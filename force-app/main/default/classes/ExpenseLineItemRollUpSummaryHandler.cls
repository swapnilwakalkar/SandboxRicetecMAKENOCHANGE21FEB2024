public class ExpenseLineItemRollUpSummaryHandler {
    public static void updateParentTotalAmount(List<Expense_Claim_Line_Item__c> changedRecords) {
        Set<Id> parentIds = new Set<Id>();

        // Collect all unique parent record IDs from the child records
        for (Expense_Claim_Line_Item__c childRecord : changedRecords) {
            if (childRecord.Expense_Claim__c != null) {
                parentIds.add(childRecord.Expense_Claim__c);
            }
        }

        // Query Parent records along with their child records
        Map<Id, Decimal> parentTotalMap = new Map<Id, Decimal>();
        for (AggregateResult aggResult : [
            SELECT Expense_Claim__c, SUM(Amount__c) totalAmount, SUM(Amounts__c) totalFormulaAmount
            FROM Expense_Claim_Line_Item__c
            WHERE Expense_Claim__c IN :parentIds
            GROUP BY Expense_Claim__c
        ]) {
            Id parentId = (Id)aggResult.get('Expense_Claim__c');
            Decimal totalAmount = (Decimal)aggResult.get('totalAmount');
            Decimal totalFormulaAmount = (Decimal)aggResult.get('totalFormulaAmount');

            // Calculate total amount including both fields
            Decimal combinedTotal = (totalAmount != null ? totalAmount : 0) + (totalFormulaAmount != null ? totalFormulaAmount : 0);
            parentTotalMap.put(parentId, combinedTotal);
        }

        // Update Parent records with the calculated total amount
        List<Expense_Claim__c> parentsToUpdate = new List<Expense_Claim__c>();
        Set<Id> parentsWithNoChildRecords = new Set<Id>(); // To track parents with no child records

        for (Id parentId : parentIds) {
            if (parentTotalMap.containsKey(parentId)) {
                Decimal totalAmount = parentTotalMap.get(parentId);

                if (totalAmount != null) {
                    Expense_Claim__c parentRecord = new Expense_Claim__c(
                        Id = parentId,
                        Total_Amount__c = totalAmount
                    );
                    parentsToUpdate.add(parentRecord);
                } else {
                    // Optionally handle or log scenarios where the total amount is null
                    System.debug('Total amount is null for parentId: ' + parentId);
                }
            } else {
                // If parent ID not found in the aggregation results, set total amount to zero
                parentsWithNoChildRecords.add(parentId);
            }
        }

        // Set the total amount to zero for parent records with no child records
        for (Id parentId : parentsWithNoChildRecords) {
            Expense_Claim__c parentRecord = new Expense_Claim__c(
                Id = parentId,
                Total_Amount__c = 0.00  // Set the total amount to zero explicitly
            );
            parentsToUpdate.add(parentRecord);
        }

        // Perform DML to update Parent records
        if (!parentsToUpdate.isEmpty()) {
            update parentsToUpdate;
        }
    }
}