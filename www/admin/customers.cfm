<cfset variables.page_title = "Customers">
<cfinclude template="header.cfm">
<style>
	.form-group {
		margin-bottom:0px;
	}
</style>
<cfoutput>	
	<cfinclude template="customers_elements.cfm">
	<!---<cfset variables.birthYearLimit = DateFormat(now(),"yyyy") - 4 >
	<div id="dialog-customer" class="hide" style="width:450px">
		<form id="customer_form" action="" method ="post">			
			<p>
				<div class="row">
					<label for="firstName" class="col-md-12 control-label">First Name*</label>
					<div class="col-md-12 form-group">
						<input type="text" name="firstName" class="form-control required" id="firstName" maxlength="50" required> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="lastName" class="col-md-12 control-label">Last Name*</label>
					<div class="col-md-12 form-group">
						<input type="text" name="lastName" class="form-control required" id="lastName" maxlength="50" required> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="mobileNumber" class="col-md-12 control-label">Mobile Number</label>
					<div class="col-md-12 form-group">
						<input type="text" name="mobileNumber" class="form-control" id="mobileNumber" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="secondaryMobile" class="col-md-12 control-label">Home Phone</label>
					<div class="col-md-12 form-group">
						<input type="text" name="secondaryMobile" class="form-control" id="secondaryMobile" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="emailId" class="col-md-12 control-label">Email</label>
					<div class="col-md-12 form-group">
						<input type="text" name="emailId" class="form-control" id="emailId" maxlength="50"> 
					</div>
				</div>
			</p>
			<p >
				<div class="row">
					<label for="password" class="col-md-12 control-label">Password</label>
					<div class="col-md-12 form-group">
						<input type="password" name="password" class="form-control" id="password" maxlength="50"> 
					</div>
				</div>
			</p>
			<p >
				<div class="row">
					<label for="day" class="col-md-12 control-label">Birth Day</label>
					<div class="col-md-4 form-group">
						<select name="day" class="form-control" id="day">
							<option value="">-DD-</option>
							<cfloop from="1" to="31" index="index">
								<option value="#index#">#index#</option>
							</cfloop>
						</select> 
					</div>
					<cfset variables.monthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]>
					<div class="col-md-4 form-group">
						<select name="month" class="form-control" id="month">
							<option value="">-MM-</option>
							<cfloop from="1" to="#ArrayLen(variables.monthArray)#" index="index">
								<option value="#index#">#variables.monthArray[index]#</option>
							</cfloop>
						</select>
					</div>
					<div class="col-md-4 form-group">
						<select name="year" class="form-control" id="year">
							<option value="">-YYYY-</option>
							<cfloop from="1950" to="#variables.birthYearLimit#" index="index">
								<option value="#index#">#index#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="address" class="col-md-12 control-label">Address</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="address" id="address"></textarea>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="address2" class="col-md-12 control-label">Address 2</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="address2" id="address2"></textarea>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="city" class="col-md-12 control-label">City</label>
					<div class="col-md-12 form-group">
						<input type="text" name="city" class="form-control" id="city" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="state" class="col-md-12 control-label">State</label>
					<div class="col-md-12 form-group">
						<input type="text" name="state" class="form-control" id="state" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="zipCode" class="col-md-12 control-label">Zip Code</label>
					<div class="col-md-12 form-group">
						<input type="text" name="zipCode" class="form-control" id="zipCode" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="customerNotes" class="col-md-12 control-label">Customer Notes</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="customerNotes" id="customerNotes"></textarea>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="companyNotes" class="col-md-12 control-label">Company Notes</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="companyNotes" id="companyNotes"></textarea>
					</div>
				</div>
			</p>
			<h3>Billing Information</h3>
			<p>
				<div class="row">
					<label for="billingAddress" class="col-md-12 control-label">Billing Address</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="billingAddress" id="billingAddress"></textarea>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="billingAddress2" class="col-md-12 control-label">Billing Address 2</label>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="3" name="billingAddress2" id="billingAddress2"></textarea>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="billingCity" class="col-md-12 control-label">Billing City</label>
					<div class="col-md-12 form-group">
						<input type="text" name="billingCity" class="form-control" id="billingCity" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="billingState" class="col-md-12 control-label">Billing State</label>
					<div class="col-md-12 form-group">
						<input type="text" name="billingState" class="form-control" id="billingState" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="billingZipCode" class="col-md-12 control-label">Billing Zip Code</label>
					<div class="col-md-12 form-group">
						<input type="text" name="billingZipCode" class="form-control" id="billingZipCode" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="creditCardNumber" class="col-md-12 control-label">Credit Card Number</label>
					<div class="col-md-12 form-group">
						<input type="text" name="creditCardNumber" class="form-control" id="creditCardNumber" maxlength="50"> 
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="nameOnCard" class="col-md-12 control-label">Name On Card</label>
					<div class="col-md-12 form-group">
						<input type="text" name="nameOnCard" class="form-control" id="nameOnCard" maxlength="50"> 
					</div>
				</div>
			</p>
			<p >
				<div class="row">
					<label for="creditCardMonth" class="col-md-6 control-label">Credit Card Exp Month</label>
					<div class="col-md-4 form-group">
						<select name="creditCardMonth" class="form-control" id="creditCardMonth">
							<cfloop from="1" to="12" index="index">
								<option value="#index#">#index#</option>
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
								<option value="#index#">#index#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</p>
			<p>
				<div class="row">
					<label for="ccvCodeclass" class="col-md-6 control-label">CCV Code</label>
					<div class="col-md-4 form-group">
						<input type="text" name="ccvCode" class="form-control" id="ccvCode" maxlength="5" value=""> 
					</div>
				</div>
			</p>
			<p>				
				<div class="row">
					<div id="error" class="col-md-12 alert alert-danger" style="display:none;">
						
					</div>
				</div>
			</p>				
		</form>
	</div><!-- ##dialog-service -->
	--->

	<div id="dialog-delete-customer" class="hide">
		<p> Are you sure you want to delete the Customer ?</p>
	</div>
</cfoutput>
<script>
	$('.delete-custumer').on('click', function() {		
		var data 				= {};
		data.custumerId 		= $(this).attr('id').split('_')[1];
		var $dialog 	= $('#dialog-delete-customer');	
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
							url: 'customers.cfc?method=deleteCustomer&returnFormat=plain',
							dataType: 'html',
							type: 'post',
							data: {
								Customer_ID: data.custumerId				
							},
							success: function(data){
								$dialog.dialog( "close" ); 
								window.location ='customers.cfm';
							}
						});
					} 
				}
			]
		});
	});
	
	$('#add-customer').on('click', function() {
		window.location.href 	= "editcustomer.cfm";
	});
	
	$('.edit-customer').on('click', function() {
		var customerId 			= $(this).attr('id').split('_');
		window.location.href 	= "editcustomer.cfm?cid="+customerId[1];
	});
</script>
<cfinclude template="footer.cfm">