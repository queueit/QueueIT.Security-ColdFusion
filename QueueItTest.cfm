<cfapplication name="tztest">
<cfif not structkeyexists(application, "tz")>
	<cfset application.tz = createObject("component","timeZone").init()>
	<p>TimeZone class is now loaded</p>
</cfif>


<cfdump var = "This is Coldfusion Queue-IT Known User Implementation Sample" />

<cfscript>
	
VARIABLES.queueItKnownUser = false;
VARIABLES.queueItKnownUserHash = false;
VARIABLES.queueItKnownUserTimestamp = false;

    if(structKeyExists(URL,"qitq")
        and structKeyExists(URL,"qitp")
        and structKeyExists(URL,"qitts")
        and structKeyExists(URL,"qith")
        and len(trim(URL.qitq))
        and len(trim(URL.qitp))
        and len(trim(URL.qith))
        and isNumeric(URL.qitts)
    ) {

    	// create queue it security object for known user verification
        VARIABLES.QueueItSecurityObj = new QueueItSecurity(
            redirectedURL = "http://#CGI.SERVER_NAME#:8500#CGI.SCRIPT_NAME#?#replaceNoCase(CGI.QUERY_STRING,'&&','&','ALL')#",
            expectedHash = URL.qith,
            timestamp = URL.qitts
        );
        
       
if(VARIABLES.QueueItSecurityObj.verifyMd5Hash()) {
            VARIABLES.queueItKnownUserHash = true;
        }
if(VARIABLES.QueueItSecurityObj.verifyTimestamp()) {
            VARIABLES.queueItKnownUserTimestamp = true;
        }

    }

    // if not a known user, redirect to queue it else store the queue number in session
    if(VARIABLES.queueItKnownUser eq false) {
    	// redirect to queue it
    }
    else {
        
    	// Valid user....

    }

</cfscript>


<cfdump var = "#QueueItSecurityObj#"  />

<cfdump var = "[Is this user known : #queueItKnownUser# ]"  />

<cfdump var = "[Is this user known Hash : #queueItKnownUserHash# ]"  />

<cfdump var = "[Is this user known Timestamp: #queueItKnownUserTimestamp# ]"  />
