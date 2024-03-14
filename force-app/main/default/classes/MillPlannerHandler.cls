public class MillPlannerHandler {
    
    public static void createFollowupEvent(List<Mill_Planner__c> newMillPlannerList, Map<Id, Mill_Planner__c> oldMillPlannerMap) {
        List<Event> eventsToInsert = new List<Event>();
        List<Monthly_Planner__c> monthlyPlannerList = new List<Monthly_Planner__c>();
        List<Day_Planner__c> DayPlannerList = new List<Day_Planner__c>();
        List<Mill_Planner__c> MillPlanList = new List<Mill_Planner__c>();
        
        for (Mill_Planner__c newMillPlanner : newMillPlannerList) {
            Mill_Planner__c oldMillPlanner = oldMillPlannerMap.get(newMillPlanner.Id);
            
            if (newMillPlanner.Follow_Up_Date_Time__c != null &&
                (oldMillPlanner == null || newMillPlanner.Follow_Up_Date_Time__c != oldMillPlanner.Follow_Up_Date_Time__c)) {
                    
                    Event newEvent = new Event();
                    newEvent.Subject = 'Follow-up Event';
                    newEvent.StartDateTime = newMillPlanner.Follow_Up_Date_Time__c;
                    newEvent.EndDateTime = newMillPlanner.Follow_Up_Date_Time__c.addHours(1); // Adjust end time accordingly
                    newEvent.Description = 'Follow-up event created from Mill Planner record: ' + newMillPlanner.Name;
                    newEvent.Location = newMillPlanner.Area__c;
                    newEvent.WhatId = newMillPlanner.Id;
                    
                    eventsToInsert.add(newEvent);
                    
                    if (!eventsToInsert.isEmpty()) {
            insert eventsToInsert;
        }
                    
                    Monthly_Planner__c newMonthlyPlanner = new Monthly_Planner__c();
                    newMonthlyPlanner.Name = 'New ' + newEvent.Subject;
                    newMonthlyPlanner.Start_Date__c = newEvent.StartDateTime.date();
                    newMonthlyPlanner.End_Date__c = newEvent.EndDateTime.date();
                    monthlyPlannerList.add(newMonthlyPlanner);
                    if (!monthlyPlannerList.isEmpty()) {
                        insert monthlyPlannerList;
                    }
                    
                    Day_Planner__c newDayPlanner = new Day_Planner__c();
                    newDayPlanner.Name = newMonthlyPlanner.Name;
                    newDayPlanner.Date_of_Execution__c = newEvent.StartDateTime.date();
                    newDayPlanner.Remarks__c = newEvent.Description;
                    newDayPlanner.Monthly_Planner__c = newMonthlyPlanner.id;   
                    DayPlannerList.add(newDayPlanner);
                    
                            if (!DayPlannerList.isEmpty()) {
            insert DayPlannerList;
        }
                    
                    Mill_Planner__c newMillPlan = new Mill_Planner__c();
                    newMillPlan.Name = newDayPlanner.Name;
                    newMillPlan.Plan_Date_Time__c = newEvent.StartDateTime.date();
                    newMillPlan.Day_Planner__c = newDayPlanner.id;
                    MillPlanList.add(newMillPlan);
                }
            
             if (!MillPlanList.isEmpty()) {
            insert MillPlanList;
        }
        }        
    }
}