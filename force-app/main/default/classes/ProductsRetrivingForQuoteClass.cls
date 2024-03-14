public class ProductsRetrivingForQuoteClass {
    
    @AuraEnabled()
    public static List<Products__c> retrieveProducts(){
        return [ SELECT Name,Product_Name__c, Opportunities__c, Category__c, Sub_Category__c, Quoted_Price__c, Power_in_HP__c, Quantity_In_no_s__c, 
                Discount__c, Discounted_Price__c, Unit_Price__c, Total_Price__c
                FROM Products__c ];
    }
    
    public class ProductUpdateWrapper {
        @AuraEnabled public String Id;
        @AuraEnabled public String Quoteid;
    }
    
    @AuraEnabled
    public static void UpdateQuoteProducts(List<String> selectedProductIds, Id QuoteId) {
        for(string abc : selectedProductIds){
            system.debug('method is'  +abc);
        }
        try {
            List<Quote_Line_Item__c> QuoteLineItemsToInsert = new List<Quote_Line_Item__c>();
            if(selectedProductIds!= null){
                
            
            for (Products__c product : [SELECT Name,Product_Name__c, Opportunities__c, Quoted_Price__c, Power_in_HP__c, Quantity_In_no_s__c, 
                                        Discount__c, Category__c, Sub_Category__c, Discounted_Price__c, Type__c, Unit_Price__c, Total_Price__c
                                        FROM Products__c WHERE Id IN :selectedProductIds]) {
                                            Quote_Line_Item__c lineItem = new Quote_Line_Item__c(
                                                Quotes__c = QuoteId,
                                                Product__c = product.Id,
                                                Product_Name__c = product.Product_Name__c,
                                                Discount__c = product.Discount__c,
                                                Type__c = product.Type__c,
                                                Category1__c = product.Category__c,
                                                SubCategory__c = product.Sub_Category__c,
                                                Unit_Price__c = product.Unit_Price__c,
                                                Quantity__c = product.Quantity_In_no_s__c,
                                                PowerHP__c = product.Power_in_HP__c);
                                            QuoteLineItemsToInsert.add(lineItem);
                                        }
            }
            
            if (!QuoteLineItemsToInsert.isEmpty()) {
                system.debug('lineitems'+QuoteLineItemsToInsert);
                insert QuoteLineItemsToInsert;
                system.debug('lineitems'+QuoteLineItemsToInsert);
            }
        } catch (Exception e) {
            // Handle the exception appropriately
            System.debug('Exception: ' + e.getMessage());
        }
    }
    
}