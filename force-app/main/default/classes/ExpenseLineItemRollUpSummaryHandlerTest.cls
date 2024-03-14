@isTest
public class ExpenseLineItemRollUpSummaryHandlerTest {
    @isTest
    static void testTriggerOperations() {
        // Create test data - parent record and child records
        Expense_Claim__c parentRecord = new Expense_Claim__c();
        insert parentRecord;
        
        Expense_Claim__c parentRecordWithoutChild = new Expense_Claim__c();
        insert parentRecordWithoutChild;
		
         Expense_Claim_Line_Item__c Child = new Expense_Claim_Line_Item__c(
            Expense_Claim__c = parentRecordWithoutChild.Id,
            Amount__c = 0
        );
	      insert Child;
        
        Expense_Claim_Line_Item__c childRecord1 = new Expense_Claim_Line_Item__c(
            Expense_Claim__c = parentRecord.Id,
            Amount__c = 100
        );
        Expense_Claim_Line_Item__c childRecord2 = new Expense_Claim_Line_Item__c(
            Expense_Claim__c = parentRecord.Id,
            Amount__c = 150
        );

        List<Expense_Claim_Line_Item__c> childRecords = new List<Expense_Claim_Line_Item__c>{childRecord1, childRecord2};
        insert childRecords;

        // Update child records
        childRecord1.Amount__c = 200;
        update childRecord1;

        // Delete one child record
        delete childRecord2;

        // Undelete the deleted child record
        undelete childRecord2;

        // Call the handler method directly to avoid recursion issues
        Test.startTest();
        ExpenseLineItemRollUpSummaryHandler.updateParentTotalAmount(new List<Expense_Claim_Line_Item__c>{childRecord1, childRecord2});
        Test.stopTest();

        // Retrieve the updated parent record
        parentRecord = [SELECT Id, Total_Amount__c FROM Expense_Claim__c WHERE Id = :parentRecord.Id LIMIT 1];
        parentRecordWithoutChild = [SELECT Id, Total_Amount__c FROM Expense_Claim__c WHERE Id = :parentRecordWithoutChild.Id LIMIT 1];

        // Assert the total amount on the parent record
        System.assertEquals(350.00, parentRecord.Total_Amount__c, 'Total amount on the parent record is incorrect');
        System.assertEquals(0, parentRecordWithoutChild.Total_Amount__c, 'Total amount on the parent record without child is incorrect');
    }
}