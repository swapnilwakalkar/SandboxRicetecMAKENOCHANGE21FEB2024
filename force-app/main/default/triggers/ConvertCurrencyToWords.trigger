trigger ConvertCurrencyToWords on Work_Order_for_Spares__c  (before insert, before update){

    for (Work_Order_for_Spares__c c : Trigger.new) {
        if (c.Grand_Total__c != null && c.Grand_Total__c >= 0) {
         
            Long n = c.Grand_Total__c.longValue();
            string amo = ConvertCurrencyToWords.english_number(n);
            string amo1 = amo.remove(',');
            c.Amount_In_Words__c = amo1;
        } else {
            c.Amount_in_Words__c = null;
        }
    } 
}