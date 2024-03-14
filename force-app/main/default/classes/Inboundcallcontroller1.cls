public with sharing class Inboundcallcontroller1 {
 /*  
     public Inbound_Call_Report__c icr{get;set;}

     public Inboundcallcontroller1() {
         icr = [Select Name, Customer_Name__c, Phone_Number__c, Mill_Name__c, Mill_Address__c, 
         Call_Receipt_Date__c, Call_Acknowledged_By__c, Call_Classification__c, Call_Details__c
                 from Inbound_Call_Report__c];

      }
       
 /*  public PageReference pdf() {
        if (icr.isEmpty()) {
            return null; // No complaint to generate PDF
        }
       Inbound_Call_Report__c cc = icr[0];
        
        PageReference pdfPage = Page.abc;
        pdfPage.getParameters().put(id, cc.Id);
        Blob pdfBlob = pdfPage.getContentAsPDF();        
        return null; // Add your desired PageReference to redirect the user after generating the PDF.
    }
   */
}