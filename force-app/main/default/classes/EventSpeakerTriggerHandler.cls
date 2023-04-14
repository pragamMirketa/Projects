public with sharing class EventSpeakerTriggerHandler {
    
    public static void duplicateSpeaker(List<Event_Speaker__c> eventSpeaker) {

        Set<Id> eventId = new Set<Id>();
        Set<Id> speakerId = new Set<Id>();
        for(Event_Speaker__c evtSpkr: eventSpeaker){
            eventId.add(evtSpkr.Speaker__c);
            speakerId.add(evtSpkr.Event__c);
        }

        Map<Id, Event__c> eventMap = new Map<Id, Event__c>([ SELECT Id, Start__c, End__c FROM Event__c WHERE Id IN :eventId ]);
        
        for (Event_Speaker__c evtSpkr : [ SELECT Id, Event__c, Speaker__c, Event__r.Start__c, Event__r.End__c  FROM Event_Speaker__c WHERE Speaker__c IN :speakerId ]) {
            Event__c evtTime = eventMap.get(evtSpkr.Event__c);
                Datetime evtTimeStart = evtTime.Start__c;
                Datetime evtTimeEnd = evtTime.End__c;
                // evtSpkr.Speaker__c == evtSpkr.Speaker__c &&
                    if ( ((evtTimeStart <= evtSpkr.Event__r.Start__c && evtTimeEnd >= evtSpkr.Event__r.End__c) || (evtTimeStart >= evtSpkr.Event__r.Start__c && evtTimeStart <= evtSpkr.Event__r.End__c) || (evtTimeEnd >= evtSpkr.Event__r.Start__c && evtTimeEnd <= evtSpkr.Event__r.End__c))) {
                        evtSpkr.Speaker__c.addError('Already booked');
                    }
                
            
        }
    }
}
    //     Map<Id,Event__c> evtDateTime= new Map<Id, Event__c>([Select id, Start__c from Event__c where id in :eventId]);
    //     List<Event_Speaker__c> spkr = [Select id, Event__c,Speaker__c,Event__r.Start__c, Event__r.End__c from Event_Speaker__c where id in :speakerId];
    //     for(Event_Speaker__c evtSpkr: eventSpeaker){
    //         Datetime evtTime = evtDateTime.get(evtSpkr.Event__r.Start__c);
    //         for(Event_Speaker__c checkEvtSpkr: spkr){
    //             if(evtSpkr.Speaker__c == checkEvtSpkr.Speaker__c &&  (evtSpkr.Event__r.Start__c >= checkEvtSpkr.Event__r.Start__c && evtSpkr.Event__r.Start__c < checkEvtSpkr.Event__r.End__c)){
    //                 evtSpkr.addError('Already Booked');
    //             }
    //         }
    //     }
    // }
// }