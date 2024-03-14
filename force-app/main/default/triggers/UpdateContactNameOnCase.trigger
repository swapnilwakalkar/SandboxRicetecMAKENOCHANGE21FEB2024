trigger UpdateContactNameOnCase on Cases__c (before insert, before update) {
	 for (Cases__c c : Trigger.new) {
         if (c.Account_Name__c != null) {
             try{
                Contact primaryContact = [SELECT Name FROM Contact WHERE AccountId = :c.Account_Name__c LIMIT 1];
                c.Customer_Name__c = primaryContact.Name;
             }catch (QueryException e) {
                 
               c.Customer_Name__c = null;  
             }
            }
         for(Cases__c d : Trigger.new){
          if (d.Account_Name__c != null) {
             try{
                Order__c ordno = [SELECT Name FROM Order__c WHERE Account_Name__c = :d.Account_Name__c LIMIT 1];
                d.Ordernew__c = ordno.Name;
             system.debug('Problem' +ordno);
             }catch (QueryException e) {
                 
               d.Ordernew__c = null;  
             }
            }
         }
        }
}