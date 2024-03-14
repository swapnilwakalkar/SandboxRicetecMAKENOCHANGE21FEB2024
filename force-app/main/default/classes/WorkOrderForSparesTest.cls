@isTest
public class WorkOrderForSparesTest {
    static testMethod void testWorkOrderForSpares() {
          Cases__c ck =new Cases__c();
        insert ck;
        // Create a test Work_Order_for_Spares__c record
        Work_Order_for_Spares__c testWorkOrder = new Work_Order_for_Spares__c(
           
            Case__c = ck.id
            // Add other required fields
        );
        insert testWorkOrder;

        // Create related WorkOrderSparesLine__c records
        List<WorkOrderSparesLine__c> testWorkOrderSparesLines = new List<WorkOrderSparesLine__c>();
        for (Integer i = 0; i < 5; i++) {
            WorkOrderSparesLine__c testWorkOrderSparesLine = new WorkOrderSparesLine__c(
                Work_Order_for_Spares__c = testWorkOrder.Id,
                 Cases__c = ck.Id
                // Add other required fields
            );
            testWorkOrderSparesLines.add(testWorkOrderSparesLine);
        }
        insert testWorkOrderSparesLines;

        // Create a StandardController and pass the Work_Order_for_Spares__c Id
        ApexPages.StandardController stdController = new ApexPages.StandardController(testWorkOrder);

        // Create an instance of the WorkOrderForSpares class
        WorkOrderForSpares workOrderForSpares = new WorkOrderForSpares(stdController);

        // Test the constructor by asserting values
        System.assertEquals(1, workOrderForSpares.controller.getPageSize(), 'Controller page size should be set to 1');
        System.assertEquals(5, workOrderForSpares.op.size(), 'op list should have 5 records');
        

        // Test the pdf method (if needed)
        PageReference pdfPage = workOrderForSpares.pdf();
        System.assertNotEquals(null, pdfPage, 'pdf method should return a PageReference');
    }
}