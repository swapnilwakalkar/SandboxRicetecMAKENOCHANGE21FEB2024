public with sharing class convertController {
    
   /* @AuraEnabled(cacheable=true)
    public static Leads__c getLeadRecords(string LeadId) {
        List<Leads__c> leads =  [SELECT Id, Address__c, Campaign__c, Company__c, CreatedById, CurrencyIsoCode, 
                                 Data_com_key__c, Description__c, Do_Not_Call__c, Email__c, Email_Opt_Out__c, FirstName__c, Industry__c, 
                                 LastName__c, Last_Transfer_Date__c, Name, Lead_Source__c, Owner.Name, OwnerId, Lead_Owner__r.Name, Lead_Status__c, MiddleName__c,
                                 Mobile__c, Number_Of_Employees__c, Partner_Account__c, Phone__c, Rating__c, Salutation__c, Suffix__c, Title__c, Website__c
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
    public static List<Account> searchAccounts (String searchTerm){
        List<Account> accLookupList =  new List<Account>();
        if(searchTerm != ''){
            String accountName = '%' + searchTerm + '%';
            accLookupList = [Select Id, Name From Account Where Name like:accountName];
            System.debug('accLookupList'+accLookupList);
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
    public static Account submitAccount(string LeadCompany) {
        Account account = new Account();
        account.Name = LeadCompany;
        insert account;
        update account;
        return account;
    }
    @AuraEnabled
    public static Leads__c updateLead(String leadId) {
        Leads__c lead = [SELECT Id FROM Leads__c WHERE Id = :leadId];
        //lead.Lead_Status__c = 'Closed - Converted';
        update lead;
      //  delete lead;    
        return lead;
    }
    
    @AuraEnabled
    public static Contact submitContact(string Salutation, String FirstName, String LastName,  String AccId) {
        Contact contact = new Contact();
        contact.Salutation = Salutation;
        contact.FirstName = FirstName;
        contact.LastName = LastName;
        contact.AccountId = AccId;
        insert contact;
      //  update contact;
        return contact;
    }
    
    
    
    @AuraEnabled
    public static Opportunities__c submitOpportunity(string LeadCompany,string AccId) {
        Opportunities__c opportunity = new Opportunities__c();
        opportunity.Name = LeadCompany;
        //opportunity.Stage__c = 'Prospecting';
        //opportunity.Close_Date__c = Date.today().addDays(30);
        opportunity.AccountID__c = AccId;
        insert opportunity;
        //update opportunity;
        return opportunity;
        
    }

    @AuraEnabled
    public static void updateAccount(String accountId, String leadCompany) {
        Account acc = new Account(
            Id = accountId,
            Name = leadCompany
        );
        update acc;
    }

    
    @AuraEnabled
    public static void updateExistAccount(String leadCompany){
        System.debug('leadCompany '+leadCompany);
        List<Account> updateAcctList=new List<Account>();
        for(Account a : [select Id,Name from Account where Name=:leadCompany]){
        //update fields of Existing Account Record
            a.Name=leadCompany;
            updateAcctList.add(a);

        }
        update updateAcctList;
    }

    @AuraEnabled
    public static void updateExistContact(String contactname){
        
        System.debug('Name---> '+contactname);
        List<Contact> updateContList=new List<Contact>();
        for(Contact c : [select Id,FirstName,LastName from Contact where Name =:contactname]){
        //update fields of Existing Contact Record
           
        c.ExistingContact__c=contactname;
            
            updateContList.add(c);

        }
        update updateContList;
        
    }   
    @AuraEnabled
    public static void updateExistOppty(String AcctName){
        
        System.debug('AcctName---> '+AcctName);
        List<Opportunities__c> updateOpptyList=new List<Opportunities__c>();
        for(Opportunities__c opp : [select Id,Name from Opportunities__c where Name =:AcctName]){
        //update fields of Existing Contact Record
           
        opp.ExistingOppty__c=AcctName;
            
        updateOpptyList.add(opp);

        }
        update updateOpptyList;
        
    }

*/
    
}