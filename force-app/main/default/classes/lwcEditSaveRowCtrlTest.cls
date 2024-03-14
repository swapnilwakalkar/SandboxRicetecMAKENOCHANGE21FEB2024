@isTest
public class lwcEditSaveRowCtrlTest {
    @isTest
    static void testGetAccounts() {
         Cases__c ck =new Cases__c();
        insert ck;
        Work_Order_for_Spares__c wo=new Work_Order_for_Spares__c();
        insert WO;
        // Create a test WorkOrderSparesLine__c record
        WorkOrderSparesLine__c testRecord = new WorkOrderSparesLine__c(
         
            Work_Order_for_Spares__c=WO.id,
           Cases__c = ck.id
            // Add other required fields
        );
        insert testRecord;

        // Set the WorkOrderSparesLine__c record's Id as the input parameter
        Id recId = testRecord.Work_Order_for_Spares__c;

        // Call the getAccounts method
        List<WorkOrderSparesLine__c> result = lwcEditSaveRowCtrl.getAccounts(recId);

        // Perform assertions to validate the results
        System.assertEquals(1, result.size(), 'The method should return a list with one record');
        WorkOrderSparesLine__c returnedRecord = result[0];
         System.assertEquals(testRecord.Work_Order_for_Spares__c, returnedRecord.Work_Order_for_Spares__c, 'Available Quantity should match');
        System.assertEquals(testRecord.Cases__c, returnedRecord.Cases__c, 'Cases should match');
        // Add more assertions for other fields as needed
    }
}