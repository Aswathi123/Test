<!--- <cfinclude template="header.cfm"> --->
<cfparam name="variables.location_id" default=0>
<cfparam name="variables.Company_ID" default=0>
<cfif isDefined('form.location_id')>
	<cfset variables.location_id=form.location_id>
<cfelseif isDefined('url.location_id')>
	<cfset variables.location_id=url.location_id>
</cfif>

<cfif isDefined('session.Company_ID')>
	<cfset variables.Company_ID=session.Company_ID>
</cfif>

<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
	<cfinvokeargument name="Location_ID" value="#variables.location_id#">
</cfinvoke>
<cfoutput>
<div class="col-sm-8">
<form action="update_location.cfm" class="form-horizontal" id="register_form_location" name="register_form_location" method="post">
	<cfinclude template="location_form_elements.cfm">
<!--- <cfif FindNoCase('/admin/',cgi.SCRIPT_NAME)>
	<input type="submit" value="Submit">
</cfif> --->
	<div class="form-group">
		<label class="col-sm-3 control-label">&nbsp;</label>
		<div class="col-sm-9">
			<button type="button" class="submitFrmData btn btn-info btn-sm">
				<i class="icon-ok bigger-110"></i>
				Submit
			</button>
		</div>
	</div>
</form>
</div>
</cfoutput>

<div class="col-sm-8">
	<div class="form-group">
		<div id="location_msg" class="alert"></div>
	</div>
</div>

<script src="assets/js/profile_location.js"></script>
<!--- <cfinclude template="footer.cfm">  --->