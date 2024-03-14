@isTest
public class OrderRetrievingHandlerTest {
    
    @isTest
    static void testqueryQuoteLineItemsToOrder(){
        
        Opportunities__c testOpportunity = new Opportunities__c(
            Name = 'Test Opportunity'
            
        );
        insert testOpportunity;
        
        Products__c Prod = new Products__c();
        prod.Name = 'TestProduct';
        Prod.Opportunities__c = testOpportunity.id;
        insert Prod;
        
        // Create a test OpportunityLineItem__c record related to the Opportunity
        OpportunityLineItem__c oli = new OpportunityLineItem__c(
            Opportunities__c = testOpportunity.Id,
            Product_Name__c = Prod.id,
            Quantity__c = 5,
            Unit_Price__c = 100.0
        );
        insert oli;
        
        // Create a test Quotes__c record related to the Opportunity
        Quotes__c testQuote = new Quotes__c(
            name = 'Test Quotation',
            Opportunity_Name__c = testOpportunity.Id
            
        );
        insert testQuote;
        
        //Insert Order
        Order__c testOrder = new Order__c ();
        testOrder.Quotes__c = testQuote.id;
        insert testOrder;
        
        Order_Line_Item__c orderLineItem = new Order_Line_Item__c();
        orderLineItem.Orders__c = testOrder.id;
        insert orderLineItem;
        
        Test.startTest();
        List<Order__c> olA = new List<Order__c>{testOrder};
            OrderRetrievingHandler.queryQuoteLineItemsToOrder(olA);
        Test.stopTest();
        
        // Retrieve the updated Order Line Item
        List<Order_Line_Item__c> updatedOrderLineItems = [SELECT Id, Orders__c FROM Order_Line_Item__c WHERE Orders__c = :testOrder.Id];
        
        // Assert that there is one and only one updated Order Line Item
        System.assertEquals(3, updatedOrderLineItems.size(), 'There should be one updated Order Line Item');
        
        // Assert that the Order Id in the updated Order Line Item is the same as the test Order Id
        System.assertEquals(testOrder.Id, updatedOrderLineItems[0].Orders__c, 'Order Id should match in the updated Order Line Item');
        
    }
}