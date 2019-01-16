<cfcomponent displayname="Blog" hint="">
	
	<cffunction name="getBlogPost" access="public" output="false" returntype="query" hint="Returns query of Blogs based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="false"> 		
		
		<cfquery name="qGetBlogPost" datasource="#request.dsn#">
			SELECT * 
			FROM Blog_Post
			WHERE 1=1			
			<cfif isDefined('arguments.Company_ID')>
		  	AND Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Company_ID#">
			</cfif>
			order by blog_id desc
		</cfquery> 
		
		<cfreturn qGetBlogPost>
	</cffunction>
	
	<cffunction name="getBlogPostEdit" access="remote" output="false" returntype="any">
		<cfargument name="blog_id" type="numeric" required="false"> 
		<cfquery name="qGetBlogPostEdit" datasource="#request.dsn#">
			SELECT title,description
			FROM Blog_Post
			WHERE
			<cfif isDefined('arguments.blog_id')>
				blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.blog_id#">
			</cfif>
		</cfquery>
		<cfreturn SerializeJSON(qGetBlogPostEdit)>
	</cffunction>
	
	<cffunction name="InsertBlogPost" access="remote" output="false">
		<cfargument name="company_id" type="numeric" required="true">
		<cfargument name="professional_id" type="numeric" required="true">
		<cfargument name="blogTitle" type="string" required="true">
		<cfargument name="blog_description" type="string" required="true">
		
		<cfquery datasource="#request.dsn#">
			INSERT INTO
				Blog_Post (Company_ID,Professional_ID,Title,Description,Created_Date,Created_By)			
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.company_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.professional_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blogTitle#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blog_description#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.professional_id#">
				)
		</cfquery>
	</cffunction>
	
	<cffunction name="updateBlogPost" access="remote" output="yes">
		<cfargument name="blog_id" type="numeric" required="true"> 
		<cfargument name="blogTitle" type="string" required="true">
		<cfargument name="blog_description" type="string" required="true">

		<cfquery datasource="#request.dsn#" name="qUpdateBolg">
			UPDATE
				Blog_Post
			SET 
				Title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blogTitle#">,
				Description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blog_description#">
			WHERE
				blog_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.blog_id#">
		</cfquery>
	</cffunction>
	
	<cffunction name="DeleteBlogPost" access="remote" output="false">
		<cfargument name="blog_id" type="numeric" required="true">

		<cfquery datasource="#request.dsn#">
			DELETE FROM 
				Blog_Post 
			WHERE 
				Blog_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.blog_id#">
		</cfquery>
	</cffunction>
	
</cfcomponent>