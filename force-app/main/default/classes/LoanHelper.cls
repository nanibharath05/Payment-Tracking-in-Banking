public class LoanHelper {
    public static void beforeInsert(List<Loan__c> newLoans) {
        try {
            for (Loan__c loan : newLoans) {
                if (loan.Amount__c <= 0) {
                    throw new PaymentTrackingException('Loan Amount must be greater than 0.');
                }
            }
        } catch (Exception ex) {
            String msg = ErrorHandler.logError(ex, 'LoanHelper.beforeInsert');
            ErrorHandler.notifyAdmin('Loan Insert Error', msg);
            throw ex;
        }
    }
}
