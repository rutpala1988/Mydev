trigger TestPhone on Account (before update) {
for(Account acct:Trigger.New)
{
  if(acct.Phone==null)
  {
   System.debug('Iam into this section');
    acct.addError('Phone number cannot be empty');
    
  
  }

}

}