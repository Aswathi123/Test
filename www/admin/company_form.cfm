<!--- <cfinclude template="header.cfm"> --->
<cfparam name="variables.company_id" default="#session.company_id#">
<!--- URL and FORM Company_ID can only be used by adminsitrator --->
<cfif isDefined('form.company_id')>
	<cfset variables.company_id=form.company_id>
<cfelseif isDefined('url.company_id')>
	<cfset variables.company_id=url.company_id>
</cfif>

<div class="col-sm-8">
<form action="update_company.cfm" method="post" class="form-horizontal" role="form"
		id="register_form_company" name="register_form_company" enctype="multipart/form-data">
	<cfinclude template="company_form_elements.cfm">

	<div class="form-group">
		<label class="col-sm-3 control-label">&nbsp;</label>
		<div class="col-sm-9">
			<button type="button" class="submitFrmDataCompany btn btn-info btn-sm">
				<i class="icon-ok bigger-110"></i>
				Submit
			</button>
		</div>
	</div>
</form>
</div>
<div class="col-sm-8">
	<div class="form-group">
		<div id="company_msg" class="alert alert-success hide" >Company updated successfully</div>
	</div>
</div>

<script src="assets/js/profile_company.js"></script>
<!--- <cfinclude template="footer.cfm">  --->