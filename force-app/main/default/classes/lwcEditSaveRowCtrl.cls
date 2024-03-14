public with sharing class lwcEditSaveRowCtrl {

    @AuraEnabled(Cacheable = true)
    public static List<WorkOrderSparesLine__c> getAccounts(Id recId) {
                                                                                                

    List<WorkOrderSparesLine__c> acclist= [Select Account_Name__c,Available_Quantity__c,Cases__c,Contact_Person_Mobile_Number__c,
                                                Contact_Person_Name__c,Date__c,Diagram__c,Id,
                                                Issued_ON__c,MC_Name__c,Mill_Address__c,Name,Price__c,Product_Code__c,Product_Name__c,Discount__c,Discount_Amount__c,
                                                Quantity__c,Required_On_or_Before__c,RS_EA__c,RS_SET__c,Size__c,Spares_And_Machinery_Parts__c,Spare_Products__c,
                                                Sr_No__c,Status__c,Total_Price__c,Spare_Products__r.name,Work_Order_for_Spares__r.name,TPrice__c,Work_Order_for_Spares__c
                                                FROM WorkOrderSparesLine__c 
                                                where   Work_Order_for_Spares__c=: recId
                                                
                                              
                                                ];
         return acclist;  

       
    }    
}