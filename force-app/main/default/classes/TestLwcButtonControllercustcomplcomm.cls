@isTest
public class TestLwcButtonControllercustcomplcomm {

    @isTest
    static void testConstructor() {
        // Create a test record for Cases__c
        Cases__c testComm = new Cases__c(/* Set required field values */);
        insert testComm;
        
        Test.setCurrentPageReference(new PageReference('/apex/CustomerComplaintcommunicationPDF'));
        System.currentPageReference().getParameters().put('id', testComm.Id);
        
        LwcButtonControllercustcomplcomm controller = new LwcButtonControllercustcomplcomm();
        
        // Verify that the constructor sets currentRecordId and comm
        System.assertEquals(testComm.Id, controller.currentRecordId);
        System.assertNotEquals(null, controller.comm);
    }
    
    @isTest
    static void testSendPdf() {
        // Create a test record for Cases__c
        Cases__c testComm = new Cases__c(/* Set required field values */);
        insert testComm;
        
        Test.setCurrentPageReference(new PageReference('/apex/CustomerComplaintcommunicationPDF'));
        System.currentPageReference().getParameters().put('id', testComm.Id);
        
        // Call the sendPdf method
        String result = LwcButtonControllercustcomplcomm.sendPdf(testComm.Id);
        
        // Verify that the method returns the expected result
        System.assertEquals('PDF saved successfully.', result);
        
       
    }
}