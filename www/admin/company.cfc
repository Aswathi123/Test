<cfcomponent displayname="Company" hint="">




	<cffunction name="isExistingEmailAddress" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="EmailAddress" type="string" required="yes" />
		<cfargument name="password" type="string" required="no" />
		<cfargument name="noCache" type="string" required="yes" />
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					errMsg = "",
        					Data = 0} />
        <cftry>

            <cfquery name="local.qryResults" datasource="#request.dsn#">
				SELECT TOP 1 1 FROM Professionals
				WHERE UPPER(Email_Address) = <cfqueryparam value="#UCase(arguments.EmailAddress)#" cfsqltype="cf_sql_varchar" />
				<cfif structKeyExists(arguments, "password") and len(arguments.password)>
				and Password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar" />
				</cfif>
            </cfquery>

			<cfif local.qryResults.RecordCount>
				<cfset local.Response.Data = 1 />
			</cfif>

        <cfcatch type="any">
			<cfdump var="#cfcatch#" />
			<cfset local.Response.Success = false />
            <cfset local.Response.errMsg = cfcatch.Message />
        </cfcatch>
        </cftry>

        <cfreturn local.Response />
	</cffunction>


	<cffunction name="isExistingCompanyEmail" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="CompanyEmail" type="string" required="yes" />
		<cfargument name="noCache" type="string" required="yes" />
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					errMsg = "",
        					Data = 0} />
        <cftry>

            <cfquery name="local.qryResults" datasource="#request.dsn#">
				SELECT TOP 1 1 FROM Companies
				WHERE UPPER(Company_Email) = <cfqueryparam value="#UCase(arguments.CompanyEmail)#" cfsqltype="cf_sql_varchar" />
            </cfquery>

			<cfif local.qryResults.RecordCount>
				<cfset local.Response.Data = 1 />
			</cfif>

        <cfcatch type="any">
			<cfdump var="#cfcatch#" />
			<cfset local.Response.Success = false />
            <cfset local.Response.errMsg = cfcatch.Message />
        </cfcatch>
        </cftry>

        <cfreturn local.Response />
	</cffunction>

	<cffunction name="isExistingWebAddress" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="WebAddress" type="string" required="yes" />
		<cfargument name="noCache" type="string" required="yes" />
		<cfsetting showdebugoutput="false">
		<cfset var local = {} />
		<cfset local.Response = {
        					Success = true,
        					errMsg = "",
        					Data = 0} />
        <cftry>

            <cfquery name="local.qryResults" datasource="#request.dsn#">
				SELECT TOP 1 1 FROM Companies
				WHERE UPPER(Web_Address) = <cfqueryparam value="#UCase(arguments.WebAddress)#" cfsqltype="cf_sql_varchar" />
            </cfquery>

			<cfif local.qryResults.RecordCount>
				<cfset local.Response.Data = 1 />
			</cfif>

        <cfcatch type="any">
			<cfdump var="#cfcatch#" />
			<cfset local.Response.Success = false />
            <cfset local.Response.errMsg = cfcatch.Message />
        </cfcatch>
        </cftry>

        <cfreturn local.Response />
	</cffunction>

	<cffunction name="saveSocialMediaForm" access="public" output="false" returntype="void">
		<cfargument name="Company_ID" type="numeric" required="true" />
		<cfargument name="Form" type="struct" required="true" />
		<cfset var local = {} />

		<cfset local.socialIdList = arguments.Form.socialIdList />

		<cfquery name="qryDelete" datasource="#request.dsn#">
			DELETE Companies_Social_Media
			WHERE Company_ID = <cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>

		<cfquery name="qryResults" datasource="#request.dsn#">
			INSERT INTO Companies_Social_Media(Social_Media_ID, Company_ID, URL)
			VALUES
			<cfoutput>
					<cfset local.index = 0 />
					<cfloop list="#arguments.Form.socialIdList#" index="local.itemId">
						<cfset local.urlString = '#Evaluate("arguments.Form.URL_" & local.itemId)#' />
						<cfset local.urlString = ReplaceNoCase(local.urlString, '#Evaluate("arguments.form.SOCIAL_WEBSITE_"&local.itemId)#', "", "all") />
						<!--- <cfset local.urlString = ReplaceNoCase(local.urlString, "https://", "", "all") />
						<cfset local.urlString = ReplaceNoCase(local.urlString, "www.", "", "all") /> --->
						<cfif  local.index GT 0>,</cfif>
						(
							#local.itemId#, #arguments.Company_ID#, '#local.urlString#'
						)

						<cfset local.index = local.index + 1 />
					</cfloop>
			</cfoutput>
		</cfquery>

	</cffunction>

	<cffunction name="getSocialMedia" access="public" output="false" returntype="query" hint="Returns query of social media based on Company_ID">
		<cfquery name="qryResults" datasource="#request.dsn#">
			SELECT  Social_Media_ID, Site_Name, Logo_File, Web_Site
			FROM Social_Media
			ORDER BY Site_Name
		</cfquery>

		<cfreturn qryResults />
	</cffunction>

	<cffunction name="getSocialMediaNotInCompany" access="public" output="false" returntype="query" hint="Returns query of social media based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="true" />

		<cfquery name="qryResults" datasource="#request.dsn#">
			SELECT  Social_Media_ID, Site_Name, Logo_File, Web_Site
			FROM Social_Media
			WHERE Social_Media_ID Not In (SELECT Social_Media_ID FROM Companies_Social_Media WHERE Company_ID = <cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer" />)
			ORDER BY Site_Name
		</cfquery>

		<cfreturn qryResults />
	</cffunction>

	<cffunction name="getCompanySocialMedia" access="public" output="false" returntype="query" hint="Returns query of social media based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="true" />

		<cfquery name="qryResults" datasource="#request.dsn#">
			SELECT  Companies_Social_Media.Social_Media_ID, Companies_Social_Media.URL, Social_Media.Site_Name, Social_Media.Logo_File, Social_Media.Web_Site
			FROM Companies_Social_Media INNER JOIN
			                         Social_Media ON Companies_Social_Media.Social_Media_ID = Social_Media.Social_Media_ID
			WHERE Companies_Social_Media.Company_ID = <cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>

		<cfreturn qryResults />
	</cffunction>

	<cffunction name="getCompanySocialMediaPlus" access="public" output="false" returntype="query" hint="Returns query of social media based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="true" />
		<cfquery name="qryResults" datasource="#request.dsn#">
			SELECT Social_Media.Site_Name, Social_Media.Logo_File, Social_Media.Web_Site, Social_Media.Social_Media_ID,
			URL = (	SELECT ISNULL(url,'')
					FROM Companies_Social_Media
					WHERE Companies_Social_Media.Social_Media_ID = Social_Media.Social_Media_ID AND
							Companies_Social_Media.Company_ID = <cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer" />)
			FROM Social_Media
		</cfquery>

		<cfreturn qryResults />
	</cffunction>

	<cffunction name="hasCompanySocialMedia" access="public" output="false" returntype="boolean" hint="Returns boolean if social media based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="true" />

		<cfset var local = {} />

		<cfquery name="qryResults" datasource="#request.dsn#">

			SELECT 1
					FROM Companies_Social_Media
					WHERE 	url is not null AND url <> '' AND
							Companies_Social_Media.Company_ID = <cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer" />

		</cfquery>
		<cfif qryResults.RecordCount>
			<cfset local.bolExists = true />
		<cfelse>
			<cfset local.bolExists = false />
		</cfif>
		<cfreturn local.bolExists />
	</cffunction>

	<cffunction name="getCompany" access="public" output="false" returntype="query" hint="Returns query of Company based on Company_ID">
		<cfargument name="Company_ID" type="numeric" required="false" default="0">
		<cfargument name="Web_Address" type="string" required="false" default="">
		<cfargument name="appointment_code" type="string" required="false" default="">
		<cfdump var="#arguments#">
		<cfquery name="getCompany" datasource="#request.dsn#">
			SELECT
			   Company_ID
		      ,Web_Address
		      ,Company_Name
		      ,Company_Address
		      ,Company_Address2
		      ,Company_City
		      ,Company_State
		      ,Company_Postal
		      ,Company_Phone
		      ,Company_Email
		      ,Company_Fax
		      ,Company_Description
		      ,Professional_Admin_ID
		      <!---,Credit_Card_No
		      ,Name_On_Card--->
		      ,Billing_Address
		      ,Billing_Address2
		      ,Billing_City
		      ,Billing_State
		      ,Billing_Postal
		      ,Credit_Card_ExpMonth
		      ,Credit_Card_ExpYear
		      ,CVV_Code
		      ,Hosted
			  ,Template_ID
			  ,Promo_Code
			  ,Trial_Expiration
		  FROM Companies
		  WHERE 1=1
		 <!---  <cfif arguments.Company_ID gt 0> --->
		 <!---  </cfif> --->
		  <cfif len(trim(arguments.Web_Address)) gt 0>
		  	AND Web_Address='#arguments.Web_Address#'
		  <cfelseif arguments.Company_ID gt 0>
		 	AND Company_ID=#arguments.Company_ID#
		 <cfelseif len(arguments.appointment_code)>
		 	AND appointment_code='#arguments.appointment_code#'
		  </cfif>
		
		</cfquery>
		<cfdump var="#len(trim(arguments.Web_Address))#">
		<cfdump var="#getCompany#">
		<cfreturn getCompany>
	</cffunction>


	<cffunction name="InsertCompany" access="remote" output="false" returntype="numeric">
		<cfargument name="Web_Address" type="string" required="false" default="">
		<cfset Trial_Expiration = DateFormat(DateAdd("m",1,Now()),'dd-mmm-yyyy')>
		<cfset local.appointment_code = createUUID() >
		<cftransaction isolation="READ_COMMITTED">
			<cfquery name="InsertCompany" datasource="#request.dsn#">
				INSERT INTO Companies
				(Web_Address,Trial_Expiration,appointment_code) VALUES ('#arguments.Web_Address#','#Trial_Expiration#','#local.appointment_code#')
			</cfquery>
			<cfquery name="getCompany" datasource="#request.dsn#">
				SELECT Max(Company_ID) as New_Company_ID FROM Companies
				WHERE Web_Address='#arguments.Web_Address#'
			</cfquery>
			<!--- Configure company as a trial account ---> 
			<cfquery name="getTrial" datasource="#request.dsn#">
				INSERT INTO Company_Prices
				(Company_ID, Company_Service_Plan_ID, Price)
					VALUES
				(#getCompany.New_Company_ID#,2,49.99)
			</cfquery>
		</cftransaction>
		<!--- <cffunction name="InsertLocation" access="public" output="false" returntype="numeric" hint="">
		<cftransaction isolation="READ_COMMITTED">
			<cfquery name="InsertLocation" datasource="#request.dsn#">
				INSERT INTO Locations
				(Location_Name) VALUES ('')
			</cfquery>
			<cfquery name="getLocation" datasource="#request.dsn#">
				SELECT Max(Location_ID) as New_Location_ID FROM Locations 
				WHERE Location_Name=''
			</cfquery>
		</cftransaction>
		<cfreturn getLocation.New_Location_ID>
	</cffunction>  --->
		<cfreturn getCompany.New_Company_ID>
	</cffunction>

	<cffunction name="UpdateCompany" access="remote" output="false" returntype="any">
		
		<cfargument name="Web_Address" type="string" required="false" default="">
		<cfargument name="Company_Name" type="string" required="false" default="">
		<cfargument name="Company_Address" type="string" required="false" default="">
		<cfargument name="Company_Address2" type="string" required="false" default="">
		<cfargument name="Company_City" type="string" required="false" default="">
		<cfargument name="Company_State" type="string" required="false" default="">
		<cfargument name="Company_Postal" type="string" required="false" default="">
		<cfargument name="Company_Phone" type="string" required="false" default="">
		<cfargument name="Company_Email" type="string" required="false" default="">
		<cfargument name="Company_Fax" type="string" required="false" default="">
		<cfargument name="company_id" type="string" required="false" default="">
		<cfargument name="Company_Description" type="string" required="false" default="">
		<cfargument name="Professional_Admin_ID" type="string" required="false" default="">
		<cfargument name="Credit_Card_No" type="string" required="false" default="">
		<cfargument name="Name_On_Card" type="string" required="false" default="">
		<cfargument name="Billing_Address" type="string" required="false" default="">
		<cfargument name="Billing_Address2" type="string" required="false" default="">
		<cfargument name="Billing_City" type="string" required="false" default="">
		<cfargument name="Billing_State" type="string" required="false" default="">
		<cfargument name="Billing_Postal" type="string" required="false" default="">
		<cfargument name="Credit_Card_ExpMonth" type="string" required="false" default="">
		<cfargument name="Credit_Card_ExpYear" type="string" required="false" default="">
		<cfargument name="CVV_Code" type="string" required="false" default="">
		<cfargument name="Hosted" type="string" required="false" default="">
		<cfargument name="Promo_Code" type="string" required="false" default="">

			<cfargument name="url_1" type="string" required="false" default="">
			<cfargument name="url_2" type="string" required="false" default="">
			<cfargument name="url_3" type="string" required="false" default="">
			<cfargument name="url_4" type="string" required="false" default="">
			<cfargument name="url_5" type="string" required="false" default="">
			<cfargument name="url_6" type="string" required="false" default="">
		<!---<cftry>--->
			<cfquery name="UpdateCompany" datasource="#request.dsn#">
				UPDATE Companies
				SET
				   <cfif structKeyExists(arguments, 'Web_Address') >
				   Web_Address='#arguments.Web_Address#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Name') >
				   ,Company_Name='#reReplace(arguments.Company_Name,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Address') >
				   ,Company_Address='#reReplace(arguments.Company_Address,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Address2') >
				  ,Company_Address2='#reReplace(arguments.Company_Address2,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_City') >
				   ,Company_City='#reReplace(arguments.Company_City,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_State') >
				   ,Company_State='#reReplace(arguments.Company_State,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Postal') >
				    ,Company_Postal='#arguments.Company_Postal#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Phone') >
				   ,Company_Phone='#arguments.Company_Phone#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Email') >
				     ,Company_Email='#arguments.Company_Email#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Fax') >
				   ,Company_Fax='#arguments.Company_Fax#'
				   </cfif>
				   <cfif structKeyExists(arguments, 'Company_Fax') >
				   ,Company_Description='#arguments.Company_Description#'
				   </cfif>
			      <cfif structKeyExists(arguments,"Professional_Admin_ID")>
			      ,Professional_Admin_ID='#arguments.Professional_Admin_ID#'
			      </cfif>
			      <cfif structKeyExists(arguments,"Promo_Code")>
			      ,Promo_Code='#arguments.Promo_Code#'
			      </cfif>
			     <!---  ,Credit_Card_No='#arguments.Credit_Card_No#'
			      ,Name_On_Card='#arguments.Name_On_Card#'
			      ,Billing_Address='#arguments.Billing_Address#'
			      ,Billing_Address2='#arguments.Billing_Address2#'
			      ,Billing_City='#arguments.Billing_City#'
			      ,Billing_State='#arguments.Billing_State#'
			      ,Billing_Postal='#arguments.Billing_Postal#'
			      ,Credit_Card_ExpMonth='#arguments.Credit_Card_ExpMonth#'
			      ,Credit_Card_ExpYear='#arguments.Credit_Card_ExpYear#'
			      ,CVV_Code='#arguments.CVV_Code#'
			      ,Hosted='#arguments.Hosted#' --->
				  WHERE Company_ID=#arguments.company_id#
			</cfquery>

			<cfloop from="1" to="6" index="i">
				<cfif structKeyExists(arguments, "url_#i#") >
					<!--- <cfdump var="#arguments["url_#i#"]#" abort="true"> --->
					<cfquery name="UpdateCompanySocialMedia" datasource="#request.dsn#" result="resultUpdateSocial">
						UPDATE Companies_Social_Media                                                                       
						SET url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments["url_#i#"]#">
						WHERE Company_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">
						AND Social_Media_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">
					</cfquery>
				</cfif>

			</cfloop>

			
			



			<!--- <cfset args_lst = StructKeyList(arguments, ",")>
			<cfif listContainsNoCase(args_lst, "url_")>

			</cfif> --->

			<cfreturn true />
		<!---<cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
		</cftry>--->

	</cffunction>
<!--- Insert free demo --->
	<cffunction name="setPersonalDemo" access="public" output="false" returntype="numeric" result="demo_id">
		<cfargument name="First_name" type="string" required="false" />
		<cfargument name="Last_name" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Mobile" type="string" required="false" />
		<cfmail from="#arguments.Email#" to="salonworks@salonworks.com" bcc="ciredrofdarb@gmail.com" subject="Free Demo Request" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
				<h2>Request for personolized demo</h2>
				<div>
					Name: #arguments.First_name#  #arguments.Last_name# <br>
					Email: #arguments.Email#<br>
					Mobile: #arguments.Mobile#<br>
				</div>
		</cfmail>
		<cfquery name="setDemo" datasource="#request.dsn#">
			INSERT INTO personolized_demo
			(	FirstName
				,LastName
				,mobile
				,Email
				,Created_time
				,updated_time)
			VALUES
			(<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.First_name#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Last_name#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Email#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Mobile#">
			,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
			)
		</cfquery>
		<cfreturn 1 />
	</cffunction>
	<cffunction name="updateTrialPlan" access="remote" output="false" returntype="any" returnformat="plain">
		<cfargument name="company_id" type="any">
		<cfquery name="getTrialExpiration" datasource="#request.dsn#">
		   SELECT top 1
		   Trial_Expiration,subscriptionId
		   FROM
		   Companies
		   WHERE
		   Company_ID=
		   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>	
		<cfif DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0 AND (not getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)) and not (len(getTrialExpiration.subscriptionId) gt 1)>
		   <cfquery name="updatePlan" datasource="#request.dsn#">
		      UPDATE 
		         Company_Prices 
		      SET
		         Company_Service_Plan_ID = 1
		      WHERE
		         Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		   </cfquery>
  		<cfreturn 1>
  		<cfelse>
  		<cfreturn 0>
		</cfif> 
	</cffunction>

	<cffunction name="updateCompanyTemplate" access="remote" output="false" returntype="any">
		<cfargument name="Template_ID" type="string" required="false" />
		<cfargument name="Company_ID" type="string" required="false" />
		<cfquery name="updCopmpanyTemplateId" datasource="#request.dsn#">
			UPDATE Companies
			SET Template_ID=<cfqueryparam value="#arguments.Template_ID#" cfsqltype="cf_sql_integer">
			WHERE Company_ID=<cfqueryparam value="#arguments.Company_ID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
	</cffunction>
</cfcomponent>