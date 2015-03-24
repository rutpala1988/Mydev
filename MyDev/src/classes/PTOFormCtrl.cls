public class PTOFormCtrl
{
    public PTO_Object__c ptoObject {get;set;}
    public Attachment normalImg {get;set;}
    public Attachment ptoImg {get;set;}
    public String existingIconName {get;set;}
    public String chatterPost {get;set;}
    public String blobString {get;set;}
    public String startString {get;set;}
    public String endString {get;set;}
    
    public PTOFormCtrl()
    {
        ptoObject = new PTO_Object__c();
        normalImg = new Attachment();
        ptoImg = new Attachment();
        ptoObject.Start_Date__c = System.now().addMinutes(1);
    }
    
    public void save()
    {
        //if user entered a time before current time, then change it so it's 5 sec in the future
        if(ptoObject.Start_Date__c < System.now())
            ptoObject.Start_Date__c = System.now().addSeconds(5);
        //get user's start/end DateTime in front end
        //calculate the string for Date Time
        startString = calculateScheduleTimeStr(ptoObject.Start_Date__c);
        endString = calculateScheduleTimeStr(ptoObject.End_Date__c);
        
        /** fetch normal pic **/
        //doing it here because view state size limitation (135KB)
        //retreive current profile pic
        ConnectApi.Photo userProfilePic = ConnectApi.ChatterUsers.getPhoto(null, UserInfo.getUserId());
        String imgUrl= userProfilePic.largePhotoUrl;
        System.Debug('current chatter img url: '+imgUrl);
        normalImg.name = 'profilePic.png';
        normalImg.Body = linkToBlob(imgUrl);

        ScheduledPTO changeToPTO = new ScheduledPTO(ptoImg);
        ScheduledPTO changeBackToNormal = new ScheduledPTO(normalImg);
        
        //schedule change back first to preserve the current profile pic
        system.schedule('Scheduled PTO End_'+endString, endString, changeBackToNormal); //SCHEDULE THE CHANGE BACK!!
        system.schedule('Scheduled PTO Start_'+startString, startString, changeToPTO); //SCHEDULE THE CHANGE!!!!
        
        //post to ur own news feed
        post();

        //reset
        ptoObject = new PTO_Object__c();
        normalImg = new Attachment();
        ptoImg = new Attachment();
        chatterPost = '';
    }
    
    public void post()
    {
        //NEED TO SCHEDULE THIS!!!!
        if(chatterPost != '')
        {
            //setup the feed using chatter connect
            String communityId = Network.getNetworkId();
            ConnectApi.FeedType feedType = ConnectApi.FeedType.News;
            ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
            input.visibility = ConnectApi.FeedItemVisibilityType.AllUsers;
            
            ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
            messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

            ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
            
            textSegment.text = chatterPost;
            messageInput.messageSegments.add(textSegment);
            input.body = messageInput;
            
            //schedule post
            ScheduledChatterConnectPost schedPost = new ScheduledChatterConnectPost(communityId, feedType, 'me', input,null);
            system.schedule('Scheduled chatter post Start_'+startString, startString, schedPost); //SCHEDULE THE Post!!!!
        }
    }

    private Blob linkToBlob(String imageUrl)
    {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //Replace any spaces with %20
        req.setEndpoint( imageUrl.replace(' ', '%20') );
        req.setMethod('GET');
        //If you want to get a PDF file the Content Type would be 'application/pdf'
        req.setHeader('Content-Type', 'image/png');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        //req.setCompressed(true);
        //req.setTimeout(60000);
                         
        HttpResponse res = new HttpResponse();
        if(!Test.isRunningTest()) //test method doesn't support web service, so don't send if it's test
            res = h.send(req);
        System.Debug('response: '+res);
        //system.debug('Response Body for File: ' + res.getBody());
        
        //only if you want to display your file on vf page 
        //Blob blobObject = res.getBodyAsBlob();
        //blobString = EncodingUtil.base64Encode(blobObject);
        //system.debug('blobString: '+blobString);
        
        //This is the line that does the magic.  We can get the blob of our file.  
        //This getBodyAsBlob method was added in the Spring 2012 release and version 24 of the API
        return res.getBodyAsBlob();
    }

    //get image url from front end and change the pto blob body to the existing image user selected
    public void changePTOImage()
    {
        //ptoImg.Body = linkToBlob(existingIconUrl);
        ptoImg.Body = [SELECT Id,body,Name FROM StaticResource where name =:existingIconName limit 1].body;
    }
    public String calculateScheduleTimeStr(DateTime dt)
    {
        String scheduleStr = '';
        scheduleStr = dt.format('s m H d M')+ ' ? '+dt.format('yyyy');
        return scheduleStr;
    }

}