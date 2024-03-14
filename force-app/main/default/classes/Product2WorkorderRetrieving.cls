public with sharing class Product2WorkorderRetrieving {
   
    @AuraEnabled()
            public static List<spares__c> retrieveProducts(){
                return [ SELECT Available_Quantity__c,Cases__c,Dept__c,Diagram__c,
                        Id,MC_Name__c,Name,Name__c,Order_Quantity__c,Price__c,Cases__r.Machine_No__c,
                        Product_Code__c,Size__c,SpareDescriptionofMaterial__c,Discount__C,
                        SpareLineItem__c,Spares_And_Machinery_Parts__c,Sr_No__c,Std_Qty__c,Required_On_or_Before__c,
                        Unit_Type__c,Unit__c FROM spares__c
 
                ];
            }
            
            public class ProductUpdateWrapper {
                @AuraEnabled public String Id;
                @AuraEnabled public String CaseId; 
            }
              
     @AuraEnabled
            public static void updateProductOpport(List<String> selectedProductIds, Id CaseId) {
      try {
                    List<SpareLineItem__c> WorkOrderSparesLineItemsToInsert = new List<SpareLineItem__c>();
                    
                 for (spares__c product : [SELECT Available_Quantity__c,Cases__c,Dept__c,Diagram__c,Id,
                                           MC_Name__c,Name,Name__c,Order_Quantity__c,Price__c,Product_Code__c,
                                           Size__c,SpareDescriptionofMaterial__c,Discount__C,
                                           Spares_And_Machinery_Parts__c,Sr_No__c,Std_Qty__c,Unit_Type__c,Required_On_or_Before__c,
                                           Unit__c 
                                           FROM spares__c
                                           WHERE Id IN :selectedProductIds]) {
                                               
                        SpareLineItem__c  lineItem = new SpareLineItem__c(
                                cases__c = CaseId,
                                Spares_And_Machinery_Parts__c = product.Id,
                                Name=product.name,
                                MC_Name__c=product.MC_Name__c,
                                Diagram__c = product.Diagram__c,
                                Product_Code__c = product.Product_Code__c,
                                Spare_Description_of_Material__c=product.SpareDescriptionofMaterial__c,
                                Size__c=product.Size__c,
                                Dept__c=product.Dept__c,
                                Units__c=product.Unit__c,
                                Std_Qty__c=product.Std_Qty__c,
                                RS_EA__c=product.Price__c,
                               Discount__C=Product.Discount__C,
                               Required_On_or_Before__c=product.Required_On_or_Before__c                                               
                                );
                     WorkOrderSparesLineItemsToInsert.add(lineItem);                      
                    }

                if (!WorkOrderSparesLineItemsToInsert.isEmpty()) {
                insert WorkOrderSparesLineItemsToInsert;
                system.debug('lineitems'+WorkOrderSparesLineItemsToInsert);	
            }
        } 
                catch (Exception e) {
            // Handle the exception appropriately
           System.debug('Exception: ' + e.getMessage());
        }
     }  
 }