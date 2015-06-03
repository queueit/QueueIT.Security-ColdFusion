# QueueIT.Security-ColdFusion
Queue-it KnownUser integration in ColdFusion

In order to user this code please follow below steps 

1. Download the code & place it in an approprite ColdFusion directory.

2. Open QueueItSecurity.cfc file and Replace the secret key with your "Know users secret key" given in Queue-It's Go Platform. The key is available under advance event setting tab in individual event. 

3. Open QueueItSecurity.cfc file and set default value to the timezone which you prefer <cfproperty name="serverTimezone" type="string" default="Etc/GMT" hint="Default timezone of the server.">. In order to specify the exact string value please refer timezone.cfc file & <cffunction name="loadStandardTimeZones" access="private" returntype="Struct"> section.


Note: This code is using exteranl file for Timezone. The original code is available at below path
https://github.com/rip747/TimeZone-CFC
