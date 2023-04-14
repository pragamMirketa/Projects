// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {

//     //EventSpeakerTriggerHandler.duplicateSpeaker(Trigger.new);
//     Set<Id> eventId = new Set<Id>();
//     Set<Id> speakerId = new Set<Id>();
//     for(Event_Speaker__c evtSpkr: Trigger.new){
//         eventId.add(evtSpkr.Event__c);
//         speakerId.add(evtSpkr.Speaker__c);
//     }
//     Map<Id,Event__c> evtDateTime= new Map<Id, Event__c>([Select id, Start__c, End__c from Event__c where id in :eventId]);
//     List<Event_Speaker__c> spkr = [Select id, Event__c,Speaker__c,Event__r.Start__c, Event__r.End__c from Event_Speaker__c where Speaker__c in :speakerId];
//     for(Event_Speaker__c evtSpkr: Trigger.new){
//         Event__c evtTime = evtDateTime.get(evtSpkr.Event__c);
//         Datetime evtTimeStart = evtTime.Start__c;
//         Datetime evtTimeEnd = evtTime.End__c;
//         for(Event_Speaker__c checkEvtSpkr: spkr){
//             if(evtSpkr.Speaker__c == checkEvtSpkr.Speaker__c && ((evtTimeStart <= checkEvtSpkr.Event__r.Start__c && evtTimeEnd >= checkEvtSpkr.Event__r.End__c) ||(evtTimeStart >= checkEvtSpkr.Event__r.Start__c && evtTimeStart <= checkEvtSpkr.Event__r.End__c ) ||(evtTimeEnd >= checkEvtSpkr.Event__r.Start__c && evtTimeEnd <= checkEvtSpkr.Event__r.End__c))){
//                 evtSpkr.Speaker__c.addError('Already booked');
//                 evtSpkr.addError('Already Booked');
//             }
//         }
//     }
// }





trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) { 

    Map<Id, Event__c> eventMap = new Map<Id, Event__c>();
    Set<Id> eventIds = new Set<Id>();
    Set<Id> speakerId = new Set<Id>();

    for(Event_Speaker__c evtSpkr : Trigger.new) { 
        eventIds.add(evtSpkr.Event__c); 
        speakerId.add(evtSpkr.Speaker__c); 
    } 
    List<Event_Speaker__c> spkr = [Select id, Event__c,Speaker__c,Event__r.Start__c, Event__r.End__c from Event_Speaker__c where        Speaker__c in :speakerId];
    for(Event__c evt : [SELECT Id, Start__c, End__c FROM Event__c WHERE Id IN :eventIds]) {
        eventMap.put(evt.Id, evt);
    }
Map<id,Event_Speaker__c> es = new Map<id,Event_Speaker__c>();
for(Event_Speaker__c evtspeaker : spkr) {
            es.put(evtspeaker.Speaker__c,evtSpeaker);
        }

    for(Event_Speaker__c evtSpkr : Trigger.new) {
        Event__c event = eventMap.get(evtSpkr.Event__c); 
        Datetime evtTime = event.Start__c;

        if(es.containsKey(evtSpkr.Speaker__c)) {
            Event_Speaker__c eventSpkrId1 = es.get(evtSpkr.Speaker__c);
                Datetime existingEvtTime = eventSpkrId1.Event__r.Start__c;

                if((evtTime >= existingEvtTime && evtTime < eventSpkrId1.Event__r.End__c) || (event.End__c >= existingEvtTime && event.End__c < eventSpkrId1.Event__r.End__c) || (evtTime <=existingEvtTime && event.End__c >=eventSpkrId1.Event__r.End__c )) {
                    evtSpkr.Speaker__c.addError('Already booked'); 
                    evtSpkr.addError('Already Booked');
                }
        }
    }
}




// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) { 

//     Map<Id, Event__c> eventMap = new Map<Id, Event__c>();
//     // Map<Id, Event_Speaker__c> speakerToEventMap = new Map<Id, Event_Speaker__c>();
//     Set<Id> eventIds = new Set<Id>();
//     Set<Id> speakerId = new Set<Id>();

//     for(Event_Speaker__c evtSpkr : Trigger.new) { 
//         eventIds.add(evtSpkr.Event__c); 
//         speakerId.add(evtSpkr.Speaker__c); 
//         // speakerToEventMap.put(evtSpkr.Speaker__c, evtSpkr);
//     } 
//     List<Event_Speaker__c> spkr = [Select id, Event__c,Speaker__c,Event__r.Start__c, Event__r.End__c from Event_Speaker__c where        Speaker__c in :speakerId];
//     for(Event__c evt : [SELECT Id, Start__c, End__c FROM Event__c WHERE Id IN :eventIds]) {
//         eventMap.put(evt.Id, evt);
//     }
// Map<id,Event_Speaker__c> es = new Map<id,Event_Speaker__c>();
// for(Event_Speaker__c evtspeaker : spkr) {
//             es.put(evtspeaker.Speaker__c,evtSpeaker);
//         }

//     for(Event_Speaker__c evtSpkr : Trigger.new) {
//         Event__c event = eventMap.get(evtSpkr.Event__c); 
//         Datetime evtTime = event.Start__c;

//         if(es.containsKey(evtSpkr.Speaker__c)) {
//             Event_Speaker__c eventSpkrId1 = es.get(evtSpkr.Speaker__c);
//             // Id eventSpkrId = eventSpkrId1.Id;

//             // if(eventSpkrId != evtSpkr.Event__c) {
//                 // Event__c existingEvent = eventSpkrId1.Event__c;
//                 Datetime existingEvtTime = eventSpkrId1.Event__r.Start__c;
//                 // Datetime existingEvtTime = existingEvent.Start__c;

//                 if((evtTime >= existingEvtTime && evtTime < eventSpkrId1.Event__r.End__c) || (event.End__c >= existingEvtTime && event.End__c < eventSpkrId1.Event__r.End__c) || (evtTime <=existingEvtTime && event.End__c >=eventSpkrId1.Event__r.End__c )) {
//                     evtSpkr.Speaker__c.addError('Already booked'); 
//                     evtSpkr.addError('Already Booked');
//                 }
//             // }
//         }
//     }
// }









































// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) { 

//     Map<Id, Event__c> eventMap = new Map<Id, Event__c>();
//     Map<Id, Id> speakerToEventMap = new Map<Id, Id>();
//     Set<Id> eventIds = new Set<Id>();

//     for(Event_Speaker__c evtSpkr : Trigger.new) { 
//         eventIds.add(evtSpkr.Event__c); 
//         speakerToEventMap.put(evtSpkr.Speaker__c, evtSpkr.Event__c);
//     } 

//     for(Event__c evt : [SELECT Id, Start__c, End__c FROM Event__c WHERE Id IN :eventIds]) {
//         eventMap.put(evt.Id, evt);
//     }

//     for(Event_Speaker__c evtSpkr : Trigger.new) {
//         Event__c event = eventMap.get(evtSpkr.Event__c); 
//         Datetime evtTime = event.Start__c;

//         if(speakerToEventMap.containsKey(evtSpkr.Speaker__c)) {
//             Id eventId = speakerToEventMap.get(evtSpkr.Speaker__c);

//             if(eventId != evtSpkr.Event__c) {
//                 Event__c existingEvent = eventMap.get(eventId);
//                 Datetime existingEvtTime = existingEvent.Start__c;

//                 if(evtTime >= existingEvtTime && evtTime < existingEvent.End__c) {
//                     evtSpkr.Speaker__c.addError('Already booked'); 
//                     evtSpkr.addError('Already Booked');
//                 }
//             }
//         }
//     }
// }















// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) { 



//     Map<Id, Event_Speaker__c> speakerToEventSpeakerMap = new Map<Id, Event_Speaker__c>(); 
//     Set<Id> eventIds = new Set<Id>(); 



//     for(Event_Speaker__c evtSpkr : Trigger.new) { 
//         eventIds.add(evtSpkr.Event__c); 
//         speakerToEventSpeakerMap.put(evtSpkr.Speaker__c, evtSpkr); 
//     } 



//     Map<Id, Event__c> eventMap = new Map<Id, Event__c>([Select id, Start__c, End__c from Event__c where id in :eventIds]); 

//     for(Event_Speaker__c evtSpkr : Trigger.new) { 

//         Event__c eventTime = eventMap.get(evtSpkr.Event__c); 

//         Datetime evtTimeStart = eventTime.Start__c; 
//         Datetime evtTimeEnd = eventTime.End__c;
// //             Datetime evtTimeEnd = evtTime.End__c;
//         Event_Speaker__c existingEventSpeaker = speakerToEventSpeakerMap.get(evtSpkr.Speaker__c); 
//         if(existingEventSpeaker != null && existingEventSpeaker.Id != evtSpkr.Id && existingEventSpeaker.Speaker__c == evtSpkr.Speaker__c && ((evtTimeStart <= existingEventSpeaker.Event__r.Start__c && evtTimeEnd >= existingEventSpeaker.Event__r.End__c) || (evtTimeStart >= existingEventSpeaker.Event__r.Start__c && evtTimeStart <= existingEventSpeaker.Event__r.End__c) || (evtTimeEnd >= existingEventSpeaker.Event__r.Start__c && evtTimeEnd <= existingEventSpeaker.Event__r.End__c))) { 

//             // evtSpkr.Speaker__c.addError('Already booked'); 
//             evtSpkr.addError('Already Booked'); 

//         } 

//     } 

// } 






































// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {

//     //EventSpeakerTriggerHandler.duplicateSpeaker(Trigger.new);
//     Set<Id> eventId = new Set<Id>();
//     Set<Id> speakerId = new Set<Id>();
//     for(Event_Speaker__c es1: Trigger.new){
//         eventId.add(es1.Event__c);
//         speakerId.add(es1.Speaker__c);
//     }
//     Map<Id,Event__c> evtDateTime= new Map<Id, Event__c>([Select id, Start__c,End__c from Event__c where id in :eventId]);
//     Map<Id,Event_Speaker__c> eventSpeaker = new Map<Id,Event_Speaker__c>();
//         for(Event_Speaker__c es: [SELECT Id, Event__c, Speaker__c, Event__r.Start__c, Event__r.End__c  FROM Event_Speaker__c WHERE Speaker__c IN :speakerId ]){
//             eventSpeaker.put(es.Speaker__c,es);
//         }
//         for(Event_Speaker__c es: Trigger.new){
//             Event_Speaker__c es1 = eventSpeaker.get(es.Speaker__c);
//             Event__c evtTime = evtDateTime.get(es.Event__c);
//             Datetime evtTimeStart = evtTime.Start__c;
//             Datetime evtTimeEnd = evtTime.End__c;
//             if(es1 !=null){
//                 if(es.Speaker__c == es1.Speaker__c && ((evtTimeStart <= es1.Event__r.Start__c && evtTimeEnd >= es1.Event__r.End__c) || (evtTimeStart >= es1.Event__r.Start__c && evtTimeStart <= es1.Event__r.End__c) || (evtTimeEnd >= es1.Event__r.Start__c && evtTimeEnd <= es1.Event__r.End__c))){
//                     es.Speaker__c.addError('Already booked');
// //                 es1.addError('Already Booked');
//                 }
//             }
//         }
// }








// Map<Id,Event_Speaker__c> eventSpeaker = new Map<Id,Event_Speaker__c>();
//         for(Event_Speaker__c es: [SELECT Id, Event__c, Speaker__c, Event__r.Start__c, Event__r.End__c  FROM Event_Speaker__c WHERE Speaker__c IN :speakerId ]){
//             eventSpeaker.put(es.Speaker__c,es);
//         }
//         for(Event_Speaker__c es: Trigger.new){
//             Event_Speaker__c es1 = eventSpeaker.get(es.Speaker__c);
//             Event__c evtTime = evtDateTime.get(es1.Event__c);
//             Datetime evtTimeStart = evtTime.Start__c;
//             Datetime evtTimeEnd = evtTime.End__c;
//             if(es1 !=null){
//                 if(es.Speaker__c == es1.Speaker__c && ((evtTimeStart <= es1.Event__r.Start__c && evtTimeEnd >= es1.Event__r.End__c) || (evtTimeStart >= es1.Event__r.Start__c && evtTimeStart <= es1.Event__r.End__c) || (evtTimeEnd >= es1.Event__r.Start__c && evtTimeEnd <= es1.Event__r.End__c))){
//                     es.Speaker__c.addError('Already booked');
// //                 es1.addError('Already Booked');
//                 }
//             }
//         }








// List<Event_Speaker__c> spkr = [Select id, Event__c,Speaker__c,Event__r.Start__c, Event__r.End__c from Event_Speaker__c where Speaker__c in :speakerId];
//     for(Event_Speaker__c es1: Trigger.new){
//         Event__c evtTime1 = evtDateTime.get(es1.Event__c);
//         Datetime evtTimeStart = evtTime1.Start__c;
//         Datetime evtTimeEnd = evtTime1.End__c;
//         for(Event_Speaker__c checkes1: spkr){
//             if(es1.Speaker__c == checkes1.Speaker__c &&  ((evtTimeStart <= checkes1.Event__r.Start__c && evtTimeEnd >= checkes1.Event__r.End__c) ||(evtTimeStart >= checkes1.Event__r.Start__c && evtTimeStart <= checkes1.Event__r.End__c ) ||(evtTimeEnd >= checkes1.Event__r.Start__c && evtTimeEnd <= checkes1.Event__r.End__c))){
//                 es1.Speaker__c.addError('Already booked');
//                 es1.addError('Already Booked');
//             }
//         }
//     }













// trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {

//     Set<Id> eventIds = new Set<Id>();
//     Map<Id, Event_Speaker__c> speakerToEventSpeakerMap = new Map<Id, Event_Speaker__c>();
//     List<Event_Speaker__c> existingEventSpeakers = new List<Event_Speaker__c>();

//     for(Event_Speaker__c evtSpkr : Trigger.new) { 
//         eventIds.add(evtSpkr.Event__c);
//         speakerToEventSpeakerMap.put(evtSpkr.Speaker__c, evtSpkr);
//     } 
    

//     Map<Id, Event__c> eventMap = new Map<Id, Event__c>([Select id, Start__c, End__c from Event__c where id in :eventIds]);

//     for(Event_Speaker__c evtSpkr : [Select id, Event__c, Speaker__c, Event__r.Start__c, Event__r.End__c from Event_Speaker__c where Speaker__c in :speakerToEventSpeakerMap.keySet()]) {
//         Event__c event = eventMap.get(evtSpkr.Event__c);
//         Datetime evtTimeStart = event.Start__c;
//         Datetime evtTimeEnd = event.End__c;
        
//         if(speakerToEventSpeakerMap.containsKey(evtSpkr.Speaker__c)){
//             Event_Speaker__c existingEventSpeaker = speakerToEventSpeakerMap.get(evtSpkr.Speaker__c);
//             if(existingEventSpeaker.Id != evtSpkr.Id && ((evtTimeStart <= existingEventSpeaker.Event__r.Start__c && evtTimeEnd >= existingEventSpeaker.Event__r.End__c) || (evtTimeStart >= existingEventSpeaker.Event__r.Start__c && evtTimeStart <= existingEventSpeaker.Event__r.End__c) || (evtTimeEnd >= existingEventSpeaker.Event__r.Start__c && evtTimeEnd <= existingEventSpeaker.Event__r.End__c))){
//                 evtSpkr.Speaker__c.addError('Already booked');
//                 evtSpkr.addError('Already Booked');
//             }
//         }
//     }
// }