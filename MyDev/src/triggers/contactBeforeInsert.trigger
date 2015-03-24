trigger contactBeforeInsert on Contact (before Insert) {
    
    
    boolean test=trigger.isInsert;
    System.debug('++++++++'+test);
    
    for(Contact c:trigger.new)
     {
    
     
     
     if(c.FirstName==null)
      {

       c.FirstName.addError('First Name is mandatory');
      
      }
      else if (c.Phone==null)
      {
       c.Phone.addError('Phone Number is mandatory');
     
     }
     }

}