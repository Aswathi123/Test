<cfif structKeyExists(url,"template_id")>
		
		<cfset application.template_id=url.template_id>
<cfelse>	
	<cfset application.template_id = 1>
<!--- <cfelse>
	<cfif qCompany.Template_ID neq "">
		<cfset application.template_id = qCompany.Template_ID>
	<cfelse>
		<cfset application.template_id = 1>
	</cfif> --->
</cfif>
<cfinclude template="customer_header.cfm">
<cfinclude template="/templates/#NumberFormat(application.template_id,'0000')#/index.cfm">
<!--- <cfinclude template="/templates/#NumberFormat(variables.Template_ID,'0000')#/index.cfm"> --->