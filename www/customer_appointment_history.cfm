<script src="js/vendor/jquery-3.3.1.slim.min.js"></script>
<script src="js/jquery.validate.js"></script>
<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/"> --->
<cfoutput>
	<cfset variables.PageTitle ="Appointment History">
	<cfset variables.title_no = 0>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<cfinclude template="#templatePath#customerAppointment_content.cfm">
<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>