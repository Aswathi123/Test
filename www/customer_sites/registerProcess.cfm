
<cfif NOT len(cgi.http_referer) OR NOT findnocase(cgi.http_host,cgi.http_referer) 
				Or Not IsDefined("Session.Form") OR Not IsDefined("Form.btnSubmitStep3")>
   <cflocation url="registerStep1.cfm" />
</cfif>

<cfset Session.Form.SundayHoursFrom = HTMLEditFormat(Form.SundayHoursFrom) />
<cfset Session.Form.SundayHoursTo = HTMLEditFormat(Form.SundayHoursTo) />
<cfset Session.Form.MondayHoursFrom = HTMLEditFormat(Form.MondayHoursFrom) />
<cfset Session.Form.MondayHoursTo = HTMLEditFormat(Form.MondayHoursTo) />
<cfset Session.Form.TuesdayHoursFrom = HTMLEditFormat(Form.TuesdayHoursFrom) />
<cfset Session.Form.TuesdayHoursTo = HTMLEditFormat(Form.TuesdayHoursTo) />
<cfset Session.Form.WednesdayHoursFrom = HTMLEditFormat(Form.WednesdayHoursFrom) />
<cfset Session.Form.WednesdayHoursTo = HTMLEditFormat(Form.WednesdayHoursTo) />
<cfset Session.Form.ThursdayHoursFrom = HTMLEditFormat(Form.ThursdayHoursFrom) />
<cfset Session.Form.ThursdayHoursTo = HTMLEditFormat(Form.ThursdayHoursTo) />
<cfset Session.Form.FridayHoursFrom = HTMLEditFormat(Form.FridayHoursFrom) />
<cfset Session.Form.FridayHoursTo = HTMLEditFormat(Form.FridayHoursTo) />
<cfset Session.Form.SaturdayHoursFrom = HTMLEditFormat(Form.SaturdayHoursFrom) />
<cfset Session.Form.SaturdayHoursTo = HTMLEditFormat(Form.SaturdayHoursTo) />
<cfset Session.Form.PaymentMethodsList = HTMLEditFormat(Form.PaymentMethodsList) />
<cfset Session.Form.ServicesList = HTMLEditFormat(Form.ServicesList) />



<cfset Session.Form.ParkingFees = HTMLEditFormat(Form.ParkingFees) />
<cfset Session.Form.CancellationPolicy = HTMLEditFormat(Form.CancellationPolicy) />
<cfset Session.Form.Languages = HTMLEditFormat(Form.Languages) />
<cfset Session.Form.LocationName = HTMLEditFormat(Form.LocationName) />
<cfset Session.Form.ContactName = HTMLEditFormat(Form.ContactName) />
<cfset Session.Form.ContactPhone = HTMLEditFormat(Form.ContactPhone) />
<cfset Session.Form.LocationAddress = HTMLEditFormat(Form.LocationAddress) />
<cfset Session.Form.LocationAddress2 = HTMLEditFormat(Form.LocationAddress2) />
<cfset Session.Form.LocationCity = HTMLEditFormat(Form.LocationCity) />
<cfset Session.Form.LocationState = HTMLEditFormat(Form.LocationState) />
<cfset Session.Form.LocationPostal = HTMLEditFormat(Form.LocationPostal) />
<cfset Session.Form.LocationPhone = HTMLEditFormat(Form.LocationPhone) />
<cfset Session.Form.LocationFax = HTMLEditFormat(Form.LocationFax) />
<cfset Session.Form.Description = HTMLEditFormat(Form.Description) />
<cfset Session.Form.Directions = HTMLEditFormat(Form.Directions) />
<cfdump var="#session.form#">

<!--- SAVE TO SWQL DATABASE --->
<cfinvoke component="admin.company" method="InsertCompany" returnvariable="variables.Company_ID"> 
	<cfinvokeargument name="Web_Address" value="#Session.Form.WebAddress#">
</cfinvoke>

<!--- Insert Location --->
<cfif Session.Form.SundayHoursFrom neq 'Closed' and Session.Form.SundayHoursTo neq 'Closed'>
	<cfset variables.Sunday_Hours = TimeFormat(Session.Form.SundayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.SundayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Sunday_Hours="Closed">
</cfif>
<cfif Session.Form.MondayHoursFrom neq 'Closed' and Session.Form.MondayHoursTo neq 'Closed'>
	<cfset variables.Monday_Hours = TimeFormat(Session.Form.MondayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.MondayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Monday_Hours="Closed">
</cfif>
<cfif Session.Form.TuesdayHoursFrom neq 'Closed' and Session.Form.TuesdayHoursTo neq 'Closed'>
	<cfset variables.Tuesday_Hours = TimeFormat(Session.Form.TuesdayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.TuesdayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Tuesday_Hours="Closed">
</cfif>
<cfif Session.Form.WednesdayHoursFrom neq 'Closed' and Session.Form.WednesdayHoursTo neq 'Closed'>
	<cfset variables.Wednesday_Hours = TimeFormat(Session.Form.WednesdayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.WednesdayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Wednesday_Hours="Closed">
</cfif>
<cfif Session.Form.ThursdayHoursFrom neq 'Closed' and Session.Form.ThursdayHoursTo neq 'Closed'>
	<cfset variables.Thursday_Hours = TimeFormat(Session.Form.ThursdayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.ThursdayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Thursday_Hours="Closed">
</cfif>
<cfif Session.Form.FridayHoursFrom neq 'Closed' and Session.Form.FridayHoursTo neq 'Closed'>
	<cfset variables.Friday_Hours = TimeFormat(Session.Form.FridayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.FridayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Friday_Hours="Closed">
</cfif>
<cfif Session.Form.SaturdayHoursFrom neq 'Closed' and Session.Form.SaturdayHoursTo neq 'Closed'>
	<cfset variables.Saturday_Hours = TimeFormat(Session.Form.SaturdayHoursFrom, "h:mmtt") & ' to ' & TimeFormat(Session.Form.SaturdayHoursTo, "h:mmtt") />
<cfelse>
	<cfset variables.Saturday_Hours="Closed">
</cfif>

<cfinvoke component="admin.location" method="InsertLocation" returnvariable="variables.Location_ID"> 
</cfinvoke>

<cfinvoke component="admin.location" method="UpdateLocation">
	<cfinvokeargument name="dsn" value="Salon">
	<cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
	<cfinvokeargument name="Location_Name" value="#Session.Form.LocationName#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
	<cfinvokeargument name="Contact_Phone" value="#Session.Form.ContactPhone#">
	<cfinvokeargument name="Contact_Name" value="#Session.Form.ContactName#"> 
	<cfinvokeargument name="Location_Address" value="#Session.Form.LocationAddress#">
	<cfinvokeargument name="Location_Address2" value="#Session.Form.LocationAddress2#">
	<cfinvokeargument name="Location_City" value="#Session.Form.LocationCity#">
	<cfinvokeargument name="Location_State" value="#Session.Form.LocationState#">
	<cfinvokeargument name="Location_Postal" value="#Session.Form.LocationPostal#">
	<cfinvokeargument name="Location_Phone" value="#Session.Form.LocationPhone#">
	<cfinvokeargument name="Location_Fax" value="#Session.Form.LocationFax#">
	<cfinvokeargument name="Description" value="#Session.Form.Description#">
	<cfinvokeargument name="Time_Zone_ID" value="">
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
	<cfinvokeargument name="Directions" value="#Session.Form.Directions#">
	<cfinvokeargument name="Services_List" value="#Session.Form.ServicesList#">
</cfinvoke>


<cfinvoke component="admin.professionals" method="InsertProfessional" returnvariable="variables.Professional_ID"> 
</cfinvoke>

<cfinvoke component="admin.professionals" method="UpdateProfessional">
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
	<cfinvokeargument name="Location_ID" value="#variables.Location_ID#"> 
	<!--- <cfinvokeargument name="Title_ID" value="#Session.Form.Title_ID#">  --->
	<cfinvokeargument name="First_Name" value="#Session.Form.FirstName#"> 
	<cfinvokeargument name="Last_Name" value="#Session.Form.LastName#"> 
	<cfinvokeargument name="License_No" value="#Session.Form.LicenseNumber#"> 
	<cfinvokeargument name="License_Expiration_Month" value="#Session.Form.LicenseExpirationMonth#"> 
	<cfinvokeargument name="License_Expiration_Year" value="#Session.Form.LicenseExpirationYear#"> 
	<cfinvokeargument name="License_State" value="#Session.Form.LicenseState#"> 
	<cfinvokeargument name="Home_Phone" value="#Session.Form.HomePhone#"> 
	<cfinvokeargument name="Mobile_Phone" value="#Session.Form.MobilePhone#"> 
	<cfinvokeargument name="Home_Address" value="#Session.Form.HomeAddress#"> 
	<cfinvokeargument name="Home_Address2" value="#Session.Form.HomeAddress2#"> 
	<cfinvokeargument name="Home_City" value="#Session.Form.HomeCity#"> 
	<cfinvokeargument name="Home_State" value="#Session.Form.HomeState#"> 
	<cfinvokeargument name="Home_Postal" value="#Session.Form.HomePostal#"> 
	<cfinvokeargument name="Email_Address" value="#Session.Form.EmailAddress#"> 
	<cfinvokeargument name="Password" value="#Session.Form.Password#"> 
	<cfinvokeargument name="Services_Offered" value="#Session.Form.ServicesOffered#"> 
	<cfinvokeargument name="Accredidations" value="#Session.Form.Accredidations#"> 
	<cfinvokeargument name="Bio" value="#Session.Form.Bio#"> 
	<cfinvokeargument name="Appointment_Increment" value="#Session.Form.Appointment_Increment#"> 
	<!--- <cfinvokeargument name="Active_Flag" value="#Session.Form.Active_Flag#">  --->
</cfinvoke>

<cfinvoke component="admin.company" method="UpdateCompany">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
	<cfinvokeargument name="Web_Address" value="#Session.Form.WebAddress#">
	<cfinvokeargument name="Company_Name" value="#Session.Form.CompanyName#">
	<cfinvokeargument name="Company_Address" value="#Session.Form.CompanyAddress#">
	<cfinvokeargument name="Company_Address2" value="#Session.Form.CompanyAddress2#">
	<cfinvokeargument name="Company_City" value="#Session.Form.CompanyCity#">
	<cfinvokeargument name="Company_State" value="#Session.Form.CompanyState#">
	<cfinvokeargument name="Company_Postal" value="#Session.Form.CompanyPostal#">
	<cfinvokeargument name="Company_Phone" value="#Session.Form.CompanyPhone#">
	<cfinvokeargument name="Company_Email" value="#Session.Form.CompanyEmail#">
	<cfinvokeargument name="Company_Fax" value="#Session.Form.CompanyFax#">
	<cfinvokeargument name="Company_Description" value="#Session.Form.CompanyDescription#">
	<cfinvokeargument name="Professional_Admin_ID" value="#variables.Professional_ID#">
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


<cfinvoke component="admin.login" method="login" returnvariable="qLogin">
		<cfinvokeargument name="Email_Address" value="#Session.Form.EmailAddress#">
		<cfinvokeargument name="Password" value="#Session.form.Password#">
	</cfinvoke>
	
<cfif qLogin.RecordCount GT 0>
		<cfset session.Professional_ID = qLogin.Professional_ID>
        <cfset session.Professional_ID  =  qLogin.Professional_ID />
        <cfset session.Location_ID = qLogin.Location_ID>
        <cfset session.First_Name = qLogin.First_Name>
        <cfset session.Last_Name = qLogin.Last_Name>
        <cfset session.Company_ID = qLogin.Company_ID>
        <cfset session.company_id = qLogin.Company_ID>
        <cfset session.Company_Admin = qLogin.Company_Admin>
        <cfinclude template="/admin/loadSessionForm.cfm" />
        
        <cflocation url="/admin/index.cfm" addtoken="no">
    </cfif>
<!--- <cflock timeout="20" scope="Session" type="Exclusive">
   <cfset StructDelete(Session, "ReachedPage") />
   <cfset StructDelete(Session, "Form") />
</cflock> --->

<!--- Automatically log into admin, you may not want to execute delete above --->
DONE REGISTRATION - Need to log professional to continue with setting up site...
