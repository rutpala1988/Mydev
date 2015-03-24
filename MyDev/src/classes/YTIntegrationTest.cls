public class YTIntegrationTest {
    
    private String endpoint = 'https://www.googleapis.com/youtube/v3/search?part=snippet&order=viewCount&q=';
    private String endpoint1 = 'https://www.googleapis.com/youtube/v3/videos?id=';
    public String TempRes {set;get;}
    public String TempRes1 {set;get;}
    
    public superItemMapOne[] dataSetOne {get;set;}
    
    private final Lead acct;
    public String searchString;
    public String id;
    
    public YTIntegrationTest(ApexPages.StandardController controller) {
        this.acct = (Lead)controller.getRecord();
        id = apexpages.currentpage().getparameters().get('id');
        Lead l = [select id,search__c from Lead where id=:id];
        searchString = l.search__c;
        try{
        searchString = searchString.replaceAll(' ','+');
        system.debug('-------'+searchString );
        }catch(Exception e){
        
        }
        endpoint = endpoint+searchString+'&type=video&key=AIzaSyCRBPLmRmuUUXJi7xKcMO4i7ScWr2E27-M';
    }

    //AIzaSyCRBPLmRmuUUXJi7xKcMO4i7ScWr2E27-M
    
    public PageReference fetchData() {
        
        dataSetOne = new superItemMapOne[]{};
        
        http h = new http();        
        httprequest req = new httprequest();  
        req.setHeader('Accept', 'application/json');                  
        req.setEndpoint(endpoint);
        req.setMethod('GET');
              
        req.setTimeout(60000);        
        httpresponse res = h.send(req);        
        TempRes = res.getBody(); 
        
        JSONParser parser = JSON.createParser(res.getBody());          
        masterobj d = (masterobj)JSON.deserialize(TempRes, masterobj.class);
        
        for(integer j=0;j<d.items.size();j++){            
            String videCount = checkVideoDetails(d.items[j].id.videoId);
            Date dt = date.today();
            integer stYear = integer.valueof(d.items[j].snippet.publishedAt.substring(0,4));
            integer stMonth = integer.valueof(d.items[j].snippet.publishedAt.substring(5,7));
            integer stDay = integer.valueof(d.items[j].snippet.publishedAt.substring(8,10));
            date dueDate = date.newInstance(stYear , stMonth , stDay );
            
            integer numberDaysDue = dueDate.monthsBetween(dt);            
            integer modMonth = math.mod(numberDaysDue,12);
            integer modYear = numberDaysDue/12;
            
            String videoAge = String.valueOf(modYear)+'Years '+String.valueOf(modMonth )+'Months ago';
            
            dataSetOne.add(new superItemMapOne(d.items[j].snippet.title,d.items[j].snippet.description,d.items[j].snippet.thumbnails.medium,videCount,d.items[j].snippet.channelTitle,videoAge,d.items[j].id.videoId));
        }
        endpoint = 'https://www.googleapis.com/youtube/v3/search?part=snippet&order=viewCount&q=';
        return null;
    }
 
    public String checkVideoDetails(String c){
        return fetchVideoDetails(c);
     
    }
    public String fetchVideoDetails(String c){
       
        endpoint1 = endpoint1+c+'&key=AIzaSyCRBPLmRmuUUXJi7xKcMO4i7ScWr2E27-M&fields=items(id,snippet(channelId,title,categoryId),statistics)&part=snippet,statistics';
        http h1 = new http();        
        httprequest req1 = new httprequest();  
        req1.setHeader('Accept', 'application/json');                  
        req1.setEndpoint(endpoint1);
        req1.setMethod('GET');
              
        req1.setTimeout(60000);        
        httpresponse res1 = h1.send(req1);               
        
        JSONParser parser1 = JSON.createParser(res1.getBody()); 
        TempRes1 = res1.getBody(); 
        String videoCount; 
        videoObj d1 = (videoObj)JSON.deserialize(TempRes1, videoObj.class);
        
        for(integer jj=0;jj<d1.items.size();jj++){         
            videoCount = d1.items[jj].statistics.viewCount;
        }
        endpoint1 = 'https://www.googleapis.com/youtube/v3/videos?id=';
        
        return videoCount;
    }
    
    public class superItemMapOne{
        public String f1 {get;set;}
        public String f2 {get;set;}
        public String f3 {get;set;}
        public String f4 {get;set;}
        public String f5 {get;set;}
        public String f6 {get;set;}
        public String f7 {get;set;}
        
        public superItemMapOne(String fc1, String fc2, cls_medium fc3, String fc4, String fc5, String fc6, String fc7) {
            f1 = fc1;
            f2 = fc2;
            f3 = fc3.url;
            f4 = fc4;
            f5 = fc5;
            f6 = fc6;
            f7 = fc7;
            
        }

    }
    
    class videoObj{
        public cls_items1[] items;
        
    }
    class cls_items1 {
            public String id;   //2iUZRSeqzz8
            public cls_snippet1 snippet;
            public cls_statistics statistics;
        }
        class cls_snippet1 {
            public String channelId;    //UCBOKoEa8bLuk5TqRXFMD16w
            public String title;    //TUM HO SONG from ROCKSTAR - Mohit Chauhan (FULL SONG)
            public String categoryId;   //10
        }
        class cls_statistics {
            public String viewCount;    //9259828
            public String likeCount;    //16575
            public String dislikeCount; //649
            public String favoriteCount;    //0
            public String commentCount; //2982
        }
    class masterobj{   
        public String kind; //youtube#searchListResponse
        public String etag; //"g-RLCMLrfPIk8n3AxYYPPliWWoo/D74LmxrfGuQLTAIWTVInHKpNjR4"
        public cls_pageInfo pageInfo;
        public String nextPageToken;    //CAUQAA
        public cls_items[] items;    
    }
    
    
    class cls_pageInfo {
        public Integer totalResults;    //1000000
        public Integer resultsPerPage;  //5
    }
         
    
    class cls_items {
        public String kind; //youtube#searchResult
        public String etag; //"g-RLCMLrfPIk8n3AxYYPPliWWoo/7V3f_pSqwTskErIhapVnov87YAk"
        public cls_id id;
        public cls_snippet snippet;
        
        /**public cls_items (String s1, String s2,cls_id s3,cls_snippet s4) {            
            this.kind = s1;
            this.etag = s2;
            this.id = s3;
            this.snippet = s4;
        }
        */
        
    }
    class cls_id {
        public String kind; //youtube#channel
        public String videoId;    //HCpLKZQHp5ZsI
    }
    class cls_snippet {
        public String publishedAt;  //2013-04-21T16:04:36.000Z
        public String channelId;    //HCpLKZQHp5ZsI
        public String title;    //A. R. Rahman
        public String description;  //Since Roja hit movie screens in South India in 1992, A.R. Rahman has been redefining the country's widely popular film music. Generally regarded as the fines...
        public cls_thumbnails thumbnails;
        public String channelTitle; //A. R. Rahman
        
        /**public cls_snippet (String s1, String s2,String s3,String s4,cls_thumbnails s5,String s6) {            
            this.publishedAt= s1;
            this.channelId= s2;
            this.title= s3;
            this.description= s4;
            this.thumbnails = s5;
            this.channelTitle= s6;
        }*/
        
    }
    class cls_thumbnails {
        //public cls_default default;
        public cls_medium medium;
        public cls_high high;
    }
    class cls_default {
        public String url;  //https://i.ytimg.com/li/pLKZQHp5ZsI/default.jpg
    }
    class cls_medium {
        public String url;  //https://i.ytimg.com/li/pLKZQHp5ZsI/default.jpg
    }
    class cls_high {
        public String url;  //https://i.ytimg.com/li/pLKZQHp5ZsI/hqdefault.jpg
    }
   
    
    
    
}