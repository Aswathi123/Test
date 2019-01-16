<cfset AuthNetTools = createObject("component", "AuthNetTools").init()>
<cfquery name="getcustomerProfileId" datasource="#request.dsn#">
	SELECT 
		customerProfileId
	FROM
		Companies
	WHERE
		Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>


<CFSET args = StructNew()>
<cfset args.customerProfileId = getcustomerProfileId.customerProfileId>

<cfset AuthnetReply = AuthNetTools.getCustomerProfile(argumentCollection=args)>
<cfdump var="#AuthnetReply#">
<CFIF AuthnetReply.errorcode eq 0>
 Success. Save records to database, etc.
<CFELSE>
 Error: #AuthnetReply.error#
 Hopefully this won't be seen in production.
</CFIF>
<cfset variables.Billing_First_Name=AuthnetReply.PAYMENTPROFILES.FIRSTNAME>
<cfset variables.Billing_Last_Name=AuthnetReply.PAYMENTPROFILES.LASTNAME>
<cfset variables.Billing_Address1=AuthnetReply.PAYMENTPROFILES.ADDRESS> 
<cfset variables.Billing_City=AuthnetReply.PAYMENTPROFILES.CITY>
<cfset variables.Billing_State=AuthnetReply.PAYMENTPROFILES.STATE>
<cfset variables.Billing_Zip=AuthnetReply.PAYMENTPROFILES.ZIP>
<cfset variables.Credit_Card=AuthnetReply.PAYMENTPROFILES.CARDNUMBER> 
<form action="update_billing.cfm" method="post">
	<cfinclude template="billing_form_elements.cfm">
</form>