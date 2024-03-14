import { LightningElement, wire, track,api } from 'lwc';
import getAccounts from '@salesforce/apex/lwcEditSaveRowCtrl.getAccounts';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    {
        label: 'Product Code',
        fieldName: 'Product_Code__c',
        type: 'text',
        editable: false,
    }, {
        label: 'M/C Name',
        fieldName: 'MC_Name__c',
        type: 'text',
        editable: false,
    },
    {
        label: 'Spare Description',
        fieldName: 'Product_Name__c',
        type: 'text',
        editable: false,
    },
    {
        label: 'Size',
        fieldName: 'Size__c',
        type: 'text',
        editable: false,
    },
    {
        label: 'Quantity',
        fieldName: 'Quantity__c',
        type: 'number',
        editable: true,
        required: true,
    },

    {
        label: 'RS/EA',
        fieldName: 'RS_EA__c',
        type: 'currency',
        editable: true,
    },
    {
        label: 'Discount %',
        fieldName: 'Discount__c',
        type: 'number',
        editable: true,
        required: true,
    },


    {
        label: 'Discount in Amount',
        fieldName: 'Discount_Amount__c',
        type: 'number',
        editable: false,
        required: true,
    },

    {
        label: 'Total Amount(Discounted)',
        fieldName: 'TPrice__c',
        type: 'currency',
        editable: false,
    },


];
export default class Trail003Showingcomponents extends LightningElement {

    @api recordId;
    columns = columns;
    @track accObj;
    fldsItemValues = [];

    @wire(getAccounts,{recId:'$recordId'})
    cons(result) {
        this.accObj = result;
        if (result.error) {
            this.accObj = undefined;
        }
    }

    saveHandleAction(event) {
        this.fldsItemValues = event.detail.draftValues;
        const inputsItems = this.fldsItemValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });


        const promises = inputsItems.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.fldsItemValues = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.fldsItemValues = [];
        });
    }

    async refresh() {
        await refreshApex(this.accObj);
    }
}