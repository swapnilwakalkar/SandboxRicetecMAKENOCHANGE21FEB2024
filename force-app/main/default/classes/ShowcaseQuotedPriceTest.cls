@isTest
public class ShowcaseQuotedPriceTest {

    static testMethod void testShowcaseQuotedPrice() {
        // Create test data
        Quotes__c testQuote = new Quotes__c(
            Name = 'Test Quote'
            // Populate other required fields here
        );
        insert testQuote;

        Quote_Line_Item__c testQuoteLineItem = new Quote_Line_Item__c(
            
            Quotes__c = testQuote.Id
            // Populate other required fields here
        );
        insert testQuoteLineItem;

        ApexPages.StandardController stdController = new ApexPages.StandardController(testQuote);

        ShowcaseQuotedPrice controller = new ShowcaseQuotedPrice(stdController);

        // Call the pdf() method
        PageReference pdfPageRef = controller.pdf();

        // Verify that the PageReference is not null
        System.assertNotEquals(null, pdfPageRef);

        // Perform additional assertions as needed to cover more code paths

        // Example: Simulate a page parameter
        Test.setCurrentPageReference(Page.ShowcaseQuotedPage);
        ApexPages.currentPage().getParameters().put('id', testQuote.Id);

        // Call pdf() again to cover the code for generating PDF content
        PageReference pdfPageRef2 = controller.pdf();

        // Verify that the PageReference is not null
        System.assertNotEquals(null, pdfPageRef2);

        // Add assertions to verify other behaviors as needed
    }
}