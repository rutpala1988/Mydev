@isTest (seeAllData=true)
public with sharing class NextCaseTest {
    public static testMethod void runTests() {
        PageReference pageRef = Page.NextCase;
        Test.setCurrentPage(pageRef);

        String gid = myFunc();
        myFunc2(gid);
        //test.stopTest();
        //CreateCase.myMethod(g.id);
        //test.startTest();
        Case c = [select id from case order by createddate desc limit 1];
        NextCase nc = new NextCase();
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        NextCase ncStandard = new NextCase(sc);
        ncStandard.getCase();
        ncStandard.getMap();
        Case myCase = NextCase.getCaseId();
    }
    
    private static string myFunc()
    {
         ///1st DML operation
     
         User usr = [Select id from User where Id = :UserInfo.getUserId()];
         String gid;
         System.RunAs(usr)
         {
            Test.startTest();
            Group g = new Group();
            g.name = 'MyGroup';
            g.type = 'queue';
            insert g;
            
            QueueSobject mappingObject = new QueueSobject(QueueId = g.Id, SobjectType = 'Case');
            insert mappingObject;
            
            GroupMember gm = new GroupMember();
            gm.GroupId = g.id;
            gm.userorgroupid = userinfo.getuserid();
            insert gm;
            Test.stopTest();
             gid = g.id;
         }
     return gid;
     
    }
     
    @future
    private static void myFunc2(String gid)
    {
       Case c = new Case();
        c.subject = 'Hello World!';
        c.ownerId = gid;
        c.status = 'New';
        insert c;
    }
     
}