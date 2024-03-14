public class LeadNameHandler {
    public static void handleLeadName(List<Leads__c> newLeads, Map<Id, Leads__c> oldLeadsMap, Boolean isDelete) {
        if (!isDelete) {
            // Update Lead names based on FirstName and LastName
            for (Leads__c le : newLeads) {
                if (le.LastName__c != null && le.FirstName__c != null) {
                    le.Name = le.FirstName__c + ' ' + le.LastName__c;
                } else if (le.LastName__c == null && le.FirstName__c != null) {
                    le.Name = le.FirstName__c;
                } else if (le.LastName__c != null && le.FirstName__c == null) {
                    le.Name = le.LastName__c;
                }
            }
        } else {
            // Update related Task records if Leads are being deleted
            try {
                List<Task> relatedTasks = [SELECT Id, WhatId FROM Task WHERE WhatId IN :oldLeadsMap.keySet()];
                
                for (Task t : relatedTasks) {
                    t.WhatId = oldLeadsMap.get(t.WhatId).ConvertedAccId__c;
                }

                update relatedTasks;
            } catch (Exception e) {
                // Handle exceptions appropriately (e.g., log, rethrow, or notify)
                System.debug('An error occurred: ' + e.getMessage());
            }
        }
    }
}
/*

public class LeadNameHandler {
    public static void handleLeadName(List<Leads__c> newLeads, Map<Id, Leads__c> oldLeadsMap, Boolean isDelete) {
        if (!isDelete) {
            for (Leads__c le : newLeads) {
                if(le.LastName__c != null && le.FirstName__c != null){
                    le.Name = le.FirstName__c + ' '+ le.LastName__c;  
                   
                } 
                else if(le.LastName__c == null && le.FirstName__c != null){
                    le.Name = le.FirstName__c;
                }
                else if(le.LastName__c != null && le.FirstName__c == null){
                    le.Name = le.LastName__c;
                }
                
            }
        } else {
            List<Task> relatedTasks = [SELECT Id, WhatId FROM Task WHERE WhatId IN :oldLeadsMap.keySet()];
            for (Task t : relatedTasks) {
                t.WhatId = oldLeadsMap.get(t.WhatId).ConvertedAccId__c;
            }
            update relatedTasks;
        }
    }
}*/