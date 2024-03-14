@isTest
public class LeadNameHandlerTest {
    @isTest
    static void testBeforeInsert() {
        Leads__c lead = new Leads__c(FirstName__c = 'Gold', LastName__c = 'Smith');
        
        Test.startTest();
        LeadNameHandler.handleLeadName(new List<Leads__c>{lead}, null, false);
        Test.stopTest();
        
        System.assertEquals('Gold Smith', lead.Name);
    }

    @isTest
    static void testBeforeDelete() {
        account acc = new account();
        Leads__c lead = new Leads__c(LastName__c = 'Johnson');
        insert lead;

        Task task = new Task(WhatId = lead.Id);
        insert task;

        lead.ConvertedAccId__c = acc.Id ; // Set the Converted Account Id

        update lead;

        Test.startTest();
        delete lead;
        Test.stopTest();

        Task updatedTask = [SELECT WhatId FROM Task WHERE Id = :task.Id];
        System.assertEquals(lead.ConvertedAccId__c, updatedTask.WhatId);
    }
}

/* sample created on 19-01-2024--Sp
@isTest
public class LeadNameHandlerTest {

    @isTest
    static void testBeforeInsert() {
        Leads__c lead = new Leads__c(FirstName__c = 'Gold', LastName__c = 'Smith');
        
        Test.startTest();
        LeadNameHandler.handleLeadName(new List<Leads__c>{lead}, null, false);
        Test.stopTest();
        
        System.assertEquals('Gold Smith', lead.Name);
    }

    @isTest
    static void testBeforeDelete() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Leads__c lead = new Leads__c(LastName__c = 'Johnson');
        insert lead;

        Task task = new Task(WhatId = lead.Id);
        insert task;

        lead.ConvertedAccId__c = acc.Id; // Set the Converted Account Id

        update lead;

        Test.startTest();
        delete lead;
        Test.stopTest();

        Task updatedTask = [SELECT WhatId FROM Task WHERE Id = :task.Id LIMIT 1];
        System.assertEquals(lead.ConvertedAccId__c, updatedTask.WhatId);
    }
}*/