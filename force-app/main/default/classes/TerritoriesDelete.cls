public class TerritoriesDelete {
    public static void createTerritories() {
        List<Territory__c> territoriesToInsert = new List<Territory__c>();

        Territory__c nizamabad = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Nizamabad',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(nizamabad);

        Territory__c karimnagar = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Karimnagar',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(karimnagar);
        
        Territory__c Medak = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Medak',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(Medak);

        Territory__c Warangal = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Warangal',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(Warangal);

        Territory__c Nalgonda = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Nalgonda',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(Nalgonda); 
        
        Territory__c Jedcherla = new Territory__c(
            State_Province__c = 'Telangana',
            Parent_Location__c = 'Telangana',
            Name = 'Jedcherla',
            Country__c = 'India',
            Active__c = true
        );
        territoriesToInsert.add(Jedcherla);         

        if (!territoriesToInsert.isEmpty()) {
            insert territoriesToInsert;
        }
    }
}