public class OrderAttachment {/*
    public Id id { get; set; }
    public List<Order__c> OrderList {get;set;}
    public List<Order_Line_Item__c>ORDL{get;set;}
    public Integer currentPageIndex {get;set;}
    public Integer totalPages { get; set; }
   
    public OrderAttachment(ApexPages.StandardController controller) {
        id = controller.getId();
        OrderList = [SELECT Id, SL_No__c,Village__c,Transportation_Charges__c,Transit_Insurance_Amount__c,Transit_Insurance__c,Supplier_Name__c,SGST__c,State__c,Sub_Total__c,SGST_Amount__c,Second_Concern_Person__c,Advance__c,Balance__c,Basic_Order_Value__c,Building_No_Street__c,CGST__c,CGST_Amount__c,  City__c,Commissioning_Charges__c, Country__c,Customer_Name__c,Date__c,District__c,  Email__c,   Engineering_Charges__c,FAX_No__c,First_Concern_Person__c,Forwarding_Charge__c,Forwarding_Charges__c,Grand_Amount__c,GST_No__c,  IGST__c,IGST_Amount__c,Old_Price__c,Name,Package_Charges__c,    Packing_Charges__c,Phone__c,Phone_1__c,Product_Code__c,Proforma_Invoice__c, Quanity__c,Quotes__c,Remarks__c FROM Order__c WHERE id = :id];
             
        totalPages = OrderList.size();
        currentPageIndex = 0;
        ORDL = new List<Order_Line_Item__c>();
       
         Set<Id> ORDlIds = new Set<Id>();
        for (Order__c OrderRecord : OrderList) {
            ORDlIds.add(OrderRecord.Id);
        }
 
       
        ORDL = [SELECT Name, Orders__r.Name, Productes__r.Products__c, Product_Description__c, Quantity__c, Final_Price_After_Discount__c, Unit_Rate__c, Value__c, Serial_No__c, Orders__r.Proforma_Invoice__r.Orders__r.Name, Productes__c, Machine_Name__c FROM Order_Line_Item__c WHERE Orders__c IN :ORDlIds];
 
       generateSerialNumbers();
    }
 
    private void generateSerialNumbers() {
        for (Integer i = 0; i < ORDL.size(); i++) {
            ORDL[i].Serial_No__c = currentPageIndex * 10 + i + 1;
        }
    }
    public Order__c getCurrentOrderReport() {
        if (currentPageIndex >= 0 && currentPageIndex < OrderList.size()) {
            return OrderList[currentPageIndex];
        }
        return null;
    }
    public PageReference next() {
    if (currentPageIndex < totalPages-1) {
        currentPageIndex++;
    }
    return null;
    }
    public PageReference previous() {
    if (currentPageIndex > 0) {
        currentPageIndex--;
    }
    return null;
    }
    public PageReference save() {
        Order__c orderrep = getCurrentOrderReport();
        if (orderrep != null && id != null) {
            Blob pdfBlob = generatePdfContent(orderrep.Id);
            if (pdfBlob != null) {
                String pdfFileName = 'GeneratedPDF.pdf';
                savePdfAsAttachment(orderrep.Id, pdfFileName, pdfBlob);
            }
        }
        PageReference recordDetailPage = new PageReference('/' + orderrep.Id);
        recordDetailPage.setRedirect(true);
        return recordDetailPage;
    }
    private Blob generatePdfContent(Id orderID) {
        PageReference pdfPage = Page.OrderAttachmentPage;
        pdfPage.getParameters().put('id', orderID);
        return pdfPage.getContentAsPDF();
    }
 
    private void savePdfAsAttachment(Id orderID, String pdfFileName, Blob pdfBlob) {
        Attachment attachment = new Attachment();
        attachment.ParentId = orderID;
        attachment.Name = pdfFileName;
        attachment.Body = pdfBlob;
        insert attachment;
    }*/
}