public class JSONConverter{

   //declare Account and boolean variables for thr wrapper class
   public Account account{get;set;}
   public boolean display{get;set;}
   public String jsonString{get;set;}
   
       public JSONConverter(){
        //insert new account and set the boolean value as false.
        account=new Account();
        account.Name='Test';
        
        display=false;    
         
       
     }
       
     public void convertToJSON(){
     insert account;
     jsonString=JSON.serialize(account);
    
     
     
     
     
     }  

    
    
    
 }