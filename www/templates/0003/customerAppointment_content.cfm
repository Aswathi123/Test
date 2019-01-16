<cfoutput>	
	<div class="row ">
		<br /><br />
	</div>
	<section class="contact-body-content">
		<section class="contact-mail-section">
		<!-- contact-form -->
		 <section class="contact-section operations-section">
			<div class="container outer-container-layout welcome-container">
				<div class="row top-banner-row">
					<div class="col-md-8 col-12 blog-layout-left">
						<h1>APPOINTMENT HISTORY</h1>							
					</div>
					<div class="col-md-4 col-12 blog-layout-right">
						<h1>INFO</h1>
					</div>
				</div>
				<div class="row">					
					<div class="col-lg-8 col-md-12 col-12 contact-section">
						<cfif IsDefined("session.CustomerID")>
							<cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />	
							<cfset variables.qryResults = variables.objCFC.getCustomerAppointmentHistory(session.CustomerID) />
							
							<cfif variables.qryResults.RecordCount>
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>&nbsp;</th>
											<th align="left">Appointment Date/Time</th>
											<th align="left"><strong>Service</strong></th>
											<th align="left">Professional Name</th>
										</tr>
									</thead>
									<tbody>
										<cfloop query="variables.qryResults">
										<tr>
											<td>
												<cfif Start_Time GT Now()>
													<cfset variables.apptDesc = URLEncodedFormat('#Service_Name# on #DateFormat(Start_Time,"mm/dd/yyyy")# #TimeFormat(Start_Time,"short")#') />
													<a href="appointments.cfm?changeAppointmentID=#Appointment_ID#&apptDesc=#variables.apptDesc###bookingDiv">Reschedule</a>
												<cfelse>
													&nbsp;
												</cfif>
											</td>
											<td>#DateFormat(Start_Time,"mm/dd/yyyy")# #TimeFormat(Start_Time,"short")#</td>
											<td>#Service_Name#</td>
											<td>#First_Name# #Last_Name#</td>
										</tr>
										</cfloop>
									</tbody>
								</table>	
							<cfelse>
								<p>No Appointments were found</p>
							</cfif>
						</cfif>
					</div>

					<div class="col-lg-4 col-md-12 col-12 timing-table-content">		
						<h2>Hours of Operation</h2>
						<div class="row">

							<div class="col-md-12 col-sm-12 col-12">
								<table class="timing-table">
									<tbody>
										<tr>
											<td>Sunday</td>
											<td>: #qLocation.SUNDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Monday</td>
											<td>: #qLocation.MONDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Tuesday</td>
											<td>: #qLocation.TUESDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Wednesday</td>
											<td>: #qLocation.WEDNESDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Thursday</td>
											<td>: #qLocation.THURSDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Friday</td>
											<td>: #qLocation.FRIDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Saturday</td>
											<td>: #qLocation.SATURDAY_HOURS#</td>
										</tr>
									</tbody>
								</table>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>
	</section>
	<!-- Payment -->
	<section class="payment-section">
		<div class="container outer-container-layout payment-container">
			<div class="row">
				<div class="payment-inner-child payment-img-left">
				<h2>Payment methods</h2>
				</div>
				<div class="payment-inner-child payment-method-right">
					<cfinclude template="/customer_sites/include_payment_methods.cfm" >
					<ul class="payment-ul">
						<cfloop query="getPaymentMethods">
							<li>
								<img src="images/#getPaymentMethods.Logo_File#" alt="getPaymentMethods.PAYMENT_METHOD">
							</li>
						</cfloop>
					</ul>
				</div>
			</div>
		</div>
	</section>
</section>
</cfoutput>

<div class="modal fade" id="dialog-changepassword" tabindex="-1" role="dialog" aria-labelledby="Change password" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="registerModalLabel">Change your password</h4>
			</div>
			<div class="modal-body">
				<form id="changepass_form">
					<input type="hidden" name="customer_id" id="customer_id" value="#session.CustomerID#">
					<p>
						<div class="row">
							<label for="password" class="col-md-6 control-label">New Password*</label>
							<div class="col-md-12 form-group">
								<input type="password" name="password" class="form-control" id="password" maxlength="50">
							</div>
						</div>
						<div class="row">
							<label for="Confirm_Password" class="col-md-6 control-label">Confirm password*</label>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="Confirm_Password" maxlength="50">
							</div>
						</div>							
					</p>
				</form>
				<div id="changePassMsg" class="alert alert-danger" style="display:none;">
					Password does not match.
				</div>
				<div id="changePassMsgSucc" class="alert alert-success" style="display:none;"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="btnChangePassword" >Continue</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$('#btnUpdateProfile').on('click', function() {
	
	$('#frmProfile').validate({
		rules: {
			EmailAddress: { required: true, email: true },
			FirstName: { required: true },
			LastName: { required: true },
			MobilePhone: { required: true },
			Address: { required: true },
			State: { required: true },
			Postal: { required: true, number: true },
			Password: { required: true },
		}
	});
	
	if ( !$('#frmProfile').valid() )
		return false;
		
	$.ajax({
			type: "post",
			url: "/admin/appointmentsCalendarBean.cfc?method=updateCustomerProfile&returnFormat=JSON",
			dataType: "json",
			data: $('#frmProfile').serialize(),
			success: function (data){
				if( data == true ) {
					$('#msgProfile').addClass('alert-success');
					$('#msgProfile').html('Profile was successfully updated.');
				}
				else {
					$('#msgProfile').addClass('alert-danger');
					$('#msgProfile').html(data);
				}
			}
	});
});

$('.changeCustomerPassword').on("click",function() {
	$('#changePassMsg').hide();
	$('#dialog-changepassword').modal('show');
});

$('#btnChangePassword').on("click",function() {	
	var customerId 	= $('#changepass_form').find("#customer_id").val();
	var password 	= $('#changepass_form').find('#password').val();
	var Confirm_Password = $('#changepass_form').find('#Confirm_Password').val();
	if(password != '' && password == Confirm_Password) {
		$('#changePassMsg').hide();
		$.ajax({
			url: '/admin/customers.cfc?method=changeCustomerPassword',
			dataType: 'text',
			type: 'post',
			data: {
				customerId: customerId,
				password:password								
			},
			success: function(data){									
				//$('#dialog-changepassword').modal('hide');
				$('#dialog-changepassword #changePassMsgSucc').html('Your password has been changed successfully').fadeIn();
			}
		});							
	} else {
		$('#changePassMsg').show();
	}
});
</script>