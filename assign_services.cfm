<cfif isDefined('form.Professional_ID') and isDefined('form.service_id_list')>
	<cfinvoke component="services" method="DeleteAssignment">
		<cfinvokeargument name="Professional_ID" value="#form.Professional_ID#"> 
	</cfinvoke>
	<cfloop list="#form.service_id_list#" index="index">
		<cfinvoke component="services" method="AssignService">
			<cfinvokeargument name="Professional_ID" value="#form.Professional_ID#"> 
			<cfinvokeargument name="Service_ID" value="#index#"> 
		</cfinvoke>
	</cfloop>
</cfif>

<cfparam name="variables.company_id" default=#session.company_id#>
<cfparam name="variables.professional_id" default=#session.professional_id#>
<!--- URL and FORM Company_ID can only be used by adminsitrator --->
<cfif isDefined('form.professional_id')>
	<cfset variables.professional_id=form.professional_id>
<cfelseif isDefined('url.professional_id')>
	<cfset variables.professional_id=url.professional_id>
</cfif> 
<cfinvoke component="services" method="getServices" returnvariable="qServices">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
</cfinvoke>

<!--- <cfdump var="#qServices#"> --->

<cfoutput>
	<p><a href="services_form.cfm?Professional_ID=#variables.Professional_ID#" rel="0" class="newWindow">Add A Service</a></p>
</cfoutput>
<form action="assign_services.cfm" method="post">
<cfoutput query="qServices">
	<!--- <input type="checkbox" name="service_id_list" value="#qServices.Service_ID#" <cfif qServices.Professional_ID eq variables.Professional_ID>checked</cfif>> ---> <a href="services_form.cfm?Professional_ID=#variables.Professional_ID#&Service_ID=#qServices.Service_ID#">#Service_Name#</a> (#DollarFormat(price)#)<br>
</cfoutput>
<cfoutput><input type="hidden" name="Professional_ID" value="#variables.Professional_ID#"> </cfoutput>

<input type="submit" value="Enter">
</form>