@isTest
private class ProductsRetrivingfororderClassTest {

    @isTest
    static void testRetrieveProducts() {
        // Insert test data for Products__c
        List<Products__c> testProducts = new List<Products__c>{
            new Products__c(Name = 'TestProduct1', Product_Name__c = 'TestProduct1', Quantity_In_no_s__c = 10, Unit_Price__c = 100.00),
            new Products__c(Name = 'TestProduct2', Product_Name__c = 'TestProduct2', Quantity_In_no_s__c = 5, Unit_Price__c = 50.00)
        };
        insert testProducts;

        // Call the method to test
        List<Products__c> retrievedProducts = ProductsRetrivingfororderClass.retrieveProducts();

        // Perform assertions
        System.assertEquals(2, retrievedProducts.size(), 'Number of retrieved products should match the number of test products');
        // Add more assertions based on your requirements
    }

    @isTest
    static void testUpdateOrderProducts() {
        // Insert test data for selectedProductIds and OrderId
        Products__c testProduct = new Products__c(Name = 'TestProduct', Product_Name__c = 'TestProduct', Quantity_In_no_s__c = 10, Unit_Price__c = 100.00);
        insert testProduct;

        Order__c testOrder = new Order__c(/* populate required fields */);
        insert testOrder;

        List<String> selectedProductIds = new List<String>{testProduct.Id};
        Id orderId = testOrder.Id;

        // Call the method to test
        Test.startTest();
        ProductsRetrivingfororderClass.UpdateOrderProducts(selectedProductIds, orderId);
        Test.stopTest();

        // Perform assertions
        // Add assertions based on your requirements, e.g., check if Order_Line_Item__c records were created
        System.assertEquals(1, [SELECT count() FROM Order_Line_Item__c WHERE Orders__c = :orderId]);
    }

    // Add more test methods as needed for additional coverage

}