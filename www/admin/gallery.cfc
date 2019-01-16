<cfcomponent displayname="Gallery" hint="">
	
	<cffunction name="getGallery" access="public" output="false" returntype="query" hint="Returns query of Gallery based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="false"> 
		<cfargument name="Professional_ID" type="numeric" required="false">
		
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT * 
			FROM Gallery
			WHERE 1=1
			<cfif isDefined('arguments.Professional_ID')>
		  	AND Professional_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Professional_ID#">
			</cfif>
			<cfif isDefined('arguments.Company_ID')>
		  	AND Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Company_ID#">
			</cfif>
			order by Gallery_ID desc
		</cfquery>
		
		<cfreturn getGallery>
	</cffunction>
	
	
	<cffunction name="editGallery" access="remote" output="false" returntype="string" returnformat="JSON">
		<cfargument name="gallery_id" type="numeric" required="false">
		
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT * 
			FROM Gallery
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#" >
		</cfquery>
		
		<cfreturn SerializeJSON(getGallery) >
	</cffunction>
	

	<cffunction name="DeleteGallery" access="remote" output="false">
		<cfargument name="gallery_id" type="numeric" required="false">
		
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT Image_Name,Thumb_Name
			FROM Gallery 
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#" >
		</cfquery>
		<cfoutput>
			<cfset variables.destination = ExpandPath("\")&"admin\images\company\gallery\#session.company_id#\" >
			<cfset variables.deletePathOne = variables.destination&#getGallery.Image_Name# >
			<cfset variables.deletePathTwo = variables.destination&#getGallery.Thumb_Name# >
			
			<!---<cffile action = "delete"  file = "#variables.deletePathOne#">
			<cffile action = "delete" file = "#variables.deletePathTwo#">--->
		</cfoutput>
		<cfquery name="deleteImage" datasource="#request.dsn#">
			DELETE FROM Gallery
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#" >
		</cfquery>
	</cffunction>
	
	<cffunction name="deleteImage" access="remote" output="false">
		<cfargument name="gallery_id" type="numeric" required="false">
		
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT Image_Name,Thumb_Name,company_id
			FROM Gallery 
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#" >
		</cfquery>
		
		<cfoutput>
			<cfset variables.destination = ExpandPath("\")&"admin\images\company\gallery\#getGallery.company_id#\" >
			<!--- <cfset DirectoryDelete(variables.destination,'true')>  --->
			
			<cfset variables.deletePathOne = variables.destination&#getGallery.Image_Name# >
			<cfset variables.deletePathTwo = variables.destination&#getGallery.Thumb_Name# >
			
			<cftry>
				<cffile action = "delete"  file = "#variables.deletePathOne#">			
				<cffile action = "delete" file = "#variables.deletePathTwo#">
			<cfcatch type="any"><cfabort></cfcatch>
			</cftry>
		</cfoutput>
		
		<cfquery name="getGallery" datasource="#request.dsn#">
			UPDATE Gallery
			SET Image_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="" >,
				Thumb_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="" >
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gallery_id#" >
		</cfquery>
		
	</cffunction>
	
</cfcomponent>