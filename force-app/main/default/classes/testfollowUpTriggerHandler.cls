public class testfollowUpTriggerHandler {
    public static void createEvent(List<Mill_Planner__c> mp, Map<Id, Datetime> oldMp) {
        
        List<Event> eventsToInsert = new List<Event>();
        
        for (Mill_Planner__c millPlanner : mp) {
            Datetime newfollowUpDate = millPlanner.Follow_Up_Date_Time__c;
            Datetime oldfollowUpDate = oldMp.get(millPlanner.Id);
            
            if (newfollowUpDate != oldfollowUpDate) {
                Event ev = new Event();
                ev.WhatId = millPlanner.Id;
                ev.Subject = 'Meeting';
                ev.StartDateTime = millPlanner.Follow_Up_Date_Time__c;
                ev.EndDateTime = millPlanner.Follow_Up_Date_Time__c.addHours(1);
                ev.Description = millPlanner.Feedback__c;
                eventsToInsert.add(ev);
            }
        }
        
        if (!eventsToInsert.isEmpty()) {
            insert eventsToInsert;
        }
    }
    
    Public static void CreateMillPlannerOnFollowUp(List<Mill_Planner__c> mp){
        
        Mill_Planner__c insertMp = new Mill_Planner__c();
        
        Monthly_Planner__c  monthlyPlanner = [select id, Start_Date__c,End_Date__c from Monthly_Planner__c];
        
        
        
      
    }
}