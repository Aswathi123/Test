<cfcomponent displayname="email_campaign" hint="Sending email Campaign">
	
	<cffunction name="sendMailToALLCustomers">
		<cfargument name="emaildata" type="struct">
		<cfquery name="getAllcustomerEmail" datasource="#request.dsn#">
			select *
			from Customers
			where Preferred_Professional_ID = <cfqueryparam value="#arguments.emaildata.professional_id#" cfsqltype="cf_sql_numeric" > 
		</cfquery>
		<cfloop query="getAllcustomerEmail">
			<cfoutput>
				<cfmail 
					from="salonworks@salonworks.com"
					subject="#arguments.emaildata.emailSubject#"
					type="HTML"
					to="#getAllcustomerEmail.Email_Address#"
					<!--- to="#getAllcustomerEmail.Email_Address#" --->
					server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" >
					Dear #getAllcustomerEmail.FIRST_NAME# #getAllcustomerEmail.LAST_NAME#,
					<br>
					<cfoutput>#arguments.emaildata.emailContent#</cfoutput>
					<br>
					Regards,<br>
					SalonWorks Customer Support<br>
					salonworks@salonworks.com
				</cfmail>
			</cfoutput>
		</cfloop>
	</cffunction>

	<cffunction name="sendMailToSelectedCustomers">
		<cfargument name="emaildata" type="struct">
		<cfloop list="#arguments.emaildata.serviceId#" index="item">
			<cfquery name="getmail" datasource="#request.dsn#">
				select distinct(EMAIL_ADDRESS) as EMAIL_ADDRESS,FIRST_NAME,LAST_NAME
				from Appointments a 
				inner join Customers c on a.Customer_ID = c.Customer_ID
				where a.Professional_ID = <cfqueryparam value="#arguments.emaildata.professional_id#" cfsqltype="cf_sql_numeric" > 
				AND a.Service_ID = <cfqueryparam value="#item#" cfsqltype="cf_sql_numeric" > 
			</cfquery>
			<cfloop query="getmail">
				<cfmail 					
					from="salonworks@salonworks.com"
					subject="#arguments.emaildata.emailSubject#"
					type="HTML"
					to="#getmail.EMAIL_ADDRESS#"
					<!--- to="#getmail.EMAIL_ADDRESS#" --->
					server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" >
					Dear <cfoutput>#getmail.FIRST_NAME# #getmail.LAST_NAME#</cfoutput>,
					<br>
					#arguments.emaildata.emailContent#
					<br>
					Regards,<br>
					SalonWorks Customer Support<br>
					salonworks@salonworks.com
				</cfmail>
			</cfloop>
		</cfloop>		
	</cffunction>

	<cffunction name="getServices">
		<cfargument name="professional_id">
		<cfquery name="getServiceList" datasource="#request.dsn#">
			<!---select s.Service_Name,s.Service_ID
			from Services s inner join Professionals_Services ps on s.Service_ID = ps.Service_ID
			where Professional_ID = <cfqueryparam value="#arguments.professional_id#" cfsqltype="cf_sql_numeric" >--->
			select s.Service_Name,s.Service_ID
			from Predefined_Services s inner join Professionals_Services ps on s.Service_ID = ps.Service_ID
			where Professional_ID = <cfqueryparam value="#arguments.professional_id#" cfsqltype="cf_sql_numeric" >
		</cfquery>
		<cfreturn getServiceList>
	</cffunction>

</cfcomponent>