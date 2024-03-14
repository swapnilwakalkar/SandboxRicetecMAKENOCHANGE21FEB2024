/**
* @description       : 
* @author            : Pranav Thatikonda   
* @group             : 
* @last modified on  : 30-10-2023
* @last modified by  : Pranav Thatikonda
**/
@isTest(SeeAllData=true)
public class GetLeadsFromTradeIndiaTest {

    // Nested private class to mock HTTP callouts
    private class MockHttpCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response for the HTTP callout
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"sender_name":"John Doe","sender_mobile":"1234567890","sender_other_mobiles":"9876543210","sender_co":"ABC Inc","message":"Test Message","sender_email":"pranavT@example.com","sender_country":"US","sender_state":"CA","sender_city":"Los Angeles","address":"123 Main St","inquiry_type":"Test Type"}]');
            res.setStatusCode(200);
            return res;
        }
    }

    // Test fetchDataFromURL method
    @isTest(SeeAllData=true)
    static void testFetchDataFromURL() {
        Test.startTest();

        // Create a mock response for the HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout());

        // Call the fetchDataFromURL method
        GetLeadsFromTradeIndia.fetchDataFromURL();
        Test.stopTest();

        // Add assertions here to verify the expected behavior
        // For example, check if leads were created
          Integer leadCount = [SELECT COUNT() FROM Leads__c where FirstName__c = 'John Doe'];
        System.assertEquals(1, leadCount, 'One lead should have been created');
    }
}