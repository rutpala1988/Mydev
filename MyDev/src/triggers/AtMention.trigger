trigger AtMention on FeedItem (before insert) {

for(FeedItem fi:Trigger.New)

{
if(!ProcessController.control)
{
ConnectChatterRestAPI.doAction(fi.Body,UserInfo.getSessionId());

  
}
}

}