trigger CasesObjectTriggerHandler on Cases__c (before insert, before update) {
    if(trigger.isBefore && (trigger.isinsert || trigger.isupdate)){
        CaseObjectHelper.updateproductname(trigger.new);
    }
}