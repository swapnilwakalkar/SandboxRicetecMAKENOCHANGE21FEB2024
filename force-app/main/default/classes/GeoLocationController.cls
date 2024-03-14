public with sharing class GeoLocationController {
  /*  @AuraEnabled
    public static void updateGeoLocation(Double checkInLatitude, Double checkInLongitude,
        Double checkOutLatitude, Double checkOutLongitude) {
        
        Attendance__c geoLocation = [SELECT Id, Absent_Reason__c, Name, Date__c,
                                     Excused_Absence__c, Present__c, Present_Coordinates__c, Representative__c
                                     FROM Attendance__c LIMIT 1];
        
        if (geoLocation!= null) {
           
            
            if (checkInLatitude != null && checkInLongitude != null) {
                geoLocation.Current_Location_Latitude__c = checkInLatitude;
                geoLocation.Current_Location_Longitude__c = checkInLongitude;
            }
            
            update geoLocation;
        }
    }
    */
}