	<cfif not form.Location_ID gt 0>
		<cfinvoke component="location" method="InsertLocation" returnvariable="variables.Location_ID">
			<cfinvokeargument name="dsn" value="Salon"> 
		</cfinvoke>
	<cfelse>
		<cfset variables.Location_ID=form.Location_ID>
	</cfif>
	
	<cfloop from="1" to="7" index="dayindex">
		<cfif Evaluate('Begin_#dayindex#') neq 'Closed' AND Evaluate('End_#dayindex#') neq 'Closed'>
			<cfset "variables.#DayOfWeekAsString(dayindex)#_Hours"="#TimeFormat(Evaluate('Begin_#dayindex#'),'h:mm tt')# &mdash; #TimeFormat(Evaluate('End_#dayindex#'),'h:mm tt')#">
		<cfelse>
			<cfset "variables.#DayOfWeekAsString(dayindex)#_Hours"="Closed">
		</cfif>
	</cfloop>
	<cfset variables.Payment_Methods_List = ""/>
	<cfif structKeyExists(form, 'Payment_Methods_List')>
		<cfset variables.Payment_Methods_List = form.Payment_Methods_List />
	</cfif>
	
	<cfset variables.Services_List = ""/>
	<cfif structKeyExists(form, 'Services_List')>
		<cfset variables.Services_List = form.Services_List />
	</cfif>	
	
	
	
	<cfinvoke component="location" method="UpdateLocation">
		<cfinvokeargument name="dsn" value="Salon">
		<cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
		<cfinvokeargument name="Company_ID" value="#form.Company_ID#">
		<cfinvokeargument name="Contact_Name" value="#form.Contact_Name#">
		<cfinvokeargument name="Contact_Phone" value="#form.Contact_Phone#">
		<cfinvokeargument name="Location_Name" value="#form.Location_Name#">
		<cfinvokeargument name="Location_Address" value="#form.Location_Address#">
		<cfinvokeargument name="Location_Address2" value="#form.Location_Address2#">
		<cfinvokeargument name="Location_City" value="#form.Location_City#">
		<cfinvokeargument name="Location_State" value="#form.Location_State#">
		<cfinvokeargument name="Location_Postal" value="#form.Location_Postal#">
		<cfinvokeargument name="Location_Phone" value="#form.Location_Phone#">
		<cfinvokeargument name="Location_Fax" value="#form.Location_Fax#">
		<cfinvokeargument name="Description" value="#form.Description#">
		<cfinvokeargument name="Directions" value="#form.Directions#">
		<cfinvokeargument name="Time_Zone_ID" value="#form.Time_Zone_ID#">
		<cfinvokeargument name="Sunday_Hours" value="#variables.Sunday_Hours#">
		<cfinvokeargument name="Monday_Hours" value="#variables.Monday_Hours#">
		<cfinvokeargument name="Tuesday_Hours" value="#variables.Tuesday_Hours#">
		<cfinvokeargument name="Wednesday_Hours" value="#variables.Wednesday_Hours#">
		<cfinvokeargument name="Thursday_Hours" value="#variables.Thursday_Hours#">
		<cfinvokeargument name="Friday_Hours" value="#variables.Friday_Hours#">
		<cfinvokeargument name="Saturday_Hours" value="#variables.Saturday_Hours#">
		<cfinvokeargument name="Payment_Methods_List" value="#variables.Payment_Methods_List#">
		<cfinvokeargument name="Services_List" value="#variables.Services_List#">
		<cfinvokeargument name="Parking_Fees" value="#form.Parking_Fees#">
		<cfinvokeargument name="Cancellation_Policy" value="#form.Cancellation_Policy#">
		<cfinvokeargument name="Languages" value="#form.Languages#">
	</cfinvoke>
	<cfif structKeyExists(form, "location_tab") >
		<cflocation url="index.cfm?showTab=comment-tab" addtoken="no">
	<cfelse>
	<cflocation url="location_form.cfm" addtoken="no">
	</cfif>
	