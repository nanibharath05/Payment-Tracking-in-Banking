public class PaymentReminderQueue implements Queueable {
    public void execute(QueueableContext context) {
        List<Payment__c> duePayments = [
            SELECT Id, Status__c FROM Payment__c WHERE Status__c = 'Pending'
        ];
        for (Payment__c p : duePayments) {
            p.Status__c = 'Reminder Sent';
        }
        update duePayments;
        System.debug('✅ Queue Job executed for reminders.');
    }
}
