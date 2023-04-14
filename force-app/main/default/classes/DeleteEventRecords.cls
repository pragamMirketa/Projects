public with sharing class DeleteEventRecords implements Database.Batchable<SObject>  {
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String query = 'Select id, Name__c from Event__c where Live__c = true AND End__c < LAST_N_MONTHS:2';
        return Database.getQueryLocator(query);

    } 

    public void execute(Database.BatchableContext batchContext, List<Event__c> listEvt){
        Database.delete(listEvt);
        
    }

    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch has been processed');
        List<String> toAddress = new List<String>();
        toAddress.add('pragam.kaistha@mirketa.com');
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName('Organizer');
        
        mail.setHtmlBody('The records have been deleted.');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}