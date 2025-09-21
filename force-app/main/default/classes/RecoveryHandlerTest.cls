@isTest
public class RecoveryHandlerTest {

    @isTest
    static void testRecoveryInsert() {
        Loan__c loan = new Loan__c(
            Principal_Amount__c = 10000,
            Term_Months__c = 12,
            Interest_Rate__c = 8
        );
        insert loan;

        Recovery__c rec = new Recovery__c(
            Loan__c = loan.Id,
            Amount_Recovered__c = 1000,
            Recovery_Date__c = Date.today()
        );

        Test.startTest();
        insert rec;
        Test.stopTest();

        System.assertEquals(1000, rec.Amount_Recovered__c);
    }
}
