@isTest
    global class MockHttpResponseGenerator implements HttpCalloutMock {
        global HTTPResponse respond(HTTPRequest req){
            Decimal logoutlat=17.4030848;
            Decimal logoutlong=78.544896;
            try{
           if(req.getEndpoint()=='https://maps.googleapis.com/maps/api/geocode/json?latlng=' +
                         logoutlat + ',' + logoutlong + '&key=AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c'){
                HttpResponse res= new HttpResponse();
                res.setHeader('Content-Type','application/json');
                res.setBody('{"Name ":"Test Name"}');
                res.setStatusCode(200);
                return res;
             } 
        }catch(Exception ex){
                System.debug('ERROR Message>>>'+ex.getMessage()+' Error Line Number>>> '+ex.getLineNumber());
        }
            return null;
         }
    }