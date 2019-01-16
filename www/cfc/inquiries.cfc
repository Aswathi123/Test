<cfcomponent output="false">
	
	<cffunction name="logInquiry" access="remote" output="false" returntype="any">
    	<cfargument name="Name" type="string" required="true" />
        <cfargument name="Email" type="string" required="true" />
		<cfargument name="Phone" type="string" required="true" />
		<cfargument name="Message" type="string" required="true" />
		<cfargument name="Location_ID" type="numeric" required="true" />
		<cfargument name="Company_Email" type="string" required="false" />
		<cfsetting showdebugoutput="no">
	<!--- 	<cfdump var="#arguments.Email#"><cfdump var="#arguments.Company_Email#"><cfabort> --->
		<cftry>
			<cfquery datasource="#request.dsn#" result="resultInquiry" name="qSubmitInquiry">
	           INSERT INTO Inquiries (Sender_Name,Sender_Email,Sender_Phone,Sender_Message,Location_ID, received_date,receivedDate)
			VALUES
				(
					<cfqueryparam value="#arguments.Name#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Email#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Phone#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Message#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Location_ID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp"/>,
					<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp"/>
				)
	       	</cfquery>
	     	<!--- TODO: replace with system.sendemail --->
	       <!--- 	<cfif structKeyExists(arguments,"Company_Email")>
				<cfmail from="noreply@salonworks.com" to="#arguments.Company_Email#" subject="Web Site Inquiry">
				This message was sent from you the Contact Us page on your SalonWorks web site.
				
				Name: #arguments.Name#
				Email Address: #arguments.Email#
				Phone Number: #arguments.Phone#
				Message:
				#arguments.Message#
				</cfmail>
			</cfif> --->

			<cfif structKeyExists(arguments,"Company_Email")><!--- Need to enter the password --->
				<cfmail server="smtp.gmail.com" port="587" to="#arguments.Email#" from="#arguments.Company_Email#"
				 subject="#cgi.server_name#" type="HTML" username="#arguments.Company_Email#" password="" charset="UTF-8" usetls="true">
   						Name: #arguments.Name#
						Email Address: #arguments.Email#
						Phone Number: #arguments.Phone#
						Message:#arguments.Message#
				</cfmail>
			</cfif>
	       	
	       	<cfreturn true />
	    <cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
	    </cftry>
	
    </cffunction>
	
</cfcomponent>