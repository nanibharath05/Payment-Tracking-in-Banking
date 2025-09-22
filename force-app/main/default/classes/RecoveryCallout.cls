public class RecoveryCallout implements Queueable, Database.AllowsCallouts {
    private Id recoveryId;
    public RecoveryCallout(Id recId) { this.recoveryId = recId; }
    
    public void execute(QueueableContext qc) {
        Recovery__c rec = [SELECT Id, Loan__c, Amount_Recovered__c FROM Recovery__c WHERE Id=:recoveryId];
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:BankAPI/recoveryStatus');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(rec));
        
        HttpResponse res = new Http().send(req);
        System.debug('Recovery response: ' + res.getBody());
    }
}
