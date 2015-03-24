@isTest
public with sharing class MyClass_TC {
    
     static testMethod void verifyDescription()
    {
       List<Account> accounts =new List<Account>{}; 
       for(Integer i=0;i<200;i++)
       {
        Account a=new Account(Name='test account'+i);
        accounts.add(a);
       }
       
       test.startTest();
       
       insert accounts;
       
       List<Account> insertedaccounts=[select Name,Description from Account where Id in :accounts];
       
       for(Account a:insertedaccounts)
       {
        System.assertEquals('This is a test account left for testing',a.Description);
       }
       
    }
    

}