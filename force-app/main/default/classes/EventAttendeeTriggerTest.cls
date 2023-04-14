@isTest
private class EventAttendeeTriggerTest {
    @isTest
    static void sendEmailsTest() {
        // Setup test data
        Event_Organiser__c org = new Event_Organiser__c(
            Name = 'Test Org',
            Phone__c = '1234567890',
            Email__c = 'pragam.kaistha@mirketa.com'
        );
        insert org;
        Event__c evt = new Event__c(
            Name__c = 'Test Event',
            Event_Organizer__c = org.Id,
            Event_Type__c = 'Virtual',
            Frequency__c = 'Weekly',
            Max_Seats__c = 100,
            Recurring__c = true,
            Live__c = true,
            Start__c = System.now().addDays(1),
            End__c = System.now().addDays(3)
        );
        insert evt;
        Attendee__c att = new Attendee__c(
            Name = 'Test Attendee',
            Email__c = 'kaisthapragam@gmail.com',
            Phone__c = '1234567890'
        );
        insert att;
        Event_Attendee__c evtAtt = new Event_Attendee__c(
            Event__c = evt.Id,
            Attendee__c = att.Id
        );
        insert evtAtt;
        
        // Call the method being tested
        Test.startTest();
        EventAttendeeTriggerHandler.sendEmails(new List<Event_Attendee__c>{ evtAtt });
        Test.stopTest();
        
        // Verify that an email was sent
        System.assertEquals(1, Limits.getEmailInvocations());
    }


    // @isTest
    // static void notSendEmailsTest() {
    //     // Setup test data
    //     Event_Organiser__c org = new Event_Organiser__c(
    //         Name = 'Test Org123',
    //         Phone__c = '326915494'
    //     );
    //     insert org;
    //     Event__c evt = new Event__c(
    //         Max_Seats__c = 100,
    //         Live__c = true,
    //         Start__c = System.now().addDays(1),
    //         End__c = System.now().addDays(3)
    //     );
    //     insert evt;
    //     Attendee__c att = new Attendee__c(
    //         Name = 'Test Attendee',
    //         Phone__c = '1234656490'
    //     );
    //     insert att;
    //     Event_Attendee__c evtAtt1 = new Event_Attendee__c(
    //         Event__c = evt.Id,
    //         Attendee__c = att.Id
    //     );
    //     insert evtAtt1;
        
    //     // Call the method being tested
    //     Test.startTest();
    //     EventAttendeeTriggerHandler.sendEmails(new List<Event_Attendee__c>{ evtAtt1 });
    //     Test.stopTest();
        
    //     // Verify that an email was sent
    //     System.assertEquals(0, Limits.getEmailInvocations());
    // }
}