@istest
public class GoogleMapDistanceCtrlTest {

    @istest
    static void testGoogleMapDistanceCtrl(){
         // ... Your setup code ...
        Account mill = new Account();
        mill.Name = 'testmill';
        mill.Geo_Location__latitude__s = 12.3456;
        mill.Geo_Location__longitude__s = 78.9012;
        insert mill;
       
        //create new Territory
        Territory__c trty = new Territory__c();
        trty.name = 'testTerritory';
        insert trty;
        
        // Create Monthly Planner 
        Monthly_Planner__c mp = new Monthly_Planner__c();
        mp.Name = 'testMonth';
        insert mp;
        
        //Create Day Planner
        Day_Planner__c dp = new Day_Planner__c();
        dp.Monthly_Planner__c = mp.Id; 
        dp.Name = 'testDayPlanner';
        dp.Representative_End_Location__Latitude__s = 12.3456;
        dp.Representative_End_Location__Longitude__s = 78.9012;
        dp.Representative_Initial_Location__latitude__s = 12.3456;
        dp.Representative_Initial_Location__longitude__s = 78.9012;
        
        insert dp;
       
        // Create a Mill Planner record for testing
        Mill_Planner__c millPlanner = new Mill_Planner__c();
        millPlanner.Day_Planner__c = dp.Id; 
        millPlanner.Area__c = trty.Id; 
        millPlanner.Mill_Name__c = mill.id;
        millPlanner.Start_Location__latitude__s = 12.3456;
        millPlanner.Start_Location__longitude__s = 78.9012;
        insert millPlanner;
        
          // Create a PageReference and set parameters for the page
        PageReference pageRef = Page.GoogleMapDistanceCtrlVf; // Replace with the actual name of your Visualforce page
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', dp.Id);

        // Instantiate the controller
        GoogleMapDistanceCtrl controller = new GoogleMapDistanceCtrl(new ApexPages.StandardController(dp));

        // Perform assertions to verify that the controller properties are set correctly
        System.assertEquals(dp.Id, controller.currentRecordId);
    }
}