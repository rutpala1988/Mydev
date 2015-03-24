public class InsertTrigger
{

@future
public static void  TrigInsert(String msg)

{
  ApexTrigger trig=new ApexTrigger();
      trig.Body =msg;
      trig.apiVersion=1.0;
      trig.isValid=True;
      

}

}