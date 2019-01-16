	<cfparam name="FORM.LocationName" default="" />
	<cfparam name="FORM.ContactName" default="" />
	<cfparam name="FORM.ContactPhone" default="" />
	<cfparam name="FORM.LocationAddress" default="" />
    <cfparam name="FORM.LocationAddress2" default="" />
    <cfparam name="FORM.LocationCity" default="" />
    <cfparam name="FORM.LocationState" default="" />
    <cfparam name="FORM.LocationPostal" default="" />
    <cfparam name="FORM.LocationPhone" default="" />
    <cfparam name="FORM.LocationFax" default="" />
    <cfparam name="FORM.Description" default="" />
    <cfparam name="FORM.PaymentMethodsList" default="" />
    <cfparam name="FORM.ParkingFees" default="" />
    <cfparam name="FORM.CancellationPolicy" default="" />
    <cfparam name="FORM.Languages" default="" />
    <cfparam name="FORM.Directions" default="" />
    <cfparam name="FORM.ServicesList" default="" />
    <cfparam name="FORM.SundayHoursFrom" default="" />
    <cfparam name="FORM.SundayHoursTo" default="" />
    <cfparam name="FORM.MondayHoursFrom" default="" />
    <cfparam name="FORM.MondayHoursTo" default="" />
    <cfparam name="FORM.TuesdayHoursFrom" default="" />
    <cfparam name="FORM.TuesdayHoursTo" default="" />
    <cfparam name="FORM.WednesdayHoursFrom" default="" />
    <cfparam name="FORM.WednesdayHoursTo" default="" />
    <cfparam name="FORM.ThursdayHoursFrom" default="" />
    <cfparam name="FORM.ThursdayHoursTo" default="" />
    <cfparam name="FORM.FridayHoursFrom" default="" />
    <cfparam name="FORM.FridayHoursTo" default="" />
    <cfparam name="FORM.SaturdayHoursFrom" default="" />
    <cfparam name="FORM.SaturdayHoursTo" default="" />                    

	<cfset Session.Form.LocationName = Trim(HTMLEditFormat(Form.LocationName)) />
	<cfset Session.Form.ContactName = Trim(HTMLEditFormat(Form.ContactName)) />
	<cfset Session.Form.ContactPhone = Trim(HTMLEditFormat(Form.ContactPhone)) />
	<cfset Session.Form.LocationAddress = Trim(HTMLEditFormat(Form.LocationAddress)) />
    <cfset Session.Form.LocationAddress2 = Trim(HTMLEditFormat(Form.LocationAddress2)) />
    <cfset Session.Form.LocationCity = Trim(HTMLEditFormat(Form.LocationCity)) />
    <cfset Session.Form.LocationState = Trim(HTMLEditFormat(Form.LocationState)) />
    <cfset Session.Form.LocationPostal = Trim(HTMLEditFormat(Form.LocationPostal)) />
    <cfset Session.Form.LocationPhone = Trim(HTMLEditFormat(Form.LocationPhone)) />
    <cfset Session.Form.LocationFax = Trim(HTMLEditFormat(Form.LocationFax)) />
    <cfset Session.Form.Description = Trim(HTMLEditFormat(Form.Description)) />
    <cfset Session.Form.PaymentMethodsList = Trim(HTMLEditFormat(Form.PaymentMethodsList)) />
    <cfset Session.Form.ServicesList = Trim(HTMLEditFormat(Form.ServicesList)) />
    <cfset Session.Form.ParkingFees = Trim(HTMLEditFormat(Form.ParkingFees)) />
    <cfset Session.Form.CancellationPolicy = Trim(HTMLEditFormat(Form.CancellationPolicy)) />
    <cfset Session.Form.Languages = Trim(HTMLEditFormat(Form.Languages)) />
    <cfset Session.Form.Directions = Trim(HTMLEditFormat(Form.Directions)) />
    <cfset Session.Form.ServicesList = Trim(HTMLEditFormat(Form.ServicesList)) />
    <cfset Session.Form.SundayHoursFrom = Form.SundayHoursFrom />
    <cfset Session.Form.SundayHoursTo = Form.SundayHoursTo />
    <cfset Session.Form.MondayHoursFrom = Form.MondayHoursFrom />
    <cfset Session.Form.MondayHoursTo = Form.MondayHoursTo />
    <cfset Session.Form.TuesdayHoursFrom = Form.TuesdayHoursFrom />
    <cfset Session.Form.TuesdayHoursTo = Form.TuesdayHoursTo />
    <cfset Session.Form.WednesdayHoursFrom = Form.WednesdayHoursFrom />
    <cfset Session.Form.WednesdayHoursTo = Form.WednesdayHoursTo />
    <cfset Session.Form.ThursdayHoursFrom = Form.ThursdayHoursFrom />
    <cfset Session.Form.ThursdayHoursTo = Form.ThursdayHoursTo />
    <cfset Session.Form.FridayHoursFrom = Form.FridayHoursFrom />
    <cfset Session.Form.FridayHoursTo = Form.FridayHoursTo />
    <cfset Session.Form.SaturdayHoursFrom = Form.SaturdayHoursFrom />
    <cfset Session.Form.SaturdayHoursTo = Form.SaturdayHoursTo />

	<cfif Session.Form.SundayHoursFrom neq 'Closed' and Session.Form.SundayHoursTo neq 'Closed'>
        <cfset variables.Sunday_Hours = Session.Form.SundayHoursFrom & ' to ' & Session.Form.SundayHoursTo />
    <cfelse>
        <cfset variables.Sunday_Hours="Closed">
        <cfset Session.Form.SundayHoursFrom = "Closed" />
        <cfset Session.Form.SundayHoursTo = "Closed" />
    </cfif>
    <cfif Session.Form.MondayHoursFrom neq 'Closed' and Session.Form.MondayHoursTo neq 'Closed'>
        <cfset variables.Monday_Hours = Session.Form.MondayHoursFrom & ' to ' & Session.Form.MondayHoursTo />
    <cfelse>
        <cfset variables.Monday_Hours="Closed">
        <cfset Session.Form.MondayHoursFrom = "Closed" />
        <cfset Session.Form.MondayHoursTo = "Closed" />    
    </cfif>
    <cfif Session.Form.TuesdayHoursFrom neq 'Closed' and Session.Form.TuesdayHoursTo neq 'Closed'>
        <cfset variables.Tuesday_Hours = Session.Form.TuesdayHoursFrom & ' to ' & Session.Form.TuesdayHoursTo />
    <cfelse>
        <cfset variables.Tuesday_Hours="Closed">
        <cfset Session.Form.TuesdayHoursFrom = "Closed" />
        <cfset Session.Form.TuesdayHoursTo = "Closed" />    
    </cfif>
    <cfif Session.Form.WednesdayHoursFrom neq 'Closed' and Session.Form.WednesdayHoursTo neq 'Closed'>
        <cfset variables.Wednesday_Hours = Session.Form.WednesdayHoursFrom & ' to ' & Session.Form.WednesdayHoursTo />
    <cfelse>
        <cfset variables.Wednesday_Hours="Closed">
        <cfset Session.Form.WednesdayHoursFrom = "Closed" />
        <cfset Session.Form.WednesdayHoursTo = "Closed" />    
    </cfif>
    <cfif Session.Form.ThursdayHoursFrom neq 'Closed' and Session.Form.ThursdayHoursTo neq 'Closed'>
        <cfset variables.Thursday_Hours = Session.Form.ThursdayHoursFrom & ' to ' & Session.Form.ThursdayHoursTo />
    <cfelse>
        <cfset variables.Thursday_Hours="Closed">
        <cfset Session.Form.ThursdayHoursFrom = "Closed" />
        <cfset Session.Form.ThursdayHoursTo = "Closed" />    
    </cfif>
    <cfif Session.Form.FridayHoursFrom neq 'Closed' and Session.Form.FridayHoursTo neq 'Closed'>
        <cfset variables.Friday_Hours = Session.Form.FridayHoursFrom & ' to ' & Session.Form.FridayHoursTo />
    <cfelse>
        <cfset variables.Friday_Hours="Closed">
        <cfset Session.Form.FridayHoursFrom = "Closed" />
        <cfset Session.Form.FridayHoursTo = "Closed" />    
    </cfif>
    <cfif Session.Form.SaturdayHoursFrom neq 'Closed' and Session.Form.SaturdayHoursTo neq 'Closed'>
        <cfset variables.Saturday_Hours = Session.Form.SaturdayHoursFrom & ' to ' & Session.Form.SaturdayHoursTo />
    <cfelse>
        <cfset variables.Saturday_Hours="Closed">
        <cfset Session.Form.SaturdayHoursFrom = "Closed" />
        <cfset Session.Form.SaturdayHoursTo = "Closed" />    
    </cfif>
    


	<cfinvoke component="location" method="UpdateLocation">
		<cfinvokeargument name="dsn" value="Salon">
		<cfinvokeargument name="Location_ID" value="#Session.Location_ID#">
		<cfinvokeargument name="Company_ID" value="#Session.company_id#">
        <cfinvokeargument name="Location_Name" value="#Session.Form.LocationName#">
		<cfinvokeargument name="Contact_Name" value="#Session.Form.ContactName#">
		<cfinvokeargument name="Contact_Phone" value="#Session.Form.ContactPhone#">
		<cfinvokeargument name="Location_Address" value="#Session.Form.LocationAddress#">
		<cfinvokeargument name="Location_Address2" value="#Session.Form.LocationAddress2#">
		<cfinvokeargument name="Location_City" value="#Session.Form.LocationCity#">
		<cfinvokeargument name="Location_State" value="#Session.Form.LocationState#">
		<cfinvokeargument name="Location_Postal" value="#Session.Form.LocationPostal#">
		<cfinvokeargument name="Location_Phone" value="#Session.Form.LocationPhone#">
		<cfinvokeargument name="Location_Fax" value="#Session.Form.LocationFax#">
		<cfinvokeargument name="Description" value="#Session.Form.Description#">
		<cfinvokeargument name="Directions" value="#Session.Form.Directions#">
		<cfinvokeargument name="Time_Zone_ID" value="0">
		<cfinvokeargument name="Sunday_Hours" value="#variables.Sunday_Hours#">
		<cfinvokeargument name="Monday_Hours" value="#variables.Monday_Hours#">
		<cfinvokeargument name="Tuesday_Hours" value="#variables.Tuesday_Hours#">
		<cfinvokeargument name="Wednesday_Hours" value="#variables.Wednesday_Hours#">
		<cfinvokeargument name="Thursday_Hours" value="#variables.Thursday_Hours#">
		<cfinvokeargument name="Friday_Hours" value="#variables.Friday_Hours#">
		<cfinvokeargument name="Saturday_Hours" value="#variables.Saturday_Hours#">
		<cfinvokeargument name="Payment_Methods_List" value="#Session.Form.PaymentMethodsList#">
		<cfinvokeargument name="Parking_Fees" value="#Session.Form.ParkingFees#">
		<cfinvokeargument name="Cancellation_Policy" value="#Session.Form.CancellationPolicy#">
		<cfinvokeargument name="Languages" value="#Session.Form.Languages#">
        <cfinvokeargument name="Services_List" value="#Session.Form.ServicesList#">
        
	</cfinvoke>   

	<cflocation url="index.cfm?msg=Completed Location update" />