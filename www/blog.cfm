<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/"> --->
<cfparam name="url.startRow" type="integer" default="1">
<cfparam name="url.endRow" type="integer" default="5">
<cfinclude template="/customer_sites/include_blog.cfm">
<cfoutput>
		<cfinclude template="/customer_sites/customer_header.cfm">
		<cfinclude template="#templatePath#template_header.cfm">
		<cfinclude template="#templatePath#blog_content.cfm">			
		<cfinclude template="#templatePath#template_footer.cfm">
		</body>
	</html>
</cfoutput>