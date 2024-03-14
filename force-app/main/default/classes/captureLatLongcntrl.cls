public class captureLatLongcntrl {
	
    @AuraEnabled public static void updateGeolocation(Id dayId, Decimal lat, Decimal lng) {
        
        Account dayToUpdate = [SELECT Id,Geo_Location__Latitude__s,Geo_Location__Longitude__s FROM Account WHERE Id = :dayId];
        dayToUpdate.Geo_Location__Latitude__s = lat;
        dayToUpdate.Geo_Location__Longitude__s = lng;
        system.debug('Lat value-->' +lat);
        system.debug('Lng value-->' +lng);
        
        update dayToUpdate;
        
        
    }
}