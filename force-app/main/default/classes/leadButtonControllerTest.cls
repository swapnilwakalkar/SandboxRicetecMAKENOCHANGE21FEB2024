@isTest
public class leadButtonControllerTest {
    
    @isTest
    static void testGetLeadRecords() {
        // Create test data
        Leads__c lead = new Leads__c(
            Area__c = 'Test Area',
            Village__c = 'Test Village',
            FirstName__c = 'hello'
        );
        insert lead;
        
        // Call the method being tested
        Leads__c result = LeadButtonController.getLeadRecords(lead.Id);
        
        // Verify the result
        System.assertNotEquals(null, result); // A lead should be returned
        System.assertEquals(lead.Id, result.Id);
        System.assertEquals('Test Area', result.Area__c);
        System.assertEquals('Test Village', result.Village__c);
        // Add assertions for other fields
    }
    
    @isTest
    static void testGetLeadRecordsNoRecordsFound() {
        // Call the method with an invalid LeadId
        Leads__c result = LeadButtonController.getLeadRecords('invalidId');
        
        // Verify the result
        System.assertEquals(null, result); // No records should be found
    }
    
    @isTest
    static void testSearchAccountsPhoneNumber() {
        // Create test data
        String searchTerm = 'Test';
        Account account1 = new Account(Name = 'Test Account 1', Mobile__c = '9030603989');
        Account account2 = new Account(Name = 'Test Account 2', Mobile__c = '9581742816');
        insert new List<Account>{account1, account2};
            
            // Call the method being tested
            List<Account> result = LeadButtonController.searchAccountsPhoneNumber(searchTerm);
        
        // Verify the result
        System.assertEquals(2, result.size()); // Two accounts have phone numbers matching 'Test'
        for (Account acc : result) {
            System.assert(acc.Name.contains('Test') || acc.Mobile__c.contains(searchTerm));
        }
    }
    
    @isTest
    static void testSearchAccountsPhoneNumberEmptySearchTerm() {
        // Call the method with an empty search term
        List<Account> result = LeadButtonController.searchAccountsPhoneNumber('');
        
        // Verify the result
        System.assertEquals(0, result.size()); // No accounts should be returned
    }
    
    @isTest
    static void testSearchAccountsPhoneNumberNoMatchingAccounts() {
        // Create test data
        String searchTerm = 'NonExistent';
        
        // Call the method with a search term that has no matches
        List<Account> result = LeadButtonController.searchAccountsPhoneNumber(searchTerm);
        
        // Verify the result
        System.assertEquals(0, result.size()); // No matching accounts should be returned
    }
    
    @isTest
    static void testSearchContacts() {
        // Create test data
        String searchTerm = 'Pranav';
        Contact contact1 = new Contact(firstName = 'Pranav', lastname = 'Tatikonda');
        Contact contact2 = new Contact(firstName = 'Karthik' , lastname= 'Tatikonda');
        insert new List<Contact>{contact1, contact2};
            
            // Call the method being tested
            List<Contact> result = LeadButtonController.searchContacts(searchTerm);
        
        // Verify the result
        System.assertEquals(1, result.size()); // One contact should be returned
        System.assertEquals(contact1.Id, result[0].Id);
        System.assertEquals('Pranav Tatikonda', result[0].Name);
    }
    
    @isTest
    static void testSearchContactsEmptySearchTerm() {
        // Call the method with an empty search term
        List<Contact> result = LeadButtonController.searchContacts('');
        
        // Verify the result
        System.assertEquals(0, result.size()); // No contacts should be returned
    }
    
    @isTest
    static void testSearchContactsNoMatchingContacts() {
        // Create test data
        String searchTerm = 'NonExistent';
        
        // Call the method with a search term that has no matches
        List<Contact> result = LeadButtonController.searchContacts(searchTerm);
        
        // Verify the result
        System.assertEquals(0, result.size()); // No matching contacts should be returned
    }
    
    ///////////////////////// 
    
    @isTest
    static void testSearchOpty() {
        // Create test data
        String searchTerm = 'Pranav';
        Opportunities__c Opp1 = new Opportunities__c(Name = 'Pranav Tatikonda');
        Opportunities__c Opp2 = new Opportunities__c(Name = 'Karthik Tatikonda');
        insert new List<Opportunities__c>{Opp1, Opp2};
            
            // Call the method being tested
            List<Opportunities__c> result = LeadButtonController.searchOpty(searchTerm);
        
        // Verify the result
        System.assertEquals(1, result.size()); // One contact should be returned
        System.assertEquals(Opp1.Id, result[0].Id);
        System.assertEquals('Pranav Tatikonda', result[0].Name);
    }
    
    @isTest
    static void testSearchOptyEmptySearchTerm() {
        // Call the method with an empty search term
     
        
        Test.startTest();
        List<Opportunities__c> result = LeadButtonController.searchOpty('');
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(0, result.size()); // No contacts should be returned
    }
    
    @isTest
    static void testSearchOptyNoMatchingContacts() {
        // Create test data
        String searchTerm = 'NonExistent';
        
        // Call the method with a search term that has no matches
        List<Opportunities__c> result = LeadButtonController.searchOpty(searchTerm);
        
        // Verify the result
        System.assertEquals(0, result.size()); // No matching contacts should be returned
    }
    
    @isTest
    static void testSubmitAccount() {
        
        Territory__c territory = new Territory__c(Name = 'Test Territory');
    		insert territory;
        
        // Define input parameters
        String LeadCompany = 'pavani Company';
        String LeadMobile1 = '1234567890';
        String LeadMobile2 = '9876543210';
        String LeadEmail = 'test@example.com';
        String LeadMillType = 'New';
        String AccountBillingStreet = '123 Test Street';
        String AccountBillingCity = 'Test City';
        String AccountBillingTerritory = territory.id;
        String AccountBillingDistrict = 'Test District';
        String AccountBillingMandal = 'Test Mandal';
        String AccountBillingVillage = 'Test Village';
        String AccountBillingState = 'Test State';
        String AccountBillingCountry = 'Test Country';
        String accountpincode = '12345';
        String LeadSource = 'IndiaMart';
        
        // Call the method being tested
        Account result = LeadButtonController.submitAccount(
            LeadCompany, LeadMobile1, LeadMobile2, LeadEmail, LeadMillType,
            AccountBillingStreet, AccountBillingCity, AccountBillingTerritory,
            AccountBillingDistrict, AccountBillingMandal, AccountBillingVillage,
            AccountBillingState, AccountBillingCountry, accountpincode, LeadSource );
              
        // Verify the result
        System.assertNotEquals(null, result); // An Account should be created
        System.assertEquals(LeadCompany, result.Name);
        System.assertEquals(LeadMobile1, result.Mobile__c);
        System.assertEquals(LeadMobile2, result.Mobiles__c);
        System.assertEquals(LeadEmail, result.Email__c);
        System.assertEquals(LeadMillType, result.Mill_Type__c);
        System.assertEquals(AccountBillingStreet, result.Street__c);
        System.assertEquals(AccountBillingCity, result.City__c);
        System.assertEquals(AccountBillingVillage, result.Village__c);
        System.assertEquals(AccountBillingDistrict, result.District__c);
        System.assertEquals(AccountBillingState, result.State__c);
        System.assertEquals(AccountBillingCountry, result.Country__c);
        System.assertEquals(AccountBillingMandal, result.Mandal__c);
        System.assertEquals(AccountBillingTerritory, result.Area__c);
        System.assertEquals(LeadSource, result.Lead_Source__c);
        System.assertEquals(accountpincode, result.Pincode__c);
    }
    
    
    @isTest
    static void testSubmitContact() {
        
        Territory__c territory = new Territory__c(Name = 'Test Territory1');
        insert territory;
        // Create test data for Account
        Account testAccount = new Account(Name = 'John Wick');
        insert testAccount;

        // Define input parameters for Contact
        String Salutation = 'Mr.';
        String FirstName = 'John';
        String LastName = 'Doe';
        String LeadMobile1 = '1234567890';
        String LeadMobile2 = '9876543210';
        String Email = 'test@example.com';
        String LeadSource = 'IndiaMart';
        String LeadMillType = 'New';
        String ContactMailingStreet = '123 Test Street';
        String ContactMailingTerritory = territory.id; // Replace with a valid Territory record ID
        String ContactMailingCity = 'Test City';
        String ContactMailingMandal = 'Test Mandal';
        String ContactMailingState = 'Test State';
        String ContactMailingVillage = 'Test Village';
        String ContactMailingDistrict = 'Test District';
        String ContactMailingCountry = 'Test Country';
        String ContactPincode = '12345';
        String AccId = testAccount.Id;

        // Call the method being tested
        Contact result = LeadButtonController.submitContact(
            Salutation, FirstName, LastName, LeadMobile1, LeadMobile2, Email, LeadSource, LeadMillType,
            ContactMailingStreet, ContactMailingTerritory, ContactMailingCity, ContactMailingMandal,
            ContactMailingState, ContactMailingVillage, ContactMailingDistrict, ContactMailingCountry,
            ContactPincode, AccId);       

        // Verify the result
        System.assertNotEquals(null, result); // A Contact should be created
        System.assertEquals(Salutation, result.Salutation);
        System.assertEquals(FirstName, result.FirstName);
        System.assertEquals(LastName, result.LastName);
        System.assertEquals(LeadMobile1, result.MobilePhone);
        System.assertEquals(LeadMobile2, result.Mobile__c);
        System.assertEquals(Email, result.Email__c);
        System.assertEquals(LeadMillType, result.Mill_Type__c);
        System.assertEquals(LeadSource, result.Lead_Source__c);
        System.assertEquals(ContactMailingStreet, result.Street__c);
        System.assertEquals(ContactMailingCity, result.City__c);
        System.assertEquals(ContactMailingVillage, result.Village__c);
        System.assertEquals(ContactMailingDistrict, result.District__c);
        System.assertEquals(ContactMailingState, result.State__c);
        System.assertEquals(ContactMailingCountry, result.Country__c);
        System.assertEquals(ContactMailingMandal, result.Mandal__c);
        System.assertEquals(ContactMailingTerritory, result.Territorys__c);
        System.assertEquals(ContactPincode, result.Pincode__c);
        System.assertEquals(AccId, result.AccountId);
    }
    
     @isTest
    static void testSubmitOpportunity() {
        // Create test data for Account
        Account testAccount = new Account(Name = 'Spider Man');
        insert testAccount;

        // Define input parameters for Opportunity
        String LeadCompany = 'Test Company';
        String LeadMillType = 'New';
        String LeadSource = 'IndiaMart';
        String AccId = testAccount.Id;
        String FirstName = 'Hello';
        String LastName = 'SP';

        // Call the method being tested
        Opportunities__c result = LeadButtonController.submitOpportunity(
            LeadCompany, LeadMillType, LeadSource, AccId, FirstName, LastName
        );

        // Verify the result
        System.assertNotEquals(null, result); // An Opportunity should be created
        System.assertEquals(LeadCompany, result.Name);
        System.assertEquals(FirstName, result.First_Name__c);
        System.assertEquals(LastName, result.Last_Name__c);
        // Add assertions for other fields as needed
    }
    
    @isTest
    static void testUpdateAccountName() {
        // Create test data for an Account
        Account testAccount = new Account(Name = 'Original Name');
        insert testAccount;

        // Define input parameters for the method
        String accountId = testAccount.Id;
        String accountName = 'New Name';

        // Call the method being tested
        Test.startTest();
        Account result = LeadButtonController.updateAccountName(accountId, accountName);
        Test.stopTest();

        // Verify the result
        System.assertNotEquals(null, result); // The Account should be updated and returned
        System.assertEquals(accountName, result.Name);

        // Verify the updated Account by querying it
        Account updatedAccount = [SELECT Name FROM Account WHERE Id = :accountId];
        System.assertEquals(accountName, updatedAccount.Name);
    }
    
    @isTest
    static void testUpdateContactAccount() {
        // Create a test Contact and Account
        Account testAccount = new Account(Name = 'Bat Man');
        insert testAccount;

        Contact testContact = new Contact(
            FirstName = 'Super',
            LastName = 'Man',
            AccountId = null // Initially, set AccountId to null
        );
        insert testContact;

        // Define input parameters
        String contactId = testContact.Id;
        String accountId = testAccount.Id;

        // Call the method being tested
        Contact result = LeadButtonController.updateContactAccount(contactId, accountId);

        // Verify the result
        System.assertNotEquals(null, result); // A Contact should be updated
        System.assertEquals(accountId, result.AccountId);
    }

    @isTest
    static void testUpdateOpportunityAccount() {
        
        Account testAccount = new Account(Name = 'Aqua Man');
        insert testAccount;
        
        // Create test data for Opportunity
        Opportunities__c testOpportunity = new Opportunities__c(
            Name = 'Test Opportunity',
            AccountID__c = testAccount.id 
        );
        insert testOpportunity;

        // Define input parameters for the method
        String opportunityId = testOpportunity.Id;
        String AcID = testAccount.id; 

        // Call the method being tested
        Opportunities__c result = LeadButtonController.updateOpportunityAccount(opportunityId, AcID);

        // Verify the result
        System.assertNotEquals(null, result); // An Opportunity should be updated
        System.assertEquals(AcID, result.AccountID__c);
    }
    
     @isTest
    static void testUpdateLead() {
        // Create test data for Lead and an Account
        Leads__c testLead = new Leads__c(
            Area__c = 'west',
            Village__c = 'Bengal',
            FirstName__c = 'hello'
        );
        insert testLead;

        Account testAccount = new Account(Name = 'Rani');
        insert testAccount;

        // Update the Lead with a converted Account ID
        Leads__c updatedLead = LeadButtonController.updateLead(testLead.Id, testAccount.Id);

        // Verify the result
        System.assertNotEquals(null, updatedLead); // The Lead should be updated and not null
        System.assertEquals(testAccount.Id, updatedLead.ConvertedAccId__c);

        // Verify that the Lead is deleted
        List<Leads__c> deletedLeads = [SELECT Id FROM Leads__c WHERE Id = :testLead.Id];
        System.assertEquals(0, deletedLeads.size()); // The Lead should be deleted
    }
}