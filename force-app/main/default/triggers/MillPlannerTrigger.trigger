trigger MillPlannerTrigger on Mill_Planner__c (after update) {
    public static void createFollowupEvent(List<Mill_Planner__c> newMillPlannerList, Map<Id, Mill_Planner__c> oldMillPlannerMap) {
        MillPlannerHandler.createFollowupEvent(newMillPlannerList, oldMillPlannerMap);
    }

    List<Mill_Planner__c> newMillPlannerList = Trigger.new;
    Map<Id, Mill_Planner__c> oldMillPlannerMap = Trigger.oldMap;

    createFollowupEvent(newMillPlannerList, oldMillPlannerMap);
}