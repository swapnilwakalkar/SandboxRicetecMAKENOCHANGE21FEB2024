public class quoteObjectHelper {
    /*public static void updateAddress(List<Quotes__c> quoteList) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Account> accountMap = new Map<Id, Account>();

        for (Quotes__c quote : quoteList) {
            accountIds.add(quote.Account_Name__c);
        }

        List<Account> accountList = [
            SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry
            FROM Account
            WHERE Id IN :accountIds
        ];

        for (Account account : accountList) {
            accountMap.put(account.Id, account);
        }

        for (Quotes__c quote : quoteList) {
            Account relatedAccount = accountMap.get(quote.Account_Name__c);
            if (relatedAccount != null) {
                quote.Bill_To__Street__s = relatedAccount.BillingStreet;
                quote.Bill_To__City__s = relatedAccount.BillingCity;
                quote.Bill_To__StateCode__s = relatedAccount.BillingState;
                quote.Bill_To__PostalCode__s = relatedAccount.BillingPostalCode;
                quote.Bill_To__CountryCode__s = relatedAccount.BillingCountry;
            }
        }
    }*/
}