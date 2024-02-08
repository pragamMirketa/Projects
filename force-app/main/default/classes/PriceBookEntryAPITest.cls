@isTest
private class PriceBookEntryAPITest {
    
    @isTest
    static void testMyCallout() {
        // Set up mock callout
        Test.setMock(HttpCalloutMock.class, new PriceBookEntryAPIMock());
        
        // Call the method being tested
        Test.startTest();
        List<PriceBookWrapper> priceBkWrap = PriceBookEntryAPI.myCallOut();
        Test.stopTest();
        
        // List<PricebookEntry> entries = [SELECT Id, Product2.Name, Product2Id, UnitPrice                                         FROM PricebookEntry];
        
        System.assertEquals(2, priceBkWrap.size());
        System.assertEquals('Product 1', priceBkWrap[0].pd.Name);
        System.assertEquals(9.99, priceBkWrap[0].pben.UnitPrice);
        System.assertEquals('Product 2', priceBkWrap[1].pd.Name);
        System.assertEquals(19.99, priceBkWrap[1].pben.UnitPrice);
    }
}
























// @isTest
// public with sharing class PriceBookEntryAPITest {
    
//     @isTest
//     static void myCallOutTest(){
//         String mockResponse = '[{"id":1,"title":"Product 1","description":"Product 1 description","price":"10.99"},{"id":2,"title":"Product 2","description":"Product 2 description","price":"20.99"}]';
//         Test.setMock(HttpCalloutMock.class, new PriceBookEntryAPIMock(mockResponse));
//         List<PricebookEntry> pbEntries = PricebookEntryAPI.myCallOut();
//         System.assertEquals(2, pbEntries.size());
//         System.assertEquals('Product 1', pbEntries[0].Product2.Name);
//         System.assertEquals('10.99', String.valueOf(pbEntries[0].UnitPrice));
//         System.assertEquals('Product 2', pbEntries[1].Product2.Name);
//         System.assertEquals('20.99', String.valueOf(pbEntries[1].UnitPrice));

//     }


//     private class PriceBookEntryAPIMock implements HttpCalloutMock{
//         private String mockResponse;
//         public PriceBookEntryAPIMock(String mockResponse) {
//             this.mockResponse = mockResponse;
//         }
//         public HttpResponse respond(HttpRequest req){
//             HttpResponse res = new HttpResponse();
//             res.setStatusCode(200);
//             res.setBody(mockResponse);
//             return res;
//         }
//     }
// }