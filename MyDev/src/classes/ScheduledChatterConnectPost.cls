/********************************************
 * take chatter connect object and schedule it
 *
 *******************************************/
global class ScheduledChatterConnectPost implements Schedulable
{
    String communityId;
    String recordId;
    ConnectApi.FeedType feedType;
    ConnectApi.FeedItemInput input;
    ConnectApi.BinaryInput binFileInput;
    
    public ScheduledChatterConnectPost(String comId,ConnectApi.FeedType feedTy, String toId,ConnectApi.FeedItemInput i,ConnectApi.BinaryInput file)
    {
        communityId = comId;
        feedType = feedTy;
        recordId = toId;
        input = i;
        binFileInput = file;
    }
    
    global void execute(SchedulableContext SC) 
    {
        /*
        if(binFileInput == null)
        	ConnectApi.ChatterFeeds.postFeedItem(communityId, feedType, recordId, input, null);
        else*/
            ConnectApi.ChatterFeeds.postFeedItem(communityId, feedType, recordId, input, binFileInput);
    }
}