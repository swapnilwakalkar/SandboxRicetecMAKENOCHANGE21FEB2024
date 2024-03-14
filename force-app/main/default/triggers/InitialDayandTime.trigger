trigger InitialDayandTime on Day_Planner__c (before insert, before update) {
     
    for (Day_Planner__c record : Trigger.new) {
        if (record.Representative_Initial_Location__Latitude__s != null && record.Representative_Initial_Location__Longitude__s != null) {
            Initialdateandtime.Updatedatestarttime();
        } else if (record.Representative_End_Location__Latitude__s != null && record.Representative_End_Location__Longitude__s != null) {         
        Initialdateandtime.Updatedateendtime();
        }
    }
}