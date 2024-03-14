@isTest
public class TestLwcButtonControllercustcomplaint {

    @isTest
    static void testConstructor() {
        // Create a test record for Cases__c
        Cases__c testComplaint = new Cases__c(/* Set required field values */);
        insert testComplaint;
        
        Test.setCurrentPageReference(new PageReference('/apex/CustomerComplaintPDF'));
        System.currentPageReference().getParameters().put('id', testComplaint.Id);
        
        LwcButtonControllercustcomplaint controller = new LwcButtonControllercustcomplaint();
        
        // Verify that the constructor sets currentRecordId and complaint
        System.assertEquals(testComplaint.Id, controller.currentRecordId);
        System.assertNotEquals(null, controller.complaint);
    }
    
    @isTest
    static void testSendPdf() {
        // Create a test record for Cases__c
        Cases__c testComplaint = new Cases__c(/* Set required field values */);
        insert testComplaint;
        
        Test.setCurrentPageReference(new PageReference('/apex/CustomerComplaintPDF'));
        System.currentPageReference().getParameters().put('id', testComplaint.Id);
        
        // Call the sendPdf method
        String result = LwcButtonControllercustcomplaint.sendPdf(testComplaint.Id);
        
        // Verify that the method returns the expected result
        System.assertEquals('PDF saved successfully.', result);
        
        
    }
}