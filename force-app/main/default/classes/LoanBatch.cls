global class LoanBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Status__c FROM Loan__c WHERE Status__c = \'Active\'');
    }
    global void execute(Database.BatchableContext bc, List<Loan__c> scope) {
        for (Loan__c l : scope) {
            l.Status__c = 'Closed';
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc) {
        System.debug('✅ Loan Batch finished updating loans.');
    }
}
