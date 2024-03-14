public with sharing class GoogleMapDistanceCtrl {
    public List<String> storeVisitString	{get;set;}
    public String currentRecordId			{get;set;}
    public String startDayVisitLat			{set;get;}
    public String startDayVisitLng			{set;get;}
    public String endDayVisitLat			{set;get;}
    public String endDayVisitLng			{set;get;}
    public String estimatedDistance			{set;get;}
    public List<String> storeNames {get;set;}
    
    
    public GoogleMapDistanceCtrl(ApexPages.StandardController controller) {
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        System.debug('currentRecordId====>>>>>>'+currentRecordId);
        storeVisitString = new List<String>();
        storeNames = new List<String>();
        List<Mill_Planner__c> storeVisitLocationList  = [SELECT Id,
                                                                  Mill_Name__r.Name,
                                                                  Mill_Name__r.Geo_Location__latitude__s,
                                                                  Day_Planner__r.Representative_End_Location__c,
                                                                  Day_Planner__r.Representative_Initial_Location__latitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__longitude__s, 
                                                                  Day_Planner__r.Representative_End_Location__latitude__s,
                                                                  Day_Planner__r.Representative_End_Location__longitude__s,
                                                                  Mill_Name__r.Geo_Location__longitude__s FROM Mill_Planner__c
                                                                  WHERE Day_Planner__c =: currentRecordId 
                                                                  AND Mill_Name__r.Geo_Location__latitude__s != NULL
                                                                  AND Mill_Name__r.Geo_Location__longitude__s != NULL 
                                                                  ORDER BY Sequence__c DESC];
         
        for(Mill_Planner__c storeVisit : storeVisitLocationList){
            storeVisitString.add(String.valueOf(storeVisit.Mill_Name__r.Geo_Location__latitude__s+';'+storeVisit.Mill_Name__r.Geo_Location__longitude__s));
            startDayVisitLat = String.valueOf(storeVisit.Day_Planner__r.Representative_Initial_Location__latitude__s);
            startDayVisitLng = String.valueOf(storeVisit.Day_Planner__r.Representative_Initial_Location__longitude__s);
            storeNames.add(storeVisit.Mill_Name__r.Name);
            if(storeVisit.Day_Planner__r.Representative_End_Location__latitude__s != NULL){
                endDayVisitLat = String.valueOf(storeVisit.Day_Planner__r.Representative_End_Location__latitude__s);
                endDayVisitLng = String.valueOf(storeVisit.Day_Planner__r.Representative_End_Location__longitude__s);
            }else{
                endDayVisitLat = String.valueOf(storeVisit.Day_Planner__r.Representative_Initial_Location__latitude__s);
                endDayVisitLng = String.valueOf(storeVisit.Day_Planner__r.Representative_Initial_Location__longitude__s);
            }
        }
    }
}