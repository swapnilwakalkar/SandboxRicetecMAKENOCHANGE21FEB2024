@isTest
public class TestSumCosts {
    @isTest
    static void testCostMethod() {
        // Create a test Quote record
        Quotes__c testQuote = new Quotes__c(Name = 'Test Quote');
        insert testQuote;

        // Create test Quote_Line_Item__c records
        Quote_Line_Item__c[] quoteLineItems = new Quote_Line_Item__c[]{
            new Quote_Line_Item__c(Quotes__c = testQuote.Id),
            new Quote_Line_Item__c(Quotes__c = testQuote.Id),
            new Quote_Line_Item__c(Quotes__c = testQuote.Id)
        };
        insert quoteLineItems;

        // Call the CostMethod to calculate sums
        Test.startTest();
        SumCosts.CostMethod(new List<Quote_Line_Item__c>(), new List<Quote_Line_Item__c>());
        Test.stopTest();

        // Verify the results
        Quotes__c updatedQuote = [SELECT Id, QUOTED_SUB_COST__c, FINAL_SUB_COST__c FROM Quotes__c WHERE Id = :testQuote.Id];
        
        // Define the expected values based on your formula logic and test data
        Decimal expectedQuotedSubCost = 100;
        Decimal expectedFinalSubCost = 99;
        
        // Assertions based on the expected values
        System.assertEquals(expectedQuotedSubCost, updatedQuote.QUOTED_SUB_COST__c, 'QUOTED_SUB_COST__c should be as expected');
        System.assertEquals(expectedFinalSubCost, updatedQuote.FINAL_SUB_COST__c, 'FINAL_SUB_COST__c should be as expected');
    }
}