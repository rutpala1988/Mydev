@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://ap1.salesforce.com/services/data/v29.0/chatter/mentions/completions?q=h', req.getEndpoint());
        //System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        //res.setBody('{"foo":"bar"}');
        res.setStatusCode(200);
        return res;
        List<User> u1=[select Id,Name from User limit 1];
        //System.assertEquals('https://ap1.salesforce.com' + '/services/data/v29.0/chatter/feeds//user-profile/'+u1[0].id+'/feed-items', req.getEndpoint());
        //System.assertEquals('POST', req.getMethod());
        
        HttpResponse res1 = new HttpResponse();
        res1.setHeader('Content-Type', 'application/json');
        //res.setBody('{ "body" : { "messageSegments" : [ { "type": "mention", "id" :"'+u1[0].Id+'"}, { "type": "text",  "text" :"Hello" } ] } }');
        res1.setStatusCode(200);
        return res1;
    }
    }