<cfset AuthNetTools = createObject("component", "AuthNetTools").init()>
<CFSET args = StructNew()>
<!--- <cfset args.refId = variables.refId><!--- echoes in the response. not required. 20 chars max. ---> --->
<cfset args.merchantCustomerId =session.Company_ID><!--- the merchant assigned customer id. --->
<cfset args.customerdescription = form.Billing_Name><!--- description of this customer. 255 chars max. --->
<!--- <cfset args.email = variables.email><!--- customer email. 255 chars max. ---> --->

<cfset args.testrequest = false><!--- true to validate in test mode. false to validate in live mode. --->
<cfset args.firstname = form.Billing_Name><!--- billing first name --->
<cfset args.lastname = form.Billing_Name><!--- billing last name --->
<!--- <cfset args.company = form.company>billing company --->
<cfset args.address = form.Billing_Address1><!--- billing address --->
<cfset args.city = form.Billing_City><!--- billing city --->
<cfset args.state = form.Billing_State><!--- billing state --->
<cfset args.zip = form.Billing_Zip><!--- billing zip --->
<cfset args.country = "US"><!--- billing country --->
<!--- <cfset args.phoneNumber = form.phoneNumber>billing phoneNumber (digits, - and () accepted) --->
<!---  <CFIF variables.cardNumber is not ""> --->
<cfset args.cardNumber = form.Credit_Card><!--- credit card number, all digits. --->
<cfset args.expirationDate = "#form.expmonth##form.expyear#"><!--- MMYY format. --->
<cfset args.cardCode = form.cardCode><!--- card security code. --->
<!---  <CFELSEIF variables.accountNumber is not "">
<cfset args.accountnumber = variables.accountnumber><!--- banking account number --->
<cfset args.accounttype = variables.accounttype><!--- checking, businessChecking, savings (case sensitive) --->
<cfset args.bankname = variables.bankname><!--- bank name --->
<cfset args.eCheckType = ""><!--- ARC,BOC,CCD,PPD,TEL,WEB (we default to WEB for internet transactions on personal accounts and CCD for internet transactions on business checking accounts). --->
<cfset args.nameonaccount = variables.nameonaccount><!--- name on account --->
<cfset args.routingnumber = variables.routingnumber><!--- 9 digit routing number. --->
 </CFIF> --->
<cfset AuthnetReply = AuthNetTools.createCustomerProfile(argumentCollection=args)>
<cfdump var="#AuthnetReply#">
<CFIF AuthnetReply.errorcode eq 0>
<cfquery name="updateCC" datasource="#request.dsn#">
	UPDATE 
		Companies
	SET
		CUSTOMERPROFILEID=<cfqueryparam value="#AuthnetReply.CUSTOMERPROFILEID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="updatePlan" datasource="#request.dsn#">
	UPDATE 
		Company_Prices 
	SET
		Company_Service_Plan_ID = 2
	WHERE
		Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>
<CFELSE>
 Error: #AuthnetReply.error# 
</CFIF>