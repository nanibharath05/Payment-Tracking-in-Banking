@IsTest
private class Test_RecoveryHandler {
    @IsTest static void testRecoveryFailsOnNegativeAmount() {
        Recovery__c r = new Recovery__c(Name='R1', Amount_Recovered__c = -10);
        // negative amount should throw DML exception because of addError in beforeInsert
        try {
            insert r;
            System.assert(false, 'Expected DML exception for negative amount');
        } catch (DmlException ex) {
            System.assert(ex.getMessage().contains('Amount Recovered must be greater than 0.'));
        }
    }
}
