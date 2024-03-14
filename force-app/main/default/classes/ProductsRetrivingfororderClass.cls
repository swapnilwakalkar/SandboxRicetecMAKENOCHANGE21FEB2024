public class ProductsRetrivingfororderClass {
      @AuraEnabled()
    public static List<Products__c> retrieveProducts(){
        return [ SELECT Name,Product_Name__c, Opportunities__c, Power_in_HP__c, Quantity_In_no_s__c, 
                Discount__c, Discounted_Price__c, Unit_Price__c, Total_Price__c
                FROM Products__c ];
    }
    
    public class ProductUpdateWrapper {
        @AuraEnabled public String Id;
        @AuraEnabled public String Orderid;
    }
    
    @AuraEnabled
    public static void UpdateOrderProducts(List<String> selectedProductIds, Id OrderId) {
        try {
            List<Order_Line_Item__c> OrderLineItemsToInsert = new List<Order_Line_Item__c>();
            
            for (Products__c product : [SELECT Name,Product_Name__c, Opportunities__c,Quantity_In_no_s__c, 
                                        Discount__c, Discounted_Price__c, Unit_Price__c, Total_Price__c
                                        FROM Products__c WHERE Id IN :selectedProductIds])
            {
                                            Order_Line_Item__c lineItem = new Order_Line_Item__c(
                                                Orders__c = OrderId,
                                                Productes__c = product.Id,
                                                Product_Description__c = product.Product_Name__c,
                                                Discount__c = product.Discount__c, 
                                                Unit_Rate__c = product.Unit_Price__c,
                                                Quantity__c = product.Quantity_In_no_s__c);
                                                OrderLineItemsToInsert.add(lineItem);
                                        }
            
              if (!OrderLineItemsToInsert.isEmpty()) {
                insert OrderLineItemsToInsert;
                system.debug('lineitems'+OrderLineItemsToInsert);
            }
        } catch (Exception e) {
            // Handle the exception appropriately
            System.debug('Exception: ' + e.getMessage());
        }
    }
    
}