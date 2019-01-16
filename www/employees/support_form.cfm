<cfparam name="variables.Employee_ID" default="#session.Employee_ID#">
<cfif isDefined('form.Employee_ID')>
	<cfset variables.Employee_ID = form.Employee_ID>
</cfif>

<cfinvoke component="login" method="getEmployee" returnvariable="qEmployee">
	<cfinvokeargument name="Employee_ID" value="#variables.Employee_ID#">
</cfinvoke>

<cfoutput>
<div id="dialog-support" class="hide">
	<form id="support_form">
		<h3>Need help? We're here to assist you!</h3>
		Fill out the form below and we will respond to your request promptly.
		<input type="hidden" name="Employee_ID" id="Employee_ID" value="#variables.Employee_ID#">
		<input type="hidden" name="Name" value="#qEmployee.first_name#">
		<input type="hidden" name="from" value="#qEmployee.email#"> 
		<p>
			<div class="row">
				<label for="Confirm_Password" class="col-md-6 control-label">Subject*</label>
				<div class="col-md-12 form-group">
					<input type="text" name="Subject" class="form-control required" maxlength="50" required>
				</div>
			</div>
			<div class="row">
				<label for="Confirm_Password" class="col-md-6 control-label">Message*</label>
				<div class="col-md-12 form-group">
					<textarea name="Message" rows="5" class="form-control required" required></textarea>
				</div>
			</div>
		
			<div id="supportMsg" class="alert" style="display:none;">
			</div>
			
		</div>
	</form>
</div><!-- dialog-support -->
</cfoutput>