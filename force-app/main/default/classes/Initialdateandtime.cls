public class Initialdateandtime {
    public static void Updatedatestarttime(){
        Day_Planner__c x = new Day_Planner__c();   
        x.Initial_Location_Date_and_Time__c = Datetime.now();      
        //update x;
    }
    
    public static void Updatedateendtime(){
        Day_Planner__c d = new Day_Planner__c();   
        d.Final_Location_Date_and_Time__c = Datetime.now();      
       // update d;
    }
}