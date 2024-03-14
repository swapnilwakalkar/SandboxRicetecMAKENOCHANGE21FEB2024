public class QuotepController {
    public Id id { get; set; }
    public List<Quotes__c> quote { get; set; }
    
    public List<Quote_Line_Item__c> op { get; set; }
    public ApexPages.StandardSetController controller { get; set; }
    
    public QuotepController(ApexPages.StandardController stdController) {
        Id quoteId = stdController.getId();
        quote = [SELECT Id, Account_Name__c,  GSTIN__c,Date__c, BillingStreet__c, BillToName__c,Price__c, Forwarding__c, Sales_Tax__c, Payment__c,
                 Commissioning_Charges__c, Phone__c, Contact_Name__c,Contact_Name2__c, Village__c, Mandal__c, District__c, Territory__c, BillingZipPostalCode__c,
                 BillingCity__c, BillingStateProvince__c, BillingCountry__c,IGST__c,IGST_Amount__c, CGST__c, SGST__c, SGST_Amount__c, SGST_Amount_Final__c,
                 Description__c, Email__c, Fax__c, Forwarding_Charges__c, Forwarding_Charges_Amount__c, Grand_Total__c, PackingCharge__c, ForwardingCharge__c,
                 Opportunity_Name__c, Packing_Charges__c, Packing_Charges_Amount__c, Name, Quote_Number__c, Ship_To__c, QuotedQQ__c, FinalFF__c,Total_PowerPP__c,
                 Ship_To_Name__c, Status__c, Packing_Charges_AmountF_c__c, Delivery__c, Freight__c, Warranty__c, Validity__c, Note__c,
                 Forwarding_Charges_AmountF_c__c, Transit_Insurance_ChargesF_c__c, Machine_Required__c, Total_CostF_c__c, GST_AmountF_c__c,
                 Total_Commissioning_Charges__c, Grand_TotalF_c__c, Total_Cost__c, Transit_Insurance__c,
                 Transit_Insurance_Charges__c FROM Quotes__c WHERE id=:quoteId];
        controller = new ApexPages.StandardSetController(quote);
        controller.setPageSize(1); // Set the desired page size for pagination if needed
                    
                                                           

        // Retrieve the unique set of Product IDs from the Quote records
        Set<Id> oppoIds = new Set<Id>();
        for (Quotes__c quoteRecord : quote) {
            oppoIds.add(quoteRecord.Id);
        }
        
        
        // Query the Product_Line_Item__c records related to the unique set of Product IDs
        op = [SELECT Id, Name, Product_Name__c, Product__r.Name, Quantity__c, RowNumber__c, Calculated_Unit_Price__c, Unit_Price__c, Discount__c, QuotedQ__c, FinalF__c,
               PowerHP__c, ProductName__c, Discounted_Unit_Price__c FROM Quote_Line_Item__c
               WHERE Quotes__c IN:oppoIds];
        
          
        for (Quote_Line_Item__c item : op) {
        System.debug('Products__r.Name value: ' +item.Product__r.Name);
}
        
        for (Integer i = 0; i < op.size(); i++) {
            op[i].RowNumber__c = i + 1;
        }
        }
    
    public String Subcost {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal FinalValue = quote[0].FinalFF__c;
                return formatIndianCurrency(FinalValue);
            }
            return null;
        }
        }
    
    
    public String packingchargeper {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal packingchargep = quote[0].Packing_Charges_AmountF_c__c;
                return formatIndianCurrency(packingchargep);
            }
            return null;
        }
        }
    public String Forwardingcharges {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal forwardingcharge = quote[0].ForwardingCharge__c;
                return formatIndianCurrency(forwardingcharge);
            }
            return null;
        }
        }
    public String Forwardingchargeper {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal forwardingchargep = quote[0].Forwarding_Charges_AmountF_c__c;
                return formatIndianCurrency(forwardingchargep);
            }
            return null;
        }
        }
    public String commissioning {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal commision = quote[0].Total_Commissioning_Charges__c;
                return formatIndianCurrency(commision);
            }
            return null;
        }
        }
    public String Total {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal totalcost = quote[0].Total_CostF_c__c;
                return formatIndianCurrency(totalcost);
            }
            return null;
        }
        }
    public String transient {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal transientcost = quote[0].Transit_Insurance_ChargesF_c__c;
                return formatIndianCurrency(transientcost);
            }
            return null;
        }
        }
    public String IGST {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal IGSTcost = quote[0].GST_AmountF_c__c;
                return formatIndianCurrency(IGSTcost);
            }
            return null;
        }
        }
    public String CGST {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal CGSTcost = quote[0].SGST_Amount_Final__c;
                return formatIndianCurrency(CGSTcost);
            }
            return null;
        }
        }
    public String SGST {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal SGSTcost = quote[0].SGST_Amount_Final__c;
                return formatIndianCurrency(SGSTcost);
            }
            return null;
        }
        }
    public String GrandTotal {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal grandcost = quote[0].Grand_TotalF_c__c;
                return formatIndianCurrency(grandcost);
            }
            return null;
        }
        }
    public String Quoted {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal Quotedp = quote[0].QuotedQQ__c;
                return formatIndianCurrency(Quotedp);
            }
            return null;
        }
        }
    public String pack {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal packcharge = quote[0].PackingCharge__c;
                return formatIndianCurrency(packcharge);
            }
            return null;
        }
        }
    public String packchargeper {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal packchargeq = quote[0].Packing_Charges_Amount__c;
                return formatIndianCurrency(packchargeq);
            }
            return null;
        }
        }
    
    public String Forwardingchargeamount {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal Forwardchar = quote[0].Forwarding_Charges_Amount__c;
                return formatIndianCurrency(Forwardchar);
            }
            return null;
        }
        }
    public String commisionquote {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal commisionquo = quote[0].Total_Commissioning_Charges__c;
                return formatIndianCurrency(commisionquo);
            }
            return null;
        }
        }
    public String Totalcostquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal costquo = quote[0].Total_Cost__c;
                return formatIndianCurrency(costquo);
            }
            return null;
        }
        }
    public String transientquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal transquo = quote[0].Transit_Insurance_Charges__c;
                return formatIndianCurrency(transquo);
            }
            return null;
        }
        }
    public String IGSTquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal igstquo = quote[0].IGST_Amount__c;
                return formatIndianCurrency(igstquo);
            }
            return null;
        }
        }
    public String CGSTquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal cgstquo = quote[0].SGST_Amount__c;
                return formatIndianCurrency(cgstquo);
            }
            return null;
        }
        }
    public String SGSTquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal sgstquo = quote[0].SGST_Amount__c;
                return formatIndianCurrency(sgstquo);
            }
            return null;
        }
        }
    public String GrandTotalquo {
        get {
            if (quote != null && quote.size() > 0) {
                Decimal grandquo = quote[0].Grand_Total__c;
                return formatIndianCurrency(grandquo);
            }
            return null;
        }
        }
   public String formatIndianCurrency(Decimal amount) {
        String formattedAmount = amount.setScale(2).format();
        return formattedAmount;
    }
    
    public PageReference pdf() {
        if (quote.isEmpty()) {
            return null; // No Quotes to generate PDF
        }
        
        // Retrieve the first Quote from the list
        Quotes__c quo = quote[0];
        
        PageReference pdfPage = Page.QuotationPDF;
        pdfPage.getParameters().put('id', quo.Id);
       
         blob pdfBlob;
        if(Test.isRunningTest()) { 
          pdfBlob = blob.valueOf('Unit.Test');
        } else {
          pdfBlob = pdfPage.getContentAsPDF();
        }
        // Create the email attachment
        /*  Messaging.EmailFileAttachment qo = new Messaging.EmailFileAttachment();
qo.setFileName('quote.pdf');
qo.setBody(pdfBlob);

// Retrieve the email address from the Quote record
String[] toAddresses = new String[]{quo.Email__c};

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setSubject('Quote Attachment');
mail.setHtmlBody('Please find the attached Quotation.');
mail.setToAddresses(toAddresses);
mail.setFileAttachments(new Messaging.EmailFileAttachment[] {qo});

// Send the email
Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
--*/
        PageReference pageRef = new PageReference('/' + quo.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}