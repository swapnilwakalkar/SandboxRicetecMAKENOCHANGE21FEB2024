/**
* @description       : 
* @author            : Pranav Thatikonda   
* @group             : 
* @last modified on  : 08-09-2023
* @last modified by  : Pranav Thatikonda
**/
public with sharing class LeadButtonController {
    @AuraEnabled(cacheable=true)
    public static Leads__c getLeadRecords(string LeadId) {
        List<Leads__c> leads =  [SELECT Id, Area__c,Village__c, City__c, Mandal__c, ConvertedAccId__c, District__c,State__c, Territorys__c, Country__c, Company__c, Description__c, Email__c, FirstName__c, Industry__c, Pincode__c,
                                 LastName__c, Name, Lead_Source__c, Owner.Name, Lead_Owner__r.Name, Lead_Status__c, MiddleName__c,
                                 Mobile__c  , Phone__c, Rating__c, Salutation__c,  Website__c, Mill_Type__c
                                 FROM Leads__c
                                 WHERE Id = :LeadId
                                 LIMIT 1
                                ];
        
        if (!leads.isEmpty()) {
            return leads[0];
        } else {
            return null; // Return null or handle the case when no records are found
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccountsPhoneNumber(String searchTerm1) {
        List<Account> accLookupList = new List<Account>();
        if (searchTerm1 != '') {
            String sanitizedTerm = '%' + searchTerm1 + '%';
            
            // Query accounts by name or phone number
            accLookupList = [SELECT Id, Name, Mobile__c FROM Account WHERE (Name LIKE :sanitizedTerm) OR (Mobile__c LIKE :sanitizedTerm) or (Mobiles__c LIKE :sanitizedTerm)];
            
            System.debug('accLookupList: ' + accLookupList);
            return accLookupList;
        }
        return accLookupList;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm) {
        List<Contact> conLookupList =  new List<Contact>();
        if(searchTerm != ''){
            String searchKey = '%' + searchTerm + '%';
            conLookupList = [SELECT Id, Name FROM Contact WHERE Name LIKE :searchKey];
            System.debug('conLookupList'+conLookupList);
            return conLookupList;
        }
        return conLookupList;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunities__c> searchOpty(String searchTerm) {
        List<Opportunities__c> oppLookupList =  new List<Opportunities__c>();
        if(searchTerm != ''){
            String searchKey = '%' + searchTerm + '%';
            oppLookupList = [SELECT Id, Name FROM Opportunities__c WHERE Name LIKE :searchKey];
            System.debug('oppLookupList'+oppLookupList);
            return oppLookupList;
        }
        return oppLookupList;
    }    
    
    @AuraEnabled
    public static Account submitAccount(string LeadCompany, string LeadMobile1, string LeadMobile2, string LeadEmail, String LeadMillType,string AccountBillingStreet, 
                                        string AccountBillingCity,id AccountBillingTerritory, string AccountBillingDistrict, string AccountBillingMandal, string AccountBillingVillage, string AccountBillingState, string AccountBillingCountry, 
                                        string accountpincode, String LeadSource) {                                         
                                            Account account = new Account();
                                            account.Name = LeadCompany;
                                            account.Mobile__c = LeadMobile1;
                                            account.Mobiles__c = LeadMobile2;
                                            account.Email__c = LeadEmail;
                                            account.Mill_Type__c = LeadMillType;                                          
                                            account.Street__c = AccountBillingStreet;
                                            account.City__c = AccountBillingCity;
                                            account.Village__c = AccountBillingVillage;
                                            account.District__c =   AccountBillingDistrict;
                                            account.State__c = AccountBillingState;
                                            account.Country__c = AccountBillingCountry;
                                            account.Mandal__c = AccountBillingMandal;
                                            account.Area__c = AccountBillingTerritory;
                                            account.Lead_Source__c = LeadSource;
                                            account.Pincode__c = accountpincode;   
                                            insert account;
                                            return account;       
                                        }
    
    
    @AuraEnabled
    public static Contact submitContact(string Salutation, String FirstName, String LastName, string LeadMobile1, string LeadMobile2, string Email, String LeadSource, String LeadMillType,
                                        string ContactMailingStreet, string ContactMailingTerritory, string ContactMailingCity,string ContactMailingMandal,  string ContactMailingState, string ContactMailingVillage, string ContactMailingDistrict, string ContactMailingCountry,
                                        string ContactPincode, String AccId) {
                                            
                                            Contact contact = new Contact();
                                            contact.Salutation = Salutation;
                                            contact.FirstName = FirstName;
                                            contact.LastName = LastName;
                                            contact.MobilePhone = LeadMobile1;
                                            contact.Mobile__c = LeadMobile2;
                                            contact.Email__c= Email;
                                            contact.Mill_Type__c = LeadMillType;
                                            contact.Lead_Source__c = LeadSource;	   
                                            contact.Street__c = ContactMailingStreet;
                                            contact.City__c = ContactMailingCity;
                                            contact.Village__c = ContactMailingVillage;
                                            contact.State__c = ContactMailingState;
                                            contact.Mandal__c = ContactMailingMandal;
                                            contact.District__c = ContactMailingDistrict;
                                            contact.Country__c = ContactMailingCountry;
                                            contact.Territorys__c = ContactMailingTerritory;
                                            contact.Pincode__c = ContactPincode;
                                            contact.AccountId = AccId;
                                            insert contact;
                                            return contact;
                                        }   
   @AuraEnabled
    public static Opportunities__c submitOpportunity(string LeadCompany, String LeadMillType, String LeadSource, string AccId, String FirstName, String LastName ) {
        Opportunities__c opportunity = new Opportunities__c();
        opportunity.Name = LeadCompany;
        opportunity.Close_Date__c = Date.today().addDays(30);
        opportunity.AccountID__c = AccId;
        opportunity.Mill_Type__c = LeadMillType;
        opportunity.Lead_Source__c = LeadSource;
        opportunity.First_Name__c = FirstName;
        opportunity.Last_Name__c = LastName;

        insert opportunity;
        return opportunity;
    }
    
    @AuraEnabled
    public static Account updateAccountName(String accountId, String accountName) {
        
        system.debug('Account IDDDDDD:  ' +accountId);
        system.debug('Account Name:  ' +accountName);
        try {
            Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
            
            if (acc != null) {
                acc.Name = accountName;
                update acc;
                return acc;
            }
        } catch (Exception ex) {
            System.debug('Error updating account name: ' + ex.getMessage());
            throw ex;
        }
        return null;
    }
    
    @AuraEnabled
    public static Contact updateContactAccount(string contactId, string AccountId) {
        system.debug(contactId);
        system.debug(AccountId);
        
        try {
            Contact contact = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId];
            if (contact != null) {
                contact.AccountId = accountId; // Set the AccountId on the Contact record
                update contact; // Update the Contact record
                return contact;
            }
        } catch (Exception ex) {
            System.debug('Error updating contact account: ' + ex.getMessage());
            throw ex;
        }
        return null;
    }
    
    @AuraEnabled
    public static Opportunities__c updateOpportunityAccount(string opportunityId, string AcID) {
        System.debug(opportunityId);
        System.debug(AcID);
        try {
            Opportunities__c opportunity = [SELECT Id, AccountID__c FROM Opportunities__c WHERE Id = :opportunityId];
            if (opportunity != null) {
                opportunity.AccountID__c = AcID; // Set the AccountID__c on the Opportunity record
                update opportunity; // Update the Opportunity record
                return opportunity;
            }
        } catch (Exception ex) {
            System.debug('Error updating opportunity account: ' + ex.getMessage());
            throw ex;
        }
        return null;
    }
    
    @AuraEnabled
    public static Leads__c updateLead(String leadId, Id ConvertedAccId) {
        Leads__c lead = [SELECT Id FROM Leads__c WHERE Id = :leadId];
        lead.ConvertedAccId__c = ConvertedAccId;
        update lead;
        delete lead;
        return lead;
    }
}