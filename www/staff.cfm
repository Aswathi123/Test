<cfset variables.PageTitle ="Our Staff">
<cfset variables.title_no = 4>
<cfset variables.webpathC = "/images/staff/" />
<cfset variables.pathC = expandPath(variables.webpathC) />
<!--- If the staff page is called from an invalid site go to home page --->
<cfif variables.Company_ID eq 0>
	<cflocation url="/" addtoken="no">
</cfif>
<cfinvoke component="admin.services" method="getServices" returnvariable="qServices">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 
	<cfinvokeargument name="Professional_ID" value="#qProfessional.Professional_ID#"> 
</cfinvoke>

<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/">
 ---><cfoutput>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<cfinclude template="#templatePath#header.cfm">
	<cfinclude template="#templatePath#service_content.cfm">
	<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>