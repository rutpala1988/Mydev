public class MyFirstTestClass
{

public PageReference saveRecord()
{

 Case c= new Case();
 c.subject='Inserting this case using apex code';
 insert c;
 
 return null;
}


}