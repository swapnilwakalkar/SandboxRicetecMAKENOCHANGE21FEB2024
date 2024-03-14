public class OrderRetrievingHandler {
    public static void queryQuoteLineItemsToOrder(List<Order__c> orderList) {
        Set<Id> quoteIds = new Set<Id>();
        for (Order__c order : orderList){
            quoteIds.add(order.Quotes__c);
        }
        List<Quote_Line_Item__c> quoteLineItems = [SELECT Id, Discount__c, FinalF__c, Name, Opportunities__c,Product_Name__c,
                                                   Product__c, ProductName__c, Quantity__c, Quotes__c, Unit_Price__c,QuotedQ__c
                                                   FROM Quote_Line_Item__c
                                                   WHERE Quotes__c IN :quoteIds];
        System.debug('Retrieving data: ' + quoteLineItems);
        
        List<Order_Line_Item__c> orderLineItemsToInsert = new List<Order_Line_Item__c>();
        
        for (Order__c order : orderList) {
            
            for (Quote_Line_Item__c quoteLineItem : quoteLineItems) {
                
                if (quoteLineItem.Quotes__c == order.Quotes__c) {
                    
                    Order_Line_Item__c orderLineItem = new Order_Line_Item__c(
                        Orders__c = order.Id,
                        Machine_Name__c = quoteLineItem.ProductName__c,
                        Product_Description__c = quoteLineItem.Product_Name__c,
                        Quantity__c = quoteLineItem.Quantity__c,
                        Unit_Rate__c = quoteLineItem.Unit_Price__c,
                        Discount__c = quoteLineItem.Discount__c,
                        Productes__c = quoteLineItem.Product__c,
                        Value__c = quoteLineItem.QuotedQ__c
                    );
                    orderLineItemsToInsert.add(orderLineItem);
                    System.debug('Order Line Item added: ' + orderLineItem);
                }
            }
        }
        if (!orderLineItemsToInsert.isEmpty()) {
            insert orderLineItemsToInsert;
            System.debug('Order Line Items inserted successfully');
        }
    }
}