public with sharing class ProductsRetrivingClass {
    @AuraEnabled()
    public static List<Products__c> retrieveProducts(){
        return [ SELECT Name, Category__c, Sub_Category__c, Product_Name__c, Opportunities__c, Quoted_Price__c, Power_in_HP__c, Quantity_In_no_s__c, 
                Discount__c, Discounted_Price__c, Unit_Price__c, Type__c, Total_Price__c
                FROM Products__c ];
    }
    
    public class ProductUpdateWrapper {
        @AuraEnabled public String Id;
        @AuraEnabled public String Oppid; // Keep using 'Opportunities__c' for the field name
    }
    
   
    
    @AuraEnabled
    public static void updateProductOpport(List<String> selectedProductIds, Id oppId) {
        try {
            List<OpportunityLineItem__c> opportunityLineItemsToInsert = new List<OpportunityLineItem__c>();
            
            system.debug(oppId);
            
            
            for (Products__c product : [SELECT Name, Category__c, Sub_Category__c, Product_Name__c, Opportunities__c, Quoted_Price__c, Power_in_HP__c, Quantity_In_no_s__c, 
                Discount__c, Discounted_Price__c, Unit_Price__c, Type__c, Total_Price__c
                FROM Products__c WHERE Id IN :selectedProductIds]) {
                OpportunityLineItem__c lineItem = new OpportunityLineItem__c(
                Opportunities__c = oppId,
                Products__c = product.Id,
                Category__c = product.Category__c,
                Sub_Category__c = product.Sub_Category__c,
                Type__c = product.Type__c,
                Product_Name__c = product.Product_Name__c,
                Discount__c = product.Discount__c, 
                Unit_Price__c = product.Unit_Price__c,
                Quantity__c = product.Quantity_In_no_s__c,
                Power_in_HP__c = product.Power_in_HP__c);
                opportunityLineItemsToInsert.add(lineItem);
            }
            
            if (!opportunityLineItemsToInsert.isEmpty()) {
                insert opportunityLineItemsToInsert;
                system.debug('lineitems'+opportunityLineItemsToInsert);
            }
        } catch (Exception e) {
            // Handle the exception appropriately
           System.debug('Exception: ' + e.getMessage());
        }
    }
}