<cfcomponent displayname="customers" hint="">
	
	<cffunction name="getCustomers" access="public" output="false" returntype="query" hint="Returns query of custmers">
		<cfargument name="Company_ID" type="numeric" required="false"> 
		<cfargument name="Professional_ID" type="numeric" required="false">
		
		<cfquery name="qGetCustomers" datasource="#request.dsn#">
			SELECT * 
			FROM customers
			WHERE 1=1
		
			<cfif isDefined('arguments.Company_ID')>
				AND Company_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Company_ID#">
			</cfif>
			ORDER BY Customer_ID DESC
		</cfquery>
		
		<cfreturn qGetCustomers>
	</cffunction>
	
	<cffunction name="deleteCustomer" access="remote" output="false">
		<cfargument name="Customer_ID" type="numeric" required="true">

		<cfquery datasource="#request.dsn#">
			DELETE FROM 
				customers 
			WHERE 
				Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Customer_ID#">
		</cfquery>
	</cffunction>
	



	<cffunction name="checkEmail" access="remote" output="false" returntype="string" returnformat="plain">
		<cfargument name="email" type="any" required="true">
		<!--- <cfdump var="#arguments#"><cfabort> --->
		<cfset variables.isEmailExist = 0>
		<cfif len(trim(arguments.email))>
			<cfquery datasource="#request.dsn#" name="checkEmailExist">
				SELECT
					count(*) as total
				FROM
					customers
				WHERE
					email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			</cfquery>
			<cfif checkEmailExist.total>
				<cfset variables.isEmailExist = 1>
			</cfif>
		</cfif>
		<cfif variables.isEmailExist>
			<cfreturn 1>
		</cfif>
		<cfreturn 0>
	</cffunction>	


	<cffunction name="setCustomer" access="remote" output="false" returntype="string" returnformat="plain">
		<cfargument name="firstName" type="string" required="true">
		<cfargument name="lastName" type="string" required="true">
		<cfargument name="mobileNumber" type="string" required="false">
		<cfargument name="emailId" type="string" required="false">
		<cfargument name="password" type="string" required="false">		
		<cfargument name="day" type="any" required="false">
		<cfargument name="month" type="any" required="false">
		<cfargument name="year" type="any" required="false">
		<cfargument name="address" type="string" required="false">
		<cfargument name="address2" type="string" required="false">
		<cfargument name="city" type="string" required="false">
		<cfargument name="state" type="string" required="false">
		<cfargument name="zipCode" type="string" required="false">
		<cfargument name="customerNotes" type="string" required="false">
		<cfargument name="companyNotes" type="string" required="false">
		<cfargument name="creditCardNumber" type="string" required="false">
		<cfargument name="nameOnCard" type="string" required="false">
		<cfargument name="billingAddress" type="string" required="false">
		<cfargument name="billingAddress2" type="string" required="false">
		<cfargument name="billingZipCode" type="string" required="false">
		<cfargument name="creditCardMonth" type="any" required="false">
		<cfargument name="creditCardYear" type="any" required="false">
		<cfargument name="ccvCode" type="any" required="false">
		<cfargument name="secondaryMobile" type="string" required="false">
		<cfargument name="billingState" type="string" required="false">
		<cfargument name="billingCity" type="string" required="false">
		
		<!--- <cfset variables.isEmailExist = false > --->
		<!--- <cfif len(trim(arguments.emailId))>
			<cfquery datasource="#request.dsn#" name="checkEmailExist">
				SELECT
					count(*) as total
				FROM
					customers
				WHERE
					email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailId#">
			</cfquery>
			<cfif checkEmailExist.total>
				<cfset variables.isEmailExist = true>
			</cfif>
		</cfif> --->
		<!--- <cfif not variables.isEmailExist> --->			
			<cfquery datasource="#request.dsn#" result="result">
				INSERT INTO
					customers (First_Name,Last_Name,Mobile_Phone,email_address,Password,Company_ID,Preferred_Professional_ID,BirthDate_Month,
					BirthDate_Day,Birthdate_Year,Address,Address2,City,State,Postal,Home_Phone,Customer_Notes,Company_Notes)
					<!---,Credit_Card_No,Name_On_Card,Billing_Address,Billing_Address2,Credit_Card_ExpMonth,Credit_Card_ExpYear<cfif len(trim(arguments.ccvCode))>,CVV_Code</cfif>,Billing_City,Billing_State,Billing_Postal)--->
					
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobileNumber#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailId#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.company_id#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.professional_id#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.month#" null="#not len(trim(arguments.month))#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.day#" null="#not len(trim(arguments.day))#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.year#" null="#not len(trim(arguments.year))#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address2#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zipCode#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.secondaryMobile#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.customerNotes#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.companyNotes#">
					<!---<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.creditCardNumber#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.nameOnCard#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingAddress#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingAddress2#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.creditCardMonth#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.creditCardYear#">,
					<cfif len(trim(arguments.ccvCode))>
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ccvCode#">,					
					</cfif>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingCity#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingState#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingZipCode#">--->
					)
			</cfquery>
			<cfreturn 1>
		<!--- </cfif> --->
		<!--- <cfreturn 0> --->
	</cffunction>
	
	<cffunction name="getCustomerToEdit" access="remote" output="false" returntype="any">
		<cfargument name="customerId" type="numeric" required="false"> 
		<cfquery name="qGetBlogPostEdit" datasource="#request.dsn#">
			SELECT
				First_Name,Last_Name,Mobile_Phone,Email_Address,Password,BirthDate_Month,
				BirthDate_Day,Birthdate_Year,Address,Address2,City,State,Postal,Home_Phone,Customer_Notes,Company_Notes,Credit_Card_No,
				Name_On_Card,Billing_Address,Billing_Address2,Credit_Card_ExpMonth,Credit_Card_ExpYear,CVV_Code,Billing_City,Billing_State,Billing_Postal
			FROM 
				customers
			WHERE
				Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.customerId#">
		</cfquery>
		<cfreturn SerializeJSON(qGetBlogPostEdit)>
	</cffunction>
	
	<cffunction name="updateCustomerDetails" access="remote" output="false" returntype="string" returnformat="plain">
		<cfargument name="firstName" type="string" required="true">
		<cfargument name="lastName" type="string" required="true">
		<cfargument name="mobileNumber" type="string" required="false">
		<cfargument name="emailId" type="string" required="false">
		<cfargument name="customerId" type="numeric" required="false">
		<cfargument name="day" type="string" required="false">
		<cfargument name="month" type="string" required="false">
		<cfargument name="year" type="string" required="false">
		<cfargument name="address" type="string" required="false">
		<cfargument name="address2" type="string" required="false">
		<cfargument name="city" type="string" required="false">
		<cfargument name="state" type="string" required="false">
		<cfargument name="zipCode" type="string" required="false">
		<cfargument name="customerNotes" type="string" required="false">
		<cfargument name="companyNotes" type="string" required="false">
		<cfargument name="creditCardNumber" type="string" required="false">
		<cfargument name="nameOnCard" type="string" required="false">
		<cfargument name="billingAddress" type="string" required="false">
		<cfargument name="billingAddress2" type="string" required="false">
		<cfargument name="billingZipCode" type="string" required="false">
		<cfargument name="creditCardMonth" type="any" required="false">
		<cfargument name="creditCardYear" type="any" required="false">
		<cfargument name="ccvCode" type="any" required="false">,
		<cfargument name="secondaryMobile" type="string" required="false">,
		<cfargument name="billingState" type="string" required="false">,
		<cfargument name="billingCity" type="string" required="false">
		
		<cfset variables.isEmailExist = false >
		<cfif len(trim(arguments.emailId))>
			<cfquery datasource="#request.dsn#" name="checkEmailExist">
				SELECT
					count(*) as total
				FROM
					customers
				WHERE
					Email_Address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailId#">
				AND
					Customer_ID != <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.customerId#">
			</cfquery>
			<cfif checkEmailExist.total>
				<cfset variables.isEmailExist = true>
			</cfif>
		</cfif>
		<cfif not variables.isEmailExist>	
			<cfquery datasource="#request.dsn#">
				UPDATE
					customers
				SET 
					First_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstName#">,
					Last_Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#">,
					Mobile_Phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobileNumber#">,
					Email_Address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailId#">,
					BirthDate_Month = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.month#" null="#not len(trim(arguments.month))#">,
					BirthDate_Day = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.day#" null="#not len(trim(arguments.day))#">,
					Birthdate_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.year#" null="#not len(trim(arguments.year))#">,
					Address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address#">,
					Address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address2#">,
					City = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">,
					State = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#">,
					Postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zipCode#">,
					Home_Phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.secondaryMobile#">,
					Customer_Notes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.customerNotes#">,
					Company_Notes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.companyNotes#">
					<!---Credit_Card_No = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.creditCardNumber#">,
					Name_On_Card = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.nameOnCard#">,
					Billing_Address =<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingAddress#">,
					Billing_Address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingAddress2#">,
					Credit_Card_ExpMonth = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.creditCardMonth#">,
					Credit_Card_ExpYear = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.creditCardYear#">,
					<cfif len(trim(arguments.ccvCode))>
						CVV_Code = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ccvCode#">,
					<cfelse>
						CVV_Code = <cfqueryparam value="0" cfsqltype="cf_sql_numeric" null="yes">,
					</cfif>
					Billing_City = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingCity#">,
					Billing_State = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingState#">,
					Billing_Postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.billingZipCode#">--->
				WHERE
					Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.customerId#">
			</cfquery>
			<cfreturn 1>
		</cfif>
		<cfreturn 0>
	</cffunction>
	
	<cffunction name="addNewCustomer" access="remote" output="true" returntype="string" returnformat="plain">
		<cfargument name="firstName" type="string" required="true">
		<cfargument name="lastName" type="string" required="true">
		<cfargument name="mobile" type="string" required="false">
		<cfargument name="email" type="string" required="false">
		<cfargument name="phone" type="string" required="false">
		<cfargument name="password" type="string" required="false">
		<cfargument name="company_id" type="numeric" required="false" default="0">
		<cfargument name="professional_id" type="numeric" required="false" default="0">
		<cfargument name="location_id" type="numeric" required="false" default="0">
		<!--- <cfset var variables.isEmailExists = false >
		<cfif len(trim(arguments.email))>
			<cfquery datasource="#request.dsn#" name="checkEmailExists">
				SELECT
					count(*) as total
				FROM
					customers
				WHERE
					email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			</cfquery>
			<cfif checkEmailExists.total>
				<cfset variables.isEmailExists = true>
			</cfif>
		</cfif> --->
		<cfif len(trim(arguments.email))>
			<cfquery datasource="#request.dsn#" name="checkEmailExists">
				SELECT
					count(*) as total
				FROM
					customers
				WHERE
					email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
					<cfif structkeyexists(arguments,"company_id") and len(arguments.company_id) >
						and Company_ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.company_id#">
					</cfif>
			</cfquery>
		</cfif>
		<!--- <cfif not variables.isEmailExists>	 --->
		<cfif not val(checkEmailExists.total)>	
			<cfquery name="qInsertCustomer" datasource="#request.dsn#" result="resultQuery">
				INSERT INTO
					customers (First_Name,Last_Name,Mobile_Phone,email_address,Password,Company_ID,Preferred_Professional_ID,Preferred_Location_ID,Home_Phone)
				VALUES(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobile#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.company_id)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.professional_id)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#val(arguments.location_id)#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#val(arguments.phone)#">
				)
			</cfquery>
		</cfif>
		<cfset calendarObj= createObject("component","appointmentsCalendarBean") /> 
		<cfset variables.qGetCustomersList  = calendarObj.getCustomersListBy(company_id = val(session.company_id))>
		<cfsavecontent variable="response">
			<option value="0">Select Customer</option>
			<cfoutput query="variables.qGetCustomersList">
				<option value="#variables.qGetCustomersList.customer_id#"> #variables.qGetCustomersList.first_name# #variables.qGetCustomersList.last_name# </option>
			</cfoutput>
		</cfsavecontent>
		<cfreturn trim(response)>
	</cffunction>
	
	<cffunction name="getCustomerDetailsById" access="public" output="false" returntype="any">
		<cfargument name="customerId" type="numeric" required="true"> 
		<cfquery name="qGetCustomerDetailsById" datasource="#request.dsn#">
			SELECT
				First_Name,Last_Name,Mobile_Phone,Email_Address,Password,BirthDate_Month,
				BirthDate_Day,Birthdate_Year,Address,Address2,City,State,Postal,Home_Phone,Customer_Notes,Company_Notes,Credit_Card_No,
				Name_On_Card,Billing_Address,Billing_Address2,Credit_Card_ExpMonth,Credit_Card_ExpYear,CVV_Code,Billing_City,Billing_State,Billing_Postal
			FROM 
				customers
			WHERE
				Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.customerId#">
		</cfquery>
		<cfreturn qGetCustomerDetailsById>
	</cffunction>
	
	<cffunction name="changeCustomerPassword" access="remote" output="false" returntype="any">
		<cfargument name="customerId" type="numeric" required="true">
		<cfargument name="password" type="string" required="true">
		<cfquery name="qChangeCustomerPassword" datasource="#request.dsn#">	
			UPDATE 
				customers
			SET 
				password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">
			WHERE 
				Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.customerId#">
		</cfquery>
	</cffunction>
	
	<cffunction name="emailAllCustomers" access="public" output="true" hint="Send Email to all customers">
		<cfargument name="Professional_ID" default="">
		<cfargument name="message" default="">
		
		<cfset variables.message_id = createUUID()>
		<cfquery name="qCustomerEmails" datasource="#request.dsn#">	
			select email_address from customers 
			where 
			Preferred_Professional_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Professional_ID#">
		</cfquery>
		
		<cfloop from="1" to="#qCustomerEmails.recordcount#" index="count">
			<cfset variables.toEmail = qCustomerEmails.email_address[count]>
			<cfif len(trim(variables.toEmail))>
				<cfquery name="qUpdateOpenEmail" datasource="#request.dsn#">	
					insert into email_marketing (
						email, message, message_id
					)
					values (
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.toEmail#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#arguments.message#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.message_id#">
					)
				</cfquery>
				<cfmail from="no-reply@salonworks.com" To="#variables.toEmail#" Subject="Email Marketing" type="html">
					<cfoutput>
						<img src="http://salonworksdev.com/admin/email_marketing_update.cfm?emailid=#variables.toEmail#&message_id=#variables.message_id#" width="1">
						<a href="http://salonworksdev.com/newgallery.cfm?emailid=#variables.toEmail#&message_id=#variables.message_id#&link">
							Click here
						</a>
						#arguments.message#
					</cfoutput>
				</cfmail>
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="updateOpenEmail" access="public" output="true" hint="Update Open Email for the Customers">
		<cfargument name="email" default="">
		<cfargument name="message_id" default="1">
		<cfquery name="qUpdateOpenEmail" datasource="#request.dsn#">	
			UPDATE 
				email_marketing 
			SET 
				date_opened = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			WHERE 
				email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#"> AND
				message_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.message_id#">
		</cfquery>
	</cffunction>
	
	<cffunction name="updateClickEmailLink" access="public" output="true" hint="Update Open Email for the Customers">
		<cfargument name="email" default="">
		<cfargument name="message_id" default="1">
		<cfquery name="qUpdateOpenEmail" datasource="#request.dsn#">	
			UPDATE 
				email_marketing 
			SET 
				link_clicked = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			WHERE 
				email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#"> AND
				message_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.message_id#">
		</cfquery>
	</cffunction>
</cfcomponent>