@isTest
public class WorkOrderForSparesQuoteTest {
    @isTest
    static void testWorkOrderForSparesQuote() {
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
                   Cases__c = ck.id
                // Add other required fields
            );
            testWorkOrderSparesLines.add(testWorkOrderSparesLine);
        }
        insert testWorkOrderSparesLines;

        // Create a StandardController and pass the Work_Order_for_Spares__c Id
        ApexPages.StandardController stdController = new ApexPages.StandardController(testWorkOrder);

        // Set the current page parameter
        PageReference pageRef = Page.WorkorderQuote;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', testWorkOrder.Id);

        // Create an instance of the WorkOrderForSparesQuote class
        WorkOrderForSparesQuote workOrderForSparesQuote = new WorkOrderForSparesQuote(stdController);

        // Test the constructor by asserting values
        System.assertEquals(testWorkOrder.Id, workOrderForSparesQuote.MstrId, 'MstrId should be set');
        System.assertEquals(5, workOrderForSparesQuote.op.size(), 'op list should have 5 records');
        // Add more assertions as needed

        // Test the pdfAction method
        PageReference pdfPage = workOrderForSparesQuote.pdfAction();
        System.assertNotEquals(null, pdfPage, 'pdfAction should return a PageReference');
        // Add more assertions for attachment creation and redirection
    }
}