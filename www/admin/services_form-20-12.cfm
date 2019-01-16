<!--- 
COMPANY_ID
SERVICE_ID
 --->
<cfoutput>
	<form name="services_form" id="services_form"  method="get" action="">
		<cfinclude template="services_form_elements.cfm">
	</form>
	
	<div id="dialog-service" class="hide">
		<form id="service_form">
			<cfif structKeyExists(variables, 'service_tab') and len(#variables.service_tab#)>
				<input type="hidden" name="service_tab" id="service_tab_id" value="#variables.service_tab#">
			</cfif>
			<input type="hidden" name="service_id" id="service_id">
			<p>
				<div class="row">
					<label for="service_name" class="col-md-3 control-label">Name*</label>
					<div class="col-md-10 form-group">
						<input type="text" name="service_name" class="form-control required" id="service_name" maxlength="50" required> 
					</div>
				</div>
				<div class="row">
					<label for="service_description" class="col-md-3 control-label">Description*</label>
					<div class="col-md-10 form-group">
						<textarea class="form-control required" id="service_description" name="service_description" required></textarea>
					</div>
				</div>
			</p>
			<div class="hr hr-10 hr-double"></div>
			<p>
				<div class="row">
					
					<div class="col-md-5 form-group input-group">
						<input type="text" id="service_time" name="service_time" class="form-control number required" minlength="1" maxlength="3" required />
						<span class="input-group-addon">
							min
						</span>
					</div>
					<div class="col-md-5 form-group input-group">
						<span class="input-group-addon">
							$
						</span>
						<input type="text" id="price" name="price" class="form-control money required" maxlength="6" required />
					</div>
				</div>
				<div class="row">
					<div id="servicesMsg" class="col-md-10 alert alert-danger" style="display:none;">
						Missing required fields!
					</div>
				</div>
			</p>
			
		</form>
	</div><!-- ##dialog-service -->
	
	<div id="dialog-delete-service" class="hide">
		<p> Are you sure you want to delete the service ?</p>
	</div>
</cfoutput>

<script>
	
	$('.money').mask('000,000,000,000,000.00', {reverse: true});
	$('.number').mask('0000000000');

	var initDialog = function($dialog, okBtnAction){
		
		$dialog.removeClass('hide').dialog({
			modal: true,
			buttons: [ 
				{
					text: "Cancel",
					"class" : "btn btn-xs",
					click: function() {
						$('#page-content').load('services_form.cfm');
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

	$('.delete-service').on('click', function() {
		
		var data = {};
		data.serviceId = $(this).attr('id').split('_')[1];
		
		var $dialog = $('#dialog-delete-service');
		
		okBtnAction = function() {
			$.ajax({
				url: 'services.cfc?method=DeleteService&returnFormat=plain',
				dataType: 'html',
				type: 'post',
				data: {
					service_id: data.serviceId,
					professional_id: $('#table_sevices').find('#professional_id_service').val()
				},
				success: function(data){
					$dialog.dialog( "close" ); 
					var tab_id = $('#service_tab_id').val();
					if($('#service_tab_id').size() && tab_id)  {
						window.location = 'index.cfm?showTab=service-tab';
					}else 
					$('#page-content').load('services_form.cfm');
				}
			});
		};
	
		initDialog( $dialog,  okBtnAction);
		
	});
	$("#service_time").on("input", function() {
	  if (/^0/.test(this.value)) {
	    this.value = this.value.replace(/^0/, "")
	  }
	})
	$("#price").on("input", function() {
	  if (/^0/.test(this.value)) {
	    this.value = this.value.replace(/^0/, "")
	  }
	})
	
	$('#add-service').on('click', function() {
		
		var $dialog = $('#dialog-service');
		var $service_form = $dialog.find('#service_form');
		
		$dialog.find('#servicesMsg').hide();
		$service_form[0].reset();
		
		var okBtnAction = function() {
			
			$service_form.validate();
			$service_form.find(".required").each(function() {
	        	$(this).rules("add", { required: true, messages: { required: "" } });
			});
			console.log($('#service_time').val());
			console.log($('#price').val());
			if ( !$service_form.valid() ) {
				$dialog.find('#servicesMsg').show();
				return false;
			}
			
			// var time_value = $('#service_time').val();
			// if(!(time_value>0 && time_value <1440) {
			// 	error_flag = true;
			// }
			$.ajax({
				url: 'services.cfc?method=InsertService',
				dataType: 'text',
				type: 'post',
				data: {
					company_id: $('#table_sevices').find('#company_id_service').val(),
					professional_id: $('#table_sevices').find('#professional_id_service').val(),
					service_name : $service_form.find('#service_name').val(),
					service_description: $service_form.find('#service_description').val(),
					price: $service_form.find('#price').val(), 
					service_time: $service_form.find('#service_time').val()
				},
				success: function(data){
					console.log(data);
					$(".ui-dialog-content").dialog("close");
					//$dialog.dialog( "close" ); 
					var tab_id = $('#service_tab_id').val();
					if($('#service_tab_id').size() && tab_id) {
						window.location = 'index.cfm?showTab=service-tab';
					}else 
					$('#page-content').load('services_form.cfm');
				}
			});
		}
	
		initDialog( $dialog,  okBtnAction);
		
	});

	$( ".edit-service" ).on('click', function() {
		
		var $dialog_ = $('#dialog-service');
		var $service_form_ = $dialog_.find('#service_form');
		$dialog_.find('#servicesMsg').hide();
		$service_form_[0].reset();
		
		var srv_id = $(this).attr('id').split('_')[1];
		$.ajax({
				url: 'services.cfc?method=getServices&returnFormat=JSON',
				dataType: 'json',
				type: 'get',
				data: {
					Company_ID: $('#table_sevices').find('#company_id_service').val(),
					Service_ID: srv_id,
					Professional_ID: $('#table_sevices').find('#professional_id_service').val()
				},
				success: function(data){
					if (data.COLUMNS) {
						for(var i=0;i<data.COLUMNS.length;i++) {
							$('#'+data.COLUMNS[i].toLowerCase()).val(data.DATA[0][i]);
							$('#'+data.COLUMNS[i].toLowerCase()).attr('value', data.DATA[0][i])
						}
					};
					var $dialog = $('#dialog-service');
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
									var $service_form = $dialog.find('#service_form');
									
									$service_form.validate();
									$service_form.find(".required").each(function() {
							        	$(this).rules("add", { required: true, messages: { required: "" } });
									});
									if ( !$service_form.valid() ) {
										$dialog.find('#servicesMsg').show();
										return false;
									}
									
									var postdata = $service_form.serialize();
											postdata = postdata + '&company_id=' + $('#table_sevices').find('#company_id_service').val();
											postdata = postdata + '&professional_id=' + $('#table_sevices').find('#professional_id_service').val();
									$.ajax({
										url: 'services.cfc?method=updateService&returnFormat=plain',
										dataType: 'html',
										type: 'post',
										data: postdata,
										success: function(data){
									
											$dialog.dialog( "close" ); 
											$('#page-content').load('services_form.cfm');
										}
									});
								} 
							}
						]
					});
					
				}
		});
		
	});
	

</script>
