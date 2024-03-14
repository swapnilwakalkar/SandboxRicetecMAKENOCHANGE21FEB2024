@isTest
public class LwcButtonQuotedPriceTest {

    @isTest
    static void testLwcButtonQuotedPrice() {
        // Create a Quotes__c record for testing
        Quotes__c quote = new Quotes__c(
            
            // Add other required fields here
        );
        insert quote;

        // Set the currentRecordId to the Id of the created Quotes__c record
        PageReference currentPage = Page.ShowcaseQuotedPage; // Replace with your VF page name
        currentPage.getParameters().put('id', quote.Id);

        Test.setCurrentPage(currentPage);

        // Call the constructor to initialize the controller
        LwcButtonQuotedPrice controller = new LwcButtonQuotedPrice();

        // Verify that the controller has been initialized and the qu property is not null
        System.assertNotEquals(null, controller);
        System.assertNotEquals(null, controller.qu);

        // Test the sendPdf method
        Test.startTest();
        String result = LwcButtonQuotedPrice.sendPdf(quote.Id);
        Test.stopTest();

        // Add assertions to verify the behavior of the sendPdf method
        System.assertNotEquals(null, result);
        
        // Add more test cases as needed to achieve complete coverage
    }
}