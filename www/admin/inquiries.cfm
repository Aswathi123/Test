<cfset variables.page_title = "Inquiries"> 
<cfinclude template="header.cfm">
<cfparam name="variables.location_id" default=0>
<cfparam name="variables.Company_ID" default=0>
<cfif isDefined('form.location_id')>
	<cfset variables.location_id=form.location_id>
<cfelseif isDefined('url.location_id')>
	<cfset variables.location_id=url.location_id>
</cfif>

<cfif isDefined('session.Location_ID')>
	<cfset variables.location_id=session.Location_ID> 
</cfif>

<cfinvoke component="location" method="getInquiries" returnvariable="qInquiries">
	<cfinvokeargument name="Location_ID" value="#variables.location_id#">
</cfinvoke>
<p>Below are messages left for you from the contact page of your website.</p>
<div class="row">
	<div class="col-xs-12">
		<div class="tabbable">
			<ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
				<li class="active">
					<a data-toggle="tab" href="#inbox" data-target="inbox">
						<i class="blue icon-inbox bigger-130"></i>
						<span class="bigger-110">Inbox</span>
					</a>
				</li>
			</ul>

			<div class="tab-content no-border no-padding">
				<div class="tab-pane in active">
					<div class="message-container">
						<div id="id-message-list-navbar" class="message-navbar align-center clearfix">
							<div class="message-bar">
								<div class="message-infobar" id="id-message-infobar">
									<span class="blue bigger-150">Inbox</span>
									<cfoutput>
										<span class="grey bigger-110">(#qInquiries.recordcount# unread messages)</span>
									</cfoutput>
								</div>

								<div class="message-toolbar hide">
									<a href="javascript:void(0);" class="btn btn-xs btn-message" onclick="deleteSelectedMessageList();">
										<i class="icon-trash bigger-125"></i>
										<span class="bigger-110">Delete</span>
									</a>
								</div>
							</div>

							<div>
								<div class="messagebar-item-left">
									<label class="inline middle">
										<input type="checkbox" id="id-toggle-all" class="ace" />
										<span class="lbl"></span>
									</label>

									&nbsp;
									<div class="inline position-relative">
										<a href="#" data-toggle="dropdown" class="dropdown-toggle">
											<i class="icon-caret-down bigger-125 middle"></i>
										</a>

										<ul class="dropdown-menu dropdown-lighter dropdown-100">
											<li>
												<a id="id-select-message-all" href="#">All</a>
											</li>

											<li>
												<a id="id-select-message-none" href="#">None</a>
											</li>

											<li class="divider"></li>

											<li>
												<a id="id-select-message-unread" href="#">Unread</a>
											</li>

											<li>
												<a id="id-select-message-read" href="#">Read</a>
											</li>
										</ul>
									</div>
								</div>

								<!--- <div class="messagebar-item-right">
									<div class="inline position-relative">
										<a href="#" data-toggle="dropdown" class="dropdown-toggle">
											Sort &nbsp;
											<i class="icon-caret-down bigger-125"></i>
										</a>
										<ul class="dropdown-menu dropdown-lighter pull-right dropdown-100">
											<li>
												<a href="#">
													<i class="icon-ok green"></i>
													Date
												</a>
											</li>
											<li>
												<a href="#">
													<i class="icon-ok invisible"></i>
													From
												</a>
											</li>
											<li>
												<a href="#">
													<i class="icon-ok invisible"></i>
													Subject
												</a>
											</li>
										</ul>
									</div>
								</div> --->

								<!--- <div class="nav-search minimized">
									<form class="form-search">
										<span class="input-icon">
											<input type="text" autocomplete="off" class="input-small nav-search-input" placeholder="Search inbox ..." />
											<i class="icon-search nav-search-icon"></i>
										</span>
									</form>
								</div> --->
							</div>
						</div>

						<div id="id-message-item-navbar" class="hide message-navbar align-center clearfix">
							<div class="message-bar">
								<div class="message-toolbar">
									&nbsp;
									<!---<a href="#" class="btn btn-xs btn-message">
										<i class="icon-trash bigger-125"></i>
										<span class="bigger-110">Delete</span>
									</a>--->
								</div>
							</div>

							<div>
								<div class="messagebar-item-left">
									<a href="#" class="btn-back-message-list">
										<i class="icon-arrow-left blue bigger-110 middle"></i>
										<b class="bigger-110 middle">Back</b>
									</a>
								</div>

							<!--- 	<div class="messagebar-item-right">
									<i class="icon-time bigger-110 orange middle"></i>
									<span class="time grey"></span>
								</div> --->
							</div>
						</div>

						<div id="id-message-new-navbar" class="hide message-navbar align-center clearfix">
							<div class="message-bar">
								<div class="message-toolbar">
									<a href="#" class="btn btn-xs btn-message">
										<i class="icon-save bigger-125"></i>
										<span class="bigger-110">Save Draft</span>
									</a>

									<a href="#" class="btn btn-xs btn-message">
										<i class="icon-remove bigger-125"></i>
										<span class="bigger-110">Discard</span>
									</a>
								</div>
							</div>

							<div class="message-item-bar">
								<div class="messagebar-item-left">
									<a href="#" class="btn-back-message-list no-hover-underline">
										<i class="icon-arrow-left blue bigger-110 middle"></i>
										<b class="middle bigger-110">Back</b>
									</a>
								</div>

								<div class="messagebar-item-right">
									<span class="inline btn-send-message">
										<button type="button" class="btn btn-sm btn-primary no-border">
											<span class="bigger-110">Send</span>

											<i class="icon-arrow-right icon-on-right"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
						
						<div class="message-list-container">
							<div class="message-list" id="message-list">
							<cfoutput query="qInquiries">
								<cfif len(trim(qInquiries.received_date))>
									<cfif DateFormat(qInquiries.received_date,"yyyy-mm-dd") EQ DateFormat(now(),"yyyy-mm-dd")>
										<cfset myReceivedDate = "Today, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
									<cfelseif DateAdd( 'd', -1,qInquiries.received_date ) EQ DateAdd( 'd', -1,now() )>
										<cfset myReceivedDate = "Yesterday, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
									<cfelse>
										<cfset myReceivedDate = "#DateFormat(qInquiries.received_date,"mm/dd/yyyy")#, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
									</cfif>
								<cfelse>
									<cfset myReceivedDate = "">
								</cfif>
								<div class="message-item message-unread <cfif qInquiries.currentrow eq 1>first</cfif>" id="message-item_#qInquiries.Inquiry_ID#">
									<label class="inline">
										<input type="checkbox" class="ace" name="message-checked" value="#qInquiries.Inquiry_ID#"/>
										<span class="lbl"></span>
									</label>
									<i class="message-star icon-star orange2"></i>
									<span class="sender" title="#qInquiries.sender_name#">#qInquiries.sender_name#</span>

									<span class="summary">
										<span class="text" id="#qInquiries.Inquiry_ID#">
											#Left(qInquiries.Sender_Message,50)#...
										</span>
									</span>
									<span class="time" style="width:150px;">#myReceivedDate#</span>
								</div>
							</cfoutput>								
						</div><!-- /.message-list-container -->
						<cfoutput>
							<div class="message-footer clearfix">
								<div class="pull-left"> #qInquiries.recordcount# messages total </div>

								<div class="pull-right">
									<div class="inline middle"> page 1 of 1 </div>

									&nbsp; &nbsp;
									<ul class="pagination middle">
										<li class="disabled">
											<span>
												<i class="icon-step-backward middle"></i>
											</span>
										</li>
										<li class="disabled">
											<span>
												<i class="icon-caret-left bigger-140 middle"></i>
											</span>
										</li>
										<li>
											<span>
												<input value="1" maxlength="3" type="text" />
											</span>
										</li>
										<li>
											<a href="##">
												<i class="icon-caret-right bigger-140 middle"></i>
											</a>
										</li>
										<li>
											<a href="##">
												<i class="icon-step-forward middle"></i>
											</a>
										</li>
									</ul>
								</div>
							</cfoutput>
						</div>

						<!--- <div class="hide message-footer message-footer-style2 clearfix">
							<div class="pull-left"> simpler footer </div>

							<div class="pull-right">
								<div class="inline middle"> message 1 of 2 </div>

								&nbsp; &nbsp;
								<ul class="pagination middle">
									<li class="disabled">
										<span>
											<i class="icon-angle-left bigger-150"></i>
										</span>
									</li>

									<li>
										<a href="#">
											<i class="icon-angle-right bigger-150"></i>
										</a>
									</li>
								</ul>
							</div>
						</div> --->
					</div><!-- /.message-container -->
				</div><!-- /.tab-pane -->
			</div><!-- /.tab-content -->
		</div><!-- /.tabbable -->
	</div><!-- /.col -->
</div><!-- /.row -->
<cfoutput query="qInquiries">
	<cfif len(trim(qInquiries.received_date))>
		<cfif DateFormat(qInquiries.received_date,"yyyy-mm-dd") EQ DateFormat(now(),"yyyy-mm-dd")>
			<cfset myReceivedDate = "Today, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
		<cfelseif DateAdd( 'd', -1,qInquiries.received_date ) EQ DateAdd( 'd', -1,now() )>
			<cfset myReceivedDate = "Yesterday, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
		<cfelse>
			<cfset myReceivedDate = "#DateFormat(qInquiries.received_date,"mm/dd/yyyy")#, #TimeFormat(qInquiries.received_date,"hh:mm tt")#">
		</cfif>
	<cfelse>
		<cfset myReceivedDate = "">
	</cfif>
	<div class="hide message-content" id="id-message-content_#qInquiries.Inquiry_ID#">
		<div class="message-header clearfix">
			<div class="pull-left">
				<!--- <span class="blue bigger-125"> Click to open this message </span> --->

				<div class="space-4"></div>

				<i class="icon-star orange2 mark-star"></i>

				&nbsp;
				<!---<img class="middle" alt="John's Avatar" src="assets/avatars/avatar.png" width="32" />--->
				<a href="##" class="sender">#qInquiries.Sender_Name#</a>

				&nbsp;
				<a href="##" class="mail"><a href="mailto:#qInquiries.Sender_Email#">#qInquiries.Sender_Email#</a></a>

				&nbsp;
				<i class="icon-time bigger-110 orange middle"></i>
				<span class="time">#myReceivedDate#</span>
			</div>

			<div class="action-buttons pull-right">
				<a href="javascript:void(0);" class="btn-delete-message" id="message-delete_#qInquiries.Inquiry_ID#" onclick="deleteInquiryMessage(#qInquiries.Inquiry_ID#);">
					<i class="icon-trash red icon-only bigger-130"></i>
				</a>
			</div>
		</div>

		<div class="hr hr-double"></div>

		<div class="message-body">
			<p>
				#qInquiries.Sender_Message#
			</p>
		</div>
		
		<div class="hr hr-double"></div>

		<div class="message-attachment clearfix">
			<div class="attachment-title">
				<span class="blue bolder bigger-110">Phone :</span>
				&nbsp;
				<span class="grey">#qInquiries.Sender_Phone#</span>
			</div>
		</div>
	</div><!-- /.message-content -->
</cfoutput>

<!-- inline scripts related to this page -->
<script src="assets/js/jquery.hotkeys.min.js"></script>
<script src="assets/js/bootstrap-wysiwyg.min.js"></script>
<script type="text/javascript">
	jQuery(function($){
	
		//handling tabs and loading/displaying relevant messages and forms
		//not needed if using the alternative view, as described in docs
		var prevTab = 'inbox'
		$('#inbox-tabs a[data-toggle="tab"]').on('show.bs.tab', function (e) {
			var currentTab = $(e.target).data('target');			
			if(currentTab == 'write') {
				Inbox.show_form();
			}
			else {
				if(prevTab == 'write')
					Inbox.show_list();
	
				//load and display the relevant messages 
			}
			prevTab = currentTab;
		})
	
	
		
		//basic initializations
		$('.message-list .message-item input[type=checkbox]').removeAttr('checked');
		$('.message-list').delegate('.message-item input[type=checkbox]' , 'click', function() {
			$(this).closest('.message-item').toggleClass('selected');
			if(this.checked) Inbox.display_bar(1);//display action toolbar when a message is selected
			else {
				Inbox.display_bar($('.message-list input[type=checkbox]:checked').length);
				//determine number of selected messages and display/hide action toolbar accordingly
			}		
		});
	
	
		//check/uncheck all messages
		$('#id-toggle-all').removeAttr('checked').on('click', function(){
			if(this.checked) {
				Inbox.select_all();
			} else Inbox.select_none();
		});
		
		//select all
		$('#id-select-message-all').on('click', function(e) {
			e.preventDefault();
			Inbox.select_all();
		});
		
		//select none
		$('#id-select-message-none').on('click', function(e) {
			e.preventDefault();
			Inbox.select_none();
		});
		
		//select read
		$('#id-select-message-read').on('click', function(e) {
			e.preventDefault();
			Inbox.select_read();
		});
	
		//select unread
		$('#id-select-message-unread').on('click', function(e) {
			e.preventDefault();
			Inbox.select_unread();
		});
	
		/////////
	
		//display first message in a new area
		$('.message-list .message-item:eq(0) .text').on('click', function() {
			//show the loading icon
			$('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');
			
			$('.message-inline-open').removeClass('message-inline-open').find('.message-content').remove();
	
			var message_list = $(this).closest('.message-list');
	
			//some waiting
			setTimeout(function() {
	
				//hide everything that is after .message-list (which is either .message-content or .message-form)
				message_list.next().addClass('hide');
				$('.message-container').find('.message-loading-overlay').remove();
	
				//close and remove the inline opened message if any!
	
				//hide all navbars
				$('.message-navbar').addClass('hide');
				//now show the navbar for single message item
				$('#id-message-item-navbar').removeClass('hide');
	
				//hide all footers
				$('.message-footer').addClass('hide');
				//now show the alternative footer
				$('.message-footer-style2').removeClass('hide');
	
				
				//move .message-content next to .message-list and hide .message-list
				message_list.addClass('hide').after($('.message-content')).next().removeClass('hide');
	
				//add scrollbars to .message-body
				$('.message-content .message-body').slimScroll({
					height: 200,
					railVisible:true
				});
	
			}, 500 + parseInt(Math.random() * 500));
		});
	
	
		//display second message right inside the message list
		$('.message-list .message-item .text').on('click', function(){
			if(!$(this).parent().parent().hasClass('first')) {
				var message = $(this).closest('.message-item');
				var message_id = $(this).attr("id");
				//if message is open, then close it
				if(message.hasClass('message-inline-open')) {
					message.removeClass('message-inline-open').find('.message-content').remove();
					return;
				}
		
				$('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');
				setTimeout(function() {
					$('.message-container').find('.message-loading-overlay').remove();
					message
						.addClass('message-inline-open')
						.append('<div class="message-content" />')
					var content = message.find('.message-content:last').html( $('#id-message-content_'+message_id).html() );
		
					content.find('.message-body').slimScroll({
						height: 200,
						railVisible:true
					});
			
				}, 500 + parseInt(Math.random() * 500));
			}
		});
	
	
	
		//back to message list
		$('.btn-back-message-list').on('click', function(e) {
			e.preventDefault();
			Inbox.show_list();
			$('#inbox-tabs a[data-target="inbox"]').tab('show'); 
		});	
	
		//hide message list and display new message form
		/**
		$('.btn-new-mail').on('click', function(e){
			e.preventDefault();
			Inbox.show_form();
		});
		*/
	
	
	
	
		var Inbox = {
			//displays a toolbar according to the number of selected messages
			display_bar : function (count) {
				if(count == 0) {
					$('#id-toggle-all').removeAttr('checked');
					$('#id-message-list-navbar .message-toolbar').addClass('hide');
					$('#id-message-list-navbar .message-infobar').removeClass('hide');
				}
				else {
					$('#id-message-list-navbar .message-infobar').addClass('hide');
					$('#id-message-list-navbar .message-toolbar').removeClass('hide');
				}
			}
			,
			select_all : function() {
				var count = 0;
				$('.message-item input[type=checkbox]').each(function(){
					this.checked = true;
					$(this).closest('.message-item').addClass('selected');
					count++;
				});
				
				$('#id-toggle-all').get(0).checked = true;
				
				Inbox.display_bar(count);
			}
			,
			select_none : function() {
				$('.message-item input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');
				$('#id-toggle-all').get(0).checked = false;
				
				Inbox.display_bar(0);
			}
			,
			select_read : function() {
				$('.message-unread input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');
				
				var count = 0;
				$('.message-item:not(.message-unread) input[type=checkbox]').each(function(){
					this.checked = true;
					$(this).closest('.message-item').addClass('selected');
					count++;
				});
				Inbox.display_bar(count);
			}
			,
			select_unread : function() {
				$('.message-item:not(.message-unread) input[type=checkbox]').removeAttr('checked').closest('.message-item').removeClass('selected');
				
				var count = 0;
				$('.message-unread input[type=checkbox]').each(function(){
					this.checked = true;
					$(this).closest('.message-item').addClass('selected');
					count++;
				});
				
				Inbox.display_bar(count);
			}
		}
	
		//show message list (back from writing mail or reading a message)
		Inbox.show_list = function() {
			$('.message-navbar').addClass('hide');
			$('#id-message-list-navbar').removeClass('hide');
	
			$('.message-footer').addClass('hide');
			$('.message-footer:not(.message-footer-style2)').removeClass('hide');
	
			$('.message-list').removeClass('hide').next().addClass('hide');
			//hide the message item / new message window and go back to list
		}
	
		//show write mail form
		Inbox.show_form = function() {
			if($('.message-form').is(':visible')) return;
			if(!form_initialized) {
				initialize_form();
			}
			
			
			var message = $('.message-list');
			$('.message-container').append('<div class="message-loading-overlay"><i class="icon-spin icon-spinner orange2 bigger-160"></i></div>');
			
			setTimeout(function() {
				message.next().addClass('hide');
				
				$('.message-container').find('.message-loading-overlay').remove();
				
				$('.message-list').addClass('hide');
				$('.message-footer').addClass('hide');
				$('.message-form').removeClass('hide').insertAfter('.message-list');
				
				$('.message-navbar').addClass('hide');
				$('#id-message-new-navbar').removeClass('hide');
				
				
				//reset form??
				$('.message-form .wysiwyg-editor').empty();
			
				$('.message-form .ace-file-input').closest('.file-input-container:not(:first-child)').remove();
				$('.message-form input[type=file]').ace_file_input('reset_input');
				
				$('.message-form').get(0).reset();
				
			}, 300 + parseInt(Math.random() * 300));
		}
	
	
	
	
		var form_initialized = false;
		function initialize_form() {
			if(form_initialized) return;
			form_initialized = true;
			
			//intialize wysiwyg editor
			$('.message-form .wysiwyg-editor').ace_wysiwyg({
				toolbar:
				[
					'bold',
					'italic',
					'strikethrough',
					'underline',
					null,
					'justifyleft',
					'justifycenter',
					'justifyright',
					null,
					'createLink',
					'unlink',
					null,
					'undo',
					'redo'
				]
			}).prev().addClass('wysiwyg-style1');
	
			//file input
			$('.message-form input[type=file]').ace_file_input()
			//and the wrap it inside .span7 for better display, perhaps
			.closest('.ace-file-input').addClass('width-90 inline').wrap('<div class="row file-input-container"><div class="col-sm-7"></div></div>');
	
			//the button to add a new file input
			$('#id-add-attachment').on('click', function(){
				var file = $('<input type="file" name="attachment[]" />').appendTo('#form-attachments');
				file.ace_file_input();
				file.closest('.ace-file-input').addClass('width-90 inline').wrap('<div class="row file-input-container"><div class="col-sm-7"></div></div>')
				.parent(/*.span7*/).append('<div class="action-buttons pull-right col-xs-1">\
					<a href="#" data-action="delete" class="middle">\
						<i class="icon-trash red bigger-130 middle"></i>\
					</a>\
				</div>').find('a[data-action=delete]').on('click', function(e){
					//the button that removes the newly inserted file input
					e.preventDefault();			
					$(this).closest('.row').hide(300, function(){
						$(this).remove();
					});
				});
			});
		}//initialize_form
	
	});
	
	function deleteInquiryMessage(messageId) {
		$.ajax({
			url:"location.cfc?method=deleteInquiries",
			type:'post',
			data: { 
				Inquiry_ID:messageId
			},
			success: function(data){
				if(data) {
					$('.message-list').find('#message-item_'+messageId).remove();
					window.location.href = "inquiries.cfm";
				}
			}, 
			error: function(data){
				console.log(data);
			}			
		});
	}
	
	function deleteSelectedMessageList() {
		var inquiryList 	= 0;
		var messageList 	= "";
		$('.message-item input[name="message-checked"]').each(function() {
			if($(this).is(":checked")) {
				if(messageList.length) {
					messageList = messageList + ',' + $(this).val();
				} else {
					messageList = $(this).val();
				}
			}
		});
		if(messageList.length) {
			inquiryList = messageList;
		}
		$.ajax({
			url:"location.cfc?method=deleteInquiries",
			type:'post',
			data: { 
				Inquiry_List:inquiryList
			},
			success: function(data){
				if(data) {
					window.location.href = "inquiries.cfm";
				}
			}, 
			error: function(data){
				console.log(data);
			}			
		});
	}
</script>
<cfinclude template="footer.cfm"> 		