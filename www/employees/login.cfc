<cfcomponent displayname="Login" hint="">
	<cffunction name="Login" access="remote" output="false" returntype="boolean" hint="Returns query of Location based on Location_ID">
	    <cfargument name="Email_address" type="string" required="true" />
	    <cfargument name="Password" type="string" required="true" />
	
		<cfquery name="qLogin" datasource="#request.dsn#">
			SELECT     
				Employees.Employee_ID, Employees.First_Name, Employees.Last_Name
			FROM 
				Employees
			WHERE 
				Employees.Email = <cfqueryparam value="#arguments.Email_address#" cfsqltype="cf_sql_varchar"> 
			AND 
				Employees.Password = <cfqueryparam value="#arguments.Password#" cfsqltype="cf_sql_varchar"> 
		</cfquery>
		
		<cfif qLogin.RecordCount>
			<cfset session.Employee_ID 	= qLogin.Employee_ID>
	        <cfset session.First_Name 	= qLogin.First_Name>
	        <cfset session.Last_Name 	= qLogin.Last_Name>
			<cfreturn true>
	    </cfif>
		<cfreturn false>
	</cffunction>
	
	<cffunction name="getEmployee" access="public" output="false" returntype="query">
    	<cfargument name="Employee_ID" type="numeric" required="true" />
        
    	<cfquery name="qryProfessional" datasource="#request.dsn#">
        	SELECT * FROM Employees WHERE Employee_ID = #arguments.Employee_ID#
        </cfquery>
    
    	<cfreturn qryProfessional />
    </cffunction>
	
</cfcomponent>