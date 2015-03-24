public class MyExtensionController
{

Account myaccount;

public MyExtensionController(ApexPages.StandardController controller)
{
myaccount=(Account)controller.getRecord();
}

public String getGreetings()
{
return 'Hello'+myaccount.name;
}
}