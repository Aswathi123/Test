<cfoutput>
	<cfquery name="getGallery" datasource="#request.dsn#">
		SELECT Gallery_ID,Company_ID,Professional_ID,Image_Name,Thumb_Name,Description 
		FROM Gallery WHERE Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.company_id#" > ORDER BY Gallery_ID DESC
	</cfquery>
	<section class="gallery-body-content">
		<div class="container outer-container-layout">
			<div class="row blog-title" id="galleryDiv">
				<div class="col-md-8 col-12 blog-layout-left">
					<h1>GALLERY</h1>					
				</div>	
			</div>
			<div class="gallery-content">
				<div class="grid-layout gallery-content-grid">
					<cfif getGallery.recordcount>					
						<cfloop query="getGallery">
						<cfset variables.targetId ="##Image"&getGallery.GALLERY_ID>				
							<div class="grid-item gallery-grid-item span-two" data-toggle="modal" data-target="#variables.targetId#">
								<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Thumb_Name#">
								<div class="grid-button-wrapper">
									<button class="know-more-btn"><i class="fa fa-search" aria-hidden="true"></i></button>
								</div>
							</div>
						</cfloop>
					<cfelse>
						No Images available.
					</cfif>
				</div>
			</div>
		</div>
	</section>
	<!-- gallery Modal -->
	<cfloop query="getGallery">
		<cfset variables.target ="Image"&getGallery.GALLERY_ID>
		<div class="modal gallery-modal fade" id="#variables.target#" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">#getGallery.DESCRIPTION#</h5>
						<button type="button" class="close gallery-close-btn" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Image_Name#">
					</div>
				</div>
			</div>
		</div>
	</cfloop>
	<!-- Gallery Modal end -->
</cfoutput>