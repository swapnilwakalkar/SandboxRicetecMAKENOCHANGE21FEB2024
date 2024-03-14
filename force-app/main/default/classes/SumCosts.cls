public class SumCosts {
    public static void CostMethod(List<Quote_Line_Item__c> oppolist,List<Quote_Line_Item__c> oldList){
        set<id>Ids = new Set<id>();
        if(oppolist!=null){
        for(Quote_Line_Item__c op:oppolist){
            Ids.add(op.Quotes__c);
        }   
        }
        if(oldList!=null){
        for(Quote_Line_Item__c sp:oldList){
            Ids.add(sp.Quotes__c);
        }   
        }
        List<Quotes__c> prodList = [SELECT Id, Name, QUOTED_SUB_COST__c, FINAL_SUB_COST__c, Total_Power_Required__c,(SELECT Id, Name, PowerHP__c, QuotedQ__c, FinalF__c FROM Quote_Line_Items__r) FROM Quotes__c WHERE id=:Ids];
         Double SumOfQuotedPrice=0;
         Double SumOfFinalPrice=0;
         Double SumOfTotalPower=0;
        If(prodList!=null){
        for(Quotes__c opp:prodList){
            for(Quote_Line_Item__c p:opp.Quote_Line_Items__r){
                if(p.QuotedQ__c!=null){
            SumOfQuotedPrice = SumOfQuotedPrice+p.QuotedQ__c;
                }
                if(p.FinalF__c!=null){
            SumOfFinalPrice = SumOfFinalPrice+p.FinalF__c;
            }
               if(p.PowerHP__c!=null){
            SumOfTotalPower = SumOfTotalPower+p.PowerHP__c;
            }  
            }
             opp.QUOTED_SUB_COST__c = SumOfQuotedPrice;
             opp.FINAL_SUB_COST__c = SumOfFinalPrice;
             opp.Total_Power_Required__c = SumOfTotalPower;
            
        }
        }
       database.update(prodList, false);
    }
}