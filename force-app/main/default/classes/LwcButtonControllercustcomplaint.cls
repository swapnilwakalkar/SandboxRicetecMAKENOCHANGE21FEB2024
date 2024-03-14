public class LwcButtonControllercustcomplaint {

    public Cases__c  complaint{get;set;}

    public String currentRecordId{get;set;}

 

    public LwcButtonControllercustcomplaint(){

        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');

        if(currentRecordId != null && String.isNotBlank(currentRecordId)){

            complaint = [SELECT Id,Name, Customer_Address__c,Stores_GRN_No__c,Returnable_DC_No__c,Initial_DC_No__c,Sl_No__c,    
                ModeofReceipt__c,Complaint_Receipt_Date__c,Date_of_Dispatch__c,Date_of_Commissioning__c, CustomerNameNew__c,
                Machine_No__c, Complaint_Date__c, Enclosures__c, Complaint_Details__c, Reviewed_CBy__c, Reviewed_RBy__c,
                Reviewed_PBy__c,Preventive_Action__c,Root_Cause__c,Date__c,Stores_Signature__c,Datep__c,Datec__c, 
                IS_CAPA_Required__c,Re_Occurance__c,C_C_Acknowledged_by__c,Accountant_Sign__c,Debit_Note_No__c, CustomerName2__c,  PhoneNumber2__c,
                Debit_Note_Date__c,QC_Sign__c,Designinig_cost__c,Rework_Cost__c,Spares_cost__c,Obsesrvations_status_QC__c,  
                QC_cost__c, Transport_Cost__c,Prepared_By__c,Reviewed_By__c,Verified_Results__c,Corrective_Action__c, 
                Complaint_Classification__c,Approved_By__c, Others__c From Cases__c WHERE Id =:currentRecordId];

           

        }

        System.debug('Currentid: ' + currentRecordId);

    }

 

   

    @AuraEnabled

    public static String sendPdf(String recordId) {

        PageReference pdf = new pagereference('/apex/CustomerComplaintPDF?id='+recordId);

        pdf.getParameters().put('id', recordId);

        System.debug('Recordid: ' + recordId);

        Blob body;

        try {

            // returns page as a PDF

            body = pdf.getContent();

        } catch (Exception e) {

            body = Blob.valueOf('data');

        }

 

        //insert content version
        
        ContentVersion CV = new ContentVersion();
        
        // Specify the PDF type
        String pdfType = 'Customer Complaint';
        
        // Query existing ContentVersions for the same recordId and PDF type
        List<ContentVersion> existingVersions = [SELECT Id, Title FROM ContentVersion WHERE FirstPublishLocationId = :recordId AND Title LIKE :pdfType + '-%' ORDER BY CreatedDate DESC LIMIT 1];
        
        String versionLabel;
        Integer lastVersionNumber = 1; // Initialize with 1 by default
        
        if (!existingVersions.isEmpty()) {
            // If there are existing versions, determine the version label (S1, S2, etc.)
            String existingTitle = existingVersions[0].Title;
            
            // Extract the version number from the existing title
            try {
                String lastVersionLabel = existingTitle.substringAfter('V');
                lastVersionNumber = Integer.valueOf(lastVersionLabel);
                lastVersionNumber++;
            } catch (Exception e) {
                // Handle any exceptions if the existing title doesn't follow the expected format
            }
        }
        
        versionLabel = 'V' + lastVersionNumber;
        String uniqueNumber = pdfType + '-' + versionLabel;
        
        CV.Title = uniqueNumber;
        CV.PathOnClient = pdfType + '.pdf';
        CV.VersionData = body;
        CV.FirstPublishLocationId = recordId;
        
        insert CV;
        
        // Update the custom field on the Quote object to store the last version number for this PDF type
        if (!existingVersions.isEmpty()) {
            Cases__c cse = [SELECT Id, Last_Version_Number__c FROM Cases__c WHERE Id = :recordId LIMIT 1];
            cse.Last_Version_Number__c = lastVersionNumber;
            update cse;
        }

       

        /*Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();

        attach.setContentType('application/pdf');

        attach.setFileName('RiceTec Customer Complaint.pdf');

        attach.Body = body;

 

        Cases__c cemail = [SELECT Email__c FROM Cases__c WHERE Id = :recordId];

 

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setToAddresses(new String[] {cemail.Email__c});

        mail.setSubject('PDF from RiceTec Machinery India Pvt. Ltd.,');

        mail.setHtmlBody('PDF for the Customer Complaint');

        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});

        // Send the email

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

        return 'Email sent Successfully with PDF.'; */
    return 'PDF saved successfully.';
   }

}