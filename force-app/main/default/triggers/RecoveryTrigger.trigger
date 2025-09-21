trigger RecoveryTrigger on Recovery__c (
    before insert, before update,
    after insert, after update, after delete
) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) RecoveryHandler.beforeInsert(Trigger.new);
        if (Trigger.isUpdate) RecoveryHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert) RecoveryHandler.afterInsert(Trigger.new);
        if (Trigger.isUpdate) RecoveryHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        if (Trigger.isDelete) RecoveryHandler.afterDelete(Trigger.old);
    }
}
