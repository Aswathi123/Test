<style>
	.blog-post-meta {
		font-size: 15px;
		font-weight:bold;
		color:#666;
	}
	.createdBy {
		color:#428bca;
	}
	.blog-post img {
		width: 300px !important;
		display: block;
	}
	.previousButton {
		float:left;
		margin-left:20px;
		padding:10px;
	}
	.nextButton {
		float:right;
		margin-right:20px;
		padding:10px;
	}
	.pageCount {
		margin-top: 10px;
		margin-left: 183px;
		float: left;
		color: #2a6496;
		padding: 7px 20px;
		border: 1px solid #dddddd;
		border-radius: 8px;
	}
</style>
<cfoutput>
<cfif structKeyExists(url,"blogId")>
		<cfquery name="qGetBlogPostRecent" datasource="#request.dsn#">
			SELECT Company_ID,Title,Created_Date,Description,blog_id 
			FROM blog_Post	
			WHERE blog_Id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.blogId#"> 
			AND Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.COMPANY_ID#">  
			ORDER BY Blog_ID DESC
		</cfquery>
		<div class="col-md-8" id="page-content">
			<div class="block-header">
				<h2>
					<span class="title">Blog</span>
				</h2>
			</div>
			<div class="content">
				<cfif qGetBlogPostRecent.recordcount>
					<cfloop query="qGetBlogPostRecent" startRow = "#url.startRow#" endRow = "#url.endRow#">
						<cfquery name="getProfessional" datasource="#request.dsn#">
							SELECT First_Name, Last_Name FROM Professionals	LEFT JOIN Locations ON Professionals.Location_ID=Locations.Location_ID
							WHERE 
								Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.Company_ID# ">
						</cfquery>
						<div class="blog-post">
							<h2 class="blog-post-title">#qGetBlogPostRecent.Title#</h2>
							<p class="blog-post-meta">#DateFormat(qGetBlogPostRecent.Created_Date,"mmmm dd, yyyy")# by <span class="createdBy">#getProfessional.First_Name# #getProfessional.Last_Name#</span></p>
							<p>#qGetBlogPostRecent.Description#</p>
						</div>
						<hr>
					</cfloop>
				</cfif>
			</div>
			<ul class="pager">
				<cfif url.startRow gt 1>
					<li class="previousButton"><a href="blog.cfm?startRow=#(url.startRow)-5#&endRow=#(url.startRow)-1#">Previous</a></li>
				</cfif>
				<li><a href="blog.cfm" class="pageCount">SHOW ALL BLOG</a></li>
				<cfif url.endRow lt qGetBlogPostRecent.recordcount>
					<li class="nextButton"><a href="blog.cfm?startRow=#(url.endrow)+1#&endRow=#(url.endrow)+5#">Next</a></li>
				</cfif>
				<div class="clearfix"></div>
			</ul>
		</div>
		<div class="col-md-4">
			<div class="block-header">
				<h2>
					<span class="title">RECENT BLOGS</span>
				</h2>
			</div>
			<div class="content">
				<ol class="list-unstyled">
					<cfif qGetBlogPost.recordcount>
						<cfloop query="qGetBlogPost"> 
							<li><a href="blog.cfm?blogId=#qGetBlogPost.blog_Id#">#qGetBlogPost.Title#</a></li>
						</cfloop>
					</cfif>
				 </ol>
			</div>
		</div>
	<cfelse>
		<div class="col-md-8" id="page-content">
			<div class="block-header">
				<h2>
					<span class="title">Blog</span>
				</h2>
			</div>
			<div class="content">
				<cfif qGetBlogPost.recordcount>
					<cfloop query="qGetBlogPost" startRow = "#url.startRow#" endRow = "#url.endRow#">
						<cfquery name="getProfessional" datasource="#request.dsn#">
							SELECT First_Name, Last_Name FROM Professionals	LEFT JOIN Locations ON Professionals.Location_ID=Locations.Location_ID
							WHERE 
								Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.Company_ID# ">
						</cfquery>
						<div class="blog-post">
							<h2 class="blog-post-title">#qGetBlogPost.Title#</h2>
							<p class="blog-post-meta">#DateFormat(qGetBlogPost.Created_Date,"mmmm dd, yyyy")# by <span class="createdBy">#getProfessional.First_Name# #getProfessional.Last_Name#</span></p>
							<p>#qGetBlogPost.Description#</p>
						</div>
						<hr>
					</cfloop>
				</cfif>
			</div>
			<ul class="pager">
				<cfif url.startRow gt 1>
					<li class="previousButton"><a href="blog.cfm?startRow=#(url.startRow)-5#&endRow=#(url.startRow)-1#">Previous</a></li>
				</cfif>
				<li class="pageCount">PAGE #url.startRow# to <cfif url.endRow lt qGetBlogPost.recordcount>#url.endRow#<cfelse>#qGetBlogPost.recordcount#</cfif></li>
				<cfif url.endRow lt qGetBlogPost.recordcount>
					<li class="nextButton"><a href="blog.cfm?startRow=#(url.endrow)+1#&endRow=#(url.endrow)+5#">Next</a></li>
				</cfif>
				<div class="clearfix"></div>
			</ul>
		</div>
		<div class="col-md-4">
			<div class="block-header">
				<h2>
					<span class="title">RECENT BLOGS</span>
				</h2>
			</div>
			<div class="content">
				<ol class="list-unstyled">
					<cfif qGetBlogPost.recordcount>
						<cfloop query="qGetBlogPost"> 
							<li><a href="blog.cfm?blogId=#qGetBlogPost.blog_Id#">#qGetBlogPost.Title#</a></li>
						</cfloop>
					</cfif>
				 </ol>
			</div>
		</div>
	</cfif>
</cfoutput>