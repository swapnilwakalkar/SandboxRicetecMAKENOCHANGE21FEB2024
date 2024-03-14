public class Casescomplaintcontroller {
    public Id id { get; set; }
    public List<Cases__c> cont { get; set; }
    // public Cases__c c { get; set; }
    public ApexPages.StandardSetController controller { get; set; }
    
    public Casescomplaintcontroller(ApexPages.StandardController stdController) {
        Id caseId = stdController.getId();
        cont = [SELECT Id,Name,Stores_GRN_No__c,Machine_No__r.Name,Customer_Name__c, CustomerNameNew__c,Returnable_DC_No__c, Order_No_del__r.Name,
                Initial_DC_No__c,Sl_No__c,ModeofReceipt__c, CustomerName2__c,  PhoneNumber2__c, Complaint_Receipt_Date__c,Date_of_Dispatch__c,Date_of_Commissioning__c,
                Machine_No__c, Complaint_Date__c, Enclosures__c, Complaint_Details__c, Reviewed_CBy__c, Reviewed_RBy__c, Ordernew__c,
                Details_of_Designing_Cost__c, Details_of_Others__c, Details_of_QC_cost__c, Details_of_Rework_Cost__c, Details_of_Spares_Cost__c, Details_of_Transport_Cost__c,
                Reviewed_PBy__c,Preventive_Action__c,Root_Cause__c,Date__c,Stores_Signature__c,Datep__c,Datec__c, IS_CAPA_Required__c,
                Re_Occurance__c,C_C_Acknowledged_by__c,Accountant_Sign__c,Debit_Note_No__c, Debit_Note_Date__c,Name_of_Participant__c,Name_of4_Participant__c,
                Name_of2_Participant__c,Name_of3_Participant__c,QC_Sign__c,Designinig_cost__c,Rework_Cost__c,Spares_cost__c,Obsesrvations_status_QC__c, 
                QC_cost__c, Transport_Cost__c,Prepared_By__c,Signature2__c,Signature1__c,Signature3__c,Reviewed_By__c,Verified_Results__c,SignatureI__c,
                SignatureD__c,SignatureM__c,DateIS__c,DateDp__c,DateAB__c,Corrective_Action__c,Complaint_Classification__c,Machine_Name__c,
                Received_by_Sign__c,Checked_by_Sign_ASM__c,Verified_by_Sign_MR__c,Authorized_Sign_Director_Operations__c,DateRB_Time__c,DateCB_Time__c,
                DateVB_Time__c,DateDO__c,Customer_Address__c,Total_Cost__c, Approved_By__c, Others__c From Cases__c WHERE Id = :caseId];
        system.debug('cases:'+cont);
        controller = new ApexPages.StandardSetController(cont);
        controller.setPageSize(1);
    }
    
    public PageReference pdf() {
        if (cont.isEmpty()) {
            return null; // No complaint to generate PDF
        }
        Cases__c cc = cont[0];
        
        PageReference pdfPage = Page.CustomerComplaintPDF;
        pdfPage.getParameters().put('id', cc.Id);
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