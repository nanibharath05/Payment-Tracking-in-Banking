@IsTest
private class Test_PaymentHandlers {
    @IsTest static void testPaymentInsertAndLoanClose() {
        // Create an Account to attach to loan (if Loan has Account lookup - optional)
        // Create Loan
        Loan__c loan = new Loan__c(Name='TestLoan', Principal_Amount__c = 1000.00, Status__c='Active');
        insert loan;

        // Create 2 payments not paid
        Payment__c p1 = new Payment__c(Name='P1', Loan__c = loan.Id, Payment_Date__c = Date.today().addDays(1), Amount__c = 500, Status__c='Pending');
        Payment__c p2 = new Payment__c(Name='P2', Loan__c = loan.Id, Payment_Date__c = Date.today().addDays(2), Amount__c = 500, Status__c='Pending');

        insert new List<Payment__c>{p1,p2};

        // Now mark both paid and update
        p1.Status__c = 'Paid';
        p2.Status__c = 'Paid';
        update new List<Payment__c>{p1,p2};

        // Reload loan and assert closed
        Loan__c refreshed = [SELECT Id, Status__c FROM Loan__c WHERE Id = :loan.Id];
        System.assertEquals('Closed', refreshed.Status__c);
    }

    @IsTest static void testPaymentOverdueBeforeInsert() {
        Loan__c loan = new Loan__c(Name='L2', Principal_Amount__c=1000.00);
        insert loan;
        // create payment in past
        Payment__c p = new Payment__c(Name='past', Loan__c = loan.Id, Payment_Date__c = Date.today().addDays(-2), Amount__c = 100, Status__c=null);
        insert p;
        Payment__c got = [SELECT Id, Status__c FROM Payment__c WHERE Id = :p.Id];
        System.assertEquals('Overdue', got.Status__c);
    }
}
