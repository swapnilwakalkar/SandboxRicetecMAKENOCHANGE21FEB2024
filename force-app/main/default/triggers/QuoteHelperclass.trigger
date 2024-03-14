trigger QuoteHelperclass on Quotes__c (After insert) {
	if(trigger.isAfter && trigger.isInsert){
            QuoteRetrivingClass.convertOpportunityToQuote(trigger.new);
        }
}