public with sharing class RecordUpdateController {
    @AuraEnabled
    public static void updateLogInTime(Id millPlannerId, DateTime LogInTime) {
        // Retrieve the Mill_Planner__c record by its Id.
        Mill_Planner__c millPlanner = [SELECT Id, Mill_Start_Date_Time__c FROM Mill_Planner__c WHERE Id = :millPlannerId];

        // Update the Mill_Start_Date_Time__c field with the new date time value.
        millPlanner.Mill_Start_Date_Time__c = LogInTime;

        // Update the record in the database.
        update millPlanner;
    }

    @AuraEnabled
    public static void updateLogOutTime(Id millPlannerId,  DateTime LogOutTime) {
        // Retrieve the Mill_Planner__c record by its Id.
        Mill_Planner__c millPlanner = [SELECT Id,Mill_End_Date_Time__c FROM Mill_Planner__c WHERE Id = :millPlannerId];

        // Update the Mill_Start_Date_Time__c field with the new date time value.
        millPlanner.Mill_End_Date_Time__c = LogOutTime;

        // Update the record in the database.
        update millPlanner;
    }
}