public class PaymentHandler {
    public static void beforeInsert(List<Payment__c> newPayments) {
        try {
            for (Payment__c pay : newPayments) {
                if (pay.Payment_Date__c == null) {
                    throw new PaymentTrackingException('Payment Date is required.');
                }
            }
        } catch (Exception ex) {
            String msg = ErrorHandler.logError(ex, 'PaymentHandler.beforeInsert');
            ErrorHandler.notifyAdmin('Payment Insert Error', msg);
            throw ex;
        }
    }

    public static void afterUpdate(List<Payment__c> updatedPayments) {
        try {
            for (Payment__c pay : updatedPayments) {
                if (pay.Status__c == 'Overdue') {
                    System.debug('Payment ' + pay.Id + ' is overdue. Creating recovery...');
                }
            }
        } catch (Exception ex) {
            String msg = ErrorHandler.logError(ex, 'PaymentHandler.afterUpdate');
            ErrorHandler.notifyAdmin('Payment Update Error', msg);
        }
    }
}
