<cfset AuthNetTools = createObject("component", "AuthNetTools").init()>

<cftransaction>
	<cfquery name="insertTransaction" datasource="#request.dsn#">
		INSERT INTO 
			Transactions
		(Company_ID)
		VALUES
		(<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />);
		SELECT @@IDENTITY AS 'Invoice_ID';
	</cfquery>
	<CFSET args = StructNew()>
	<!--- <cfset args.refId = variables.refId><!--- echoes in the response. not required. 20 chars max. ---> --->
	<cfset args.merchantCustomerId =session.Company_ID><!--- the merchant assigned customer id. --->
	<cfset args.customerdescription = "#form.Billing_First_Name# #Billing_Last_Name#"><!--- description of this customer. 255 chars max. --->
	<!--- <cfset args.email = variables.email><!--- customer email. 255 chars max. ---> --->
	
	<cfset args.testrequest = false><!--- true to validate in test mode. false to validate in live mode. --->
	<cfset args.firstname = form.Billing_First_Name><!--- billing first name --->
	<cfset args.lastname = form.Billing_Last_Name><!--- billing last name --->
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
	<!--- <cfdump var="#AuthnetReply#" abort="true"> --->
	<CFIF AuthnetReply.errorcode eq 0>
		<cfquery name="getPrice" datasource="#request.dsn#">
			SELECT 
				Price
			FROM
				Company_Prices
			WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<CFSET args = StructNew()>
		<!---  <cfset args.refId = variables.refId><!--- echoes in the response. not required. 20 chars max. ---> --->
		<cfset args.customerProfileId = AuthnetReply.customerProfileId><!--- customer profile id --->
		<cfset args.customerPaymentProfileId = AuthnetReply.customerPaymentProfileId><!--- Payment Profile Id. Must match original for capture, void, refund, etc. --->
		<cfset args.testrequest = false><!--- true to validate in test mode. false to validate in live mode. --->
		<cfset args.ipaddress = cgi.remote_addr><!--- don't change this. --->
		<cfset args.amount = getPrice.Price><!--- amount of sale. --->
		<cfset args.description = "Monthly Subscription"><!--- description of sale/transaction. --->
		<cfset args.invoice = insertTransaction.Invoice_ID><!--- invoice or order number. --->
		<cfset args.auth_type = "AUTH_CAPTURE">
		
		<cfset Transaction = AuthNetTools.createCustomerProfileTransaction(argumentCollection=args)>
		<cfset variables.Transaction_ID = ListGetAt(Transaction.RESULTSTRING,7)>
		<cfset variables.Response = ListGetAt(Transaction.RESULTSTRING,4)>
		<!---<cfdump var="#Transaction#" abort="true">  --->
	<cfif variables.Response eq 'This transaction has been approved.'>
		<cfquery name="updateCC" datasource="#request.dsn#">
			UPDATE 
				Companies
			SET
				CUSTOMERPROFILEID=<cfqueryparam value="#AuthnetReply.CUSTOMERPROFILEID#" cfsqltype="cf_sql_integer" />
				,customerPaymentProfileId = <cfqueryparam value="#AuthnetReply.customerPaymentProfileId#" cfsqltype="cf_sql_integer" />
				,Next_Billing_Date=<cfqueryparam value="#DateFormat(DateAdd("m",1,Now()),'dd-mmm-yyy')#" cfsqltype="cf_sql_date" />
			WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfquery name="insertTransaction" datasource="#request.dsn#">
			UPDATE 
				Transactions
			SET
				Transaction_ID=<cfqueryparam value="#variables.Transaction_ID#" cfsqltype="cf_sql_varchar" />
				,Amount_Paid=<cfqueryparam value="#getPrice.Price#" cfsqltype="cf_sql_float" /> 
			WHERE
				Invoice_ID = <cfqueryparam value="#insertTransaction.Invoice_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfquery name="updatePlan" datasource="#request.dsn#">
			UPDATE 
				Company_Prices 
			SET
				Company_Service_Plan_ID = 2
			WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	<cfelse>
		<cftransaction action="rollback">
	</cfif>
	<CFELSE>
		<cftransaction action="rollback">
	 	<cfset variables.Response = AuthnetReply.error>
	</CFIF>
</cftransaction>
<cfinclude template="header.cfm">
<cfoutput>
	<cfif variables.Response eq 'This transaction has been approved.'>
		<h2>Your account has been upgraded!</h2>
		You may now enjoy all of the features of your very own SalonWorks custom website including Online Billing, Photo Gallery, and Blog.

	<cfelse>
		
		<cfset variables.Billing_First_Name = form.Billing_First_Name>
		<cfset variables.Billing_Last_Name = form.Billing_Last_Name>
		<cfset variables.Billing_Address1 = form.Billing_Address1>
		<cfset variables.Billing_City = form.Billing_City>
		<cfset variables.Billing_State = form.Billing_State>
		<cfset variables.Billing_Zip = form.Billing_Zip>
		<cfset variables.Credit_Card = form.Credit_Card>
		<cfset variables.cardCode = form.cardCode>
		<cfset variables.expirationDate = form.expmonth&form.expyear>
		<h2>Upgrade Your Account</h2>
		<h4>Enable all available features by upgrading your account</h4>
		<div class="alert alert-block alert-success">#variables.Response#</div>
		<div class="col-sm-6">
			<form action="process_payment.cfm" method="post" id="register_form">
				<cfinclude template="billing_form_elements.cfm">
				<div class="col-sm-12">
					<input type="submit" value="Upgrade" class="btn btn-info btn-sm">
				</div>
			</form>
</div>
	</cfif>
	
</cfoutput>
<cfinclude template="footer.cfm">