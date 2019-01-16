<cfset AuthNetTools = createObject("component", "AuthNetTools").init()>
<cfset local.alertclass = 'alert-success'>
<cfset local.responseMsg = ''>
<cfset local.textAlert = 1><!---  text-success = 1--->
<cfset local.pageDirect = "">
<cfif structkeyExists(form,'cancelSubscription')>
	<cfset args = StructNew()>
	<cfset args.subscriptionId = form.subscriptionId />
	<cfif args.subscriptionId neq 0>
		<cfset cancelSubscription = AuthNetTools.ARBCancelSubscription(argumentCollection=args)>
		<cfif cancelSubscription.ERRORCODE eq 0 >
			<cfquery name="getTrialExpiration" datasource="#request.dsn#">
			   SELECT top 1
			   Trial_Expiration,subscriptionId
			   FROM
			   Companies
			   WHERE
			   Company_ID=
			   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="updateCC" datasource="#request.dsn#">
                UPDATE 
                    Companies
                SET subscription_status = <cfqueryparam value="0" cfsqltype="cf_sql_numeric" />
                    ,Next_Billing_Date=<cfqueryparam value="" cfsqltype="cf_sql_date" />
                WHERE
                    Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
            </cfquery>
           	<cfset trialExpiration = DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) />
           	<cfset Company_Service_Plan_ID = 2>
           	<cfif trialExpiration LT 0 >
           			<cfset Company_Service_Plan_ID = 1>
           	</cfif>	
            <cfquery name="updatePlan" datasource="#request.dsn#">
                UPDATE 
                    Company_Prices 
                SET
                    Company_Service_Plan_ID = #Company_Service_Plan_ID#
                WHERE
                    Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
            </cfquery>
			<cflocation url="cancellationSuccess.cfm" addtoken="false">
		</cfif>
	</cfif>
<cfelseif structkeyExists(form,'updateSubscription')>
	<cfset args = StructNew()>
	<cfset args.subscriptionId = form.subscriptionId />
	<cfset args.firstname = form.Billing_First_Name />
	<cfset args.lastname = form.Billing_Last_Name />
	<cfset args.address = form.Billing_Address1 />
	<cfset args.city = form.Billing_City />
	<cfset args.state = form.Billing_State />
	<cfset args.zip = form.Billing_Zip />
	<cfset args.cardNumber = form.Credit_Card />
	<cfset args.expirationDate = "#form.expmonth##form.expyear#" />
	<cfset args.cardCode = form.cardCode />
	<cfif args.subscriptionId neq 0>
		<cfset updateSubscription = AuthNetTools.ARBUpdateSubscription(argumentCollection=args)>
		<cfif updateSubscription.ERRORCODE eq 0 >
			<cfquery name="updateCC" datasource="#request.dsn#">
				UPDATE 
					Companies
				SET 
					subscriber_fname = <cfqueryparam value="#args.firstname#" cfsqltype="cf_sql_varchar" />,
					subscriber_lname = <cfqueryparam value="#args.lastname#" cfsqltype="cf_sql_varchar" />,
					Billing_Address = <cfqueryparam value="#args.address#" cfsqltype="cf_sql_varchar" />,
					Billing_City = <cfqueryparam value="#args.city#" cfsqltype="cf_sql_varchar" />,
					Billing_State = <cfqueryparam value="#args.state#" cfsqltype="cf_sql_varchar" />,
					Billing_Postal = <cfqueryparam value="#args.zip#" cfsqltype="cf_sql_varchar" />
				WHERE
					Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
					and subscriptionId = <cfqueryparam value="#args.subscriptionId#" cfsqltype="cf_sql_numeric" />
			</cfquery>

			<cfquery name="getTrialExpiration" datasource="#request.dsn#">
			   SELECT top 1
			   Trial_Expiration,subscriptionId
			   FROM
			   Companies
			   WHERE
			   Company_ID=
			   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
			</cfquery>
			<cfset local.responseMsg = 0> <!--- success --->
		<cfelseif updateSubscription.ERRORCODE eq 'E00013'>
			<cfset local.responseMsg = 13> <!--- error code --->
			<cfset local.textAlert = 0> <!--- text-danger = 0 --->
		<cfelseif updateSubscription.ERRORCODE eq 'E00027' >
			<cfset local.responseMsg = 27>
			<cfset local.textAlert = 0 >
		<cfelse>
		    <cfset local.responseMsg = 2>
		    <cfset local.textAlert = 0>
		</cfif>
		<cflocation url="updateSubscription.cfm?msg=#local.responseMsg#&altCode=#local.textAlert#"  addtoken="false">
	</cfif>
<cfelse>
	
	<cfset args = StructNew()>
	<cfset subscription = structNew()>
	<cfset variables.valErr = "">

	<cfset args.merchantCustomerId =session.Company_ID>
	<cfset args.customerdescription = form.Billing_First_Name & form.Billing_Last_Name>
	<cfset subscription.fname = form.Billing_First_Name>
	<cfset subscription.lname = form.Billing_Last_Name>
	<cfset subscription.start_date = DateFormat(now(),'yyyy-mm-dd')>
	<cfset subscription.Billing_Address = form.Billing_Address1>
	<cfset subscription.Billing_City = form.Billing_City>
	<cfset subscription.Billing_State = form.Billing_State>
	<cfset subscription.Billing_Postal = form.Billing_Zip>
	<cfset args.testrequest = false>
	<cfset args.firstname = form.Billing_First_Name>
	<cfset args.lastname = form.Billing_Last_Name>
	<cfset args.address = form.Billing_Address1>
	<cfset args.city = form.Billing_City>
	<cfset args.state = form.Billing_State>
	<cfset args.zip = form.Billing_Zip>
	<cfset args.country = "US">
	<cfset args.cardNumber = form.Credit_Card><!--- credit card number, all digits. --->
	<cfset args.expirationDate = "#form.expmonth##form.expyear#"><!--- MMYY format. --->
	<cfset subscription.card_expiry = "20#right(args.expirationDate, 2)#-#left(args.expirationDate, 2)#">
	<cfset args.cardCode = form.cardCode><!--- card security code. --->
	<!---  <CFELSEIF variables.accountNumber is not "">
	<cfset args.accountnumber = variables.accountnumber><!--- banking account number --->
	<cfset args.accounttype = variables.accounttype><!--- checking, businessChecking, savings (case sensitive) --->
	<cfset args.bankname = variables.bankname><!--- bank name --->
	<cfset args.eCheckType = ""><!--- ARC,BOC,CCD,PPD,TEL,WEB (we default to WEB for internet transactions on personal accounts and CCD for internet transactions on business checking accounts). --->
	<cfset args.nameonaccount = variables.nameonaccount><!--- name on account --->
	<cfset args.routingnumber = variables.routingnumber><!--- 9 digit routing number. --->
	 </CFIF> --->

	<cfset args.startDate = DateFormat(now(),'yyyy-mm-dd')>
	<cfset args.length = 1>
	<cfset args.unit = "months">
	
	<cfquery name="getPrice" datasource="#request.dsn#">
		SELECT 
				Price
		FROM
				Company_Prices
		WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cfif getPrice.recordCount neq 1>
		
		<cfquery name="insertPlan" datasource="#request.dsn#">
				INSERT INTO Company_Prices
				(Company_ID, Company_Service_Plan_ID, Price)
					VALUES
				(#session.Company_ID#,2,49.99)
		</cfquery>
	</cfif>
	
	<cfset AuthnetReply = StructNew()>
	<cfset variables.Response = "" >
	<cfset local.responseErrMsg = "">
	<cfset local.transactiontype = 1 >
	<cfif local.transactiontype neq 1 >
		<cfset AuthnetReply = AuthNetTools.createCustomerProfile(argumentCollection=args)>
		
		<CFIF AuthnetReply.errorcode eq 0>
			
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
		<CFELSE>
			<!--- <cftransaction action="rollback"> --->
		 	<cfset variables.Response = AuthnetReply.error>
		</CFIF>

	<cfelse>		
		<cfset args.amount = getPrice.Price><!--- amount of sale. --->
		<cfset args.description = "Monthly Subscription"><!--- description of sale/transaction. --->
		<!--- <cfset args.invoice = insertTransaction.Invoice_ID> --->
		<cfset Transaction = AuthNetTools.ARBCreateSubscription(argumentCollection=args)>
		
	    <cfset local.code = Transaction.ERRORCODE >
	    <cfset local.responseErrMsg = Transaction.ERROR>
	    <cfif local.code eq 0>
	    	<cfset variables.Response = "Successfully Subscribed!!!" >
	        <cfset local.subscriptionId = Transaction.subscriptionId >
	        <cfset local.cutomeridpaymentid = Transaction.XMLRESPONSE.ARBCreateSubscriptionResponse.profile.customerPaymentProfileId.XmlText >
	        <cfset local.customerProfileId = Transaction.XMLRESPONSE.ARBCreateSubscriptionResponse.profile.customerProfileId.XmlText >
	   </cfif>
	</cfif>
	<cfif variables.Response eq 'This transaction has been approved.' or ((structKeyExists(local,'code') and local.code eq 0))>
		<!--- Setting the billing data into companies tbl --->
		<cfquery name="updateCC" datasource="#request.dsn#">
			UPDATE 
				Companies
			SET 
			<cfif structKeyExists(local, 'subscriptionId')>
				subscriptionId = <cfqueryparam value="#local.subscriptionId#" cfsqltype="cf_sql_numeric" />,
			</cfif>
				CUSTOMERPROFILEID=<cfif structKeyExists(AuthnetReply, 'CUSTOMERPROFILEID')>
					<cfqueryparam value="#AuthnetReply.CUSTOMERPROFILEID#" cfsqltype="cf_sql_integer" />
				<cfelse>
					<cfqueryparam value="#local.customerProfileId#" cfsqltype="cf_sql_integer" />
				</cfif>,
				customerPaymentProfileId = <cfif structKeyExists(AuthnetReply, 'CUSTOMERPROFILEID')>
					<cfqueryparam value="#AuthnetReply.customerPaymentProfileId#" cfsqltype="cf_sql_integer" />
				<cfelse>
					<cfqueryparam value="#local.cutomeridpaymentid#" cfsqltype="cf_sql_integer" />
				</cfif>,
				subscriber_fname = <cfqueryparam value="#subscription.fname#" cfsqltype="cf_sql_varchar" />,
				subscriber_lname = <cfqueryparam value="#subscription.lname#" cfsqltype="cf_sql_varchar" />,
				subscriber_start_date = <cfqueryparam value="#subscription.start_date#" cfsqltype="cf_sql_date" />,
				card_expry_date = <cfqueryparam value="#subscription.card_expiry#" cfsqltype="cf_sql_date" />,
				subscription_status = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
				Billing_Address = <cfqueryparam value="#subscription.Billing_Address#" cfsqltype="cf_sql_varchar" />,
				Billing_City = <cfqueryparam value="#subscription.Billing_City#" cfsqltype="cf_sql_varchar" />,
				Billing_State = <cfqueryparam value="#subscription.Billing_State#" cfsqltype="cf_sql_varchar" />,
				Billing_Postal = <cfqueryparam value="#subscription.Billing_Postal#" cfsqltype="cf_sql_varchar" />,
				Next_Billing_Date=<cfqueryparam value="#DateFormat(DateAdd("m",1,subscription.start_date),'dd-mmm-yyy')#" cfsqltype="cf_sql_date" />
			WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfquery name="updatePlan" datasource="#request.dsn#">
			UPDATE 
				Company_Prices 
			SET
				Company_Service_Plan_ID = 3
			WHERE
				Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset local.responseMsg = 0> <!--- success --->
		<cfset local.pageDirect = "updateSubscription.cfm">
	<cfelseif ((structKeyExists(local,'code') and local.code eq 'E00013')) >
		<cfset local.responseMsg = 13> <!--- error code --->
		<cfset local.textAlert = 0> <!--- text-danger = 0 --->
		<cfset local.pageDirect = "upgrade.cfm">
	<cfelseif ((structKeyExists(local,'code') and local.code eq 'E00027')) >
		<cfset local.responseMsg = 27>
		<cfset local.textAlert = 0 >
		<cfset local.pageDirect = "upgrade.cfm">
	<cfelse>
		<cfset local.responseMsg = 2>
	    <cfset local.textAlert = 0>
	    <cfset local.pageDirect = "upgrade.cfm">
	</cfif>
	<cflocation url="#local.pageDirect#?msg=#local.responseMsg#&altCode=#local.textAlert#&type=create"  addtoken="false">
</cfif>
