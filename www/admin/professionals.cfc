<cfcomponent displayname="Professionals" hint="">
	
	<cffunction name="getProfessional" access="public" output="false" returntype="query" hint="Returns query of Location based on Location_ID">
		<cfargument name="Professional_ID" type="numeric" required="false" default="0">
		<cfargument name="Location_ID" type="numeric" required="false" default="0">
		<cfargument name="Company_ID" type="numeric" required="false" default="0">
		<cfquery name="getProfessional" datasource="#request.dsn#">
			SELECT 
			   Professionals.Professional_ID
		      ,Professionals.Location_ID
		      ,Professionals.Title_ID
		      ,Professionals.First_Name
		      ,Professionals.Last_Name
		      ,Professionals.License_No
		      ,Professionals.License_Expiration_Month
		      ,Professionals.License_Expiration_Year
		      ,Professionals.License_State
		      ,Professionals.Home_Phone
		      ,Professionals.Mobile_Phone
		      ,Professionals.Home_Address
		      ,Professionals.Home_Address2
		      ,Professionals.Home_City
		      ,Professionals.Home_State
		      ,Professionals.Home_Postal
		      ,Professionals.Email_Address
		      ,Professionals.Password
		      ,Professionals.Services_Offered
		      ,Professionals.Accredidations
		      ,Professionals.Bio
		      ,Professionals.Active_Flag
		      ,Professionals.Appointment_Increment
			  ,Locations.Location_Name
			  ,Professionals.Do_It_Later
			FROM Professionals
				  LEFT JOIN Locations 
				  ON Professionals.Location_ID=Locations.Location_ID
		  WHERE 
		  1=1
		  <cfif arguments.Professional_ID gt 0>
		  	AND Professional_ID=#arguments.Professional_ID#
		  </cfif>
		  <cfif arguments.Location_ID gt 0>
		  	AND Professionals.Location_ID=#arguments.Location_ID#
		  </cfif>
		  	AND Company_ID=#arguments.Company_ID# 
		</cfquery>
		<cfreturn getProfessional>
	</cffunction>
	
	<cffunction name="InsertProfessional" access="public" output="false" returntype="numeric" hint="">
		<cftransaction isolation="READ_COMMITTED">
			<cfquery name="InsertProfessional" datasource="#request.dsn#">
				INSERT INTO Professionals
				(License_No) VALUES ('')
			</cfquery>
			<cfquery name="getProfessional" datasource="#request.dsn#">
				SELECT Max(Professional_ID) as New_Professional_ID FROM Professionals 
				<!--- WHERE Professional_Name='#arguments.Professional_Name#' --->
			</cfquery>
		</cftransaction>
		<cfreturn getProfessional.New_Professional_ID>
	</cffunction> 
	
	<cffunction name="UpdateProfessional" access="remote" output="false" returntype="any">
		<!--- Make a cfargument for each column name --->
		<cfargument name="Professional_ID" type="numeric" required="true">
		<cfargument name="Location_ID" type="string" required="false">
		<cfargument name="Title_ID" type="string" required="false" default="">
		<cfargument name="First_Name" type="string" required="false">
		<cfargument name="Last_Name" type="string" required="false">
		<cfargument name="License_No" type="string" required="false" default="">
		<cfargument name="License_Expiration_Month" type="string" required="false" default="0">
		<cfargument name="License_Expiration_Year" type="string" required="false" default="0">
		<cfargument name="License_State" type="string" required="false" default="">
		<cfargument name="Home_Phone" type="string" required="false" default="">
		<cfargument name="Mobile_Phone" type="string" required="false">
		<cfargument name="Home_Address" type="string" required="false" default="">
		<cfargument name="Home_Address2" type="string" required="false" default="">
		<cfargument name="Home_City" type="string" required="false" default="">
		<cfargument name="Home_State" type="string" required="false" default="">
		<cfargument name="Home_Postal" type="string" required="false" default="">
		<cfargument name="Email_Address" type="string" required="false" default="">
		<cfargument name="Password" type="string" required="false" default="">
		<cfargument name="Services_Offered" type="string" required="false" default="">
		<cfargument name="Accredidations" type="string" required="false" default="">
		<cfargument name="Bio" type="string" required="false" default="">
		<cfargument name="Active_Flag" type="string" required="false" default="1" >
		<cfargument name="Appointment_Increment" type="numeric" required="false" default="15">
		<cfargument name="passwordStatus" type="string" required="false">
		<cftry>
			<!--- if at least one argument exists (except the required Professional_ID) --->
			<cfquery name="getPassword" datasource="#request.dsn#" >
				SELECT Password 
				FROM Professionals
				WHERE Professional_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Professional_ID#">
			</cfquery>
			<cfif (structkeyexists(arguments,'Password') and len(arguments.Password))>
				<cfset pw = arguments.password />
			<cfelseif getPassword.recordcount and len(getPassword.Password)>
				<cfset pw = getPassword.Password >
			<cfelse>
				<cfset charlist =
				"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!$%^&*">
				<cfset pw = "">
				<cfloop index="sub" from="1" to="6">
				<cfset pw = pw & Mid(charlist, RandRange(1, Len(charlist)),1)>
				</cfloop>
			</cfif>
			<cfif StructCount(arguments) GT 1>
				<cfset var upd_cols = Duplicate(arguments)>
				<cfif structkeyexists(upd_cols, "Professional_ID")>
					<cfset StructDelete(upd_cols,"Professional_ID")>
				</cfif>
				<cfset var cnt = 0>
				<cfif structKeyExists(arguments, "passwordStatus") and len(trim(arguments.passwordStatus))>
					<cfquery name="UpdateProfessional" datasource="#request.dsn#" result="updateresult">
						UPDATE Professionals
						SET Password=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Password#">
						WHERE Professional_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Professional_ID#">
					</cfquery>
				<cfelse>
					<cfquery name="UpdateProfessional" datasource="#request.dsn#" result="updateresult">
								UPDATE Professionals
									SET 
										<!---cfloop collection="#upd_cols#" item="col">
											
											<cfif structkeyexists(arguments, col)>
												<cfset cnt ++>
												<cfif cnt GT 1>, </cfif>
												#col# = '#arguments['#col#']#'
											</cfif>
										</cfloop--->
										<cfif structKeyExists(arguments, "Location_ID")>
								   		 	Location_ID='#arguments.Location_ID#'
										</cfif>
										<cfif structKeyExists(arguments, "Title_ID")>
								   			,Title_ID='#arguments.Title_ID#'
										</cfif>
										<cfif structKeyExists(arguments, "First_Name")>
								   			,First_Name='#arguments.First_Name#'
										</cfif>
										<cfif structKeyExists(arguments, "Last_Name")>
								   			,Last_Name='#arguments.Last_Name#'
										</cfif>
										<cfif structKeyExists(arguments, "License_No")>
								   			,License_No='#arguments.License_No#'
										</cfif>
										<cfif structKeyExists(arguments, "License_Expiration_Month")>
								   			,License_Expiration_Month='#arguments.License_Expiration_Month#'
										</cfif>
										<cfif structKeyExists(arguments, "License_Expiration_Year")>
								   			,License_Expiration_Year='#arguments.License_Expiration_Year#'
										</cfif>
										<cfif structKeyExists(arguments, "License_State")>
								   			,License_State='#arguments.License_State#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_Phone")>
								   			,Home_Phone='#arguments.Home_Phone#'
										</cfif>
										<cfif structKeyExists(arguments, "Mobile_Phone")>
								   			,Mobile_Phone='#arguments.Mobile_Phone#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_Address")>
								   			,Home_Address='#arguments.Home_Address#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_Address2")>
								   			,Home_Address2='#arguments.Home_Address2#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_City")>
								   			,Home_City='#arguments.Home_City#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_State")>
								   			,Home_State='#arguments.Home_State#'
										</cfif>
										<cfif structKeyExists(arguments, "Home_Postal")>
								   			,Home_Postal='#arguments.Home_Postal#'
										</cfif>
										<cfif structKeyExists(arguments, "Email_Address")>
								   			,Email_Address='#arguments.Email_Address#'
										</cfif>
										<cfif structKeyExists(arguments, "Password") and(len(#pw#))>
								   			,Password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pw#">
										</cfif>
										<cfif structKeyExists(arguments, "Services_Offered")>
								   			,Services_Offered='#arguments.Services_Offered#'
										</cfif>
										<cfif structKeyExists(arguments, "Accredidations")>
								   			,Accredidations='#arguments.Accredidations#'
										</cfif>
										<cfif structKeyExists(arguments, "Bio")>
								   			,Bio='#arguments.Bio#'
										</cfif>
										<cfif structKeyExists(arguments, "Active_Flag")>
								   			,Active_Flag='#arguments.Active_Flag#'
										</cfif>
										<cfif structKeyExists(arguments, "Appointment_Increment")>
								   			,Appointment_Increment = '#arguments.Appointment_Increment#' 
										</cfif>
							  	WHERE Professional_ID=#arguments.Professional_ID#
						</cfquery>
				</cfif>
			</cfif>
		 	<cfset local.data = {} >
		 	<cfset local.data.value = true >
		 	<cfset local.data.pw = pw >
		<cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
		</cftry>
		<cfreturn local.data />
	</cffunction>

	<cffunction name="loginProfessional" access="remote" output="false" returntype="any">
		<cfargument name="Email_Address" type="string" required="true" />
        <cfargument name="Password" type="string" required="true" />
        <cfargument name="firstsignup" type="string" required="false" />
		<cfinvoke component="login" method="login" returnvariable="loggedin">
			<cfinvokeargument name="Email_Address_log" value="#Trim(arguments.Email_Address)#">
			<cfinvokeargument name="Password" value="#Trim(arguments.Password)#">
		</cfinvoke>
		
		<cfif loggedin and (structKeyExists(arguments, 'firstsignup') and len(arguments.firstsignup))>
			<cflocation url="index.cfm?swflg" addtoken="No"/>
		<cfelseif loggedin>
		<cflocation url="index.cfm" addtoken="No"/>
		</cfif>
	</cffunction>
	<cffunction name="forgotPassword" access="remote" output="false" returntype="numeric" returnformat="plain">
		<cfargument name="email" required="true" type="string">
		<cfquery name="findUser" datasource="salonworks">
			SELECT * from Professionals
			where Email_Address=<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfif finduser.RecordCount gt 0>
		<!--- 	<cfquery name="newpassword" datasource="#request.dsn#">
				update Professionals
				set password=<cfqueryparam value="newpass#findUser.Professional_ID#" cfsqltype="cf_sql_nvarchar">
				where Email_Address=<cfqueryparam value=" #finduser.Email_Address#" cfsqltype="cf_sql_varchar">
			</cfquery> --->
			<!--- <cfmail server="smtp.gmail.com" port="465" from="aswathi.k@spericorn.com" to="aswathi.k@spericorn.com" subject="New Password for Login" type="HTML" username="aswathi.k@spericorn.com" password=""  useSSL ="yes" useTLS ="yes">
				<h3>You can use the password given below for the retrieval of your Salonworks account</h3>
				<div>
					Your password is: #finduser.password#
				</div>
			</cfmail>--->

			<cfmail from="salonworks@salonworks.com" to="#finduser.Email_Address#" bcc="ciredrofdarb@gmail.com" subject="New Password for Login" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
				<!--- <h3>You can use the password given below for the retrieval of your Salonworks account</h3>
				<div>
					Your password is: #finduser.password#
				</div> --->
				<cfmailpart type="text/html">
					<div style="background: ##f0f3f6; min-height: 100vh;">
						<div class="container" style="margin: auto; max-width: 100%; width: 840px; border:1px solid ##ddd; border-bottom: 0; background: ##fff;">
							<table class="main-width" style="border-spacing: 0; width:100%;" border="0" cellspacing="0" cellpadding="0"><!--logo-space-->
								<tbody>
									<tr>
										<td>
											<table style="width: 840px; margin: auto; border-spacing: 0px;"><!--text-content-->
												<tbody>
													<tr class="" style="width: 100%; background: ##fff; text-align: center;">
														<td style="padding: 20px 0;"> <a href=""><img src="http://salonworks.com/img/logo.png" alt=""></a></td>
													</tr>
													<table border="0" cellspacing="0" cellpadding="0" style=" height:265px; width: 100%; text-align: left;">
														<tr>
															<td style="padding: 10px 50px;">

															<h2 style="font-family: Roboto, sans-serif, arial;" >Hello #finduser.First_Name#' '#finduser.Last_Name#</h2>

																<p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; margin-bottom:40px;">
															
																	You can use the password given below for the retrieval of your Salonworks account<br>
																	
																	<strong>Password:</strong>#finduser.password#<br><br>

																</p>
															</td>
														</tr>
														<tr>
															<td style="padding: 10px 50px;">
																<p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; padding-top: 25px; border-top: 1px solid ##eee;"">
																	Regards,<br>
																	SalonWorks Customer Support<br>
																	salonworks@salonworks.com
														 		</p>
															</td>
														</tr>
													</table>
												<!--##1f2937-->

													<table border="0" cellspacing="0" cellpadding="0" style=" height:95px; width: 100%; text-align: center; background: ##2995d3; padding: 34px 5px;">
														<tr>
														<td style="width: 33%; float: left; ">
															<a href="https://www.facebook.com/pages/Salonworks/1434509316766493" style="margin-right: 10px;"><img src="http://salonworks.com/images/facebook_round.png" alt=""></a>
														</td>
														<td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
														<img src="http://salonworks.com/images/call.png" alt="" style="vertical-align: middle; margin-right: 5px;">
															<label>
															 <a href="tel:+ (978) 352-0235" style="color: ##fff; text-decoration:  none;">+ (978) 352-0235</a>
															</label>
														</td>

														<td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
														<img src="http://salonworks.com/images/mail.png" alt="" style="vertical-align: middle; margin-right: 5px;">
															<label>
															 <a href="mailto:salonworks@salonworks.com" style="color: ##fff; text-decoration:  none;">salonworks@salonworks.com </a>
															</label>

														</td>
														</tr>
													</table>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</cfmailpart>
			</cfmail>
			<!--- <cfmail from="salonworks@salonworks.com" to="#finduser.Email_Address#" subject="New Password for Login" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
				<h3>You can use the password given below for the retrieval of your Salonworks account</h3>
				<div>
					Your password is: #finduser.password#
				</div>
			</cfmail> --->
			<cfreturn 1>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>
	
</cfcomponent>