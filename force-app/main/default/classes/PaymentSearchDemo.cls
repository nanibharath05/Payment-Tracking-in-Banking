public with sharing class PaymentSearchDemo {
    public static List<List<SObject>> searchPayments(String searchKey) {
        return [
            FIND :searchKey IN ALL FIELDS
            RETURNING Payment__c(Id, Name, Customer_Email__c, Status__c),
                      Loan__c(Id, Name, Status__c)
        ];
    }
}
