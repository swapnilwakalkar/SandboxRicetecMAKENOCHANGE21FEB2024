@isTest
public class GetMapLocationTest {
    
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"routes": [{"legs": [{"distance": {"text": "2 km"}}]}]}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    @istest
    Static void getAddressRecommendationsTest(){
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String result = GetMapLocation.getAddressRecommendations('MVSR Engineering Collage');        
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assert(result.contains('2 km'));
    }
     
    @istest
    Static void getAddressDetailsByPlaceIdTest(){
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String result = GetMapLocation.getAddressDetailsByPlaceId('RICETEC');        
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assert(result.contains('2 km'));
    }
    
}