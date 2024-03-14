trigger OrderLineHelper on Order_Line_Item__c (After insert, After update, After delete, After undelete) {
	   if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete || trigger.isDelete)){
            SumCostofOrders.CostMethod1(trigger.new);
        }
}