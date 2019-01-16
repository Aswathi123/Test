<cfcomponent output="false">

	<cfset variables.instance = StructNew()/>

	<cfset variables.instance.dbname = "eventcalendar"/>
	<cfset variables.instance.dbuser = ""/>
	<cfset variables.instance.dbpass = ""/>
	<cfset variables.instance.sessionmanagement = "true"/>
	
	<cfset variables.instance.userfacade = createObject("component","UserFacade").init()/>
	
	<!---the jQuery calendar never really calls the constructor, so keep that in mind. It's here just in case someone wants it--->
	<cffunction name="init" output="false" access="public" returntype="EventCalendar">
		<cfargument name="dbname" required="false" type="String"/>
		<cfargument name="dbuser" required="false" type="String"/>
		<cfargument name="dbpass" required="false" type="String"/>
		<cfargument name="sessionmanagement" required="false" type="String"/>
		<cfif isdefined("arguments.dbname")><cfset variables.instance.dbname = arguments.dbname/></cfif>
		<cfif isdefined("arguments.dbuser")><cfset variables.instance.dbuser = arguments.dbuser/></cfif>
		<cfif isdefined("arguments.dbpass")><cfset variables.instance.dbpass = arguments.dbpass/></cfif>
		<cfif isdefined("arguments.sessionmanagement")><cfset variables.instance.sessionmanagement = arguments.sessionmanagement/></cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getEvents" output="false" access="remote" returntype="Any">
		<cfargument name="start" required="false" type="Date"/>
		<cfargument name="end" required="false" type="Date"/>
		<cfset var local = StructNew()/>
		<cfset local.myQuery = QueryNew("id,title,body,starttime,endtime,readonly","varchar, varchar, varchar, varchar, varchar, bit")/>
		<cftry>
		<cfquery name="local.find" datasource="#variables.instance.dbname#" username="#variables.instance.dbuser#" password="#variables.instance.dbpass#">
			select id,title,body,starttime,endtime,userid from events
			<cfif isdefined("arguments.start") and isdefined("arguments.end")>
				where starttime between <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.start#"> and <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.end#">
			</cfif>
			order by starttime
		</cfquery>
		<cfset local.ii = 1/>
		<cfloop query="local.find">
			<cfset QueryAddRow(local.myQuery, 1)/>
			<cfset QuerySetCell(local.myQuery, "id", id, local.ii)/>
			<cfset QuerySetCell(local.myQuery, "title", title, local.ii)/>
			<cfset QuerySetCell(local.myQuery, "body", body, local.ii)/>
			<cfset QuerySetCell(local.myQuery, "starttime", formatTime(starttime), local.ii)/>
			<cfset QuerySetCell(local.myQuery, "endtime", formatTime(endtime), local.ii)/>
			<cfif variables.instance.sessionmanagement eq true and variables.instance.userfacade.isCalendarAdmin() eq false>
				<cfif userid neq variables.instance.userfacade.getUserid()>
					<cfset QuerySetCell(local.myQuery, "readonly", true, local.ii)/>
				<cfelse>
					<cfset QuerySetCell(local.myQuery, "readonly", false, local.ii)/>
				</cfif>
			<cfelse>
				<cfset QuerySetCell(local.myQuery, "readonly", false, local.ii)/>
			</cfif>
			<cfset local.ii = local.ii + 1/>
		</cfloop>
		<cfcatch></cfcatch></cftry>
		<cfreturn local.myQuery/>
	</cffunction>

	<cffunction name="removeEvent" output="false" access="remote" returntype="Any">
		<cfargument name="id" required="true" type="string"/>
		<cfset var local = Structnew()/>
		<cftry>		
		<cfset local.id = arguments.id/>		
		<cfquery name="local.delete" datasource="#variables.instance.dbname#" username="#variables.instance.dbuser#" password="#variables.instance.dbpass#">
			delete from events
			where id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#id#"/>
				<cfif variables.instance.sessionmanagement eq true and variables.instance.userfacade.isCalendarAdmin() eq false>
					and userid = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#variables.instance.userfacade.getUserid()#"/>
				</cfif>
		</cfquery>
		<cfcatch></cfcatch></cftry>
		<cfreturn local/>
	</cffunction>

	<cffunction name="modifyEvent" output="false" access="remote" returntype="Any">
		<cfargument name="id" required="true" type="string"/>
		<cfargument name="title" required="true" type="string"/>
		<cfargument name="body" required="true" type="string"/>
		<cfargument name="starttime" required="true" type="date"/>
		<cfargument name="endtime" required="true" type="date"/>
		<cfset var result = Structnew()/>

		<cftry>		
			<!---Setup or modify data for insertion and call back--->
			<cfset result.id = arguments.id/>
			<cfset result.title = arguments.title/>
			<cfset result.body = arguments.body/>
			<cfset result.starttime = formatTime(arguments.starttime)/>
			<cfset result.endtime = formatTime(arguments.endtime)/>

			<cfquery name="update" datasource="#variables.instance.dbname#" username="#variables.instance.dbuser#" password="#variables.instance.dbpass#">
				update events set 
					title = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#result.title#"/>
					,body = <cfqueryparam cfsqltype="cf_sql_varchar" value="#result.body#"/>
					,starttime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#result.starttime#"/>
					,endtime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#result.endtime#"/>
				where id = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#result.id#"/>
					<cfif variables.instance.sessionmanagement eq true and variables.instance.userfacade.isCalendarAdmin() eq false>
						and userid = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#variables.instance.userfacade.getUserid()#"/>
					</cfif>
			</cfquery>
		<cfcatch></cfcatch></cftry>
		<cfreturn result/>
	</cffunction>

	<cffunction name="addEvent" output="false" access="remote" returntype="Any">
		<cfargument name="title" required="true" type="string"/>
		<cfargument name="body" required="true" type="string"/>
		<cfargument name="starttime" required="true" type="date"/>
		<cfargument name="endtime" required="true" type="date"/>
		<cfset var result = Structnew()/>

		<cftry>		
			<!---Setup or modify data for insertion and call back--->
			<cfset result.id = createUUID()/>
			<cfset result.title = arguments.title/>
			<cfset result.body = arguments.body/>
			<cfset result.starttime = formatTime(arguments.starttime)/>
			<cfset result.endtime = formatTime(arguments.endtime)/>
			
			<cfquery name="insert" datasource="#variables.instance.dbname#" username="#variables.instance.dbuser#" password="#variables.instance.dbpass#">
				insert into events(id,title,body,starttime,endtime<cfif variables.instance.sessionmanagement eq true>,userid</cfif>)
				values(
					<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#result.id#"/>
					,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#result.title#"/>
					,<cfqueryparam cfsqltype="cf_sql_varchar" value="#result.body#"/>
					,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#result.starttime#"/>
					,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#result.endtime#"/>
					<cfif variables.instance.sessionmanagement eq true>,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="200" value="#variables.instance.userfacade.getUserid()#"/></cfif>
			)
			</cfquery>
		<cfcatch></cfcatch></cftry>

		<cfreturn result/>
	</cffunction>

	<cffunction name="formatTime" output="false" access="private" returntype="Any">
		<cfargument name="ts" required="true" type="Any"/>
		<!---Just formatting time stamps to make things easier on the jQuery side of this, ie. "Month dd, yyyy hh:mm:ss"--->
		<cfset var result = monthasstring(month(arguments.ts))/>
		<cfset result = result & " " & leadingZero(day(arguments.ts))/>
		<cfset result = result & ", " & year(arguments.ts)/>
		<cfset result = result & " " & timeformat(arguments.ts,"HH:mm")/>
		<cfreturn result/>
	</cffunction>

	<cffunction name="leadingZero" output="false" access="private" returntype="Any">
		<cfargument name="value" required="true" type="string"/>
		<cfif len(arguments.value) eq 1><cfset arguments.value = "0" & arguments.value/></cfif>	
		<cfreturn arguments.value/>
	</cffunction>
	
</cfcomponent>