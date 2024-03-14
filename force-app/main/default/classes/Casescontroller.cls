public class Casescontroller {
    public Id id { get; set; }
    public List<Cases__c> cse { get; set; }
    // public Cases__c c { get; set; }
    public ApexPages.StandardSetController controller { get; set; }
    
    public Casescontroller(ApexPages.StandardController stdController) {
        Id caseId = stdController.getId();
        cse = [SELECT Id, Name, Mill_Name__c, Account_Name__r.Name,Machine_No__r.Name,Customer_Address__c, Customer_Name__c, Call_Type__c, 
               C_C_Acknowledged_by__c, Re_Occurance__c, Enclosures__c, CustomerNameNew__c, CustomerName2__c,  PhoneNumber2__c,
               Details_of_Designing_Cost__c, Details_of_Others__c, Details_of_QC_cost__c, Details_of_Rework_Cost__c, Details_of_Spares_Cost__c, Details_of_Transport_Cost__c,
               Complaint_Classification__c, Machine_Name__c, Complaint_Details__c, IS_CAPA_Required__c, Engineer_Allotment_Date__c,  
               Service_Engineer__c, Authorised_Sign__c, ModeofReceipt__c, Complaint_Receipt_Date__c, Machine_MFD__c, PhoneNumberNew__c From Cases__c WHERE Id = :caseId];
        system.debug('cases:'+cse);
        controller = new ApexPages.StandardSetController(cse);
        controller.setPageSize(1);
    }
    
    public PageReference pdf() {
        if (cse.isEmpty()) {
            return null; // No complaint to generate PDF
        }
        Cases__c ca = cse[0];
        
        PageReference pdfPage = Page.CustomerComplaintcommunicationPDF;
        pdfPage.getParameters().put('id', ca.Id);
         blob pdfBlob;
        if(Test.isRunningTest()) { 
          pdfBlob = blob.valueOf('Unit.Test');
        } else {
          pdfBlob = pdfPage.getContentAsPDF();
        } 
        
        // Code to handle the PDF Blob, for example, save it or attach it to a record.
        
        return null; // Add your desired PageReference to redirect the user after generating the PDF.
    }
}