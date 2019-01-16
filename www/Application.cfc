<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">

	<!--- Set up the application. --->
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SetClientCookies = true />

	<cfif FindNoCase('salonworks.com',cgi.HTTP_HOST)>
		<cfset THIS.project_stage = "production" />
	<cfelseif FindNoCase('salonworks_staging.com',cgi.HTTP_HOST)>
		<cfset THIS.project_stage = "staging" />	
	<cfelse>
		<cfset THIS.project_stage = "development" />
	</cfif>
	<!--- <cfset this.datasources["salonworks"] = {
	  class: 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
	, bundleName: 'com.microsoft.sqlserver.mssql-jdbc'
	, bundleVersion: '6.2.2.jre8'
	, connectionString: 'jdbc:sqlserver://salonworks.database.windows.net:1433;DATABASENAME=salonworks;sendStringParametersAsUnicode=true;SelectMethod=direct;'
	, username: 'coldfusion@salonworks'
	, password: "encrypted:e11e0a35e55736a047be92fb86dd769f72c3a07902b8bc9592354041ed7d8acb"
	
	// optional settings
	, connectionLimit:100 // default:-1
}>
 --->
 	<cfset this.datasources["salonworknew"] = {
	  class: 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
	, bundleName: 'com.microsoft.sqlserver.mssql-jdbc'
	, bundleVersion: '6.2.2.jre8'
	, connectionString: 'jdbc:sqlserver://localhost:1433;DATABASENAME=salonworks_dev;sendStringParametersAsUnicode=true;SelectMethod=direct'
	, username: 'spericorn'
	, password: "encrypted:0163c6a53a3d5a69c9d36fcae54be576b99da8ed62a3a5b6e91ee8b582f1ea7a"
	
	// optional settings
	, connectionLimit:100 // default:-1
}>

	
	<!--- CF application definition --->
	<cfinclude template="environment/#this.project_stage#/app.cfm">
	<!--- Define the page request properties. --->
	<cfsetting requesttimeout="20" showdebugoutput="true" enablecfoutputonly="false" />

	<cffunction name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">

		<cfmodule template="environment/#this.project_stage#/config.cfm">
		<cfmodule template="environment/config.cfm">

		<cfset globalvars = attributes.globalvars />

		<!--- append to application scope --->
		<cflock scope="application" type="exclusive" timeout="3" throwontimeout="yes">
			<cfset StructAppend(application, globalvars, true)>
		</cflock>

		<!--- Return out. --->
		<cfreturn true />
	</cffunction>


	<cffunction name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnRequestStart"
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


		<cfif isDefined("url.resetApp")>
			<cfset OnApplicationStart() />
		</cfif>

 		<!--- <cfparam name="session.company_id" default="0">
 		<cfparam name="session.professional_id" default="0"> --->
 		<cfparam name="request.dsn" default="salonworknew">
		<cfset variables.subdomain = ListgetAt(cgi.server_name,1,'.')>
		<!--- added on 08/01/2019 --->
		<cfif !ListFindNoCase("www,salonworks",variables.subdomain)>
		  <cfset variables.subdomain=variables.subdomain>
		<cfelse>
		  <cfset variables.subdomain="">
		</cfif>
		<cfset application.bugLogService=createObject("component","buglog.client.bugLogService").init(bugLogListener="http://www.salonworks.com/buglog/listeners/bugLogListenerREST.cfm",bugEmailRecipients="jacinth@spericorn.com",bugEmailSender="jacinth@spericorn.com")>
 		<cfset application.devpath="../../">
 		<cfset application.filePath="/dev/templates/0001/">
 		<cfset application.projectpath = "/dev/">
 		<!--- <cfset application.template_id = 3> --->
		<!--- <cfif session.Company_ID gt 0>
			<cfset variables.Company_ID = session.Company_ID>
		</cfif> --->
		<!--- <cfquery name="testdata" datasource="salonworks"  password ="Powder.52" username="coldfusion@salonworks" >
			select *
			from companies
		</cfquery>
		<cfdump var="#testdata#">
		<cfabort> --->
		<cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
			<cfinvokeargument name="Web_Address" value="#variables.subdomain#">
		</cfinvoke>
		
		<!--- <cfif session.Company_ID eq 0> --->
			<cfif qCompany.recordcount gt 0 AND !ListFindNoCase("www,salonworks",variables.subdomain)>
				<cfset variables.Company_ID=qCompany.Company_ID>
				<cfset variables.Template_ID=qCompany.Template_ID>
			<cfelse>
				<cfset variables.Company_ID=0>
				<cfset variables.Template_ID=0>
			</cfif>
		<!--- </cfif> --->
		<cfinvoke component="admin.location" method="getLocation" returnvariable="qLocation">
			<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
		</cfinvoke>

		<cfif qLocation.recordcount gt 0>
			<cfset variables.Location_ID=qLocation.Location_ID>
		<cfelse>
			<cfset variables.Location_ID=0>
		</cfif>

		<cfinvoke component="admin.professionals" method="getProfessional" returnvariable="qProfessional">
			<cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
			<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
		</cfinvoke>
		<!--- Site Log  --->
		<cfif THIS.project_stage eq "production">
			<!--- <cfquery name="sitelog" datasource="salonworks">
				INSERT INTO Site_Log
				(Company_ID
				,Page
				,URL_Parameters
				,Referrer
				,IP_Address)
				Values
				(<cfqueryparam value="#variables.Company_ID#" cfsqltype="CF_SQL_INTEGER">
				,<cfqueryparam value="#cgi.PATH_INFO#" cfsqltype="CF_SQL_VARCHAR">
				,<cfqueryparam value="#cgi.QUERY_STRING#" cfsqltype="CF_SQL_VARCHAR">
				,<cfqueryparam value="#cgi.HTTP_REFERER#" cfsqltype="CF_SQL_VARCHAR">
				,<cfqueryparam value="#cgi.REMOTE_ADDR#" cfsqltype="CF_SQL_VARCHAR">
				)
			</cfquery> --->
		</cfif>
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>

	<!--- <cffunction name="OnRequestStart"
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
 		<!--- <cfparam name="session.company_id" default="0">
 		<cfparam name="session.professional_id" default="0"> --->
 		<cfparam name="request.dsn" default="salonworks">
		<cfset this.subdomain = ListgetAt(cgi.server_name,1,'.')>

		<!--- <cfif session.Company_ID gt 0>
			<cfset variables.Company_ID = session.Company_ID>
		</cfif> --->
		<cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
			<cfinvokeargument name="Web_Address" value="#this.subdomain#">
		</cfinvoke>
		<!--- <cfif session.Company_ID eq 0> --->
			<cfif qCompany.recordcount gt 0 AND !ListFindNoCase("www,salonworks",this.subdomain)>
				<cfset this.Company_ID=qCompany.Company_ID>
				<cfset this.Template_ID=qCompany.Template_ID>
			<cfelse>
				<cfset this.Company_ID=0>
				<cfset this.Template_ID=0>
			</cfif>
		<!--- </cfif> --->
		<cfinvoke component="admin.location" method="getLocation" returnvariable="qLocation">
			<cfinvokeargument name="Company_ID" value="#this.Company_ID#">
		</cfinvoke>

		<cfif qLocation.recordcount gt 0>
			<cfset this.Location_ID=qLocation.Location_ID>
		<cfelse>
			<cfset this.Location_ID=0>
		</cfif>

		<cfinvoke component="admin.professionals" method="getProfessional" returnvariable="qProfessional">
			<cfinvokeargument name="Location_ID" value="#this.Location_ID#">
			<cfinvokeargument name="Company_ID" value="#this.Company_ID#">
		</cfinvoke>
		<cfdump var="#this#"><cfabort>


		<!--- Return out. --->
		<cfreturn true />
	</cffunction> --->


	<cffunction name="OnRequest"
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
			<!--- <cfdump var="#url#">
			<cfdump var="#arguments#"> --->
			<!--- Block public users from dev site --->
		<!--- <cfif not ListContains('127.0.0.1,99.103.70.43,107.194.73.65,75.103.109.211,173.172.44.148,89.205.33.15,220.227.196.145,13.58.245.95',cgi.REMOTE_ADDR) AND THIS.project_stage neq "production"> <cfabort></cfif> --->
		<!--- <table width="100%" bgcolor="red"><tr><td align="center"><span style="color:white;">Dev Site</span></td></tr></table> --->

		<cfif isDefined('url.u')>
		<!--- So that people can't predict userIDs i'm putting the userid between 3 digits to the left and 2 digits to the right --->
			<cfset session.u=url.u>
			<cfset session.u=Left(session.u,8)>
			<cfset session.u=Right(session.u,5)>
		</cfif>
		<cfif isDefined('session.u')>
			<cfquery name="getCosmotrainingUser" datasource="preferredce">
				SELECT
					FirstName
					,LastName
					,Address
					,Address2
					,City
					,State
					,PostalCode
					,Email
					,Telephone
				FROM
					Students
				WHERE
					StudentID=<cfqueryparam value="#session.u#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
		</cfif>

		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete.">
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnSessionEnd"
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


	<cffunction name="OnApplicationEnd"
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

 	
	<cffunction name="OnError"
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
			<cfdump var="#arguments#">
			<cfmail server="smtp.gmail.com" port="465" from="jacinth@spericorn.com" to="jacinth@spericorn.com" subject="error on site" type="HTML" username="aswathi.k@spericorn.com" password="aashnairknr"  useSSL ="yes" useTLS ="yes">
				<h3>Error occurred in SalonWorks.com Front end-live site staging qa #now()#</h3>
				<div>
					--------------------------------------------
					<cfdump var="#Exception#"/>
				</div>
			</cfmail>
				<cfif structKeyExists(application,"bugLogService")>

					<cfset application.bugLogService.notifyService("Error report from salonworks",#Exception#,'extrainfo')>
				</cfif>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>
	
</cfcomponent>