public class WorkPreviewController {
    
    public String MstrId{get;set;}
    public Work_Order_for_Spares__c accObj{get;set;}
    
    public String PDFNo{get;set;}
    public String EFNo{get;set;}
    public boolean show{get;set;}
    public boolean showpdf{get;set;}
    public ApexPages.PageReference page2{get;set;}
    
    
    public PageReference Cancel()
    {
        PageReference Pdf = new PageReference('/'+MstrID);
        pdf.setredirect(True);
        return Pdf;
    }
    
    public WorkPreviewController(ApexPages.StandardController Controller){
        MstrId = ApexPages.currentPage().getParameters().get('id');
        accObj = [SELECT Account_Name__c,Case__c,
                 
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
         Where id =: MstrId ];
        //WHERE id=:workorderforsparesId
    }
    
    
    
    public PageReference pdfAction()
    {
        PageReference savepage ;
        savepage = Page.WorkOrderPreview;
        savepage.getParameters().put('id',MstrID);
        system.debug('id:- '+MstrID);
        blob pdfBlob;
        if (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent(); //generate the pdf blob
        } else { 
            pdfBlob = Blob.valueOf('Test');
        }
        List<ContentDocumentLink> notesattch = [select id, ContentDocument.Title,LinkedEntityId from ContentDocumentLink where LinkedEntityId =: MstrID order by ContentDocument.Title asc];    
        system.debug('notesattch## ' + notesattch);
        if(notesattch.size() > 0)
        {
            string title =  notesattch[0].ContentDocument.Title;
            system.debug('title111 ' + title);
            List<String> titleSplit = title.split('R');
            //String FinalTitle = titleSplit[0]+'R0'+notesattch.size();
            String FinalTitle = 'R0'+notesattch.size();
            system.debug('FinalTitle22 ' + FinalTitle);
            PDFNo=FinalTitle;
            
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = FinalTitle+'.pdf'; 
            conVer.Title = FinalTitle; 
            conVer.VersionData = pdfBlob;
            system.debug('conVer@@ ' + conVer);
            insert conVer;  
            
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
            
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrID;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            insert conDocLink;
            update accObj;
            
            show=false;
            showpdf=true;
            PageReference savepage2 = Page.WorkOrderPreview;
            savepage2.getParameters().put('id',MstrID);
            if(!show)
                savepage2.getParameters().put('show','0');
            savepage2.setRedirect(true);
            return savepage2;
            
        }
        
        
        {
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = PDFNo+'.pdf'; 
            conVer.Title = PDFNo; 
            conVer.VersionData = pdfBlob;
            insert conVer;  
            
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
            
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrID;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            insert conDocLink;
            //Addtext = 'File Attached';
            
            update accObj;
           
            show=false;
            showpdf=true;
            PageReference savepage2 = Page.WorkOrderPreview;//Cafactionpage;CAFFormPDF
            savepage2.getParameters().put('id',MstrID);
            if(!show)
                savepage2.getParameters().put('show','0');
            savepage2.setRedirect(true);
            return savepage2;
        }
        
        //PageReference Pdf = new PageReference('/'+MstrID);
        //pdf.setredirect(True);
        //return Pdf;        
        
    }
    
}