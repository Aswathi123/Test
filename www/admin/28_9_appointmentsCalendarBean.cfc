<cfcomponent displayname="appointmentsCalendarBean" hint="appointmentsCalendarBean" output="false">
	<cfset this.CALANDER_DAYS_SPAN = 7 />
    
	<cfset this.RECURRENCE_TYPE_NONE = 0 />
    <cfset this.RECURRENCE_TYPE_DAILY_DAYS = 1 />
    <cfset this.RECURRENCE_TYPE_DAILY_WEEKDAYS = 2 />
    <cfset this.RECURRENCE_TYPE_WEEKLY = 3 />
    <cfset this.RECURRENCE_TYPE_MONTHLY_DATE = 4 />
    <cfset this.RECURRENCE_TYPE_MONTHLY_WEEK = 5 />
    <cfset this.RECURRENCE_TYPE_YEARLY_DATE = 6 />
    <cfset this.RECURRENCE_TYPE_YEARLY_MONTH = 7 />
    
    <cfset this.RECURRENCE_RANGE_TYPE_NO_END_DATE = 1 />
    <cfset this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES = 2 />
    <cfset this.RECURRENCE_RANGE_TYPE_END_BY_DATE = 3 />

    <cfset this.RECURRENCE_ORDINAL_TYPE_FIRST = 1 />
    <cfset this.RECURRENCE_ORDINAL_TYPE_SECOND = 2 />
    <cfset this.RECURRENCE_ORDINAL_TYPE_THIRD = 3 />
    <cfset this.RECURRENCE_ORDINAL_TYPE_FOURTH = 4 />
    <cfset this.RECURRENCE_ORDINAL_TYPE_LAST = 5 />

	<cfset this.RECURRENCE_WEEKDAY_INTERVAL_DAY = 1 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_WEEKDAY = 2 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_WEEKEND_DAY = 3 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_SUNDAY = 4 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_MONDAY = 5 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_TUESDAY = 6 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_WEDNESDAY = 7 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_THURSDAY = 8 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_FRIDAY = 9 />
    <cfset this.RECURRENCE_WEEKDAY_INTERVAL_SATURDAY = 10 />

	<cfset this.RECURRENCE_DELETE_TYPE_NONE = 0 />
    <cfset this.RECURRENCE_DELETE_TYPE_SINGLE = 1 />
    <cfset this.RECURRENCE_DELETE_TYPE_SERIES = 2 />
        
    <cfset this.WEEKDAY_SUNDAY = 1 />
    <cfset this.WEEKDAY_MONDAY = 2 />
    <cfset this.WEEKDAY_TUESDAY = 3 />
    <cfset this.WEEKDAY_WEDNESDAY = 4 />
    <cfset this.WEEKDAY_THURSDAY = 5 />
    <cfset this.WEEKDAY_FRIDAY = 6 />
    <cfset this.WEEKDAY_SATURDAY = 7 />    
   
	<cffunction name="loginCustomer" access="remote" output="false" returntype="struct" returnformat="JSON">
    	<cfargument name="emailAddress" type="string" required="true" />
        <cfargument name="pw" type="string" required="true" />

        
    	<cfset var local = {} />
		<cfset local.Response = {
							CustomerID = 0,
        					Success = true,
        					FailedMsg = ""} />
        

		<cfquery name="local.qryResultsExist" datasource="#request.dsn#">
            SELECT TOP 1 1 FROM Customers WHERE Email_Address = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />
        </cfquery> 
		
		<cfif local.qryResultsExist.RecordCount>
			<cfquery name="local.qryResultsLogin" datasource="#request.dsn#">
            SELECT 	Customer_ID, Email_Address, First_name + ' ' + Last_name as name
			FROM 	Customers 
			WHERE 	Email_Address = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />
			AND 	Password = <cfqueryparam value="#arguments.pw#" cfsqltype="cf_sql_varchar" />
        	</cfquery> 
	
			<cfif local.qryResultsLogin.RecordCount>
				<cfset local.Response.CustomerID = local.qryResultsLogin.Customer_ID />
				<cfset local.Response.Email_Address = local.qryResultsLogin.Email_Address />
				<cfset local.Response.name = local.qryResultsLogin.name />
				<cfset session.CustomerID = local.qryResultsLogin.Customer_ID />
						
			<cfelse>
				<cfset local.Response.Success = false />
				<cfset local.Response.FailedMsg = "The password submitted did not match." />					
			</cfif>

		<cfelse>
			<cfset local.Response.Success = false />
			<cfset local.Response.FailedMsg = "The email address submitted does not have account.<br />Please try another email address, or register." />				
		</cfif>
		
        <cfreturn  local.Response />
    </cffunction>

	<cffunction name="registerCustomer" access="remote" output="false" returntype="struct">
    	<cfargument name="emailAddress" type="string" required="true" />
        <cfargument name="pw" type="string" required="true" />
		<cfargument name="firstName" type="string" required="true" />
		<cfargument name="lastName" type="string" required="true" />
		<cfargument name="ph" type="string" required="true" />
        
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					FailedMsg = ""} />

		<cfquery name="local.qryResultsExist" datasource="#request.dsn#">
            SELECT TOP 1 1 FROM Customers WHERE Email_Address = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />
        </cfquery> 
		
		<cfif local.qryResultsExist.RecordCount>
			<cfset local.Response.Success = false />
			<cfset local.Response.FailedMsg = "The email address submitted already exist in the database." />
		
		<cfelse>
			<cfquery name="local.qryResults" datasource="#request.dsn#">
				INSERT INTO Customers (Email_Address, Password, First_Name, Last_Name, Mobile_Phone)
				VALUES(
					<cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.pw#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.ph#" cfsqltype="cf_sql_varchar" />
				)
	        </cfquery> 	
			
			<cfset local.Response = this.loginCustomer(arguments.emailAddress, arguments.pw) />
	        		
		</cfif>
		
        <cfreturn  local.Response />
    </cffunction>
	

	<cffunction name="getCustomerProfile" access="remote" output="false" returntype="query">
		<cfargument name="CustomerID" type="numeric" required="true" />
    	<cfset var local = {} />

		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT 
			           First_Name
				      ,Last_Name
				      ,Address
				      ,Address2
				      ,City
				      ,State
				      ,Postal
				      ,Mobile_Phone
				      ,Email_Address
				      ,Password
				      ,Home_Phone
					  ,BirthDate_Month
					  ,BirthDate_Day
					  ,Birthdate_Year
					  ,Customer_Notes
					  ,Company_Notes
			  FROM Customers
			  WHERE Customer_ID = <cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />
        </cfquery> 

        <cfreturn  local.qryResults />
    </cffunction>
		
	<cffunction name="updateCustomerProfile" access="remote" output="false" returntype="any">
		<cfargument name="CustomerID" type="numeric" required="true" />
		<cfargument name="FirstName" type="string" required="true" />
		<cfargument name="LastName" type="string" required="true" />
		<cfargument name="Address" type="string" required="true" />
		<cfargument name="City" type="string" required="true" />
		<cfargument name="State" type="string" required="true" />
		<cfargument name="Postal" type="numeric" required="true" />
		<cfargument name="MobilePhone" type="string" required="true" />
		<cfargument name="EmailAddress" type="string" required="true" />
		<cfargument name="Password" type="string" required="false" />
		
    	<cfset var local = {} />
		<cftry>
			<cfquery name="local.qryResults" datasource="#request.dsn#">
				UPDATE Customers
				SET 
		           First_Name = <cfqueryparam value="#arguments.FirstName#" cfsqltype="cf_sql_varchar" />
			      ,Last_Name = <cfqueryparam value="#arguments.LastName#" cfsqltype="cf_sql_varchar" />
			      ,Address = <cfqueryparam value="#arguments.Address#" cfsqltype="cf_sql_varchar" />
			      ,Address2 = <cfqueryparam value="#arguments.Address2#" cfsqltype="cf_sql_varchar" />
			      ,City = <cfqueryparam value="#arguments.City#" cfsqltype="cf_sql_varchar" />
			      ,State = <cfqueryparam value="#arguments.State#" cfsqltype="cf_sql_varchar" />
			      ,Postal = <cfqueryparam value="#arguments.Postal#" cfsqltype="cf_sql_integer" />
			      ,Mobile_Phone = <cfqueryparam value="#arguments.MobilePhone#" cfsqltype="cf_sql_varchar" />
			      ,Home_Phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.HomePhone#">
			      ,Email_Address = <cfqueryparam value="#arguments.EmailAddress#" cfsqltype="cf_sql_varchar" />
			      <cfif structKeyExists(arguments,"Password") and len(trim(arguments.Password))>
					,Password = <cfqueryparam value="#arguments.Password#" cfsqltype="cf_sql_varchar" />
				  </cfif>
			      ,BirthDate_Month = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.month#" null="#not len(trim(arguments.month))#">
			      ,BirthDate_Day = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.day#" null="#not len(trim(arguments.day))#">
			      ,Birthdate_Year = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.year#" null="#not len(trim(arguments.year))#">
				  WHERE Customer_ID = <cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />
	        </cfquery>
			<cfreturn true />
		<cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
		</cftry>
    </cffunction>
			
	<cffunction name="bookAppointment" access="remote" output="false" returntype="string" returnformat="plain">
		<cfargument name="CustomerID" type="numeric" required="true" />
		<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="ServiceID" type="numeric" required="true" />
		<cfargument name="serviceTime" type="numeric" required="true" default= 15 />
		
		<cfargument name="StartDateTime" type="string" required="false" />
		<cfargument name="EndDateTime" type="string" required="false" />
		
		<cfargument name="AppointmentStartDate" type="string" required="false" />
		<cfargument name="AppointmentStartTime" type="string" required="false" />
		
		<cfargument name="ChangeAppointmentID" type="numeric" required="true" />
		
		<cfif arguments.serviceTime eq 0 >
			<cfset arguments.serviceTime = 15 >
		</cfif>
		<cfif not structKeyExists(arguments,"StartDateTime") AND not structKeyExists(arguments,"EndDateTime")>
			<cfset arguments.StartDateTime = ParseDateTime(arguments.AppointmentStartDate & " " & arguments.AppointmentStartTime) />
			<cfset arguments.EndDateTime = DateAdd("n", arguments.serviceTime, arguments.StartDateTime ) />
		</cfif>
		
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					FailedMsg = "",
							qryResults = ""} />
		<cftransaction>
			<cfif arguments.ChangeAppointmentID GT 0>
				<cfquery name="local.qryInsert" datasource="#request.dsn#">
		            DELETE Appointments
					WHERE Appointment_ID = <cfqueryparam value="#arguments.ChangeAppointmentID#" cfsqltype="cf_sql_integer" />
		        </cfquery> 
			</cfif>
			
			<cfquery name="local.qryInsert" datasource="#request.dsn#">
	            INSERT INTO Appointments(Customer_ID, Professional_ID, Service_ID, Start_Time, End_Time, Date_Booked)
				VALUES(
						<cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#arguments.ServiceID#" cfsqltype="cf_sql_integer" />,
						<cfqueryparam value="#arguments.StartDateTime#" cfsqltype="cf_sql_timestamp" />,
						<cfqueryparam value="#arguments.EndDateTime#" cfsqltype="cf_sql_timestamp" />,
						CURRENT_TIMESTAMP
					)
	        </cfquery> 

			<cfquery name="local.qryResults" datasource="#request.dsn#">
				SELECT      Appointments.Appointment_ID, Customers.First_Name + ' ' + Customers.Last_Name as CustomerName, 
							Customers.Email_Address as CustomerEmail, Customers.Mobile_Phone as CustomerPhone, 
							Locations.Location_Address + ' ' + Locations.Location_Address2 + ' ' + Locations.Location_City + ', ' + Locations.Location_State + ' ' + Locations.Location_Postal as LocationDesc, 
							Locations.Location_Phone, Locations.Location_Name, Professionals.First_Name + ' ' + Professionals.Last_Name AS ProfessionalName, 
							Professionals.Email_Address as ProfessionalEmail
				FROM            Appointments INNER JOIN
				                         Customers ON Appointments.Customer_ID = Customers.Customer_ID INNER JOIN
				                         Professionals ON Appointments.Professional_ID = Professionals.Professional_ID INNER JOIN
				                         Locations ON Professionals.Location_ID = Locations.Location_ID
				WHERE Appointments.Appointment_ID = (select max(Appointment_ID) from Appointments)
			</cfquery>
			
			<cfquery name="local.qGetCompanId" datasource="#request.dsn#" result="getCompanId">
				SELECT Company_ID,Customer_ID
				FROM Customers
				WHERE Customer_ID = <cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			<cfquery name="local.qGetCompanyDetails" datasource="#request.dsn#" result="getCompanyDetails">
				SELECT Company_Name,Company_Address ,Company_Address2,Company_City,Company_State,Company_Postal,Company_Phone,Company_Email,Company_ID
				FROM Companies
				WHERE Company_ID = <cfqueryparam value="#local.qGetCompanId.Customer_ID#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			<cfquery name="local.qGetSocialDetails" datasource="#request.dsn#" result="getSocialDetails">
				SELECT Social_Media_ID,Company_ID ,URL 
				FROM Companies_Social_Media
				WHERE Company_ID = <cfqueryparam value="#local.qGetCompanId.Customer_ID#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			 <cftry> 
				<!--- Email Customer --->
				<!--- <cfmail from="no-reply@salonworks.com" To="#local.qryResults.CustomerEmail#" replyto="no-reply@salonworks.com" Subject="Your Appointment with #local.qryResults.CustomerName#  #DateFormat(arguments.AppointmentStartDate,"long")# #TimeFormat(arguments.AppointmentStartTime,"medium")#" type="html"> --->
				
				<cfmail from="no-reply@salonworks.com" To="#local.qryResults.CustomerEmail#" replyto="no-reply@salonworks.com" Subject="Your Appointment with #local.qryResults.CustomerName#  #DateFormat(arguments.AppointmentStartDate,"long")# #TimeFormat(arguments.AppointmentStartTime,"medium")#" server="smtp-relay.sendinblue.com" port="587" type="HTML" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
					<cfoutput>
						<!doctype html>
						<html xmlns="http://www.w3.org/1999/xhtml">
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
							<meta name="viewport" content="initial-scale=1.0" />
							<meta name="format-detection" content="telephone=no" />
							<title></title>
							<style type="text/css">
							body {
								width: 100%;
								margin: 0;
								padding: 0;
								-webkit-font-smoothing: antialiased;
							}
							@media only screen and (max-width: 600px) {
								table[class="table-row"] {
									float: none !important;
									width: 98% !important;
									padding-left: 20px !important;
									padding-right: 20px !important;
								}
								table[class="table-row-fixed"] {
									float: none !important;
									width: 98% !important;
								}
								table[class="table-col"], table[class="table-col-border"] {
									float: none !important;
									width: 100% !important;
									padding-left: 0 !important;
									padding-right: 0 !important;
									table-layout: fixed;
								}
								td[class="table-col-td"] {
									width: 100% !important;
								}
								table[class="table-col-border"] + table[class="table-col-border"] {
									padding-top: 12px;
									margin-top: 12px;
									border-top: 1px solid ##E8E8E8;
								}
								table[class="table-col"] + table[class="table-col"] {
									margin-top: 15px;
								}
								td[class="table-row-td"] {
									padding-left: 0 !important;
									padding-right: 0 !important;
								}
								table[class="navbar-row"] , td[class="navbar-row-td"] {
									width: 100% !important;
								}
								img {
									max-width: 100% !important;
									display: inline !important;
								}
								img[class="pull-right"] {
									float: right;
									margin-left: 11px;
									max-width: 125px !important;
									padding-bottom: 0 !important;
								}
								img[class="pull-left"] {
									float: left;
									margin-right: 11px;
									max-width: 125px !important;
									padding-bottom: 0 !important;
								}
								table[class="table-space"], table[class="header-row"] {
									float: none !important;
									width: 98% !important;
								}
								td[class="header-row-td"] {
									width: 100% !important;
								}
							}
							@media only screen and (max-width: 480px) {
								table[class="table-row"] {
									padding-left: 16px !important;
									padding-right: 16px !important;
								}
							}
							@media only screen and (max-width: 320px) {
								table[class="table-row"] {
									padding-left: 12px !important;
									padding-right: 12px !important;
								}
							}
							@media only screen and (max-width: 608px) {
								td[class="table-td-wrap"] {
									width: 100% !important;
								}
							}
							</style>
						</head>
						<body style="font-family: Arial, sans-serif; font-size:13px; color: ##444444; min-height: 200px;" bgcolor="##E4E6E9" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
							<table width="100%" height="100%" bgcolor="##E4E6E9" cellspacing="0" cellpadding="0" border="0">
								<tr>
									<td width="100%" align="center" valign="top" bgcolor="##E4E6E9" style="background-color:##E4E6E9; min-height: 200px;">
									<table style="table-layout: auto; width: 100%; background-color: ##438eb9;" width="100%" bgcolor="##438eb9" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="100%" align="center" style="width: 100%; background-color: ##438eb9;" bgcolor="##438eb9" valign="top">
													<table class="table-row-fixed" height="50" width="600" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
														<tbody>
															<tr>
																<td class="navbar-row-td" valign="middle" height="50" width="600" data-skipstyle="true" align="left">
																	<table class="table-row" style="table-layout: auto; padding-right: 16px; padding-left: 16px; width: 600px;" width="600" cellspacing="0" cellpadding="0" border="0">
																		<tbody>
																			<tr style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
																				<td class="table-row-td" style="padding-right: 16px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; vertical-align: middle;" valign="middle" align="left">
																					<a href="##" style="color: ##ffffff; text-decoration: none; padding: 10px 0px; font-size: 18px; line-height: 20px; height: auto; background-color: transparent;">
																						Your Appointment with #local.qryResults.CustomerName#  #DateFormat(arguments.AppointmentStartDate,"long")# #TimeFormat(arguments.AppointmentStartTime,"medium")#
																					</a>
																				</td>

																		
																			</tr>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</tbody>
									</table>


									<table class="table-space" height="8" style="height: 8px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td class="table-space-td" valign="middle" height="8" style="height: 8px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td>
											</tr>
										</tbody>
									</table>

									<table class="table-row-fixed" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td class="table-row-fixed-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 24px; padding-right: 24px;" valign="top" align="left">
													<table class="table-col" align="left" width="285" style="padding-right: 18px; table-layout: fixed;" cellspacing="0" cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																	<table class="header-row" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																		<tbody>
																			<tr>
																				<td class="header-row-td" width="267" style="font-size: 28px; margin: 0px; font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; padding-bottom: 10px; padding-top: 15px;" valign="top" align="left">Dear, #local.qryResults.CustomerName#,</td>
																			</tr>
																		</tbody>
																	</table>
																	<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
																	Thank you for booking your appointment with us.  We look forward to serving you soon!
																	Click <a href="##">here</a> to view your appointments, or update your profile.
																	</p>											
																	<br>
																	<!---
																	<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; text-align: center;">
																		<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 5px solid ##6fb3e0; padding: 6px 12px; font-size: 15px; line-height: 21px; width: 100%; background-color: ##6fb3e0;"> &nbsp; &nbsp; &nbsp; Click Me! &nbsp; &nbsp; &nbsp; </a>
																	</div>
																	--->
																</td>
															</tr>
														</tbody>
													</table>
													<table class="table-col" align="left" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
														<tbody>
															<tr>
																<td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																	<table class="table-space" height="6" style="height: 6px; font-size: 0px; line-height: 0; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
																		<tbody>
																			<tr>
																				<td class="table-space-td" valign="middle" height="6" style="height: 6px; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" align="left">&nbsp;</td>
																			</tr>
																		</tbody>
																	</table>
																	
																	<!---
																	<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																		<tbody>
																			<tr>
																				<td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
																					<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																						<tbody>
																							<tr>
																								<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 0px;" valign="top" align="left">Appointment Details</td>
																							</tr>
																						</tbody>
																					</table>
																					
																					<table class="table-space" height="10" style="height: 10px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																						<tbody>
																							<tr>
																								<td class="table-space-td" valign="middle" height="10" style="height: 10px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																							</tr>
																						</tbody>
																					</table>
																					
																					<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																						Date: <strong>#DateFormat(arguments.AppointmentStartDate,"long")#</strong>
																					</span>
																					<br>
																					<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																						Time: <strong>#TimeFormat(arguments.AppointmentStartTime,"medium")#</strong>
																					</span>
																					<br>
																					<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																						Stylist: <strong>#local.qryResults.ProfessionalName#</strong>
																					</span>															
																					<br>
																				</td>
																			</tr>
																		</tbody>
																	</table>
							
																	--->
							
																	<br>
																	<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																		<tbody>
																			<tr>
																				<td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
																					<cfif not local.qGetSocialDetails.recordcount >
																						<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																							<tbody>
																								<tr>
																									<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 0px;" valign="top" align="left">Connect With Us</td>
																								</tr>
																							</tbody>
																						</table>
																			
																						<table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																							<tbody>
																								<tr>
																									<td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																								</tr>
																							</tbody>
																						</table>
																						<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; text-align: center;">
																							<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##428bca; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##428bca;"> &nbsp;&nbsp; &nbsp; Facebook &nbsp; &nbsp;&nbsp; </a>
																							<br>
																							<br>
																							<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##6fb3e0; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##6fb3e0;"> &nbsp;&nbsp; &nbsp; &nbsp; Twitter &nbsp; &nbsp; &nbsp; &nbsp; </a>
																							<br>
																							<br>
																							<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##d15b47; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##d15b47;"> &nbsp; &nbsp; &nbsp; Google + &nbsp; &nbsp; &nbsp; </a>
																						</div>
																					</cfif>
																					<table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																						<tbody>
																							<tr>
																								<td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																							</tr>
																						</tbody>
																					</table>
																					<hr data-skipstyle="true" style="border-width: 0px; height: 1px; background-color: ##e8e8e8;">

																					<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																						<tbody>
																							<tr>
																								<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 10px;" valign="top" align="left">Contact Info</td>
																							</tr>
																						</tbody>
																					</table>
																					Company Name: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">#local.qGetCompanyDetails.Company_Name#</span>
																					<br>
																					
																					Address: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">#local.qryResults.LocationDesc#</span>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</tbody>
									</table>

									<table class="table-space" height="32" style="height: 32px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="32" style="height: 32px; width: 600px; padding-left: 18px; padding-right: 18px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="center">&nbsp;<table bgcolor="##E8E8E8" height="0" width="100%" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td bgcolor="##E8E8E8" height="1" width="100%" style="height: 1px; font-size:0;" valign="top" align="left">&nbsp;</td></tr></tbody></table></td></tr></tbody></table>

									<table class="table-row" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
													<table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
														<tbody>
															<tr>
																<td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																	<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##777777; font-size: 14px; text-align: center;">PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IS NOT MONITORED
																	</div>
																	<table class="table-space" height="8" style="height: 8px; font-size: 0px; line-height: 0; width: 528px; background-color: ##ffffff;" width="528" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="8" style="height: 8px; width: 528px; background-color: ##ffffff;" width="528" bgcolor="##FFFFFF" align="left">&nbsp;</td></tr></tbody></table>

																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="table-space" height="14" style="height: 14px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td class="table-space-td" valign="middle" height="14" style="height: 14px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						 </table>
						</body>
						</html>
					
					</cfoutput>
				</cfmail>
				<cfif Len(local.qryResults.ProfessionalEmail)>
					<!--- Email Professional --->
					<!--- <cfmail from="no-reply@salonworks.com" To="#local.qryResults.ProfessionalEmail#" replyto="no-reply@salonworks.com" Subject="Appointment Notification"> --->
					<cfmail from="no-reply@salonworks.com" To="#local.qryResults.ProfessionalEmail#" replyto="no-reply@salonworks.com" Subject="Appointment Notification" server="smtp-relay.sendinblue.com" port="587" type="HTML" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
						<html>
						<body>
							<p>#local.qryResults.ProfessionalName#,</p>
							<p>
								Appointment Details: <br />
								Date: <strong>#DateFormat(arguments.AppointmentStartDate,"long")#</strong><br />
								Time: <strong>#TimeFormat(arguments.AppointmentStartTime,"medium")#</strong><br />
								Customer: <strong>#local.qryResults.CustomerName# (ph: #local.qryResults.CustomerPhone#)</strong><br />
								Location: <strong>#local.qryResults.Location_Name#</strong> <br />
								Address: <strong>#local.qryResults.LocationDesc#</strong>
							</p>
							
							<p><br /></p>
							<p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IS NOT MONITORED--</em></p>
						</body>      
						</html> 
					</cfmail> 	 				
				</cfif>
				<cfcatch type="any">
				
				</cfcatch>
			</cftry>
		</cftransaction> 
						
		<cfset local.Response.qryResults  =  local.qryResults />
		
        <cfreturn serializeJSON(local.Response) />
    </cffunction>
	
	<cffunction name="addAppointment" access="remote" output="false" returntype="struct" >
		<cfargument name="CustomerID" type="numeric" required="true" />
		<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="ServiceID" type="numeric" required="true" />		
		<cfargument name="apptStartTime" type="any" required="true" />
		<cfargument name="apptEndTime" type="any" required="true" />
	
		<cfset var local = StructNew() />
		
			<!--- <cfdump var="#arguments#"><cfabort> --->
	<!--- 	<cfquery name="local.qryInsert" datasource="#request.dsn#" result="qryResult">
			INSERT INTO Appointments(Customer_ID, Professional_ID, Service_ID, Start_Time, End_Time, Date_Booked)
			VALUES(
					<cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ServiceID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#ISOToDateTime(arguments.StartDateTime)#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDateTime)#" cfsqltype="cf_sql_timestamp" />,
					CURRENT_TIMESTAMP
				)
		</cfquery> --->
			<cfquery name="local.qryInsert" datasource="#request.dsn#" result="qryResult">
			INSERT INTO Appointments(Customer_ID, Professional_ID, Service_ID, Start_Time, End_Time, Date_Booked)
			VALUES(
					<cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ServiceID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.apptStartTime#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#arguments.apptEndTime#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(),'dd-mm-yyyy')#">
				)
		</cfquery>
	<!--- 	<cfdump var="#qryResult#"><cfabort> --->
		<cfquery name="local.qryAppointmentResults" datasource="#request.dsn#">
			SELECT      Appointments.Appointment_ID, Customers.First_Name + ' ' + Customers.Last_Name as CustomerName, 
						Customers.Email_Address as CustomerEmail, Customers.Mobile_Phone as CustomerPhone, 
						Locations.Location_Address + ' ' + Locations.Location_Address2 + ' ' + Locations.Location_City + ', ' + Locations.Location_State + ' ' + Locations.Location_Postal as LocationDesc, 
						Locations.Location_Phone, Locations.Location_Name, Professionals.First_Name + ' ' + Professionals.Last_Name AS ProfessionalName, 
						Professionals.Email_Address as ProfessionalEmail
			FROM            Appointments INNER JOIN
									 Customers ON Appointments.Customer_ID = Customers.Customer_ID INNER JOIN
									 Professionals ON Appointments.Professional_ID = Professionals.Professional_ID INNER JOIN
									 Locations ON Professionals.Location_ID = Locations.Location_ID
			WHERE Appointments.Appointment_ID = <cfqueryparam value="#qryResult.generatedkey#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfquery name="local.qGetCompanId" datasource="#request.dsn#" result="getCompanId">
			SELECT Company_ID,Customer_ID
			FROM Customers
			WHERE Customer_ID = <cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfquery name="local.qGetCompanyDetails" datasource="#request.dsn#" result="getCompanyDetails">
			SELECT Company_Name,Company_Address ,Company_Address2,Company_City,Company_State,Company_Postal,Company_Phone,Company_Email,Company_ID
			FROM Companies
			WHERE Company_ID = <cfqueryparam value="#local.qGetCompanId.Customer_ID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfquery name="local.qGetSocialDetails" datasource="#request.dsn#" result="getSocialDetails">
			SELECT Social_Media_ID,Company_ID ,URL 
			FROM Companies_Social_Media
			WHERE Company_ID = <cfqueryparam value="#local.qGetCompanId.Customer_ID#" cfsqltype="cf_sql_integer">
		</cfquery>
			
			
		<cftry>
			<!--- Email Customer --->
			<cfmail from="no-reply@salonworks.com" To="#local.qryAppointmentResults.CustomerEmail#" replyto="no-reply@salonworks.com" Subject="Your Appointment with #local.qryAppointmentResults.CustomerName# #DateFormat(ISOToDateTime(arguments.StartDateTime),"long")# #timeformat(ISOToDateTime(arguments.StartDateTime),"long")#" type="html">
				<cfoutput>
					<!doctype html>
					<html xmlns="http://www.w3.org/1999/xhtml">
					<head>
						<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
						<meta name="viewport" content="initial-scale=1.0" />
						<meta name="format-detection" content="telephone=no" />
						<title></title>
						<style type="text/css">
						body {
							width: 100%;
							margin: 0;
							padding: 0;
							-webkit-font-smoothing: antialiased;
						}
						@media only screen and (max-width: 600px) {
							table[class="table-row"] {
								float: none !important;
								width: 98% !important;
								padding-left: 20px !important;
								padding-right: 20px !important;
							}
							table[class="table-row-fixed"] {
								float: none !important;
								width: 98% !important;
							}
							table[class="table-col"], table[class="table-col-border"] {
								float: none !important;
								width: 100% !important;
								padding-left: 0 !important;
								padding-right: 0 !important;
								table-layout: fixed;
							}
							td[class="table-col-td"] {
								width: 100% !important;
							}
							table[class="table-col-border"] + table[class="table-col-border"] {
								padding-top: 12px;
								margin-top: 12px;
								border-top: 1px solid ##E8E8E8;
							}
							table[class="table-col"] + table[class="table-col"] {
								margin-top: 15px;
							}
							td[class="table-row-td"] {
								padding-left: 0 !important;
								padding-right: 0 !important;
							}
							table[class="navbar-row"] , td[class="navbar-row-td"] {
								width: 100% !important;
							}
							img {
								max-width: 100% !important;
								display: inline !important;
							}
							img[class="pull-right"] {
								float: right;
								margin-left: 11px;
								max-width: 125px !important;
								padding-bottom: 0 !important;
							}
							img[class="pull-left"] {
								float: left;
								margin-right: 11px;
								max-width: 125px !important;
								padding-bottom: 0 !important;
							}
							table[class="table-space"], table[class="header-row"] {
								float: none !important;
								width: 98% !important;
							}
							td[class="header-row-td"] {
								width: 100% !important;
							}
						}
						@media only screen and (max-width: 480px) {
							table[class="table-row"] {
								padding-left: 16px !important;
								padding-right: 16px !important;
							}
						}
						@media only screen and (max-width: 320px) {
							table[class="table-row"] {
								padding-left: 12px !important;
								padding-right: 12px !important;
							}
						}
						@media only screen and (max-width: 608px) {
							td[class="table-td-wrap"] {
								width: 100% !important;
							}
						}
						</style>
					</head>
					<body style="font-family: Arial, sans-serif; font-size:13px; color: ##444444; min-height: 200px;" bgcolor="##E4E6E9" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
						<table width="100%" height="100%" bgcolor="##E4E6E9" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td width="100%" align="center" valign="top" bgcolor="##E4E6E9" style="background-color:##E4E6E9; min-height: 200px;">
								<table style="table-layout: auto; width: 100%; background-color: ##438eb9;" width="100%" bgcolor="##438eb9" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td width="100%" align="center" style="width: 100%; background-color: ##438eb9;" bgcolor="##438eb9" valign="top">
												<table class="table-row-fixed" height="50" width="600" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
													<tbody>
														<tr>
															<td class="navbar-row-td" valign="middle" height="50" width="600" data-skipstyle="true" align="left">
																<table class="table-row" style="table-layout: auto; padding-right: 16px; padding-left: 16px; width: 600px;" width="600" cellspacing="0" cellpadding="0" border="0">
																	<tbody>
																		<tr style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
																			<td class="table-row-td" style="padding-right: 16px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; vertical-align: middle;" valign="middle" align="left">
																				<a href="##" style="color: ##ffffff; text-decoration: none; padding: 10px 0px; font-size: 18px; line-height: 20px; height: auto; background-color: transparent;">
																					Your Appointment with #local.qryAppointmentResults.CustomerName# #DateFormat(ISOToDateTime(arguments.StartDateTime),"long")# #timeformat(ISOToDateTime(arguments.StartDateTime),"long")#
																				</a>
																			</td>

																	
																		</tr>
																	</tbody>
																</table>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>


								<table class="table-space" height="8" style="height: 8px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td class="table-space-td" valign="middle" height="8" style="height: 8px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td>
										</tr>
									</tbody>
								</table>

								<table class="table-row-fixed" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td class="table-row-fixed-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 24px; padding-right: 24px;" valign="top" align="left">
												<table class="table-col" align="left" width="285" style="padding-right: 18px; table-layout: fixed;" cellspacing="0" cellpadding="0" border="0">
													<tbody>
														<tr>
															<td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																<table class="header-row" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																	<tbody>
																		<tr>
																			<td class="header-row-td" width="267" style="font-size: 28px; margin: 0px; font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; padding-bottom: 10px; padding-top: 15px;" valign="top" align="left">Dear, #local.qryAppointmentResults.CustomerName#,</td>
																		</tr>
																	</tbody>
																</table>
																<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
																You are booked appointment with us.  We look forward to serving you soon!
																Click <a href="##">here</a> to view your appointments, or update your profile.
																</p>											
																<br>
																<!---
																<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; text-align: center;">
																	<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 5px solid ##6fb3e0; padding: 6px 12px; font-size: 15px; line-height: 21px; width: 100%; background-color: ##6fb3e0;"> &nbsp; &nbsp; &nbsp; Click Me! &nbsp; &nbsp; &nbsp; </a>
																</div>
																--->
															</td>
														</tr>
													</tbody>
												</table>
												<table class="table-col" align="left" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
													<tbody>
														<tr>
															<td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																<table class="table-space" height="6" style="height: 6px; font-size: 0px; line-height: 0; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
																	<tbody>
																		<tr>
																			<td class="table-space-td" valign="middle" height="6" style="height: 6px; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" align="left">&nbsp;</td>
																		</tr>
																	</tbody>
																</table>
																<!---
																<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																	<tbody>
																		<tr>
																			<td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
																				<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																					<tbody>
																						<tr>
																							<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 0px;" valign="top" align="left">Appointment Details</td>
																						</tr>
																					</tbody>
																				</table>
																				
																				<table class="table-space" height="10" style="height: 10px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																					<tbody>
																						<tr>
																							<td class="table-space-td" valign="middle" height="10" style="height: 10px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																						</tr>
																					</tbody>
																				</table>
																				
																				<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																					Date: <strong>#DateFormat(ISOToDateTime(arguments.StartDateTime),"long")#</strong>
																				</span>
																				<br>
																				<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																					Time: <strong>#timeformat(ISOToDateTime(arguments.StartDateTime),"long")#</strong>
																				</span>
																				<br>
																				<span style="color: ##428bca; text-decoration: none; background-color: transparent;">
																					Stylist: <strong>#local.qryAppointmentResults.ProfessionalName#</strong>
																				</span>															
																				
																			</td>
																		</tr>
																	</tbody>
																</table>
																--->
						
						
																<br>
																<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																	<tbody>
																		<tr>
																			<td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
																			
																				<cfif not local.qGetSocialDetails.recordcount >
																					<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																						<tbody>
																							<tr>
																								<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 0px;" valign="top" align="left">Connect With Us</td>
																							</tr>
																						</tbody>
																					</table>
																		
																					<table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																						<tbody>
																							<tr>
																								<td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																							</tr>
																						</tbody>
																					</table>
																					<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; text-align: center;">
																						<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##428bca; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##428bca;"> &nbsp;&nbsp; &nbsp; Facebook &nbsp; &nbsp;&nbsp; </a>
																						<br>
																						<br>
																						<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##6fb3e0; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##6fb3e0;"> &nbsp;&nbsp; &nbsp; &nbsp; Twitter &nbsp; &nbsp; &nbsp; &nbsp; </a>
																						<br>
																						<br>
																						<a href="##" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##d15b47; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##d15b47;"> &nbsp; &nbsp; &nbsp; Google + &nbsp; &nbsp; &nbsp; </a>
																					</div>
																				</cfif>
																				<table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0">
																					<tbody>
																						<tr>
																							<td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td>
																						</tr>
																					</tbody>
																				</table>
																				<hr data-skipstyle="true" style="border-width: 0px; height: 1px; background-color: ##e8e8e8;">

																				<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
																					<tbody>
																						<tr>
																							<td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 10px;" valign="top" align="left">Contact Info</td>
																						</tr>
																					</tbody>
																				</table>
																				Company Name: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">#local.qGetCompanyDetails.Company_Name#</span>
																				<br>
																				
																				Address: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">#local.qryAppointmentResults.LocationDesc#</span>
																			</td>
																		</tr>
																	</tbody>
																</table>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>

								<table class="table-space" height="32" style="height: 32px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="32" style="height: 32px; width: 600px; padding-left: 18px; padding-right: 18px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="center">&nbsp;<table bgcolor="##E8E8E8" height="0" width="100%" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td bgcolor="##E8E8E8" height="1" width="100%" style="height: 1px; font-size:0;" valign="top" align="left">&nbsp;</td></tr></tbody></table></td></tr></tbody></table>

								<table class="table-row" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
												<table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;">
													<tbody>
														<tr>
															<td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
																<div style="font-family: Arial, sans-serif; line-height: 19px; color: ##777777; font-size: 14px; text-align: center;">PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IT NOT MONITORED
																</div>
																<table class="table-space" height="8" style="height: 8px; font-size: 0px; line-height: 0; width: 528px; background-color: ##ffffff;" width="528" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="8" style="height: 8px; width: 528px; background-color: ##ffffff;" width="528" bgcolor="##FFFFFF" align="left">&nbsp;</td></tr></tbody></table>

															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
								<table class="table-space" height="14" style="height: 14px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td class="table-space-td" valign="middle" height="14" style="height: 14px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					 </table>
					</body>
					</html>	
				</cfoutput>
				
			</cfmail>
			<cfcatch type="any">
			
			</cfcatch>
		</cftry>
		
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Appointment'>
		<cfset res['start'] = arguments.apptStartTime>
		<cfset res['end'] 	= arguments.apptEndTime>
		<cfset res['ID'] 	= qryResult.generatedkey>
		<cfreturn res />
    </cffunction>

	<cffunction name="getCustomerAppointmentHistory" access="remote" output="false" returntype="query">
		<cfargument name="CustomerID" type="numeric" required="true" />
		
    	<cfset var local = {} />

		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT      Appointments.Appointment_ID, Professionals.First_Name, Professionals.Last_Name, Locations.Location_Address, Locations.Location_Address2
						,Locations.Location_City, Locations.Location_State, Locations.Location_Postal, Locations.Location_Phone
						,Services.Service_Name, Appointments.Start_Time, Appointments.End_Time
						,Time_Zones.Offset, Timezone_Location
			FROM            
						Appointments 
						INNER JOIN
							Services ON Appointments.Service_ID = Services.Service_ID 
						INNER JOIN
							Professionals ON Appointments.Professional_ID = Professionals.Professional_ID 
						INNER JOIN
							Locations ON Professionals.Location_ID = Locations.Location_ID 
						INNER JOIN
							Time_Zones ON Locations.Time_Zone_ID = Time_Zones.Time_Zone_ID
			WHERE 
					Customer_ID = <cfqueryparam value="#arguments.CustomerID#" cfsqltype="cf_sql_integer" />
			ORDER BY Appointments.Start_Time DESC
        </cfquery> 

        <cfreturn  local.qryResults />
    </cffunction>
			
	<cffunction name="getBookAppointment" access="remote" output="false" returntype="query">
		<cfargument name="AppointmentID" type="numeric" required="true" />
		
    	<cfset var local = {} />

		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT        Professionals.First_Name, Professionals.Last_Name, Locations.Location_Name, Locations.Location_Address, Locations.Location_Address2, Locations.Location_City, 
			                         Locations.Location_State, Locations.Location_Postal, Locations.Location_Phone, Services.Service_Name, Appointments.Start_Time, Appointments.End_Time, 
			                         Time_Zones.Offset, Timezone_Location, Professionals.Email_Address
			FROM            Appointments INNER JOIN
			                         Services ON Appointments.Service_ID = Services.Service_ID INNER JOIN
			                         Professionals ON Appointments.Professional_ID = Professionals.Professional_ID INNER JOIN
			                         Locations ON Professionals.Location_ID = Locations.Location_ID INNER JOIN
			                         Time_Zones ON Locations.Time_Zone_ID = Time_Zones.Time_Zone_ID
			WHERE Appointments.Appointment_ID = <cfqueryparam value="#arguments.AppointmentID#" cfsqltype="cf_sql_integer" />
        </cfquery> 

        <cfreturn  local.qryResults />
    </cffunction>

	<cffunction name="changeAppointment" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Appointment_ID" type="numeric" required="true" />
        <cfargument name="apptDate" type="string" required="true" />
		<cfargument name="apptStartTime" type="string" required="true" />
		<cfargument name="apptEndTime" type="string" required="true" />
		<cfargument name="noCache" type="string" required="true" />
        <cfsetting showdebugoutput="false">

    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} /> 
		
		<cftry>
			<cfset local.StartDateTime = arguments.apptDate & " " & arguments.apptStartTime />
	        <cfset local.EndDateTime = arguments.apptDate & " " & arguments.apptEndTime />
			
			<cfquery name="local.qryResults" datasource="#request.dsn#">
	            UPDATE Appointments 
				SET Start_Time = '#local.StartDateTime#',
					End_Time = '#local.EndDateTime#'
				WHERE Appointment_ID = <cfqueryparam value="#arguments.Appointment_ID#" cfsqltype="cf_sql_integer" />
	        </cfquery> 
		<cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />
    </cffunction>
	
	<cffunction name="updateAppointment" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Appointment_ID" type="numeric" required="true" />
		<cfargument name="apptStartTime" type="string" required="true" />
		<cfargument name="apptEndTime" type="string" required="true" />
		<cfargument name="customerId" type="numeric" required="true" />
		<cfargument name="ServiceID" type="numeric" required="true" />
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} /> 
		
		<cftry>
			<cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
	            UPDATE 
					Appointments 
				SET 
					Start_Time = <cfqueryparam value="#arguments.apptStartTime#" cfsqltype="cf_sql_timestamp" />,
					End_Time =  <cfqueryparam value="#arguments.apptEndTime#" cfsqltype="cf_sql_timestamp" />,					
					Service_ID = <cfqueryparam value="#arguments.ServiceID#" cfsqltype="cf_sql_integer" />,				
					Customer_ID = <cfqueryparam value="#arguments.customerId#" cfsqltype="cf_sql_integer" />					
				WHERE Appointment_ID = <cfqueryparam value="#arguments.Appointment_ID#" cfsqltype="cf_sql_integer" />
	        </cfquery> 
	    <cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />
    </cffunction>

	<cffunction name="deleteAppointment" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Appointment_ID" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="yes" />
		
        <cfsetting showdebugoutput="false">

    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} /> 
		
		<cftry>
			<cfquery name="local.qryResults" datasource="#request.dsn#">
	            DELETE Appointments 
				WHERE Appointment_ID = <cfqueryparam value="#arguments.Appointment_ID#" cfsqltype="cf_sql_integer" />
	        </cfquery> 
		<cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />
    </cffunction>

	<cffunction name="getProfessionalsListByService" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Location_ID" type="numeric" required="true" />
        <cfargument name="ServiceID" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="true" />
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					Errors = [],
        					DATA = []} />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
            SELECT DISTINCT Professionals.Professional_ID, Professionals.Title_ID, Professionals.Last_Name, Professionals.First_Name
            FROM         Professionals INNER JOIN
                                  Professionals_Services ON Professionals.Professional_ID = Professionals_Services.Professional_ID
            WHERE   Professionals.Active_Flag = 1 AND 
            		Professionals.Location_ID =  <cfqueryparam value="#arguments.Location_ID#" cfsqltype="cf_sql_integer" />
            		 <cfif arguments.ServiceID GT 0> AND Professionals_Services.Service_ID = <cfqueryparam value="#arguments.ServiceID#" cfsqltype="cf_sql_integer" /></cfif>
            ORDER BY Professionals.Last_Name, Professionals.First_Name
        </cfquery> 

		<cfset local.rowIndex = 1 />
		<cfloop query="local.qryResults">
			<cfset local.Response.DATA[local.rowIndex] = {} />
			<cfset local.Response.DATA[local.rowIndex].PROFESSIONAL_ID = local.qryResults.Professional_ID />
			<cfset local.Response.DATA[local.rowIndex].TITLE_ID = local.qryResults.Title_ID />
			<cfset local.Response.DATA[local.rowIndex].LAST_NAME = local.qryResults.Last_Name />
			<cfset local.Response.DATA[local.rowIndex].FIRST_NAME = local.qryResults.First_Name />
			<cfset local.rowIndex = local.rowIndex + 1 />
		</cfloop>
		
        <cfreturn  local.Response />
    </cffunction>
	
	<cffunction name="getProfessionalServices" access="public" output="false" returntype="query">
		<cfargument name="Location_ID" type="numeric" required="true" />
		<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="true" />
		<cfquery name="qGetServicesByProfessionals" datasource="#request.dsn#">
			SELECT DISTINCT <!--- Service_Types.Service_Type_Name, ---> Services.Service_ID, Services.Service_Name, Services.Price, Services.Service_Time<!--- , Service_Types.Service_Type_Display_Order --->
			FROM            Services <!--- INNER JOIN
			                         Service_Types ON Services.Service_Type_ID = Service_Types.Service_Type_ID ---> INNER JOIN
			                         Professionals_Services ON Services.Service_ID = Professionals_Services.Service_ID INNER JOIN
			                         Professionals ON Professionals_Services.Professional_ID = Professionals.Professional_ID
			WHERE Professionals.Location_ID = <cfqueryparam value="#arguments.Location_ID#" cfsqltype="cf_sql_integer" />
				<cfif arguments.Professional_ID GT 0> AND Professionals.Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> </cfif>
			<!--- ORDER BY Service_Types.Service_Type_Display_Order --->
        </cfquery> 
		<cfreturn qGetServicesByProfessionals>
	</cffunction>
	
	<cffunction name="getServicesListByProfessional" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Location_ID" type="numeric" required="true" />
		<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="true" />
        <cfsetting showdebugoutput="false">
		
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					Errors = [],
        					DATA = []} />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT DISTINCT <!--- Service_Types.Service_Type_Name, ---> Services.Service_ID, Services.Service_Name, Services.Price, Services.Service_Time<!--- , Service_Types.Service_Type_Display_Order --->
			FROM            Services <!--- INNER JOIN
			                         Service_Types ON Services.Service_Type_ID = Service_Types.Service_Type_ID ---> INNER JOIN
			                         Professionals_Services ON Services.Service_ID = Professionals_Services.Service_ID INNER JOIN
			                         Professionals ON Professionals_Services.Professional_ID = Professionals.Professional_ID
			WHERE Professionals.Location_ID = <cfqueryparam value="#arguments.Location_ID#" cfsqltype="cf_sql_integer" />
				<cfif arguments.Professional_ID GT 0> AND Professionals.Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> </cfif>
			<!--- ORDER BY Service_Types.Service_Type_Display_Order --->
        </cfquery> 

		<cfset local.rowIndex = 1 />
		<cfloop query="local.qryResults">
			<cfset local.Response.DATA[local.rowIndex] = {} />
			<!--- <cfset local.Response.DATA[local.rowIndex].TYPE_NAME = local.qryResults.Service_Type_Name /> --->
			<cfset local.Response.DATA[local.rowIndex].SERVICE_ID = local.qryResults.Service_ID />
			<cfset local.Response.DATA[local.rowIndex].SERVICE_NAME = local.qryResults.Service_Name />
			<cfset local.Response.DATA[local.rowIndex].SERVICE_PRICE = local.qryResults.Price />
			<cfset local.Response.DATA[local.rowIndex].SERVICE_TIME = local.qryResults.Service_Time />
			<cfset local.rowIndex = local.rowIndex + 1 />
		</cfloop>
		
        <cfreturn  local.Response />
    </cffunction>	
		
	<cffunction name="getAvailableSlots" access="remote" returnFormat="json" returntype="struct" output="false">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="ServiceID" type="numeric" required="true" />
        <cfargument name="AppointmentDate" type="string" required="true" />
		<cfargument name="ServiceTime" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="true" />
        <cfsetting showdebugoutput="false">
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					Errors = [],
        					DATA = []} />
        
		<cfset local.AvailableSlotsQuery = this.getCalendarAvailability(arguments.Professional_ID, arguments.AppointmentDate, 1) /> 
		<cfset local.qryExistingAppoinments = this.getProfessionalAppointmentForSingleDate(arguments.Professional_ID, arguments.AppointmentDate) /> 
		
		<cfquery name="local.qryResults" datasource="#request.dsn#">
            SELECT  Appointment_Increment
            FROM Professionals
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset local.IncrementTime = local.qryResults.Appointment_Increment />
		
		<cfset local.arrQualifiedStartDates = ArrayNew(1) />
        <cfloop query="local.AvailableSlotsQuery">
            <!--- Test that service time does not overlap slot minutes --->
            <cfif arguments.ServiceTime LTE DateDiff("n", local.AvailableSlotsQuery.Start_Date, local.AvailableSlotsQuery.End_Date)>
                <cfloop from="#local.AvailableSlotsQuery.Start_Date#" to="#dateAdd('n', -local.IncrementTime, local.AvailableSlotsQuery.End_Date)#" index="i" step="#CreateTimeSpan(0,0,local.IncrementTime,0)#">
                    <cfset local.currentTime = TimeFormat(i, "hh:mm tt") />
                     <cfif dateAdd('n', arguments.ServiceTime, local.currentTime) LTE TimeFormat(local.AvailableSlotsQuery.End_Date, "hh:mm tt")>
                        <cfset ArrayAppend(local.arrQualifiedStartDates, local.currentTime) />
                     <cfelse>
                        <cfbreak />
                     </cfif>
                </cfloop>
            </cfif>
        </cfloop>
        
        <cfset local.arrQualifiedFinalList = ArrayNew(1) />
        <cfloop from="1" to="#ArrayLen(local.arrQualifiedStartDates)#" index="local.i">
            <cfset local.QualifiedStart = local.arrQualifiedStartDates[i] />
            <cfset local.QualifiedEnd = TimeFormat(DateAdd('n', arguments.ServiceTime, local.QualifiedStart), "hh:mm tt") />
            <cfset local.bolAdd = true />
            <cfloop query="local.qryExistingAppoinments">
                <cfif Not (local.QualifiedStart GTE TimeFormat(local.qryExistingAppoinments.End_Time, "hh:mm tt") OR 
                                            local.QualifiedEnd LTE TimeFormat(local.qryExistingAppoinments.Start_Time, "hh:mm tt"))>
                    <cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>                        
            </cfloop>
            <cfif bolAdd>
                <cfset ArrayAppend(local.arrQualifiedFinalList, local.QualifiedStart) /> 
            </cfif>
        </cfloop>   

        <cfset local.Response.DATA = local.arrQualifiedFinalList />
		<cfreturn local.Response />		
    </cffunction>
	
	<cffunction name="getQualifiedServiceInfo" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="ServiceID" type="numeric" required="true" />
        <cfargument name="AppointmentDate" type="string" required="true" />
        <cfargument name="ServiceArray" type="array" required="true" />
        <cfsetting showdebugoutput="false">
    	<cfset var local = StructNew() />
        
        <cfset local.objService = StructNew() />
        
        <cfset local.AvailableSlotsQuery = this.getCalendarAvailability(arguments.Professional_ID, arguments.AppointmentDate, 1) /> 

        <cfloop from="1" to="#ArrayLen(arguments.ServiceArray)#" index="local.ArrayIndex">
        	<cfif arguments.ServiceID EQ arguments.ServiceArray[local.ArrayIndex].ServiceID>
        		<cfset local.objService = arguments.ServiceArray[local.ArrayIndex] />
                <cfbreak />
        	</cfif>
        </cfloop>
        
    	<cfset local.qryExistingAppoinments = this.getProfessionalAppointmentByDate(arguments.Professional_ID, arguments.AppointmentDate) /> 

		<cfset local.arrQualifiedStartDates = ArrayNew(1) />
        
        <!--- For each available entry --->
        <cfloop query="local.AvailableSlotsQuery">
            <!--- Test that service time does not overlap slot minutes --->
            <cfif local.objService.ServiceTime LTE DateDiff("n", local.AvailableSlotsQuery.Start_Date, local.AvailableSlotsQuery.End_Date)>
                
                <cfloop from="#local.AvailableSlotsQuery.Start_Date#" to="#dateAdd('n', -15, local.AvailableSlotsQuery.End_Date)#" index="i" step="#CreateTimeSpan(0,0,15,0)#">
                    <cfset local.currentTime = TimeFormat(i, "hh:mm tt") />
                     <cfif dateAdd('n', local.objService.ServiceTime, local.currentTime) LTE TimeFormat(local.AvailableSlotsQuery.End_Date, "hh:mm tt")>
                        <cfset ArrayAppend(local.arrQualifiedStartDates, local.currentTime) />
                     <cfelse>
                        <cfbreak />
                     </cfif>
                </cfloop>
            </cfif>
            <hr />
        </cfloop>
        
        <cfset local.arrQualifiedFinalList = ArrayNew(1) />
        
        <cfloop from="1" to="#ArrayLen(local.arrQualifiedStartDates)#" index="local.i">
            <cfset local.QualifiedStart = local.arrQualifiedStartDates[i] />
            <cfset local.QualifiedEnd = TimeFormat(DateAdd('n', local.objService.ServiceTime, local.QualifiedStart), "hh:mm tt") />
            <cfset local.bolAdd = true />
            <cfloop query="local.qryExistingAppoinments">
                <cfif Not (local.QualifiedStart GTE TimeFormat(local.qryExistingAppoinments.End_Time, "hh:mm tt") OR 
                                            local.QualifiedEnd LTE TimeFormat(local.qryExistingAppoinments.Start_Time, "hh:mm tt"))>
                    <cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>                        
            </cfloop>
            <cfif bolAdd>
                <cfset ArrayAppend(local.arrQualifiedFinalList, local.QualifiedStart) /> 
            </cfif>
        </cfloop>      
        
        <cfset local.objService.AppointmentTimeSlots = local.arrQualifiedFinalList />
        
        <cfreturn local.objService />
        
    </cffunction>    
   
	<cffunction name="getProfessionalAppointmentForSingleDate" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AppointmentDate" type="string" required="true" />
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
            SELECT  Start_Time, End_Time
            FROM Appointments
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                   	Convert(varchar(10),Start_Time,101) = '#arguments.AppointmentDate#'
            ORDER BY Start_Time
		</cfquery>
        
        <cfreturn local.qryResults />
        
    </cffunction>  

	<cffunction name="getProfessionalAppointmentByDate" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AppointmentDate" type="string" required="true" />
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
            SELECT  Start_Time, End_Time
            FROM Appointments
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                   	DATEDIFF(day, '#arguments.AppointmentDate#', Start_Time) >= 0 
            ORDER BY Start_Time
		</cfquery>
        
        <cfreturn local.qryResults />
        
    </cffunction>       
   
	<cffunction name="getAvailableDatesArray" access="remote" output="false" returnFormat="json" returntype="array">
    	<cfargument name="Location_ID" type="numeric" required="true" />
        <cfargument name="ServiceID" type="numeric" required="true" />
        <cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="ServiceTime" type="numeric" required="true" />
        <cfargument name="Month" type="numeric" required="true" />
        <cfargument name="Year" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="true" />
		
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = {} /> 
        <cfset arguments.month = arguments.month + 2 />
        <cfif arguments.month GT 12>
        	<cfset arguments.month = arguments.month - 12 />
        	<cfset arguments.year = arguments.year + 1 />
        </cfif>
        
        <cfset local.CalendarSelected = CreateDate(arguments.year, arguments.month, 1) />
        <cfset local.calendarSpan = DateDiff('d', Now(), local.CalendarSelected) />
      	<cfset local.qryAvailableSlots = this.getCalendarAvailability(arguments.Professional_ID, DateFormat(Now(),'mm/dd/yyyy'), local.calendarSpan) /> 
		<!--- <cfdump var="#local.qryAvailableSlots#" label="local.qryAvailableSlots" /> --->
        
    	<cfset local.qryExistingAppoinments = this.getProfessionalAppointmentByDate(arguments.Professional_ID, DateFormat(Now(),'mm/dd/yyyy')) /> 
        <!--- <cfdump var="#local.qryExistingAppoinments#" label="local.qryExistingAppoinments" /> --->
         
		<cfset local.arrQualifiedStartDates = ArrayNew(1) />
        
        <!--- For each available entry --->
        <cfloop query="local.qryAvailableSlots">
            <!--- Test that service time does not overlap slot minutes --->
            <cfif arguments.ServiceTime LTE DateDiff("n", local.qryAvailableSlots.Start_Date, local.qryAvailableSlots.End_Date)>
                
                <cfloop from="#local.qryAvailableSlots.Start_Date#" to="#dateAdd('n', -15, local.qryAvailableSlots.End_Date)#" index="i" step="#CreateTimeSpan(0,0,15,0)#">
                    <cfset local.currentTime = TimeFormat(i, "hh:mm tt") />
                    <cfset local.timeDate = CreateDateTime(DatePart("yyyy", i), DatePart("m", i), DatePart("d", i), DatePart("h", i), DatePart("n", i), 0)  /> 
                    
                     <cfif dateAdd('n', arguments.ServiceTime, local.currentTime) LTE TimeFormat(local.qryAvailableSlots.End_Date, "hh:mm tt")>
                        <cfset ArrayAppend(local.arrQualifiedStartDates, local.timeDate) />
                     <cfelse>
                        <cfbreak />
                     </cfif>
                </cfloop>
            </cfif>
        </cfloop>
        
        <cfset local.arrQualifiedFinalList = ArrayNew(1) />
        
        <cfloop from="1" to="#ArrayLen(local.arrQualifiedStartDates)#" index="local.i">
            <cfset local.QualifiedStart = local.arrQualifiedStartDates[i] />
            <cfset local.QualifiedEnd = DateAdd('n', arguments.ServiceTime, local.QualifiedStart) />
            <cfset local.bolAdd = true />
            <cfloop query="local.qryExistingAppoinments">

				<cfif Not (local.QualifiedStart GTE local.qryExistingAppoinments.End_Time OR 
                                            local.QualifiedEnd LTE local.qryExistingAppoinments.Start_Time)>
                    <cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>                        
            </cfloop>
            
			<cfif bolAdd AND Not ArrayContains(local.arrQualifiedFinalList, DateFormat(local.QualifiedStart,'m/d/yyyy')) GT 0>
                <cfset ArrayAppend(local.arrQualifiedFinalList, DateFormat(local.QualifiedStart,'m/d/yyyy')) />
            </cfif>
        </cfloop>      

<!---  <cfloop from="1" to="#ArrayLen(local.arrQualifiedStartDates)#" index="local.i">
            <cfset local.QualifiedStart = local.arrQualifiedStartDates[i] />
            <cfset local.QualifiedEnd = TimeFormat(DateAdd('n', arguments.ServiceTime, local.QualifiedStart), "hh:mm tt") />
            <cfset local.bolAdd = true />
            <cfloop query="local.qryExistingAppoinments">
                <!--- <cfif Not (local.QualifiedStart GTE TimeFormat(local.qryExistingAppoinments.End_Time, "hh:mm tt") OR  --->
				<cfif Not (TimeFormat(local.QualifiedStart, "hh:mm tt") GTE TimeFormat(local.qryExistingAppoinments.End_Time, "hh:mm tt") OR 
                                            local.QualifiedEnd LTE TimeFormat(local.qryExistingAppoinments.Start_Time, "hh:mm tt"))>
                    <cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>                        
            </cfloop>
            
			<cfif bolAdd AND Not ArrayContains(local.arrQualifiedFinalList, DateFormat(local.QualifiedStart,'m/d/yyyy')) GT 0>
                <cfset ArrayAppend(local.arrQualifiedFinalList, DateFormat(local.QualifiedStart,'m/d/yyyy')) />
            </cfif>
        </cfloop>       --->  

        <cfreturn local.arrQualifiedFinalList />
    </cffunction> 
    
 	<cffunction name="getEventDetails" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfsetting showdebugoutput="false">
        
		<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	SELECT 	Recurrence_Type_ID, Recur_Count_Interval, Week_Days, Recurrence_Weekday_Interval_ID,
					Recurrence_Ordinal_Interval_ID,Yearly_Month, Day_Value, End_Recurrence_Date, 
                    End_After_Ocurrences, Recurrence_Range_Type_ID				
            FROM Availability
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND
            		Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />
		</cfquery>
        
        <cfreturn local.qryResults />
    </cffunction>
	
	<cffunction name="getAppointmentDetails" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AppointmentID" type="numeric" required="true" />
        <cfsetting showdebugoutput="false">
        
		<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	SELECT 	Appointment_ID, Professional_ID, Start_Time, End_Time,Service_ID,Customer_ID, Date_Booked				
            FROM  
				Appointments
            WHERE 	
				Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
			AND
            	Appointment_ID = <cfqueryparam value="#arguments.AppointmentID#" cfsqltype="cf_sql_integer" />
		</cfquery>
        
        <cfreturn local.qryResults />
    </cffunction>
       
 	<cffunction name="removeAvailability" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="DeleteType" type="numeric" required="true" />
        <cfargument name="ExceptionDate" type="string" required="false" />
		<cfsetting showdebugoutput="false">
        
		<!--- <cfset var local = StructNew() /> --->
		<!--- 	
		RECURRENCE_DELETE_TYPE_NONE = 0 
		RECURRENCE_DELETE_TYPE_SINGLE = 1
		RECURRENCE_DELETE_TYPE_SERIES = 2
		--->
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} /> 
        <cftry>					
		<!--- Delete is from a series type, but only want to remove a single occurance, hence insert into exceptions (to series) --->
        <cfif arguments.DeleteType EQ this.RECURRENCE_DELETE_TYPE_SINGLE>
            <cfquery name="local.qryResults" datasource="#request.dsn#">
                INSERT INTO Availability_Exceptions(Availability_ID, Professional_ID, Exception_Date)
                VALUES (<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                		<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,'#arguments.ExceptionDate#')
            </cfquery>        
        
        <cfelseif arguments.DeleteType EQ this.RECURRENCE_DELETE_TYPE_SERIES OR arguments.DeleteType EQ this.RECURRENCE_DELETE_TYPE_NONE>
            
            <cfquery name="local.qryResults" datasource="#request.dsn#">
                DELETE FROM Availability_Exceptions
                WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND
                        Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />
            </cfquery>            
            
            <cfquery name="local.qryResults" datasource="#request.dsn#">
                DELETE FROM Availability
                WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND
                        Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />
            </cfquery>
        </cfif>
       <cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />
        
    </cffunction>
	
   <cffunction name="addAvailabilityTypeNone" access="remote" output="false" returntype="struct">
 		<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="any" required="false" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfsetting showdebugoutput="false">
		
		<cfset var local = StructNew() />
		
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		
		<cfquery name="local.qryResults" datasource="#request.dsn#" result="qryRes">
			INSERT INTO Availability(
			Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID)
			VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp"/>,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" cfsqltype="cf_sql_timestamp"/>,
					#this.RECURRENCE_TYPE_NONE#)
		</cfquery>
		
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction>  
 	

<cffunction name="updateAvailabilityTypeNone" access="remote" output="false" returnFormat="json" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
    	<cfargument name="id" type="numeric" required="true" />
		<cfargument name="startDate" type="string" required="true" />
		<cfargument name="endDate" type="string" required="true" />
	
		<!--- <cfdump var="#arguments#">
		<cfdump var="#this.RECURRENCE_TYPE_NONE#"><cfabort> --->
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} /> 
		
		<cftry>
			<cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
	            UPDATE 
					Availability
				SET 
					Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
					End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/>				
										
				WHERE Availability_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> AND 
				Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
				Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_NONE#" cfsqltype="cf_sql_integer">
	        </cfquery> 
	        
	    <cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />
    </cffunction>

    <cffunction name="updateAvailabilityTypeDailyDays" access="remote" output="false" returnFormat="json" returntype="struct">
         <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="RecurCountInterval" type="any" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />
    
       <!--- <cfdump var="#arguments#"><cfabort> --->
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
        
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    Recur_Count_Interval = <cfqueryparam value="#arguments.RecurCountInterval#" cfsqltype="cf_sql_integer"/>,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfif Len(arguments.recurrenceRangeType)><cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>
                WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 
        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

    <cffunction name="updateAvailabilityTypeDailyWeekdays" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />
       
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
       
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfif Len(arguments.recurrenceRangeType)><cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>
                 WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 

        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

  <cffunction name="updateAvailabilityTypeWeekly" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="weekDays" type="string" required="true" />
        <cfargument name="recurCountInterval" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />
       	<!--- <cfdump var="#arguments#"><cfabort> --->
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
       
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfif Len(arguments.recurrenceRangeType)><cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Week_Days = <cfqueryparam value="#arguments.weekDays#" cfsqltype="cf_sql_varchar"/>,
                    Recur_Count_Interval = <cfqueryparam value="#arguments.recurCountInterval#" cfsqltype="cf_sql_integer"/>
                 WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 

        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

<cffunction name="updateAvailabilityTypeMonthlyWeek" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="recurrenceOrdinalIntervalID" type="numeric" required="true" />
        <cfargument name="recurrenceWeekdayIntervalID" type="numeric" required="true" />
        <cfargument name="recurCountInterval" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="true" />
       	<!--- <cfdump var="#arguments#"><cfabort> --->
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
       
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/>,
                   	Recurrence_Ordinal_Interval_ID = <cfqueryparam value="#arguments.recurrenceOrdinalIntervalID#" cfsqltype="cf_sql_integer" />,
                   	Recurrence_Weekday_Interval_ID = <cfqueryparam value="#arguments.recurrenceWeekdayIntervalID#" cfsqltype="cf_sql_integer" />,
                    Recur_Count_Interval = <cfqueryparam value="#arguments.recurCountInterval#" cfsqltype="cf_sql_integer"/>
                 WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 

        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

    <cffunction name="updateAvailabilityTypeYearlyDate" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="dayValue" type="numeric" required="true" />
        <cfargument name="yearlyMonth" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="true" />
       	<!--- <cfdump var="#arguments#"><cfabort> --->
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
       
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/>,
                    Day_Value = <cfqueryparam value="#arguments.dayValue#" cfsqltype="cf_sql_integer"/>,
                    Yearly_Month = <cfqueryparam value="#arguments.yearlyMonth#" cfsqltype="cf_sql_integer"/>
                 WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 

        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

  <cffunction name="updateAvailabilityTypeYearlyMonth" access="remote" output="false" returnFormat="json" returntype="struct">
        <cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="recurrenceOrdinalIntervalID" type="numeric" required="true" />
        <cfargument name="recurrenceWeekdayIntervalID" type="numeric" required="true" />
        <cfargument name="yearlyMonth" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="true" />
       	<!--- <cfdump var="#arguments#"><cfabort> --->
        <cfsetting showdebugoutput="false">
        <cfset var local = {} />
        <cfset local.Response = {
                            Success = true,
                            ErrMsg = ""} /> 
       
        <cftry>
            <cfquery name="local.qryResults" datasource="#request.dsn#" result="updateqryResult">
                UPDATE 
                    Availability
                SET 
                    Start_Date = <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" cfsqltype="cf_sql_timestamp" />,
                    End_Date =  <cfqueryparam value="#ISOToDateTime(arguments.endDate)#" cfsqltype="cf_sql_timestamp"/> ,
                    End_Recurrence_Date = <cfif Len(arguments.EndRecurrenceDate)><cfqueryparam value="#arguments.EndRecurrenceDate#" cfsqltype="cf_sql_date"/><cfelse>NULL</cfif>,
                    End_After_Ocurrences = <cfif Len(arguments.EndAfterOcurrences)><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer"/><cfelse>NULL</cfif>,
                    Recurrence_Range_Type_ID = <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer"/>,
                    Recurrence_Ordinal_Interval_ID = <cfqueryparam value="#arguments.recurrenceOrdinalIntervalID#" cfsqltype="cf_sql_integer"/>,
                    Recurrence_Weekday_Interval_ID = <cfqueryparam value="#arguments.recurrenceWeekdayIntervalID#" cfsqltype="cf_sql_integer"/>,
                    Yearly_Month = <cfqueryparam value="#arguments.yearlyMonth#" cfsqltype="cf_sql_integer"/>
                 WHERE 
                    Availability_ID = <cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" /> AND 
                    Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
            </cfquery> 

        <cfcatch type="any">
            <cfset local.Response.Success = false />
            <cfset local.Response.ErrMsg = cfcatch.message />
        </cfcatch>
        </cftry>    
        <cfreturn  local.Response />
    </cffunction>

  	<cffunction name="addAvailabilityTypeDailyDays" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="RecurCountInterval" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />
        <cfsetting showdebugoutput="false">
      <!---  <cfdump var="#arguments#"><cfabort> ---> 
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID,
            Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
                    #this.RECURRENCE_TYPE_DAILY_DAYS#,
                    <cfqueryparam value="#arguments.RecurCountInterval#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)
		</cfquery>
		
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction>  

  	<cffunction name="addAvailabilityTypeDailyWeekdays" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />
        <cfsetting showdebugoutput="false">
        <!---  <cfdump var="#arguments#"><cfabort>  --->      
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID,
            End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_DAILY_WEEKDAYS#,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)                    
		</cfquery>
		
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction> 

  	<cffunction name="addAvailabilityTypeWeekly" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="WeekDays" type="string" required="true" />
        <cfargument name="RecurCountInterval" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />        
        <cfsetting showdebugoutput="false">
       <!---  <cfdump var="#arguments#"><cfabort> --->
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID, Week_Days,
            Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_WEEKLY#,
                    <cfqueryparam value="#arguments.WeekDays#" cfsqltype="cf_sql_varchar" />,
                    <cfqueryparam value="#arguments.RecurCountInterval#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)  
		</cfquery>
		
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction> 

  	<cffunction name="addAvailabilityTypeMonthlyDate" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="DayValue" type="numeric" required="true" />
        <cfargument name="RecurCountInterval" type="numeric" required="false" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="true" />
        <cfargument name="recurrenceRangeType" type="numeric" required="true" />             
       <!---  <cfdump var="#arguments#"><cfabort> --->
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID, Day_Value,
            Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_MONTHLY_DATE#,
                    <cfqueryparam value="#arguments.DayValue#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.RecurCountInterval#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)  
		</cfquery>
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction> 

  	<cffunction name="addAvailabilityTypeMonthlyWeek" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="RecurrenceOrdinalIntervalID" type="numeric" required="true" />
        <cfargument name="RecurrenceWeekdayIntervalID" type="numeric" required="true" />
        <cfargument name="RecurCountInterval" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />          
       <!---  <cfdump var="#arguments#"><cfabort> --->
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID,
            Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID,
            Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_MONTHLY_WEEK#,
                    <cfqueryparam value="#arguments.RecurrenceOrdinalIntervalID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.RecurrenceWeekdayIntervalID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.RecurCountInterval#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)  
		</cfquery>
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction> 

  	<cffunction name="addAvailabilityTypeYearlyDate" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="DayValue" type="numeric" required="true" />
        <cfargument name="YearlyMonth" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />               
       <!---  <cfdump var="#arguments#"><cfabort> --->
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID, Day_Value, Yearly_Month,
            End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_YEARLY_DATE#,
                    <cfqueryparam value="#arguments.DayValue#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.YearlyMonth#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)  
		</cfquery>
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfreturn res />
    </cffunction> 

  	<cffunction name="addAvailabilityTypeYearlyMonth" access="remote" output="false" returntype="struct">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="StartDate" type="string" required="true" />
        <cfargument name="EndDate" type="string" required="true" />
        <cfargument name="RecurrenceOrdinalIntervalID" type="numeric" required="true" />
        <cfargument name="RecurrenceWeekdayIntervalID" type="numeric" required="true" />
        <cfargument name="YearlyMonth" type="numeric" required="true" />
        <cfargument name="EndRecurrenceDate" type="string" required="false" />
        <cfargument name="EndAfterOcurrences" type="numeric" required="false" />
        <cfargument name="recurrenceRangeType" type="numeric" required="false" />          
         <!---  <cfdump var="#arguments#"><cfabort>  ---> 
		<cfset var local = StructNew() />
		<cfif arguments.AvailabilityID eq 0>
			<cfset arguments.AvailabilityID = getProfessionalAvailabilityNextId()>
		</cfif>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	INSERT INTO Availability(
            Professional_ID, Availability_ID,Start_Date,End_Date,Recurrence_Type_ID,
            Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID, Yearly_Month, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID)
            VALUES (<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
            		<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#ISOToDateTime(arguments.StartDate)#" />,
					<cfqueryparam value="#ISOToDateTime(arguments.EndDate)#" />,
					#this.RECURRENCE_TYPE_YEARLY_MONTH#,
                    <cfqueryparam value="#arguments.RecurrenceOrdinalIntervalID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.RecurrenceWeekdayIntervalID#" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#arguments.YearlyMonth#" cfsqltype="cf_sql_integer" />,
                    <cfif Len(arguments.EndRecurrenceDate)>'#arguments.EndRecurrenceDate#'<cfelse>NULL</cfif>,
                    <cfif arguments.EndAfterOcurrences GT 0><cfqueryparam value="#arguments.EndAfterOcurrences#" cfsqltype="cf_sql_integer" /><cfelse>NULL</cfif>,
                    <cfqueryparam value="#arguments.recurrenceRangeType#" cfsqltype="cf_sql_integer" />)  
		</cfquery>
		<cfset var res = StructNew()>
		<cfset res['title'] = 'Available'>
		<cfset res['ID'] 	= arguments.AvailabilityID>
		<cfset res['start'] = arguments.StartDate>
		<cfset res['end'] 	= arguments.EndDate>
		
		<cfreturn res />
    </cffunction> 

 	<cffunction name="getProfessionalAvailabilityMaxID" access="remote" output="false" returntype="numeric">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
 		
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	SELECT ISNULL(Max(Availability_ID), 0) as MaxID
            FROM Availability
            WHERE Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />  
		</cfquery>
        
        <cfset local.MaxID = local.qryResults.MaxID />

        <cfreturn local.MaxID />
    </cffunction>
	
	<cffunction name="getProfessionalAvailabilityNextId" access="private" output="false" returntype="numeric">
		<cfset var local = StructNew() />
 		
		<cfquery name="local.qryResults" datasource="#request.dsn#">
        	SELECT ISNULL(Max(Availability_ID), 0) as MaxID
            FROM Availability
		</cfquery>
        
        <cfset local.MaxID = local.qryResults.MaxID + 1 />

        <cfreturn local.MaxID />
    </cffunction>

	<cffunction name="getProfessionalAppointments" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AppointmentDate" type="string" required="true" />
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT        Appointments.Appointment_ID AS 'id', Appointments.Start_Time AS Start_Date, Appointments.End_Time AS End_Date, 
						'|' + REPLACE(Services.Service_Name , '''', '') + ' - ' +  Customers.First_Name + ' ' + Customers.Last_Name  AS 'title'
			FROM            Appointments INNER JOIN
			                         Customers ON Appointments.Customer_ID = Customers.Customer_ID INNER JOIN
			                         Services ON Appointments.Service_ID = Services.Service_ID
            WHERE 	Appointments.Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                   	DATEDIFF(day, '#arguments.AppointmentDate#', Appointments.Start_Time) >= 0 
            ORDER BY Appointments.Start_Time
		</cfquery>
        
        <cfreturn local.qryResults />
        
    </cffunction>  

	<cffunction name="getProfessionalAppointmentsEvents" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AppointmentStartDate" type="string" required="true" />
        <cfargument name="AppointmentEndDate" type="string" required="true" />
        <cfsetting showdebugoutput="false">
        
    	<cfset var local = StructNew() />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
			SELECT  Appointments.Appointment_ID AS 'id', Appointments.Start_Time AS Start_Date, Appointments.End_Time AS End_Date, 
					'|' + REPLACE(Services.Service_Name , '''', '') + ' - ' +  Customers.First_Name + ' ' + Customers.Last_Name  AS 'title'
			FROM    Appointments 
			INNER JOIN
				Customers ON Appointments.Customer_ID = Customers.Customer_ID 
			INNER JOIN
				Services ON Appointments.Service_ID = Services.Service_ID
            WHERE 	
				Appointments.Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> 
			AND 
				CAST(Appointments.Start_Time AS DATE) >= <cfqueryparam value="#DateFormat(arguments.AppointmentStartDate,'yyyy-mm-dd')#" cfsqltype="cf_sql_timestamp" />
			AND
                CAST(Appointments.End_Time AS DATE) < <cfqueryparam value="#DateFormat(arguments.AppointmentEndDate,'yyyy-mm-dd')#" cfsqltype="cf_sql_timestamp" />
            ORDER BY Appointments.Start_Time
		</cfquery>
        
        <cfreturn local.qryResults />
        
    </cffunction>	
	
	<cffunction name="getCalendarAvailabilityEventJSONS" access="remote" output="false" returnFormat="json" returntype="string">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarEndDate" type="String" required="true" />		
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="yes" />
		
		<cfset arguments.CalendarDaysSpan = DateDiff("d", arguments.CalendarStartDate, arguments.CalendarEndDate)>
		
		<cfsetting showdebugoutput="false">
		<cfset var local = StructNew() />
        
		<cfset var qEventResults 		= QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
        <cfset var CalendarRangeDates 	= this.getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var eResult 	= {} />
        <cfset eResult.q 	= "" />
        
		<cfset var qEventAppointments 				= this.getProfessionalAppointmentsEvents(Professional_ID = arguments.Professional_ID, AppointmentStartDate = arguments.CalendarStartDate, AppointmentEndDate = arguments.CalendarEndDate) />
		
        <cfset var qEventRecurrenceTypeNone 		= this.getRecurrenceTypeNone(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qEventRecurrenceTypeDailyDays 	= this.getRecurrenceTypeDailyDays(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
    	<cfset var qEventRecurrenceTypeDailyWeekdays= this.getRecurrenceTypeDailyWeekdays(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qEventRecurrenceTypeWeekly 		= this.getRecurrenceTypeWeekly(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qEventRecurrenceTypeMonthlyDay 	= this.getRecurrenceTypeMonthlyDay(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qEventRecurrenceTypeMonthlyWeek 	= this.getRecurrenceTypeMonthlyWeek(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qEventRecurrenceTypeYearlyDate 	= this.getRecurrenceTypeYearlyDate(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qEventRecurrenceTypeYearlyMonth 	= this.getRecurrenceTypeYearlyMonth(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />

		<cfquery name="qEventResults" dbtype="Query">
			SELECT * FROM qEventAppointments
			UNION
			SELECT * FROM qEventRecurrenceTypeNone
			UNION
			SELECT * FROM qEventRecurrenceTypeDailyDays
			UNION
			SELECT * FROM qEventRecurrenceTypeDailyWeekdays
			UNION
			SELECT * FROM qEventRecurrenceTypeWeekly
			UNION
			SELECT * FROM qEventRecurrenceTypeMonthlyDay 
			UNION				
			SELECT * FROM qEventRecurrenceTypeMonthlyWeek				
			UNION				
			SELECT * FROM qEventRecurrenceTypeYearlyDate				
			UNION				
			SELECT * FROM qEventRecurrenceTypeYearlyMonth                                                                     
		</cfquery>
		
		<cfquery name="local.qEventResultsSorted" dbtype="Query">
			SELECT * FROM qEventResults ORDER BY Start_Date
		</cfquery>	        
		
		<cfquery name="local.qEventExceptions" datasource="#request.dsn#">
            SELECT Availability_ID, Professional_ID, Exception_Date
            FROM Availability_Exceptions
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />
        </cfquery>

		<cfset local.qEventFinalResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />

		<cfloop query="local.qEventResultsSorted">
        	<cfset local.bolAdd = true />
        	<cfloop query="local.qEventExceptions">
				<cfif local.qEventResultsSorted.ID EQ local.qEventExceptions.Availability_ID AND local.qEventResultsSorted.Start_Date EQ local.qEventExceptions.Exception_Date>
                	<cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>            
            </cfloop>
            <cfif local.bolAdd>
            	<cfset QueryAddRow(local.qEventFinalResults) />
                <cfset QuerySetCell(local.qEventFinalResults, "ID", local.qEventResultsSorted.ID) />
                <cfset QuerySetCell(local.qEventFinalResults, "Start_Date", local.qEventResultsSorted.Start_Date) />
                <cfset QuerySetCell(local.qEventFinalResults, "End_Date", local.qEventResultsSorted.End_Date) />
                <cfset QuerySetCell(local.qEventFinalResults, "Title", Replace(local.qEventResultsSorted.Title,"Available","Availability")) />
            </cfif>
        </cfloop>

        <cfset eResult.q 		= local.qEventFinalResults />
        <cfset eResult.results 	= [] />

        <cfloop query="eResult.q">
            <cfset eResult.temp 			= {} />
            <cfset eResult.temp['id'] 		= eResult.q['ID'][eResult.q.currentrow] />
            <cfset eResult.temp['start'] 	= parseDate(eResult.q['Start_Date'][eResult.q.currentrow]) />
            <cfset eResult.temp['end'] 		= parseDate(eResult.q['End_Date'][eResult.q.currentrow]) />
            <cfset eResult.temp['title'] 	= eResult.q['Title'][eResult.q.currentrow] />
            <cfset arrayAppend( eResult.results, eResult.temp ) />
        </cfloop> 

        <cfset eResult.data = {} />
        <cfset eResult.data = eResult.results />
        <cfreturn serializeJSON(eResult.data) />
	</cffunction>
	
	
  	<cffunction name="getCalendarAvailabilityJSONString" access="remote" output="false" returnFormat="json" returntype="string">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />		
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
		<cfargument name="noCache" type="string" required="yes" />

		<cfsetting showdebugoutput="false">
		<cfset var local = StructNew() />
        
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />  
        <cfset var CalendarRangeDates = this.getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var rs = {} />
        <cfset rs.q = "" />
              
        <cfset var qryRecurrenceTypeNone = this.getRecurrenceTypeNone(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeDailyDays = this.getRecurrenceTypeDailyDays(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
    	<cfset var qryRecurrenceTypeDailyWeekdays = this.getRecurrenceTypeDailyWeekdays(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qryRecurrenceTypeWeekly = this.getRecurrenceTypeWeekly(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qryRecurrenceTypeMonthlyDay = this.getRecurrenceTypeMonthlyDay(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qryRecurrenceTypeMonthlyWeek = this.getRecurrenceTypeMonthlyWeek(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qryRecurrenceTypeYearlyDate = this.getRecurrenceTypeYearlyDate(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, CalendarRangeDates) />
        <cfset var qryRecurrenceTypeYearlyMonth = this.getRecurrenceTypeYearlyMonth(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, CalendarRangeDates) />
		
		<cfset var qryAppointments = this.getProfessionalAppointments(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />

		<cfquery name="qryResults" dbtype="Query">
				SELECT * 
				FROM qryAppointments
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeNone
				
 				UNION 
			
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeDailyDays

				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeDailyWeekdays
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeWeekly  
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeMonthlyDay        
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeMonthlyWeek
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeYearlyDate
				
				UNION
				
				SELECT *<!--- , '' as Service_Name, '' as CustomerName --->
				FROM qryRecurrenceTypeYearlyMonth                                                                     
		</cfquery>
		
		<cfquery name="local.qryResultsSorted" dbtype="Query">
				SELECT * FROM qryResults ORDER BY Start_Date
		</cfquery>	        
		
		<cfquery name="local.qryExceptions" datasource="#request.dsn#">
            SELECT Availability_ID, Professional_ID, Exception_Date
            FROM Availability_Exceptions
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />
        </cfquery> 

		<cfset local.qryFinalResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />

		<cfloop query="local.qryResultsSorted">
        	<cfset local.bolAdd = true />
        	<cfloop query="local.qryExceptions">
				<cfif local.qryResultsSorted.ID EQ local.qryExceptions.Availability_ID AND local.qryResultsSorted.Start_Date EQ local.qryExceptions.Exception_Date>
                	<cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>            
            </cfloop>
            <cfif local.bolAdd>
            	<cfset QueryAddRow(local.qryFinalResults) />
                <cfset QuerySetCell(local.qryFinalResults, "ID", local.qryResultsSorted.ID) />
                <cfset QuerySetCell(local.qryFinalResults, "Start_Date", local.qryResultsSorted.Start_Date) />
                <cfset QuerySetCell(local.qryFinalResults, "End_Date", local.qryResultsSorted.End_Date) />
                <cfset QuerySetCell(local.qryFinalResults, "Title", local.qryResultsSorted.Title) />
<!--- 				<cfset QuerySetCell(local.qryFinalResults, "Service_Name", local.qryResultsSorted.Service_Name) />
				<cfset QuerySetCell(local.qryFinalResults, "CustomerName", local.qryResultsSorted.CustomerName) /> --->
            </cfif>
        </cfloop>

        <cfset rs.q = local.qryFinalResults />
        <cfset rs.results = [] />

         <cfloop query="rs.q">
            <cfset rs.temp = {} />

            <cfset rs.temp['id'] = rs.q['ID'][rs.q.currentrow] />
            <cfset rs.temp['start'] = parseDate(rs.q['Start_Date'][rs.q.currentrow]) />
            <cfset rs.temp['end'] = parseDate(rs.q['End_Date'][rs.q.currentrow]) />
            <cfset rs.temp['title'] = rs.q['Title'][rs.q.currentrow] />
<!--- 			<cfset rs.temp['service_name'] = rs.q['Service_Name'][rs.q.currentrow] />
			<cfset rs.temp['customername'] = rs.q['CustomerName'][rs.q.currentrow] /> --->
            
            <cfset arrayAppend( rs.results, rs.temp ) />
        </cfloop> 

        <cfset rs.data = {} />
        <cfset rs.data = rs.results />
        <cfreturn serializeJSON(rs.data) />

	</cffunction> 
    
    <cffunction name="parseDate" access="public" output="false" returntype="String">
    	<cfargument name="DateValue" type="date" required="true" />              

		<cfreturn (DateFormat(arguments.DateValue,"yyyy-mm-dd") & " " & TimeFormat(arguments.DateValue,"HH:mm:ss")) />    
    </cffunction>

	<cffunction name="getCalendarAvailability" access="remote" output="false" returntype="query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
		
		<cfset var local = StructNew() />
        
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />  
        <cfset var CalendarRangeDates = this.getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
              
        <cfset var qryRecurrenceTypeNone = this.getRecurrenceTypeNone(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeDailyDays = this.getRecurrenceTypeDailyDays(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, local.CalendarRangeDates) />
    	<cfset var qryRecurrenceTypeDailyWeekdays = this.getRecurrenceTypeDailyWeekdays(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, local.CalendarRangeDates) />
        <cfset var qryRecurrenceTypeWeekly = this.getRecurrenceTypeWeekly(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, local.CalendarRangeDates) />
        <cfset var qryRecurrenceTypeMonthlyDay = this.getRecurrenceTypeMonthlyDay(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, local.CalendarRangeDates) />
        <cfset var qryRecurrenceTypeMonthlyWeek = this.getRecurrenceTypeMonthlyWeek(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, local.CalendarRangeDates) />
        <cfset var qryRecurrenceTypeYearlyDate = this.getRecurrenceTypeYearlyDate(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan, local.CalendarRangeDates) />
        <cfset var qryRecurrenceTypeYearlyMonth = this.getRecurrenceTypeYearlyMonth(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan, local.CalendarRangeDates) />

		<cfquery name="qryResults" dbtype="Query">
				SELECT *
				FROM qryRecurrenceTypeNone
				
 				UNION 
			
				SELECT *
				FROM qryRecurrenceTypeDailyDays

				UNION
				
				SELECT *
				FROM qryRecurrenceTypeDailyWeekdays
				
				UNION
				
				SELECT *
				FROM qryRecurrenceTypeWeekly  
				
				UNION
				
				SELECT *
				FROM qryRecurrenceTypeMonthlyDay        
				
				UNION
				
				SELECT *
				FROM qryRecurrenceTypeMonthlyWeek
				
				UNION
				
				SELECT *
				FROM qryRecurrenceTypeYearlyDate
				
				UNION
				
				SELECT * 
				FROM qryRecurrenceTypeYearlyMonth                                                                     
		</cfquery>
		
		<cfquery name="local.qryResultsSorted" dbtype="Query">
				SELECT * FROM qryResults ORDER BY Start_Date
		</cfquery>		

		<cfquery name="local.qryExceptions" datasource="#request.dsn#">
            SELECT Availability_ID, Professional_ID, Exception_Date
            FROM Availability_Exceptions
            WHERE 	Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />
        </cfquery> 

		<cfset local.qryFinalResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />

		<cfloop query="local.qryResultsSorted">
        	<cfset local.bolAdd = true />
        	<cfloop query="local.qryExceptions">
				<cfif local.qryResultsSorted.ID EQ local.qryExceptions.Availability_ID AND local.qryResultsSorted.Start_Date EQ local.qryExceptions.Exception_Date>
                	<cfset local.bolAdd = false />
                    <cfbreak />
                </cfif>            
            </cfloop>
            <cfif local.bolAdd>
            	<cfset QueryAddRow(local.qryFinalResults) />
                <cfset QuerySetCell(local.qryFinalResults, "ID", local.qryResultsSorted.ID) />
                <cfset QuerySetCell(local.qryFinalResults, "Start_Date", local.qryResultsSorted.Start_Date) />
                <cfset QuerySetCell(local.qryFinalResults, "End_Date", local.qryResultsSorted.End_Date) />
                <cfset QuerySetCell(local.qryFinalResults, "Title", local.qryResultsSorted.Title) />
            </cfif>
        </cfloop>
        
		<cfreturn local.qryFinalResults  />
	</cffunction>     
    
    <cffunction name="getRecurrenceTypeNone" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="string" required="true" />
        <cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
        
		<cfset arguments.CalendarStartDate = DateFormat(arguments.CalendarStartDate, "mm/dd/yyyy") />
        
		<cfquery name="local.qryResults" datasource="#request.dsn#">
            SELECT  Availability_ID as 'id', Start_Date, End_Date, 
                    'Available' as 'title' 
            FROM Availability
            WHERE 
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_NONE#" cfsqltype="cf_sql_integer" /> AND 
            		Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                   	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                   	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan#
            ORDER BY Start_Date
		</cfquery>

		<cfreturn local.qryResults />
	</cffunction>        

	<cffunction name="getRecurrenceTypeDailyDays" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id', 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                        )
                    )
		</cfquery>
      
        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopModCount = 0 />
            
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") /> 
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfif local.EndAfterOcurrences GT 0>
                            <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        <cfelse>
                            <cfbreak />
                        </cfif>
                    </cfif>
                    
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                <cfset local.RecurCountInterval = local.qryRecurResults.Recur_Count_Interval />
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.RecurCountInterval) EQ 0>
                        <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") /> 
                        <cfif local.CurrentLoopDate LTE local.EndRecurrenceDate>
                            <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                        <cfelse>
                            <cfbreak />
                        </cfif>
                    </cfif>
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#arguments.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
					<cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
						Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
						Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  

	<cffunction name="getRecurrenceTypeDailyWeekdays" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_WEEKDAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopCount = 0 />
            
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") />

                    <cfif DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    <cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>
                
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") />
					<cfif local.EndAfterOcurrences GT 0>  
                    	<cfif DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
							<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                        	<cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />                        
						</cfif>
					<cfelse>
                    	<cfbreak />
                    </cfif>
                	<cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>
                        
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>
            	<cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
					<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Start_Date) , "mm/dd/yyyy") /> 

                    <cfif 	local.CurrentLoopDate LTE local.EndRecurrenceDate  AND
							DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND 
							DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    
                    <cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>            
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>

        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  
    
 	<!--- 	Recurrence_Type_ID = 3	"Weekly"
			Weekly:  Recur every [Recur_Count_Interval] weeks(s) on:  [Week_Days: comma seperated list of possible {1-7} corresponding to Su-Sa] --->
	<cffunction name="getRecurrenceTypeWeekly" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Week_Days
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_WEEKLY#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR 
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>
 
        <cfloop query="local.qryRecurResults">
        	<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = arguments.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Start_Date />
            <cfset local.WeekDaysList = local.qryRecurResults.Week_Days />    

			<!--- Find first week hit to start with --->
            <cfloop condition="ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) EQ 0 AND local.CurrentLoopDate LTE local.RangeEndDate">
                <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
            </cfloop>            
            
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="DateFormat(local.CurrentLoopDate,'mm/dd/yyyy') LTE local.RangeEndDate">
                	<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                	</cfif>
                    <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
                    	<!--- Put on Next Sunday start of week --->
                    	<cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        <!--- Add week(s) recur count --->
                        <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                        	<cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                        </cfif>
                     <cfelse>
                    	 <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                    </cfif>
                </cfloop>

			<!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="DateFormat(local.CurrentLoopDate,'mm/dd/yyyy') LTE local.RangeEndDate">
      				<cfif local.EndAfterOcurrences GT 0>
						<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
							<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        </cfif>
                        <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
							
                            <!--- Put on Next Sunday start of week --->
                            <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) />
							 
                            <!--- Add week(s) recur count --->
                            <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                                <cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                            </cfif>
							<cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                         <cfelse>
                             <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        </cfif>
                 	<cfelse>
                    	<cfbreak />
                 	</cfif>                        
                </cfloop>
    			
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
            	<cfloop condition="DateFormat(local.CurrentLoopDate,'mm/dd/yyyy') LTE local.RangeEndDate AND DateFormat(local.CurrentLoopDate,'mm/dd/yyyy') LTE local.EndRecurrenceDate">
                	<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                	</cfif>
                    <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
                    	<!--- Put on Next Sunday start of week --->
                    	<cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        <!--- Add week(s) recur count --->
                        <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                        	<cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                        </cfif>
                     <cfelse>
                    	 <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                    </cfif>
                </cfloop>                          
			</cfif>
<!---              <cfoutput>local.TargetDates</cfoutput>
            <cfdump var="#local.TargetDates#" />
            <cfoutput>arguments.CalendarRangeDates</cfoutput>
			<cfdump var="#arguments.CalendarRangeDates#" />  --->

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>            
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />	
    </cffunction>  
   
 	<!--- 	Recurrence_Type_ID = 4	"Monthly Date"
			Monthly:  Day [Day_Value] of every [Recur_Count_Interval] month(s) --->
    <cffunction name="getRecurrenceTypeMonthlyDay" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Day_Value
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_MONTHLY_DATE#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>


                
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = arguments.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Start_Date />
                
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        <cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
						<cfif local.EndAfterOcurrences GT 0>
							<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        	<cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        <cfelse>
                            <cfbreak />
                        </cfif>                        
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        <cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>            

        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>       

	<!--- Recurrence_Type_ID = 5	Monthly Week
		Monthly:  The [Recurrence_Ordinal_Interval_ID: 1st,2nd,3rd,4th,last] [Recurrence_Weekday_Interval_ID: day,weekday,weekend,Su-Sa] 
		of every [Recur_Count_Interval] month(s) --->
 	<cffunction name="getRecurrenceTypeMonthlyWeek" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
                    Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_MONTHLY_WEEK#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = arguments.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Start_Date />
                
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                    <cfif local.CurrentLoopDate LTE local.RangeEndDate>
						<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                    	<cfset local.CurrentLoopDate = 
								DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />                    
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.EndAfterOcurrences GT 0>
                        <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
						<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                    	<cfset local.CurrentLoopDate = 
									DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />

				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate>
						<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                    	<cfset local.CurrentLoopDate = 
									DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>            
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>    

		<!--- Recurrence_Type_ID = 6	Yearly Date
        		Yearly:  Every [Yearly_Month, 1-12] [Day_Value]  --->
    <cffunction name="getRecurrenceTypeYearlyDate" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Day_Value, Yearly_Month
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_YEARLY_DATE#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = arguments.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Start_Date), local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />

            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE DateFormat(local.qryRecurResults.Start_Date, 'mm/dd/yyyy')">
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE DateFormat(local.qryRecurResults.Start_Date, 'mm/dd/yyyy')">
                	<cfif local.EndAfterOcurrences GT 0>
                		<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />
                        <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
					<cfelse>
                        <cfbreak />
                    </cfif>                           
                </cfloop>                

    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE DateFormat(local.qryRecurResults.Start_Date, 'mm/dd/yyyy') AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />                   
                </cfloop>               
			</cfif>
			
            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>            
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  

	<!--- Recurrence_Type_ID = 7	Yearly Month
    			Yearly:  The [Recurrence_Ordinal_Interval_ID: 1st,2nd,3rd,4th,last] [Recurrence_Weekday_Interval_ID: day,weekday,weekend,Su-Sa] of [Yearly_Month: 1-12]
     --->
 	<cffunction name="getRecurrenceTypeYearlyMonth" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        <cfargument name="CalendarRangeDates" type="array" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("ID, Start_Date, End_Date, Title", "Integer, Timestamp, Timestamp, VarChar") />
 
		<cfquery name="local.qryRecurResults" datasource="#request.dsn#">
        	SELECT  Start_Date, End_Date, 
            		Availability_ID as 'id',            
            		End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
                    Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID, Yearly_Month
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_YEARLY_MONTH#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>
              
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = arguments.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Start_Date), 
															local.qryRecurResults.Yearly_Month, 1) />
            
         <!---    <cfoutput>
			local.qryRecurResults.Start_Date = #local.qryRecurResults.Start_Date#<br />
            local.CurrentLoopDate = #local.CurrentLoopDate#<br />
            local.RangeEndDate = #local.RangeEndDate#<br />
			</cfoutput> --->
      <!---       <cfif local.qryRecurResults.Start_Date GT local.CurrentLoopDate>
            	<cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Start_Date) + 1, 
															local.qryRecurResults.Yearly_Month, 1) />            	
            </cfif> --->
            
            
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                     

                    <cfif local.CurrentLoopDate LTE local.RangeEndDate>
                    	<cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
                        	<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        </cfif>
                    	<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) />                     
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.EndAfterOcurrences GT 0>
                        <cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
                        	<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        </cfif>
						<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) /> 
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />

				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate>
                    	<cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
							<cfset ArrayAppend(local.TargetDates, DateFormat(local.CurrentLoopDate, "mm/dd/yyyy")) />
                        </cfif>
						<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) /> 	
					<cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
            <cfloop index="i" array="#arguments.CalendarRangeDates#">
                <cfif ListContains(local.TargetDateList, i) GT 0>
                    <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "ID", local.qryRecurResults.id, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.Start_Date), Minute(local.qryRecurResults.Start_Date),0), local.CurrentRow) />
                        
                    <cfset QuerySetCell(qryResults, "End_Date", CreateDateTime(Year(i), Month(i), Day(i), 
                        Hour(local.qryRecurResults.End_Date), Minute(local.qryRecurResults.End_Date),0), local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Title", 'Available', local.CurrentRow) />	                    
                </cfif> 
            </cfloop>            
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Start_Date
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>    

     <cffunction name="getCalendarRangeDates" access="public" output="false" returntype="array">
        <cfargument name="CalendarStartDate" type="String" required="true" />
        <cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
        <cfset var local = StructNew() />
        <cfset var RangeDates = ArrayNew(1) />
        
        <cfset arguments.CalendarStartDate = DateFormat(arguments.CalendarStartDate, "mm/dd/yyyy") />
        
        
        <cfloop from="0" to="#arguments.CalendarDaysSpan - 1#" index="local.i">
        	<cfset RangeDates[local.i + 1] = DateFormat(DateAdd("d", local.i, arguments.CalendarStartDate) , "mm/dd/yyyy") />
        </cfloop>
        
        <cfreturn RangeDates />
    </cffunction>
    
    <cffunction name="IsWeekDay" access="public" output="false" returntype="boolean">
        <cfargument name="TestDate" type="String" required="true" default="#ToString(Now())#" />
		
        <cfset var local = StructNew() />
        <cfset var bolResults = false />
        <cftry>
        	<cfset bolResults = (DayOfWeek(arguments.TestDate) GTE 2 AND DayOfWeek(arguments.TestDate) LTE 6) />
            <cfcatch type="any">
                
             </cfcatch>            
        </cftry>

        <cfreturn bolResults />
    </cffunction>
    
    <cffunction name="IsWeekEnd" access="public" output="false" returntype="boolean">
        <cfargument name="TestDate" type="String" required="true" default="#ToString(Now())#" />
		
        <cfset var local = StructNew() />
        <cfset var bolResults = false />
        <cftry>
        	<cfset bolResults = (DayOfWeek(arguments.TestDate) EQ 1 OR DayOfWeek(arguments.TestDate) EQ 7) />
            <cfcatch type="any">
                
             </cfcatch>            
        </cftry>

        <cfreturn bolResults />
    </cffunction>
       
	<cffunction name="getXOfMonth" access="public" returntype="date" output="false">
        <cfargument name="Date" type="date" required="true"  />
        <cfargument name="OrdinalInterval" type="numeric" required="true" />
		<cfargument name="WeekdayType" type="numeric" required="true" />    	
    
    	<cfset var local = StructNew() /> 
<!---  
			WeekdayTypes
			1	Day
			2	Weekday
			3	Weekend Day
			4	Sunday
			5	Monday
			6	Tuesday
			7	Wednesday
			8	Thursday
			9	Friday
			10	Saturday 
---> 
        <cfset local.StartDate = CreateDate(Year(arguments.Date),Month( arguments.Date ),1) />
        <cfset local.FinalDate = local.StartDate />
        <cfset local.incrementBy = 1 />
        
        <cfif arguments.OrdinalInterval EQ this.RECURRENCE_ORDINAL_TYPE_LAST>
        	<cfreturn getLastXOfMonth(arguments.Date, arguments.WeekdayType) />
        <cfelse>
        	<cfset local.ContinueLoop = true />
            <cfloop condition="local.ContinueLoop">
            	<cfset local.OrdinalInterval = arguments.OrdinalInterval />
                <cfswitch expression="#WeekdayType#">
                    <cfcase value="1"><!--- Day --->
                        <cfset local.FinalDate = DateAdd( "d", local.OrdinalInterval - 1, local.StartDate ) />
                    </cfcase>
                    <cfcase value="2"><!--- Weekday --->
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif IsWeekDay(local.StartDate)>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>
                    </cfcase>     
                    <cfcase value="3"><!--- Weekend Day --->
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif IsWeekEnd(local.StartDate)>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval -1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>                                  
                    </cfcase>   
                    <cfcase value="4">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_SUNDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop> 
                                            
                    </cfcase>   
                    <cfcase value="5">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_MONDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>   
                    
                    <cfcase value="6">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_TUESDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>         	
                    </cfcase>   
                    <cfcase value="7">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_WEDNESDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>   
                    <cfcase value="8">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_THURSDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>            	
                    </cfcase>   
                    <cfcase value="9">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_FRIDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>             	
                    </cfcase>   
                    <cfcase value="10">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_SATURDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>                                                                                                          
                    <cfdefaultcase></cfdefaultcase>
                </cfswitch>
                
                <cfif local.FinalDate LT arguments.Date>
					<cfset local.StartDate = DateAdd('m', 1, CreateDate(Year(local.FinalDate),Month(local.FinalDate),1)) />
                    <cfset local.FinalDate = local.StartDate />
                <cfelse>
                	<cfset local.ContinueLoop = false />
                </cfif>
       		</cfloop>
        </cfif>

    	<cfreturn DateFormat(local.FinalDate,"mm/dd/yyyy") />        
    </cffunction>

    <cffunction name="getLastXOfMonth" access="public" returntype="date" output="false"> 
        <cfargument name="Date" type="date" required="true"  />
		<cfargument name="WeekdayType" type="numeric" required="true" />
        <cfset var local = StructNew() />

        <cfset local.ThisMonth = CreateDate(Year(arguments.Date),Month(arguments.Date),1) />
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
        <cfset local.ContinueLoop = true />
        <cfloop condition="local.ContinueLoop">
            <cfswitch expression="#WeekdayType#">
                <cfcase value="1">
                    <!--- Already calculated  --->
                </cfcase>
                <cfcase value="2">
                    <cfloop condition="Not IsWeekDay(local.LastDay)">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>     
                <cfcase value="3">
                    <cfloop condition="Not IsWeekEnd(local.LastDay)">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>   
                <cfcase value="4">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_SUNDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>   
                <cfcase value="5">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_MONDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="6">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_TUESDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="7">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_WEDNESDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="8">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_THURSDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="9">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_FRIDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="10">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_SATURDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>                                                                                                          
                <cfdefaultcase></cfdefaultcase>
             </cfswitch>
    
            <cfif local.LastDay LT arguments.Date>
                <cfset local.ThisMonth = DateAdd('m', 1, CreateDate(Year(local.ThisMonth),Month(local.ThisMonth),1)) />
        		<cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
            <cfelse>
                <cfset local.ContinueLoop = false />
            </cfif>         
         </cfloop>

    	<cfreturn local.LastDay />
    </cffunction>
    
    <cffunction name="getLastWeekendDayOfMonth" access="public" returntype="date" output="false"> 
        <cfargument name="Date" type="date" required="true"  />

        <cfset var local = StructNew() />

        <cfset local.ThisMonth = CreateDate(Year( arguments.Date ),Month( arguments.Date ),1) />
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
        
        <cfloop condition="Not IsWeekEnd(local.LastDay)">
			<cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
        </cfloop>
    
    	<cfreturn local.LastDay />
    </cffunction>    
    
    <cffunction name="getLastDayOfWeekOfMonth" access="public" returntype="date" output="false" hint="Returns the date of the last given weekday of the given month.">
        <cfargument name="Date" type="date" required="true"hint="Any date in the given month we are going to be looking at." />
        <cfargument name="DayOfWeek" type="numeric" required="true" hint="The day of the week of which we want to find the last monthly occurence." />
     
        <!--- Define the local scope. --->
        <cfset var local = StructNew() />
     
        <!--- Get the current month based on the given date. --->
        <cfset local.ThisMonth = CreateDate(Year( arguments.Date ),Month( arguments.Date ),1) />
     
        <!---Now, get the last day of the current month. We can get this by subtracting 1 from the first day of the next month.--->
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
     
        <!---
            Now, the last day of the month is part of the last
            week of the month. However, there is no guarantee
            that the target day of this week will be in the current
            month. Regardless, let's get the date of the target day
            so that at least we have something to work with.
        --->
        <cfset local.Day = (local.LastDay - DayOfWeek( local.LastDay ) + arguments.DayOfWeek) />
     
        <!---
            Now, we have the target date, but we are not exactly
            sure if the target date is in the current month. if
            is not, then we know it is the first of that type of
            the next month, in which case, subracting 7 days (one
            week) from it will give us the last occurence of it in
            the current Month.
        --->
        <cfif (Month( local.Day ) NEQ Month( local.ThisMonth ))>
            <!--- Subract a week. --->
            <cfset local.Day = (local.Day - 7) />
        </cfif>
     
     
        <!--- Return the given day. --->
        <cfreturn DateFormat( local.Day ) />
    </cffunction>
	
	<cffunction name="getProfessionalsList" access="public" output="false" returntype="query">
		<cfquery name="qGetProfessionalsList" datasource="#request.dsn#">
            SELECT DISTINCT 
				Professionals.Professional_ID, Professionals.Title_ID, Professionals.Last_Name, Professionals.First_Name
            FROM  
				Professionals 
			INNER JOIN
                Professionals_Services ON Professionals.Professional_ID = Professionals_Services.Professional_ID
            WHERE   
				Professionals.Active_Flag = 1
            ORDER BY 
				Professionals.Last_Name, Professionals.First_Name
        </cfquery> 
        <cfreturn  qGetProfessionalsList />
    </cffunction>
	
	<cffunction name="getCustomersListBy" access="public" output="false" returntype="query">
		<cfargument name="company_id" required="true" type="numeric">
		
		<cfquery name="qGetCustomersList" datasource="#request.dsn#">
            SELECT DISTINCT 
				Customers.Customer_ID, Customers.First_Name, Customers.Last_Name
            FROM  
				Customers
			WHERE 1 = 1
			AND Company_ID = <cfqueryparam value="#arguments.company_id#" cfsqltype="cf_sql_integer">
            ORDER BY 
				Customers.Last_Name, Customers.First_Name
        </cfquery> 
        <cfreturn  qGetCustomersList />
    </cffunction>

     <cffunction name="updateRecurrenceAvailability" output="false" returntype="struct" access="remote">
		<cfargument name="Professional_ID" type="numeric" required="true" />
        <cfargument name="AvailabilityID" type="numeric" required="true" />
        <cfargument name="ExceptionDate" type="string" required="true" />
		
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					ErrMsg = ""} />
		<cftry>
		<cfquery name="local.qryResults" datasource="#request.dsn#">
			INSERT INTO Availability_Exceptions(Availability_ID, Professional_ID, Exception_Date)
			VALUES (<cfqueryparam value="#arguments.AvailabilityID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" />,
					'#arguments.ExceptionDate#')
		</cfquery>
		<cfcatch type="any">
			<cfset local.Response.Success = false />
			<cfset local.Response.ErrMsg = cfcatch.message />
		</cfcatch>
		</cftry>	
        <cfreturn  local.Response />		
	</cffunction>
	
	
	<cffunction name="ISOToDateTime" access="public" returntype="string" output="false" hint="Converts an ISO 8601 date/time stamp with optional dashes to a ColdFusion date/time stamp.">
		<cfargument name="Date" type="string" required="true" hint="ISO 8601 date/time stamp." >
        <cfreturn arguments.Date.ReplaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$","$1-$2-$3 $4") >
	</cffunction>

</cfcomponent>