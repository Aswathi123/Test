<cfoutput>
<div class="block-header">
	<h2>
		<span class="title">Profile</span>
	</h2>
</div>
<div class="content">
	<cfif IsDefined("session.CustomerID")>
		<cfset variables.birthYearLimit 	= DateFormat(now(),"yyyy") - 4 >
		<cfset variables.objCFC 			=  createObject("component","admin.appointmentsCalendarBean") />	
		<cfset variables.qryCustomer 		= variables.objCFC.getCustomerProfile(session.CustomerID) />
		<form id="frmProfile" name="frmProfile" action="customer_profile.cfm" method="post">
			<input type="hidden" name="customerID" value="#session.CustomerID#" />
			<div class="row">
				<label for="Email" class="col-md-4">Your email address:</label>
				<div class="col-md-8">
					<input type="text" id="EmailAddress" name="EmailAddress" class="form-control" maxlength="100" value="#qryCustomer.Email_Address#" />
				</div>
			</div><br>			
			<div class="row">
				<label for="FirstName" class="col-md-4">Your first name:</label>
				<div class="col-md-8">
					<input type="text" id="FirstName" name="FirstName" class="form-control" maxlength="50" value="#qryCustomer.First_Name#" />
				</div>
			</div><br>
			<div class="row">
				<label for="LastName" class="col-md-4">Your last name:</label>
				<div class="col-md-8">
					<input type="text" id="LastName" name="LastName" class="form-control" maxlength="50" value="#qryCustomer.Last_Name#" />
				</div>
			</div><br>
			<div class="row">
				<label for="Password" class="col-md-4"></label>
				<div class="col-md-8">
					<a href="javascript:void(0)" class="changeCustomerPassword" id="customer_#session.CustomerID#">Change password</a>
				</div>
			</div><br/>
			<div class="row">
				<label for="Phone" class="col-md-4">Your phone:</label>
				<div class="col-md-8">
					<input type="text" id="MobilePhone" name="MobilePhone" class="form-control" maxlength="12" value="#qryCustomer.Mobile_Phone#" /><br />
					Example: 512-753-0000
				</div>
			</div><br>
			<div class="row">
				<label for="Phone" class="col-md-4">Your Home Phone:</label>
				<div class="col-md-8">
					<input type="text" id="HomePhone" name="HomePhone" class="form-control" maxlength="12" value="#qryCustomer.Home_Phone#" /><br />
				</div>
			</div><br>
			<div class="row">
				<label for="Address" class="col-md-4">Your Address:</label>
				<div class="col-md-8">
					<input type="text" id="Address" name="Address" class="form-control" maxlength="50" value="#qryCustomer.Address#" />
				</div>
			</div><br>
			<div class="row">
				<label for="Address" class="col-md-4">Your Address2:</label>
				<div class="col-md-8">
					<input type="text" id="Address2" name="Address2" class="form-control" maxlength="50" value="#qryCustomer.Address2#" />
				</div>
			</div><br>
			<div class="row">
				<label for="City" class="col-md-4">Your City:</label>
				<div class="col-md-8">
					<input type="text" id="City" name="City" class="form-control" maxlength="50" value="#qryCustomer.City#" />
				</div>
			</div><br>
			<div class="row">
				<label for="State" class="col-md-4">Your State:</label>
				<div class="col-md-8">
					<cfinvoke component="admin.states" method="getStates">
	                    <cfinvokeargument name="Select_Name" value="State">
	                    <cfinvokeargument name="Selected_State" value="#qryCustomer.State#">
	                </cfinvoke>
				</div>
			</div><br>
			<div class="row">
				<label for="Postal" class="col-md-4">Your Postal:</label>
				<div class="col-md-8">
					<input type="text" id="Postal" name="Postal" class="form-control" maxlength="5" value="#qryCustomer.Postal#" />
				</div>
			</div><br>			
			<div class="row">
				<label for="day" class="col-md-4 control-label">Birth Date</label>
				<div class="col-md-4 form-group">
					<cfset variables.monthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]>
					<select name="month" class="form-control" id="month">
						<option value="">-MM-</option>
						<cfloop from="1" to="#ArrayLen(variables.monthArray)#" index="index">
							<option value="#index#" <cfif qryCustomer.Birthdate_Month eq index> selected="selected"</cfif>>#variables.monthArray[index]#</option>
						</cfloop>
					</select>
				</div>
				<div class="col-md-2 form-group">
					<select name="day" class="form-control" id="day">
						<option value="">-DD-</option>
						<cfloop from="1" to="31" index="index">
							<option value="#index#" <cfif qryCustomer.BirthDate_Day eq index> selected="selected"</cfif>>#index#</option>
						</cfloop>
					</select> 
				</div>							
				<div class="col-md-2 form-group">
					<select name="year" class="form-control" id="year">
						<option value="">-YYYY-</option>
						<cfloop from="1900" to="#variables.birthYearLimit#" index="index">
							<option value="#index#" <cfif qryCustomer.Birthdate_Year eq index> selected="selected"</cfif>>#index#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="row">
				<label for="customerNotes" class="col-md-4 control-label">Customer Notes</label>
				<div class="col-md-8 form-group">#qryCustomer.Customer_Notes#</div>
			</div>
			<!--- <div class="row">
				<label for="companyNotes" class="col-md-4 control-label">Company Notes</label>
				<div class="col-md-8 form-group">
					<textarea class="form-control" rows="3" name="companyNotes" id="companyNotes" disabled>#qryCustomer.Company_Notes#</textarea>
				</div>
			</div> --->
			<hr />
			<div class="row">
				<div class="col-md-8">
					<button type="button" id="btnUpdateProfile" class="btn btn-danger" >Update Profile</button>
				</div>
			</div>
			<div id="msgProfile" class="alert">&nbsp;</div>
		</form>
	</cfif>
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
</div>
</cfoutput>	
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