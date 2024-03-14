public class QuoteHandlerclass {/*
    public static void UpdateQuoteLineItem(List<Quotes__c> qList){
        Set<Id> Ids = new set<Id>();
        for(Quotes__c qa:qList){
            Ids.add(qa.Opportunity_Name__c);
        }
        List<OpportunityLineItem__c> plist = [SELECT Id, Name, Quote_Name__c,Opportunities__c FROM OpportunityLineItem__c WHERE Opportunities__c=:Ids];
        
        List<OpportunityLineItem__c> updatedOpportunityLineItems = new List<OpportunityLineItem__c>();
        
        for (Quotes__c qa : qList) {
            
            for(OpportunityLineItem__c os:plist){
                if(os.Opportunities__c == qa.Opportunity_Name__c){
                   os.Quote_Name__c = qa.Id;
                }
                updatedOpportunityLineItems.add(os);
        }
            
        }
        if (!updatedOpportunityLineItems.isEmpty()) {
            update updatedOpportunityLineItems;
        }
        }*/
    }