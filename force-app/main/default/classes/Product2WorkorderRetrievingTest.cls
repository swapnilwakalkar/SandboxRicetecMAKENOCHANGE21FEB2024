@isTest
public class Product2WorkorderRetrievingTest {
    @isTest
    static void testRetrieveProducts() {
        // Create test records for spares__c object
        List<spares__c> testProducts = new List<spares__c>();
        for (Integer i = 0; i < 5; i++) {
            spares__c product = new spares__c(
               
                // Add other required fields
            );
            testProducts.add(product);
        }
        insert testProducts;

        // Call the retrieveProducts method
        List<spares__c> retrievedProducts = Product2WorkorderRetrieving.retrieveProducts();

        // Perform assertions
        System.assertEquals(5, retrievedProducts.size(), 'Number of retrieved products should match the number of test records');
    }

    @isTest
    static void testUpdateProductOpport() {
        // Create a test Case record
        Case testCase = new Case(
           
            // Add other required fields
        );
        insert testCase;

        // Create test spares__c records
        spares__c testProduct1 = new spares__c(
           
            // Add other required fields
        );
        insert testProduct1;
        
        // Call the updateProductOpport method
        List<String> selectedProductIds = new List<String>{testProduct1.Id};
        Product2WorkorderRetrieving.updateProductOpport(selectedProductIds, testCase.Id);

        // Query for SpareLineItem__c records
        List<SpareLineItem__c> lineItems = [SELECT Id FROM SpareLineItem__c WHERE Cases__c = :testCase.Id];

        // Perform assertions
       // System.assertEquals(1, lineItems.size(), 'SpareLineItem__c record should be created for the test product');
       
    }
    
}