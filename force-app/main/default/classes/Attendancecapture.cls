public class Attendancecapture {
    @AuraEnabled
 public static Id insertRecord(Decimal lat, Decimal lng) {
    Id userId = UserInfo.getUserId();
    User currentUser = [SELECT Name FROM User WHERE Id = :userId];
    String userName = currentUser.Name;

    Date todayDate = Date.today();

    List<Attendance__c> existingRecords = [SELECT Id FROM Attendance__c
                                            WHERE Representative__c = :userName
                                            AND date__c = :todayDate
                                            AND LogOut_Datetime__c = NULL];

    if (existingRecords.isEmpty()) {
        // Create a new record
        Attendance__c newAttendance = new Attendance__c();
        newAttendance.Representative__c = userName;
        newAttendance.Present__c = true;
        newAttendance.Date__c = todayDate;
        newAttendance.Current_Location_Latitude__c = lat;
        newAttendance.Current_Location_Longitude__c = lng;
        newAttendance.LogIn_DateTime__c = Datetime.now();

        insert newAttendance;

        return newAttendance.Id;
    } else {
        return null; // Record already exists for today and the current user
    }
}

     @AuraEnabled
    public static void updateLogoutDetails(Decimal lat, Decimal lng) {
        try{
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Name FROM User WHERE Id = :userId];
        String userName = currentUser.Name;
        date todayDate = Date.today();
       list< Attendance__c> existingAttendance = [SELECT Id,Representative__c,date__c, Logout_Latitude__c, Logout_Longitude__c, LogOut_Datetime__c
                                           FROM Attendance__c
                                           WHERE Representative__c = :userName AND date__c =:todayDate AND 
                                               LogOut_Datetime__c = NULL ORDER BY createdDate DESC LIMIT 1];
        if(existingAttendance.size()>0){
            System.debug('existingAttendance Size is : ' + existingAttendance.size());
            System.debug('existingAttendance list values : ' + existingAttendance);

        existingAttendance[0].Logout_Latitude__c = lat;
        existingAttendance[0].Logout_Longitude__c = lng;
        existingAttendance[0].LogOut_Datetime__c = Datetime.now();
        
        
        update existingAttendance[0];
        }
        }catch(Exception ex){
            System.debug('Error updating existing Attendance: ' + ex.getMessage());
            throw ex;
        }
  //      return null;   
            
    }
    
     @AuraEnabled
    public static String fetchAddressFromCoordinates(Decimal lat, Decimal lng) {
        String address = '';

        // Create a HTTP request to Google Geocoding API
        String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=' +
                          lat + ',' + lng + '&key=AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            if (responseMap.containsKey('results') && !((List<Object>) responseMap.get('results')).isEmpty()) {
                Map<String, Object> result = (Map<String, Object>) ((List<Object>) responseMap.get('results'))[0];
                if (result.containsKey('formatted_address')) {
                    address = (String) result.get('formatted_address');
                }
            }
        } else {
            System.debug('Error fetching address. HTTP status: ' + res.getStatusCode() + ', Response: ' + res.getBody());
        }

        return address;
    }
}