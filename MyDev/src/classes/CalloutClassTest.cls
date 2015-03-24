@isTest
private class CalloutClassTest {
     @isTest static void testCallout() {
        
        Profile p = [select id from profile where name='System Administrator'];
 
        User user = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id, country='United States',
            timezonesidkey='America/Los_Angeles', username='test123@noemail.com');
        insert user; 
        
        Mailing_List__c mlc = new Mailing_List__c();
        mlc.MailingListName__c = '#testmailingList';
        mlc.Users__c = 'Testing';
        insert mlc;
         
        SSEChatterList scl = new SSEChatterList();
        scl.finalList = 'Testing';
        scl.mailingListName = '#testmailingList';
        
        scl.SaveList();
        
        
        FeedItem fi = new FeedItem();
        fi.body = 'Hello #testmailingList team';
        fi.ParentId = user.id;
        insert fi;
         
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new SSEChatterListTest());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        CalloutClass call=new CalloutClass();
        call.getInfoFromExternalService();
        
        try{
        // Verify response received contains fake values
       /* String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());*/
        }catch(Exception e){
        
        
        }
         
         
    }
}