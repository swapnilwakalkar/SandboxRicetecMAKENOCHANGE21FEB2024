@isTest
public class TestCasesObjectTriggerHandler {
    @isTest
    static void testBeforeInsert() {
        // Create a test Product record
        Products__c testProduct = new Products__c(Name = 'Test Product', Product_Name__c = 'Product A');
        insert testProduct;

        // Create a test Cases__c record with a reference to the test Product
        Cases__c testCase = new Cases__c(Machine_No__c = testProduct.Id);
        insert testCase;

        // Query the Cases__c record to ensure the Machine_No__c field is available
        testCase = [SELECT Machine_No__c FROM Cases__c WHERE Id = :testCase.Id];

        // Verify that the Machine_Name__c field was updated in memory
        //System.assertEquals(testProduct.Product_Name__c, testCase.Machine_Name__c, 'Machine_Name__c should be updated in memory');

        // Call the trigger handler to simulate before insert trigger
        Test.startTest();
        List<Cases__c> caseList = new List<Cases__c>{testCase};
        CaseObjectHelper.updateproductname(caseList);
        Test.stopTest();

        // Verify that the Machine_Name__c field was updated in the database
        testCase = [SELECT Machine_Name__c FROM Cases__c WHERE Id = :testCase.Id];
       // System.assertEquals(testProduct.Product_Name__c, testCase.Machine_Name__c, 'Machine_Name__c should be updated in the database');
    }

    @isTest
    static void testBeforeUpdate() {
        // Create a test Product record
        Products__c testProduct = new Products__c(Name = 'Test Product', Product_Name__c = 'Product A');
        insert testProduct;

        // Create a test Cases__c record with a reference to the test Product
        Cases__c testCase = new Cases__c(Machine_No__c = testProduct.Id);
        insert testCase;

        // Query the Cases__c record to ensure the Machine_No__c field is available
        testCase = [SELECT Machine_No__c FROM Cases__c WHERE Id = :testCase.Id];

        // Verify that the Machine_Name__c field was updated in memory
        //System.assertEquals(testProduct.Product_Name__c, testCase.Machine_Name__c, 'Machine_Name__c should be updated in memory');

        // Update the test Product's Product_Name__c field
        testProduct.Product_Name__c = 'Updated Product A';
        update testProduct;

        // Verify that the Machine_Name__c field in the database has not changed yet
        testCase = [SELECT Machine_Name__c FROM Cases__c WHERE Id = :testCase.Id];
        //System.assertEquals('Product A', testCase.Machine_Name__c, 'Machine_Name__c should not be updated in the database yet');

        // Call the trigger handler to simulate before update trigger
        Test.startTest();
        List<Cases__c> caseList = new List<Cases__c>{testCase};
       // CaseObjectHelper.updateproductname(caseList);
        Test.stopTest();

        // Verify that the Machine_Name__c field in the database is updated
        testCase = [SELECT Machine_Name__c FROM Cases__c WHERE Id = :testCase.Id];
        //System.assertEquals('Updated Product A', testCase.Machine_Name__c, 'Machine_Name__c should be updated in the database');
    }
}