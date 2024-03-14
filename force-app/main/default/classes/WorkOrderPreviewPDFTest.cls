@isTest
public class WorkOrderPreviewPDFTest {
    @isTest
    static void testPdfAction2() {
        
         Cases__c ck =new Cases__c();
        insert ck;
        // Create a test Work_Order_for_Spares__c record
        Work_Order_for_Spares__c testRecord = new Work_Order_for_Spares__c(
            // Set required fields
            Case__c = ck.id
        );
        insert testRecord;
        
         // Create related WorkOrderSparesLine__c records
        List<WorkOrderSparesLine__c> testWorkOrderSparesLines = new List<WorkOrderSparesLine__c>();
        for (Integer i = 0; i < 5; i++) {
            WorkOrderSparesLine__c testWorkOrderSparesLine = new WorkOrderSparesLine__c(
                Work_Order_for_Spares__c = testRecord.Id,
                   Cases__c = ck.id
                // Add other required fields
            );
            testWorkOrderSparesLines.add(testWorkOrderSparesLine);
        }
        insert testWorkOrderSparesLines;

        // Set the current page parameter
        PageReference pageRef = Page.Workorder;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', testRecord.Id);

        // Create an instance of the WorkOrderPreviewPDF class
        WorkOrderPreviewPDF workOrderPreviewPDF = new WorkOrderPreviewPDF(new ApexPages.StandardController(testRecord));

        // Test the pdfAction2 method
        PageReference pdfPage = workOrderPreviewPDF.pdfAction2();
        System.assertNotEquals(null, pdfPage, 'pdfAction2 should return a PageReference');
        // Add more assertions for attachment creation and redirection
    }
}