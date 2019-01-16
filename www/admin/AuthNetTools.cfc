<!--- 
AuthNetTools.cfc
Author: Bud Schneehagen; Tropical Web Creations, Inc.; buddy@twcreations.com
http://www.cf-ezcart.com/        http://www.twcreations.com/
--->

<cfcomponent displayname="AuthNetTools" hint="Authorize.net credit card processing">

	<cffunction access="public" name="init" returntype="AuthNetTools" output="false">
<cfargument name="developmentserver" type="boolean" default="false">
<cfargument name="login" type="string" default="">
<cfargument name="transactionkey" type="string" default="">
<cfset variables.defaultXmlFormat = "true" /><!--- If you are already encoding your input arguments with xmlformat, set this to false. This can be set at each method also. --->
<CFIF arguments.developmentserver>
<!--- development server. use with a developers account only. use with testrequest false for best results --->
<cfset variables.url_gateway = "https://test.authorize.net/gateway/transact.dll">
<cfset variables.url_CIM_ARB = "https://apitest.authorize.net/xml/v1/request.api">
<cfset variables.login = "7xG5qVRm65k"><!--- may be passed in as an argument to the init method, or entered manually here, or passed in as an argument with each individual method to overwrite what is entered here. --->
<cfset variables.transactionkey = "97p5B2MD2v4v7tA3"><!--- may be passed in as an argument to the init method, or entered manually here, or passed in as an argument with each individual method to overwrite what is entered here. --->
<cfset variables.auth_type = "AUTH_ONLY"><!--- may be passed in as an argument. --->
<cfset variables.ADC_Delim_Character = "|"><!--- must match Direct Response setting in authorize.net settings. May be passed in as an argument if necessary but there MUST be a delimiter. --->
<cfset variables.Encapsulate_Character = '"'><!--- must match Direct Response setting in authorize.net settings. May be passed in as an argument if necessary but there MUST be an encapsulation character. --->
<cfset variables.version = "3.1">
<cfset variables.environment = "Development">
<CFELSE>
<!--- production server. use with testrequest true during testing and false to go live --->
<cfset variables.url_gateway = "https://test.authorize.net/gateway/transact.dll">
<cfset variables.url_CIM_ARB = "https://apitest.authorize.net/xml/v1/request.api">
<cfset variables.login = "7xG5qVRm65k"><!--- may be passed in as an argument to the init method, or entered manually here, or passed in as an argument with each individual method to overwrite what is entered here. --->
<cfset variables.transactionkey = "97p5B2MD2v4v7tA3"><!--- may be passed in as an argument to the init method, or entered manually here, or passed in as an argument with each individual method to overwrite what is entered here. --->
<cfset variables.auth_type = "AUTH_ONLY"><!--- may be passed in as an argument. --->
<cfset variables.ADC_Delim_Character = "|"><!--- must match Direct Response setting in authorize.net settings. May be passed in as an argument if necessary but there MUST be a delimiter. --->
<cfset variables.Encapsulate_Character = '"'><!--- must match Direct Response setting in authorize.net settings. May be passed in as an argument if necessary but there MUST be an encapsulation character. --->
<cfset variables.version = "3.1">
<cfset variables.environment = "Production">
</CFIF>
<cfreturn this />
	</cffunction>

	<cffunction name="gatewayTransaction" access="public" returntype="struct" output="false" hint="Authorize, Capture, Refund, and Void Credit Card transactions through the payment gateway.">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="transactionid" type="string" default="">
<cfargument name="approvalCode" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="currency_code" type="string" default="USD">
<cfargument name="auth_type" type="string" default="#variables.auth_type#"><!--- AUTH_CAPTURE, AUTH_ONLY, CREDIT, VOID, PRIOR_AUTH_CAPTURE --->
<cfargument name="firstname" type="string" default="">
<cfargument name="lastname" type="string" default="">
<cfargument name="company" type="string" default="">
<cfargument name="address" type="string" default="">
<cfargument name="city" type="string" default="">
<cfargument name="state" type="string" default="">
<cfargument name="zip" type="string" default="">
<cfargument name="country" type="string" default="">
<cfargument name="phoneNumber" type="string" default="">
<cfargument name="ship_firstname" type="string" default="">
<cfargument name="ship_lastname" type="string" default="">
<cfargument name="ship_company" type="string" default="">
<cfargument name="ship_address" type="string" default="">
<cfargument name="ship_city" type="string" default="">
<cfargument name="ship_state" type="string" default="">
<cfargument name="ship_zip" type="string" default="">
<cfargument name="ship_country" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="cardnumber" type="string" default="">
<cfargument name="merchantCustomerId" type="string" default="">
<cfargument name="Amount" type="numeric" default="0">
<cfargument name="invoice" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="bankname" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="accountType" type="string" default="">
<cfargument name="customertype" type="string" default=""><!--- individual or business. --->
<cfargument name="cardcode" type="string" default="">
<cfargument name="dl_no" type="string" default="">
<cfargument name="dl_state" type="string" default="">
<cfargument name="dl_dob" type="string" default="">
<cfargument name="ssn" type="string" default="">
<cfargument name="ipaddress" type="string" default="#cgi.remote_addr#">
<cfargument name="description" type="string" default="">
<cfargument name="Merchant_Email" type="string" default="">
<cfargument name="EmailCustomer" type="boolean" default="FALSE">
<cfargument name="TestRequest" type="boolean" default="FALSE">
<cfargument name="version" type="numeric" default="#variables.version#">
<cfargument name="shipping" type="boolean" default="0">
<cfargument name="taxes" type="boolean" default="0">
<cfargument name="MD5" type="string" default="">
<cfargument name="recurring_billing" type="boolean" default="NO">
<cfargument name="taxExempt" type="boolean" default="false">
<cfargument name="ECI" type="string" default="">
<cfargument name="CAVV" type="string" default="">
<cfargument name="checkforduplicate" type="numeric" default="120"><!--- seconds --->
<cfargument name="allowPartialAuth" type="any" default=""><!--- input boolean true or false to overwrite merchant settings  --->
<cfargument name="splitTenderId" type="string" default="">
<cfargument name="PO_Num" type="string" default="">


		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />
		
		<cfset response.error = "Unknown Error" />
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment />
		<cfset response.invoice = arguments.invoice>
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />

<cftry>

<!--------------------------------------------------------------------
	Post to Authorize.Net
  --------------------------------------------------------------------->
	<cfhttp url="#variables.url_gateway#" method="POST">
	<cfhttpparam type="FORMFIELD" name="x_Version" value="#arguments.version#">
	<cfhttpparam type="FORMFIELD" name="x_Login" value="7BPc46jba3">
	<cfhttpparam type="FORMFIELD" name="x_Type" value="#arguments.auth_type#">
	<cfhttpparam type="FORMFIELD" name="x_Tran_Key" value="8V7N467pmu8XSskR">
    <cfhttpparam type="FORMFIELD" name="x_Delim_Data" value="TRUE">
    <cfhttpparam type="FORMFIELD" name="x_Relay_Response" value="FALSE">
    <cfhttpparam type="FORMFIELD" name="x_Delim_Char" value="#arguments.ADC_Delim_Character#">
    <cfhttpparam type="FORMFIELD" name="x_Encap_Char" value="#arguments.Encapsulate_Character#">
	<CFIF arguments.TestRequest><cfhttpparam type="FORMFIELD" name="x_Test_Request" value="true"><CFELSE><cfhttpparam type="FORMFIELD" name="x_Test_Request" value="false"></CFIF>
<CFIF arguments.auth_type IS "PRIOR_AUTH_CAPTURE">
	<cfif arguments.splitTenderId is "">
	<cfhttpparam type="FORMFIELD" name="x_Trans_ID" value="#arguments.transactionid#">
	<cfelse>
	<cfhttpparam type="FORMFIELD" name="x_Split_Tender_ID" value="#arguments.splitTenderId#">
	</cfif>
	<cfhttpparam type="FORMFIELD" name="x_Amount" value="#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#">
<CFELSEIF arguments.auth_type IS "CAPTURE_ONLY">
	<cfhttpparam type="FORMFIELD" name="x_auth_code" value="#arguments.approvalCode#">
	<cfhttpparam type="FORMFIELD" name="x_Amount" value="#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#">
<CFELSEIF arguments.auth_type IS "CREDIT">
	<cfhttpparam type="FORMFIELD" name="x_Trans_ID" value="#arguments.transactionid#">
	<cfhttpparam type="FORMFIELD" name="x_Amount" value="#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#">
	<cfhttpparam type="FORMFIELD" name="x_Invoice_Num" value="#arguments.invoice#">
	<cfhttpparam type="FORMFIELD" name="x_Description" value="#arguments.description#">
	<CFIF arguments.accountNumber is not "" and arguments.cardNumber is "">
	<cfhttpparam type="FORMFIELD" name="x_Bank_Acct_Num" value="#arguments.accountNumber#">
	<CFELSE>
	<cfhttpparam type="FORMFIELD" name="x_Card_Num" value="#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#">
	</CFIF>
<CFELSEIF arguments.auth_type IS "VOID">
	<cfif arguments.splitTenderId is "">
	<cfhttpparam type="FORMFIELD" name="x_Trans_ID" value="#arguments.transactionid#">
	<cfelse>
	<cfhttpparam type="FORMFIELD" name="x_Split_Tender_ID" value="#arguments.splitTenderId#">
	</cfif>
<CFELSE>
	<cfhttpparam type="FORMFIELD" name="x_Amount" value="#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#">
	<cfhttpparam type="FORMFIELD" name="x_Invoice_Num" value="#arguments.invoice#">
	<cfhttpparam type="FORMFIELD" name="x_Description" value="#arguments.description#">
	<cfhttpparam type="FORMFIELD" name="x_Cust_ID" value="#arguments.merchantCustomerId#">
	<CFIF arguments.accountNumber is not "" and arguments.cardNumber is "">
	<cfhttpparam type="FORMFIELD" name="x_Method" value="eCheck">
	<cfhttpparam type="FORMFIELD" name="x_Bank_Name" value="#arguments.bankname#">
	<cfhttpparam type="FORMFIELD" name="x_Bank_Acct_Num" value="#arguments.accountNumber#">
	<cfhttpparam type="FORMFIELD" name="x_Bank_Acct_Name" value="#arguments.nameOnAccount#">
	<cfhttpparam type="FORMFIELD" name="x_Bank_ABA_Code" value="#arguments.routingNumber#">
	<cfhttpparam type="FORMFIELD" name="x_Bank_Acct_Type" value="#arguments.accountType#">
		<CFIF Trim(arguments.customertype) IS NOT ""><cfhttpparam type="FORMFIELD" name="x_Customer_Organization_Type" value="#arguments.customertype#"></CFIF>
		<CFIF Trim(arguments.dl_no) IS NOT ""><cfhttpparam type="FORMFIELD" name="x_Drivers_License_Num" value="#arguments.dl_no#"></CFIF>
		<CFIF Trim(arguments.dl_state) IS NOT ""><cfhttpparam type="FORMFIELD" name="x_Drivers_License_State" value="#arguments.dl_state#"></CFIF>
		<CFIF Trim(arguments.dl_dob) IS NOT ""><cfhttpparam type="FORMFIELD" name="x_Drivers_License_DOB" value="#DateFormat(arguments.dl_dob, "MM/DD/YYYY")#"></CFIF>
		<CFIF Trim(arguments.ssn) IS NOT ""><cfhttpparam type="FORMFIELD" name="x_Customer_Tax_ID" value="#arguments.ssn#"></CFIF>
		<CFIF arguments.echeckType is "">
		<cfswitch expression="#arguments.accountType#">
		<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
		<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
		</cfswitch>
		</CFIF>
	<cfhttpparam type="FORMFIELD" name="x_Echeck_Type" value="#arguments.echeckType#">
	<cfhttpparam type="FORMFIELD" name="x_recurring_billing" value="#arguments.recurring_billing#">
	<cfhttpparam type="FORMFIELD" name="x_tax_exempt" value="#arguments.taxExempt#">
	<CFELSE>
	<cfhttpparam type="FORMFIELD" name="x_Method" value="cc">
	<cfhttpparam type="FORMFIELD" name="x_Card_Num" value="#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#">
	<cfhttpparam type="FORMFIELD" name="x_Exp_Date" value="#arguments.expirationDate#">
	<cfhttpparam type="FORMFIELD" name="x_Card_Code" value="#arguments.cardcode#">
		<cfif arguments.allowPartialAuth is not ""><cfhttpparam type="FORMFIELD" name="x_allow_partial_Auth" value="#arguments.allowPartialAuth#"></cfif>
		<cfif arguments.splitTenderId is not ""><cfhttpparam type="FORMFIELD" name="x_Split_Tender_ID" value="#arguments.splitTenderId#"></cfif>
	<!--- verified by visa/mastercard secure code --->
	<cfhttpparam type="FORMFIELD" name="x_authentication_indicator" value="#arguments.eci#">
	<cfhttpparam type="FORMFIELD" name="x_cardholder_authentication_value" value="#arguments.cavv#">
	</CFIF>
	<cfif arguments.Merchant_Email is not ""><cfhttpparam type="FORMFIELD" name="x_Merchant_Email" value="#arguments.Merchant_Email#"></cfif>
	<cfif arguments.PO_Num is not ""><cfhttpparam type="FORMFIELD" name="x_PO_Num" value="#arguments.PO_Num#"></cfif>
	<cfhttpparam type="FORMFIELD" name="x_Currency_Code" value="#arguments.currency_code#">
	<cfhttpparam type="FORMFIELD" name="x_Customer_IP" value="#arguments.ipaddress#">
	<cfhttpparam type="FORMFIELD" name="x_Freight" value="#arguments.shipping#">
	<cfhttpparam type="FORMFIELD" name="x_Tax" value="#arguments.taxes#">
	<cfhttpparam type="FORMFIELD" name="x_First_Name" value="#arguments.firstname#">
	<cfhttpparam type="FORMFIELD" name="x_Last_Name" value="#arguments.lastname#">
	<cfhttpparam type="FORMFIELD" name="x_Company" value="#arguments.company#">
	<cfhttpparam type="FORMFIELD" name="x_Address" value="#arguments.address#">
	<cfhttpparam type="FORMFIELD" name="x_City" value="#arguments.city#">
	<cfhttpparam type="FORMFIELD" name="x_State" value="#arguments.state#">
	<cfhttpparam type="FORMFIELD" name="x_Zip" value="#arguments.zip#">
	<cfhttpparam type="FORMFIELD" name="x_Country" value="#arguments.country#">
	<cfhttpparam type="FORMFIELD" name="x_Phone" value="#arguments.phoneNumber#">
	<cfhttpparam type="FORMFIELD" name="x_Email" value="#arguments.email#">
	<cfhttpparam type="FORMFIELD" name="x_Email_Customer" value="#arguments.EmailCustomer#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_first_name" value="#arguments.ship_firstname#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_last_name" value="#arguments.ship_lastname#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_company" value="#arguments.ship_company#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_address" value="#arguments.ship_address#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_city" value="#arguments.ship_city#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_state" value="#arguments.ship_state#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_zip" value="#arguments.ship_zip#">
	<cfhttpparam type="FORMFIELD" name="x_ship_to_country" value="#arguments.ship_country#">
</CFIF>
</CFHTTP>

<cfset response.resultstring = cfhttp.filecontent>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
<CFIF isStruct(result)>
<cfloop index="i" list="#StructKeyList(result)#"><cfset temp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
<CFELSE>
<cfthrow message="#result#">
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
			
	</cffunction>
	
	<cffunction name="parseResult" access="public" returntype="struct" output="false" hint="Parse the string returned from an Authorize.net transaction.">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		
		<cfset response.error = "" />
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment />
		
		<cfset response.response_code = "3" />
		<cfset response.Response_Subcode = "" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<!--- already have this from the input <cfset response.Invoice = "" /> --->
		<cfset response.Description = "" />
		<cfset response.Amount = "" />
		<cfset response.Method = "" />
		<cfset response.TransactionType = "" />
		<cfset response.CustomerID = "" />
		<cfset response.CardholderFirstName = "" />
		<cfset response.CardholderLastName = "" />
		<cfset response.Company = "" />
		<cfset response.BillingAddress = "" />
		<cfset response.City = "" />
		<cfset response.State = "" />
		<cfset response.Zip = "" />
		<cfset response.Country = "" />
		<cfset response.Phone = "" />
		<cfset response.Fax = "" />
		<cfset response.Email = "" />
		<cfset response.ShiptoFirstName = "" />
		<cfset response.ShiptoLastName = "" />
		<cfset response.ShiptoCompany = "" />
		<cfset response.ShiptoAddress = "" />
		<cfset response.ShiptoCity = "" />
		<cfset response.ShiptoState = "" />
		<cfset response.ShiptoZip = "" />
		<cfset response.ShiptoCountry = "" />
		<cfset response.TaxAmount = "" />
		<cfset response.DutyAmount = "" />
		<cfset response.FreightAmount = "" />
		<cfset response.TaxExemptFlag = "" />
		<cfset response.PONumber = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.Hash = "" />
		<cfset response.AccountNumber = "" />
		<cfset response.CardType = "" />
		<cfset response.SplitTenderID = "" />
		<cfset response.RequestedAmount = "" />
		<cfset response.BalanceOnCard = "" />


<cftry>

<cfif ListLen(arguments.mystring, "#arguments.ADC_Delim_Character#") GTE 38 and Replace(ListGetAt(arguments.mystring, 1, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL') is not "">
	<CFIF not isDefined('arguments.MD5') or arguments.MD5 is "" or (arguments.MD5 is not "" and Replace(ListGetAt(arguments.mystring, 38, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL') is hash('#arguments.MD5#7BPc46jba3#Replace(ListGetAt(arguments.mystring, 7, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')##rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#'))>
		<cfset response.response_code = Replace(ListGetAt(arguments.mystring, 1, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.reason_code = Replace(ListGetAt(arguments.mystring, 3, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.response_text = Replace(ListGetAt(arguments.mystring, 4, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.authorization_code = Replace(ListGetAt(arguments.mystring, 5, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.avs_code = Replace(ListGetAt(arguments.mystring, 6, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.trans_id = Replace(ListGetAt(arguments.mystring, 7, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.card_code_response = Replace(ListGetAt(arguments.mystring, 39, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.cavv_response = Replace(ListGetAt(arguments.mystring, 40, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>

<!--- I don't use any of the ones below within this file, but they are returned if you wish to use them elsewhere. --->
		<cfset response.Response_Subcode = Replace(ListGetAt(arguments.mystring,  2, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<!--- already have this from the input <cfset response.Invoice = Replace(ListGetAt(arguments.mystring,  8, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')> --->
		<cfset response.Description = Replace(ListGetAt(arguments.mystring,  9, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Amount = Replace(ListGetAt(arguments.mystring, 10, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Method = Replace(ListGetAt(arguments.mystring, 11, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.TransactionType = Replace(ListGetAt(arguments.mystring, 12, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.CustomerID = Replace(ListGetAt(arguments.mystring, 13, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.CardholderFirstName = Replace(ListGetAt(arguments.mystring, 14, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.CardholderLastName = Replace(ListGetAt(arguments.mystring, 15, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Company = Replace(ListGetAt(arguments.mystring, 16, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.BillingAddress = Replace(ListGetAt(arguments.mystring, 17, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.City = Replace(ListGetAt(arguments.mystring, 18, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.State = Replace(ListGetAt(arguments.mystring, 19, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Zip = Replace(ListGetAt(arguments.mystring, 20, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Country = Replace(ListGetAt(arguments.mystring, 21, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Phone = Replace(ListGetAt(arguments.mystring, 22, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Fax = Replace(ListGetAt(arguments.mystring, 23, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Email = Replace(ListGetAt(arguments.mystring, 24, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoFirstName = Replace(ListGetAt(arguments.mystring, 25, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoLastName = Replace(ListGetAt(arguments.mystring, 26, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoCompany = Replace(ListGetAt(arguments.mystring, 27, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoAddress = Replace(ListGetAt(arguments.mystring, 28, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoCity = Replace(ListGetAt(arguments.mystring, 29, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoState = Replace(ListGetAt(arguments.mystring, 30, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoZip = Replace(ListGetAt(arguments.mystring, 31, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.ShiptoCountry = Replace(ListGetAt(arguments.mystring, 32, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.TaxAmount = Replace(ListGetAt(arguments.mystring, 33, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.DutyAmount = Replace(ListGetAt(arguments.mystring, 34, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.FreightAmount = Replace(ListGetAt(arguments.mystring, 35, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.TaxExemptFlag = Replace(ListGetAt(arguments.mystring, 36, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.PONumber = Replace(ListGetAt(arguments.mystring, 37, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.Hash = Replace(ListGetAt(arguments.mystring, 37, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.AccountNumber = Replace(ListGetAt(arguments.mystring, 51, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.CardType = Replace(ListGetAt(arguments.mystring, 52, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.SplitTenderID = Replace(ListGetAt(arguments.mystring, 53, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.RequestedAmount = Replace(ListGetAt(arguments.mystring, 54, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
		<cfset response.BalanceOnCard = Replace(ListGetAt(arguments.mystring, 55, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
	<CFELSE>
	<cfset response.response_code = "3">
	<cfset response.reason_code = "0">
	<cfset response.response_text = "Invalid Hash. Please contact merchant.">
	</CFIF>	
<cfelse>
	<cfset response.response_code = "3">
	<cfset response.reason_code = "0">
	<cfset response.authorization_code = "">
	<CFIF ListLen(arguments.mystring, "#arguments.ADC_Delim_Character#") GTE 4 and Replace(ListGetAt(arguments.mystring, 4, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL') is not "">
	<cfset response.response_text = Replace(ListGetAt(arguments.mystring, 4, "#arguments.ADC_Delim_Character#"),'#arguments.Encapsulate_Character#','','ALL')>
	<cfelseif arguments.mystring contains "Connection Failure"><cfset response.response_text = "No Response From Processor.<br />Please wait 1 or 2 minutes and try again.">
	<cfelse><cfset response.response_text = "Invalid Response From Processor. Please check all fields and try again.">
	</CFIF>
</cfif>
<CFIF response.response_code GT 1 and response.reason_code is not 252 and response.reason_code is not 253><cfset response.error = response.response_text><cfset response.errorcode = response.reason_code></CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>

	<cffunction name="createCustomerProfile" access="public" returntype="struct" output="false" hint="Creates a new CIM Customer Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="merchantCustomerId" type="string" default="">
<cfargument name="customerdescription" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="testrequest" type="boolean" default="FALSE">
<cfargument name="customerType" type="string" default="">

<cfargument name="cardNumber" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="cardCode" type="string" default="">

<cfargument name="firstname" type="string" default="">
<cfargument name="lastname" type="string" default="">
<cfargument name="company" type="string" default="">
<cfargument name="address" type="string" default="">
<cfargument name="city" type="string" default="">
<cfargument name="state" type="string" default="">
<cfargument name="zip" type="string" default="">
<cfargument name="country" type="string" default="">
<cfargument name="phoneNumber" type="string" default="">
<cfargument name="faxNumber" type="string" default="">

<cfargument name="ship_firstname" type="string" default="">
<cfargument name="ship_lastname" type="string" default="">
<cfargument name="ship_company" type="string" default="">
<cfargument name="ship_address" type="string" default="">
<cfargument name="ship_city" type="string" default="">
<cfargument name="ship_state" type="string" default="">
<cfargument name="ship_zip" type="string" default="">
<cfargument name="ship_country" type="string" default="">
<cfargument name="ship_phoneNumber" type="string" default="">
<cfargument name="ship_faxNumber" type="string" default="">

<cfargument name="accountType" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="bankName" type="string" default="">

<cfargument name="validate" type="boolean" default="true">

<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.customerProfileId = "">
		<cfset response.customerPaymentProfileId = "">
		<cfset response.customerAddressId = "">
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />

<CFIF arguments.echeckType is "" and arguments.accountNumber is not "">
<cfswitch expression="#arguments.accountType#">
<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
</cfswitch>
</CFIF>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<createCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <profile><!--- 2 out of 3 must have a value --->
    <merchantCustomerId>#arguments.merchantCustomerId#</merchantCustomerId>
    <description>#myXMLFormat(left(arguments.customerdescription, 255), arguments.useXmlFormat)#</description>
    <email>#arguments.email#</email><CFIF arguments.cardNumber is not "" or arguments.accountNumber is not "">
    <paymentProfiles><CFIF arguments.customerType is not "">
      <customerType>#arguments.customerType#</customerType></CFIF>
      <billTo>
        <firstName>#myXMLFormat(arguments.firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
        <lastName>#myXMLFormat(arguments.lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
        <company>#myXMLFormat(arguments.company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
        <address>#myXMLFormat(arguments.address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
        <city>#myXMLFormat(arguments.city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
        <state>#arguments.state#</state><!--- A valid two-character state code --->
        <zip>#myXMLFormat(arguments.zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
        <country>#myXMLFormat(arguments.country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
        <phoneNumber>#rereplace(arguments.phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
        <faxNumber>#rereplace(arguments.faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
      </billTo>
      <payment><CFIF arguments.cardNumber is not "">
        <creditCard>
          <cardNumber>#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#</cardNumber>
          <expirationDate>20#right(arguments.expirationDate, 2)#-#left(arguments.expirationDate, 2)#</expirationDate><!--- YYYY-MM ---><CFIF arguments.cardCode is not "">
          <cardCode>#arguments.cardCode#</cardCode></CFIF>
        </creditCard><CFELSEIF arguments.accountNumber is not "">
        <bankAccount>
          <accountType>#arguments.accountType#</accountType><!--- checking,savings,businessChecking --->
          <routingNumber>#arguments.routingNumber#</routingNumber><!--- 9 digits --->
          <accountNumber>#arguments.accountNumber#</accountNumber><!--- 5 to 17 digits --->
          <nameOnAccount>#myXMLFormat(arguments.nameOnAccount, arguments.useXmlFormat)#</nameOnAccount><!--- full name as listed on the bank account Up to 22 characters --->
          <echeckType>#arguments.echeckType#</echeckType><!--- CCD,PPD,TEL,WEB (WEB for internet transactions) --->
          <bankName>#myXMLFormat(arguments.bankName, arguments.useXmlFormat)#</bankName><!--- Optional Up to 50 characters --->
        </bankAccount></CFIF>
      </payment>
    </paymentProfiles></CFIF><CFIF arguments.ship_address is not "">
    <shipToList>
      <firstName>#myXMLFormat(arguments.ship_firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
      <lastName>#myXMLFormat(arguments.ship_lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
      <company>#myXMLFormat(arguments.ship_company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
      <address>#myXMLFormat(arguments.ship_address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
      <city>#myXMLFormat(arguments.ship_city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
      <state>#arguments.ship_state#</state><!--- A valid two-character state code --->
      <zip>#myXMLFormat(arguments.ship_zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
      <country>#myXMLFormat(arguments.ship_country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
      <phoneNumber>#rereplace(arguments.ship_phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
      <faxNumber>#rereplace(arguments.ship_faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    </shipToList></CFIF>
  </profile><CFIF arguments.validate and arguments.cardNumber is not "">
  <validationMode><CFIF arguments.testrequest>testMode<CFELSE>liveMode</CFIF></validationMode></CFIF>
</createCustomerProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.createCustomerProfileResponse')><cfset temp = response.XmlResponse.createCustomerProfileResponse></CFIF>

<CFIF isDefined('temp.messages.message')>
	<CFIF temp.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = temp.refId.XmlText>
<cfset response.customerProfileId = temp.customerProfileId.XmlText>
		<CFIF isDefined('temp.customerPaymentProfileIdList.numericString')><cfset response.customerPaymentProfileId = temp.customerPaymentProfileIdList.numericString.XmlText></CFIF>
		<CFIF isDefined('temp.customerShippingAddressIdList.numericString')><cfset response.customerAddressId = temp.customerShippingAddressIdList.numericString.XmlText></CFIF>
		<CFIF isDefined('temp.validationDirectResponseList.string')>
		<cfset response.resultstring = temp.validationDirectResponseList.string.XmlText>
		<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
			<CFIF isStruct(result)>
			<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
			<CFELSE>
			<cfthrow message="#result#">
			</CFIF>
		</CFIF>
	<CFELSE>
<cfset response.error = temp.messages.message[1].text.XmlText>
<cfset response.errorcode = temp.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>

	<cffunction name="updateCustomerProfile" access="public" returntype="struct" output="false" hint="Updates a new CIM customer profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="merchantCustomerId" type="string" default="">
<cfargument name="customerdescription" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">

		<cfset response.customerProfileId = arguments.customerProfileId>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<updateCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <profile><!--- 2 out of first 3 must have a value --->
    <merchantCustomerId>#arguments.merchantCustomerId#</merchantCustomerId>
    <description>#myXMLFormat(left(arguments.customerdescription, 255), arguments.useXmlFormat)#</description>
    <email>#arguments.email#</email>
    <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  </profile>
</updateCustomerProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.updateCustomerProfileResponse.messages.message')>
	<CFIF response.XmlResponse.updateCustomerProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.updateCustomerProfileResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.updateCustomerProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.updateCustomerProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />

	
	</cffunction>
	
	<cffunction name="deleteCustomerProfile" access="public" returntype="struct" output="false" hint="Deletes a CIM customer profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<deleteCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
</deleteCustomerProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.deleteCustomerProfileResponse.messages.message')>
	<CFIF response.XmlResponse.deleteCustomerProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.deleteCustomerProfileResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.deleteCustomerProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.deleteCustomerProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="createCustomerProfileTransaction" access="public" returntype="struct" output="false" hint="Charges or refunds against a CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerPaymentProfileId" type="string" default="">
<cfargument name="customerAddressId" type="string" default="">
<cfargument name="auth_type" type="string" default="#variables.auth_type#"><!--- AUTH_CAPTURE, AUTH_ONLY, CREDIT, VOID, PRIOR_AUTH_CAPTURE --->
<cfargument name="testrequest" type="boolean" default="FALSE">
<cfargument name="amount" type="numeric" default="0">
<cfargument name="transactionid" type="string" default=""><!--- for prior_auth_capture and voids --->
<cfargument name="approvalCode" type="string" default=""><!--- for capture from an order placed on a different gateway. --->
<cfargument name="invoice" type="string" default="">
<cfargument name="cardcode" type="string" default="">
<cfargument name="description" type="string" default="">
<cfargument name="recurring_billing" type="boolean" default="true">
<cfargument name="taxExempt" type="boolean" default="false">
<cfargument name="ipaddress" type="string" default="#cgi.remote_addr#">
<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">
<cfargument name="allowPartialAuth" type="any" default=""><!--- input boolean true or false to overwrite merchant settings  --->
<cfargument name="splitTenderId" type="string" default="">
<cfargument name="Merchant_Email" type="string" default="">
<cfargument name="PO_Num" type="string" default="">
		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />
		<cfset var extraOptions = "" />

		<cfset response.error = "Unknown Error" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.invoice = arguments.invoice>
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = arguments.customerPaymentProfileId>
		<cfset response.customerAddressId = arguments.customerAddressId>
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />
		
		<cfif arguments.testrequest>
		<cfset extraOptions = extraOptions & "x_test_request=true&amp;" />
		</cfif>
		<cfif arguments.allowPartialAuth is not "">
		<cfset extraOptions = extraOptions & "x_allow_partial_auth=#arguments.allowPartialAuth#&amp;" />
		</cfif>
		<cfif arguments.Merchant_Email is not "">
		<cfset extraOptions = extraOptions & "x_merchant_email=#arguments.Merchant_Email#&amp;" />
		</cfif>
		
		<!--- this must be last extraOptions --->
		<cfset extraOptions = extraOptions & "x_Customer_IP=#arguments.ipaddress#" />

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<createCustomerProfileTransactionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <transaction><CFIF arguments.auth_type is "AUTH_ONLY">
  	<profileTransAuthOnly>
  	  <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF><CFIF arguments.invoice is not "">
  	  <order>
        <invoiceNumber>#arguments.invoice#</invoiceNumber>
        <description>#myXMLFormat(arguments.description, arguments.useXmlFormat)#</description><cfif arguments.PO_Num is not "">
        <purchaseOrderNumber>#arguments.PO_Num#</purchaseOrderNumber></cfif>
      </order></CFIF>
      <taxExempt><CFIF arguments.taxExempt>true<CFELSE>false</CFIF></taxExempt>
      <recurringBilling><CFIF arguments.recurring_billing>true<CFELSE>false</CFIF></recurringBilling><CFIF arguments.cardcode is not "">
      <cardCode>#arguments.cardcode#</cardCode></CFIF><cfif arguments.splitTenderId is not "">
      <splitTenderId>#arguments.splitTenderId#</splitTenderId></cfif>
  	</profileTransAuthOnly><CFELSEIF arguments.auth_type is "AUTH_CAPTURE">
  	<profileTransAuthCapture>
  	  <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF><CFIF arguments.invoice is not "">
  	  <order>
        <invoiceNumber>#arguments.invoice#</invoiceNumber>
        <description>#myXMLFormat(arguments.description, arguments.useXmlFormat)#</description><cfif arguments.PO_Num is not "">
        <purchaseOrderNumber>#arguments.PO_Num#</purchaseOrderNumber></cfif>
      </order></CFIF>
      <recurringBilling><CFIF arguments.recurring_billing>true<CFELSE>false</CFIF></recurringBilling><CFIF arguments.cardcode is not "">
      <cardCode>#arguments.cardcode#</cardCode></CFIF><cfif arguments.splitTenderId is not "">
      <splitTenderId>#arguments.splitTenderId#</splitTenderId></cfif>
  	</profileTransAuthCapture><CFELSEIF arguments.auth_type is "CREDIT">
  	<profileTransRefund>
  	  <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF><CFIF arguments.invoice is not "">
  	  <order>
        <invoiceNumber>#arguments.invoice#</invoiceNumber>
        <description>#myXMLFormat(arguments.description, arguments.useXmlFormat)#</description><cfif arguments.PO_Num is not "">
        <purchaseOrderNumber>#arguments.PO_Num#</purchaseOrderNumber></cfif>
      </order></CFIF>
  	  <transId>#arguments.transactionid#</transId>
  	</profileTransRefund><CFELSEIF arguments.auth_type is "VOID">
  	<profileTransVoid>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF>
  	  <cfif arguments.splitTenderId is ""><transId>#arguments.transactionid#</transId><cfelse><splitTenderId>#arguments.splitTenderId#</splitTenderId></cfif>
  	</profileTransVoid><CFELSEIF arguments.auth_type is "CAPTURE_ONLY">
  	<profileTransCaptureOnly>
  	  <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF><CFIF arguments.invoice is not "">
  	  <order>
        <invoiceNumber>#arguments.invoice#</invoiceNumber>
        <description>#myXMLFormat(arguments.description, arguments.useXmlFormat)#</description><cfif arguments.PO_Num is not "">
        <purchaseOrderNumber>#arguments.PO_Num#</purchaseOrderNumber></cfif>
      </order></CFIF><CFIF arguments.cardcode is not "">
      <cardCode>#arguments.cardcode#</cardCode></CFIF>
  	  <approvalCode>#arguments.approvalCode#</approvalCode>
  	</profileTransCaptureOnly><CFELSEIF arguments.auth_type is "PRIOR_AUTH_CAPTURE">
  	<profileTransPriorAuthCapture>
  	  <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount>
      <customerProfileId>#arguments.customerProfileId#</customerProfileId>
      <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.customerAddressId is not "">
      <customerShippingAddressId>#arguments.customerAddressId#</customerShippingAddressId></CFIF>
  	  <cfif arguments.splitTenderId is ""><transId>#arguments.transactionid#</transId><cfelse><splitTenderId>#arguments.splitTenderId#</splitTenderId></cfif>
  	</profileTransPriorAuthCapture></CFIF>
  </transaction>
  <extraOptions>#extraOptions#</extraOptions>
</createCustomerProfileTransactionRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.createCustomerProfileTransactionResponse.messages.message')>
	<CFIF response.XmlResponse.createCustomerProfileTransactionResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.createCustomerProfileTransactionResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.createCustomerProfileTransactionResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.createCustomerProfileTransactionResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<CFIF isDefined('response.XmlResponse.createCustomerProfileTransactionResponse.directResponse')>
<cfset response.resultstring = response.XmlResponse.createCustomerProfileTransactionResponse.directResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
	<CFIF isStruct(result)>
	<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
	<CFELSE>
	<cfthrow message="#result#">
	</CFIF>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="createCustomerPaymentProfile" access="public" returntype="struct" output="false" hint="Creates a new CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="description" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="testrequest" type="boolean" default="FALSE">
<cfargument name="customerType" type="string" default="">

<cfargument name="cardNumber" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="cardCode" type="string" default="">

<cfargument name="firstname" type="string" default="">
<cfargument name="lastname" type="string" default="">
<cfargument name="company" type="string" default="">
<cfargument name="address" type="string" default="">
<cfargument name="city" type="string" default="">
<cfargument name="state" type="string" default="">
<cfargument name="zip" type="string" default="">
<cfargument name="country" type="string" default="">
<cfargument name="phoneNumber" type="string" default="">
<cfargument name="faxNumber" type="string" default="">

<cfargument name="accountType" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="bankName" type="string" default="">

<cfargument name="validate" type="boolean" default="true">
<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = "">
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />
		
		<CFIF arguments.cardNumber is not "">
		<cfset response.PaymentProfileType = "credit" />
		<CFELSE>
		<cfset response.PaymentProfileType = "bank" />
		</CFIF>

		<cfset response.address = arguments.address>
		<cfset response.city = arguments.city>
		<cfset response.company = arguments.company>
		<cfset response.country = arguments.country>
		<cfset response.faxnumber = arguments.faxnumber>
		<cfset response.firstname = arguments.firstname>
		<cfset response.lastname = arguments.lastname>
		<cfset response.phonenumber = arguments.phonenumber>
		<cfset response.state = arguments.state>
		<cfset response.zip = arguments.zip>
		
		<cfset response.cardnumber = right(rereplace(arguments.cardnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.expirationdate  = "#left(arguments.expirationDate, 2)##right(arguments.expirationDate, 2)#">
		
		<cfset response.accountnumber = right(rereplace(arguments.accountnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.routingnumber = right(rereplace(arguments.routingnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.accounttype = arguments.accounttype>
		<cfset response.bankname = arguments.bankname>
		<cfset response.echecktype = arguments.echecktype>
		<cfset response.nameonaccount = arguments.nameonaccount>
		<cfset response.customerType = arguments.customerType>


<CFIF arguments.echeckType is "" and arguments.accountNumber is not "">
<cfswitch expression="#arguments.accountType#">
<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
</cfswitch>
</CFIF>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<createCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <paymentProfile><CFIF arguments.customerType is not "">
    <customerType>#arguments.customerType#</customerType></CFIF>
    <billTo>
      <firstName>#myXMLFormat(arguments.firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
      <lastName>#myXMLFormat(arguments.lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
      <company>#myXMLFormat(arguments.company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
      <address>#myXMLFormat(arguments.address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
      <city>#myXMLFormat(arguments.city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
      <state>#arguments.state#</state><!--- A valid two-character state code --->
      <zip>#myXMLFormat(arguments.zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
      <country>#myXMLFormat(arguments.country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
      <phoneNumber>#rereplace(arguments.phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
      <faxNumber>#rereplace(arguments.faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    </billTo>
    <payment><CFIF arguments.cardNumber is not "">
      <creditCard>
        <cardNumber>#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#</cardNumber>
        <expirationDate>20#right(arguments.expirationDate, 2)#-#left(arguments.expirationDate, 2)#</expirationDate><!--- YYYY-MM ---><CFIF arguments.cardCode is not "">
        <cardCode>#arguments.cardCode#</cardCode></CFIF>
      </creditCard><CFELSEIF arguments.accountNumber is not "">
      <bankAccount>
        <accountType>#arguments.accountType#</accountType><!--- checking,savings,businessChecking --->
        <routingNumber>#arguments.routingNumber#</routingNumber><!--- 9 digits --->
        <accountNumber>#arguments.accountNumber#</accountNumber><!--- 5 to 17 digits --->
        <nameOnAccount>#myXMLFormat(arguments.nameOnAccount, arguments.useXmlFormat)#</nameOnAccount><!--- full name as listed on the bank account Up to 22 characters --->
        <echeckType>#arguments.echeckType#</echeckType><!--- Optional,CCD,PPD,TEL,WEB (we use WEB) --->
        <bankName>#myXMLFormat(arguments.bankName, arguments.useXmlFormat)#</bankName><!--- Optional Up to 50 characters --->
      </bankAccount></CFIF>
    </payment>
  </paymentProfile><CFIF arguments.validate>
  <validationMode><CFIF arguments.testrequest>testMode<CFELSE>liveMode</CFIF></validationMode></CFIF>
</createCustomerPaymentProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.createCustomerPaymentProfileResponse.messages.message')>
	<CFIF response.XmlResponse.createCustomerPaymentProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.createCustomerPaymentProfileResponse.refId.XmlText>
<cfset response.customerPaymentProfileId = response.XmlResponse.createCustomerPaymentProfileResponse.customerPaymentProfileId.XmlText>
		<CFIF isDefined('response.XmlResponse.createCustomerPaymentProfileResponse.validationDirectResponse')>
<cfset response.resultstring = response.XmlResponse.createCustomerPaymentProfileResponse.validationDirectResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
			<CFIF isStruct(result)>
			<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
			<CFELSE>
			<cfthrow message="#result#">
			</CFIF>
		</CFIF>
	<CFELSE>
<cfset response.error = response.XmlResponse.createCustomerPaymentProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.createCustomerPaymentProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="updateCustomerPaymentProfile" access="public" returntype="struct" output="false" hint="Updates a CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerPaymentProfileId" type="string" default="">
<cfargument name="description" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="testrequest" type="boolean" default="FALSE">
<cfargument name="customerType" type="string" default="">
<cfargument name="cardNumber" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="cardCode" type="string" default="">
<cfargument name="firstname" type="string" default="">
<cfargument name="lastname" type="string" default="">
<cfargument name="company" type="string" default="">
<cfargument name="address" type="string" default="">
<cfargument name="city" type="string" default="">
<cfargument name="state" type="string" default="">
<cfargument name="zip" type="string" default="">
<cfargument name="faxNumber" type="string" default="">
<cfargument name="country" type="string" default="">
<cfargument name="phoneNumber" type="string" default="">
<cfargument name="accountType" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="bankName" type="string" default="">
<cfargument name="validate" type="boolean" default="true">
<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = arguments.customerPaymentProfileId>
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />
		
		<CFIF arguments.cardNumber is not "">
		<cfset response.PaymentProfileType = "credit" />
		<CFELSE>
		<cfset response.PaymentProfileType = "bank" />
		</CFIF>

		<cfset response.address = arguments.address>
		<cfset response.city = arguments.city>
		<cfset response.company = arguments.company>
		<cfset response.country = arguments.country>
		<cfset response.faxnumber = arguments.faxnumber>
		<cfset response.firstname = arguments.firstname>
		<cfset response.lastname = arguments.lastname>
		<cfset response.phonenumber = arguments.phonenumber>
		<cfset response.state = arguments.state>
		<cfset response.zip = arguments.zip>
		
		<cfset response.cardnumber = right(rereplace(arguments.cardnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.expirationdate  = "#left(arguments.expirationDate, 2)##right(arguments.expirationDate, 2)#">
		
		<cfset response.accountnumber = right(rereplace(arguments.accountnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.routingnumber = right(rereplace(arguments.routingnumber, "[^0-9]+", "", "ALL"), 4)>
		<cfset response.accounttype = arguments.accounttype>
		<cfset response.bankname = arguments.bankname>
		<cfset response.echecktype = arguments.echecktype>
		<cfset response.nameonaccount = arguments.nameonaccount>
		<cfset response.customerType = arguments.customerType>

<CFIF arguments.echeckType is "" and arguments.accountType is not "">
<cfswitch expression="#arguments.accountType#">
<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
</cfswitch>
</CFIF>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<updateCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <paymentProfile><CFIF arguments.customerType is not "">
    <customerType>#arguments.customerType#</customerType></CFIF>
    <billTo>
      <firstName>#myXMLFormat(arguments.firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
      <lastName>#myXMLFormat(arguments.lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
      <company>#myXMLFormat(arguments.company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
      <address>#myXMLFormat(arguments.address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
      <city>#myXMLFormat(arguments.city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
      <state>#arguments.state#</state><!--- A valid two-character state code --->
      <zip>#myXMLFormat(arguments.zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
      <country>#myXMLFormat(arguments.country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
      <phoneNumber>#rereplace(arguments.phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
      <faxNumber>#rereplace(arguments.faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    </billTo>
    <payment><CFIF arguments.cardNumber is not "">
      <creditCard>
        <cardNumber><CFIF len(arguments.cardNumber) is 4>XXXX</CFIF>#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#</cardNumber>
        <expirationDate><CFIF arguments.expirationDate is "">XXXX<CFELSE>20#right(arguments.expirationDate, 2)#-#left(arguments.expirationDate, 2)#</CFIF></expirationDate><!--- YYYY-MM ---><CFIF arguments.cardCode is not "">
        <cardCode>#arguments.cardCode#</cardCode></CFIF>
      </creditCard><CFELSEIF arguments.accountNumber is not "">
      <bankAccount><CFIF arguments.accountType is not "">
        <accountType>#arguments.accountType#</accountType><!--- checking,savings,businessChecking ---></CFIF>
        <routingNumber><CFIF len(arguments.routingNumber) is 4>XXXX</CFIF>#arguments.routingNumber#</routingNumber><!--- 9 digits --->
        <accountNumber><CFIF len(arguments.accountNumber) is 4>XXXX</CFIF>#arguments.accountNumber#</accountNumber><!--- 5 to 17 digits ---><CFIF arguments.nameOnAccount is not "">
        <nameOnAccount>#myXMLFormat(arguments.nameOnAccount, arguments.useXmlFormat)#</nameOnAccount><!--- full name as listed on the bank account Up to 22 characters ---></CFIF><CFIF arguments.echeckType is not "">
        <echeckType>#arguments.echeckType#</echeckType><!--- Optional,CCD,PPD,TEL,WEB (we use WEB) ---></CFIF><CFIF arguments.bankName is not "">
        <bankName>#myXMLFormat(arguments.bankName, arguments.useXmlFormat)#</bankName><!--- Optional Up to 50 characters ---></CFIF>
      </bankAccount></CFIF>
    </payment>
    <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId>
  </paymentProfile><CFIF arguments.validate>
  <validationMode><CFIF arguments.testrequest>testMode<CFELSE>liveMode</CFIF></validationMode></CFIF>
</updateCustomerPaymentProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.updateCustomerPaymentProfileResponse.messages.message')>
	<CFIF response.XmlResponse.updateCustomerPaymentProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.updateCustomerPaymentProfileResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.updateCustomerPaymentProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.updateCustomerPaymentProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<CFIF isDefined('response.XmlResponse.updateCustomerPaymentProfileResponse.validationDirectResponse')>
<cfset response.resultstring = response.XmlResponse.updateCustomerPaymentProfileResponse.validationDirectResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
	<CFIF isStruct(result)>
	<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
	<CFELSE>
	<cfthrow message="#result#">
	</CFIF>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="validateCustomerPaymentProfile" access="public" returntype="struct" output="false" hint="Validates a one penny transaction against new CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="ADC_Delim_Character" type="string" default="#variables.ADC_Delim_Character#">
<cfargument name="Encapsulate_Character" type="string" default='#variables.Encapsulate_Character#'>
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerPaymentProfileId" type="string" default="">
<cfargument name="cardCode" type="string" default="">
<cfargument name="testrequest" type="boolean" default="FALSE">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = arguments.customerPaymentProfileId>
		
		<cfset response.response_code = "3" />
		<cfset response.reason_code = "" />
		<cfset response.authorization_code = "" />
		<cfset response.response_text = "" />
		<cfset response.avs_code = "" />
		<cfset response.trans_id = "" />
		<cfset response.card_code_response = "" />
		<cfset response.cavv_response = "" />
		<cfset response.resultstring = "" />

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<validateCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId><CFIF arguments.cardcode is not "">
      <cardCode>#arguments.cardcode#</cardCode></CFIF>
  <validationMode><CFIF arguments.testrequest>testMode<CFELSE>liveMode</CFIF></validationMode>
</validateCustomerPaymentProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.validateCustomerPaymentProfileResponse.messages.message')>
	<CFIF response.XmlResponse.validateCustomerPaymentProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.validateCustomerPaymentProfileResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.validateCustomerPaymentProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.validateCustomerPaymentProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<CFIF isDefined('response.XmlResponse.validateCustomerPaymentProfileResponse.DirectResponse')>
<cfset response.resultstring = response.XmlResponse.validateCustomerPaymentProfileResponse.directResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
	<CFIF isStruct(result)>
	<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
	<CFELSE>
	<cfthrow message="#result#">
	</CFIF>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="createCustomerShippingAddress" access="public" returntype="struct" output="false" hint="Creates a new CIM Customer Shipping Address.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">

<cfargument name="ship_firstname" type="string" default="">
<cfargument name="ship_lastname" type="string" default="">
<cfargument name="ship_company" type="string" default="">
<cfargument name="ship_address" type="string" default="">
<cfargument name="ship_city" type="string" default="">
<cfargument name="ship_state" type="string" default="">
<cfargument name="ship_zip" type="string" default="">
<cfargument name="ship_country" type="string" default="">
<cfargument name="ship_phoneNumber" type="string" default="">
<cfargument name="ship_faxNumber" type="string" default="">

<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerAddressId = "">

		<cfset response.address = arguments.ship_address>
		<cfset response.city = arguments.ship_city>
		<cfset response.company = arguments.ship_company>
		<cfset response.country = arguments.ship_country>
		<cfset response.faxnumber = arguments.ship_faxnumber>
		<cfset response.firstname = arguments.ship_firstname>
		<cfset response.lastname = arguments.ship_lastname>
		<cfset response.phonenumber = arguments.ship_phonenumber>
		<cfset response.state = arguments.ship_state>
		<cfset response.zip = arguments.ship_zip>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<createCustomerShippingAddressRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <address>
    <firstName>#myXMLFormat(arguments.ship_firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
    <lastName>#myXMLFormat(arguments.ship_lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
    <company>#myXMLFormat(arguments.ship_company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
    <address>#myXMLFormat(arguments.ship_address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
    <city>#myXMLFormat(arguments.ship_city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
    <state>#arguments.ship_state#</state><!--- A valid two-character state code --->
    <zip>#myXMLFormat(arguments.ship_zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
    <country>#myXMLFormat(arguments.ship_country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
    <phoneNumber>#rereplace(arguments.ship_phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    <faxNumber>#rereplace(arguments.ship_faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
  </address>
</createCustomerShippingAddressRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.createCustomerShippingAddressResponse.messages.message')>
	<CFIF response.XmlResponse.createCustomerShippingAddressResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.createCustomerShippingAddressResponse.refId.XmlText>
<cfset response.customerAddressId = response.XmlResponse.createCustomerShippingAddressResponse.customerAddressId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.createCustomerShippingAddressResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.createCustomerShippingAddressResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="updateCustomerShippingAddress" access="public" returntype="struct" output="false" hint="Updates a CIM Customer Shipping Address.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerAddressId" type="string" default="">

<cfargument name="ship_firstname" type="string" default="">
<cfargument name="ship_lastname" type="string" default="">
<cfargument name="ship_company" type="string" default="">
<cfargument name="ship_address" type="string" default="">
<cfargument name="ship_city" type="string" default="">
<cfargument name="ship_state" type="string" default="">
<cfargument name="ship_zip" type="string" default="">
<cfargument name="ship_country" type="string" default="">
<cfargument name="ship_phoneNumber" type="string" default="">
<cfargument name="ship_faxNumber" type="string" default="">

<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerAddressId = arguments.customerAddressId>

		<cfset response.address = arguments.ship_address>
		<cfset response.city = arguments.ship_city>
		<cfset response.company = arguments.ship_company>
		<cfset response.country = arguments.ship_country>
		<cfset response.faxnumber = arguments.ship_faxnumber>
		<cfset response.firstname = arguments.ship_firstname>
		<cfset response.lastname = arguments.ship_lastname>
		<cfset response.phonenumber = arguments.ship_phonenumber>
		<cfset response.state = arguments.ship_state>
		<cfset response.zip = arguments.ship_zip>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<updateCustomerShippingAddressRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <address>
    <firstName>#myXMLFormat(arguments.ship_firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
    <lastName>#myXMLFormat(arguments.ship_lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
    <company>#myXMLFormat(arguments.ship_company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) --->
    <address>#myXMLFormat(arguments.ship_address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) --->
    <city>#myXMLFormat(arguments.ship_city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) --->
    <state>#arguments.ship_state#</state><!--- A valid two-character state code --->
    <zip>#myXMLFormat(arguments.ship_zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) --->
    <country>#myXMLFormat(arguments.ship_country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) --->
    <phoneNumber>#rereplace(arguments.ship_phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    <faxNumber>#rereplace(arguments.ship_faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 --->
    <customerAddressId>#arguments.customerAddressId#</customerAddressId>
  </address>
</updateCustomerShippingAddressRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.updateCustomerShippingAddressResponse.messages.message')>
	<CFIF response.XmlResponse.updateCustomerShippingAddressResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.updateCustomerShippingAddressResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.updateCustomerShippingAddressResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.updateCustomerShippingAddressResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="deleteCustomerPaymentProfile" access="public" returntype="struct" output="false" hint="Deletes a CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerPaymentProfileId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = arguments.customerPaymentProfileId>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<deleteCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId>
</deleteCustomerPaymentProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.deleteCustomerPaymentProfileResponse.messages.message')>
	<CFIF response.XmlResponse.deleteCustomerPaymentProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.deleteCustomerPaymentProfileResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.deleteCustomerPaymentProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.deleteCustomerPaymentProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="getCustomerPaymentProfile" access="public" returntype="struct" output="false" hint="Gets a CIM Customer Payment Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerPaymentProfileId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerPaymentProfileId = "">
		<cfset response.paymentprofiledescription = "">
		
		<cfset response.customerType = "">
		
		<cfset response.address = "">
		<cfset response.city = "">
		<cfset response.company = "">
		<cfset response.country = "">
		<cfset response.faxnumber = "">
		<cfset response.firstname = "">
		<cfset response.lastname = "">
		<cfset response.phonenumber = "">
		<cfset response.state = "">
		<cfset response.zip = "">
		
		<cfset response.PaymentProfileType = "" />
		
		<cfset response.cardnumber = "">
		<cfset response.expirationdate  = "">
		
		<cfset response.accountnumber = "">
		<cfset response.accounttype = "">
		<cfset response.bankname = "">
		<cfset response.echecktype = "">
		<cfset response.nameonaccount = "">
		<cfset response.routingnumber = "">

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<getCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <customerPaymentProfileId>#arguments.customerPaymentProfileId#</customerPaymentProfileId>
</getCustomerPaymentProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.getCustomerPaymentProfileResponse.messages.message')>
	<CFIF response.XmlResponse.getCustomerPaymentProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.getCustomerPaymentProfileResponse.refId.XmlText>
<cfset temp = response.XmlResponse.getCustomerPaymentProfileResponse.PaymentProfile>
		<CFIF isDefined('temp.customerType')><cfset response.customerType = temp.customerType.XmlText></CFIF>
<cfset response.customerPaymentProfileId = temp.customerPaymentProfileId.XmlText>
<cfset response.address = temp.billTo.address.XmlText>
<cfset response.city = temp.billTo.city.XmlText>
<cfset response.company = temp.billTo.company.XmlText>
<cfset response.country = temp.billTo.country.XmlText>
<cfset response.faxnumber = temp.billTo.faxnumber.XmlText>
<cfset response.firstname = temp.billTo.firstname.XmlText>
<cfset response.lastname = temp.billTo.lastname.XmlText>
<cfset response.phonenumber = temp.billTo.phonenumber.XmlText>
<cfset response.state = temp.billTo.state.XmlText>
<cfset response.zip = temp.billTo.zip.XmlText>
		<CFIF isDefined('temp.payment.creditCard')>
<cfset response.PaymentProfileType = "credit" />
<cfset response.paymentprofiledescription = "#temp.billTo.firstname.XmlText# #temp.billTo.lastname.XmlText# (credit card #temp.payment.creditCard.cardnumber.XmlText#)">
<cfset response.cardnumber = temp.payment.creditCard.cardnumber.XmlText>
<cfset response.expirationdate  = temp.payment.creditCard.expirationdate.XmlText>
		<CFELSEIF isDefined('temp.payment.bankAccount')>
<cfset response.PaymentProfileType = "bank" />
<cfset response.accountnumber = temp.payment.bankAccount.accountnumber.XmlText><CFIF structkeyexists(temp.payment.bankAccount, 'accounttype')>
<cfset response.accounttype = temp.payment.bankAccount.accounttype.XmlText></CFIF><CFIF structkeyexists(temp.payment.bankAccount, 'bankname')>
<cfset response.bankname = temp.payment.bankAccount.bankname.XmlText></CFIF><CFIF structkeyexists(temp.payment.bankAccount, 'echecktype')>
<cfset response.echecktype = temp.payment.bankAccount.echecktype.XmlText></CFIF><CFIF structkeyexists(temp.payment.bankAccount, 'nameonaccount')>
<cfset response.nameonaccount = temp.payment.bankAccount.nameonaccount.XmlText></CFIF>
<cfset response.routingnumber = temp.payment.bankAccount.routingnumber.XmlText>
<cfswitch expression="#response.accounttype#">
<cfcase value = "checking"><cfset response.paymentprofiledescription = "#temp.payment.bankAccount.nameonaccount.XmlText# (checking acct. #temp.payment.bankAccount.accountnumber.XmlText#)"></cfcase>
<cfcase value = "businessChecking"><cfset response.paymentprofiledescription = "#temp.payment.bankAccount.nameonaccount.XmlText# (business checking #temp.payment.bankAccount.accountnumber.XmlText#)"></cfcase>
<cfcase value = "savings"><cfset response.paymentprofiledescription = "#temp.payment.bankAccount.nameonaccount.XmlText# (savings account #temp.payment.bankAccount.accountnumber.XmlText#)"></cfcase>
<cfdefaultcase><cfset response.paymentprofiledescription = "#temp.payment.bankAccount.nameonaccount.XmlText# (bank account #temp.payment.bankAccount.accountnumber.XmlText#)"></cfdefaultcase>
</cfswitch>
		</CFIF>

	<CFELSE>
<cfset response.error = response.XmlResponse.getCustomerPaymentProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.getCustomerPaymentProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="deleteCustomerShippingAddress" access="public" returntype="struct" output="false" hint="Deletes a CIM Customer Shipping Address.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerAddressId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerAddressId = arguments.customerAddressId>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<deleteCustomerShippingAddressRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <customerAddressId>#arguments.customerAddressId#</customerAddressId>
</deleteCustomerShippingAddressRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.deleteCustomerShippingAddressResponse.messages.message')>
	<CFIF response.XmlResponse.deleteCustomerShippingAddressResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.deleteCustomerShippingAddressResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.deleteCustomerShippingAddressResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.deleteCustomerShippingAddressResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="getCustomerShippingAddress" access="public" returntype="struct" output="false" hint="Gets a CIM Customer Shipping Address.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">
<cfargument name="customerAddressId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.customerProfileId = arguments.customerProfileId>
		<cfset response.customerAddressId = "">
		<cfset response.AddressDescription = "">
		
		<cfset response.address = "">
		<cfset response.city = "">
		<cfset response.company = "">
		<cfset response.country = "">
		<cfset response.faxnumber = "">
		<cfset response.firstname = "">
		<cfset response.lastname = "">
		<cfset response.phonenumber = "">
		<cfset response.state = "">
		<cfset response.zip = "">

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<getCustomerShippingAddressRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
  <customerAddressId>#arguments.customerAddressId#</customerAddressId>
</getCustomerShippingAddressRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.getCustomerShippingAddressResponse.messages.message')>
	<CFIF response.XmlResponse.getCustomerShippingAddressResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.getCustomerShippingAddressResponse.refId.XmlText>
<cfset temp = response.XmlResponse.getCustomerShippingAddressResponse.Address>
<cfset response.customerAddressId = temp.customerAddressId.XmlText>
<cfset response.address = temp.address.XmlText>
<cfset response.city = temp.city.XmlText>
<cfset response.company = temp.company.XmlText>
<cfset response.country = temp.country.XmlText>
<cfset response.faxnumber = temp.faxnumber.XmlText>
<cfset response.firstname = temp.firstname.XmlText>
<cfset response.lastname = temp.lastname.XmlText>
<cfset response.phonenumber = temp.phonenumber.XmlText>
<cfset response.state = temp.state.XmlText>
<cfset response.zip = temp.zip.XmlText>
<cfset response.AddressDescription = "#response.address#, #response.firstname# #response.lastname#">

	<CFELSE>
<cfset response.error = response.XmlResponse.getCustomerShippingAddressResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.getCustomerShippingAddressResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="getCustomerProfileIds" access="public" returntype="struct" output="false" hint="Gets a list of all CIM Customer Profile IDs.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.customerProfileIdList = "">

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<getCustomerProfileIdsRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
</getCustomerProfileIdsRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.getCustomerProfileIdsResponse.messages.message')>
	<CFIF response.XmlResponse.getCustomerProfileIdsResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.getCustomerProfileIdsResponse.refId.XmlText>
<cfloop index="i" from="1" to="#arraylen(response.XmlResponse.getCustomerProfileIdsResponse.IDs.numericString)#"><cfset response.customerProfileIdList = listappend(response.customerProfileIdList, response.XmlResponse.getCustomerProfileIdsResponse.IDs.numericString[i].XmlText)></cfloop>
	<CFELSE>
<cfset response.error = response.XmlResponse.getCustomerProfileIdsResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.getCustomerProfileIdsResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="getCustomerProfile" access="public" returntype="struct" output="false" hint="Gets a CIM Customer Profile.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="customerProfileId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		
		<cfset response.merchantCustomerId = "">
		<cfset response.customerdescription = "">
		<cfset response.email = "">
		<cfset response.customerProfileId = "">
		<cfset response.customerPaymentProfileIdList = "">
		<cfset response.customerAddressIdList = "">
		<cfset response.PaymentProfiles = ""><!--- reset as query --->
		<cfset response.Addresses = ""><!--- reset as query --->

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<getCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <customerProfileId>#arguments.customerProfileId#</customerProfileId>
</getCustomerProfileRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.getCustomerProfileResponse.messages.message')>
	<CFIF response.XmlResponse.getCustomerProfileResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.getCustomerProfileResponse.refId.XmlText>
<cfset temp = response.XmlResponse.getCustomerProfileResponse.profile>
<cfset response.merchantCustomerId = temp.merchantCustomerId.XmlText>
<cfset response.customerdescription = temp.description.XmlText>
<cfset response.email = temp.email.XmlText>
<cfset response.customerProfileId = temp.customerProfileId.XmlText>
<cfset temp = xmlToQryCustomerProfile(response.XmlResponse)>
		<CFIF isQuery(temp.PaymentProfiles)><cfset response.PaymentProfiles = temp.PaymentProfiles><cfset response.customerPaymentProfileIdList = valuelist(temp.PaymentProfiles.customerPaymentProfileId)></CFIF>
		<CFIF isQuery(temp.Addresses)><cfset response.Addresses = temp.Addresses><cfset response.customerAddressIdList = valuelist(temp.Addresses.customerAddressId)></CFIF>
	<CFELSE>
<cfset response.error = response.XmlResponse.getCustomerProfileResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.getCustomerProfileResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="ARBCreateSubscription" access="public" returntype="struct" output="false" hint="Creates an Automated Recurring Billing Subscription.">
<cfargument name="refId" type="string" default="123456">
<cfargument name="login" type="string" default="7xG5qVRm65k">
<cfargument name="transactionkey" type="string" default="97p5B2MD2v4v7tA3">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">

<cfargument name="subscriptionName" type="string" default="Monthly Subscription">
<cfargument name="length" type="any" default="">
<cfargument name="unit" type="string" default="">
<cfargument name="startDate" type="any" default="">
<cfargument name="totalOccurrences" type="any" default="12">
<cfargument name="trialOccurrences" type="any" default="1">
<cfargument name="amount" type="any" default="">
<cfargument name="trialAmount" type="any" default="1.00">

<cfargument name="merchantCustomerId" type="string" default="">
<cfargument name="invoice" type="string" default="">
<cfargument name="description" type="string" default="">
<cfargument name="email" type="string" default="">
<cfargument name="cardNumber" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="cardCode" type="string" default="">

<cfargument name="accountType" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="bankName" type="string" default="">

<cfargument name="firstname" type="string" default="">
<cfargument name="lastname" type="string" default="">
<cfargument name="company" type="string" default="">
<cfargument name="address" type="string" default="">
<cfargument name="city" type="string" default="">
<cfargument name="state" type="string" default="">
<cfargument name="zip" type="string" default="">
<cfargument name="country" type="string" default="">
<cfargument name="phoneNumber" type="string" default="">
<cfargument name="faxNumber" type="string" default="">

<cfargument name="ship_firstname" type="string" default="">
<cfargument name="ship_lastname" type="string" default="">
<cfargument name="ship_company" type="string" default="">
<cfargument name="ship_address" type="string" default="">
<cfargument name="ship_city" type="string" default="">
<cfargument name="ship_state" type="string" default="">
<cfargument name="ship_zip" type="string" default="">
<cfargument name="ship_country" type="string" default="">
<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">
<cfset arguments.amount = 1>

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.subscriptionId = "">
<!--- <cfdump var="#arguments#"> --->
<CFIF arguments.echeckType is "" and arguments.accountNumber is not "">
<cfswitch expression="#arguments.accountType#">
<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
</cfswitch>
</CFIF>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<ARBCreateSubscriptionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <subscription>
    <name>#myXMLFormat(arguments.subscriptionname, arguments.useXmlFormat)#</name>
    <paymentSchedule>
      <interval>
        <length>1</length>
        <unit>months</unit>
      </interval>
      <startDate>#DateFormat(arguments.startDate, "YYYY-MM-DD")#</startDate>
      <totalOccurrences>#arguments.totalOccurrences#</totalOccurrences><CFIF isNumeric(arguments.trialOccurrences) and arguments.trialOccurrences GT 0>
      <trialOccurrences>#arguments.trialOccurrences#</trialOccurrences></CFIF>
    </paymentSchedule>
    <amount>#arguments.amount#</amount><CFIF isNumeric(arguments.trialOccurrences) and arguments.trialOccurrences GT 0>
    <trialAmount><CFIF isNumeric(arguments.trialAmount)>#arguments.trialAmount#<CFELSE>0.00</CFIF></trialAmount></CFIF>
    <payment><CFIF arguments.cardNumber is not "">
      <creditCard>
        <cardNumber><CFIF len(arguments.cardNumber) is 4>XXXX#arguments.cardNumber#<CFELSE>#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#</CFIF></cardNumber>
        <expirationDate>20#right(arguments.expirationDate, 2)#-#left(arguments.expirationDate, 2)#</expirationDate><!--- YYYY-MM ---><CFIF arguments.cardCode is not "">
        <cardCode>#arguments.cardCode#</cardCode></CFIF>
      </creditCard><CFELSEIF arguments.accountNumber is not "">
      <bankAccount>
        <accountType>#arguments.accountType#</accountType><!--- checking,savings,businessChecking --->
        <routingNumber>#arguments.routingNumber#</routingNumber><!--- 9 digits --->
        <accountNumber>#arguments.accountNumber#</accountNumber><!--- 5 to 17 digits --->
        <nameOnAccount>#myXMLFormat(arguments.nameOnAccount, arguments.useXmlFormat)#</nameOnAccount><!--- full name as listed on the bank account Up to 22 characters --->
        <echeckType>#arguments.echeckType#</echeckType><!--- Optional,CCD,PPD,TEL,WEB (we use WEB) --->
        <bankName>#myXMLFormat(arguments.bankName, arguments.useXmlFormat)#</bankName><!--- Optional Up to 50 characters --->
      </bankAccount></CFIF>
    </payment>
  	
    
    <billTo>
      <firstName>#myXMLFormat(arguments.firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) --->
      <lastName>#myXMLFormat(arguments.lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) --->
     
    </billTo>
    
  </subscription>
</ARBCreateSubscriptionRequest></cfsavecontent></CFOUTPUT>

<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>
<!--- <cfdump var="#cfhttp#"> --->
<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>
<cfdump var="#response.XmlResponse.ARBCreateSubscriptionResponse.messages.resultCode[1].XmlText#">
<CFIF isDefined('response.XmlResponse.ARBCreateSubscriptionResponse.messages.message')>
	<CFIF response.XmlResponse.ARBCreateSubscriptionResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.ARBCreateSubscriptionResponse.refId.XmlText>
<cfset response.subscriptionId = response.XmlResponse.ARBCreateSubscriptionResponse.subscriptionId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.ARBCreateSubscriptionResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ARBCreateSubscriptionResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<CFIF isDefined('response.XmlResponse.ARBCreateSubscriptionResponse.validationDirectResponse')>
<cfset response.resultstring = response.XmlResponse.ARBCreateSubscriptionResponse.validationDirectResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
	<CFIF isStruct(result)>
	<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
	<CFELSE>
	<cfthrow message="#result#">
	</CFIF>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="ARBUpdateSubscription" access="public" returntype="struct" output="false" hint="Updates an Automated Recurring Billing Subscription.">
<cfargument name="refId" type="string" default="123456">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">

<cfargument name="subscriptionId" type="string" default="">
<cfargument name="subscriptionName" type="string" default="">
<cfargument name="startDate" type="any" default="">
<cfargument name="totalOccurrences" type="any" default="">
<cfargument name="trialOccurrences" type="any" default="">
<cfargument name="amount" type="any" default="">
<cfargument name="trialAmount" type="any" default="">

<cfargument name="cardNumber" type="string" default="">
<cfargument name="expirationDate" type="string" default="">
<cfargument name="cardCode" type="string" default="">

<cfargument name="accountType" type="string" default="">
<cfargument name="routingNumber" type="string" default="">
<cfargument name="accountNumber" type="string" default="">
<cfargument name="nameOnAccount" type="string" default="">
<cfargument name="echeckType" type="string" default="">
<cfargument name="bankName" type="string" default="">

<cfargument name="merchantCustomerId" type="string">
<cfargument name="invoice" type="string">
<cfargument name="description" type="string">
<cfargument name="email" type="string">
<cfargument name="phoneNumber" type="string">
<cfargument name="faxNumber" type="string">

<cfargument name="firstname" type="string">
<cfargument name="lastname" type="string">
<cfargument name="company" type="string">
<cfargument name="address" type="string">
<cfargument name="city" type="string">
<cfargument name="state" type="string">
<cfargument name="zip" type="string">
<cfargument name="country" type="string">

<cfargument name="ship_firstname" type="string">
<cfargument name="ship_lastname" type="string">
<cfargument name="ship_company" type="string">
<cfargument name="ship_address" type="string">
<cfargument name="ship_city" type="string">
<cfargument name="ship_state" type="string">
<cfargument name="ship_zip" type="string">
<cfargument name="ship_country" type="string">

<cfargument name="useXmlFormat" type="boolean" default="#variables.defaultXmlFormat#">
		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.subscriptionId = arguments.subscriptionId>

<cfif arguments.nameOnAccount is "" and isDefined('arguments.firstname') and isDefined('arguments.lastname')>
<cfset nameOnAccount = Trim('#arguments.firstname# #arguments.lastname#') />
</cfif>

<CFIF arguments.echeckType is "" and arguments.accountNumber is not "">
<cfswitch expression="#arguments.accountType#">
<cfcase value = "businessChecking"><cfset arguments.echeckType = "CCD" /></cfcase>
<cfdefaultcase><cfset arguments.echeckType = "WEB" /></cfdefaultcase>
</cfswitch>
</CFIF>

<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<ARBUpdateSubscriptionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <subscriptionId>#arguments.subscriptionId#</subscriptionId>
  <subscription><CFIF arguments.subscriptionname is not "">
    <name>#myXMLFormat(arguments.subscriptionname, arguments.useXmlFormat)#</name></CFIF><CFIF arguments.startDate is not "" or arguments.totalOccurrences is not "" or arguments.trialOccurrences is not "">
    <paymentSchedule><CFIF arguments.startDate is not "">
      <startDate>#DateFormat(arguments.startDate, "YYYY-MM-DD")#</startDate></CFIF><CFIF isNumeric(arguments.totalOccurrences)>
      <totalOccurrences>#arguments.totalOccurrences#</totalOccurrences></CFIF><CFIF isNumeric(arguments.trialOccurrences)>
      <trialOccurrences>#arguments.trialOccurrences#</trialOccurrences></CFIF>
    </paymentSchedule></CFIF><CFIF isNumeric(arguments.amount)>
    <amount>#rereplace(decimalFormat(rereplace(arguments.amount, "[^0-9\.-]+", "", "ALL")), "[^0-9\.-]+", "", "ALL")#</amount></CFIF><CFIF isNumeric(arguments.trialAmount)>
    <trialAmount>#arguments.trialAmount#</trialAmount></CFIF><CFIF arguments.cardNumber is not "" or arguments.accountNumber is not "">
    <payment><CFIF arguments.cardNumber is not "">
      <creditCard>
        <cardNumber><CFIF len(arguments.cardNumber) is 4>XXXX#arguments.cardNumber#<CFELSE>#rereplace(arguments.cardNumber, "[^0-9]+", "", "ALL")#</CFIF></cardNumber>
        <expirationDate>20#right(arguments.expirationDate, 2)#-#left(arguments.expirationDate, 2)#</expirationDate><!--- YYYY-MM ---><CFIF arguments.cardCode is not "">
        <cardCode>#arguments.cardCode#</cardCode></CFIF>
      </creditCard><CFELSEIF arguments.accountNumber is not "">
      <bankAccount>
        <accountType>#arguments.accountType#</accountType><!--- checking,savings,businessChecking --->
        <routingNumber>#arguments.routingNumber#</routingNumber><!--- 9 digits --->
        <accountNumber>#arguments.accountNumber#</accountNumber><!--- 5 to 17 digits --->
        <nameOnAccount>#myXMLFormat(arguments.nameOnAccount, arguments.useXmlFormat)#</nameOnAccount><!--- full name as listed on the bank account Up to 22 characters --->
        <echeckType>#arguments.echeckType#</echeckType><!--- Optional,CCD,PPD,TEL,WEB (we use WEB) --->
        <bankName>#myXMLFormat(arguments.bankName, arguments.useXmlFormat)#</bankName><!--- Optional Up to 50 characters --->
      </bankAccount></CFIF>
    </payment></CFIF><CFIF isDefined('arguments.invoice') or isDefined('arguments.description')>
  	<order><CFIF isDefined('arguments.invoice')>
      <invoiceNumber>#arguments.invoice#</invoiceNumber></CFIF><CFIF isDefined('arguments.description')>
      <description>#myXMLFormat(arguments.description, arguments.useXmlFormat)#</description></CFIF>
    </order></CFIF><CFIF isDefined('arguments.merchantCustomerId') or isDefined('arguments.email') or isDefined('arguments.phoneNumber') or isDefined('arguments.faxNumber')>
    <customer><CFIF isDefined('arguments.merchantCustomerId')>
      <id>#arguments.merchantCustomerId#</id></CFIF><CFIF isDefined('arguments.email')>
      <email>#arguments.email#</email></CFIF><CFIF isDefined('arguments.phoneNumber')>
      <phoneNumber>#rereplace(arguments.phoneNumber, "[^0-9-()]+", "", "ALL")#</phoneNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 ---></CFIF><CFIF isDefined('arguments.faxNumber')>
      <faxNumber>#rereplace(arguments.faxNumber, "[^0-9-()]+", "", "ALL")#</faxNumber><!--- Up to 25 digits (no letters) Ex. (123)123-1234 ---></CFIF>
    </customer></CFIF><CFIF isDefined('arguments.firstName') or isDefined('arguments.lastName') or isDefined('arguments.company') or isDefined('arguments.address') or isDefined('arguments.city') or isDefined('arguments.state') or isDefined('arguments.zip') or isDefined('arguments.country')>
    <billTo><CFIF isDefined('arguments.firstName')>
      <firstName>#myXMLFormat(arguments.firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.lastName')>
      <lastName>#myXMLFormat(arguments.lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.company')>
      <company>#myXMLFormat(arguments.company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.address')>
      <address>#myXMLFormat(arguments.address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.city')>
      <city>#myXMLFormat(arguments.city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.state')>
      <state>#arguments.state#</state><!--- A valid two-character state code ---></CFIF><CFIF isDefined('arguments.zip')>
      <zip>#myXMLFormat(arguments.zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.country')>
      <country>#myXMLFormat(arguments.country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) ---></CFIF>
    </billTo></CFIF><CFIF isDefined('arguments.ship_address')>
    <shipTo><CFIF isDefined('arguments.ship_firstName') or isDefined('arguments.ship_lastName') or isDefined('arguments.ship_company') or isDefined('arguments.ship_address') or isDefined('arguments.ship_city') or isDefined('arguments.ship_state') or isDefined('arguments.ship_zip') or isDefined('arguments.ship_country')>
      <firstName>#myXMLFormat(arguments.ship_firstName, arguments.useXmlFormat)#</firstName><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_lastName')>
      <lastName>#myXMLFormat(arguments.ship_lastName, arguments.useXmlFormat)#</lastName><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_company')>
      <company>#myXMLFormat(arguments.ship_company, arguments.useXmlFormat)#</company><!--- Up to 50 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_address')>
      <address>#myXMLFormat(arguments.ship_address, arguments.useXmlFormat)#</address><!--- Up to 60 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_city')>
      <city>#myXMLFormat(arguments.ship_city, arguments.useXmlFormat)#</city><!--- Up to 40 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_state')>
      <state>#arguments.ship_state#</state><!--- A valid two-character state code ---></CFIF><CFIF isDefined('arguments.ship_zip')>
      <zip>#myXMLFormat(arguments.ship_zip, arguments.useXmlFormat)#</zip><!--- Up to 20 characters (no symbols) ---></CFIF><CFIF isDefined('arguments.ship_country')>
      <country>#myXMLFormat(arguments.ship_country, arguments.useXmlFormat)#</country><!--- Up to 60 characters (no symbols) ---></CFIF>
    </shipTo></CFIF>
  </subscription>
</ARBUpdateSubscriptionRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.ARBUpdateSubscriptionResponse.messages.message')>
	<CFIF response.XmlResponse.ARBUpdateSubscriptionResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.ARBUpdateSubscriptionResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.ARBUpdateSubscriptionResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ARBUpdateSubscriptionResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<CFIF isDefined('response.XmlResponse.ARBUpdateSubscriptionResponse.validationDirectResponse')>
<cfset response.resultstring = response.XmlResponse.ARBUpdateSubscriptionResponse.validationDirectResponse.XmlText>
<cfset result = parseResult(mystring=response.resultstring,argumentcollection=arguments)>
	<CFIF isStruct(result)>
	<cfloop index="i" list="#StructKeyList(result)#"><cfset tmp = StructInsert(response, i, StructFind(result, i), true)></cfloop>
	<CFELSE>
	<cfthrow message="#result#">
	</CFIF>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="ARBCancelSubscription" access="public" returntype="struct"  output="false" hint="Cancels an Automated Recurring Billing Subscription.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="subscriptionId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.subscriptionId = arguments.subscriptionId>
<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<ARBCancelSubscriptionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <!--- <refId>#arguments.refId#</refId> ---><!--- Included in response. 20 char max. --->
  <subscriptionId>#arguments.subscriptionId#</subscriptionId>
</ARBCancelSubscriptionRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>
<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.ARBCancelSubscriptionResponse.messages.message')>
	<CFIF response.XmlResponse.ARBCancelSubscriptionResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.ARBCancelSubscriptionResponse.refId.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.ARBCancelSubscriptionResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ARBCancelSubscriptionResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="ARBGetSubscriptionStatus" access="public" returntype="struct" output="false" hint="Gets the status of an Automated Recurring Billing Subscription.">
<cfargument name="refId" type="string" default="">
<cfargument name="login" type="string" default="#variables.login#">
<cfargument name="transactionkey" type="string" default="#variables.transactionkey#">
<cfargument name="error_email_from" type="string" default="">
<cfargument name="error_email_to" type="string" default="">
<cfargument name="error_subject" type="string" default="AutNetTools.cfc Error">
<cfargument name="error_smtp" type="string" default="">
<cfargument name="subscriptionId" type="string" default="">

		<cfset var response = StructNew() />
		<cfset var cfhttp	= "" />
		<cfset var temp	= "" />
		<cfset var result = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.environment = variables.environment /><!--- xml error codes --->
		<cfset response.XmlRequest = "" />
		<cfset response.XmlResponse = "" />
		<cfset response.refId = "">
		<cfset response.subscriptionId = arguments.subscriptionId>
<cftry>
<CFOUTPUT><cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
<ARBGetSubscriptionStatusRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
  <merchantAuthentication>
    <name>7xG5qVRm65k</name>
    <transactionKey>97p5B2MD2v4v7tA3</transactionKey>
  </merchantAuthentication>
  <refId>#arguments.refId#</refId><!--- Included in response. 20 char max. --->
  <subscriptionId>#arguments.subscriptionId#</subscriptionId>
</ARBGetSubscriptionStatusRequest></cfsavecontent></CFOUTPUT>
<cfset response.XmlRequest = xmlParse(myXml)>

<cfhttp url="#variables.url_CIM_ARB#" method="POST">
<cfhttpparam type="XML" name="xml" value="#myXml#">
</cfhttp>

<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

<cfset response.XmlResponse = xmlParse(response.XmlResponse)>

<CFIF isDefined('response.XmlResponse.ARBGetSubscriptionStatusResponse.messages.message')>
	<CFIF response.XmlResponse.ARBGetSubscriptionStatusResponse.messages.resultCode[1].XmlText is "Ok">
<cfset response.refId = response.XmlResponse.ARBGetSubscriptionStatusResponse.refId.XmlText>
<cfset response.status = response.XmlResponse.ARBGetSubscriptionStatusResponse.status.XmlText>
	<CFELSE>
<cfset response.error = response.XmlResponse.ARBGetSubscriptionStatusResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ARBGetSubscriptionStatusResponse.messages.message[1].code.XmlText>
	</CFIF>
<CFELSEIF isDefined('response.XmlResponse.ErrorResponse.messages.message')>
<cfset response.error = response.XmlResponse.ErrorResponse.messages.message[1].text.XmlText>
<cfset response.errorcode = response.XmlResponse.ErrorResponse.messages.message[1].code.XmlText>
</CFIF>

<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<CFIF response.error is not "" and arguments.error_email_to is not ""><cfset temp = emailError(a=arguments,r=response)></CFIF>
<cfreturn response />
	</cffunction>
	
	<cffunction name="xmlToQryCustomerProfile" access="public" returntype="struct" output="false" hint="Returns the payment profiles and addresses from getCustomerProfile in query form.">
<cfargument name="xmlrequest" type="xml">

		<cfset var response = StructNew() />
		<cfset var temp	= "" />
		<cfset var profile = "" />
		<cfset var PaymentProfiles = "" />
		<cfset var ShipToList = "" />
		<cfset var i = "" />

		<cfset response.error = "" /><!--- xml errors --->
		<cfset response.errorcode = "0" />
		<cfset response.PaymentProfiles = QueryNew('customerProfileId,merchantCustomerId,email,paymentprofiledescription,customerPaymentProfileId,customerType,address,city,company,country,faxnumber,firstname,lastname,phonenumber,state,zip,PaymentProfileType,cardnumber,expirationdate,accountnumber,accounttype,bankname,echecktype,nameonaccount,routingnumber') />
		<cfset response.Addresses = QueryNew('customerProfileId,merchantCustomerId,email,addressdescription,customerAddressId,address,city,company,country,faxnumber,firstname,lastname,phonenumber,state,zip') />
<cftry>
<cfset profile = arguments.xmlrequest.getCustomerProfileResponse.profile>
<CFIF isDefined('arguments.xmlrequest.getCustomerProfileResponse.profile.paymentprofiles')>
<cfset paymentprofiles = arguments.xmlrequest.getCustomerProfileResponse.profile.paymentprofiles>
<cfloop index="i" from="1" to="#arraylen(paymentprofiles)#">
<cfset temp = queryAddRow(response.PaymentProfiles)>
<cfset temp = querySetCell(response.PaymentProfiles, 'customerProfileId', profile.customerProfileId.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'merchantCustomerId', profile.merchantCustomerId.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'email', profile.email.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'customerPaymentProfileId', PaymentProfiles[i].customerPaymentProfileId.XmlText)>
	<CFIF structkeyexists(PaymentProfiles[i], 'customerType')><cfset temp = querySetCell(response.PaymentProfiles, 'customerType', PaymentProfiles[i].customerType.XmlText)></CFIF>
<cfset temp = querySetCell(response.PaymentProfiles, 'address', PaymentProfiles[i].billTo.address.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'city', PaymentProfiles[i].billTo.city.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'company', PaymentProfiles[i].billTo.company.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'country', PaymentProfiles[i].billTo.country.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'faxnumber', PaymentProfiles[i].billTo.faxnumber.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'firstname', PaymentProfiles[i].billTo.firstname.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'lastname', PaymentProfiles[i].billTo.lastname.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'phonenumber', PaymentProfiles[i].billTo.phonenumber.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'state', PaymentProfiles[i].billTo.state.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'zip', PaymentProfiles[i].billTo.zip.XmlText)>
	<CFIF structkeyexists(PaymentProfiles[i].payment, 'creditCard')>
<cfset temp = querySetCell(response.PaymentProfiles, 'PaymentProfileType', 'credit')>
<cfset temp = querySetCell(response.PaymentProfiles, 'paymentprofiledescription', '#PaymentProfiles[i].billTo.firstname.XmlText# #PaymentProfiles[i].billTo.lastname.XmlText# (credit card #PaymentProfiles[i].payment.creditCard.cardnumber.XmlText#)')>
<cfset temp = querySetCell(response.PaymentProfiles, 'cardnumber', PaymentProfiles[i].payment.creditCard.cardnumber.XmlText)>
<cfset temp = querySetCell(response.PaymentProfiles, 'expirationdate ', PaymentProfiles[i].payment.creditCard.expirationdate.XmlText)>
	<CFELSEIF structkeyexists(PaymentProfiles[i].payment, 'bankAccount')>
<cfset temp = querySetCell(response.PaymentProfiles, 'PaymentProfileType', 'bank')>
<cfset temp = querySetCell(response.PaymentProfiles, 'accountnumber', PaymentProfiles[i].payment.bankAccount.accountnumber.XmlText)><CFIF structkeyexists(PaymentProfiles[i].payment.bankAccount, 'accounttype')>
<cfset temp = querySetCell(response.PaymentProfiles, 'accounttype', PaymentProfiles[i].payment.bankAccount.accounttype.XmlText)></CFIF><CFIF structkeyexists(PaymentProfiles[i].payment.bankAccount, 'bankname')>
<cfset temp = querySetCell(response.PaymentProfiles, 'bankname', PaymentProfiles[i].payment.bankAccount.bankname.XmlText)></CFIF><CFIF structkeyexists(PaymentProfiles[i].payment.bankAccount, 'echecktype')>
<cfset temp = querySetCell(response.PaymentProfiles, 'echecktype', PaymentProfiles[i].payment.bankAccount.echecktype.XmlText)></CFIF><CFIF structkeyexists(PaymentProfiles[i].payment.bankAccount, 'nameonaccount')>
<cfset temp = querySetCell(response.PaymentProfiles, 'nameonaccount', PaymentProfiles[i].payment.bankAccount.nameonaccount.XmlText)></CFIF>
<cfset temp = querySetCell(response.PaymentProfiles, 'routingnumber', PaymentProfiles[i].payment.bankAccount.routingnumber.XmlText)>
<cfswitch expression="#response.PaymentProfiles.accounttype[i]#">
<cfcase value = "checking"><cfset temp = querySetCell(response.PaymentProfiles, 'paymentprofiledescription', '#response.PaymentProfiles.nameonaccount[i]# (checking account #response.PaymentProfiles.accountnumber[i]#)')></cfcase>
<cfcase value = "businessChecking"><cfset temp = querySetCell(response.PaymentProfiles, 'paymentprofiledescription', '#response.PaymentProfiles.nameonaccount[i]# (business checking #response.PaymentProfiles.accountnumber[i]#)')></cfcase>
<cfcase value = "savings"><cfset temp = querySetCell(response.PaymentProfiles, 'paymentprofiledescription', '#response.PaymentProfiles.nameonaccount[i]# (savings account #response.PaymentProfiles.accountnumber[i]#)')></cfcase>
<cfdefaultcase><cfset temp = querySetCell(response.PaymentProfiles, 'paymentprofiledescription', '#response.PaymentProfiles.nameonaccount[i]# (bank account #response.PaymentProfiles.accountnumber[i]#)')></cfdefaultcase>
</cfswitch>
	</CFIF>
</cfloop>
</CFIF>

<CFIF isDefined('arguments.xmlrequest.getCustomerProfileResponse.profile.shiptolist')>
<cfset shiptolist = arguments.xmlrequest.getCustomerProfileResponse.profile.shiptolist>
<cfloop index="i" from="1" to="#arraylen(shiptolist)#">
<cfset temp = queryAddRow(response.Addresses)>
<cfset temp = querySetCell(response.Addresses, 'customerProfileId', profile.customerProfileId.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'merchantCustomerId', profile.merchantCustomerId.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'email', profile.email.XmlText)>
	<CFIF shiptolist[i].city.XmlText is not "" and shiptolist[i].state.XmlText is not "">
<cfset temp = querySetCell(response.Addresses, 'addressdescription', '#shiptolist[i].address.XmlText#, #shiptolist[i].city.XmlText#, #shiptolist[i].state.XmlText#')>
	<CFELSE>
<cfset temp = querySetCell(response.Addresses, 'addressdescription', '#shiptolist[i].address.XmlText#, #shiptolist[i].country.XmlText#')>
	</CFIF>
<cfset temp = querySetCell(response.Addresses, 'customerAddressId', shiptolist[i].customerAddressId.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'address', shiptolist[i].address.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'city', shiptolist[i].city.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'company', shiptolist[i].company.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'country', shiptolist[i].country.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'faxnumber', shiptolist[i].faxnumber.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'firstname', shiptolist[i].firstname.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'lastname', shiptolist[i].lastname.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'phonenumber', shiptolist[i].phonenumber.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'state', shiptolist[i].state.XmlText)>
<cfset temp = querySetCell(response.Addresses, 'zip', shiptolist[i].zip.XmlText)>
</cfloop>
</CFIF>
<cfcatch type="any">
<CFIF cfcatch.detail is ""><cfset response.error = "#cfcatch.message#"><CFELSE><cfset response.error = "#cfcatch.message# - #cfcatch.detail#"></CFIF>
</cfcatch>
</cftry>
<cfreturn response />
	</cffunction>
	
	<cffunction name="emailError" access="public" returntype="boolean" output="false" hint="Sends an error email to the appropriate address.">
<cfargument name="a" type="struct">
<cfargument name="r" type="struct">
<cftry>
<CFIF arguments.a.error_smtp is not "">
<cfmail
server="#arguments.a.error_smtp#"
from="#arguments.a.error_email_from#"
to="#arguments.a.error_email_to#"
subject="#arguments.a.error_subject#">Error Code: #arguments.r.errorcode#
Error: #arguments.r.error#<CFIF isDefined('arguments.a.invoice')>
arguments.a.invoice=#arguments.a.invoice#</CFIF><CFIF isDefined('arguments.a.merchantCustomerId')>
arguments.a.merchantCustomerId=#arguments.a.merchantCustomerId#</CFIF>
</cfmail>
<CFELSE>
<cfmail
from="#arguments.a.error_email_from#"
to="#arguments.a.error_email_to#"
subject="#arguments.a.error_subject#">Error Code: #arguments.r.errorcode#
Error: #arguments.r.error#<CFIF isDefined('arguments.a.invoice')>
arguments.a.invoice=#arguments.a.invoice#</CFIF><CFIF isDefined('arguments.a.merchantCustomerId')>
arguments.a.merchantCustomerId=#arguments.a.merchantCustomerId#</CFIF>
</cfmail>
</CFIF>
<cfreturn true />
<cfcatch type="any"><cfreturn false /></cfcatch>
</cftry>
	</cffunction>

	<cffunction name="myXMLFormat" access="public" returntype="string" output="false" hint="I XmlFormat the input if requested.">
<cfargument name="in" type="string">
<cfargument name="useXmlFormat" type="boolean">
<cfif arguments.useXmlFormat><cfreturn XMLFormat(arguments.in) /></cfif>
<cfreturn in />
	</cffunction>

	<cffunction access="public" name="setDependentObject" returntype="void" output="false" hint="I can be used by an object factory to inject dependent objects if needed for customization, debugging, etc.">
		<cfargument name="obj" required="true" type="any" hint="The object being injected into this object.">
		<cfargument name="objName" required="true" type="string" hint="The name of the object being injected.">
		<cfset variables['#objName#'] = arguments.obj />
	</cffunction>

</cfcomponent>