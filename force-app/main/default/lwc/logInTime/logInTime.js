import { LightningElement, api, track } from 'lwc';
import updateLogInTime from '@salesforce/apex/RecordUpdateController.updateLogInTime';
import logOutTime from 'c/logOutTime';

export default class RecordTimeUpdater extends LightningElement {
    @api recordId; // This will store the Mill_Planner__c record's Id passed from the parent component.
    startDate = ''; // This will store the updated start date time value.
    

    handleUpdate() {
        // Get the current date and time in the user's timezone.
        const currentDateTime = new Date().toISOString();

        // Update the LWC component's state with the new start date time value.
        this.startDate = currentDateTime;
       

        // Update the Mill_Planner__c record's start date time field.
        const LogInTime = new Date(currentDateTime);
        updateLogInTime({ millPlannerId: this.recordId, LogInTime })
        console.log('Current time ',currentDateTime)
            .then(() => {
                location.reload();// Optional: You can perform additional actions after the update is successful.
            })
            .catch((error) => {
                // Optional: Handle any error that occurs during the update.
                console.error('Error updating start date:', error);
            });
    }
}