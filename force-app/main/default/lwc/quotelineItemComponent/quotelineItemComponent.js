import { LightningElement, wire, track, api } from 'lwc';
import retrieveAllProducts from '@salesforce/apex/ProductsRetrivingForQuoteClass.retrieveProducts';
import updateQuoteProducts from '@salesforce/apex/ProductsRetrivingForQuoteClass.UpdateQuoteProducts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

const columns = [
    { type: 'checkbox', label: 'Select', initialWidth: 50, typeAttributes: { rowIndex: 'index'} },
    { label: 'Category', fieldName: 'Category__c'},
    { label: 'Sub Category', fieldName: 'Sub_Category__c' },
    { label: 'Product / Machine Code', fieldName: 'Name' },
    { label: 'Product Name', fieldName: 'Product_Name__c' },
    { label: 'Power in HP', fieldName: 'Power_in_HP__c'},
    { label: 'Quantity', fieldName: 'Quantity_In_no_s__c', editable: true },
    { label: 'Unit Price', fieldName: 'Unit_Price__c'}
];

export default class QuotelineItemComponent extends NavigationMixin(LightningElement) {

    @api recordId; // Add this to receive the Opportunity Id
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
    @track Id;
     QuatationId;
     saveDraftValues = [];//

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        this.selectedRowsAcrossSearches = [...this.selectedRowsAcrossSearches, ...event.detail.selectedRows];
    }

    connectedCallback() {
        this.getretrieveAllProducts();
    }

    getretrieveAllProducts() {
        retrieveAllProducts({}).then(data => {
            console.log(data);
            console.log('Component recordId:', this.recordId);
            this.data = data;
            this.initialRecords = data;
            this.QuatationId = data.Quotes__c;
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
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
 
        // Updateing the records using the UiRecordAPi
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
            this.getretrieveAllProducts();
            this.saveDraftValues = [];
            return this.refresh();
            
        }).catch(error => {
            this.ShowToast('Error', 'An Error Occured!!', 'error', 'dismissable');
        }).finally(() => {
            this.saveDraftValues = [];
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
 
    // This function is used to refresh the table once data updated
    async refresh() {
        await refreshApex(this.data);
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();

        if (searchKey) {
            this.data = this.initialRecords;

            if (this.data) {
                let searchRecords = [];

                for (let record of this.data) {
                    let valuesArray = Object.values(record);

                    for (let val of valuesArray) {
                        console.log('val is ' + val);
                        let strVal = String(val);

                        if (strVal) {
                            if (strVal.toLowerCase().includes(searchKey)) {
                                searchRecords.push(record);
                                break;
                            }
                        }
                    }
                }

                console.log('Matched products are ' + JSON.stringify(searchRecords));
                this.data = searchRecords;
            }
        } else {
            this.data = this.initialRecords;
        }
    }
    // New function to control Save button visibility
    get showSaveButton() {
        return this.selectedRowsAcrossSearches.length > 0;
    }

    // Method to handle checkbox selection and save selected Products
    handleSave() {
        const selectedProductIds = this.selectedRowsAcrossSearches.map(row => row.Id);

        console.log('Selected product IDs:', selectedProductIds);

        // Prepare the records for update
        const productsToUpdate = selectedProductIds.map(productId => {
            return { Id: productId, Quoteid: this.recordId };
         });

        console.log('productsall', productsToUpdate);

        updateQuoteProducts({ selectedProductIds: selectedProductIds, QuoteId: this.recordId })
            .then(() => {
                // Successful save logic here
                this.selectedRows = [];
                this.selectedRowsAcrossSearches = [];
                console.log('Products updated successfully.');
                this.getretrieveAllProducts();
                 const event = new ShowToastEvent({
                title: 'Success',
                message: 'Quote related Products Added successfully.',
                variant: 'success',
            });
            this.dispatchEvent(event);

            // Navigate to the current opportunity record page
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Quotes__c',
                    actionName: 'view',
                },
            });
        })
        .catch(error => {
            // Error handling logic here
            console.error(error);

            // Show an error toast message
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'An error occurred while updating products.',
                variant: 'error',
            });
            this.dispatchEvent(event);
        });
}

closeAction() {
    // Navigate to the current opportunity record page
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.recordId,
            objectApiName: 'Quotes__c',
            actionName: 'view',
        },
    });
}
}