<cfcomponent displayname="selectHours" hint="">
	<cffunction name="getHours" access="public" output="true">
		<cfargument name="Select_Name" type="string" required="false" default=""> 
		<cfargument name="Select_Value" type="string" required="true"> 
	
		<select name="#arguments.Select_Name#" id="#arguments.Select_Name#" style="width: 100px;">
			<option value="Closed">Closed</option>
            
		<cfloop from="6" to="22" index="i">
			<cfset meridiem="am">
			<cfif i gt 12>
				<cfset h=i-12>
				<cfset meridiem="pm">
			<cfelse>
				<cfset h=i>
			</cfif>
            
			<option value="#i#:00" <cfif arguments.Select_Value eq '#i#:00'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
			<option value="#i#:15" <cfif arguments.Select_Value eq '#i#:15'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
			<option value="#i#:30" <cfif arguments.Select_Value eq '#i#:30'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
			<option value="#i#:45" <cfif arguments.Select_Value eq '#i#:45'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
		</cfloop>
		</select>    
    
	</cffunction>
</cfcomponent>
