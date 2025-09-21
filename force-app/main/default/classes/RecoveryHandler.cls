public class RecoveryHandler {
    
    public static void beforeInsert(List<Recovery__c> newRecoveries) {
        for (Recovery__c r : newRecoveries) {
            if (r.Status__c == null) r.Status__c = 'Assigned';
        }
    }

    public static void beforeUpdate(List<Recovery__c> newRecoveries, Map<Id, Recovery__c> oldMap) {
        for (Recovery__c r : newRecoveries) {
            Recovery__c oldR = oldMap.get(r.Id);
            if (r.Amount_Recovered__c != oldR.Amount_Recovered__c) {
                r.Status__c = 'Updated';
            }
        }
    }

    public static void afterInsert(List<Recovery__c> newRecoveries) {
        System.debug('New Recoveries: ' + newRecoveries);
    }

    public static void afterUpdate(List<Recovery__c> newRecoveries, Map<Id, Recovery__c> oldMap) {
        System.debug('Updated Recoveries: ' + newRecoveries);
    }

    public static void afterDelete(List<Recovery__c> oldRecoveries) {
        System.debug('Deleted Recoveries: ' + oldRecoveries);
    }
}
