<cfcomponent displayname="Location" hint="">
	
	<cffunction name="getInquiries" access="public" output="false" returntype="query" hint="Returns query of Inquiries based on Location_ID">
		<cfargument name="Location_ID" type="numeric" required="true" default="0">

		<cfquery name="qryInquiries" datasource="#request.dsn#">
			SELECT *
			FROM Inquiries
			WHERE Location_ID = <cfqueryparam value="#Location_ID#" cfsqltype="cf_sql_integer" />  
			order by Inquiry_ID desc
		</cfquery>
		<cfreturn qryInquiries>
	</cffunction>
	
	<cffunction name="deleteInquiries" access="remote" output="false" returntype="boolean" hint="Returns query of Inquiries based on Location_ID">
		<cfargument name="Inquiry_ID" type="numeric" required="false">
		<cfargument name="Inquiry_List" type="string" required="false">

		<cfquery name="qryInquiries" datasource="#request.dsn#" result="queryResult">
			DELETE FROM Inquiries
			WHERE 
			<cfif structKeyExists(arguments,"Inquiry_ID")>
				Inquiry_ID = <cfqueryparam value="#arguments.Inquiry_ID#" cfsqltype="cf_sql_integer" /> 
			</cfif>
			<cfif structKeyExists(arguments,"Inquiry_List") and len(trim(arguments.Inquiry_List))>
				Inquiry_ID IN(<cfqueryparam value="#arguments.Inquiry_List#" list="yes" cfsqltype="cf_sql_integer" />) 
			</cfif>
		</cfquery>
		<cfif queryResult.recordcount>
			<cfreturn 1>
		</cfif>
		<cfreturn 0>
	</cffunction>
	
	<cffunction name="getLocation" access="public" output="false" returntype="query" hint="Returns query of Location based on Location_ID">
		<cfargument name="Location_ID" type="numeric" required="false" default="0">
		<cfargument name="Company_ID" type="numeric" required="false" default="0">
		<cfquery name="getLocation" datasource="#request.dsn#">
			SELECT 
			   Location_ID
		      ,Company_ID
		      ,Location_Name
		      ,Contact_Name
		      ,Contact_Phone
		      ,Location_Address
		      ,Location_Address2
		      ,Location_City
		      ,Location_State
		      ,Location_Postal
		      ,Location_Phone
		      ,Location_Fax
		      ,Description
		      ,Directions
		      ,Time_Zone_ID
		      ,Sunday_Hours
		      ,Monday_Hours
		      ,Tuesday_Hours
		      ,Wednesday_Hours
		      ,Thursday_Hours
		      ,Friday_Hours
		      ,Saturday_Hours
		      ,Payment_Methods_List
		      ,Services_List
		      ,Parking_Fees
		      ,Cancellation_Policy
		      ,Languages
		      ,Sunday_Break
		      ,Monday_Break
		      ,Tuesday_Break
		      ,Wednesday_Break
		      ,Thursday_Break
		      ,Friday_Break
		      ,Saturday_Break
		  FROM Locations
		  WHERE 1=1
		  <cfif arguments.Location_ID gt 0>
		  	AND Location_ID=#arguments.Location_ID#
		  </cfif> 
		  	AND Company_ID=#arguments.Company_ID# 
		</cfquery>
		<cfreturn getLocation>
	</cffunction>
	<cffunction name="InsertLocation" access="public" output="false" returntype="numeric" hint="">
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
		<cfargument name="Payment_Methods_List" type="string" required="true" default="">
		<cfargument name="Services_List" type="string" required="true" default="">
		<cfargument name="Parking_Fees" type="string" required="false" default="">
		<cfargument name="Cancellation_Policy" type="string" required="false" default="">
		<cfargument name="Languages" type="string" required="false" default="">
		<cfargument name="Directions" type="string" required="false" default="">
		<!--- <cftry> --->
			<cfloop from="1" to="7" index="dayindex">
				<cfif structKeyExists(arguments,"Begin_#dayindex#") AND structKeyExists(arguments,"End_#dayindex#")>
					<cfif arguments['Begin_#dayindex#'] neq 'Closed' AND arguments['End_#dayindex#'] neq 'Closed'>
						<cfset arguments['#DayOfWeekAsString(dayindex)#_Hours'] = "#TimeFormat(arguments['Begin_#dayindex#'],'h:mm tt')# &mdash; #TimeFormat(arguments['End_#dayindex#'],'h:mm tt')#">
					<cfelse>
						<cfset arguments['#DayOfWeekAsString(dayindex)#_Hours'] = "Closed">
					</cfif>
				</cfif>
			</cfloop>

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
			  	WHERE Location_ID=#arguments.Location_ID#
			</cfquery>
			<cfreturn true />
		<!--- <cfcatch>
			<cfreturn cfcatch.message />
		</cfcatch>
		</cftry> --->
		
	</cffunction>
</cfcomponent>