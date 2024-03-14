trigger ExpenseLineItemRollUpSummaryHandlerTrigger on Expense_Claim_Line_Item__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete) {
            List<Expense_Claim_Line_Item__c> changedRecords = new List<Expense_Claim_Line_Item__c>();

            if (Trigger.isDelete) {
                for (Expense_Claim_Line_Item__c deletedRecord : Trigger.old) {
                    changedRecords.add(deletedRecord);
                }
            } else {
                changedRecords.addAll(Trigger.new);
            }

            ExpenseLineItemRollUpSummaryHandler.updateParentTotalAmount(changedRecords);
        }
    }
}