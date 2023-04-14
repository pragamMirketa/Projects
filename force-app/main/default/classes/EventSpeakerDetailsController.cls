public with sharing class EventSpeakerDetailsController {
    public String MstrId{get;set;}
    public Event__c evt{get;set;}
    public List<Event_Speaker__c> evtSpkr{get;set;}
    // public Speaker__c spkr{get;set;}
    public EventSpeakerDetailsController() {
        MstrId = ApexPages.currentPage().getParameters().get('id'); 

        evt = [SELECT Id, Name__c, Event_Organizer__r.Name, Location_Address_Book__r.Name, Start__c 
                FROM Event__c 
                WHERE id=:MstrId LIMIT 1];

        evtSpkr = [SELECT Id, Event__r.Name__c, Speaker__r.Name, Speaker__r.Profile_URL__c, Speaker__r.About_Me__c 
                    FROM Event_Speaker__c 
                    WHERE Event__c = :MstrId];

        // spkr = new Speaker__c();
    }
    // public EventSpeakerDetailsController(ApexPages.StandardController stdController) {
    //     this.evt = (Event__c)stdController.getRecord();
    // }
    public PageReference saveAsAttendee(){
        return new PageReference('/apex/AttendeeRegistration?param1='+MstrId).setRedirect(true);
    }
    
    public PageReference saveAsSpeaker(){
        return new PageReference('/apex/EventSpeaker?param1='+MstrId).setRedirect(true);
    }
}