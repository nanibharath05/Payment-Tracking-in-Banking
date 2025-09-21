public class PaymentController {
    @AuraEnabled(cacheable=true)
    public static List<Payment__c> getPayments(Id loanId) {
        if (loanId == null) return new List<Payment__c>();
        return [
            SELECT Name, Amount__c, Status__c, Payment_Date__c
            FROM Payment__c
            WHERE Loan__c = :loanId
            ORDER BY Payment_Date__c DESC
        ];
    }
}
