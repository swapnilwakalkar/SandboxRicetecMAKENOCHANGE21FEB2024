public class StoreLocatorPoint {
    
    @AuraEnabled
    public static List<Mill_Planner__c> fetchDayVist(String dayVisitId){
        List<Mill_Planner__c> storeList = [SELECT id, Name, Status__c, Plan_Date_Time__c, Area__c, Area__r.Name, Mill_Name__r.Name,
                                                    Mill_Name__r.Geo_Location__Latitude__s,Mill_Name__r.Geo_Location__Longitude__s,Mill_Name__r.Area__c,
                                                    Mill_Name__r.area__r.Name,Day_Planner__c,
                                                    Day_Planner__r.Representative_Initial_Location__Latitude__s,
                                                    Day_Planner__r.Representative_Initial_Location__Longitude__s
                                                    FROM Mill_Planner__c
                                                    WHERE Day_Planner__c =: dayVisitId];
        
        system.debug('Store Visit List-->' +storeList);
        return storeList;
    }
    

    @AuraEnabled
    public static getRemainingStoresWrapper getNearestAccount(String dayVisitId, String latitude, String longitude, String getRadius){
        Map<Id, Decimal> mapOfAccountIdToDistance = new Map<Id, Decimal>();
        Decimal minValue = Decimal.valueOf(getRadius);

        List<Account> lessThan5KmAccountist = new List<Account>();
        Day_Planner__c getDayVisitPlan = [SELECT Id, Area__c,Area__r.Parent_Location__r.Name,
                                                  Representative_Initial_Location__Latitude__s,Representative_Initial_Location__Longitude__s
                                                  FROM Day_Planner__c WHERE Id =: dayVisitId LIMIT 1];
        Location getcurrentLocation = Location.newInstance(Double.valueOf(latitude),Double.valueOf(longitude));
       // Location getcurrentLocation = Location.newInstance(getDayVisitPlan.p360_Day_Visit_Start_Location__Latitude__s, getDayVisitPlan.p360_Day_Visit_Start_Location__Longitude__s);
        for(Account acc : [SELECT Id , Name, Geo_Location__Latitude__s, 
                          Area__c,Area__r.Name,
                           
                           Geo_Location__Longitude__s 
                           FROM Account 
                           WHERE Geo_Location__Latitude__s != null AND 
                           Geo_Location__Longitude__s != null Limit 50000]){
                               Location accLocation = Location.newInstance(acc.Geo_Location__Latitude__s, acc.Geo_Location__Longitude__s);
                               Decimal dist = Location.getDistance(getcurrentLocation, accLocation, 'km');
                               mapOfAccountIdToDistance.put(acc.Id, dist.setScale(2, RoundingMode.HALF_UP));
                               if(dist < minValue){
                                   lessThan5KmAccountist.add(acc); 
                               }                             
                           }
        GetRemainingStoresWrapper wrap = new GetRemainingStoresWrapper();
        wrap.acc = lessThan5KmAccountist;
        wrap.dayVisitPlan = getDayVisitPlan;
        wrap.mapOfAccountIdToDistance = mapOfAccountIdToDistance;
        return wrap;
    }
    
    @AuraEnabled
    public static GetRemainingStoresWrapperbyPinCode getNearestAccountBasedOnPinCode(String dayVisitId, String pinCode){
        Day_Planner__c getDayVisitPlan = [SELECT Id, Area__c,Area__r.Parent_Location__r.Name,
                                                  Representative_Initial_Location__Latitude__s,Representative_Initial_Location__Longitude__s
                                                  FROM Day_Planner__c WHERE Id =: dayVisitId LIMIT 1];
        string tempInput = '%' + String.valueOf(pinCode) + '%';
        list<Account> accList =  [SELECT Id , Name,Geo_Location__Latitude__s, 
                                  Area__c,
                                  BillingPostalCode ,
                                  Area__r.Name,
                                  Geo_Location__Longitude__s 
                                  FROM Account 
                                  WHERE BillingPostalCode LIKE: tempInput Limit 50000];                            
        GetRemainingStoresWrapperbyPinCode wrap = new GetRemainingStoresWrapperbyPinCode();
        wrap.acc = accList;
        wrap.dayVisitPlan = getDayVisitPlan;
        return wrap;
    }
    
    public class GetRemainingStoresWrapper{
        @AuraEnabled
        public List<Account> acc{get;set;}
        @AuraEnabled
        public Day_Planner__c dayVisitPlan {get;set;}
        @AuraEnabled
        public Map<Id, Decimal> mapOfAccountIdToDistance {get;set;}
    }
    
     public class GetRemainingStoresWrapperbyPinCode{
        @AuraEnabled
        public List<Account> acc{get;set;}
        @AuraEnabled
        public Day_Planner__c dayVisitPlan {get;set;}
    }
    
}