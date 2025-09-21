public class LoanHandler {
    
    public static void beforeInsert(List<Loan__c> newLoans) {
        for (Loan__c loan : newLoans) {
            if (loan.Status__c == null) {
                loan.Status__c = 'Pending Approval'; // Default
            }
        }
    }

    public static void beforeUpdate(List<Loan__c> newLoans, Map<Id, Loan__c> oldMap) {
        for (Loan__c loan : newLoans) {
            Loan__c oldLoan = oldMap.get(loan.Id);
            if (loan.Principal_Amount__c != oldLoan.Principal_Amount__c) {
                loan.Status__c = 'Modified';
            }
        }
    }

    public static void afterInsert(List<Loan__c> newLoans) {
        // Example: Send notification or integration
        System.debug('New Loans inserted: ' + newLoans);
    }

    public static void afterUpdate(List<Loan__c> newLoans, Map<Id, Loan__c> oldMap) {
        System.debug('Loans updated: ' + newLoans);
    }

    public static void afterDelete(List<Loan__c> oldLoans) {
        System.debug('Loans deleted: ' + oldLoans);
    }
}
