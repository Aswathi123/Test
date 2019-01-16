<style>
   .ui-widget.ui-widget-content {
	    width: 100% !important;
	    max-width: 600px;
	}
</style>
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

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
</cfinvoke>

<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />

<cfoutput>
<div class="row">
	<div class="table-responsive col-sm-8">		
		<table id="table_gallery" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th class="col-sm-1">
						<input type="hidden" id="company_id" name="company_id" value="#variables.Company_ID#">
						<input type="hidden" id="professional_id" name="professional_id" value="#variables.Professional_ID#">
						<button type="button" id="add-gallery" class="btn btn-info btn-sm">Add Photo</button>
					</th>
					<th class="col-sm-2">Thumbnail</th>					
				</tr>
			</thead>
			<tbody>
				<cfif qGallery.recordcount>
					<cfloop query="qGallery">
						<cfset variables.imagePath 		= qGallery.Image_Name>
						<cfset variables.imageThumbPath = qGallery.Thumb_Name>
						<tr>
							<td align="center">
								<div class="visible-md visible-lg hidden-sm btn-group">
									<a href="##" class="edit-gallery" id="gallery_#qGallery.Gallery_ID#" rel="#qGallery.Gallery_ID#">
									<i class="icon-edit"></i>
									</a>
									<a href="##" class="delete-gallery" id="gallery_#qGallery.Gallery_ID#">
									<font color="red"><i class="icon-trash"></i></font>
									</a>
								</div>
							</td>
							<td style="text-align: center;">
								<a href="##" class="edit-gallery" id="gallery_#qGallery.Gallery_ID#" rel="#qGallery.Gallery_ID#">
									<img src=".\images\company\gallery\#session.company_id#\#variables.imageThumbPath#" alt="" title="" style="width:200px;">
								</a>
							</td>
									
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td align="center" colspan="3">No Images Found</td>
					</tr>
				</cfif>
			</tbody>
		</table>
	</div>
</div>		
</cfoutput>