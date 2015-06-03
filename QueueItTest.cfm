<cfapplication name="tztest">
<cfif not structkeyexists(application, "tz")>
	<cfset application.tz = createObject("component","timeZone").init()>
	<p>TimeZone class is now loaded</p>
</cfif>


<cfdump var = "This is Coldfusion Queue-IT Known User Implementation Sample" />

<cfscript>


VARIABLES.queueItKnownUserHash = false;
VARIABLES.queueItKnownUserTimestamp = false;
    if(structKeyExists(URL,"q")
        and structKeyExists(URL,"p")
        and structKeyExists(URL,"ts")
        and structKeyExists(URL,"h")
        and len(trim(URL.q))
        and len(trim(URL.p))
        and len(trim(URL.h))
        and isNumeric(URL.ts)
    ) {
    	// create queue it security object for known user verification
        VARIABLES.QueueItSecurityObj = new QueueItSecurity(
            redirectedURL = GetPageContext().GetRequest().GetRequestUrl().Append("?" & GetPageContext().GetRequest().GetQueryString()).ToString(),
            expectedHash = URL.h,
            timestamp = URL.ts
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


<cfdump var = "[Is this user known Hash : #queueItKnownUserHash# ]"  />

<cfdump var = "[Is this user known Timestamp: #queueItKnownUserTimestamp# ]"  />
