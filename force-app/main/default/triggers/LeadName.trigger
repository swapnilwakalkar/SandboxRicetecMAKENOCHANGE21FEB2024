trigger LeadName on Leads__c (before insert, before delete) {
    if (trigger.isBefore && trigger.isInsert) {
        LeadNameHandler.handleLeadName(trigger.new, null, false);
    }

    if (trigger.isBefore && trigger.isDelete) {
        LeadNameHandler.handleLeadName(null, trigger.oldMap, true);
    }
}