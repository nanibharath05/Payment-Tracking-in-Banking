@isTest
public class PaymentHandlerTest {

    @isTest
    static void testPaymentBeforeInsert() {
        Loan__c loan = new Loan__c(
            Principal_Amount__c = 30000,
            Term_Months__c = 6,
            Interest_Rate__c = 5
        );
        insert loan;

        Payment__c pay = new Payment__c(
            Loan__c = loan.Id,
            Amount__c = 5000,
            Payment_Date__c = Date.today()
        );

        Test.startTest();
        insert pay;
        Test.stopTest();

        System.assertEquals(5000, pay.Amount__c);
    }
}
