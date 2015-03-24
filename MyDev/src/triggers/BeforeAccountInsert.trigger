trigger BeforeAccountInsert on Account (before insert) {
    for(Account a:Trigger.new)
    {
        if(a.Type==null)
        {
         a.Type.addError('Account type cannot be empty');
         }
         
         if(a.Industry==null)
         
         {
         a.Industry.addError('Account Industry cannot be empty');
         }
        
        
        if(a.Name.contains('test'))
        {
            a.Description='This is a test account left for testing';
        }
    }

}