public class Invoice {
    public Id id { get; set; }
    public List<Proforma_Invoice__c> InvoiceList { get; set; }
    public List<Quote_Line_Item__c> QLI {get;set;}
    public List<Order_Line_Item__c>ORDL{get;set;}
    public Integer currentPageIndex { get; set; }
    public Integer totalPages { get; set; }
    
    public Invoice(ApexPages.StandardController controller) {
        id = controller.getId();
        InvoiceList = [SELECT Id,Total_Charges__c,State__c,
                       Customer_Name__c,Village__c,
                       Total_Amount__c,Sub_Total__c,Name,
                       Packing_Charges_Amount__c,
                       Packing_Charges__c,Orders__c,Invoice_Number__c,
                       Insurance_Amount__c,Insurance__c,GST_Amount__c,
                       GST__c,Grand_Amount__c,Forwarding_Charges_Amount__c,
                       Forwarding_Charges__c,District__c,Country__c,
                       Commissioning_Charges__c,City__c,CGST__c,CGST_Amount__c,
                       Building_No_Street__c,Amount_Received__c,SGST__c,SGST_Amount__c,
                       Balance_Amount__c FROM Proforma_Invoice__c WHERE id = :id];
        			   totalPages = InvoiceList.size();
             		   currentPageIndex = 0;
        totalPages = InvoiceList.size();
             currentPageIndex = 0;
    
        QLI = [SELECT Product_Name__c,Category1__c, Quantity__c, Final_Price_Final_Price__c, Unit_Price__c, RowNumber__c
    FROM Quote_Line_Item__c WHERE Quotes__r.Proforma_Invoice__c = :id];
        
        for (INTEGER I = 0; I < QLI.size(); I++) {
            QLI[I].RowNumber__c = I + 1;
        }
        ORDL = [SELECT Name,Orders__r.Name, Productes__r.Products__c,Product_Description__c, Quantity__c, Final_Price_After_Discount__c, Unit_Rate__c, Value__c,Serial_No__c,Orders__r.Proforma_Invoice__r.Orders__r.Name,Productes__c,Machine_Name__c
                 FROM Order_Line_Item__c WHERE Orders__c IN (SELECT Orders__c 
                  FROM Proforma_Invoice__c WHERE Id = :id)];
        
        for (INTEGER S = 0; S < ORDL.size(); S++) {
            ORDL[S].Serial_No__c = S + 1;
        }
    }
    
        public Proforma_Invoice__c getCurrentInvoiceReport() {
        if (currentPageIndex >= 0 && currentPageIndex < InvoiceList.size()) {
            return InvoiceList[currentPageIndex];
        }
        return null;
    }
      public PageReference next() {
        if (currentPageIndex < totalPages - 1) {
            currentPageIndex++;
        }
        return null; // Return a PageReference to stay on the same page
    }
        public PageReference previous() {
        if (currentPageIndex > 0) {
            currentPageIndex--;
        }
        return null; // Return a PageReference to stay on the same page
    }

    public PageReference save() {
        Proforma_Invoice__c currentInvoice = getCurrentInvoiceReport();
        if (currentInvoice != null && id != null) {
            Blob pdfBlob = generatePdfContent(currentInvoice.Id);

            if (pdfBlob != null) {
                String pdfFileName = 'GeneratedPDF.pdf';
                savePdfAsAttachment(currentInvoice.Id, pdfFileName, pdfBlob);
            }
        }
    PageReference recordDetailPage = new PageReference('/' + currentInvoice.Id);
    recordDetailPage.setRedirect(true);
    return recordDetailPage;
    }

    private Blob generatePdfContent(Id InvoiceId) {
        PageReference pdfPage = Page.InvoicePage;
        pdfPage.getParameters().put('id', InvoiceId);
        return pdfPage.getContentAsPDF();
    }

    private void savePdfAsAttachment(Id InvoiceId, String pdfFileName, Blob pdfBlob) {
        Attachment attachment = new Attachment();
        attachment.ParentId = InvoiceId;
        attachment.Name = pdfFileName;
        attachment.Body = pdfBlob;
        insert attachment;
    }
}
/*public class Invoice {
    public static Id id { get; set; }
    public static List<Proforma_Invoice__c> InvoiceList { get; set; }
    public List<Quote_Line_Item__c> QLI {get;set;}
    public List<Order_Line_Item__c>ORDL{get;set;}
    public static Integer currentPageIndex { get; set; }
    public static Integer totalPages { get; set; }
    
    public Invoice(ApexPages.StandardController controller) {
        id = controller.getId();
        InvoiceList = [SELECT Id,Total_Charges__c,State__c,
                       Customer_Name__c,Village__c,
                       Total_Amount__c,Sub_Total__c,Name,
                       Packing_Charges_Amount__c,
                       Packing_Charges__c,Orders__c,Invoice_Number__c,
                       Insurance_Amount__c,Insurance__c,GST_Amount__c,
                       GST__c,Grand_Amount__c,Forwarding_Charges_Amount__c,
                       Forwarding_Charges__c,District__c,Country__c,
                       Commissioning_Charges__c,City__c,CGST__c,CGST_Amount__c,
                       Building_No_Street__c,Amount_Received__c,SGST__c,SGST_Amount__c,
                       Balance_Amount__c FROM Proforma_Invoice__c WHERE id = :id];
        totalPages = InvoiceList.size();
             currentPageIndex = 0;
        
         QLI = [SELECT Product_Name__c,Category1__c, Quantity__c, Final_Price_Final_Price__c, Unit_Price__c, RowNumber__c
    FROM Quote_Line_Item__c WHERE Quotes__r.Proforma_Invoice__c = :id];
        
        for (INTEGER I = 0; I < QLI.size(); I++) {
            QLI[I].RowNumber__c = I + 1;
        }

        
        ORDL = [SELECT Name,Orders__r.Name, Productes__r.Products__c,Product_Description__c, Quantity__c, Final_Price_After_Discount__c, Unit_Rate__c, Value__c,Serial_No__c,Orders__r.Proforma_Invoice__r.Orders__r.Name,Productes__c,Machine_Name__c
                 FROM Order_Line_Item__c WHERE Orders__c IN (SELECT Orders__c 
                  FROM Proforma_Invoice__c WHERE Id = :id)];
        
        for (INTEGER S = 0; S < ORDL.size(); S++) {
            ORDL[S].Serial_No__c = S + 1;
        }
    }
        public static Proforma_Invoice__c getCurrentInvoiceReport() {
        if (currentPageIndex >= 0 && currentPageIndex < InvoiceList.size()) {
            return InvoiceList[currentPageIndex];
        }
        return null;
    }
      public PageReference next() {
        if (currentPageIndex < totalPages - 1) {
            currentPageIndex++;
        }
        return null; // Return a PageReference to stay on the same page
    }
        public PageReference previous() {
        if (currentPageIndex > 0) {
            currentPageIndex--;
        }
        return null; // Return a PageReference to stay on the same page
    }
    public PageReference save() {
    Proforma_Invoice__c currentInvoice = getCurrentInvoiceReport();
    if (currentInvoice != null && id != null) {
        Blob pdfBlob = generatePdfContent(currentInvoice.Id);

        if (pdfBlob != null) {
            Datetime timestamp = System.now();
            String pdfFileName = 'Invoice_' + timestamp + '.pdf';
            savePdfAsAttachment(currentInvoice.Id, pdfFileName, pdfBlob);
            
            System.debug('Attachment saved successfully.');
        } else {
            System.debug('PDF Blob is null.');
        }
    } else {
        System.debug('Current Invoice or Id is null.');
    }
        
        /*PageReference recordDetailPage = new PageReference('/' + currentInvoice.Id);
    recordDetailPage.setRedirect(true);
    return recordDetailPage;
    }


    // Add a null check for currentInvoice before accessing its Id
    PageReference recordDetailPage = (currentInvoice != null) ? new PageReference('/' + + currentInvoice.Id) : null;

    if (recordDetailPage != null) {
        recordDetailPage.setRedirect(true);
    }

    return recordDetailPage;
}



 //  @TestVisible private static Blob generatePdfContent(Id InvoiceId) {
        private Blob generatePdfContent(Id InvoiceId) {
        PageReference pdfPage = Page.InvoicePage;
        pdfPage.getParameters().put('id', InvoiceId);
        return pdfPage.getContentAsPDF();
    }

    //@TestVisible private static void savePdfAsAttachment(Id InvoiceId, String pdfFileName, Blob pdfBlob) {
       private void savePdfAsAttachment(Id InvoiceId, String pdfFileName, Blob pdfBlob) {
    try {
        Attachment attachment = new Attachment();
        attachment.ParentId = InvoiceId;
        attachment.Name = pdfFileName;
        attachment.Body = pdfBlob;
        insert attachment;
    } catch (Exception e) {
        System.debug('Exception occurred while saving attachment: ' + e.getMessage());
    }
}
}*/