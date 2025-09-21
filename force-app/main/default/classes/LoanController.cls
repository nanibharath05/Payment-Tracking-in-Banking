public with sharing class LoanController {
    @AuraEnabled(cacheable=true)
    public static Loan__c getLoan(String loanId) {
      return [SELECT  Name, Principal_Amount__c FROM Loan__c WHERE Id = :loanId LIMIT 1];
    }
  
    @AuraEnabled
    public static Boolean markLoanClosed(String loanId) {
      try {
        Loan__c L = [SELECT Id, Status__c FROM Loan__c WHERE Id = :loanId LIMIT 1];
        L.Status__c = 'Closed';
        update L;
        return true;
      } catch (Exception e) {
        throw new AuraHandledException('Cannot close loan: ' + e.getMessage());
      }
    }
  }
  