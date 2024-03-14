import { LightningElement, wire, track, api } from 'lwc';
import retrieveAllProducts from '@salesforce/apex/ProductsRetrivingClass.retrieveProducts';
import updateProductOpport from '@salesforce/apex/ProductsRetrivingClass.updateProductOpport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

const columns = [
    { type: 'checkbox', initialWidth: 20, typeAttributes: { rowIndex: 'index' } },
    { label: 'Category', fieldName: 'Category__c' },
    { label: 'Sub Category', fieldName: 'Sub_Category__c' },
    { label: 'Product / Machine Code', fieldName: 'Name' },
    { label: 'Product Name', fieldName: 'Product_Name__c' },
    { label: 'Power in HP', fieldName: 'Power_in_HP__c' },
    { label: 'Quantity', fieldName: 'Quantity_In_no_s__c', editable: true },
    { label: 'Unit Price', fieldName: 'Unit_Price__c' }
];

export default class ProductsSearchComponent extends NavigationMixin(LightningElement) {
    @api recordId = 'a020T000004zdajQAA';
    @track data;
    @track error;
    @track columns = columns;
    @track searchString;
    @track initialRecords;
    @track selectedRows = [];
    @track selectedRowsAcrossSearches = [];
    @track showSaveButton = false;
    @track showError = false;
    @track isDataLoaded = false;
    @track saveDraftValues = [];

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        this.selectedRowsAcrossSearches = [...this.selectedRowsAcrossSearches, ...event.detail.selectedRows];
    }

    connectedCallback() {
        this.getretrieveAllProducts();
    }

    getretrieveAllProducts() {
        retrieveAllProducts({})
            .then(data => {
                this.data = data;
                this.initialRecords = data;
                this.error = undefined;
                this.isDataLoaded = true;
            })
            .catch(error => {
                this.error = error;
                this.data = undefined;
                this.isDataLoaded = false;
            });
    }

    saveHandleAction(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => ({
            fields: Object.assign({}, draft)
        }));

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises)
            .then(() => {
                this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
                this.getretrieveAllProducts();
                this.refresh();
                this.saveDraftValues = [];
            })
            .catch(error => {
                this.ShowToast('Error', 'An Error Occurred!', 'error', 'dismissable');
            });
    }

    ShowToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    async refresh() {
        await refreshApex(this.data);
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();

        if (searchKey) {
            this.data = this.initialRecords.filter(record => {
                const columnsToSearch = ['Category__c', 'Sub_Category__c','Name'];

                return columnsToSearch.some(fieldName => {
                    const val = record[fieldName];
                    return val && String(val).toLowerCase().includes(searchKey);
                });
            });
        } else {
            this.data = this.initialRecords;
        }
    }

    get showSaveButton() {
        return this.selectedRowsAcrossSearches.length > 0;
    }

    handleSave() {
        const selectedProductIds = this.selectedRowsAcrossSearches.map(row => row.Id);

        updateProductOpport({ selectedProductIds, oppId: this.recordId })
            .then(() => {
                this.selectedRows = [];
                this.selectedRowsAcrossSearches = [];
                this.ShowToast('Success', 'Opportunity related Products Added successfully.', 'success', 'dismissable');
                this.navigateToOpportunity();
            })
            .catch(error => {
                console.error(error);
                this.ShowToast('Error', 'An error occurred while updating products.', 'error', 'dismissable');
            });
    }

    navigateToOpportunity() {
    try {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Opportunities__c',
                actionName: 'view'
            }
        });
    } catch (error) {
        console.error('Error refreshing view:', error);
        throw error;
    }
}
    closeAction() {
        this.navigateToOpportunity();
    }

    closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
        window.location.reload();
    }
}