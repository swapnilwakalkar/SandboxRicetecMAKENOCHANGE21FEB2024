@isTest
public class ProductsRetrivingForQuoteClassTest {

    @isTest
    public static void testRetrieveProducts() {
        // Create test Products__c records for testing
        List<Products__c> products = new List<Products__c>();
        for (Integer i = 0; i < 5; i++) {
            products.add(new Products__c(
                Name = 'Product ' + i,
                Product_Name__c = 'Test Product ' + i
                // Add other required fields for Products__c here
            ));
        }
        insert products;

        // Call the retrieveProducts method
        Test.startTest();
        List<Products__c> retrievedProducts = ProductsRetrivingForQuoteClass.retrieveProducts();
        Test.stopTest();

        // Add assertions to verify the behavior of the retrieveProducts method
        System.assertNotEquals(null, retrievedProducts);
        System.assertEquals(5, retrievedProducts.size()); // Assuming 5 products were inserted

        // Add more test cases as needed to achieve complete coverage
    }

    @isTest
    public static void testUpdateQuoteProducts() {
        // Create a test Quote record
        Quotes__c quote = new Quotes__c(
           
            // Add other required fields for Quote here
        );
        insert quote;

        // Create test Products__c records for selectedProductIds
        List<Products__c> products = new List<Products__c>();
        for (Integer i = 0; i < 3; i++) {
            products.add(new Products__c(
                Name = 'Product ' + i,
                Product_Name__c = 'Test Product ' + i
                // Add other required fields for Products__c here
            ));
        }
        insert products;

        List<String> selectedProductIds = new List<String>();
        for (Products__c product : products) {
            selectedProductIds.add(product.Id);
        }

        // Call the UpdateQuoteProducts method
        Test.startTest();
        ProductsRetrivingForQuoteClass.UpdateQuoteProducts(selectedProductIds, quote.Id);
        Test.stopTest();

        // Add assertions to verify the behavior of the UpdateQuoteProducts method
        List<Quote_Line_Item__c> insertedLineItems = [SELECT Id FROM Quote_Line_Item__c WHERE Quotes__c = :quote.Id];
        System.assertNotEquals(null, insertedLineItems);
        System.assertEquals(3, insertedLineItems.size()); // Assuming 3 products were inserted as line items

        // Add more test cases as needed to achieve complete coverage
    }
}