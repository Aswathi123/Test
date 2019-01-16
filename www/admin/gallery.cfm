<cfset variables.page_title = "Photo Gallery">
<cfinclude template="header.cfm">
<cfset variables.destination = GetTempDirectory()&createuuid() >
<cfoutput>
	<form name="gallery" id="gallery"  method="get" action="">
		<cfinclude template="gallery_form_elements.cfm">
	</form>
	<cfif StructKeyExists(form,"submitGallery") >
		
		<cfif NOT DirectoryExists("#variables.destination#")>
			<cfdirectory action = "create" directory = "#variables.destination#" >
		</cfif>
		<cffile  action = "upload" destination = "#variables.destination#"  fileField = "upload_file"  nameConflict = "Overwrite"  result = "result">
		<cfset variables.fileName = result.serverfilename >
		<cfset variables.fileExt = result.serverfileext >
		<cfquery name="qInsertProfilePhoto" datasource="#request.dsn#" result="myResult">
			INSERT INTO Gallery (Company_ID,Professional_ID,Description) 
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.company_id#" >,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#session.professional_id#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gallery_description#" >
				)
		</cfquery>
		<cfset variables.galleryId = myResult.IDENTITYCOL >
		<!--- setting file name example {Gallery_ID}.jpg --->
		<cfset variables.serverFileName = variables.galleryId&'.'&variables.fileExt >
		<cfset variables.serverFileNameThumb = variables.galleryId&'_tn.'&variables.fileExt >
		<cfset variables.targetPath = expandpath('.')&"/images/company/gallery/#session.company_id#">
		<cfset destDir = variables.destination & "/" & variables.serverFileName />
		<cfset sourceDir = variables.destination & "/" & "#variables.fileName#.#variables.fileExt#" />
		<cffile action = "rename" destination = "#destDir#" source = "#sourceDir#" >
		<cfif NOT DirectoryExists("#variables.targetPath#")>
			<cfdirectory action = "create" directory = "#variables.targetPath#" >
		</cfif>
		<cffile action = "copy" source = "#variables.destination#/#variables.serverFileName#"  destination = "#variables.targetPath#" >
		<cfset variables.newFilePath = variables.targetPath &"/"& variables.serverFileName />
		<cfimage source="#variables.newFilePath#" name="uploadeImage">
		<cfset variables.uploadedImageInfo = ImageInfo(uploadeImage)>
		<cfset variables.serverFileNameThumb = variables.serverFileName >
		<cfif variables.uploadedImageInfo.width gt 250 >		
			<cfset ImageScaleToFit(uploadeImage,250,"","highestQuality")>
			<cfset variables.serverFileNameThumb = variables.galleryId&'_tn.'&variables.fileExt >
			<cfset destDir = variables.targetPath & "/" & variables.serverFileNameThumb />	
			<cfimage action = "write"  source = "#uploadeImage#" destination="#destDir#" name = "#variables.serverFileNameThumb#"  overwrite="true">
		<cfelse>
			<cfset variables.serverFileNameThumb = variables.serverFileName  >
		</cfif>		
		<cfquery name="qInsertProfilePhoto" datasource="#request.dsn#" result="myResult">
			UPDATE Gallery 
			SET Image_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.serverFileName#" >,
				Thumb_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.serverFileNameThumb#" >
			WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.galleryId#" >
		</cfquery>
		<cflocation url="gallery.cfm" addtoken="false">
	</cfif>
	
	<cfif StructKeyExists(form,"submitGallery_update") >
		<cfset variables.destination = GetTempDirectory()&createuuid() >
		<cfset variables.galleryId =  trim(form.galleryId) >
		<cfif StructKeyExists(form,"upload_file") and len(trim(form.upload_file))>
			<cfif NOT DirectoryExists("#variables.destination#")>
				<cfdirectory action = "create" directory = "#variables.destination#" >
			</cfif>
			<cffile  action = "upload" destination = "#variables.destination#"  fileField = "upload_file"  nameConflict = "Overwrite"  result = "result">
			
			<cfset variables.fileName = result.serverfilename >
			<cfset variables.fileExt = result.serverfileext >		

			<!--- setting file name example {Gallery_ID}.jpg --->
			<cfset variables.serverFileName = variables.galleryId&'.'&variables.fileExt >
			<cfset variables.serverFileNameThumb = variables.galleryId&'_tn.'&variables.fileExt >
			<cfset variables.targetPath = expandpath('.')&"\images\company\gallery\#session.company_id#">
			
			<cffile action = "rename" destination = "#variables.destination#\#variables.serverFileName#" source = "#variables.destination#\#variables.fileName#.#variables.fileExt#" >
			
			<cfif NOT DirectoryExists("#variables.targetPath#")>
				<cfdirectory action = "create" directory = "#variables.targetPath#" >
			</cfif>
			<cffile action = "copy" source = "#variables.destination#/#variables.serverFileName#"  destination = "#variables.targetPath#" >
			<cfset variables.newFilePath = variables.targetPath&"/"& variables.serverFileName>
			<cfimage source="#variables.newFilePath#" name="uploadeImage">
			<cfset variables.uploadedImageInfo = ImageInfo(uploadeImage)>
			<cfset variables.serverFileNameThumb = variables.serverFileName >
			<cfif variables.uploadedImageInfo.width gt 250 >			
				<cfset ImageScaleToFit(uploadeImage,250,"","highestQuality")>
				<cfset variables.serverFileNameThumb = variables.galleryId&'_tn.'&variables.fileExt >
				<cfimage action = "write"  source = "#uploadeImage#" destination="#variables.targetPath#\#variables.serverFileNameThumb#" name = "#variables.serverFileNameThumb#"  >
			<cfelse>
				<cfset variables.serverFileNameThumb = variables.serverFileName  >
			</cfif>		
			<cfquery name="qInsertProfilePhoto" datasource="#request.dsn#" result="myResult">
				UPDATE Gallery 
				SET Image_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.serverFileName#" >,
					Thumb_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.serverFileNameThumb#" >,
					Description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gallery_description#" >
				WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.galleryId#" >
			</cfquery>
		<cfelse>
			<cfquery name="qInsertProfilePhoto" datasource="#request.dsn#" result="myResult">
				UPDATE Gallery 
				SET Description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gallery_description#" >
				WHERE Gallery_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.galleryId#" >
			</cfquery>
		</cfif>
		<cflocation url="gallery.cfm" addtoken="no">
	</cfif>
	
	<div id="dialog-gallery" class="hide">
		<form id="gallery_form" action="" method ="post" enctype="multipart/form-data">
			<input type="hidden" name="submitGallery">
			<p>
				<div class="row">
					<label for="upload_file" class="col-md-3 control-label">Upload file*</label>
					<div class="col-md-12 form-group">
						<input type="file" name="upload_file" class="form-control required " accept="image/gif, image/jpeg,image/png" id="upload_file" required> 
					</div>
				</div>
				<div class="row">
					<label for="service_description" class="col-md-3 col-xs-12 control-label">Description</label>
					<div class="col-md-12 col-xs-12 form-group">
						<textarea class="form-control" rows="6" id="gallery_description" maxlength="200" name="gallery_description"></textarea>
					</div>
				</div>
			</p>
			<div class="hr hr-10 hr-double"></div>
			<p>				
				<div class="row">
					<div id="galleryMsg" class="col-md-10 alert alert-danger" style="display:none;">
						Missing required fields!
					</div>
				</div>
			</p>			
		</form>
	</div><!-- ##dialog-service -->
	
	
	<div id="dialog-edit-gallery" class="hide">
		<form id="gallery_edit_form" action="" method ="post" enctype="multipart/form-data">
			<input type="hidden" name="galleryId" class="editGalleryId_hdn" value="" >
			<input type="hidden" type="hidden" name="submitGallery_update">
			<p>
				<div class="row hide uploadWrap">
					<label for="upload_file" class="col-md-3 control-label">Upload file*</label>
					<div class="col-md-12 form-group">
						<input type="file" name="upload_file" class="form-control required" accept="image/gif, image/jpeg,image/png" id="upload_file"  required> 
					</div>
				</div>
				<div class="row displayUploadedImageEdit">
					<div class="col-md-12 form-group">
						<img src="" >						
					</div>
				</div>
				<div class="row">
					<label for="service_description" class="col-md-3 col-xs-12 control-label">Description</label>
					<div class="col-md-12  col-xs-12 form-group">
						<textarea class="form-control gallery_edit_description" rows="6"  maxlength="200" name="gallery_description" ></textarea>
					</div>
				</div>
			</p>
			<div class="hr hr-10 hr-double"></div>
			<p>				
				<div class="row">
					<div id="galleryEditMsg" class="col-md-10 alert alert-danger" style="display:none;">
						Missing required fields!
					</div>
				</div>
			</p>			
		</form>
	</div><!-- ##dialog-service -->
	
	<div id="dialog-delete-gallery" class="hide">
		<p> Are you sure you want to delete this image ?</p>
	</div>
</cfoutput>

<script>
	
	
	var initDialog = function($dialog, okBtnAction){		
		$dialog.removeClass('hide').dialog({
			modal: true,
			width:600,
			height:500,
			buttons: [ 
				{
					text: "Cancel",
					"class" : "btn btn-xs",
					click: function() {
						$( this ).dialog( "close" ); 
					} 
				},
				{
					text: "OK",
					"class" : "btn btn-primary btn-xs",
					click: function() {
						okBtnAction();
					} 
				}
			]
		});
	}

	$('.delete-gallery').on('click', function() {		
		var data 				= {};
		data.galleryId 			= $(this).attr('id').split('_')[1];
		var $dialog = $('#dialog-delete-gallery');
		okBtnAction = function() {
			$.ajax({
				url: 'gallery.cfc?method=DeleteGallery&returnFormat=plain',
				dataType: 'html',
				type: 'post',
				data: {
					gallery_id: data.galleryId
				},
				success: function(data){
					$dialog.dialog( "close" ); 
					//$('#page-content').load('gallery.cfm');
					window.location ='gallery.cfm';
				}
			});
		};
		initDialog( $dialog,  okBtnAction);
		
	});
	
	$('#add-gallery').on('click', function() {		
		var $dialog 		= $('#dialog-gallery');
		var $gallery_form 	= $dialog.find('#gallery_form');
		var data 			= {};
		data.companyId 		= $('#table_gallery').find('#company_id').val();
		data.professionalId = $('#table_gallery').find('#professional_id').val();
		
		$dialog.find('#galleryMsg').hide();
		$gallery_form[0].reset();
		
		var okBtnAction = function() {			
			$gallery_form.validate();
			$gallery_form.find(".required").each(function() {
	        	$(this).rules("add", { required: true, messages: { required: "" } });
			});
			if ( !$gallery_form.valid() ) {
				$dialog.find('#galleryMsg').show();
				return false;
			} else {
				$dialog.find('#galleryMsg').hide();
			}
			
			$('#gallery_form').submit();
			
		}
	
		initDialog( $dialog,  okBtnAction);
		
	});

	$( ".edit-gallery" ).on('click', function() {		
		var imageDispaly = '';
		var $dialog_ = $('#dialog-edit-gallery');
		var $gallery_edit_form = $dialog_.find('#gallery_edit_form');
		$dialog_.find('#galleryEditMsg').hide();
		$gallery_edit_form[0].reset();
		
		var data 			= {};
		data.gallery_id 	= $(this).attr("rel");
		
		//var srv_id = $(this).attr('id').split('_')[1];
		$.ajax({
			url: '/admin/gallery.cfc?method=editGallery&returnFormat=JSON',
			dataType: 'json',
			type: 'get',
			data: {
				gallery_id:data.gallery_id
			},
			success: function(data){
				var data =  JSON.parse(data);
				if (data.COLUMNS) {
					var id = $.trim(data.DATA[0][1]);
					var imageName = $.trim(data.DATA[0][4]);
					$('.gallery_edit_description').val(data.DATA[0][5]);
					$('.editGalleryId_hdn').val(data.DATA[0][0]);
					console.log(data);
					console.log(imageName);
					if(imageName == ''){
						$('.uploadWrap').removeClass("hide");
						$('.displayUploadedImageEdit').addClass("hide"); 
					}else{
					
						imageDispaly = "images/company/gallery/"+id+"/"+imageName;
						$('.displayUploadedImageEdit img').attr("src",imageDispaly);						
					}
					
				};
				var $dialog = $('#dialog-edit-gallery');
				$dialog.removeClass('hide').dialog({
					modal: true,
					width:600,
					height:500,
					buttons: [ 
						{
							text: "Cancel",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" ); 
							} 
						},
						{
							text: "OK",
							"class" : "btn btn-primary btn-xs",
							click: function() {								
								$('#gallery_edit_form').submit();
							} 
						}
					]
				});
				
			}
		});
		
	});
</script>
<cfinclude template="footer.cfm">