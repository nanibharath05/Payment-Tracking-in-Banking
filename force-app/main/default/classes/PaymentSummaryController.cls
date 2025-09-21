public with sharing class PaymentSummaryController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getPaymentSummary(Id loanId) {
        Map<String, Integer> result = new Map<String, Integer>{
            'totalPayments' => 0,
            'paidPayments' => 0
        };

        if (loanId == null) {
            return result;
        }

        // Total Payments
        Integer totalPayments = [SELECT COUNT() FROM Payment__c WHERE Loan__c = :loanId];

        // Paid Payments
        Integer paidPayments = [SELECT COUNT() FROM Payment__c WHERE Loan__c = :loanId AND Status__c = 'Paid'];

        result.put('totalPayments', totalPayments);
        result.put('paidPayments', paidPayments);

        return result;
    }
}
