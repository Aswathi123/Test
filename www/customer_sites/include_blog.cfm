<cfif isDefined("url.blogId")>
	<cfset variables.BLOG_ID = url.blogId>
</cfif>
<cfquery name="qGetBlogPost" datasource="#request.dsn#">
	SELECT Company_ID,Title,Created_Date,Description,blog_id,bp.Professional_ID,p.First_Name,p.Last_Name 
	FROM blog_Post bp	
	INNER JOIN Professionals p ON bp.Professional_ID = p.Professional_ID
	WHERE  Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.COMPANY_ID#">
	<cfif isDefined("url.blogId")>
		AND bp.Blog_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.BLOG_ID#">
	<cfelse>
		ORDER BY Blog_ID DESC
	</cfif>	
</cfquery>