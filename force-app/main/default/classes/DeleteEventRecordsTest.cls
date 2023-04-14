@isTest
public class DeleteEventRecordsTest {

    @testSetup
    public static void testSetupData(){
        Event_Organiser__c  org = new Event_Organiser__c (
            Name = 'PK Test1',
            Phone__c = '9658656985',
            Email__c = 'pragam.kaistha@mirketa.com',
            Alternate_Phone__c  = '6549652145',
            Alternate_Email__c ='pragamkaistha@gmail.com'
        );
        insert org;
        List<Event__c> eventList = new List<Event__c>();
        for(Integer i=0; i<=200; i++){
            Event__c event = new Event__c(
                Name__c = 'New Event #'+i+1,
                Event_Organizer__c  = org.Id,
                Event_Type__c = 'Virtual',
                Frequency__c  = 'Weekly',
                Max_Seats__c  = 199,
                Recurring__c = true,
                Live__c = true,
                Start__c = System.now().addMonths(-4),
                End__c  = System.now().addDays(3).addMonths(-4)
            );
            eventList.add(event);
        }
        insert eventList;
    }
    
    @isTest
    static void sendDeletEventTest(){
        Test.startTest();

        String jobId = Database.executeBatch(new DeleteEventRecords(), 250);
        
        Test.stopTest();
        List<Event__c> eventList = [Select id, Name from Event__c];
        System.assertEquals(0, eventList.size());
    }
}