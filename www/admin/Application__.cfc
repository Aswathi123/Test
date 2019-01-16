<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">
 
 
	<!--- Set up the application. --->
	<cfset THIS.Name = "SalonWorksAdmin" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 1, 0, 0, 0 ) />
	<cfset THIS.sessiontimeout = CreateTimeSpan(0,0,45,0) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SetClientCookies = true />
 
 
	<!--- Define the page request properties. --->
	<cfsetting
		requesttimeout="20"
		showdebugoutput="true"
		enablecfoutputonly="false"
		/>
 
 
	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">
 
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
 
	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
 
	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing.">
		
		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
 		<cfparam name="request.dsn" default="Salonworks">
 		<cfset application.datasource="Salonworks">
 		<cfset application.bugLogService=createObject("component","buglog.client.bugLogService").init(bugLogListener="http://salonworks.com/buglog/listeners/bugLogListenerREST.cfm",bugEmailRecipients="jacinth@spericorn.com",bugEmailSender="reshma.r@spericorn.com")>
		<cfif isAJAXRequest()>
			<!--- <cfif not structKeyExists(session,"Location_ID")>
				<cflocation url="login.cfm" addtoken="no" />
			</cfif> --->
			<!--- If AJAXResponse is not set, then generated content is response. --->
			<cfsetting	showDebugOutput="false" enableCFOutputOnly="false" />
			<cfparam name="request.AJAXResponse" default="#getPageContext().getOut().getString()#" />
			<cfcontent	reset= "true" /> 
		<cfelse>
		
			<!--- <cfif cgi.script_name neq "/admin/login.cfm" AND cgi.script_name neq "/admin/process_registration.cfm"
					AND Not structKeyExists(Session,"Location_ID") >
				<cflocation url="login.cfm" addtoken="no" />
			</cfif>  --->
			 <cfif cgi.script_name neq "/admin/login.cfm" AND cgi.script_name neq "/admin/process_registration.cfm"
					 AND Not structKeyExists(Session,"professional_id")>
				<cflocation url="login.cfm" addtoken="no" />
			</cfif> 
			
		</cfif>
		
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
 
<!--- <cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">
 
		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
			<cfdump var="#arguments#">
 			<cfdump var="#request#">
		Include the requested page.
		<cfinclude template="#ARGUMENTS.TargetPage#" />
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
 
	<cffunction
		name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete.">
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
  --->
 <!---
	<cffunction
		name="OnSessionEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated.">
 
		<!--- Define arguments. --->
		<cfargument
			name="SessionScope"
			type="struct"
			required="true"
			/>
 
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
 
	<cffunction
		name="OnApplicationEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated.">
 
		<!--- Define arguments. --->
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction> --->

	<cffunction	name= "isAJAXRequest" output="false" access="private">		
		<cfif structKeyExists( getHTTPRequestData().headers , "X-Requested-With" )>
			<cfreturn true />
		</cfif>
		<cfreturn false />
	</cffunction>

 
	<cffunction
		name="OnError"
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch.">
 
		<!--- Define arguments. --->
		<cfargument
			name="Exception"
			type="any"
			required="true"
			/>
 
		<cfargument
			name="EventName"
			type="string"
			required="false"
			default=""
			/>
 		
 		<cfmail server="smtp.gmail.com" port="465" from="aswathi.k@spericorn.com" to="aswathi.k@spericorn.com"subject="error on site-Admin #now()#" type="HTML" username="aswathi.k@spericorn.com" password="aashnairknr"  useSSL ="yes" useTLS ="yes">
				<h3>Error occurred in SalonWorks Admin side</h3>
				<h5> Logged In user Details </h5>
				<p> username:<cfif structKeyExists(session, "first_name")> #session.first_name# </cfif><cfif structKeyExists(session, "last_name")>#session.last_name#</cfif></p>
				<p> professional Id: <cfif structKeyExists(session, "professional_id")>#session.professional_id#</cfif></p>
				<p> Company Id :<cfif structKeyExists(session, "company_id")> #session.company_id#</cfif>
				<div>
					--------------------------------------------
					<cfdump var="#Exception#"/>
				</div>
		</cfmail>
		<cfif structKeyExists(application,"bugLogService")>
				<cfset application.bugLogService.notifyService("Error report from salonworks",#Exception#,'extrainfo')>
				<!--- <cfdump var="#local.return#"> --->
		</cfif>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
</cfcomponent>