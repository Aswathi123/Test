<cfparam name="variables.title_no" default=1>
<!--- This is a temporary solution to determine whether to show online booking or not --->
<cfquery name="getServices" datasource="#request.dsn#">
<!---SELECT 	DISTINCT  
			Services.Service_ID, Services.Service_Name, Services.Price, Services.Service_Time
FROM		Services  
INNER JOIN	Professionals_Services ON Services.Service_ID = Professionals_Services.Service_ID
INNER JOIN 	Professionals ON Professionals_Services.Professional_ID = Professionals.Professional_ID
WHERE 		Professionals.Location_ID = #variables.Location_ID#--->
	SELECT 	DISTINCT  
				Predefined_Services.Service_ID, Predefined_Services.Service_Name, Professionals_Services.Price, Professionals_Services.Service_Time
	FROM		Predefined_Services  
	INNER JOIN	Professionals_Services ON Predefined_Services.Service_ID = Professionals_Services.Service_ID
	INNER JOIN 	Professionals ON Professionals_Services.Professional_ID = Professionals.Professional_ID
	WHERE 		Professionals.Location_ID = #variables.Location_ID#
</cfquery>
<cfset session.Professional_ID=qProfessional.Professional_ID>
<cfquery name="getPlan" datasource="#request.dsn#">
	SELECT 
		Company_Service_Plan_ID
	FROM
		Company_Prices
	WHERE
		Company_ID=<cfqueryparam value="#variables.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>
<!--- <cfdump var="#variables.Company_ID#"><cfabort> --->
<cfquery name="getTrialExpiration" datasource="#request.dsn#">
   SELECT 
   Trial_Expiration
   FROM
   Companies
   WHERE
   Company_ID=
   <cfqueryparam value="#variables.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfparam name="variables.user_name" type="string" default="">
<cfparam name="variables.user_email" type="string" default="">
<cfparam name="variables.customerid" type="numeric" default=0>
<cfset variables.objCFC = createObject("component","admin.appointmentsCalendarBean") />

<cfif structKeyExists(session,"CUSTOMERID")>
	<cfset qCustomer = variables.objCFC.getCustomerProfile(CustomerID = session.CUSTOMERID)>
	<cfif qCustomer.recordcount>
		<cfset variables.customerid = session.CUSTOMERID>
		<cfset variables.user_name = qCustomer.First_Name & " " & qCustomer.last_name>
		<cfset variables.user_email = qCustomer.Email_Address>
	</cfif>
</cfif>