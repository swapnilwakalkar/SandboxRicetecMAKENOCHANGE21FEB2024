trigger testfollowUpTrigger on Mill_Planner__c (after Update) {
    
   /* If(trigger.isafter && Trigger.IsUpdate){
        
        Map<id,Datetime> oldFollowUpDate = new Map<id,Datetime>();
        
        for(Mill_Planner__c OldRecord: Trigger.old ){
            oldFollowUpDate.put(OldRecord.Id, OldRecord.Follow_Up_Date_Time__c);
        }
		    
       testfollowUpTriggerHandler.createEvent(Trigger.new, oldFollowUpDate);
       testfollowUpTriggerHandler.CreateMillPlannerOnFollowUp(Trigger.new);
    }
*/
}