trigger LoanTrigger on Loan__c (
    before insert, before update, before delete,
    after insert, after update, after delete
) {
    LoanTriggerHandler handler = new LoanTriggerHandler();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) handler.beforeInsert(Trigger.new);
        if (Trigger.isUpdate) handler.beforeUpdate(Trigger.new, Trigger.oldMap);
        if (Trigger.isDelete) handler.beforeDelete(Trigger.old);
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) handler.afterInsert(Trigger.new);
        if (Trigger.isUpdate) handler.afterUpdate(Trigger.new, Trigger.oldMap);
        if (Trigger.isDelete) handler.afterDelete(Trigger.old);
    }
}
