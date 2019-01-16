<cfcomponent displayname="register" hint="">
	<cffunction name="UpdateCompany" access="public" output="false" returntype="any">
		
		<!--- <cfargument name="Web_Address" type="string" required="false" default=""> --->
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

			<!--- <cfargument name="url_1" type="string" required="false" default="">
			<cfargument name="url_2" type="string" required="false" default="">
			<cfargument name="url_3" type="string" required="false" default="">
			<cfargument name="url_4" type="string" required="false" default="">
			<cfargument name="url_5" type="string" required="false" default="">
			<cfargument name="url_6" type="string" required="false" default=""> --->
		<!---<cftry>--->
			<cfquery name="UpdateCompany" datasource="#request.dsn#">
				UPDATE Companies
				SET
				  <cfif structKeyExists(arguments, 'Web_Address') >
				   Web_Address='#arguments.Web_Address#',
				   </cfif> 
				   <cfif structKeyExists(arguments, 'Company_Name') >
				   Company_Name='#reReplace(arguments.Company_Name,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
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
				  WHERE Company_ID='#arguments.company_id#'
			</cfquery>
		</cffunction>

		<cffunction name="UpdateLocation" access="remote" output="false" returntype="any">
		<!--- Make a cfargument for each column name --->
        <cfargument name="Location_ID" type="string" required="false">
		<cfargument name="Company_ID" type="string" required="false">
		<cfargument name="Contact_Name" type="string" required="false" default="">
		<cfargument name="Contact_Phone" type="string" required="false" default="">
        <cfargument name="Location_Name" type="string" required="false" default="">
		<cfargument name="Location_Address" type="string" required="false" default="">
		<cfargument name="Location_Address2" type="string" required="false" default="">
		<cfargument name="Location_City" type="string" required="false" default="">
		<cfargument name="Location_State" type="string" required="false" default="">
		<cfargument name="Location_Postal" type="string" required="false" default="">
		<cfargument name="Location_Phone" type="string" required="false" default="">
		<cfargument name="Location_Fax" type="string" required="false" default="">
		<cfargument name="Description" type="string" required="false" default="">
		<cfargument name="Time_Zone_ID" type="string" required="false" default="">
		<cfargument name="Sunday_Hours" type="string" required="false" default="">
		<cfargument name="Monday_Hours" type="string" required="false" default="">
		<cfargument name="Tuesday_Hours" type="string" required="false" default="">
		<cfargument name="Wednesday_Hours" type="string" required="false" default="">
		<cfargument name="Thursday_Hours" type="string" required="false" default="">
		<cfargument name="Friday_Hours" type="string" required="false" default="">
		<cfargument name="Saturday_Hours" type="string" required="false" default="">
		<cfargument name="Sunday_Break" type="string" required="false" default="">
		<cfargument name="Monday_Break" type="string" required="false" default="">
		<cfargument name="Tuesday_Break" type="string" required="false" default="">
		<cfargument name="Wednesday_Break" type="string" required="false" default="">
		<cfargument name="Thursday_Break" type="string" required="false" default="">
		<cfargument name="Friday_Break" type="string" required="false" default="">
		<cfargument name="Saturday_Break" type="string" required="false" default="">
		<cfargument name="Payment_Methods_List" type="string" required="true" default="">
		<cfargument name="Services_List" type="string" required="true" default="">
		<cfargument name="Parking_Fees" type="string" required="false" default="">
		<cfargument name="Cancellation_Policy" type="string" required="false" default="">
		<cfargument name="Languages" type="string" required="false" default="">
		<cfargument name="Directions" type="string" required="false" default="">
		<!--- <cftry> --->
			<cfquery name="UpdateLocation" datasource="#request.dsn#">
				UPDATE Locations
					SET 
				   		Company_ID='#arguments.Company_ID#'
				   		,Contact_Name='#arguments.Contact_Name#'
				   		,Contact_Phone='#arguments.Contact_Phone#'
	                    ,Location_Name='#arguments.Location_Name#'
				   		,Location_Address='#reReplace(arguments.Location_Address,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   		,Location_Address2='#reReplace(arguments.Location_Address2,"(^[a-z]|\s+[a-z])","\U\1","ALL")#'
				   		,Location_City='#arguments.Location_City#'
				   		,Location_State='#arguments.Location_State#'
				   		,Location_Postal='#arguments.Location_Postal#'
				   		,Location_Phone='#arguments.Location_Phone#'
				   		,Location_Fax='#arguments.Location_Fax#'
				   		,Description='#arguments.Description#'
				   		,Directions='#arguments.Directions#'
				   		,Time_Zone_ID='#arguments.Time_Zone_ID#'
				   		,Sunday_Hours='#arguments.Sunday_Hours#'
				   		,Monday_Hours='#arguments.Monday_Hours#'
				   		,Tuesday_Hours='#arguments.Tuesday_Hours#'
				   		,Wednesday_Hours='#arguments.Wednesday_Hours#'
				   		,Thursday_Hours='#arguments.Thursday_Hours#'
				   		,Friday_Hours='#arguments.Friday_Hours#'
				   		,Saturday_Hours='#arguments.Saturday_Hours#'
				   		,Payment_Methods_List='#arguments.Payment_Methods_List#'
				   		,Services_List='#arguments.Services_List#' 
				   		,Parking_Fees='#arguments.Parking_Fees#'
				   		,Cancellation_Policy='#arguments.Cancellation_Policy#'
				   		,Languages='#arguments.Languages#'
				   		,Sunday_Break='#arguments.Sunday_Break#'
				   		,Monday_Break='#arguments.Monday_Break#'
				   		,Tuesday_Break='#arguments.Tuesday_Break#'
				   		,Wednesday_Break='#arguments.Wednesday_Break#'
				   		,Thursday_Break='#arguments.Thursday_Break#'
				   		,Friday_Break='#arguments.Friday_Break#'
				   		,Saturday_Break='#arguments.Saturday_Break#'
			  	WHERE Location_ID=#arguments.Location_ID#
			</cfquery>
			<cfreturn true />
		<!--- <cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
		</cftry> --->
		
	</cffunction>
	<cffunction name="getServiceTypes" access="remote" returntype="string" returnformat="plain">
		<cfargument name="Profession_ID" default="">
		
		<cfquery name="getServiceTypes" datasource="#request.dsn#">
			SELECT Service_Type_ID,Service_Type_Name 
			FROM Service_Types
			WHERE Profession_ID=#arguments.Profession_ID#
		</cfquery>
		<cfreturn serializeJSON(getServiceTypes)>
	</cffunction>
	<cffunction name="getServices" access="remote" returntype="string" returnformat="plain">
		<cfargument name="Service_Type_ID" default="">
		
		<cfquery name="getServices" datasource="#request.dsn#">
			SELECT Service_ID,Service_Name 
			FROM Services
			WHERE Service_Type_ID=#arguments.Service_Type_ID#
		</cfquery>
		<cfreturn serializeJSON(getServices)>
	</cffunction>

	<cffunction name="getServicesDetail" access="remote" returntype="string" returnformat="plain">
		<cfargument name="Service_ID" default="">
		
		<cfquery name="getServicesDetail" datasource="#request.dsn#">
			SELECT Service_ID,Service_Name 
			FROM Services
			WHERE Service_ID=#arguments.Service_ID#
		</cfquery>
		<cfreturn serializeJSON(getServicesDetail)>
	</cffunction>
	
	


</cfcomponent>