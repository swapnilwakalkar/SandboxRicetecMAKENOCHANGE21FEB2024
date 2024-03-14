public class GoogleShowDirectionsCtrl {
    public String currentRecordId;
    public String startLocation {get;set;}
    public String endLocation {get;set;}
    public List<String> storeVisitString{get;set;}
    public String startDayVisitLat {get;set;}
    public String startDayVisitLng {get;set;}
    List<Mill_Planner__c> storeVisitLocationList{set;get;}
    
    public GoogleShowDirectionsCtrl(ApexPages.StandardController controller) {
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        storeVisitString = new List<String>();
        storeVisitLocationList  = [SELECT id, Mill_Name__r.Name, Mill_Name__c, Mill_Name__r.Geo_Location__c,
                                                                  Mill_Name__r.Geo_Location__latitude__s, Day_Planner__r.Representative_Initial_Location__c,
                                                               	   Mill_Name__r.Geo_Location__longitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__latitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__longitude__s
                                                                  FROM Mill_Planner__c
                                                                  WHERE Day_Planner__c =: currentRecordId AND Mill_Name__r.Geo_Location__latitude__s != NULL
                                                                  AND Mill_Name__r.Geo_Location__longitude__s != NULL];
        
        for(Mill_Planner__c storeVisitPlan : storeVisitLocationList){
           	storeVisitString.add(string.valueOf(storeVisitPlan.Mill_Name__r.Geo_Location__latitude__s+';'+storeVisitPlan.Mill_Name__r.Geo_Location__longitude__s));
            startDayVisitLat = String.valueOf(storeVisitPlan.Day_Planner__r.Representative_Initial_Location__latitude__s);
            startDayVisitLng = String.valueOf(storeVisitPlan.Day_Planner__r.Representative_Initial_Location__longitude__s);
        }
    }
    
    public List<SelectOption> getstartLocations(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));
        options.add(new SelectOption(startDayVisitLat+','+startDayVisitLng,'Day Visit Start Location'));       
        for(Mill_Planner__c con : storeVisitLocationList)
        {       
            options.add(new SelectOption(string.valueOf(con.Mill_Name__r.Geo_Location__latitude__s+','+con.Mill_Name__r.Geo_Location__longitude__s),con.Mill_Name__r.Name));
        }        
        return options;
    } 
    
    public List<SelectOption> getendLocations(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));               
        for(Mill_Planner__c con : storeVisitLocationList)
        {
             
            if(startLocation!=string.valueOf(con.Mill_Name__r.Geo_Location__latitude__s+','+con.Mill_Name__r.Geo_Location__longitude__s)){
                options.add(new SelectOption(string.valueOf(con.Mill_Name__r.Geo_Location__latitude__s+','+con.Mill_Name__r.Geo_Location__longitude__s),con.Mill_Name__r.Name));
            }
             
        }
        return options;
    }
}