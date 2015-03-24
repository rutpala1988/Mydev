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


// Controller for VF page
public class GoogleXlateCont
{

    public List <SelectOption> Languages {get; private set;}
    
    public String  sFromLang {get; set;}
    public String  sFromText {get; set;}
    public String  sToLang   {get; set;}
    public String  sToText   {get; private set;}
    public Boolean bValidKey {get; private set;}
        
    googleXlate gX;
    
    // Constructor
    {
        gX = new googleXlate ();
        
        bValidKey = gX.ValidKey;
        if (bValidKey)
        {
            // get the language list
            Languages = gX.Languages;
            
            // provide sensible defaults
            sFromLang = 'en';
            sToLang   = 'fr';
        }
        else
            // output message on the page
            ApexPages.addMessage (new ApexPages.Message (ApexPages.Severity.FATAL, 'Incorrect Google Translation API Key'));
            
    }


    public PageReference xlate ()
    {
        sToText = gX.convert (sFromText, sFromLang, sToLang);
        
        return null;
    }

}