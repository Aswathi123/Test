<cfcomponent output="false">
	<!--- Just a very simple User session facade you can link into your own system or extend from as needed--->
	<!--- We use the user id to determine the access/modify permissions for event entries--->
	<!--- Strongly encourage you to do some type of login procedure with this app--->	
	
	<cfset variables.instance = StructNew()/>
	
	<cffunction name="init" output="false" access="public" returntype="UserFacade">
		<cfreturn this/>
	</cffunction>

	<cffunction name="isCalendarAdmin" access="public" returntype="any" output="false">
		<cfset var local = StructNew()/>
		<cfset local.result = false/>
		<cfset local.userid = getUserid()/>
		<!---
			Inject your own logic here, this is called to see if the current user 
			is a calendar admin and can remove/modify other people's events
		--->
		<cfreturn local.result/>		
	</cffunction> 

	<cffunction name="setUserid" access="public" returntype="void" output="false">
		<cfargument name="userid" required="true" />
		<cfset session.userid = arguments.userid />		
	</cffunction> 

	<cffunction name="getUserid" access="public" returntype="any" output="false">
		<cfif structkeyexists(session,"userid") eq false>
			<cfset setUserid(createUUID())/>
		</cfif>
		<cfreturn session.userid/>		
	</cffunction> 
	
</cfcomponent>