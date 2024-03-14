@isTest
public class TestQuoteRetrivingClass {
    @isTest
    static void testConvertOpportunityToQuote() {
        // Create a test Opportunity record
        Opportunities__c testOpportunity = new Opportunities__c(
            Name = 'Test Opportunity'
            
        );
        insert testOpportunity;

        // Create a test OpportunityLineItem__c record related to the Opportunity
        OpportunityLineItem__c oli = new OpportunityLineItem__c(
            Opportunities__c = testOpportunity.Id,
            Product_Name__c = 'Test Product',
            Quantity__c = 5,
            Unit_Price__c = 100.0
        );
        insert oli;

        // Create a test Quotes__c record related to the Opportunity
        Quotes__c testQuote = new Quotes__c(
            Opportunity_Name__c = testOpportunity.Id
        );
        insert testQuote;

        // Call the QuoteRetrivingClass to process the Quotes__c record
        Test.startTest();
        List<Quotes__c> quoteList = new List<Quotes__c>{testQuote};
        QuoteRetrivingClass.convertOpportunityToQuote(quoteList);
        Test.stopTest();

        // Query for the created Quote_Line_Item__c records
        List<Quote_Line_Item__c> quoteLineItems = [SELECT Id, Quotes__c, Product_Name__c, Quantity__c, Unit_Price__c, Discount__c, Product__c, PowerHP__c FROM Quote_Line_Item__c];

        // Assert that the Quote_Line_Item__c record was created with the correct values
       // System.assertEquals(1, quoteLineItems.size(), 'One Quote_Line_Item__c record should be created');
        Quote_Line_Item__c createdQuoteLineItem = quoteLineItems[0];
        System.assertEquals(testQuote.Id, createdQuoteLineItem.Quotes__c, 'Quotes__c field should match');
        System.assertEquals(oli.Product_Name__c, createdQuoteLineItem.Product_Name__c, 'Product_Name__c should match');
        System.assertEquals(oli.Quantity__c, createdQuoteLineItem.Quantity__c, 'Quantity__c should match');
        System.assertEquals(oli.Unit_Price__c, createdQuoteLineItem.Unit_Price__c, 'Unit_Price__c should match');

        // Additional assertions can be added for the Quoted Price, Discounted Price, and Total Price fields based on your expected calculations.
        // For example, if you know the expected values based on your test data, you can assert them here.

        // Example:
        // System.assertEquals(expectedQuotedPrice, createdQuoteLineItem.Quoted_Price__c, 'Quoted_Price__c should be as expected');
        // System.assertEquals(expectedDiscountedPrice, createdQuoteLineItem.Discounted_Price__c, 'Discounted_Price__c should be as expected');
        // System.assertEquals(expectedTotalPrice, createdQuoteLineItem.Total_Price__c, 'Total_Price__c should be as expected');
    }
}