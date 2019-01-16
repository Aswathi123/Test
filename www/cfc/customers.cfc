<cfcomponent output="false">
	<cfsetting showdebugoutput=false>
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
            SELECT 	top 1 Customer_ID, Email_Address, First_name + ' ' + Last_name as name
			FROM 	Customers
			WHERE 	Email_Address = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />
			AND 	Password = <cfqueryparam value="#arguments.pw#" cfsqltype="cf_sql_varchar" />
        	</cfquery>
		
			<cfif local.qryResultsLogin.RecordCount>
				<cfset local.Response.CustomerID = local.qryResultsLogin.Customer_ID />
				<cfset local.Response.Email_Address = local.qryResultsLogin.Email_Address />
				<cfset local.Response.name = local.qryResultsLogin.name />
				<cfset session.CustomerID = local.qryResultsLogin.Customer_ID />
				<cfset variables.CustomerID = session.CustomerID>
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
		<cfargument name="companyId" type="numeric" required="false" />
    	<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					FailedMsg = ""} />

		<cfquery name="local.qryResultsExist" datasource="#request.dsn#">
            SELECT * FROM Customers WHERE Email_Address = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />
			<cfif structkeyexists(arguments,"companyId") and len(trim(arguments.companyId))>
				AND Company_ID = <cfqueryparam value="#arguments.companyId#" cfsqltype="cf_sql_integer" />
			</cfif>
        </cfquery>

		<cfif local.qryResultsExist.RecordCount>
			<cfset local.Response.Success = false />
			<cfset local.Response.FailedMsg = "That email address already exists. Please login.  If you forgot your password <a href=''>click here</a>." />

		<cfelse>
			<cfquery name="local.qryResults" datasource="#request.dsn#">
				INSERT INTO Customers (Email_Address, Password, First_Name, Last_Name, Mobile_Phone,Company_ID,Preferred_Professional_ID)
				VALUES(
					<cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.pw#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.ph#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.companyId#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#session.Professional_ID#" cfsqltype="cf_sql_integer" />
				)
	        </cfquery>

			<cfset local.Response = this.loginCustomer(arguments.emailAddress, arguments.pw) />

		</cfif>

        <cfreturn  local.Response />
    </cffunction>

	<cffunction name="logoutCustomer" access="remote" output="false" returntype="string">

		<cfset structClear( session ) />

		<cfreturn "" />

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
				where Email_Address=<cfqueryparam value="#finduser.Email_Address#" cfsqltype="cf_sql_varchar">
			</cfquery> --->

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
			<cfreturn 1>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>

</cfcomponent>