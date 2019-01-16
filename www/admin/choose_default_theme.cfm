<cfparam name="variables.company_id" default="#session.company_id#">
<cfinvoke component="themes" method="getDefault_Themes" returnvariable="qDefault"> 
</cfinvoke>

<cfdump var="#qDefault#">

<cfform action="assign_theme.cfm" method="post">
	<select name="Default_Theme_ID">
		<cfoutput query="qDefault">
		<option value="#Default_Theme_ID#">#Theme_Name# (#Default_Theme_ID#)
		</cfoutput>
	</select>
	<br>
	<input type="submit" value="Enter">
</cfform>