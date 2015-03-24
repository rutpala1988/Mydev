trigger BeforeSave on Quote (after insert) {

for(Quote q: Trigger.New)
{

  /*FeedItem fi=new FeedItem();
  
  fi.ParentId=q.Id;
  fi.Body='GE Drilling is happy to accept your RFQ. We will be reviewing the details and providing you with timely updates.';
  insert fi;*/
  
  ChatterRestAPI.invokeMethod(q.Id);
  
  
  
  
  
  
  /* String communityId = null;
ConnectApi.FeedType feedType = ConnectApi.FeedType.UserProfile;
String userToMention = '005900000012kGH';
String subjectId = '005900000012kGH';

ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
textSegment.text = 'GE Drilling is happy to accept your RFQ. We will be reviewing the details and providing you with timely updates. ';
messageInput.messageSegments.add(textSegment);

ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
mentionSegment.id = userToMention;
messageInput.messageSegments.add(mentionSegment);


textSegment = new ConnectApi.TextSegmentInput();
textSegment.text = '. How are you?';
messageInput.messageSegments.add(textSegment);


ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
input.body = messageInput;

ConnectApi.FeedItem feedItemRep = ConnectApi.ChatterFeeds.postFeedItem(communityId, feedType, subjectId, input, null);

*/
  

}

}