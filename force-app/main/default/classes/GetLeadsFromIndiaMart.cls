/**
* @description       : 
* @author            : Pranav Thatikonda   
* @group             : 
* @last modified on  : 30-10-2023
* @last modified by  : Pranav Thatikonda
**/
global class GetLeadsFromIndiaMart implements Schedulable {   
    // Specify the URL here
    private static final String URL = 'https://mapi.indiamart.com/wservce/crm/crmListing/v2/?glusr_crm_key=mR27Grpr7XzGSPes7nCN7luKo1TGnTM=';
    
    // Method to perform HTTP callout
    @future(callout=true)
    global static void fetchDataFromURL() {
        
        // Calculate the start and end date/time dynamically
        DateTime currentDateTime = DateTime.now();
        DateTime startDateTime = currentDateTime.addDays(-1);
        DateTime endDateTime = currentDateTime;
        
        // Format the start and end date/time in the required format
        String startDateTimeStr = startDateTime.format('yyyy-MM-dd');
        String endDateTimeStr = endDateTime.format('yyyy-MM-dd');
        
        // Construct the dynamic URL with the start and end date/time parameters
        String dynamicURL = URL + '&start_time=' + startDateTimeStr + '&end_time=' + endDateTimeStr;
        
        HttpRequest httpRequest = new HttpRequest();
        HttpResponse httpResponse = new HttpResponse();
        Http http = new Http();
        
        httpRequest.setEndpoint(dynamicURL);
        httpRequest.setMethod('GET');
        
        try {
            httpResponse = http.send(httpRequest);
            String responseBody = httpResponse.getBody();
            System.debug('Response: ' + responseBody);
            createLeadsFromData(responseBody);
        } catch (Exception ex) {
            System.debug('Error in HTTP request: ' + ex.getMessage());
        }
    }
    
    // Method to parse the retrieved Data and create Lead records
    global static void createLeadsFromData(String data) {
        if (data != null) {
            Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(data);
            
            List<Object> responseList = (List<Object>) parsedData.get('RESPONSE');
            
            List<Leads__c> leadsToInsert = new List<Leads__c>();
            
            for (Object obj : responseList) {
                Map<String, Object> leadData = (Map<String, Object>) obj;
                
                Leads__c lead = new Leads__c();
                lead.FirstName__c  = (String) leadData.get('SENDER_NAME');
                lead.Phone__c  = (String) leadData.get('SENDER_MOBILE');
                lead.Mobile__c = (String) leadData.get('SENDER_MOBILE_ALT');
                lead.email__C = (String) leadData.get('SENDER_EMAIL');
                lead.Company__c  = (String) leadData.get('SENDER_COMPANY');
                String queryMessage = (String) leadData.get('QUERY_MESSAGE');
                queryMessage = queryMessage.replaceAll('<br\\s*/?>', '\n');
                lead.Description__c = queryMessage;
                lead.EnquiryType__c = (string) leadData.get('QUERY_TYPE');
                lead.Lead_Source__c = 'IndiaMart';
                lead.Country__c = (string) leadData.get('SENDER_COUNTRY_ISO');
                lead.State__c= (string) leadData.get('SENDER_STATE');
                lead.District__c = (string) leadData.get('SENDER_CITY');
                lead.Village__c = (string) leadData.get('SENDER_ADDRESS');
                leadsToInsert.add(lead);
            }
            
            if (!leadsToInsert.isEmpty()) {
                Database.SaveResult[] saveResults = Database.insert(leadsToInsert, false);
                for (Database.SaveResult saveResult : saveResults) {
                    if (saveResult.isSuccess()) {
                        System.debug('Lead inserted successfully. ID: ' + saveResult.getId());
                    } else {
                        System.debug('Error inserting Lead: ' + saveResult.getErrors()[0].getMessage());
                    }
                }
            }
        }
    }
    
    // Implement the execute method required by the Schedulable interface
    global void execute(SchedulableContext sc) {
        fetchDataFromURL();
    }    
}