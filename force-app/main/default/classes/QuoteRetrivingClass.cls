public class QuoteRetrivingClass {
    
    public static void convertOpportunityToQuote(List<Quotes__c> qList) {
        Set<Id> Ids = new set<Id>();
        for(Quotes__c qa:qList){
            Ids.add(qa.Opportunity_Name__c);
        }
        
        
        List<OpportunityLineItem__c> opportunityLineItems = [SELECT Id, Product_Name__c, Quantity__c, Unit_Price__c, Quoted_Price__c, Discount__c,
                                                             Discounted_Price__c, Total_Price__c, Type__c, Category__c, Sub_Category__c,Products__c, 
                                                             Power_in_HP__c,Opportunities__c
                                                             FROM OpportunityLineItem__c
                                                             WHERE Opportunities__c =:Ids];
        system.debug('retriving data'+opportunityLineItems);
        
        List<Quote_Line_Item__c> quoteLineItemsToInsert = new List<Quote_Line_Item__c>();
        for(Quotes__c q:qList){
            
            for (OpportunityLineItem__c oli : opportunityLineItems) {
                if(oli.Opportunities__c == q.Opportunity_Name__c){
                    Quote_Line_Item__c qli = new Quote_Line_Item__c(
                        Quotes__c=q.Id,
                        Product_Name__c = oli.Product_Name__c,
                        Quantity__c = oli.Quantity__c,
                        Unit_Price__c = oli.Unit_Price__c,
                        Discount__c = oli.Discount__c,
                        Product__c = oli.Products__c,
                        Category1__c = oli.Category__c,
                        Type__c = oli.Type__c,
                        SubCategory__c = oli.Sub_Category__c,
                        PowerHP__c = oli.Power_in_HP__c);
                    quoteLineItemsToInsert.add(qli);
                    system.debug('Quote Line Item added: ' + qli);
                }
            }
        }
        
        if (!quoteLineItemsToInsert.isEmpty()) {
            insert quoteLineItemsToInsert;
            system.debug('Quote Line Items inserted successfully');
        }
    }
}