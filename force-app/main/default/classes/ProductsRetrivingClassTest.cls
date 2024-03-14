@isTest
public class ProductsRetrivingClassTest {

    @isTest
    static void testRetrieveProducts() {
        // Create test data for Products__c records
        List<Products__c> products = new List<Products__c>();
        for (Integer i = 0; i < 5; i++) {
            products.add(new Products__c(
                Name = 'Product ' + i,
                Category__c = 'Category ' + i,
                Sub_Category__c = 'SubCategory ' + i,
                Product_Name__c = 'Test Product ' + i,
                Type__c = 'BOI',
                Discount__c = 10 + i, 
                Unit_Price__c = 100 + i,
                Quantity_In_no_s__c = 1 + i,
                Power_in_HP__c = 2.00 + i
            ));
        }
        insert products;

        Test.startTest();
        List<Products__c> retrievedProducts = ProductsRetrivingClass.retrieveProducts();
        Test.stopTest();

        // Assert that the number of retrieved products matches the number of created products
        System.assertEquals(products.size(), retrievedProducts.size());
    }

    @isTest
    static void testUpdateProductOpport() {
        // Create an Opportunity
        Opportunities__c opp = new Opportunities__c(
            Name = 'Test Opportunity'
            // Add other required fields
        );
        insert opp;

        // Create Products__c records
        List<Products__c> products = new List<Products__c>();
        for (Integer i = 0; i < 5; i++) {
            products.add(new Products__c(
                Name = 'Product ' + i,
                Opportunities__c = opp.Id,
                Category__c = 'Category ' + i,
                Sub_Category__c = 'SubCategory ' + i,
                Product_Name__c = 'Test Product ' + i,
                Type__c = 'BOI',
                Discount__c = 10 + i, 
                Unit_Price__c = 100 + i,
                Quantity_In_no_s__c = 1 + i,
                Power_in_HP__c = 2.00 + i
            ));
        }
        insert products;

        // Call the updateProductOpport method
        List<String> productIds = new List<String>();
        for (Products__c product : products) {
            productIds.add(product.Id);
        }

        Test.startTest();
        ProductsRetrivingClass.updateProductOpport(productIds, opp.Id);
        Test.stopTest();

        // Query OpportunityLineItem__c records to verify insertion
        List<OpportunityLineItem__c> lineItems = [SELECT Id FROM OpportunityLineItem__c WHERE Opportunities__c = :opp.Id];

        // Assert that the number of inserted line items matches the number of products
        System.assertEquals(products.size(), lineItems.size());
    }
}