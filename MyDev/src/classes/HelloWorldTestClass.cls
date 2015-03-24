@isTest 
private class HelloWorldTestClass {
    static testMethod void validateHelloWorld() {
        User u = [select id from User where alias='KKarn'];
        System.runAs(u) {

        
            Mailing_List__c ml = new Mailing_List__c ();
            ml.MailingListName__c = '#Testing';
            ml.users__c = 'Krishna Teja Karnam,Chaitanya Krishna';
            insert ml;
            
            feedItem fi = new feedItem();
            fi.body = 'Testing #Testing Chatter Mailing List';
            fi.parentId = Userinfo.getUserId();
            
            insert fi;
            
            List<String> parts = new List<String>();
            parts.add('Krishna Teja Karnam');
            parts.add('Chaitanya Krishna');
            testAtMention.insertAtMen(parts,fi.body,fi.id);   
        
        
        }
    }
}