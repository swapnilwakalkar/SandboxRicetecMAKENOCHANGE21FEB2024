@isTest
public class TestLwcButtonQuotation {
    @isTest
    public static void testLwcButtonQuotation() {
        // Create a Quotes__c record for testing
        Quotes__c testQuote = new Quotes__c(
            Name = 'Test Quote'
            // Set other required fields here
        );
        insert testQuote;

        // Set the PageReference parameters
        PageReference pageRef = Page.QuotationPDF;
        pageRef.getParameters().put('id', testQuote.Id);

        Test.startTest();
        Test.setCurrentPage(pageRef);

        // Create an instance of the LwcButtonQuotation class
        LwcButtonQuotation controller = new LwcButtonQuotation();

        // Call the constructor
        controller = new LwcButtonQuotation();

        // Verify that the currentRecordId is set correctly
        System.assertEquals(testQuote.Id, controller.currentRecordId);

        // Call the sendPdf method
        String result = LwcButtonQuotation.sendPdf(testQuote.Id);

        // Add assertions based on your requirements
        System.assertNotEquals(null, result);

        // Retrieve and verify the ContentVersion
        List<ContentVersion> contentVersions = [SELECT Id FROM ContentVersion WHERE FirstPublishLocationId = :testQuote.Id];
        System.assertEquals(1, contentVersions.size());

        // Delete the ContentVersion records one by one
       // for (ContentVersion cv : contentVersions) {
         //   delete cv;
       // }

        // Clean up test data
        delete testQuote;

        Test.stopTest();
    }
}