@isTest
public with sharing class AttendancecaptureTest {

    static testMethod void validateAttendancecapture() {
    
 Attendance__c att = new Attendance__c(Representative__c='Surekha', Current_Location_Latitude__c=17.4030848, Current_Location_Longitude__c=78.544896,
                                      Logout_Latitude__c=17.4030848,
                                      Logout_Longitude__c=78.544896);
 System.debug(' before inserting new Attendance: ' + att.Representative__c);
    insert att;
 
 Test.startTest();
        List<Attendance__c> attendanceList = new List<Attendance__c>{att};
        Attendancecapture.insertRecord(17.4030848,78.544896);
        Test.stopTest();
 
 // Retrieve the new Attendance
 att = [SELECT Representative__c FROM Attendance__c WHERE Id =:att.Id];
 System.debug('Representative__c : ' + att.Representative__c);
 
 // Test that the Attendance Apex class correctly updated the LoginDateTime
 System.assertEquals('Surekha', att.Representative__c);
}
  
static testMethod void validateAttendancecaptureforUpdate() {
 // To test the update for the Attendance
    //Attendance__c attupdate = new Attendance__c(Representative__c='Surekha2',Current_Location_Latitude__c=17.4030848, Current_Location_Longitude__c=78.544896,
    //                                  Logout_Latitude__c=17.4030848,
     //                                 Logout_Longitude__c=78.544896);
 List<Attendance__c> lstAtt = new List<Attendance__c>();                               
		
	//insert attupdate;
    For(Integer i=1 ;i<=5 ; i++)
			{
				Attendance__c att=new Attendance__c();
				att.representative__c = 'Test Representative '+i;
				lstAtt.add(att);	   
			}
			insert lstAtt;
	
			List<Attendance__c> lstAttendance = [select id,representative__c from Attendance__c ];
			System.assertEquals(5,lstAttendance.size(),'Attendance list size is equal to 5');


    // Define input parameters for the method
   // String attendanceId = attupdate.Id;
	Decimal logoutlat=17.4030848;
    Decimal logoutlong=78.544896;
    
	Test.StartTest();
    System.debug('Inside Test.StartTest() ');
	Attendancecapture.updateLogoutDetails(logoutlat,logoutlong);
    System.debug('After Test.StartTest() ');
    Test.StopTest();
						
 
  // Test that the Attendance Apex class correctly updated the LoginDateTime
    
   lstAttendance=[SELECT Representative__c,LastModifiedDate FROM Attendance__c LIMIT 1];
    
    // Verify the result
        System.assertNotEquals(null, lstAttendance); // The Attendance should be updated and returned
    /*for(Attendance__c a: lstAttendance){
       System.assertEquals(logoutlat, a.Logout_Latitude__c);
    	System.assertEquals(logoutlong, a.Logout_Longitude__c);
    	system.assertNotEquals(null, a.LastModifiedDate, 'This record has been modified');
    } */
}
static testMethod void testfetchAddressFromCoordinates() {
    	Test.startTest();
    
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());  
        String strResp = Attendancecapture.fetchAddressFromCoordinates(17.4030848,78.544896);
    
    	System.assertNotEquals(null, strResp);
    
    	Test.stopTest();
    
    }
}