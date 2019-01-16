<cfoutput>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/imagelightbox@0.10.0/src/imagelightbox.min.js"></script>
	<script>
		$( function() {
			$( '.popImage_img' ).imageLightbox({ 
				preloadNext:false 
			});
			$('.sdfkjdfh').click(function (evt) {
				evt.stopPropagation();
				// Your code here
			});
		});
		function disbaleClick(){
			$('##imagelightbox').click(function (evt) {
				evt.stopPropagation();
				// Your code here
			});
		}
		function popUp(id,ele){
			var image = $(ele).find('.image img').attr("src");
			//$('.galleryPopup .image img').attr("src",image);
		}
	</script>

	<div class="col-md-12" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Gallery</span>
			</h2>
		</div>
		<cfquery name="getGallery" datasource="#request.dsn#">
			SELECT Gallery_ID,Company_ID,Professional_ID,Image_Name,Thumb_Name,Description 
			FROM Gallery WHERE Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.company_id#" > ORDER BY Gallery_ID DESC
		</cfquery>
		<div class="galleryPortFolio">
			<cfif getGallery.recordcount>
				<cfloop query="getGallery">
					<div class="eachPhotoWrap" onclick="popUp(#getGallery.Gallery_ID#,this)">
						<div class="image">	
							<!---<a href="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Image_Name#" data-imagelightbox="a">
								<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Thumb_Name#" alt="" title="" >
							</a>--->
							<a href="##" data-imagelightbox="a" class="pop">
								<img src="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Thumb_Name#" alt="" title="" id="imageresource" data-imgsrc="admin\images\company\gallery\#getGallery.Company_ID#\#getGallery.Image_Name#" data-imgdesc="#getGallery.Description#">
							</a>
						</div>
						<div class="description">
							#Left(getGallery.Description, 200)# <cfif len(getGallery.Description) gt 200>...</cfif>
						</div>
					</div>
				</cfloop>
				<div class="clear"></div>
			<cfelse>
				<div class="emptyPhoto">No Record found</div>
			</cfif>
		</div>
	</div>
	<!-- Creates the bootstrap modal where the image will appear -->
	<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" style="margin-top: -10px;"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			
		  </div>
		   <div class="modal-body text-center">
		        <img src="" id="imagepreview" style="height: 330px; margin-top:10px;" >
				<div id="imagedescripton" style="margin-top:10px;text-align:center;"></div>
		      </div>
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		  </div>
		</div>
	  </div>
	</div>	
</cfoutput>