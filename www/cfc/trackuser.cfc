<cfcomponent output="false">

	<cffunction name="registrationTracking" access="remote" output="false" returntype="string">
    	<cfargument name="guid" type="string" required="true" />
        <cfargument name="field" type="string" required="true" />

		<cfif len(arguments.guid)>
			<cfset local.cfguid = arguments.guid>
		<cfelse>
			<cfset var uuidUtil = createobject('java', 'java.util.UUID') />
			<cfset local.cfguid = uuidUtil.randomUUID().toString() />
		</cfif>

		<cfquery name="checkregTrackRecord" datasource="#request.dsn#">
        SELECT 	*
		FROM	regTracking
        WHERE	field = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.field#">
		AND		id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#local.cfguid#">
		</cfquery>

		<cfif NOT checkregTrackRecord.recordcount>
			<cfquery datasource="#request.dsn#">
	        INSERT INTO regTracking (
	        	id, field, value, inputdate
	        )
	        VALUES (
	        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#local.cfguid#">,
	        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.field#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.value#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">
	        )
			</cfquery>
		</cfif>

        <cfreturn  local.cfguid />
    </cffunction>

	<cffunction name="deleteRegTracking" access="remote" returntype="boolean">
		<cfargument name="guid" type="string" required="true" />

		<cfif not len(arguments.guid)>
			<cfreturn false />
		</cfif>

		<cfquery datasource="#request.dsn#">
        DELETE
		FROM	regTracking
        WHERE	id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.guid#">
		</cfquery>

		<cfreturn true />
	</cffunction>

</cfcomponent>
