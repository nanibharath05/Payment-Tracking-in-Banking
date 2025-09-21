public class PaymentHandler {
    
    public static void beforeInsert(List<Payment__c> newPayments) {
        for (Payment__c p : newPayments) {
            if (p.Status__c == null) p.Status__c = 'Pending';
        }
    }

    public static void beforeUpdate(List<Payment__c> newPayments, Map<Id, Payment__c> oldMap) {
        for (Payment__c p : newPayments) {
            Payment__c oldP = oldMap.get(p.Id);
            if (p.Amount__c != oldP.Amount__c) {
                p.Status__c = 'Revised';
            }
        }
    }

    public static void afterInsert(List<Payment__c> newPayments) {
        updateLoanStatus(newPayments);
    }

    public static void afterUpdate(List<Payment__c> newPayments, Map<Id, Payment__c> oldMap) {
        updateLoanStatus(newPayments);
    }

    public static void afterDelete(List<Payment__c> oldPayments) {
        updateLoanStatus(oldPayments);
    }

    private static void updateLoanStatus(List<Payment__c> payments) {
        Set<Id> loanIds = new Set<Id>();
        for (Payment__c p : payments) if (p.Loan__c != null) loanIds.add(p.Loan__c);
        if (loanIds.isEmpty()) return;

        Map<Id, Integer> totalPayments = new Map<Id, Integer>();
        for (AggregateResult ar : [
            SELECT Loan__c loanId, COUNT(Id) totalCount
            FROM Payment__c WHERE Loan__c IN :loanIds
            GROUP BY Loan__c
        ]) {
            totalPayments.put((Id) ar.get('loanId'), (Integer) ar.get('totalCount'));
        }

        Map<Id, Integer> paidPayments = new Map<Id, Integer>();
        for (AggregateResult ar : [
            SELECT Loan__c loanId, COUNT(Id) paidCount
            FROM Payment__c WHERE Loan__c IN :loanIds AND Status__c = 'Paid'
            GROUP BY Loan__c
        ]) {
            paidPayments.put((Id) ar.get('loanId'), (Integer) ar.get('paidCount'));
        }

        List<Loan__c> loansToUpdate = new List<Loan__c>();
        for (Id lid : loanIds) {
            Integer total = totalPayments.containsKey(lid) ? totalPayments.get(lid) : 0;
            Integer paid = paidPayments.containsKey(lid) ? paidPayments.get(lid) : 0;

            if (total > 0 && total == paid) {
                loansToUpdate.add(new Loan__c(Id = lid, Status__c = 'Closed'));
            } else {
                loansToUpdate.add(new Loan__c(Id = lid, Status__c = 'Active'));
            }
        }
        if (!loansToUpdate.isEmpty()) update loansToUpdate;
    }
}
