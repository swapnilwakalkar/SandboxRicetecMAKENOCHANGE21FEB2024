/* public class Redirect_Main {
public List<WorkOrderSparesLine__c> accs { get; set; }
public List<Work_Order_for_Spares__c> qList{ get; set; }
public List<SpareLineItem__c> op{ get; set; }
public Redirect_Main(ApexPages.StandardController controller) {
         
         
         List<id> cnt = new List<id>();
for(Work_Order_for_Spares__c c : [Select case__c from Work_Order_for_Spares__c]) {
         cnt.add(c.case__c);
}

        List<WorkOrderSparesLine__c> accs = [SELECT Account_Name__c,Available_Quantity__c,
        Cases__c,Contact_Person_Mobile_Number__c,Contact_Person_Name__c,
        Date__c,Diagram__c,Id,Issued_ON__c,MC_Name__c,Mill_Address__c,
        Name,Price__c,Products__c,Product_Code__c,Product_Name__c,Quantity__c,Required_On_or_Before__c,
        Size__c,Spares_And_Machinery_Parts__c,Spare_Products__c,Sr_No__c,Status__c,
        Total_Price__c,Work_Order_for_Spares__c 
        FROM WorkOrderSparesLine__c 
        where Cases__c IN: cnt
        ];  
       
    }    
}

*/



public class Redirect_Main {
public List<Work_Order_for_Spares__c> op { get; set; }

public List<WorkOrderSparesLine__c> accs{ get; set; }
public Redirect_Main(ApexPages.StandardController controller) {
List<String> cnt = new List<String>();
for(Work_Order_for_Spares__c c : [Select Id,name,Case__c From Work_Order_for_Spares__c limit 1]) {
         cnt.add(c.Id);
         

       accs= [SELECT Account_Name__c,Available_Quantity__c,
        Cases__c,Contact_Person_Mobile_Number__c,Contact_Person_Name__c,
        Date__c,Diagram__c,Id,Issued_ON__c,MC_Name__c,Mill_Address__c,
        Name,Price__c,Product_Code__c,Quantity__c,Required_On_or_Before__c,
        Size__c,Spares_And_Machinery_Parts__c,Spare_Products__c,Sr_No__c,Status__c,
        Total_Price__c,Work_Order_for_Spares__c 
        FROM WorkOrderSparesLine__c 
        where Work_Order_for_Spares__c IN: cnt];

 }
 }
 }