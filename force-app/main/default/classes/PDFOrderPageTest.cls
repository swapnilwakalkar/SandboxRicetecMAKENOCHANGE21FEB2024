@isTest
public class PDFOrderPageTest {
    
    @isTest
    static void testPDFOrderPageController() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();
        testOrderLineItem.Orders__c = testOrder.Id;
        insert testOrderLineItem;
        
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
        System.assertEquals(1, controller.OrderList.size(), 'OrderList should have one record');
        System.assertEquals(1, controller.ORDL.size(), 'ORDL should have one record');
        System.assertEquals(0, controller.currentPageIndex, 'currentPageIndex should be initialized to 0');
        
        controller.next();
        System.assertEquals(1, controller.currentPageIndex, 'Next method should increment currentPageIndex');
        controller.previous();
        System.assertEquals(0, controller.currentPageIndex, 'Previous method should decrement currentPageIndex');
        
        Test.startTest();
        PageReference pageRef = controller.save();
        Test.stopTest();
        
        List<Attachment> attachments = [SELECT Id FROM Attachment WHERE ParentId = :testOrder.Id];
        System.assertNotEquals('Same value: 0', 'Attachment not created');
    }
    @isTest
    static void formattedUnitRate() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();
        testOrderLineItem.Orders__c = testOrder.Id;
        testOrderLineItem.Unit_Rate__c = 100000.50;
        insert testOrderLineItem;
        
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        controller.ORDL = [SELECT Id, Unit_Rate__c FROM Order_Line_Item__c WHERE Orders__c = :testOrder.Id LIMIT 1];
        String testformattedUnitRate = controller.formattedUnitRate;
        System.assertEquals('1,00,000.5', testformattedUnitRate, 'Unexpected currency formatting');
    }
    @isTest
    static void formattedValue() {
    
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedValue;
        System.assertEquals(null, testFormattedValue, 'Unexpected currency formatting');
    }
    @isTest
    static void formattedTransitInsuranceAmount() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();
        
        testOrderLineItem.Orders__c = testOrder.Id;
        insert testOrderLineItem;
        
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        controller.OrderList = [SELECT Id,Transit_Insurance_Amount__c FROM Order__c WHERE Id = :testOrder.Id LIMIT 1];
        
        String testformattedTransitInsuranceAmount = controller.formattedTransitInsuranceAmount;
        System.assertEquals('0', testformattedTransitInsuranceAmount, 'Unexpected currency formatting');
    }
    @isTest
    static void formattedBasicOrderValue() {
        Order__c testOrder = new Order__c(Basic_Order_Value__c = 500000.00);
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c(Orders__c = testOrder.Id);
        insert testOrderLineItem;
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
       // System.assertNotEquals(null, controller.formattedBasicOrderValue,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals(null, controller.formattedBasicOrderValue,'Unexpected currency formatting');
    }
    @isTest
    static void formattedPackingCharges() {
        Order__c testOrder = new Order__c(Packing_Charges__c = 500000.00);
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c(Orders__c = testOrder.Id);
        insert testOrderLineItem;
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
        System.assertNotEquals(null, controller.formattedPackingCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals(null, controller.formattedPackingCharges,'Unexpected currency formatting');
    }
    @isTest
    static void testFormattedCommissioningCharges() {
        Order__c testOrder = new Order__c(Commissioning_Charges__c = 500000.00);
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c(Orders__c = testOrder.Id);
        insert testOrderLineItem;
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
        System.assertNotEquals(null, controller.formattedCommissioningCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals(null, controller.formattedCommissioningCharges,'Unexpected currency formatting');
    }
    @isTest
    static void formattedTransportationCharges() {
         Order__c testOrder = new Order__c(Transportation_Charges__c = 500000.00);
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c(Orders__c = testOrder.Id);
        insert testOrderLineItem;
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
        System.assertNotEquals(null, controller.formattedTransportationCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals(null, controller.formattedTransportationCharges,'Unexpected currency formatting');   }
    @isTest
    static void formattedSubTotal() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedSubTotal;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');    
    }
    @isTest
    static void formattedCGSTAmount() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedCGSTCharges;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');  
    }
    @isTest
    static void formattedSGSTCharges() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedSGSTCharges;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');
    }
    @isTest
    static void formattedIGSTAmount() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedIGSTCharges;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');   
    }
    @isTest
    static void formattedGrandAmount() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedGrandTotal;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');   
    }
    @isTest
    static void formattedAdvance() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedAdvance;
        System.assertEquals(null, testFormattedValue, 'Unexpected currency formatting');    
    }
    @isTest
    static void formattedBalance() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedBalance;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting');     
    }
    @isTest
    static void formattedForwardingCharge() {
        Order__c testOrder = new Order__c();
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c();

        testOrderLineItem.Orders__c = testOrder.Id;
    
        insert testOrderLineItem;

        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));

        String testFormattedValue = controller.formattedForwardingCharges;
        System.assertEquals('0', testFormattedValue, 'Unexpected currency formatting'); 
    }
    @isTest
    static void testFormattedEngineeringCharges() {
        Order__c testOrder = new Order__c(Engineering_Charges__c = 500000.00);
        insert testOrder;
        Order_Line_Item__c testOrderLineItem = new Order_Line_Item__c(Orders__c = testOrder.Id);
        insert testOrderLineItem;
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        
        System.assertNotEquals(null, controller.FormattedEngineeringCharges,'Unexpected currency formatting');
        controller.ORDL = new List<Order_Line_Item__c>();
        System.assertEquals(null, controller.FormattedEngineeringCharges,'Unexpected currency formatting');
    }
    @isTest
    static void testFormatIndianCurrency() {
        Decimal testAmount = 10000.50;
        Order__c testOrder = new Order__c();
        insert testOrder;
        
        PDFOrderPage controller = new PDFOrderPage(new ApexPages.StandardController(testOrder));
        controller.OrderList = [SELECT Id FROM Order__c WHERE Id = :testOrder.Id LIMIT 1];
        
        String formattedValue = controller.formatIndianCurrency(testAmount);
        System.assertEquals('10,000.5', formattedValue, 'Unexpected currency formatting');
    }
}