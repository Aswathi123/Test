	<cfparam name="FORM.WebAddress" default="" />
    <cfparam name="FORM.CompanyName" default="" />
    <cfparam name="FORM.CompanyAddress" default="" />
    <cfparam name="FORM.CompanyAddress2" default="" />
    <cfparam name="FORM.CompanyCity" default="" />
    <cfparam name="FORM.CompanyState" default="" />
    <cfparam name="FORM.CompanyPostal" default="" />
    <cfparam name="FORM.CompanyPhone" default="" />
    <cfparam name="FORM.CompanyEmail" default="" />
    <cfparam name="FORM.CompanyFax" default="" />
    <cfparam name="FORM.CompanyDescription" default="" />

	<cfset Session.Form.WebAddress = HTMLEditFormat(Form.WebAddress) />
    <cfset Session.Form.CompanyName = HTMLEditFormat(Form.CompanyName) />
    <cfset Session.Form.CompanyAddress = HTMLEditFormat(Form.CompanyAddress) />
    <cfset Session.Form.CompanyAddress2 = HTMLEditFormat(Form.CompanyAddress2) />
    <cfset Session.Form.CompanyCity = HTMLEditFormat(Form.CompanyCity) />
    <cfset Session.Form.CompanyState = HTMLEditFormat(Form.CompanyState) />
    <cfset Session.Form.CompanyPostal = HTMLEditFormat(Form.CompanyPostal) />
    <cfset Session.Form.CompanyPhone = HTMLEditFormat(Form.CompanyPhone) />
    <cfset Session.Form.CompanyEmail = HTMLEditFormat(Form.CompanyEmail) />
    <cfset Session.Form.CompanyFax = HTMLEditFormat(Form.CompanyFax) />
    <cfset Session.Form.CompanyDescription = HTMLEditFormat(Form.CompanyDescription) />
    
    
    <cfinvoke component="admin.company" method="UpdateCompany">
        <cfinvokeargument name="Company_ID" value="#session.company_id#">
        <cfinvokeargument name="Web_Address" value="#Session.form.WebAddress#">
        <cfinvokeargument name="Company_Name" value="#Session.form.CompanyName#">
        <cfinvokeargument name="Company_Address" value="#Session.form.CompanyAddress#">
        <cfinvokeargument name="Company_Address2" value="#Session.form.CompanyAddress2#">
        <cfinvokeargument name="Company_City" value="#Session.form.CompanyCity#">
        <cfinvokeargument name="Company_State" value="#Session.form.CompanyState#">
        <cfinvokeargument name="Company_Postal" value="#Session.form.CompanyPostal#">
        <cfinvokeargument name="Company_Phone" value="#Session.form.CompanyPhone#">
        <cfinvokeargument name="Company_Email" value="#Session.form.CompanyEmail#">
        <cfinvokeargument name="Company_Fax" value="#Session.form.CompanyFax#">
        <cfinvokeargument name="Company_Description" value="#Session.form.CompanyDescription#">
         <cfinvokeargument name="Professional_Admin_ID" value="#Session.Professional_ID#">
<!---         <cfinvokeargument name="Credit_Card_No" value="">
        <cfinvokeargument name="Name_On_Card" value="">
        <cfinvokeargument name="Billing_Address" value="">
        <cfinvokeargument name="Billing_Address2" value="">
        <cfinvokeargument name="Billing_City" value="">
        <cfinvokeargument name="Billing_State" value="">
        <cfinvokeargument name="Billing_Postal" value="">
        <cfinvokeargument name="Credit_Card_ExpMonth" value="">
        <cfinvokeargument name="Credit_Card_ExpYear" value="">
        <cfinvokeargument name="CVV_Code" value="">
        <cfinvokeargument name="Hosted" value="">  --->
    </cfinvoke>    

	<cflocation url="index.cfm?msg=completed company update" />