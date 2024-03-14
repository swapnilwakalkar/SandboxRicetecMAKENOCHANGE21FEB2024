import { LightningElement,api } from 'lwc';
import sendPdf from "@salesforce/apex/LwcButtonControllercustcomplaint.sendPdf";

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CustomerComplaintpdfgeneration extends LightningElement {
    @api recordId;

   

    handleGeneratePDFAndSendEmail() {

        sendPdf({recordId: this.recordId})

        .then(res=>{

            this.ShowToast('Success', res, 'success', 'dismissable');

        })

        .catch(error=>{

            console.error('Error sending email:', error);

            this.ShowToast('Error', 'Error in send email!!', 'error', 'dismissable');

        })

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

}