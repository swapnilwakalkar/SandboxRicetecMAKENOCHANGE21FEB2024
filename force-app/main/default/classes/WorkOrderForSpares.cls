public class WorkOrderForSpares {

public Id id { get; set; }
public List<Work_Order_for_Spares__c> Wosp { get; set; }

public Integer rowCount { get; set; }

public List<WorkOrderSparesLine__c> op { get; set; }
public ApexPages.StandardSetController controller { get; set; }


public WorkOrderForSpares(ApexPages.StandardController stdcontroller) {
           
         Id workorderforsparesId = stdcontroller.getId();    
         Wosp = [SELECT Account_Name__c,Case__c,
                 
                 Spares_And_Machinery_Parts__r.id,
                 Spares_And_Machinery_Parts__r.Name,
                 Spares_And_Machinery_Parts__r.Unit__c,
                 Spares_And_Machinery_Parts__r.Size__c,
                 Spares_And_Machinery_Parts__r.Price__c,
                 Spares_And_Machinery_Parts__r.MC_Name__c,
                   Spares_And_Machinery_Parts__r.Name__c,
                     Spares_And_Machinery_Parts__r.Order_Quantity__c,
                    
              
                Contact_Person_Mobile_Number__c,Contact_Person_Name__c,
                Date__c,Id,Issued_ON__c,Mill_Address__c,
                Name,OwnerId,ProductCode__c,Product_Machine_Number__c,Quantity__c,
                Required_On__c,Rice_Mill_Name__c,Spares_And_Machinery_Parts__c,
                Spare_Description__c,Status__c,Subject__c,SubTotal__c,Total_Price__c
        FROM Work_Order_for_Spares__c 
        WHERE id=:workorderforsparesId];
        
       controller = new ApexPages.StandardSetController(Wosp);
       controller.setPageSize(1);
        
       
     
         
          Set<Id> CasesIds = new Set<Id>(); 
           for (Work_Order_for_Spares__c WospRecord : Wosp) {
             CasesIds.add(WospRecord.Id);
        }        
      
         op=[SELECT Account_Name__c,Spares_And_Machinery_Parts__r.name,Available_Quantity__c,Cases__c,Contact_Person_Mobile_Number__c,
         Contact_Person_Name__c,Date__c,Diagram__c,Id,Issued_ON__c,MC_Name__c,Mill_Address__c,
         Name,Price__c,Product_Code__c,Product_Name__c,Quantity__c,Required_On_or_Before__c,
         Size__c,Spares_And_Machinery_Parts__c,Spare_Products__c,Sr_No__c,Status__c,Total_Price__c,
         Work_Order_for_Spares__c FROM WorkOrderSparesLine__c

         WHERE Work_Order_for_Spares__c IN :CasesIds
         ]; 
                 

      
      
        
           
                     
        for (WorkOrderSparesLine__c item : op) {
        System.debug('Spares_And_Machinery_Parts__r.Name value: ' +item.Spares_And_Machinery_Parts__r.Name);
        
       rowCount =0;
}                 
     
 for (Integer i = 0; i < op.size(); i++) {
          op[i].Sr_No__c = i + 1;}
        
    }

          public PageReference pdf() {
        if (wosp.isEmpty()) {
            return null; // No Quotes to generate PDF
    } 
 
      Work_Order_for_Spares__c wos = Wosp[0];
  
        PageReference pdfPage = Page.WorkorderQuote;
        pdfPage.getParameters().put('id', wos.Id);
                blob pdfBody;
        if(Test.isRunningTest()) { 
          pdfBody = blob.valueOf('Unit.Test');
        } else {
          pdfBody = pdfPage.getContentAsPDF();
        }
         PageReference pageRef = new PageReference('/' + wos.Id);
        pageRef.setRedirect(true);
        return pageRef;
          
    }

    
}