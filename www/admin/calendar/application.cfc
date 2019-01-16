<cfcomponent displayname="Application">
	<cfset This.Name = "Salon" />
	<cfset This.Sessionmanagement = true /> 
	<cfset This.Sessiontimeout = "#CreateTimeSpan(0,1,0,0)#" />
	<cfset This.Applicationtimeout = "#CreateTimeSpan(7,0,0,0)#" />	

	<cfif cgi.https eq "on">
		<cfset application.protocol = "https">
	</cfif>

	<cffunction name="onApplicationStart"  returnType="boolean">
		<cfset Application.Sessions = 0 />

		<cfset Application.datasource = "salonworks" />	
		
		<cflog file="#This.Name#" type="Information" text="--- Application Started ---" />
		
		<cfreturn True />
	</cffunction>
	
		
	<cffunction name="onApplicationEnd" returntype="void">
	   <cfargument name="ApplicationScope" required="true" />
	   
	   <cflog file="#This.Name#" type="Information" text="Application #Arguments.ApplicationScope.applicationname# Ended" />
	</cffunction>

	
	<cffunction name="onSessionStart">
		<cfset Session.Cart = ArrayNew(1) />
		<cfset Session.UserID = 0 />
		<cfset Session.discount_code = 0 />
		<cfparam name="session.savelist" default="">
		<cfparam name="session.cartlist" default="">
      	<cflock scope="Application" timeout="5" type="Exclusive">
         	<cfset Application.Sessions = Application.Sessions + 1 />
   		</cflock> 
	</cffunction>
	
	<cffunction name="onSessionEnd" returnType="void">
	   <cfargument name="SessionScope" required="True" />
	   <cfargument name="ApplicationScope" required="False" />

   		<cfset var SessionLength = TimeFormat(Now() - SessionScope.started,"H:mm:ss") />
	   <cflock name="AppLock" timeout="5" type="Exclusive">
		  <cfset Arguments.AppScope.Sessions = Arguments.AppScope.Sessions - 1>
	   </cflock>
   		<cflog file="#This.Name#" type="Information" text="Session #Arguments.SessionScope.Sessionid# ended. Length: #SessionLength# Active Sessions: #Arguments.AppScope.Sessions#" />
	</cffunction>
	
	
	<cffunction name="onRequestStart" returnType="boolean">
		<cfargument name="targetPage" type="String" required="true" />

		<cfif isDefined("url.reload")>
			<cfinclude template="ApplicationInit.cfm" />
		</cfif>	

		<cfreturn True />
	</cffunction>
	

</cfcomponent>
 
