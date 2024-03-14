public class LwcButtonControllercustcomplcomm {

    public Cases__c  comm{get;set;}

    public String currentRecordId{get;set;}

 

    public LwcButtonControllercustcomplcomm(){

        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');

        if(currentRecordId != null && String.isNotBlank(currentRecordId)){

            comm = [SELECT Id, Name, Mill_Name__c, CustomerName2__c,  PhoneNumber2__c, Customer_Address__c, Customer_Name__c, Call_Type__c, C_C_Acknowledged_by__c, Re_Occurance__c, Enclosures__c, 
               Complaint_Classification__c, Complaint_Details__c, IS_CAPA_Required__c, Engineer_Allotment_Date__c,  CustomerNameNew__c,
               Service_Engineer__c, Authorised_Sign__c, ModeofReceipt__c, Complaint_Receipt_Date__c, Machine_MFD__c, PhoneNumberNew__c From Cases__c WHERE Id =:currentRecordId];

           

        }

        System.debug('Currentid: ' + currentRecordId);

    }

 

   

    @AuraEnabled

    public static String sendPdf(String recordId) {

        PageReference pdf = new pagereference('/apex/CustomerComplaintcommunicationPDF?id='+recordId);

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
        String pdfType = 'Customer Complaint Communication';
        
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

       

       /* Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();

        attach.setContentType('application/pdf');

        attach.setFileName('RiceTec CC Commnication.pdf');

        attach.Body = body;

 

        Cases__c cmail = [SELECT Email__c FROM Cases__c WHERE Id = :recordId];

 

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setToAddresses(new String[] {cmail.Email__c});

        mail.setSubject(' PDF from RiceTec Machinery India Pvt. Ltd.,');

        mail.setHtmlBody('PDF for the Customer Complaint Communication');

        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});

        // Send the email

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

        return 'Email sent Successfully with PDF.';*/
        return 'PDF saved successfully.';

   }

}