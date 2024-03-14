public class WorkOrderForSparesQuote {
    
    private final Work_Order_for_Spares__c a; //object
    
    
    
    public String MstrId{GET;SET;}
    public String PDFNo{GET;SET;}
        public boolean show{get;set;}
    public boolean showpdf{get;set;}
    public List<Work_Order_for_Spares__c> Wosp { get; set; }
    
    
    public List<WorkOrderSparesLine__c> op { get; set; }
    public ApexPages.StandardSetController controller { get; set; }
    
    
    
    public PageReference Cancel()
    {
        PageReference Pdf = NEW PageReference('/'+MstrID);
        pdf.setredirect(TRUE);
        RETURN Pdf;
    }
    
    
    
    
    public WorkOrderForSparesQuote(ApexPages.StandardController stdcontroller) {
        Id workorderforsparesId = stdcontroller.getId();    
        Wosp = [SELECT 
                
                Spares_And_Machinery_Parts__r.id,
                
                Spares_And_Machinery_Parts__r.Unit__c,
                Spares_And_Machinery_Parts__r.Size__c,
                Spares_And_Machinery_Parts__r.Price__c,
                Spares_And_Machinery_Parts__r.MC_Name__c,
                Spares_And_Machinery_Parts__r.Name__c,
                Spares_And_Machinery_Parts__r.Order_Quantity__c,
                
                
                Account_Name__c,Batch_No__c,Case__c,CGST__c,
                Commissioning_Charges_for_each_machine__c,
                Contact_Person_Mobile_Number__c,Contact_Person_Name__c
                ,Date__c,
                Forwarding_Charges_Amount__c,Forwarding_Charges__c,
                Grand_Total__c,GSTIN__c,HSN__c,Id,IGST__c,
                Issued_ON__c,
                Line_Items__c,Mill_Address__c,
                Name,Packing_Charges_Amount__c,Packing_Charges__c,
                PAN_No__c,ProductCode__c,Product_Machine_Number__c,
                Quantity__c,Required_On__c,Rice_Mill_Name__c,SGST__c,Size__c,
                Spares_And_Machinery_Parts__c,Spare_Description__c,State__c,
                Status__c,Subject__c,SubTotal__c,tcs__c, Amt_In_words__c,
                Total_Price__c,Total__c,Transit_Insurance__c 
                FROM Work_Order_for_Spares__c
                
                
                
                
                WHERE id=:workorderforsparesId];
        
        controller = new ApexPages.StandardSetController(Wosp);
        controller.setPageSize(1);
        
        
        
        
        Set<Id> CasesIds = new Set<Id>(); 
        for (Work_Order_for_Spares__c WospRecord : Wosp) {
            CasesIds.add(WospRecord.Id);
        }        
        
        
        op=[SELECT Account_Name__c,Spares_And_Machinery_Parts__r.name,Available_Quantity__c,Cases__c,Contact_Person_Mobile_Number__c,
            Contact_Person_Name__c,Date__c,Diagram__c,Id,Issued_ON__c,MC_Name__c,Mill_Address__c,Discount__c,IGST_Amount__c,
            Name,Price__c,Product_Name__c,Quantity__c,Required_On_or_Before__c,Discount_Amount__c,
            Size__c,Spares_And_Machinery_Parts__c,Product_Code__c,Spare_Products__c,Sr_No__c,Status__c,Total_Price__c,TPrice__c,RS_SET__c,RS_EA__c,
            Work_Order_for_Spares__c FROM WorkOrderSparesLine__c
            
            WHERE Work_Order_for_Spares__c IN :CasesIds
           ]; 
        
        
        
        
        MstrId = ApexPages.currentPage().getParameters().get('id');
        
        
        
        
        
        for (WorkOrderSparesLine__c item : op) {
            System.debug('Spares_And_Machinery_Parts__r.Name value: ' +item.Spares_And_Machinery_Parts__r.Name);
            
            
        }                 
        
        for (Integer i = 0; i < op.size(); i++) {
            op[i].Sr_No__c = i + 1;}
        
    }
    
    
    
    
    
    
    
    
    

    //action method - returns a page reference
    public PageReference pdfAction() {   
        
        
        // Get PDF content from VF page
        PageReference pdfPage = Page.WorkorderQuote;
        pdfPage.getParameters().put('id',MstrId);
        Blob pdfBlob; //create a blob for the PDF content
        if (!Test.isRunningTest()) { //if we are not in testing context
            pdfBlob = pdfPage.getContent(); //generate the pdf blob
        } else { //otherwise, we are in testing context and getContent() gets funky so create the blob manually
            pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        }      
        List<ContentDocumentLink> notesattch = [SELECT id, ContentDocument.Title,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: MstrID ORDER BY ContentDocument.Title ASC];    
        
        
        String FinalTitle = 'SpareQuotation'+notesattch.size();
        PDFNo=FinalTitle;
        // Create attachment and attach
        Attachment attach = new Attachment();
        attach.Body = pdfBlob;
        attach.Name = FinalTitle+'.pdf';
        attach.IsPrivate = false;
        attach.ParentId = MstrId;        
        attach.ContentType = 'application/pdf';
        insert attach; //insert the attachment
        
        // Redirect the user to object page
        
        //    PageReference destPage = new ApexPages.StandardController(Work_Order_for_Spares__c).view();
        
        PageReference Pdf = NEW PageReference('/'+MstrID);
        pdf.setredirect(TRUE);
        RETURN Pdf;
    }
    
    
 
    
     public PageReference pdfAction2() {   
        
        
        // Get PDF content from VF page
        PageReference pdfPage = Page.Workorder;
        pdfPage.getParameters().put('id',MstrId);
        Blob pdfBlob; //create a blob for the PDF content
        if (!Test.isRunningTest()) { //if we are not in testing context
            pdfBlob = pdfPage.getContent(); //generate the pdf blob
        } else { //otherwise, we are in testing context and getContent() gets funky so create the blob manually
            pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        }      
        List<ContentDocumentLink> notesattch = [SELECT id, ContentDocument.Title,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: MstrID ORDER BY ContentDocument.Title ASC];    
        
        
        String FinalTitle = 'Workorder'+notesattch.size();
        PDFNo=FinalTitle;
        // Create attachment and attach
        Attachment attach = new Attachment();
        attach.Body = pdfBlob;
        attach.Name = FinalTitle+'.pdf';
        attach.IsPrivate = false;
        attach.ParentId = MstrId;        
        attach.ContentType = 'application/pdf';
        insert attach; //insert the attachment
        
        // Redirect the user to object page
        
        //    PageReference destPage = new ApexPages.StandardController(Work_Order_for_Spares__c).view();
        
        PageReference Pdf = NEW PageReference('/'+MstrID);
        pdf.setredirect(TRUE);
        RETURN Pdf;
    }
   
   
    
    
    
    
    
}