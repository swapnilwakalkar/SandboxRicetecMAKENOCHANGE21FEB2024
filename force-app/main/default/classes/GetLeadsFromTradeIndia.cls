/**
* @description       : 
* @author            : Pranav Thatikonda   
* @group             : 
* @last modified on  : 30-10-2023
* @last modified by  : Pranav Thatikonda
**/
global class GetLeadsFromTradeIndia implements Schedulable {  
     private static final String URL = 'https://www.tradeindia.com/utils/my_inquiry.html?userid=1559850&profile_id=1864910&key=7691361075cce7ee188093fa36606b8a';
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
        String dynamicURL = URL + '&from_date=' + startDateTimeStr + '&to_date=' + endDateTimeStr;
        
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
    // Method to parse the retrieved data and create Lead records
    global static void createLeadsFromData(String data) {
    if (data != null) {
        List<Object> responseList = (List<Object>) JSON.deserializeUntyped(data);
        
        List<Leads__c> leadsToInsert = new List<Leads__c>();
        
        for (Object obj : responseList) {
            Map<String, Object> leadData = (Map<String, Object>) obj;
            
            Leads__c lead = new Leads__c();
          	
            lead.FirstName__c  = (String) leadData.get('sender_name');
            lead.Phone__c  = (String) leadData.get('sender_mobile');
            lead.Mobile__c = (string) leadData.get('sender_other_mobiles');
            lead.Company__c  = (String) leadData.get('sender_co');
            String queryMessage = (String) leadData.get('message');
            queryMessage = queryMessage.replaceAll('<br\\s*/?>', '\n');
            lead.Description__c = queryMessage;
            lead.Email__c = (String) leadData.get('sender_email');
            lead.Country__c = (string) leadData.get('sender_country');
            lead.State__c= (string) leadData.get('sender_state');
            lead.District__c = (string) leadData.get('sender_city');
            lead.Village__c = (string) leadData.get('address');
            lead.EnquiryType__c = (string) leadData.get('inquiry_type');   
            lead.Lead_Source__c = 'TradeIndia';
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
    public void execute(SchedulableContext sc) {
        fetchDataFromURL();
    }
}