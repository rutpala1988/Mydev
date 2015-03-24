public class AddNumbers {

     String[] Operations=new String[]{};
     
    public List<SelectOption> getItems()
    {
    List<SelectOption> options=new List<SelectOption>();
    options.add(new SelectOption('Add','Add'));
    options.add(new SelectOption('Multiply','Multiply'));
    options.add(new SelectOption('Divide','Divide'));
    options.add(new SelectOption('Subtract','Subtract'));
    return options;
    }
    

public Integer FirstNumber{get;set;}
public Integer SecondNumber{get;set;}
public Integer ThirdNumber{get;set;}

public void setOperations()
{
 this.Operations=Operations;
 }
 
 public String[] getOperations(String[] Operations)
 {
 return Operations;
 }






public void add()
   {
      ThirdNumber=FirstNumber+SecondNumber;

   }


}