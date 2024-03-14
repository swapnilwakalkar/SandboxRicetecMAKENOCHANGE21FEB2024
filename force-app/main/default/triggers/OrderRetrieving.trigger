trigger OrderRetrieving on Order__c (After insert) {
	if(trigger.isAfter && trigger.isInsert){
            OrderRetrievingHandler.queryQuoteLineItemsToOrder(trigger.new);
        }
}