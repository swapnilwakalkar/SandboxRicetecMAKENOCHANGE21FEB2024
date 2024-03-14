@isTest
public class WO2WOLI1Test {
    @isTest
    static void testTriggerOnInsert() {
         Cases__c ck =new Cases__c();
        insert ck;
        // Create a test Work_Order_for_Spares__c record
        Work_Order_for_Spares__c testRecord = new Work_Order_for_Spares__c(
              Case__c = ck.id
            // Set required fields
        );
        insert testRecord;

        // Query the related WorkOrderSparesLine__c records
        List<WorkOrderSparesLine__c> relatedRecords = [SELECT Id FROM WorkOrderSparesLine__c WHERE Work_Order_for_Spares__c = :testRecord.Id];

        // Perform assertions to validate that the trigger logic has executed as expected
        System.assertNotEquals(0, relatedRecords.size(), 'WorkOrderSparesLine__c records should be created');
        // Add more assertions as needed to validate the created records
    }

    @isTest
    static void testTriggerOnUpdate() {
        // Create a test Work_Order_for_Spares__c record
        Work_Order_for_Spares__c testRecord = new Work_Order_for_Spares__c(
            // Set required fields
        );
        insert testRecord;

        // Update the test record
     
        update testRecord;

        // Query the related WorkOrderSparesLine__c records
        List<WorkOrderSparesLine__c> relatedRecords = [SELECT Id FROM WorkOrderSparesLine__c WHERE Work_Order_for_Spares__c = :testRecord.Id];

        // Perform assertions to validate that the trigger logic has executed as expected
        // For an update trigger, ensure that the related records are modified as expected
        System.assertNotEquals(0, relatedRecords.size(), 'WorkOrderSparesLine__c records should be created');
        // Add more assertions as needed to validate the created or updated records
    }
}