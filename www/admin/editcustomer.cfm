<cftry>
<cfif not (StructKeyExists(url,"cid") and len(trim(url.cid)))>
	<cfset variables.page_title = "Add Customer">
	<cfset url.cid = 0>
<cfelse>
	<cfset variables.page_title = "Edit Customer">
</cfif>
<cfinclude template="header.cfm">

<cfoutput>	
	<cfset variables.birthYearLimit 	= DateFormat(now(),"yyyy") - 4 >	
	<cfset variables.objCustomer 		= CreateObject("component","customers")>
	<cfset variables.qGetCustomerDetails= variables.objCustomer.getCustomerDetailsById(customerId = url.cid)>
	<cfif StructKeyExists(form,"editCustomer")>	
		<cfif StructKeyExists(url,"cid") and url.cid>
			<cfset variables.qUpdateCustomers = variables.objCustomer.updateCustomerDetails(customerId = url.cid,firstName = form.firstName,lastName = form.lastName,mobileNumber = form.mobileNumber,emailId = form.emailId,day = form.day,month = form.month,year = form.year,address = form.address,address2 = form.address2,city = form.city,state = form.state,zipCode = form.zipCode,customerNotes = form.customerNotes,companyNotes = form.companyNotes,secondaryMobile = form.secondaryMobile)>
		<cfelse>
			<cfset variables.qUpdateCustomers = variables.objCustomer.setCustomer(firstName = form.firstName,lastName = form.lastName,mobileNumber = form.mobileNumber,emailId = form.emailId,password = form.password, day = form.day,month = form.month,year = form.year,address = form.address,address2 = form.address2,city = form.city,state = form.state,zipCode = form.zipCode,customerNotes = form.customerNotes,companyNotes = form.companyNotes,secondaryMobile = form.secondaryMobile)>
		</cfif>
		<cfif variables.qUpdateCustomers>
			<cflocation url="customers.cfm" addtoken="false">
		<cfelse>
			<cflocation url="editcustomer.cfm?cid=#url.cid#&false" addtoken="false">			
		</cfif>
	</cfif>
	<cfif StructKeyExists(url,"cid") and StructKeyExists(url,"false")>
		<script>
			$(function() {
				$('##customer_form_edit').find('##error').html('Email address already exists.');
				$('##customer_form_edit').find('##error').show();
			});
		</script>
	</cfif>
	<div id="edit-customer">
		<form id="customer_form_edit" action="" method="post">
			<div class="row">
				<div class="col-md-6">
					<p>
						<div class="row">
							<label for="firstName" class="col-md-12 control-label">First Name*</label>
							<div class="col-md-12 form-group">
								<input type="text" name="firstName" class="form-control required" id="firstName" maxlength="50" required value="#variables.qGetCustomerDetails.First_Name#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="lastName" class="col-md-12 control-label">Last Name*</label>
							<div class="col-md-12 form-group">
								<input type="text" name="lastName" class="form-control required" id="lastName" maxlength="50" required value="#variables.qGetCustomerDetails.Last_Name#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="mobileNumber" class="col-md-12 control-label">Mobile Number</label>
							<div class="col-md-12 form-group">
								<input type="text" name="mobileNumber" class="form-control" id="mobileNumber" maxlength="50" value="#variables.qGetCustomerDetails.Mobile_Phone#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="secondaryMobile" class="col-md-12 control-label">Home Phone</label>
							<div class="col-md-12 form-group">
								<input type="text" name="secondaryMobile" class="form-control" id="secondaryMobile" maxlength="50" value="#variables.qGetCustomerDetails.Home_Phone#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="emailId" class="col-md-12 control-label">Email</label>
							<div class="col-md-12 form-group">
								<input type="text" name="emailId" class="form-control" id="emailId" maxlength="50" value="#variables.qGetCustomerDetails.Email_Address#"> 
							</div>
						</div>
					</p>
					<p >
						<div class="row">				
							<cfif StructKeyExists(url,"cid") and url.cid>
								<div class="form-group">
									<span class="col-sm-12 control-label">
										<a href="javascript:void(0)" class="changeCustomerPassword" id="customer_#url.cid#">Change password</a>
									</span>
								</div>
							<cfelse>
								<label for="password" class="col-md-12 control-label">Password</label>
								<div class="col-md-12 form-group">
									<input type="password" name="password" class="form-control" id="password" maxlength="50" value="#variables.qGetCustomerDetails.Password#"> 
								</div>
							</cfif>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="day" class="col-md-12 control-label">Birth Date</label>
							<div class="col-md-4 form-group">
								<cfset variables.monthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]>
								<select name="month" class="form-control" id="month">
									<option value="">-MM-</option>
									<cfloop from="1" to="#ArrayLen(variables.monthArray)#" index="index">
										<option value="#index#" <cfif variables.qGetCustomerDetails.Birthdate_Month eq index> selected="selected"</cfif>>#variables.monthArray[index]#</option>
									</cfloop>
								</select>
							</div>
							<div class="col-md-4 form-group">
								<select name="day" class="form-control" id="day">
									<option value="">-DD-</option>
									<cfloop from="1" to="31" index="index">
										<option value="#index#" <cfif variables.qGetCustomerDetails.BirthDate_Day eq index> selected="selected"</cfif>>#index#</option>
									</cfloop>
								</select> 
							</div>							
							<div class="col-md-4 form-group">
								<select name="year" class="form-control" id="year">
									<option value="">-YYYY-</option>
									<cfloop from="1900" to="#variables.birthYearLimit#" index="index">
										<option value="#index#" <cfif variables.qGetCustomerDetails.Birthdate_Year eq index> selected="selected"</cfif>>#index#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="address" class="col-md-12 control-label">Address</label>
							<div class="col-md-12 form-group">
								<input type="text" name="address" class="form-control" id="address" value="#variables.qGetCustomerDetails.Address#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="address2" class="col-md-12 control-label">Address 2</label>
							<div class="col-md-12 form-group">
								<input type="text" name="address2" class="form-control" id="address2" value="#variables.qGetCustomerDetails.Address2#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="city" class="col-md-12 control-label">City</label>
							<div class="col-md-12 form-group">
								<input type="text" name="city" class="form-control" id="city" maxlength="50" value="#variables.qGetCustomerDetails.City#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="state" class="col-md-12 control-label">State</label>
							<div class="col-md-12 form-group">
								<!---<input type="text" name="state" class="form-control" id="state" maxlength="50" value="#variables.qGetCustomerDetails.State#"> --->
								<cfinvoke component="states" method="getStates">
									<cfinvokeargument name="Select_Name" value="state">
									<cfinvokeargument name="Selected_State" value="#variables.qGetCustomerDetails.State#">
								</cfinvoke>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="zipCode" class="col-md-12 control-label">Zip Code</label>
							<div class="col-md-12 form-group">
								<input type="text" name="zipCode" class="form-control" id="zipCode" maxlength="50" value="#variables.qGetCustomerDetails.Postal#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="customerNotes" class="col-md-12 control-label">Customer Notes</label>
							<div class="col-md-12 form-group">
								<textarea class="form-control" rows="3" name="customerNotes" id="customerNotes">#variables.qGetCustomerDetails.Customer_Notes#</textarea>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="companyNotes" class="col-md-12 control-label">Company Notes</label>
							<div class="col-md-12 form-group">
								<textarea class="form-control" rows="3" name="companyNotes" id="companyNotes">#variables.qGetCustomerDetails.Company_Notes#</textarea>
							</div>
						</div>
					</p>
					<!---<p>
						<h4>Billing Information</h4>
						<div class="row">
							<label for="billingAddress" class="col-md-12 control-label">Billing Address</label>
							<div class="col-md-12 form-group">
								<textarea class="form-control" rows="3" name="billingAddress" id="billingAddress">#variables.qGetCustomerDetails.Billing_Address#</textarea>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="billingAddress2" class="col-md-12 control-label">Billing Address 2</label>
							<div class="col-md-12 form-group">
								<textarea class="form-control" rows="3" name="billingAddress2" id="billingAddress2">#variables.qGetCustomerDetails.Billing_Address2#</textarea>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="billingCity" class="col-md-12 control-label">Billing City</label>
							<div class="col-md-12 form-group">
								<input type="text" name="billingCity" class="form-control" id="billingCity" maxlength="50" value="#variables.qGetCustomerDetails.Billing_City#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="billingState" class="col-md-12 control-label">Billing State</label>
							<div class="col-md-12 form-group">
								<input type="text" name="billingState" class="form-control" id="billingState" maxlength="50" value="#variables.qGetCustomerDetails.Billing_State#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="billingZipCode" class="col-md-12 control-label">Billing Zip Code</label>
							<div class="col-md-12 form-group">
								<input type="text" name="billingZipCode" class="form-control" id="billingZipCode" maxlength="50" value="#variables.qGetCustomerDetails.Billing_Postal#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="creditCardNumber" class="col-md-12 control-label">Credit Card Number</label>
							<div class="col-md-12 form-group">
								<input type="text" name="creditCardNumber" class="form-control" id="creditCardNumber" maxlength="50" value="#variables.qGetCustomerDetails.Credit_Card_No#"> 
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="nameOnCard" class="col-md-12 control-label">Name On Card</label>
							<div class="col-md-12 form-group">
								<input type="text" name="nameOnCard" class="form-control" id="nameOnCard" maxlength="50" value="#variables.qGetCustomerDetails.Name_On_Card#"> 
							</div>
						</div>
					</p>
					<p >
						<div class="row">
							<label for="creditCardMonth" class="col-md-6 control-label">Credit Card Exp Month</label>
							<div class="col-md-4 form-group">
								<select name="creditCardMonth" class="form-control" id="creditCardMonth">
									<cfloop from="1" to="12" index="index">
										<option value="#index#" <cfif variables.qGetCustomerDetails.Credit_Card_ExpMonth eq index> selected="selected"</cfif>>#index#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="creditCardYear" class="col-md-6 control-label">Credit Card Exp Year</label>
							<div class="col-md-4 form-group">
								<select name="creditCardYear" class="form-control" id="creditCardYear">
									<cfloop from="2004" to="2024" index="index">
										<option value="#index#" <cfif variables.qGetCustomerDetails.Credit_Card_ExpYear eq index> selected="selected"</cfif>>#index#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</p>
					<p>
						<div class="row">
							<label for="ccvCodeclass" class="col-md-6 control-label">CCV Code</label>
							<div class="col-md-4 form-group">
								<input type="text" name="ccvCode" class="form-control" id="ccvCode" maxlength="5" value="#variables.qGetCustomerDetails.CVV_Code#"> 
							</div>
						</div>
					</p>--->					
				</div>
			</div>
			<p>				
				<div class="row">
					<div id="error" class="col-md-12 alert alert-danger" style="display:none;">
						
					</div>
				</div>
			</p>
			<p>				
				<div class="row">
					<div class="col-md-12">
						<input type="hidden" name="customer_id" value="#url.cid#">
						<cfif StructKeyExists(url,"cid") and url.cid>
							<input type="submit" name="editCustomer" value="Update" class="btn btn-primary" onclick="return customerFormValidate(1);">
						<cfelse>
							<input type="submit" name="editCustomer" value="Save" class="btn btn-primary" onclick="return customerFormValidate(0);">
						</cfif>	


						<!--- <input type="submit" name="editCustomer" value="<cfif StructKeyExists(url,"cid") and url.cid>Update<cfelse>Save</cfif>" class="btn btn-primary" onclick="return customerFormValidate();"> --->
						<input type="button" name="cancel" value="Cancel" class="btn btn-default" onclick="cancelCustomerEditForm();">
					</div>
				</div>
			</p>
		</form>
	</div>
	<div id="dialog-changepassword" class="hide">
		<form id="changepass_form">
			<input type="hidden" name="customer_id" id="customer_id" value="#url.cid#">
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
						<input type="password" class="form-control" id="Confirm_Password" name="Confirm_Password" maxlength="50">
					</div>
				</div>

				<div id="changePassMsg" class="alert alert-danger" style="display:none;">
					Password does not match.
				</div>
				<div id="changePassMsgSucc" class="alert alert-success" style="display:none;"></div>
			</p>
		</form>
	</div><!-- ##dialog-changepassword -->	
</cfoutput>
<script type="text/javascript">
	function cancelCustomerEditForm() {
		window.location.href = "customers.cfm";
	}
	function customerFormValidate(x) {
		$('#error').html('');
		$('#error').hide();
		var mail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var charctersOnly =  /^([a-zA-Z]+\s)*[a-zA-Z]+$/;
		var numbersOnly = /^[0-9]+$/;
		var alphanumeric = /^[a-zA-Z0-9_]*$/;
		$('#customer_form_edit').validate();

		var firstNameForm = $.trim($('#firstName').val());
		var lastNameForm = $.trim($('#lastName').val());
		var mobileNumberForm = $.trim($('#mobileNumber').val());
		var email = $.trim($('#emailId').val());
		var homeNumberForm = $.trim($('#secondaryMobile').val());
		var zipCodeForm = $.trim($('#zipCode').val());
		//var usphone = /^\(?(\d{3})\)?[-\. ]?(\d{3})[-\. ]?(\d{4})( x\d{4})?$/;
		// var ccvCode = $.trim($('#ccvCode').val());
		$('#customer_form_edit').find(".required").each(function() {
			$(this).rules("add", { required: true, messages: { required: "" } });
		});
		

		var isSuccess = true;
		var isSuccessUpdate = true;
		if(x == 0) {
			if(email != '') {
				$.ajax({
					url: 'customers.cfc?method=checkEmail',
					dataType: 'text',
					type: 'post',
					async: false,
					data: {
						email: email,
					},
					success: function(obj) {
						console.log(obj);
						if(obj == 1) {
							isSuccess=  false;
						}
					}
				});
			}
		}
		console.log(isSuccess);
		if(firstNameForm != '') {		
			if(!(charctersOnly.test(firstNameForm))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid first name');
				$('#customer_form_edit').find('#error').show();
				return false;
			} 
		}
		if(lastNameForm != '') {		
			if(!(charctersOnly.test(lastNameForm))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid last name');
				$('#customer_form_edit').find('#error').show();
				return false;
			} 
		}
		if(mobileNumberForm != '') {		
			if(!(numbersOnly.test(mobileNumberForm))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid mobile number');
				$('#customer_form_edit').find('#error').show();
				return false;
			} 
		}
		if(homeNumberForm != '') {		
			if(!(numbersOnly.test(homeNumberForm))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid home phone number');
				$('#customer_form_edit').find('#error').show();
				return false;
			} 
		}
		if(email != '') {		
			if(!(mail.test(email))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid email address');
				$('#customer_form_edit').find('#error').show();
				return false;
			}
		}
		if(isSuccess == false) {
			$('#customer_form_edit').find('#error').html('Email address already exists.');
			$('#customer_form_edit').find('#error').show();
			return false;	
		}
		if(zipCodeForm != '') {		
			if(!(alphanumeric.test(zipCodeForm))) {
				$('#customer_form_edit').find('#error').html('Please enter a valid zip code');
				$('#customer_form_edit').find('#error').show();
				return false;
			} 
		}
		if ( !$('#customer_form_edit').valid() ) {
			$('#customer_form_edit').find('#error').html('Missing required fields!');
			$('#customer_form_edit').find('#error').show();
			$('#customer_form_edit').find('.form-group label.error').remove();
			return false;
		}
		// if(isNaN(ccvCode)) {
		// 	$('#ccvCode').css("border", "1px solid #FF0000");
		// 	$('#customer_form_edit').find('#error').html('Please enter a valid number');
		// 	$('#customer_form_edit').find('#error').show();
		// 	return false;			
		// } 
		return true;
	}
	$("#changepass_form").validate({
	        rules: {
	          password:{
	          required: true,
	          minlength: 3
	          },
	           Confirm_Password:{
	          required: true
	          },
	        },
	        messages:{
	          password:{
	            required: "Password is required",
	            minlength:"Atleast 3 characters required"
	          },
	          Confirm_Password:{
	            required: "Password is required"
	          },
	        }
	       }); 
	$('.changeCustomerPassword').on("click",function() {		
		var $dialog 	= $('#dialog-changepassword');	
		var customerId 	= $dialog.find("#customer_id").val();
		$dialog.removeClass('hide').dialog({
			modal: true,
			width: 350,
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
						var password = $dialog.find('#password').val();
						var Confirm_Password = $dialog.find('#Confirm_Password').val();
						var $changepass_form = $dialog.find('#changepass_form');

						$changepass_form.validate();
					
						if ( !$changepass_form.valid() )
							return false;
						
						if ( $changepass_form.find('#password').val() != $changepass_form.find('#Confirm_Password').val() ) {
							
			                $dialog.find('#changePassMsg').show();
							setTimeout(function() {
								 $dialog.find('#changePassMsg').hide();
			                }, 5000);
							return false;
						}

						// if(password != '' && password == Confirm_Password) {
							$('#changePassMsg').hide();
							$.ajax({
								url: 'customers.cfc?method=changeCustomerPassword',
								dataType: 'text',
								type: 'post',
								data: {
									customerId: customerId,
									password:password								
								},
								success: function(data){									
									//$dialog.dialog( "close" );
									 $('#dialog-changepassword #changePassMsgSucc').html('Your password has been changed successfully').fadeIn();
										setTimeout(function() {
						                   	$('#dialog-changepassword #changePassMsgSucc').html('');
						                    $('#changepass_form')[0].reset();
						                }, 5000);
									
								}
							});	
													
						// } else {
						// 	$('#changePassMsg').show();
						// }
					} 
				}
			]
		});
	});
	function leapYear(year)
		{
		  return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
		}
	$(document).ready(function(){
		var isleapyear = false;
		$('#year').on("click",function() {
			var yearid = $('#year').val();
			if(yearid != '') {
				var year = $("#year option:selected").text();
				var leapyear = leapYear(year);
				if(leapyear == true) {
					isleapyear = true;
					$("#day option[value='29']").attr("disabled",false);
				}else {
					isleapyear = true;
					$("#day option[value='29']").attr("disabled",true);
				}
			}
		});

		$('#month').on("click",function() {
			var monthid = $('#month').val();
			console.log(isleapyear);
			var yearid = $('#year').val();
			if(yearid != '') {
				var year = $("#year option:selected").text();
				var leapyear = leapYear(year);
				if(leapyear == true) {
					isleapyear = true;
				}
			}
			if(monthid == 2){
				if(isleapyear == true) {
					$("#day option[value='29']").attr("disabled",false);
				}else {
					$("#day option[value='29']").attr("disabled",true);
				}
				$("#day option[value='30']").attr("disabled",true);
				$("#day option[value='31']").attr("disabled",true);
			}
			
			else if(monthid == 4){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 6){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 9){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 11){
				$("#day option[value='31']").attr("disabled",true);
			} else{
				$("#day option[value='29']").attr("disabled",false);
				$("#day option[value='30']").attr("disabled",false);
				$("#day option[value='31']").attr("disabled",false);
			}
		});
	});
</script>
<cfinclude template="footer.cfm">
<cfcatch><cfdump var="#cfcatch#" abort="true"></cfcatch>
</cftry>