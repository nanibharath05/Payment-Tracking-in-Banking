public with sharing class ApiUsage {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getLimits() {
        return Limits.getAllLimits();
    }
}
