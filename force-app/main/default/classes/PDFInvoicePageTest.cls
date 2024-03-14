@isTest
public class PDFInvoicePageTest {
    
    @isTest
    static void testPDFInvoicePage() {
        
        Proforma_Invoice__c testInvoice = new Proforma_Invoice__c();
        insert testInvoice;
      
        ApexPages.StandardController standardController = new ApexPages.StandardController(testInvoice);
        
        PDFInvoicePage pdfInvoicePage = new PDFInvoicePage(standardController);
                
        pdfInvoicePage.next();
        System.assertEquals(1, pdfInvoicePage.currentPageIndex, 'Next method should increment currentPageIndex');
        pdfInvoicePage.previous();
        System.assertEquals(0, pdfInvoicePage.currentPageIndex, 'Previous method should decrement currentPageIndex');

        
        Test.startTest();
        PageReference pageRef = pdfInvoicePage.save();
        Test.stopTest();
        
        System.assertNotEquals(null, pageRef);
        
        Attachment testAttachment = [SELECT Id FROM Attachment WHERE ParentId = :testInvoice.Id LIMIT 1];
        System.assertNotEquals(null, testAttachment);
    }    
    @isTest
    static void testPDFInvoicePageSavePdfAsAttachment() {
        Proforma_Invoice__c testInvoice = new Proforma_Invoice__c();
        insert testInvoice;
        
        Blob testPdfBlob = Blob.valueOf('Test PDF Content');
        
        ApexPages.StandardController standardController = new ApexPages.StandardController(testInvoice);
        
        PDFInvoicePage pdfInvoicePage = new PDFInvoicePage(standardController);
        
        Test.startTest();
        pdfInvoicePage.savePdfAsAttachment(testInvoice.Id, 'TestFileName.pdf', testPdfBlob);
        Test.stopTest();
      
    }
    @isTest
    static void testPDFInvoicePageGeneratePdfContent() {
        
        Proforma_Invoice__c testInvoice = new Proforma_Invoice__c();
        insert testInvoice;
        
        ApexPages.StandardController standardController = new ApexPages.StandardController(testInvoice);
        
        PDFInvoicePage pdfInvoicePage = new PDFInvoicePage(standardController);
        
        Test.startTest();
        Blob pdfBlob = pdfInvoicePage.generatePdfContent(testInvoice.Id);
        Test.stopTest();
        
        System.assertNotEquals(null, pdfBlob);
    }
        @isTest
    static void formattedSubTotal() {
        Proforma_Invoice__c testerInvoice = new Proforma_Invoice__c();
        insert testerInvoice;

        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testerInvoice));

        String testFormattedValue = controller.formattedSubTotal;
        System.assertEquals(null, testFormattedValue, 'Unexpected currency formatting');    
    }
        @isTest
    static void formattedPackingCharges() {
        Proforma_Invoice__c TestingInvoice = new Proforma_Invoice__c(Packing_Charges__c = 500000.00);
        insert TestingInvoice;

        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(TestingInvoice));
        
        System.assertNotEquals(null, controller.formattedPackingCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals('0', controller.formattedPackingCharges,'Unexpected currency formatting');
    }
        @isTest
    static void testFormattedCommissioningCharges() {
        Proforma_Invoice__c TestingInvoice = new Proforma_Invoice__c(Commissioning_Charges__c = 500000.00);
        insert TestingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(TestingInvoice));
        
        System.assertNotEquals(null, controller.formattedCommissioningCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals('5,00,000', controller.formattedCommissioningCharges,'Unexpected currency formatting');
    }
    @isTest
        static void formattedForwardingCharge() {
        Proforma_Invoice__c TestingInvoice = new Proforma_Invoice__c();
        insert TestingInvoice;
            
            PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(TestingInvoice));
        controller.InvoiceList = [SELECT Id,Forwarding_Charges_Amount__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];

        String testFormattedValue = controller.formattedForwardingCharges;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting'); 
    }
        @isTest
    static void formattedTransitInsuranceAmount() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,Insurance_Amount__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedTransitInsuranceAmount = controller.formattedInsuranceAmount;
        System.assertEquals('0', testformattedTransitInsuranceAmount, 'Unexpected currency formatting');
    }
           @isTest
    static void testformattedTotalCharges() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,Total_Charges__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedTotalCharges = controller.formattedTotalCharges;
        System.assertEquals('7,500', testformattedTotalCharges, 'Unexpected currency formatting');
    }       
    @isTest
    static void formattedGSTAmount() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,GST_Amount__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedGSTAmount = controller.formattedGSTAmount;
        System.assertEquals('0', testformattedGSTAmount, 'Unexpected currency formatting');
    }
           @isTest
    static void formattedGrandAmount() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,Grand_Amount__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedGrandAmount = controller.formattedGrandAmount;
        System.assertEquals('7,500', testformattedGrandAmount, 'Unexpected currency formatting');
    }
           @isTest
    static void formattedAmountReceived() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,Amount_Received__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedAmountReceived = controller.formattedAmountReceived;
        System.assertEquals(null, testformattedAmountReceived, 'Unexpected currency formatting');
    }
           @isTest
    static void formattedBalanceAmount() {
        Proforma_Invoice__c testingInvoice = new Proforma_Invoice__c();
        insert testingInvoice;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testingInvoice));
        controller.InvoiceList = [SELECT Id,Balance_Amount__c FROM Proforma_Invoice__c WHERE Id = :testingInvoice.Id LIMIT 1];
        
        String testformattedBalanceAmount = controller.formattedBalanceAmount;
        System.assertEquals('7,500', testformattedBalanceAmount, 'Unexpected currency formatting');
    }
    
        @isTest
    static void testformatIndianCurrency() {
        Decimal testAmount = 10000.50;
        Proforma_Invoice__c testInv = new Proforma_Invoice__c();
        insert testInv;
        
        PDFInvoicePage controller = new PDFInvoicePage(new ApexPages.StandardController(testInv));
        controller.InvoiceList = [SELECT Id FROM Proforma_Invoice__c WHERE Id = :testInv.Id LIMIT 1];
        
        String formattedValue = controller.formatIndianCurrency(testAmount);
        System.assertEquals('10,000.5', formattedValue, 'Unexpected currency formatting');
    }  

}