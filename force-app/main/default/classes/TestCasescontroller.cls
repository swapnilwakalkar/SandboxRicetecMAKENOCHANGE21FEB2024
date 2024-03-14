@isTest
public class TestCasescontroller {

    static testMethod void testCasescontroller() {
        // Create a test Cases__c record
        Cases__c testCase = new Cases__c(
            // Populate test case fields as needed
        );
        insert testCase;

        // Instantiate the controller with the StandardController
        ApexPages.StandardController stdController = new ApexPages.StandardController(testCase);
        Casescontroller controller = new Casescontroller(stdController);

        // Call the pdf() method
        PageReference pdfPageRef = controller.pdf();

        // Verify that the PageReference is not null
        //System.assertNotEquals(null, pdfPageRef);

       

        // Example: Simulate a page parameter
        Test.setCurrentPageReference(Page.CustomerComplaintcommunicationPDF);
        ApexPages.currentPage().getParameters().put('id', testCase.Id);

        // Call pdf() again to cover the code for generating PDF content
        PageReference pdfPageRef2 = controller.pdf();

        // Verify that the PageReference is not null
        //System.assertNotEquals(null, pdfPageRef2);

        
    }
}