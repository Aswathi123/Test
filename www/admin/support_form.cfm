<cfparam name="variables.company_id" default="#session.company_id#">
<cfparam name="variables.professional_id" default="#session.Professional_ID#">
<cfif isDefined('form.professional_id')>
	<cfset variables.professional_id=form.professional_id>
<cfelseif isDefined('url.professional_id')>
	<cfset variables.professional_id=url.professional_id>
</cfif>

<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessional">
	<cfinvokeargument name="Professional_ID" value="#variables.professional_id#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>

<cfoutput>
<div id="dialog-support" class="hide">
	<form id="support_form">
		<h3>Need help? We're here to assist you!</h3>
		Fill out the form below and we will respond to your request promptly.
		<input type="hidden" name="professional_id_support" id="professional_id_support" value="#variables.professional_id#">
		<input type="hidden" name="Name" value="#qProfessional.first_name#">
		<input type="hidden" name="from" value="#qProfessional.email_address#"> 
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