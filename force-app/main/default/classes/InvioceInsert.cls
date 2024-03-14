global class InvioceInsert {}/* implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, Description__c, Product_Code__c, Value__c, Unit_Rate__c, Email__c, Product_Code_r.Name__c FROM Order__c';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
       List<Proforma_Invoice__c> recordsToInsert = new List<Proforma_Invoice__c>();

        for (sObject sourceRecord : scope) {
            Order__c order = (Order__c)sourceRecord;

            Proforma_Invoice__c invoice = new Proforma_Invoice__c();
            
            invoice.Description__c = order.Description__c;
            
            invoice.Machine_Name__c = order.Product_Code__c;
            
            recordsToInsert.add(invoice);
        }

        
        if (!recordsToInsert.isEmpty()) {
            insert recordsToInsert;
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Records inserted');
    }
}
*/