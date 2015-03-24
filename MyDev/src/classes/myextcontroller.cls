public class myextcontroller
{

private final Account acct;

public myextcontroller(ApexPages.StandardController    stdcontroller)
{
this.acct=(Account)stdcontroller.getRecord();
}

public String getGreetings()
{

return 'Account Name : '+acct.name+'\n';
}
}