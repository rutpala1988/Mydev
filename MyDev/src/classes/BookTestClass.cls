@isTest
public class BookTestClass{

static testMethod void bookTest()
{

Book__c book1=new Book__c(Name='abc',Price__c=200);
System.debug('price before inserting'+book1.Price__c);
insert book1;
book1=[SELECT Name,Price__c FROM Book__c WHERE Id=:book1.Id];
System.debug('price after trigger fired'+book1.Price__c);

}

}