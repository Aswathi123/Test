<cfparam name="variables.company_id" default=#session.company_id#>
<cfparam name="variables.professional_id" default=#session.professional_id#>

<cfif isDefined('session.professional_id')>
	<cfset variables.professional_id 	= session.Professional_ID>
</cfif>
<cfif isDefined('session.Company_ID')>
	<cfset variables.Company_ID			= session.Company_ID>
</cfif>

<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessionals">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>

<cfinvoke component="blog" method="getBlogPost" returnvariable="qBlogPost">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 	
</cfinvoke>
<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_blogs td {
		vertical-align:middle;
	}
	#table_blogs td img {
		width:250px !important;
	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
	.ui-widget.ui-widget-content {
	    max-width: 800px;
	    width: 100% !important;
	}
</style>
<cfoutput>
<div class="row">
	<div class="table-responsive col-sm-12">
		<table id="table_blogs" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th class="col-sm-1">
						<input type="hidden" name="professional_id" id="professional_id" value="#variables.professional_id#">
						<input type="hidden" name="company_id" id="company_id" value="#variables.Company_ID#">
						<button type="button" id="add-blog" class="btn btn-info btn-sm">Add Blog Post</button>
					</th>
					<th class="col-sm-2">Title</th>
					<!---<th class="col-sm-3">Description</th>--->
					<th class="col-sm-2">Created Date</th>
				</tr>
			</thead>
			<tbody>
				<cfif qBlogPost.recordcount>
					<cfloop query="qBlogPost">
						<tr>
							<td align="center">
								<div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
									<a href="javascript:void(0);" class="edit-blog" id="blog_#qBlogPost.Blog_ID#">
									<i class="icon-edit"></i>
									</a>
									<a href="javascript:void(0);" class="delete-blog" id="blog_#qBlogPost.Blog_ID#">
									<font color="red"><i class="icon-trash"></i></font>
									</a>
								</div>
							</td>
							<td>#qBlogPost.Title#</td>
							<!---<td>#qBlogPost.Description#</td>--->
							<td>#DateFormat(qBlogPost.Created_Date,"mmmm dd, yyyy")#</td>
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td align="center" colspan="4">No Blog Post Found</td>
					</tr>
				</cfif>
			</tbody>
		</table>
	</div>
	<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage">
</div>		
</cfoutput>