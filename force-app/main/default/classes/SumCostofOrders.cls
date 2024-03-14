public class SumCostofOrders {
   public static void CostMethod1(List<Order_Line_Item__c> orderLineItems) {
        Set<Id> orderIds = new Set<Id>();

        // Collect unique Order__c record IDs from the provided Order_Line_Item__c records
        for (Order_Line_Item__c oli : orderLineItems) {
            orderIds.add(oli.Orders__c);
        }

        // Query related Order__c records with their Order_Line_Item__c child records
        List<Order__c> ordersToUpdate = [SELECT Id, Name, Basic_Order_Value__c,
                                          (SELECT Value__c, Final_Price_After_Discount__c FROM Order_Line_Item__r)
                                          FROM Order__c WHERE Id IN :orderIds];

        // Update each Order__c record with the calculated values
        for (Order__c order : ordersToUpdate) {
            Double sumOfQuotedPrice = 0;
            Double sumOfFinalPrice = 0;

            for (Order_Line_Item__c oli : order.Order_Line_Item__r) {
                if (oli.Value__c != null) {
                    sumOfQuotedPrice += oli.Value__c;
                }
                if (oli.Final_Price_After_Discount__c != null) {
                    sumOfFinalPrice += oli.Final_Price_After_Discount__c;
                }
            }

            order.Basic_Order_Value__c = sumOfQuotedPrice;
            order.Final_Price_After_Discount__c = sumOfFinalPrice;
        }

        // Update the Order__c records
        update ordersToUpdate;
    }
}