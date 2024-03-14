trigger QuoteLineItemHelper on Quote_Line_Item__c (After insert, After update, After delete, After undelete) {
       if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete || trigger.isDelete)){
            SumCosts.CostMethod(trigger.new, trigger.old);
        }
}