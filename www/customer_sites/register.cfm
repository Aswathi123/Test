<cfinclude template="header.cfm">



<cfparam name="variables.company_id" default="0">
<cfparam name="variables.location_id" default="0">
<cfparam name="variables.professional_id" default="0">
<cfform action="process_registration.cfm" method="post">

<cflayout type="tab" name="registrationTabs">            
	<cflayoutarea title="Step 1. Professional Information" >
		<cfinclude template="admin/professionals_form_elements.cfm">
	</cflayoutarea>
	<cflayoutarea title="Step 2. Company Information">
		<cfinclude template="admin/company_form_elements.cfm">
	</cflayoutarea>
	<cflayoutarea title="Step 3. Location Information">
		<cfinclude template="admin/location_form_elements.cfm">
	<input type="submit" value="submit">
	</cflayoutarea>
</cflayout>
	
	
	
</cfform>
<cfinclude template="footer.cfm">