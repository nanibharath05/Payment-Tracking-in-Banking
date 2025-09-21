public class RecoveryHandler {
    public static void beforeInsert(List<Recovery__c> recoveries) {
        try {
            for (Recovery__c rec : recoveries) {
                if (rec.Amount_Recovered__c < 0) {
                    throw new PaymentTrackingException('Recovered amount cannot be negative.');
                }
            }
        } catch (Exception ex) {
            String msg = ErrorHandler.logError(ex, 'RecoveryHandler.beforeInsert');
            ErrorHandler.notifyAdmin('Recovery Insert Error', msg);
            throw ex;
        }
    }
}
