@isTest
public class TestQuotepController {

    @isTest
    static void testQuotepController() {
        // Create a test Quotes__c record
        Quotes__c testQuote = new Quotes__c(Name='Suyog');
        insert testQuote;

        // Create a test Quote_Line_Item__c record related to the test Quote
        Quote_Line_Item__c testQuoteLineItem = new Quote_Line_Item__c(
            Quotes__c = testQuote.Id /* populate other necessary fields */
        );
        insert testQuoteLineItem;

        // Set the quote for the QuotepController to use
        //QuotepController.quote = [SELECT Id FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

        // Instantiate the controller with the StandardController
        ApexPages.StandardController stdController = new ApexPages.StandardController(testQuote);
        QuotepController controller = new QuotepController(stdController);

        // Call the pdf() method
        PageReference pdfPageRef = controller.pdf();

        // Verify that the PageReference is not null
        System.assertNotEquals(null, pdfPageRef);

        // Add additional assertions as needed to cover more code paths

        // Example: Simulate a page parameter
        Test.setCurrentPageReference(Page.QuotationPDF);
        ApexPages.currentPage().getParameters().put('id', testQuote.Id);

        // Call pdf() again to cover the code for generating PDF content
        PageReference pdfPageRef2 = controller.pdf();

        // Verify that the PageReference is not null
        System.assertNotEquals(null, pdfPageRef2);

        // Add assertions to verify other behaviors as needed
    }


     @isTest
static void testFormatIndianCurrency() {
    // Adjust the value as needed
    Decimal testAmount = 10000.50;

    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    String formattedValue = controller.formatIndianCurrency(testAmount);

    // Add assertions to validate the formattedValue
    //System.assertEquals('10,000.50', formattedValue);
}
    
    @isTest
static void testSubcostProperty() {
    // Create a test Quotes__c record
    
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, FinalFF__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String subcostValue = controller.Subcost;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValueForSubcost', subcostValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}

@isTest
static void testpackingchargeperProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Packing_Charges_AmountF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String packingchargeperValue = controller.packingchargeper;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValueForPackingCharge', packingchargeperValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}
    @isTest
static void testForwardingchargesProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, ForwardingCharge__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    //String ForwardingchargesValue = controller.Forwardingcharges;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValueForForwarding', ForwardingchargesValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}
    @isTest
static void testForwardingchargeperProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Forwarding_Charges_AmountF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String ForwardingchargeperValue = controller.Forwardingchargeper;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValueForForwardingCharge', ForwardingchargeperValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}
  @isTest
static void testcommissioningProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Total_Commissioning_Charges__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String commissioningValue = controller.commissioning;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValueForCommisioning', commissioningValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}  
    @isTest
static void testTotalProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Total_CostF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String TotalValue = controller.Total;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', TotalValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}  
    @isTest
static void testtransientProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Transit_Insurance_ChargesF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String transientValue = controller.Transient;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', transientValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}  
  @isTest
static void testIGSTProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, GST_AmountF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String IGSTValue = controller.iGST;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', IGSTValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}    
    @isTest
static void testCGSTProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, SGST_Amount_Final__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String CGSTValue = controller.cGST;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', CGSTValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}    
   @isTest
static void testSGSTProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, SGST_Amount_Final__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String SGSTValue = controller.sGST;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', SGSTValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}   
   @isTest
static void testGrandTotalProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Grand_TotalF_c__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String GrandTotalValue = controller.grandTotal;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', GrandTotalValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}   
    @isTest
static void testQuotedProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, QuotedQQ__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String QuotedValue = controller.quoted;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', QuotedValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value
}   
  @isTest
static void testpackProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, PackingCharge__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Pack property
    //String packValue = controller.Pack;

    // Add assertions to validate the Pack value
    //System.assertEquals('ExpectedFormattedValue', packValue); 
    // Replace 'ExpectedFormattedValue' with the actual expected formatted value

    // Additional assertions can be added based on your specific requirements

    // Example: Assert that the Pack value matches the PackingCharge__c field in the quote
    //System.assertEquals(controller.quote.PackingCharge__c, packValue);

    // Example: Assert that the Pack value is not null
    //System.assertNotEquals(null, packValue);
}
   
   @isTest
static void testpackchargeperProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Packing_Charges_Amount__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String packchargeperValue = controller.Packchargeper;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', packchargeperValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}    
  


   @isTest
static void testForwardingchargeamountProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Forwarding_Charges_Amount__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String ForwardingchargeamountValue = controller.forwardingchargeamount;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', ForwardingchargeamountValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}  
   @isTest
static void testcommisionquoteProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Total_Commissioning_Charges__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String commisionquoteValue = controller.Commisionquote;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', commisionquoteValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}   
  @isTest
static void testTotalcostquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Total_Cost__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String TotalcostquoValue = controller.totalcostquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', TotalcostquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}   
	@isTest
static void testtransientquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Transit_Insurance_Charges__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String transientquoValue = controller.Transientquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', transientquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}      
	@isTest
static void testIGSTquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, IGST_Amount__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String IGSTquoValue = controller.iGSTquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', IGSTquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}        
  @isTest
static void testCGSTquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, SGST_Amount__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String CGSTquoValue = controller.cGSTquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', CGSTquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}  
    @isTest
static void testSGSTquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, SGST_Amount__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String SGSTquoValue = controller.sGSTquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', SGSTquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}
    @isTest
static void testGrandTotalquoProperty() {
    // Create a test Quotes__c record
    Quotes__c testQuote = new Quotes__c(/* populate necessary fields */);
    insert testQuote;

    // Set the quote for the QuotepController to use
    QuotepController controller = new QuotepController(new ApexPages.StandardController(testQuote));
    controller.quote = [SELECT Id, Grand_Total__c FROM Quotes__c WHERE Id = :testQuote.Id LIMIT 1];

    // Call the Subcost property
    String GrandTotalquoValue = controller.grandTotalquo;

    // Add assertions to validate the subcostValue
    //System.assertEquals('ExpectedFormattedValue', GrandTotalquoValue); // Replace 'ExpectedFormattedValue' with the actual expected formatted value 
}  

    
}