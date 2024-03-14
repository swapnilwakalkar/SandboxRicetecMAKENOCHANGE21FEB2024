public class PDFInvoicePage {
    public Id id { get; set; }
    public List<Proforma_Invoice__c> InvoiceList { get; set; }
    public List<Quote_Line_Item__c> QLI {get;set;}
    public List<Order_Line_Item__c>ORDL{get;set;}
    public Integer currentPageIndex { get; set; }
    public Integer totalPages { get; set; }
    public String Invoicecaller { get; set; }
    
    public PDFInvoicePage(ApexPages.StandardController controller) {
        SET<id>qSet = new SET<id>();
        id = controller.getId();
        
        InvoiceList = [SELECT Id,Total_Charges__c,State__c,Validity__c,
                       Customer_Name__c,Village__c,Warranty__c,
                       Total_Amount__c,Sub_Total__c,Name,Freight__c,
                       Packing_Charges_Amount__c,Delivery__c,Price__c,
                       Packing_Charges__c,Orders__c,Invoice_Number__c,Payment__c,
                       Insurance_Amount__c,Insurance__c,GST_Amount__c,Sales_Tax__c,
                       GST__c,Grand_Amount__c,Forwarding_Charges_Amount__c,
                       Forwarding_Charges__c,District__c,Country__c,Forwarding__c,
                       Commissioning_Charges__c,City__c,CGST__c,CGST_Amount__c,Quotation__c,
                       Building_No_Street__c,Amount_Received__c,SGST__c,SGST_Amount__c,
                       Balance_Amount__c FROM Proforma_Invoice__c WHERE id = :id];
        totalPages = InvoiceList.size();
        currentPageIndex = 0;
        for(Proforma_Invoice__c pp :InvoiceList){
            qSet.add(pp.Quotation__c);
        }
        
        QLI = [SELECT ProductName__c,Product_Name__c, Quantity__c,RowNumber__c,FinalF__c,Calculated_Unit_Price__c
               FROM Quote_Line_Item__c WHERE Quotes__c=:qSet];
        
        for (INTEGER I = 0; I < QLI.size(); I++) {
            QLI[I].RowNumber__c = I + 1;
        }
        
        ORDL = [SELECT Name,Orders__r.Name,Product_Description__c, Quantity__c, Final_Price_After_Discount__c, Unit_Rate__c, Value__c,Serial_No__c,Orders__r.Proforma_Invoice__r.Orders__r.Name,Productes__c,Machine_Name__c
                FROM Order_Line_Item__c WHERE Orders__c IN (SELECT Orders__c FROM Proforma_Invoice__c WHERE Id = :id)];
        
        for (INTEGER S = 0; S < ORDL.size(); S++) {
            ORDL[S].Serial_No__c = S + 1;
        }
        Invoicecaller = ApexPages.currentPage().getParameters().get('id');
    }
    
    public String formattedSubtotal {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal Subtotal = InvoiceList[0].Sub_Total__c;
                return formatIndianCurrency(Subtotal);
            }
            return null;
        }
        }
    public String formattedPackingCharges {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal PackingCharges = InvoiceList[0].Packing_Charges_Amount__c;
                return formatIndianCurrency(PackingCharges);
            }
            return null;
        }
        }
    public String formattedForwardingCharges {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal ForwardingCharges = InvoiceList[0].Forwarding_Charges_Amount__c;
                return formatIndianCurrency(ForwardingCharges);
            }
            return null;
        }
        }
    public String formattedCommissioningCharges {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal CommissioningCharges = InvoiceList[0].Commissioning_Charges__c;
                return formatIndianCurrency(CommissioningCharges);
            }
            return null;
        }
        }
    public String formattedInsuranceAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal InsuranceAmount = InvoiceList[0].Insurance_Amount__c;
                return formatIndianCurrency(InsuranceAmount);
            }
            return null;
        }
        }
    public String formattedTotalCharges {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal TotalCharges = InvoiceList[0].Total_Charges__c;
                return formatIndianCurrency(TotalCharges);
            }
            return null;
        }
        }
    public String formattedGSTAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal GSTAmount = InvoiceList[0].GST_Amount__c;
                return formatIndianCurrency(GSTAmount);
            }
            return null;
        }
        }
        public String formattedCGSTAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal CGSTAmount = InvoiceList[0].CGST_Amount__c;
                return formatIndianCurrency(CGSTAmount);
            }
            return null;
        }
        }
        public String formattedSGSTAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal SGSTAmount = InvoiceList[0].SGST_Amount__c;
                return formatIndianCurrency(SGSTAmount);
            }
            return null;
        }
        }
    public String formattedGrandAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal GrandAmount = InvoiceList[0].Grand_Amount__c;
                return formatIndianCurrency(GrandAmount);
            }
            return null;
        }
        }
    public String formattedAmountReceived {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal AmountReceived = InvoiceList[0].Amount_Received__c;
                return formatIndianCurrency(AmountReceived);
            }
            return null;
        }
        }
    public String formattedBalanceAmount {
        get {
            if (InvoiceList != null && InvoiceList.size() > 0) {
                Decimal BalanceAmount= InvoiceList[0].Balance_Amount__c;
                return formatIndianCurrency(BalanceAmount);
            }
            return null;
        }
        }

    
    Public String formatIndianCurrency(Decimal amount) {
        if (amount != null) {
            String formattedAmount = amount.setScale(2).format();
            return formattedAmount;
        } else {
            return null;
        }
    }    
    public Proforma_Invoice__c getCurrentInvoiceReport() {
        if (currentPageIndex >= 0 && currentPageIndex < InvoiceList.size()) {
            return InvoiceList[currentPageIndex];
        }
        return null;
    }
     public PageReference next() {
        if (currentPageIndex < totalPages) {
            currentPageIndex++;
        }return null;
    }
    public PageReference previous() {
        if (currentPageIndex > 0) {
            currentPageIndex--;
        }return null;
    }
    
    public PageReference save() {
        Proforma_Invoice__c currentInvoice = getCurrentInvoiceReport();
        if(!test.isRunningTest()){   
            if (currentInvoice != null && id != null) {
                Blob pdfBlob = generatePdfContent(currentInvoice.Id);
                
                if (pdfBlob != null) {
                    Datetime timestamp = System.now();
                    String pdfFileName = 'Invoice_' + timestamp + '.pdf';
                    savePdfAsAttachment(currentInvoice.Id, pdfFileName, pdfBlob);
                }
            }
            
        }else{
            if (currentInvoice != null && id != null) {
                blob pdfBlob = blob.valueof('TEST');
                if (pdfBlob != null) {
                    Datetime timestamp = System.now();
                    String pdfFileName = 'Invoice_' + timestamp + '.pdf';
                    pdfBlob = blob.valueof('TEST');
                    savePdfAsAttachment(currentInvoice.Id, pdfFileName, pdfBlob);
                }
            }
        }
        PageReference recordDetailPage = new PageReference('/' + currentInvoice.Id);
        recordDetailPage.setRedirect(true);
        return recordDetailPage;
    }
    
    public Blob generatePdfContent(Id Invoicecaller) {
        if (Test.isRunningTest()) {
            // Return a dummy Blob for testing
            return Blob.valueOf('TEST');
        }
        PageReference pdfPage = Page.PDFInvoice2;
        pdfPage.getParameters().put('id', Invoicecaller);
        return pdfPage.getContentAsPDF();
    }
    
    public void savePdfAsAttachment(Id Invoicecaller, String pdfFileName, Blob pdfBlob) {
        Attachment attachment = new Attachment();
        attachment.ParentId = Invoicecaller;
        attachment.Name = pdfFileName;
        attachment.Body = pdfBlob;
        attachment.ContentType = 'application/pdf';
        insert attachment;
    }
}