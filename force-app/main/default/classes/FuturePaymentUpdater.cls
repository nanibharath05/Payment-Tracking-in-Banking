public class FuturePaymentUpdater {
    @future
    public static void markAsProcessed(List<Id> paymentIds) {
        List<Payment__c> payments = [SELECT Id, Status__c FROM Payment__c WHERE Id IN :paymentIds];
        for (Payment__c p : payments) {
            if (p.Status__c != 'Paid') {
                p.Status__c = 'Processed';
            }
        }
        update payments;
    }
}
