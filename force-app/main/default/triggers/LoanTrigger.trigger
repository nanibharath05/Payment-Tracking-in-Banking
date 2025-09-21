trigger LoanTrigger on Loan__c (
    before insert, before update,
    after insert, after update, after delete
) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) LoanHandler.beforeInsert(Trigger.new);
        if (Trigger.isUpdate) LoanHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert) LoanHandler.afterInsert(Trigger.new);
        if (Trigger.isUpdate) LoanHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        if (Trigger.isDelete) LoanHandler.afterDelete(Trigger.old);
    }
}
