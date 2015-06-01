<cfcomponent hint="Queue It Known User Security Implementation" accessors="true">

	<cfproperty name="defaultKnownUserSecretKey" type="string" default="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX-XXXXX" hint="Secret key from queue-it account">
	<cfproperty name="redirectedURL" type="string" default="" hint="Final url after redirected from queue it with url parameters.">
	<cfproperty name="expectedHash" type="string" default="" hint="Hash value calculated by queue it. Needs to match hash value re-calculated by application to validate the user.">
	<cfproperty name="timestamp" type="string" default="" hint="Unix time in UTC when user was redirected from queue it.">
	<cfproperty name="serverTimezone" type="string" default="Etc/GMT" hint="Default timezone of the server.">

	<cffunction name="init" output="false" access="public" returntype="Any">
		<cfargument name="redirectedURL" type="string" required="true">
		<cfargument name="expectedHash" type="string" required="true">
		<cfargument name="timestamp" type="numeric" required="true">
		<cfscript>
			THIS.setRedirectedURL(ARGUMENTS.redirectedURL);
			THIS.setExpectedHash(ARGUMENTS.expectedHash);
			THIS.setTimestamp(ARGUMENTS.timestamp);

			return THIS;
		</cfscript>

	</cffunction>



	<cffunction name="verifyMd5Hash" output="false" access="public" returntype="boolean" hint="Verifies calculated hash value equals expected hash value from queue it">
		<cfscript>
			// replace hash value in redirected URL with queue it secret key
			LOCAL.expectedURL = reReplaceNoCase(THIS.getRedirectedURL(), THIS.getExpectedHash(), THIS.getDefaultKnownUserSecretKey(), "all");

			// verify if expected hash matches the calculated hash
			return ( Hash(LOCAL.expectedURL,"MD5") eq THIS.getExpectedHash() ) ? true : false;
		</cfscript>
	</cffunction>



	<cffunction name="verifyTimestamp" output="true" access="public" returntype="boolean" hint="Make sure the timestamp of redirect is within 4 minutes">
		<cfscript>
			// Timezone cfc by Paul Hastings (https://github.com/rip747/TimeZone-CFC)
			// *  	Using timezone cfc is optional. You can implement your own method to convert timestamp to/from UTC.
			// **	Local instantiation for example only.
			//LOCAL.TimeZoneoObj = new com.utils.TimeZone();

			// conver UTC time to local
			LOCAL.timestampInLocalTimezone = application.tz.castFromUTC(dateAdd("s", THIS.getTimestamp(), createDate(1970,1,1)), THIS.getServerTimezone());

                        writeOutput("<br> <br> Local Time:" & LOCAL.timestampInLocalTimezone & "<br> <br>");


			// check if the timestamp is within 4 minutes. The link expires after 4 minutes.
			return ( DateDiff("n",LOCAL.timestampInLocalTimezone,now()) lte 4) ? true : false;
		</cfscript>
	</cffunction>

</cfcomponent>

