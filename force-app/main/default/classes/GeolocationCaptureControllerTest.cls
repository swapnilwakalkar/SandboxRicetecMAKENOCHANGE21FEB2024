@isTest
public class GeolocationCaptureControllerTest {
    
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"routes": [{"legs": [{"distance": {"text": "2 km"}}]}]}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    private class MockHttpResponseGenerator2 implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"routes": [{"legs": [{"distance": {"text": "2 m"}}]}]}');
            res.setStatusCode(200);
            return res;
        }
    }
    @isTest
    static void testUpdateGeolocation() {
        
        // ... Your setup code ...
        Account mill = new Account();
        mill.Name = 'testmill';
        mill.Geo_Location__latitude__s = 12.3456;
        mill.Geo_Location__longitude__s = 78.9012;
        insert mill;
        
        
        //create new Territory
        Territory__c trty = new Territory__c();
        trty.name = 'testTerritory';
        insert trty;
        
        // Create Monthly Planner 
        Monthly_Planner__c mp = new Monthly_Planner__c();
        mp.Name = 'testMonth';
        insert mp;
        
        //Create Day Planner
        Day_Planner__c dp = new Day_Planner__c();
        dp.Monthly_Planner__c = mp.Id; 
        dp.Name = 'testDayPlanner';
        dp.Representative_End_Location__Latitude__s = 12.3456;
        dp.Representative_End_Location__Longitude__s = 78.9012;
        dp.Representative_Initial_Location__latitude__s = 12.3456;
        dp.Representative_Initial_Location__longitude__s = 78.9012;
        
        insert dp;
        
        
        
        // Create a Mill Planner record for testing
        Mill_Planner__c millPlanner = new Mill_Planner__c();
        millPlanner.Day_Planner__c = dp.Id; 
        millPlanner.Area__c = trty.Id; 
        millPlanner.Mill_Name__c = mill.id;
        millPlanner.Start_Location__latitude__s = 12.3456;
        millPlanner.Start_Location__longitude__s = 78.9012;
        insert millPlanner;
        
        
        Test.startTest();
        // Testing Apex classes in MillPlanner__C
        GeolocationCaptureController.updateGeolocation(millPlanner.Id, 12.3456, 78.9012, DateTime.now());
        GeolocationCaptureController2.updateGeolocation(millPlanner.Id, 12.3456, 78.9012, DateTime.now(), DateTime.now());
        GeolocationController_endvisit.updateGeolocation(millPlanner.id, 12.3456, 78.9012, DateTime.now());
     
        
        //testing geo on DayPlanner__C
        StoreLocatorPoint.fetchDayVist(dp.Id);
        StoreLocatorPoint.getNearestAccount(dp.Id, '12.3456', '78.9012', '5');
        StoreLocatorPoint.getNearestAccountBasedOnPinCode(dp.Id, '501510');
        
        //Testing Apex Classes in DayPlanner__c
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        dayStartLocationCapture.updateGeolocation(dp.id, 12.3456, 78.9012);
        dayEndLocationCapture.updateGeolocation(dp.id, 12.3456, 78.9012);
        
        Test.stopTest();
        
        // Retrieve the updated Mill Planner record
        Mill_Planner__c updatedMillPlanner = [SELECT Start_Location__Latitude__s, Start_Location__Longitude__s, Status__c
                                              FROM Mill_Planner__c WHERE Id = :millPlanner.Id];
        
        // Perform assertions to verify the update
        System.assertEquals(12.3456, updatedMillPlanner.Start_Location__Latitude__s);
        System.assertEquals(78.9012, updatedMillPlanner.Start_Location__Longitude__s);
        
    }
    
    @isTest
    static void testDistanceGeolocation() {
        // ... Your setup code ...
         Account mill = new Account();
        mill.Name = 'testmill';
        mill.Geo_Location__latitude__s = 12.3456;
        mill.Geo_Location__longitude__s = 78.9012;
        insert mill;
        
        
        //create new Territory
        Territory__c trty = new Territory__c();
        trty.name = 'testTerritory';
        insert trty;
        
        // Create Monthly Planner 
        Monthly_Planner__c mp = new Monthly_Planner__c();
        mp.Name = 'testMonth';
        insert mp;
        
        //Create Day Planner
        Day_Planner__c dp = new Day_Planner__c();
        dp.Monthly_Planner__c = mp.Id; 
        dp.Name = 'testDayPlanner';
        dp.Representative_End_Location__Latitude__s = 12.3456;
        dp.Representative_End_Location__Longitude__s = 78.9012;
        dp.Representative_Initial_Location__latitude__s = 12.3456;
        dp.Representative_Initial_Location__longitude__s = 78.9012;
        
        insert dp;
        
        
        
        // Create a Mill Planner record for testing
        Mill_Planner__c millPlanner = new Mill_Planner__c();
        millPlanner.Day_Planner__c = dp.Id; 
        millPlanner.Area__c = trty.Id; 
        millPlanner.Mill_Name__c = mill.id;
        millPlanner.Start_Location__latitude__s = 12.3456;
        millPlanner.Start_Location__longitude__s = 78.9012;
        insert millPlanner;
        
        // Set up the mock HTTP callout
        Test.startTest(); // Start a new transaction
        
        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call the distanceGeolocation method with appropriate parameters
        String result = GeolocationCaptureController.distanceGeolocation(millPlanner.Id, '12.3456', '78.9012');
        String result1 = GeolocationCaptureController2.distanceGeolocation(millPlanner.Id, '12.3456', '78.9012');
        dayStartLocationCapture.getEstmatedDistance(dp.Id, '12.3456', '78.9012');
        dayEndLocationCapture.getActualdistance(dp.Id, 12.3456, 78.9012);
        dayEndLocationCapture.getActualdistance(dp.Id, 12.3456, 78.9012);
        
        // Perform assertions to verify the result
        System.assertNotEquals(null, result); 
        System.assertNotEquals(null, result1);
        
        
        // Add more specific assertions as needed
        
        Test.stopTest(); // End the transaction
    }
    
    @isTest
    static void testDistanceGeolocationInMeter() {
        
        // ... Your setup code ...
          Account mill = new Account();
        mill.Name = 'testmill';
        mill.Geo_Location__latitude__s = 12.3456;
        mill.Geo_Location__longitude__s = 78.9012;
        insert mill;
        
        
        //create new Territory
        Territory__c trty = new Territory__c();
        trty.name = 'testTerritory';
        insert trty;
        
        // Create Monthly Planner 
        Monthly_Planner__c mp = new Monthly_Planner__c();
        mp.Name = 'testMonth';
        insert mp;
        
        //Create Day Planner
        Day_Planner__c dp = new Day_Planner__c();
        dp.Monthly_Planner__c = mp.Id; 
        dp.Name = 'testDayPlanner';
        dp.Representative_End_Location__Latitude__s = 12.3456;
        dp.Representative_End_Location__Longitude__s = 78.9012;
        dp.Representative_Initial_Location__latitude__s = 12.3456;
        dp.Representative_Initial_Location__longitude__s = 78.9012;
        
        insert dp;
        
        
        
        // Create a Mill Planner record for testing
        Mill_Planner__c millPlanner = new Mill_Planner__c();
        millPlanner.Day_Planner__c = dp.Id; 
        millPlanner.Area__c = trty.Id; 
        millPlanner.Mill_Name__c = mill.id;
        millPlanner.Start_Location__latitude__s = 12.3456;
        millPlanner.Start_Location__longitude__s = 78.9012;
        insert millPlanner;
        
        // Set up the mock HTTP callout
        Test.startTest(); // Start a new transaction
        
        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2());
        
        // Call the distanceGeolocation method with appropriate parameters
        String result = GeolocationCaptureController.distanceGeolocation(millPlanner.Id, '12.3456', '78.9012');
        String result1 = GeolocationCaptureController2.distanceGeolocation(millPlanner.Id, '12.3456', '78.9012');
        dayStartLocationCapture.getEstmatedDistance(dp.Id, '12.3456', '78.9012');
        dayEndLocationCapture.getActualdistance(dp.Id, 12.3456, 78.9012);
         dayEndLocationCapture.getActualdistance(dp.Id, 12.3456, 78.9012);
        
        // Perform assertions to verify the result
        System.assertNotEquals(null, result);
        System.assertNotEquals(null, result1);// Ensure the result is not null
        // Add more specific assertions as needed
        
        Test.stopTest(); // End the transaction
    }
    
}