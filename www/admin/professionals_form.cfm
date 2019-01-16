<!--- <cfdump var="#form#"><cfdump var="#arguments#"><cfdump var="#session#"><cfabort> --->
<cfparam name="variables.company_id" default="#session.company_id#">
<cfparam name="variables.professional_id" default="#session.Professional_ID#">
<cfif isDefined('form.professional_id')>
	<cfset variables.professional_id=form.professional_id>
<cfelseif isDefined('url.professional_id')>
	<cfset variables.professional_id=url.professional_id>
</cfif>
<!--- <cfinclude template="header.cfm"> --->

<script>
	/*
	fnSubmit = function(){

		if (!($("#Email_Address").val() == $("#Confirm_Email_Address").val())){
			alert('Email Address does not match.');
			$("#Email_Address").focus();
			return false;
		}


		if (!($("#Password").val() == $("#Confirm_Password").val())){
			alert('Password does not match.');
			$("#Password").focus();
			return false;
		}
		$( "#register_form" ).submit();
	}
	*/
</script>

	<!--- check to make sure user has permission to modify professional --->
<div class="col-sm-8">
<form class="form-horizontal" role="form" action="update_professional.cfm" method="POST"  id="register_form_professional"
		name="register_form_professional" enctype="multipart/form-data">
	<cfinclude template="professionals_form_elements.cfm">
	<!--- <input type="button" value="Submit" onclick="fnSubmit()"> --->
	<div class="form-group">
		<label class="col-sm-3 control-label">&nbsp;</label>
		<div class="col-sm-9">
			<button type="button" class="submitFrmDataprofessional btn btn-info btn-sm">
				<i class="icon-ok bigger-110"></i>
				Submit
			</button>
		</div>
	</div>
</form>
</div>
<div class="col-sm-8">
	<div class="form-group">
		<div id="professional_msg" class="alert alert-success hide">Profile updated successfully</div>
	</div>
</div>

<cfoutput>
<div id="dialog-changepassword" class="hide">
	<form id="changepass_form">
		<input type="hidden" name="professional_id" id="professional_id" value="#variables.professional_id#">
		<p>
			<div class="row">
				<label for="password" class="control-label" style="margin-left:13px;">New Password*</label>
				<div class="col-md-12 form-group">
					<input type="password" name="password" class="form-control required" id="password" maxlength="50" required>
				</div>
			</div>
			<div class="row">
				<label for="Confirm_Password" class="control-label" style="margin-left:13px;">Confirm password*</label>
				<div class="col-md-12 form-group">
					<input type="password" class="form-control required" id="Confirm_Password" name="Confirm_Password" maxlength="50" required>
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

<script src="assets/js/profile_professionals.js"></script>

<!--- </td>
<td>
<h2>Services</h2>
<cfinclude template="assign_services.cfm">
</td>
</tr></table> --->

<!--- <cfinclude template="footer.cfm">  --->