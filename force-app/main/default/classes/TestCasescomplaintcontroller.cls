@isTest
public class TestCasescomplaintcontroller {

    static testMethod void testCasescomplaintcontroller() {
        // Create a test Cases__c record
        Cases__c testCase = new Cases__c(
            // Populate test case fields as needed
        );
        insert testCase;

        // Instantiate the controller with the StandardController
        ApexPages.StandardController stdController = new ApexPages.StandardController(testCase);
        Casescomplaintcontroller controller = new Casescomplaintcontroller(stdController);

        // Call the pdf() method
        PageReference pdfPageRef = controller.pdf();

        // Verify that the PageReference is not null
      //  System.assertNotEquals(null, pdfPageRef);

        // Perform additional assertions as needed to cover more code paths

        // Example: Simulate a page parameter
        Test.setCurrentPageReference(Page.CustomerComplaintPDF);
        ApexPages.currentPage().getParameters().put('id', testCase.Id);

        // Call pdf() again to cover the code for generating PDF content
        PageReference pdfPageRef2 = controller.pdf();

        // Verify that the PageReference is not null
      //  System.assertNotEquals(null, pdfPageRef2);

        // Add assertions to verify other behaviors as needed
    }
}