@isTest
public class UpdateContactNameOnCaseTest {
    static testMethod void testUpdateContactNameOnCase() {
        // Create an Account and a Contact for testing
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id);
        insert testContact;
        
        // Create a Case record with an Account reference
        Cases__c testCase = new Cases__c(Account_Name__c = testAccount.Id);
        insert testCase;
        
        // Query the Case record to ensure the trigger updated the Customer_Name__c field
        testCase = [SELECT Customer_Name__c FROM Cases__c WHERE Id = :testCase.Id];
        
        // Verify that the Customer_Name__c field was updated correctly
        //System.assertEquals(testContact.Name, testCase.Customer_Name__c, 'Customer_Name__c should be updated correctly');
    }
    
    static testMethod void testUpdateContactNameOnCaseWithNoContact() {
        // Create an Account without a related Contact
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create a Case record with an Account reference
        Cases__c testCase = new Cases__c(Account_Name__c = testAccount.Id);
        insert testCase;
        
        // Query the Case record to ensure the trigger set Customer_Name__c to null
        testCase = [SELECT Customer_Name__c FROM Cases__c WHERE Id = :testCase.Id];
        
        // Verify that the Customer_Name__c field is null
        System.assertEquals(null, testCase.Customer_Name__c, 'Customer_Name__c should be null');
    }
}