<!--- Insert Company --->
<cfparam name="form.Payment_Methods_List" default="">
<cfinvoke component="admin.company" method="InsertCompany" returnvariable="variables.Company_ID"> 
	<cfinvokeargument name="Web_Address" value="#form.Web_Address#">
</cfinvoke>
<cfinvoke component="admin.company" method="UpdateCompany">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
	<cfinvokeargument name="Web_Address" value="#form.Web_Address#">
	<cfinvokeargument name="Company_Name" value="#form.Company_Name#">
	<cfinvokeargument name="Company_Address" value="#form.Company_Address#">
	<cfinvokeargument name="Company_Address2" value="#form.Company_Address2#">
	<cfinvokeargument name="Company_City" value="#form.Company_City#">
	<cfinvokeargument name="Company_State" value="#form.Company_State#">
	<cfinvokeargument name="Company_Postal" value="#form.Company_Postal#">
	<cfinvokeargument name="Company_Phone" value="#form.Company_Phone#">
	<cfinvokeargument name="Company_Email" value="#form.Company_Email#">
	<cfinvokeargument name="Company_Fax" value="#form.Company_Fax#">
	<cfinvokeargument name="Company_Description" value="#form.Company_Description#">
	<cfinvokeargument name="Professional_Admin_ID" value="">
	<cfinvokeargument name="Credit_Card_No" value="">
	<cfinvokeargument name="Name_On_Card" value="">
	<cfinvokeargument name="Billing_Address" value="">
	<cfinvokeargument name="Billing_Address2" value="">
	<cfinvokeargument name="Billing_City" value="">
	<cfinvokeargument name="Billing_State" value="">
	<cfinvokeargument name="Billing_Postal" value="">
	<cfinvokeargument name="Credit_Card_ExpMonth" value="">
	<cfinvokeargument name="Credit_Card_ExpYear" value="">
	<cfinvokeargument name="CVV_Code" value="">
	<cfinvokeargument name="Hosted" value=""> 
</cfinvoke>



<!--- Insert Location --->
<cfif form.Begin_1 neq 'Closed' and form.End_1 neq 'Closed'>
	<cfset variables.Sunday_Hours = TimeFormat(form.Begin_1,'h:mm tt')&' to '&TimeFormat(form.End_1,'h:mm tt')>
<cfelse>
	<cfset variables.Sunday_Hours="Closed">
</cfif>
<cfif form.Begin_2 neq 'Closed' and form.End_2 neq 'Closed'>
	<cfset variables.Monday_Hours = TimeFormat(form.Begin_2,'h:mm tt')&' to '&TimeFormat(form.End_2,'h:mm tt')>
<cfelse>
	<cfset variables.Monday_Hours="Closed">
</cfif>
<cfif form.Begin_3 neq 'Closed' and form.End_3 neq 'Closed'>
	<cfset variables.Tuesday_Hours = TimeFormat(form.Begin_3,'h:mm tt')&' to '&TimeFormat(form.End_3,'h:mm tt')>
<cfelse>
	<cfset variables.Tuesday_Hours="Closed">
</cfif>
<cfif form.Begin_4 neq 'Closed' and form.End_4 neq 'Closed'>
	<cfset variables.Wednesday_Hours = TimeFormat(form.Begin_4,'h:mm tt')&' to '&TimeFormat(form.End_4,'h:mm tt')>
<cfelse>
	<cfset variables.Wednesday_Hours="Closed">
</cfif>
<cfif form.Begin_5 neq 'Closed' and form.End_5 neq 'Closed'>
	<cfset variables.Thursday_Hours = TimeFormat(form.Begin_5,'h:mm tt')&' to '&TimeFormat(form.End_5,'h:mm tt')>
<cfelse>
	<cfset variables.Thursday_Hours="Closed">
</cfif>
<cfif form.Begin_6 neq 'Closed' and form.End_6 neq 'Closed'>
	<cfset variables.Friday_Hours = TimeFormat(form.Begin_6,'h:mm tt')&' to '&TimeFormat(form.End_6,'h:mm tt')>
<cfelse>
	<cfset variables.Friday_Hours="Closed">
</cfif>
<cfif form.Begin_7 neq 'Closed' and form.End_7 neq 'Closed'>
	<cfset variables.Saturday_Hours = TimeFormat(form.Begin_7,'h:mm tt')&' to '&TimeFormat(form.End_7,'h:mm tt')>
<cfelse>
	<cfset variables.Saturday_Hours="Closed">
</cfif>

<cfinvoke component="admin.location" method="InsertLocation" returnvariable="variables.Location_ID"> 
</cfinvoke>
<cfinvoke component="admin.location" method="UpdateLocation">
	<cfinvokeargument name="dsn" value="Salon">
	<cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
	<cfinvokeargument name="Contact_Phone" value="#form.Contact_Phone#">
	<cfinvokeargument name="Contact_Name" value="#form.First_Name# #form.Last_Name#"> 
	<cfinvokeargument name="Location_Address" value="#form.Location_Address#">
	<cfinvokeargument name="Location_Address2" value="#form.Location_Address2#">
	<cfinvokeargument name="Location_City" value="#form.Location_City#">
	<cfinvokeargument name="Location_State" value="#form.Location_State#">
	<cfinvokeargument name="Location_Postal" value="#form.Location_Postal#">
	<cfinvokeargument name="Location_Phone" value="#form.Location_Phone#">
	<cfinvokeargument name="Location_Fax" value="#form.Location_Fax#">
	<cfinvokeargument name="Description" value="#form.Description#">
	<cfinvokeargument name="Time_Zone_ID" value="">
	<cfinvokeargument name="Sunday_Hours" value="#variables.Sunday_Hours#">
	<cfinvokeargument name="Monday_Hours" value="#variables.Monday_Hours#">
	<cfinvokeargument name="Tuesday_Hours" value="#variables.Tuesday_Hours#">
	<cfinvokeargument name="Wednesday_Hours" value="#variables.Wednesday_Hours#">
	<cfinvokeargument name="Thursday_Hours" value="#variables.Thursday_Hours#">
	<cfinvokeargument name="Friday_Hours" value="#variables.Friday_Hours#">
	<cfinvokeargument name="Saturday_Hours" value="#variables.Saturday_Hours#">
	<cfinvokeargument name="Payment_Methods_List" value="#form.Payment_Methods_List#">
	<cfinvokeargument name="Parking_Fees" value="#form.Parking_Fees#">
	<cfinvokeargument name="Cancellation_Policy" value="#form.Cancellation_Policy#">
	<cfinvokeargument name="Languages" value="#form.Languages#">
	<cfinvokeargument name="Directions" value="#form.Directions#">
	<cfinvokeargument name="Services_List" value="">
</cfinvoke>

	
<!--- Insert Professional --->

<cfinvoke component="admin.professionals" method="InsertProfessional" returnvariable="variables.Professional_ID"> 
</cfinvoke>

<cfinvoke component="admin.professionals" method="UpdateProfessional">
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
	<cfinvokeargument name="Location_ID" value="#variables.Location_ID#"> 
	<!--- <cfinvokeargument name="Title_ID" value="#form.Title_ID#">  --->
	<cfinvokeargument name="First_Name" value="#form.First_Name#"> 
	<cfinvokeargument name="Last_Name" value="#form.Last_Name#"> 
	<cfinvokeargument name="License_No" value="#form.License_No#"> 
	<cfinvokeargument name="License_Expiration_Month" value="#form.License_Expiration_Month#"> 
	<cfinvokeargument name="License_Expiration_Year" value="#form.License_Expiration_Year#"> 
	<cfinvokeargument name="License_State" value="#form.License_State#"> 
	<cfinvokeargument name="Home_Phone" value="#form.Home_Phone#"> 
	<cfinvokeargument name="Mobile_Phone" value="#form.Mobile_Phone#"> 
	<cfinvokeargument name="Home_Address" value="#form.Home_Address#"> 
	<cfinvokeargument name="Home_Address2" value="#form.Home_Address2#"> 
	<cfinvokeargument name="Home_City" value="#form.Home_City#"> 
	<cfinvokeargument name="Home_State" value="#form.Home_State#"> 
	<cfinvokeargument name="Home_Postal" value="#form.Home_Postal#"> 
	<cfinvokeargument name="Email_Address" value="#form.Email_Address#"> 
	<cfinvokeargument name="Password" value="#form.Password#"> 
	<cfinvokeargument name="Services_Offered" value="#form.Services_Offered#"> 
	<cfinvokeargument name="Accredidations" value="#form.Accredidations#"> 
	<cfinvokeargument name="Bio" value="#form.Bio#"> 
	<cfinvokeargument name="Appointment_Increment" value="#Form.Appointment_Increment#"> 
	<!--- <cfinvokeargument name="Active_Flag" value="#form.Active_Flag#">  --->
</cfinvoke>