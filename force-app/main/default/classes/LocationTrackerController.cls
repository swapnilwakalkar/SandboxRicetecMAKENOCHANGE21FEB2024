public class LocationTrackerController {
   /* @AuraEnabled(cacheable=true)
    public static Attendance__c getAttendanceRecordId() {
        List<Attendance__c> attendanceRecords = [SELECT Id, Name, Present_Coordinates__Latitude__s, Present_Coordinates__Longitude__s FROM Attendance__c LIMIT 1];
        
        if (!attendanceRecords.isEmpty()) {
            return attendanceRecords[0];
        }
        
        return null;
    }
    
    @AuraEnabled
    public static void updateAttendanceRecord(String recordId,Double latitude, Double longitude) {
    Attendance__c attendance = new Attendance__c();
        attendance.Id = recordId;    
        attendance.Present_Coordinates__latitude__s = latitude;
        attendance.Present_Coordinates__Longitude__s = longitude;    

        try{
            update attendance;
        }catch(Exception ex){
            Throw new AuraHandledException('Error Updating Attendance:' + ex.getMessage());
        }
    }
    */
}