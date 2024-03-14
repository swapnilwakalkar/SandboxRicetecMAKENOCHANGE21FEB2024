@isTest
public class ServicerTest {
    @isTest
    static void testServicerClass() {
        Service_Report__c testServiceReport = new Service_Report__c();
        insert testServiceReport;
        
        ApexPages.StandardController standardController = new ApexPages.StandardController(testServiceReport);

        Servicer servicerInstance = new Servicer(standardController);

    
        servicerInstance.next();
        System.assertEquals(0, servicerInstance.currentPageIndex);

        servicerInstance.previous();
        System.assertEquals(0, servicerInstance.currentPageIndex);
        
        Test.startTest();
        PageReference recordDetailPage = servicerInstance.save();
        Test.stopTest();
        
        System.assertNotEquals(null, recordDetailPage);
        
        Attachment testAttachment = [SELECT Id FROM Attachment WHERE ParentId = :testServiceReport.Id LIMIT 1];
        System.assertNotEquals(null, testAttachment);
        
    }        
        @istest 
        static void testServicerSavePdfAsAttachment(){
        Service_Report__c testServicer = new Service_Report__c();
          insert testServicer;  
            Blob testPdfBlob = Blob.valueOf('Test PDF Content'); 
            ApexPages.StandardController standardController = new ApexPages.StandardController(testServicer);
            Servicer servicerpage = new Servicer(standardController);
               
            Test.startTest();
            servicerpage.savePdfAsAttachment(testServicer.Id, 'TestFileName.pdf', testPdfBlob);
            Test.stopTest();
        }    
    
    @isTest
    static void testservicerGeneratePdfContent() {
        Service_Report__c testServicer = new Service_Report__c();
        insert testServicer;
        
        ApexPages.StandardController standardController = new ApexPages.StandardController(testServicer);
        
        Servicer Servicerpage = new Servicer(standardController);
        
        Test.startTest();
        Blob pdfBlob = Servicerpage.generatePdfContent(testServicer.Id);
        Test.stopTest();
        
        System.assertNotEquals(null, pdfBlob);
    }
}