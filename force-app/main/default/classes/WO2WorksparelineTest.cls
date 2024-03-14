@isTest
public class WO2WorksparelineTest {
    @isTest
    static void testConvertSpareline2WOLI() {
        // Create test data for Work_Order_for_Spares__c records
        Cases__c ck =new Cases__c();
        insert ck;
        List<Work_Order_for_Spares__c> testWorkOrders = new List<Work_Order_for_Spares__c>();
        for (Integer i = 0; i < 5; i++) {
            Work_Order_for_Spares__c workOrder = new Work_Order_for_Spares__c(
                Case__c = ck.Id
                // Add other required fields
            );
            testWorkOrders.add(workOrder);
        }
        insert testWorkOrders;

        // Create test data for SpareLineItem__c records
        List<SpareLineItem__c> testSpareLineItems = new List<SpareLineItem__c>();
        for (Integer i = 0; i < 5; i++) {
            SpareLineItem__c spareLineItem = new SpareLineItem__c(
                Cases__c = ck.Id
                // Add other required fields
            );
            testSpareLineItems.add(spareLineItem);
        }
        insert testSpareLineItems;

        // Call the convertSpareline2WOLI method
        WO2Workspareline.convertSpareline2WOLI(testWorkOrders);

        // Query for WorkOrderSparesLine__c records
        List<WorkOrderSparesLine__c> workOrderSparesLines = [SELECT Id FROM WorkOrderSparesLine__c WHERE Work_Order_for_Spares__c IN :testWorkOrders];

        // Perform assertions
        System.assertEquals(25, workOrderSparesLines.size(), 'WorkOrderSparesLine__c records should be created for each combination of Work_Order_for_Spares__c and SpareLineItem__c');
    }
}