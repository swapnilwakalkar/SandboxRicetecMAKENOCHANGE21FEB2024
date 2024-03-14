public with sharing class GetCoordinateforAccount {
    @AuraEnabled
    public static void updateGeolocation(String accountId, Decimal latitude, Decimal longitude) {
        if (String.isNotBlank(accountId) && latitude != null && longitude != null) {
            // Update the Geolocation fields in the Account object.
            Account acc = new Account(Id = accountId);
            acc.Geo_Location__Latitude__s = latitude;
            acc.Geo_Location__Longitude__s = longitude;
            update acc;
        }
    }
}