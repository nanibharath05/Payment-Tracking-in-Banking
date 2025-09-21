public with sharing class LoanDetailsController {
    @AuraEnabled
    public static Loan__c getRecord(Id loanId) {
        try {
            return [
                SELECT Id, Name, Principal_Amount__c, Status__c
                FROM Loan__c
                WHERE Id = :loanId
                LIMIT 1
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching loan details: ' + e.getMessage());
        }
    }
}
