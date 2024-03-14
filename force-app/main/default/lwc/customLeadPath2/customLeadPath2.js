import { api, LightningElement, track, wire } from 'lwc';
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValuesByRecordType, getObjectInfo } from 'lightning/uiObjectInfoApi';
import customCSS from './customLeadPath2.css'; // Add this line to import the CSS file

const fields = [];
const DUMMY_RECORDTYPE_ID = '012000000000000AAA';

export default class CustomLeadPath2 extends LightningElement {
    @api recordId; /* Id the record */
    @api objectApiName; /* object api name. For example, Account, Invoice__c */
    @api fieldApiName; /* field api name. For example, Rating, Status__c */
    @api values; /* picklist values comma separated if the values are not part of picklist field */
    @api currentValue; /* current value of the field */
    @api pathType; /* type of the path. For base, path */
    @api buttonLocation; /* location of the button. For top, same row */
    @api buttonLabel = 'Mark Lead Status as Complete'; /* label of the button */
    @api showButton = false;
    @api recordTypeName; /* record type name */

    @track pathValues = [];
    isLoading = false;
    isSameRow = false;
    errorMessage;
    isError = false;
    showChildComponent = false;
    
    recordTypeId;

    connectedCallback() {
        if (this.buttonLocation === 'SameRow') {
            this.isSameRow = true;
        } else {
            this.isSameRow = false;
        }
        fields.push(this.objectApiName + '.' + this.fieldApiName);
        if (this.recordTypeName) {
            fields.push(this.objectApiName + '.RecordTypeId');
        }
        if (this.values) {
            let allValues = this.values.split(',');
            for (let i = 0; i < allValues.length; i++) {
                this.pathValues.push({
                    label : allValues[i],
                    value : allValues[i]
                });
            }
        } else {
            //this.handlePicklistValues();
        }
    }

    // Use @wire decorator to fetch the record data
    @wire(getRecord, { recordId: '$recordId', fields })
    fetchRecordData({ error, data }) {
        if (data) {
            let fieldValue = getFieldValue(data, this.objectApiName + '.' + this.fieldApiName);
            this.recordTypeId = getFieldValue(data, this.objectApiName + '.RecordTypeId');
            if (!this.currentValue) {
                this.currentValue = fieldValue;
            }
            if (this.recordTypeId) {
                //DUMMY_RECORDTYPE_ID = this.recordTypeId;
            } else {
                this.recordTypeId = DUMMY_RECORDTYPE_ID;
            }
        } else if (error) {
            this.isError = true;
            this.errorMessage = error.body.message;
        }
    }


    @wire(getPicklistValuesByRecordType, { objectApiName: '$objectApiName', recordTypeId: '$recordTypeId' })
    fetchValues({error, data}) {
        if (data && data.picklistFieldValues) {
            try {
                if (!this.values) { // check if the values are not there then add the values to the picklist
                    let allValues = data.picklistFieldValues[this.fieldApiName];
                    this.pathValues = [];
                    allValues.values.forEach(option => {
                        this.pathValues.push({
                            label: option.label,
                            value: option.value
                        });
                    });
                }
            } catch (err) {
                this.isError = true;
                this.errorMessage = err.message;
            }
        } else if (error) {
            this.isError = true;
            this.errorMessage = 'Object is not configured properly please check';
        }
    }

    handleSelectChange(event) {
        event.preventDefault();
        this.currentValue = event.target.value;
        if (!this.showButton) {
            const changeEvent = new CustomEvent('change', {
                detail: {
                    value: this.currentValue
                }
            });
            this.dispatchEvent(changeEvent);
        }
    }

    handleClick(event) {
        event.preventDefault();
        if (this.currentValue === 'Closed - Converted' && this.showButton) {
            // Show the child component (pop-up window) only when the button is clicked
            this.showChildComponent = true;
        } else {
            this.isLoading = true;

            // Update the record when the "Mark Lead Status as Complete" button is clicked
            const fields = {};
            fields['Id'] = this.recordId;
            fields[this.fieldApiName] = this.currentValue;
            const recordInput = { fields };

            updateRecord(recordInput)
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record updated',
                            variant: 'success'
                        })
                    );
                })
                .catch(error => {
                    console.error('Error updating record ', error);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error updating record',
                            message: error.body.message,
                            variant: 'error'
                        })
                    );
                })
                .finally(() => {
                    this.isLoading = false;
                });
        }
    }

    closeModal() {
        this.showChildComponent = false; // Close the child component (pop-up window)
    }
}