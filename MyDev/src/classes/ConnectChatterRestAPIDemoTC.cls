@isTest(seeAllData=true)

public class ConnectChatterRestAPIDemoTC
{
public static testMethod void  testChatter()
{

List<User> uList=[Select Id,name from User limit 1];
String p='@'+uList[0].name+': Hello How are you doing';

ConnectChatterRestAPIDemo.post=p;
ConnectChatterRestAPIDemo c1=new ConnectChatterRestAPIDemo();
c1.createPost();
Test.startTest();
Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
c1.doAction();

}




}