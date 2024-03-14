import { LightningElement, track, api } from 'lwc';
import retrieveAllProducts from '@salesforce/apex/Product2WorkorderRetrieving.retrieveProducts';
import updateProductOpport from '@salesforce/apex/Product2WorkorderRetrieving.updateProductOpport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

const columns = [
    { type: 'checkbox', label: '', initialWidth: 50, typeAttributes: { rowIndex: 'index', selectedRows: [] } },
    { label: 'MC Name', fieldName: 'MC_Name__c', editable: false },
    { label: 'Product Code', fieldName: 'Product_Code__c', editable: false },
    { label: 'Spare Description', fieldName: 'SpareDescriptionofMaterial__c', editable: false },
    { label: 'Size', fieldName: 'Size__c', editable: false },
    { label: 'Standard Quantity', fieldName: 'Std_Qty__c', editable:false},
    { label: 'Quantity', fieldName: 'Unit__c', editable:true,required: true },
    { label: 'Rs/EA', fieldName: 'Price__c', editable: true },
];
   
export default class SparesSearch001 extends  NavigationMixin(LightningElement) {
    @api recordId; // Add this to receive the case Id
    @track data;
    @track error;
    @track columns = columns;
    @track searchString;
    @track initialRecords;
    @track selectedRows = [];
    @track selectedRowsAcrossSearches = [];
    @track showSaveButton = false; // Add this variable to control the visibility of the Save button
    @track showError = false; // Add this variable to control the visibility of the error message
    @track isDataLoaded = false; // Add this variable to track if data is loaded
    @track saveDraftValues = [];//
    
    handleRowSelection(event) {
            this.selectedRows = event.detail.selectedRows; // Store selected rows across searches
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
            this.isDataLoaded = true; // Set isDataLoaded to true when data is loaded

        }).catch(error => {
            this.error = error;
            this.data = undefined;
            this.isDataLoaded = false; // Set isDataLoaded to false if there's an error
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
 
    ShowToast(title, message, variant, mode){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
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
                const columnsToSearch = ['MC_Name__c','Product_Code__c'];

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

        updateProductOpport({ selectedProductIds, CaseId: this.recordId })
            .then(() => {
                this.selectedRows = [];
                this.selectedRowsAcrossSearches = [];
                this.ShowToast('Success', 'Spare Items Added successfully.', 'success', 'dismissable');
                this.navigateToOpportunity();
            })
            .catch(error => {
                console.error(error);
                this.ShowToast('Error', 'An error occurred while updating Spares.', 'error', 'dismissable');
            });
    }

    navigateToOpportunity() {
        try {  // Navigate to the current opportunity record page
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Cases__c',
                    actionName: 'view',
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