public class CaseObjectHelper {
 Public Static void updateproductname(List<Cases__c> newList){
        Set<id> sno = new Set<id>();
     Map<Id,String>cmap=new Map<Id,String>();
     for(Cases__c ca:newList){
     sno.add(ca.Machine_No__c);
          }
           List<Products__c> plist=[ SELECT id, Name,Product_Name__c from Products__c where id=:sno];
     for(Products__c pl:plist){
        cmap.put(pl.id,pl.Product_Name__c);
     }
     for(Cases__c ca:newList){
      ca.Machine_Name__c=cmap.get(ca.Machine_No__c);

    }
}
}