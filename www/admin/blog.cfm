<cfset variables.page_title = "Blog">
<cfinclude template="header.cfm">
<script>
	$(function() {
		$('#Blog_Description_summernote').summernote({
			focus: false,
			height:250
		});
		$('.note-toolbar .note-insert').remove();
	});	
</script>
		
<cfoutput>
	<form name="blog" id="blogPost"  method="get" action="">
		<cfinclude template="blog_elements.cfm">
	</form>
	<!---<cfif StructKeyExists(form,"submitBlog") >
		<cfif len(trim(form.blog_title))>
			<cfquery datasource="#request.dsn#" result="myResult">
				INSERT INTO
					Blog_Post (Company_ID,Professional_ID,Title,Description,Created_Date,Created_By)			
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.company_id#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.professional_id#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.blog_title#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Blog_Description#">,
					<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#form.professional_id#">
					)
			</cfquery>
			<cfif myResult.recordcount>
				<cflocation url="blog.cfm" addtoken="no">
			</cfif>
		</cfif>
	</cfif>--->
	<div id="dialog-blog" class="hide">
		<form id="blog_form" action="" method ="post" enctype="multipart/form-data">
			<input type="hidden" name="submitBlog">
			<input type="hidden" name="professional_id" id="professional_id" value="#session.professional_id#">
			<input type="hidden" name="company_id" id="company_id" value="#session.Company_ID#">
			<p>
				<div class="row">
					<label for="blog_title" class="col-md-3 control-label">Title*</label>
					<div class="col-md-12 form-group">
						<input type="text" name="blog_title" class="form-control required" id="blog_title" required> 
					</div>
				</div>
				<div class="row">
					<label for="blog_description" class="col-md-3 control-label">Description*</label>
					<div class="col-md-12 form-group">
						<input type="hidden" id="Blog_Description" name="Blog_Description" class="required" required/>
						<div id="Blog_Description_summernote" class="required" ></div>
					</div>
				</div>
			</p>
			<div class="hr hr-12 hr-double"></div>
			<p>				
				<div class="row">
					<div id="blogMsg" class="col-md-12 alert alert-danger" style="display:none;">
						Missing required fields!
					</div>
				</div>
			</p>			
		</form>
	</div><!-- ##dialog-service -->

	<div id="dialog-delete-blog" class="hide">
		<p> Are you sure you want to delete the service ?</p>
	</div>
</cfoutput>
<script>
	var initDialog = function($dialog, okBtnAction){		
		$dialog.removeClass('hide').dialog({
			modal: true,
			width:800,
			height:700,
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

	$('.delete-blog').on('click', function() {		
		var data 				= {};
		data.blogPostId 		= $(this).attr('id').split('_')[1];			
		data.professionalId 	= $('#table_blogs').find('#professional_id').val();		
		data.companyId 			= $('#table_blogs').find('#company_id').val();
		
		var $dialog 	= $('#dialog-delete-blog');	
		$dialog.removeClass('hide').dialog({
			modal: true,
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
						$.ajax({
							url: 'blog.cfc?method=DeleteBlogPost&returnFormat=plain',
							dataType: 'html',
							type: 'post',
							data: {
								blog_id: data.blogPostId					
							},
							success: function(data){
								$dialog.dialog( "close" ); 
								window.location ='blog.cfm';
							}
						});
					} 
				}
			]
		});
	});

	$('#add-blog').on('click', function() {
		$('#blog_title').val("");
		$('#Blog_Description_summernote').code("");
		var $dialog = $('#dialog-blog');
		var $blog_form = $dialog.find('#blog_form');
		var error_flag = true;
		$dialog.find('#blogMsg').hide();
		$blog_form[0].reset();
		
		var okBtnAction = function() {
			var blogDescription = $('#Blog_Description_summernote').code();
			var title = $('#blog_title').val();
			console.log(blogDescription.length);
			console.log(title.length);
			$dialog.find('#blogMsg').hide();
			if((title.length == 0) && (blogDescription.length == 0)) {
				$dialog.find('#blogMsg').html("Title and description fields are required");
				error_flag = false;
			}
			else if(title.length == 0) {
				$dialog.find('#blogMsg').html("Title is required");
				error_flag = false;
			}
			else if(blogDescription.length == 0) {
				$dialog.find('#blogMsg').html("Description is required");
				error_flag = false;
			}
		 	else {
				error_flag = true;
			}
			// $blog_form.validate();
			// $blog_form.find(".required").each(function() {
	  //       	$(this).rules("add", { required: true, messages: { required: "" } });
			// });
			// if ( !$blog_form.valid() ) {
			// 	$dialog.find('#blogMsg').show();
			// 	return false;
			// } else {
			// 	$dialog.find('#blogMsg').hide();
			// 	/*$("#Blog_Description").val(blogDescription);
			// 	$('#blog_form').submit();*/
			// }
			if(error_flag == true) {
				$dialog.find('#blogMsg').hide();
				$.ajax({
				url: 'blog.cfc?method=InsertBlogPost',
				dataType: 'text',
				type: 'post',
				data: {
					company_id: $('#table_blogs').find('#company_id').val(),
					professional_id: $('#table_blogs').find('#professional_id').val(),
					blogTitle : $blog_form.find('#blog_title').val(),
					blog_description: blogDescription
				},
					success: function(data){
						$dialog.dialog( "close" ); 
						window.location ='blog.cfm';
					}
				});
			}else {
				$dialog.find('#blogMsg').show();
			}
			
		}
	
		initDialog( $dialog,  okBtnAction);
		
	});
	$('.edit-blog').on('click', function() {
		$('#blog_title').val("");
		$('#Blog_Description_summernote').code("");
		$('.loaderImage').show();
		var $dialog = $('#dialog-blog');
		var $blog_form = $dialog.find('#blog_form');
		
		$dialog.find('#blogMsg').hide();
		$blog_form[0].reset();
		var blog_id = $(this).attr('id').split('_')[1];
		$.ajax( {
			url:'blog.cfc?method=getBlogPostEdit&returnFormat=JSON',
			dataType: 'json',
			type: 'get',
			data: {
				blog_id : blog_id
			},
			success:function(data) {
				console.log(data);
				/*var data=JSON.parse(data);*/
				$('.loaderImage').hide();
				$('#blog_title').val(data.DATA[0][0]);
				$('#Blog_Description_summernote').code(data.DATA[0][1]);
			}
		});
		var okBtnAction = function() {
			var blogDescription = $('#Blog_Description_summernote').code();
			// $blog_form.validate();
			// $blog_form.find(".required").each(function() {
	  //       	$(this).rules("add", 
	  //       		{ 
	  //       		required: true,
  	// 				messages: { required: "" } });
			// });
			// if ( !$blog_form.valid() ) {
			// 	$dialog.find('#blogMsg').show();
			// 	return false;
			// } else {
			// 	$dialog.find('#blogMsg').hide();
			// 	/*$("#Blog_Description").val(blogDescription);
			// 	$('#blog_form').submit();*/
			// }
			var title = $('#blog_title').val();
			console.log(blogDescription.length);
			console.log(title.length);
			$dialog.find('#blogMsg').hide();
			if((title.length == 0) && (blogDescription.length == 0)) {
				$dialog.find('#blogMsg').html("Title and description fields are required");
				error_flag = false;
			}
			else if(title.length == 0) {
				$dialog.find('#blogMsg').html("Title is required");
				error_flag = false;
			}
			else if(blogDescription.length == 0) {
				$dialog.find('#blogMsg').html("Description is required");
				error_flag = false;
			}
		 	else {
				error_flag = true;
			}
			if(error_flag == true) {
				$dialog.find('#blogMsg').hide();
				$.ajax({
					url: 'blog.cfc?method=updateBlogPost',
					dataType: 'text',
					type: 'post',
					data: {
						blog_id : blog_id,
						blogTitle : $blog_form.find('#blog_title').val(),
						blog_description: blogDescription
					},
					success: function(data){
						$dialog.dialog( "close" ); 
						window.location ='blog.cfm';
					}
				});
			}else {
				$dialog.find('#blogMsg').show();
			}
		}
	
		initDialog( $dialog,  okBtnAction);
		
	});
</script>
<cfinclude template="footer.cfm">