
	<cfparam name="FORM.FirstName" default="" />
    <cfparam name="FORM.LastName" default="" />
    <cfparam name="FORM.LicenseNumber" default="" />
    <cfparam name="FORM.LicenseExpirationMonth" default="" />
    <cfparam name="FORM.LicenseExpirationYear" default="" />
    <cfparam name="FORM.LicenseState" default="" />
    <cfparam name="FORM.HomePhone" default="" />
    <cfparam name="FORM.MobilePhone" default="" />
    <cfparam name="FORM.HomeAddress" default="" />
    <cfparam name="FORM.HomeAddress2" default="" />
    <cfparam name="FORM.HomeCity" default="" />
    <cfparam name="FORM.HomePostal" default="" />
    <cfparam name="FORM.HomeState" default="" />
    <cfparam name="FORM.EmailAddress" default="" />
    <cfparam name="FORM.Password" default="" />
    <cfparam name="FORM.ServicesOffered" default="" />
    <cfparam name="FORM.Accredidations" default="" />
    <cfparam name="FORM.Bio" default="" />
    
    <cfset Session.Form.FirstName = HTMLEditFormat(Form.FirstName) />
    <cfset Session.Form.LastName = HTMLEditFormat(Form.LastName) />
    <cfset Session.Form.LicenseNumber = HTMLEditFormat(Form.LicenseNumber) />
    <cfset Session.Form.LicenseExpirationMonth = HTMLEditFormat(Form.LicenseExpirationMonth) />
    <cfset Session.Form.LicenseExpirationYear = HTMLEditFormat(Form.LicenseExpirationYear) />
    <cfset Session.Form.LicenseState = HTMLEditFormat(Form.LicenseState) />
    <cfset Session.Form.HomePhone = HTMLEditFormat(Form.HomePhone) />
    <cfset Session.Form.MobilePhone = HTMLEditFormat(Form.MobilePhone) />
    <cfset Session.Form.HomeAddress = HTMLEditFormat(Form.HomeAddress) />
    <cfset Session.Form.HomeAddress2 = HTMLEditFormat(Form.HomeAddress2) />
    <cfset Session.Form.HomeCity = HTMLEditFormat(Form.HomeCity) />
    <cfset Session.Form.HomePostal = HTMLEditFormat(Form.HomePostal) />
    <cfset Session.Form.HomeState = HTMLEditFormat(Form.HomeState) />
    <cfset Session.Form.EmailAddress = HTMLEditFormat(Form.EmailAddress) />
    <cfset Session.Form.Password = HTMLEditFormat(Form.Password) />
    <cfset Session.Form.ServicesOffered = HTMLEditFormat(Form.ServicesOffered) />
    <cfset Session.Form.Accredidations = HTMLEditFormat(Form.Accredidations) />
    <cfset Session.Form.Bio = HTMLEditFormat(Form.Bio) />   

	<cfinvoke component="professionals" method="UpdateProfessional">
		<cfinvokeargument name="dsn" value="SalonWorks">
		<cfinvokeargument name="Professional_ID" value="#session.Professional_ID#"> 
		<cfinvokeargument name="Location_ID" value="#session.Location_ID#"> 
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
		<!--- <cfinvokeargument name="Active_Flag" value="#Session.Form.Active_Flag#">  --->
	</cfinvoke>
	
	<cfif structKeyExists(form, "staffImageFile") AND Len(form.staffImageFile)>
		<cfset variables.FilePath = expandPath("../images/staff/") />

		<cffile action="upload" filefield="staffImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
		<cfset variables.FileExtention = "." & clientFileExt />
		<cfset variables.FileName = clientFile />
		
		<cfimage action="convert" source="#variables.FilePath##clientFile#" destination="#variables.FilePath##Session.Professional_ID#.jpg" overwrite="true" />
   		
		<cfimage action="resize" source="#variables.FilePath##Session.Professional_ID#.jpg" destination="#variables.FilePath##Session.Professional_ID#.jpg" width="300" height="300" overwrite="true" /> 	
	
		<cffile action="delete" file="#variables.FilePath##variables.FileName#" />
	</cfif>

	<cflocation url="index.cfm?msg=Completed Professional update" />