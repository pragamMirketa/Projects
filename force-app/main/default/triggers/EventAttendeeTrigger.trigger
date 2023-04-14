trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {

    EventAttendeeTriggerHandler.sendEmails(Trigger.new);
    
}