public with sharing class UpdateRecordWithCurrentDateTime {
    @InvocableMethod(label='Update Record with Current Date and Time')
    public static List<Id> updateRecordWithDateTime(List<Id> recordIds) {
        // Get the current date and time
        Datetime currentDate = Datetime.now();

        List<Mill_Planner__c> recordsToUpdate = new List<Mill_Planner__c>();

        // Prepare the fields you want to update on the record
        for (Id recordId : recordIds) {
            Mill_Planner__c recordToUpdate = new Mill_Planner__c(Id = recordId);
            recordToUpdate.Mill_Start_Date_Time__c = currentDate;
            recordsToUpdate.add(recordToUpdate);
        }

        // Update the records
        update recordsToUpdate;

        // Return the updated record IDs
        return recordIds;
    }
}