/**
* @description       : 
* @author            : Pranav Thatikonda   
* @group             : 
* @last modified on  : 30-10-2023
* @last modified by  : Pranav Thatikonda
**/


/**
* @description       : Test class for GetLeadsFromIndiaMart
* @author            : Pranav Thatikonda   
* @last modified on  : 30-10-2023
* @last modified by  : Pranav Thatikonda
**/

@isTest(SeeAllData=true)
public class GetLeadsFromIndiaMartTest {

    // Nested private class to mock HTTP callouts
    private class MockHttpCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a mock response for the HTTP callout
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"RESPONSE": [{"SENDER_NAME":"John Bro","SENDER_MOBILE":"1234567890","SENDER_MOBILE_ALT":"9876543210","SENDER_EMAIL":"KarthikT@example.com","SENDER_COMPANY":"ABC Inc","QUERY_MESSAGE":"Test <br> Query","QUERY_TYPE":"Test Type","SENDER_COUNTRY_ISO":"US","SENDER_STATE":"CA","SENDER_CITY":"Los Angeles","SENDER_ADDRESS":"123 Main St"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    // Test fetchDataFromURL method
    @isTest(SeeAllData=true)
    static void testFetchDataFromURL() {
        Test.startTest();

        // Set the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout());

        // Call the fetchDataFromURL method
        GetLeadsFromIndiaMart.fetchDataFromURL();
        Test.stopTest();

        // Add assertions here to verify the expected behavior
        // For example, check if leads were created
        Integer leadCount = [SELECT COUNT() FROM Leads__c where FirstName__c = 'John Bro'];
        System.assertEquals(1, leadCount, 'One lead should have been created');
    }
}