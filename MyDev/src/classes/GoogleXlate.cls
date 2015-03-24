// Copyright 2013, Doug Merrett - Sales Engineering, Salesforce.com Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer. 
// - Redistributions in binary form must reproduce the above copyright notice, 
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the salesforce.com nor the names of its contributors
//   may be used to endorse or promote products derived from this software
//   without specific prior written permission. 
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

/*
**********************************************************************************************
** The actual translate class.  The API key must be entered into the GoogleAPI Custom Setting
** with the Name of "Translate" and the API Key as the actual API Key from Google.
**
** Even though all keys are the same at the moment for all calls for the same account, you 
** could have different keys for each service.
**
** Full doc at https://developers.google.com/translate/
**
**********************************************************************************************
*/


public class GoogleXlate
{
    // Has a valid key?
    public Boolean ValidKey {get; private set;}    
    
    // List of languages if required
    public List <SelectOption> Languages {get; private set;}

    // The APIKey to use.  Set in the constructor.
    String APIKey;

    // Convert the text.  You can pass an empty string as sFromLang to mean "work it out google"
    public String Convert (String sFromText, String sFromLang, String sToLang)
    {
        // Response from the translation
        String sToText;
        
        // Define the URL
        String URL = 'https://www.googleapis.com/language/translate/v2?key=' + APIKey +
                     '&q=' + EncodingUtil.urlEncode (sFromText, 'UTF-8') +  // you need to encoded text to put on the URL
                     '&source=' + sFromLang +                               // add the languages 
                     '&target=' + sToLang;                                  

        // Instantiate a new http object
        Http h = new Http ();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest ();
        req.setEndpoint (URL);
        req.setMethod ('GET');

        // Send the request, and return a response
        HttpResponse res = h.send (req);        

        // The response should look like this
        //
        // {
        //  "data": {
        //  "translations": [
        //    {
        //     "translatedText": "XXXXX"
        //    }
        //   ]
        //  }
        // }


        // Parse from JSON        
        Map <String, Object> JSONResponse = (Map <String, Object>) JSON.deserializeUntyped (res.getBody ());
        
        // Get the "data" lump
        Map <String, Object> Data = (Map <String, Object>) JSONResponse.get ('data');
        
        // If there is some "data", then we're OK to continue
        if (Data != null)
        {
            // Get the "translations" lump
            List <Object> Trans = (List <Object>) Data.get ('translations');
    
            // There should only be one translation and we will parse it now
            Map <String, Object> T = (Map <String, Object>) Trans [0];
            sToText = (String) T.get ('translatedText');
        }
        else
        {
            sToText = 'Error in the call';
        }
        
        return sToText;
    }
        
    // Constructor
    {
        // Set initial Language List
        Languages = new List <SelectOption> ();

        // Do we have a valid Google Key? - do a call to get the list of languages to test the API Key (free call) and use
        // this to populate the Language selection list
        GoogleAPI__c Translate = GoogleAPI__c.getInstance ('Translate');
        APIKey = Translate.API_Key__c;

        // Define the URL - get all languages that can be translated into English (to get their names)
        String URL = 'https://www.googleapis.com/language/translate/v2/languages?key=' + APIKey + '&target=en';

        // Instantiate a new http object
        Http h = new Http ();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest ();
        req.setEndpoint (URL);
        req.setMethod ('GET');

        // Send the request, and return a response
        HttpResponse res = h.send (req);
 
        // The response should look like this
        //
        // {
        // "data": {
        //  "languages": [
        //   {
        //    "language": "af",
        //    "name": "Afrikaans"
        //   },
        //   {
        //    "language": "sq",
        //    "name": "Albanian"
        //   },
        //   ... more data ...
        //   {
        //    "language": "yi",
        //    "name": "Yiddish"
        //   }
        //  ]
        // }
        //}


        // Parse from JSON        
        Map <String, Object> JSONResponse = (Map <String, Object>) JSON.deserializeUntyped (res.getBody ());
        
        // Get the "data" lump
        Map <String, Object> Data = (Map <String, Object>) JSONResponse.get ('data');
        
        // If there is some "data", then we're OK to continue and set the flag appropriately
        ValidKey = (Data != null);
                
        if (ValidKey)
        {
            // Get the "languages" lump
            List <Object> Langs = (List <Object>) Data.get ('languages');
    
            // Now loop through collecting the Map each time and get the language code and the name
            for (Object Lang : Langs)
            {
                Map <String, Object> L = (Map <String, Object>) Lang;
                Languages.add (new SelectOption ((String) L.get ('language'), (String) L.get ('name')));
            }
        }
    }
}