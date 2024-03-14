public with sharing class GeolocationCaptureController2 {
    
    //Function to update storevisit with geolocation
    @AuraEnabled 
    public static void updateGeolocation(Id storeId, Decimal lat, Decimal lng, Datetime loginTime, Datetime	logoutTime  ) {
        	Mill_Planner__c storeToUpdate = [SELECT Id FROM Mill_Planner__c WHERE Id = :storeId];
        storeToUpdate.Start_Location__Latitude__s = lat;
        storeToUpdate.Start_Location__Longitude__s = lng;
        storeToUpdate.Mill_Start_Date_Time__c = loginTime;
        storeToUpdate.Mill_End_Date_Time__c = logoutTime;
        system.debug('Lat value-->' +lat);
        system.debug('Lng value-->' +lng);
      
        update storeToUpdate;
    }
    
    @AuraEnabled 
    public static String distanceGeolocation(Id storeId, String startLat, String startLng) {
        Mill_Planner__c storeVisit = [SELECT Id, Mill_Name__r.Geo_Location__c, Mill_Name__r.Geo_Location__Latitude__s,
                                               Mill_Name__r.Geo_Location__longitude__s
                                               FROM Mill_Planner__c WHERE Id = :storeId];
        
        List<String> wayPointList = new List<String>();
        String dayLocationLat = String.valueOf(storeVisit.Mill_Name__r.Geo_Location__latitude__s);
        String dayLocationLan = String.valueOf(storeVisit.Mill_Name__r.Geo_Location__longitude__s);
        wayPointList.add(String.valueOf(storeVisit.Mill_Name__r.Geo_Location__latitude__s + ','+ 
                                        storeVisit.Mill_Name__r.Geo_Location__longitude__s + '|'));
        
        
        String wayPointStr = String.valueOf(wayPointList);
        String wayPointRemovefirstSymbol = wayPointStr.remove('('); 
        String wayPointRemoveLastSymbol = wayPointRemovefirstSymbol.remove(')'); 
        String wayPoints = wayPointRemoveLastSymbol.replace('|,','|via:');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=' + dayLocationLat+ ',' + dayLocationLan
            +'&destination='+startLat + ',' + startLng +'&waypoints=via:'+ wayPoints +'&key=AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';
        String endPointURL = url.replace(' ', '%20');
        request.setEndpoint(endPointURL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('response=====>>>>'+response);
        System.debug('response====>>>'+response.getBody());
        if(response.getStatuscode()==200){
            String jsonStr = response.getBody();
            WayPointsWrapper obj = (WayPointsWrapper) JSON.deserialize(jsonStr, WayPointsWrapper.class);
            String jsonString = JSON.serialize(obj);
            Map < String, Object > result = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            Map < String, Object > mapData = WayPointsWrapper.mapResult(result);
            Map < String, Object > distanceData = (Map < String, Object > ) mapData.get('distance');
            String distanceValue = String.valueOf(distanceData.get('text'));
            Decimal kmToMeter;
            String distance;
            if(distanceValue.contains(' km')){
                distance =  distanceValue.replace(' km', '');
                kmToMeter = Decimal.valueOf(distance)*1000;
                if(kmToMeter > 5){
                    return 'Your current geolocation is more than 5mts away from store location';
                }else{
                    return 'Your current geolocation is less than 5mts away from store location';
                }
            }else if(distanceValue.contains(' m')){
                if(kmToMeter > 5){
                    return 'Your current geolocation is more than 5mts away from store location';
                }else{
                    return 'Your current geolocation is less than 5mts away from store location';
                }
            }
        }
        return null;
        
    }
}