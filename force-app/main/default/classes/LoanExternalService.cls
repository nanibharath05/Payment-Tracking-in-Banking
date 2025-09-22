public with sharing class LoanExternalService {
    public static String getLoanValidation(String loanId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:BankAPI/validateLoan?loanId=' + loanId);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            return res.getBody();
        } else {
            throw new CalloutException('Error from API: ' + res.getStatus() + ' - ' + res.getBody());
        }
    }
}
