<cfcomponent displayname="Themese" hint="">

	<cffunction name="getFonts" access="public" output="true" hint="Returns query of Fonts">
		<cfquery name="getFonts" datasource="#request.dsn#">
			SELECT Font_ID
			,Font 
			FROM Fonts order by Font
		</cfquery>
		<cfreturn getFonts>
	</cffunction>
	
	<cffunction name="getDefault_Themes" access="public" output="true" hint="Returns query of Themes">
		<cfargument name="Default_Theme_ID" type="numeric" required="false" default="0"> 
		<cfquery name="getDefault_Themes" datasource="#request.dsn#">
			SELECT Default_Theme_ID
				,Theme_Name
		      ,Background_Image
		      ,Background_Color
		      ,Text_Color
		      ,Link_Color
		      ,Link_Visited
		      ,Text_Font_ID
		      ,Menu_Font_ID
		      ,Menu_Color
		      ,Header_Font_ID
		      ,Header_Color
		  	FROM Default_Themes 
			WHERE 1=1
			<cfif arguments.Default_Theme_ID gt 0>
				AND Default_Theme_ID=#arguments.Default_Theme_ID#
			</cfif>
		</cfquery>
		<cfreturn getDefault_Themes>
	</cffunction>
	
	<cffunction name="getCompany_Themes" access="public" output="true" hint="Returns query of Themes">
		<cfargument name="Company_ID" type="numeric" required="false" default="0"> 
		<cfquery name="getCompany_Themes" datasource="#request.dsn#">
			SELECT Company_Theme_ID
		      ,Company_ID
		      ,Theme_ID
		      ,Background_Image
		      ,Background_Color
		      ,Text_Color
		      ,Link_Color
		      ,Link_Visited
		      ,Text_Font_ID
		      ,Menu_Font_ID
		      ,Menu_Color
		      ,Header_Font_ID
		      ,Header_Color
		  	FROM Company_Themes 
			WHERE 1=1
			<cfif arguments.Company_ID gt 0>
				AND Company_ID=#arguments.Company_ID#
			</cfif>
		</cfquery>
		<cfreturn getCompany_Themes>
	</cffunction>
	
	<cffunction name="assignTheme" access="public" output="true" hint="Returns query of Themes">
		<cfargument name="Company_ID" type="numeric" required="true"> 
		<cfargument name="Default_Theme_ID" type="numeric" required="true"> 
		<cfset qDefault=getDefault_Themes(#Default_Theme_ID#)>
		<cfquery name="assignTheme" datasource="#request.dsn#">
			INSERT INTO Company_Themes 
			(Company_ID
		      ,Theme_ID
		      ,Background_Image
		      ,Background_Color
		      ,Text_Color
		      ,Link_Color
		      ,Link_Visited
		      ,Text_Font_ID
		      ,Menu_Font_ID
		      ,Menu_Color
		      ,Header_Font_ID
		      ,Header_Color)
			  VALUES
			  (
			  #arguments.Company_ID#
			  ,#qDefault.Default_Theme_ID#
		      ,'#qDefault.Background_Image#'
		      ,'#qDefault.Background_Color#'
		      ,'#qDefault.Text_Color#'
		      ,'#qDefault.Link_Color#'
		      ,'#qDefault.Link_Visited#'
		      ,#qDefault.Text_Font_ID#
		      ,#qDefault.Menu_Font_ID#
		      ,'#qDefault.Menu_Color#'
		      ,#qDefault.Header_Font_ID#
		      ,'#qDefault.Header_Color#'
			  )
		</cfquery>
	</cffunction>
	<cffunction name="UpdateTheme" access="public" output="true" hint="">
		<cfargument name="Company_ID" required="true" type="numeric">
		<cfquery name="updateTheme" datasource="#request.dsn#">
			UPDATE  Company_Themes
	  		 SET 
		      Background_Image = '#Background_Image#'
		      ,Background_Color = '#Background_Color#'
		      ,Text_Color = '#Text_Color#'
		      ,Link_Color = '#Link_Color#'
		      ,Link_Visited = '#Link_Visited#'
		      ,Text_Font_ID = #Text_Font_ID#
		      ,Menu_Font_ID = #Menu_Font_ID#
		      ,Menu_Color = '#Menu_Color#'
		      ,Header_Font_ID = #Header_Font_ID#
		      ,Header_Color = '#Header_Color#'
			WHERE Company_ID=#arguments.Company_ID#		
		</cfquery>
	</cffunction>
	
</cfcomponent>