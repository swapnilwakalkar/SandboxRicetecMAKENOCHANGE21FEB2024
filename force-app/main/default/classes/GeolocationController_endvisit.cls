public class GeolocationController_endvisit {

    //Function to update storevisit with geolocation
    @AuraEnabled public static void updateGeolocation(Id storeId, Decimal lat, Decimal lng, DateTime EndMillVisitTime, String feedback) {
        Mill_Planner__c storeToUpdate = [SELECT Id, Status__c, Start_Location__latitude__s, 
                                                  Start_Location__longitude__s 
                                                  FROM Mill_Planner__c WHERE Id =: storeId
                                                ];
        //storeToUpdate.p360_Status__c = 'Completed';
        storeToUpdate.End_Location__Latitude__s = lat;
        storeToUpdate.End_Location__Longitude__s = lng;
        storeToUpdate.Mill_End_Date_Time__c = EndMillVisitTime;
        
        // Check if feedback is provided before updating the status
        if (String.isNotBlank(feedback)) {
            storeToUpdate.Status__c = 'Completed';
            storeToUpdate.Feedback__c = feedback; // Assuming Feedback__c is the API name of the feedback field
            update storeToUpdate;
            System.debug('storeToUpdate updated: ' + storeToUpdate);
        } else {
            // If feedback is blank, do not update status and throw an error message
            throw new AuraHandledException('Please enter feedback before completing the visit.');
        }
    }
}