<<!--- cfinclude template="header.cfm"> --->
<cfinvoke component="admin.services" method="getServices" returnvariable="qService">  
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
	 <cfinvokeargument name="Professional_ID" value="#session.Professional_ID#">
</cfinvoke>
<!--- <cfdump var="#qService#"><cfabort> --->
<!--- <cfinclude template="footer.cfm"> --->