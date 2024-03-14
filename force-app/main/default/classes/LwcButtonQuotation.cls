public class LwcButtonQuotation {
    
    public Quotes__c  qu{get;set;}
    
    public String currentRecordId{get;set;}
    

    public LwcButtonQuotation(){
        
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        
        if(currentRecordId != null && String.isNotBlank(currentRecordId)){
            
            qu = [SELECT Id,  Account_Name__c,  GSTIN__c,Date__c, BillingStreet__c, BillToName__c, Contact_Name2__c,
                 Commissioning_Charges__c, Phone__c, Contact_Name__c, Village__c, Mandal__c, District__c, Territory__c, BillingZipPostalCode__c,
                 BillingCity__c, BillingStateProvince__c, BillingCountry__c,IGST__c,IGST_Amount__c, CGST__c, SGST__c, SGST_Amount__c, SGST_Amount_Final__c,
                 Description__c, Email__c, Forwarding_Charges__c, Forwarding_Charges_Amount__c, Grand_Total__c, PackingCharge__c, ForwardingCharge__c,
                 Opportunity_Name__c, Packing_Charges__c, Packing_Charges_Amount__c, Name, Quote_Number__c, Ship_To__c, QuotedQQ__c, FinalFF__c,
                 Total_PowerPP__c, Ship_To_Name__c, Status__c, Packing_Charges_AmountF_c__c, Forwarding_Charges_AmountF_c__c, Transit_Insurance_ChargesF_c__c, 
                 Machine_Required__c, Total_CostF_c__c, GST_AmountF_c__c, Total_Commissioning_Charges__c, Grand_TotalF_c__c, Total_Cost__c, 
                 Transit_Insurance__c,Transit_Insurance_Charges__c FROM Quotes__c WHERE Id =:currentRecordId];       
        }
        
        System.debug('Currentid: ' + currentRecordId);
        
    }
    
    
    
    
    
    @AuraEnabled
    
    public static String sendPdf(String recordId) {
        
        PageReference pdf = new pagereference('/apex/QuotationPDF?id='+recordId);
        
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
        String pdfType = 'Final Quote';
        
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
            Quotes__c quote = [SELECT Id, LastVersionNumber__c FROM Quotes__c WHERE Id = :recordId LIMIT 1];
            quote.LastVersionNumber__c = lastVersionNumber;
            update quote;
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