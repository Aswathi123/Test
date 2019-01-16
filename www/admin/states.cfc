<cfcomponent displayname="States" hint="">
	<cffunction name="getStates" access="public" output="true" hint="Returns query of Services based on Professional_ID">
		<cfargument name="Selected_State" type="string" required="false" default=""> 
		<cfargument name="Select_Name" type="string" required="true"> 
		<cfargument name="IsRequired" type="boolean" required="false" default="false"> 
		
		<cfquery name="getStates" datasource="#request.dsn#">
			SELECT State_Name, Abbreviation 
			FROM States order by State_Name
		</cfquery>
		<select name="#arguments.Select_Name#" class="form-control" id="#arguments.Select_Name#" <cfif arguments.IsRequired>required</cfif>>
			<option value="">Choose State
			<cfoutput query="getStates">
				<option <cfif Abbreviation eq arguments.Selected_State>selected="selected"</cfif> value="#Abbreviation#">#State_Name#
			</cfoutput>
		</select>
	</cffunction>
</cfcomponent>