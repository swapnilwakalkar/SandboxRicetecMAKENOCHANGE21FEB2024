@isTest
public class captureLatLongcntrlTest {
	@isTest
    static void testUpdateGeolocation() {
        // Create a test Account record
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Define the latitude and longitude values for testing
        Decimal testLatitude = 12.345;
        Decimal testLongitude = 67.890;

        // Call the updateGeolocation method from the controller
        captureLatLongcntrl.updateGeolocation(testAccount.Id, testLatitude, testLongitude);

        // Retrieve the updated Account record
        Account updatedAccount = [SELECT Geo_Location__Latitude__s, Geo_Location__Longitude__s FROM Account WHERE Id = :testAccount.Id];

        // Verify that the Account's latitude and longitude have been updated
        System.assertEquals(testLatitude, updatedAccount.Geo_Location__Latitude__s, 'Latitude should be updated');
        System.assertEquals(testLongitude, updatedAccount.Geo_Location__Longitude__s, 'Longitude should be updated');
    }
}