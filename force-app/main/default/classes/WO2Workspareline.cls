public with sharing class WO2Workspareline {
    public static void convertSpareline2WOLI(List<Work_Order_for_Spares__c> qList) {
        Set<Id> Ids = new set<Id>();
        for(Work_Order_for_Spares__c qa:qList){
            Ids.add(qa.Case__c);
        }
        List<SpareLineItem__c>  spareLineItems=[ SELECT Cases__c,Dept__c,Diagram__c,Id,
                                                MC_Name__c,Name,Price__c,Product_Code__c,Product_Name__c,
                                                Required_On_or_Before__c,RS_EA__c,RS_SET__c,Size__c,
                                                Spare_Description_of_Material__c,Sr_No__c,Std_Qty__c,Total_Price__c,Units__c,Work_Order__c 
                                                FROM SpareLineItem__c
                                                WHERE Cases__c = :Ids];
        
        
        List<WorkOrderSparesLine__c> SpareLineItemsToInsert = new List<WorkOrderSparesLine__c>();
        for(Work_Order_for_Spares__c q:qList){
            
            for (SpareLineItem__c oli : spareLineItems) {
                
                   WorkOrderSparesLine__c qli = new WorkOrderSparesLine__c(
                         cases__c=q.case__c,
                         Work_Order_for_Spares__c=q.Id,
                         MC_Name__c = oli.MC_Name__c,
                         Diagram__c=oli.Diagram__c,
                         Product_Code__c=oli.Product_Code__c,
                         Product_Name__c=oli.Spare_Description_of_Material__c,
                         Size__c=oli.Size__c,
                         Quantity__c=oli.Units__c,
                         RS_EA__c=oli.RS_EA__c,
                         RS_SET__c=oli.RS_SET__c,
                     
                         Required_On_or_Before__c=oli.Required_On_or_Before__c
                                            
                );
                    SpareLineItemsToInsert.add(qli);
                    system.debug('WorkLine Item added: ' + qli);
                            }
        }
        
        if (!SpareLineItemsToInsert.isEmpty()) {
            insert SpareLineItemsToInsert;
            system.debug('WorkLine Items inserted successfully');
        }
    }
}