@isTest(seeAllData = true)
public class TestPTOForm
{
	public static testMethod void runTest()
    {
    	PTOFormCtrl controller = new PTOFormCtrl();
        controller.ptoObject.Start_Date__c = System.now().addMinutes(3);
        controller.ptoObject.End_Date__c = System.now().addMinutes(5);
        controller.chatterPost = 'test method';
        controller.ptoImg.body = [select body from attachment limit 1].body;
        controller.save();
    }
}