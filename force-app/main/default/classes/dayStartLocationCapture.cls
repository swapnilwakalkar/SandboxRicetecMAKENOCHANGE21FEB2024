public class dayStartLocationCapture {

    @AuraEnabled public static void updateGeolocation(Id dayId, Decimal lat, Decimal lng) {
        Day_Planner__c dayToUpdate = [SELECT Id,Representative_Initial_Location__c, Representative_Initial_Location__Latitude__s,Representative_Initial_Location__Longitude__s FROM Day_Planner__c WHERE Id = :dayId];
        dayToUpdate.Representative_Initial_Location__Latitude__s = lat;
        dayToUpdate.Representative_Initial_Location__Longitude__s = lng;
        system.debug('Lat value-->' +lat);
        system.debug('Lng value-->' +lng);
        
        update dayToUpdate;
        
        getEstmatedDistance(dayId, String.valueOf(lat), String.valueOf(lng));
    }
    
    @future(callout=true)
    public Static void getEstmatedDistance(String dayId, String startLat, String startLng){
        List<Mill_Planner__c> storeVisitLocationList  = [SELECT id, Mill_Name__r.Name, Mill_Name__c, 
                                                                  Mill_Name__r.Geo_Location__c,
                                                                  Mill_Name__r.Geo_Location__latitude__s, 
                                                                  Day_Planner__r.Representative_Initial_Location__c,
                                                                  Mill_Name__r.Geo_Location__longitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__latitude__s,
                                                                  Day_Planner__r.Representative_Initial_Location__longitude__s,
                                                                  Day_Planner__r.Representative_End_Location__Latitude__s,
                                                                  Day_Planner__r.Representative_End_Location__Longitude__s,
                                                                  Day_Planner__r.Actual_Distance__c
                                                                  FROM Mill_Planner__c
                                                                  WHERE Day_Planner__c =: dayId AND Mill_Name__r.Geo_Location__latitude__s != NULL
                                                                  AND Mill_Name__r.Geo_Location__longitude__s != NULL
                                                                  ];
        
        List<String> wayPointList = new List<String>();
        String dayLocationLat = String.valueOf(storeVisitLocationList[0].Day_Planner__r.Representative_Initial_Location__latitude__s);
        String dayLocationLan = String.valueOf(storeVisitLocationList[0].Day_Planner__r.Representative_Initial_Location__longitude__s);
        
        for(Mill_Planner__c storeVisitPlan : storeVisitLocationList){
            wayPointList.add(String.valueOf(storeVisitPlan.Mill_Name__r.Geo_Location__latitude__s + ','+ 
                                            storeVisitPlan.Mill_Name__r.Geo_Location__longitude__s + '|'));
        }
        
        
        String wayPointStr = String.valueOf(wayPointList);
        String wayPointRemovefirstSymbol = wayPointStr.remove('('); 
        String wayPointRemoveLastSymbol = wayPointRemovefirstSymbol.remove(')'); 
        String wayPoints = wayPointRemoveLastSymbol.replace('|,','|via:');
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=' + dayLocationLat+ ',' + dayLocationLan
                +'&destination='+String.valueOf(startLat) + ',' + String.valueOf(startLng) +'&waypoints=via:'+ wayPoints +'&key=AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';
            String endPointURL = url.replace(' ', '%20');
            request.setEndpoint(endPointURL);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            String jsonStr = response.getBody();
            WayPointsWrapper obj = (WayPointsWrapper) JSON.deserialize(jsonStr, WayPointsWrapper.class);
            String jsonString = JSON.serialize(obj);
            Map < String, Object > result = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            Map < String, Object > mapData = WayPointsWrapper.mapResult(result);
            Map < String, Object > distanceData = (Map < String, Object > ) mapData.get('distance');
            String distanceValue = String.valueOf(distanceData.get('text'));
            String distance;
            if(distanceValue.contains(' km')){
                distance =  distanceValue.replace(' km', '');
            }else if(distanceValue.contains(' m')){
                distance = String.valueOf(Integer.valueOf(distanceValue.replace(' m', ''))/1000);
            }
            Day_Planner__c dayToUpdate = [SELECT Id, Estimated_Distance_Kms__c FROM Day_Planner__c WHERE Id = :dayId];
            
            dayToUpdate.Estimated_Distance_Kms__c = Integer.valueOf(distance);
            
            update dayToUpdate;
        }Catch(Exception e){
            System.debug('exception====>>>'+e.getMessage());
        }
    }
}