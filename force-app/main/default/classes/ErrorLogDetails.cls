public with sharing class ErrorLogDetails {
    public static void insertLog(String processName, String details) {
        Error_Log__c log = new Error_Log__c();
        log.Process_Name__c = processName;
        log.Log_Date_Time__c = Datetime.now();
        log.Log_Details__c = details;
        
        insert log;
    }
}