<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">
 
 
	<!--- Set up the application. --->
	<cfset THIS.Name = "Salonworks" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 ) />
	<cfset THIS.sessiontimeout = CreateTimeSpan(0,0,45,0) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SetClientCookies = true />

 	<!--- <cfset this.datasources["salonworknew"] = {
	  class: 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
	, bundleName: 'com.microsoft.sqlserver.mssql-jdbc'
	, bundleVersion: '6.2.2.jre8'
	, connectionString: 'jdbc:sqlserver://localhost:1433;DATABASENAME=salonworks_dev;sendStringParametersAsUnicode=true;SelectMethod=direct'
	, username: 'spericorn'
	, password: "encrypted:0163c6a53a3d5a69c9d36fcae54be576b99da8ed62a3a5b6e91ee8b582f1ea7a"
	
	// optional settings
	, connectionLimit:100 // default:-1
}> --->
 
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
		<cfset session.company_id=0>
		<cfset session.professional_id=0>
 		<cfparam name="session.company_id" default="3">
 		<cfparam name="session.professional_id" default="3">
 		<cfparam name="request.dsn" default="salonworks">
 
 
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
 
	<cffunction
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
 
		<!--- Include the requested page. --->
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
	</cffunction>
 
 <!--- 
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
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
  --->
</cfcomponent>