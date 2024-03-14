trigger WO2WOLI1 on Work_Order_for_Spares__c (after insert,after Update) {
    
     
    
    if(trigger.isafter && trigger.isinsert){
        WO2Workspareline.convertSpareline2WOLI(trigger.new);
                                             }
}