public class dayEndLocationCapture {
    
     @AuraEnabled 
    public static void updateGeolocation(Id storeId, Decimal lat, Decimal lng) {
        Day_Planner__c dayToUpdate = [SELECT Id,Status__c, Representative_Initial_Location__c, Actual_Distance__c FROM Day_Planner__c 
                                              WHERE Id = :storeId];
        dayToUpdate.Representative_End_Location__Latitude__s = lat;
        dayToUpdate.Representative_End_Location__Longitude__s = lng;
        system.debug('Lat value-->' +lat);
        system.debug('Lng value-->' +lng);
        
        update dayToUpdate;
        getActualdistance(storeId,lat,lng);
    }

    @future(callout=true)
    public Static void getActualdistance(String storeId, Decimal endDayLat, Decimal endDayLng){
        List<Mill_Planner__c> storeVisitLocationList  = [SELECT id, Mill_Name__r.Name, Mill_Name__c, 
                                                                  Mill_Name__r.Geo_Location__c,
                                                                  Mill_Name__r.Geo_Location__latitude__s, 
                                                                  Day_Planner__r.Representative_Initial_Location__c,
                                                                  Mill_Name__r.Geo_Location__longitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__latitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__longitude__s,
                                                                  Day_Planner__r.Representative_End_Location__Latitude__s,
                                                                  Day_Planner__r.Representative_End_Location__Longitude__s,
                                                                  Day_Planner__r.Actual_Distance__c,
                                                                  Start_Location__latitude__s,
                                                                  Start_Location__longitude__s
                                                                  FROM Mill_Planner__c
                                                                  WHERE Day_Planner__c =: storeId 
                                                                  AND Mill_Name__r.Geo_Location__latitude__s != NULL
                                                                  AND Mill_Name__r.Geo_Location__longitude__s != NULL 
                                                                  AND Day_Planner__r.Representative_Initial_Location__latitude__s != NULL
                                                                  AND Day_Planner__r.Representative_Initial_Location__longitude__s != NULL
                                                                  AND Start_Location__latitude__s != NULL
                                                                  AND Start_Location__longitude__s != NULL];
        
        List<String> wayPointList = new List<String>();
        
        for(Mill_Planner__c storeVisitPlan : storeVisitLocationList){
            wayPointList.add(String.valueOf(storeVisitPlan.Start_Location__latitude__s + ','+ 
                                            storeVisitPlan.Start_Location__longitude__s + '|'));  
        }
        System.debug('wayPointList=======>>>>>'+wayPointList);
        String wayPointStr = String.valueOf(wayPointList);
        String wayPointRemovefirstSymbol = wayPointStr.remove('('); 
        String wayPointRemoveLastSymbol = wayPointRemovefirstSymbol.remove(')'); 
        String wayPoints = wayPointRemoveLastSymbol.replace('|,','|via:');
        
        String dayLocationLat = String.valueOf(storeVisitLocationList[0].Day_Planner__r.Representative_Initial_Location__latitude__s);
        String dayLocationLan = String.valueOf(storeVisitLocationList[0].Day_Planner__r.Representative_Initial_Location__longitude__s);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=' + dayLocationLat+ ',' + dayLocationLan
            +'&destination='+String.valueOf(endDayLat)+ ',' + String.valueOf(endDayLng)+'&waypoints=via:'+ wayPoints +'&key=AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';
        String endPointURL = url.replace(' ', '%20');
        request.setEndpoint(endPointURL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String jsonStr = response.getBody();
        System.debug('jsonStr========>>>>>>>'+jsonStr);
        WayPointsWrapper obj = (WayPointsWrapper) JSON.deserialize(jsonStr, WayPointsWrapper.class);
        String jsonString = JSON.serialize(obj);
        Map < String, Object > result = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
        Map < String, Object > mapData = WayPointsWrapper.mapResult(result);
        Map < String, Object > distanceData = (Map < String, Object > ) mapData.get('distance');
        string distanceValue = String.valueOf(distanceData.get('text'));
        string distance;
        if(distanceValue.contains(' km')){
            distance =  distanceValue.replace(' km', '');
        }else if(distanceValue.contains(' m')){
            distance = String.valueOf(Integer.valueOf(distanceValue.replace(' m', ''))/1000);
        }
        System.debug('distance========>>>>>>>'+distance);
        Day_Planner__c dayToUpdate = [SELECT Id, Actual_Distance__c FROM Day_Planner__c WHERE Id = :storeId];
       Decimal  x = Decimal.valueOf(distance);
        dayToUpdate.Actual_Distance__c = x;
        
        update dayToUpdate;
        
    }
    
}