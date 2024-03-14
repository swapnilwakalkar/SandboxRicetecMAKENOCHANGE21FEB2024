public class GetMapLocation {
    @AuraEnabled
    public static String getAddressRecommendations(String searchText){
        String apiKey = 'AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';//YOUR_API_KEY
        String result = null;
        try{
            if(searchText != null){
                String apiUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + searchText.replace(' ', '%20') + '&key=' + apiKey; 
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(apiUrl);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                if(statusCode == 200){
                    result = res.getBody();
                }
            }
        } catch(exception e){
            System.debug(e.getMessage());
        }
        return result;
    }
    
    //Method to call Google Map API and fetch the address details by placeId 
    @AuraEnabled
    public static String getAddressDetailsByPlaceId(String placeId){
        String apiKey = 'AIzaSyDiUJkRB6xUmdQQEcBqaysho7Wmu26oD9c';//YOUR_API_KEY
        String result = null;
        try{
            if(placeId != null){
                String apiUrl = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + placeId.replace(' ', '%20') + '&key=' + apiKey; 
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(apiUrl);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                if(statusCode == 200){
                    result = res.getBody();
                }
            }
        } catch(exception e){
            System.debug(e.getMessage());
        }
        return result;
    }
}