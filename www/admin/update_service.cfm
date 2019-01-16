<cfif not form.Service_ID gt 0>
	<cfinvoke component="services" method="InsertService" returnvariable="variables.Service_ID">
		<cfinvokeargument name="Service_Name" value="#form.Service_Name#">
		<cfinvokeargument name="Service_Description" value="#form.Service_Description#">
		<cfinvokeargument name="Price" value="#form.Price#">
		<cfinvokeargument name="Service_Time" value="#form.Service_Time#">
		<cfinvokeargument name="Service_ID" value="#form.Service_ID#">
		<cfinvokeargument name="Company_ID" value="#form.Company_ID#">
		<cfinvokeargument name="Professional_ID" value="#session.Professional_ID#">
	</cfinvoke>
<cfelse>
	<cfinvoke component="services" method="UpdateService" returnvariable="variables.Service_ID">
		<cfinvokeargument name="Service_Name" value="#form.Service_Name#">
		<cfinvokeargument name="Service_Description" value="#form.Service_Description#">
		<cfinvokeargument name="Price" value="#form.Price#">
		<cfinvokeargument name="Service_Time" value="#form.Service_Time#">
		<cfinvokeargument name="Service_ID" value="#form.Service_ID#">
		<cfinvokeargument name="Company_ID" value="#form.Company_ID#">
		<cfinvokeargument name="Professional_ID" value="#session.Professional_ID#">
	</cfinvoke>

</cfif>
<cfif structKeyExists(form, "service_tab") >
	<cflocation url="index.cfm?showTab=service-tab" addtoken="no">
<cfelse>
<cflocation url="professionals_form.cfm">
</cfif>
