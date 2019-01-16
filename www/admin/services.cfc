<cfcomponent displayname="Services" hint="">
	
	<cffunction name="getServices" access="remote" output="false" returntype="query" hint="Returns query of Services based on Professional_ID">
		<cfargument name="Company_ID" type="numeric" required="true"> 
		<cfargument name="Professional_ID" type="numeric" required="false"> 
		<cfargument name="Service_ID" type="numeric" required="false"> 
		<cfquery name="getServices" datasource="#request.dsn#">
			<!---SELECT 
			   Services.Service_ID 
			   ,Services.Service_Name
			   ,Services.Service_Description
			   <cfif structKeyExists(arguments, "Professional_ID")>
			   ,Cast(CONVERT(DECIMAL(10,2),Professionals_Services.Price) as nvarchar) as price
			   ,Professionals_Services.Service_Time
			   </cfif>
			   ,Services.Company_ID
			   ,Professionals_Services.Professional_ID
				FROM Services LEFT OUTER JOIN
                      Professionals_Services ON Services.Service_ID = Professionals_Services.Service_ID
		  WHERE 
		  	Services.Company_ID=#arguments.Company_ID#
		  <cfif isDefined('arguments.Professional_ID')>
		  	AND 
				(
					Professionals_Services.Professional_ID=#arguments.Professional_ID#
					<!--- OR
					Professionals_Services.Professional_ID is null --->
				)
		  </cfif>
		  <cfif isDefined('arguments.Service_ID')>
		  	AND Services.Service_ID=#arguments.Service_ID#
		  </cfif>--->
		  	Select Predefined_Services.Service_ID,Predefined_Services.Service_Type_ID,Predefined_Services.Service_Name,Cast(CONVERT(DECIMAL(10,2),Professionals_Services.Price) as nvarchar) as price ,Professionals_Services.Service_Time 
			from Professionals_Services 
			left join Predefined_Services on Professionals_Services.Service_ID = Predefined_Services.Service_ID 
			where Professional_ID='#arguments.professional_id#'
		</cfquery>
		<cfreturn getServices>
	</cffunction>

	<cffunction name="InsertService" access="remote"  returntype="numeric" hint="" returnformat="plain">
		<cfargument name="Professional_ID" type="string" required="true"> 
		<cfargument name="Company_ID" type="string" required="true">
		<cfargument name="Service_Name" type="string" required="true">
		<cfargument name="Service_Time" type="numeric" required="true" >
	<!--- <cftransaction isolation="READ_COMMITTED"> --->
			<cfquery name="qInsertService" datasource="#request.dsn#" result="result">
				INSERT INTO Services (Service_Name,Service_Time) 
				VALUES (
				 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Service_Name#">,
				 	<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Service_Time#">)
			</cfquery>
			
			<!--- <cfquery name="getService" datasource="#request.dsn#">
				SELECT Max(Service_ID) as New_Service_ID FROM Services  
			</cfquery>
			 --->
			<cfinvoke method="UpdateService" returnvariable="variables.Service_ID">
				<cfinvokeargument name="Service_Name" value="#arguments.Service_Name#">
				<cfinvokeargument name="Service_Description" value="#arguments.Service_Description#">
				<cfinvokeargument name="Price" value="#arguments.Price#">
				<cfinvokeargument name="Service_Time" value="#arguments.Service_Time#">
				<cfinvokeargument name="Service_ID" value="#result.generatedKey#">
				<cfinvokeargument name="Professional_ID" value="#arguments.Professional_ID#">
				<cfinvokeargument name="Company_ID" value="#arguments.Company_ID#">
			</cfinvoke>
			
			<!--- </cftransaction> --->
		<cfreturn result.generatedKey>
	</cffunction> 
	
	<cffunction name="UpdateService" access="remote" returntype="numeric">
		<!--- Make a cfargument for each column name --->
		<cfargument name="Service_ID" type="numeric" required="true">
		<cfargument name="Professional_ID" type="numeric" required="false"> 
		<cfargument name="Company_ID" type="numeric" required="true"> 
		<cfargument name="Service_Name" type="string" required="true"> 
		<cfargument name="Service_Time" type="numeric" required="true"> 
		<cfargument name="Service_Description" type="string" required="true"> 
		<cfargument name="Price" type="numeric" required="true"> 

		<cfquery datasource="#request.dsn#" name="UpdateServiceQuery" result="UpdateServiceQueryresult">
			UPDATE Services
				SET 
			   		Service_Name='#arguments.Service_Name#' 
			   		,Service_Description='#arguments.Service_Description#' 
			   		<cfif NOT structKeyExists(arguments, "Professional_ID")>
			   		,Price=#arguments.Price#
			   		,Service_Time='#arguments.Service_Time#'
			   		</cfif>
					,Company_ID=#arguments.Company_ID#
		  	WHERE Service_ID=#arguments.Service_ID#
		 </cfquery>
		<cfif structKeyExists(arguments, "Professional_ID")>
		 	<cfset this.AssignService( argumentCollection = arguments )>
		 </cfif>

		 <cfif UpdateServiceQueryresult.RECORDCOUNT>
		 	 <cfreturn arguments.Service_ID>	
		 </cfif>	
		
	</cffunction>
	
	<cffunction name="DeleteService" access="remote" output="false">
		<cfargument name="Professional_ID" type="numeric" required="true">
		<cfargument name="Service_ID" type="numeric" required="true">
		
		<cfquery datasource="#request.dsn#">
			DELETE FROM Professionals_Services 
			WHERE Professional_ID=#arguments.Professional_ID#
			AND	Service_ID=#arguments.Service_ID#
		</cfquery>
		<cfquery datasource="#request.dsn#">
			DELETE FROM Services 
			WHERE Service_ID=#arguments.Service_ID#
		</cfquery>
	</cffunction>
	
	<cffunction name="DeleteAssignment" access="public" output="false">
		<cfargument name="Professional_ID" type="numeric" required="true">
		<cfquery name="DeleteAssignment" datasource="#request.dsn#">
			DELETE FROM Professionals_Services 
			WHERE Professional_ID=#arguments.Professional_ID#
		</cfquery>
	</cffunction>
	
	<cffunction name="AssignService" access="public" output="false">
		<cfargument name="Professional_ID" type="numeric" required="true">
		<cfargument name="Service_ID" type="numeric" required="true">
		<cfargument name="service_time" type="numeric" required="true">
		<cfargument name="price" type="numeric" required="true">
		
		<cfquery name="checkIfServiceIsAssigned" datasource="#request.dsn#">
			SELECT * FROM Professionals_Services 
			WHERE Professional_ID=#arguments.Professional_ID#
			AND	Service_ID=#arguments.Service_ID#
		</cfquery>
		
		<cfif not checkIfServiceIsAssigned.recordcount>
			<cfquery datasource="#request.dsn#">
				INSERT INTO Professionals_Services
					(Professional_ID, Service_ID, service_time, price)
				VALUES
					(#arguments.Professional_ID#, #arguments.Service_ID#, #arguments.service_time#, #arguments.price#)
			</cfquery>
		<cfelse>

			<cfquery datasource="#request.dsn#">
				UPDATE 	Professionals_Services
				SET	
						service_time = #arguments.service_time#,
						price = #arguments.price#
				WHERE 	
						Professional_ID = #arguments.Professional_ID#
				AND 	Service_ID = #arguments.Service_ID#
			</cfquery>
		</cfif>
		
		<cfabort>

		
	</cffunction>
</cfcomponent>