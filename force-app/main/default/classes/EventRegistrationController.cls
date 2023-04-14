public with sharing class EventRegistrationController {

    public Event_Organiser__c evtOrganizer {get;set;}
	public Event__c evt {get;set;}
	public Location_Address_Book__c	 loc {get;set;}

	public EventRegistrationController ()
	{
		evtOrganizer = new Event_Organiser__c();
		evt = new Event__c();
		loc = new Location_Address_Book__c();
	}
	public PageReference save() 
	{
		// insert con;
        
		insert loc;
        evtOrganizer.Location_Address_Book__c = loc.Id;
        // loc = new Location_Address_Book__c();
		
		insert evtOrganizer;
        evt.Event_Organizer__c = evtOrganizer.Id;
		evt.Location_Address_Book__c = loc.Id;
        // evtOrganizer = new Event_Organiser__c();
		insert evt;
        // evt = new Event__c();
        // resetValue();
        return null;
		// return new PageReference('/apex/EventRegistration').setRedirect(true);
	}
	// public void resetValue(){
	// 	loc = new Location_Address_Book__c();
	// 	evtOrganizer = new Event_Organiser__c();
	// 	evt = new Event__c();
	// }
}