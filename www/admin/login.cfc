<cfcomponent displayname="Login" hint="">
	<cffunction name="Login" access="remote" output="false" returntype="boolean" hint="Returns query of Location based on Location_ID">
	    <cfargument name="Email_Address_log" type="string" required="true" />
	    <cfargument name="Password" type="string" required="true" />
		<cfquery name="qLoginPass" datasource="#request.dsn#">
			SELECT Password FROM Professionals
			WHERE Email_Address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Email_Address_log#">
		</cfquery>	
		<cfset local.errorStatus = 0>
		<cfif Hash(qLoginPass.Password) eq Hash(arguments.Password)>
			<cfset local.errorStatus = 1>
		</cfif>
		<cfif local.errorStatus>
			<cfquery name="qLogin" datasource="#request.dsn#">
				SELECT     
				Professionals.Professional_ID
				, Professionals.First_Name
				, Professionals.Last_Name
				, Companies.Company_ID AS Company_Admin
				, Locations.Location_ID
				, Companies_1.Company_ID AS Company_ID
				FROM         Locations INNER JOIN
				                      Professionals ON Locations.Location_ID = Professionals.Location_ID INNER JOIN
				                      Companies AS Companies_1 ON Locations.Company_ID = Companies_1.Company_ID LEFT OUTER JOIN
				                      Companies ON Professionals.Professional_ID = Companies.Professional_Admin_ID
				WHERE Professionals.Email_Address='#arguments.Email_Address_log#' 
				AND Professionals.Password='#arguments.Password#'
			</cfquery>
			<cfif qLogin.RecordCount GT 0>
				<cfset session.Professional_ID = qLogin.Professional_ID>
		        <cfset session.Professional_ID  =  qLogin.Professional_ID />
		        <cfset session.Location_ID = qLogin.Location_ID>
		        <cfset session.First_Name = qLogin.First_Name>
		        <cfset session.Last_Name = qLogin.Last_Name>
		        <cfset session.Company_ID = qLogin.Company_ID>
		        <cfset session.company_id = qLogin.Company_ID>
		        <cfset session.Company_Admin = qLogin.Company_Admin>
		       <!---  <cfinclude template="loadSessionForm.cfm" /> --->
	       
	       <cfreturn true>
	    </cfif>
	</cfif>
		<cfreturn false>
	</cffunction>
    
    
    <cffunction name="getCompany" access="public" output="false" returntype="query">
    	<cfargument name="company_id" type="numeric" required="true" />
        
    	<cfquery name="qryCompany" datasource="#request.dsn#">
        	SELECT * FROM Companies WHERE Company_ID = #arguments.company_id#
        </cfquery>
    
    	<cfreturn qryCompany />
    </cffunction>
    
    <cffunction name="getLocation" access="public" output="false" returntype="query">
    	<cfargument name="Location_ID" type="numeric" required="true" />
        
    	<cfquery name="qryLocation" datasource="#request.dsn#">
        	SELECT * FROM Locations WHERE Location_ID = #arguments.Location_ID#
        </cfquery>
    
    	<cfreturn qryLocation />
    </cffunction>
    
    
    <cffunction name="getProfessional" access="public" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        
    	<cfquery name="qryProfessional" datasource="#request.dsn#">
        	SELECT * FROM Professionals WHERE Professional_ID = #arguments.Professional_ID#
        </cfquery>
    
    	<cfreturn qryProfessional />
    </cffunction>
    
            
    
</cfcomponent>