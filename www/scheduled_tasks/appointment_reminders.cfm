
<cfif not ListContains('99.103.70.43,107.194.73.65,75.103.109.211,220.227.196.145,13.58.245.95,127.0.0.1
',cgi.REMOTE_ADDR)><cfabort></cfif>
<cfset dateh = DateAdd('h',24,Now()) >
<cfset date = DateAdd('n',59,dateh) >
<cfquery name="getAppointments" datasource="#request.dsn#">
	-- SELECT 
	-- 	Appointments.Appointment_ID    
	-- 	,Professionals.First_Name as Professional_First
	-- 	,Professionals.Last_Name as Professional_Last
	-- 	,Appointments.Start_Time 
	-- 	,Services.Service_Name	
	-- 	,Companies.Web_Address
	-- 	,Companies.Company_Name 
	-- 	,Locations.Location_Name
	-- 	,Locations.Location_Address
	-- 	,Locations.Location_Address2
	-- 	,Locations.Location_City
	-- 	,Locations.Location_State
	-- 	,Locations.Location_Postal
	-- 	,Locations.Location_Phone
	-- 	,Locations.Directions
	-- 	,Locations.Time_Zone_ID
	-- 	,Locations.Payment_Methods_List
	-- 	,Locations.Cancellation_Policy
	-- 	,Locations.Parking_Fees
	-- 	,Services.Price
	-- 	,Services.Service_Description
	-- 	,Services.Service_Time
	-- 	,Customers.First_Name AS Customer_First
	-- 	,Customers.Last_Name AS Customer_Last
	-- 	,Customers.Mobile_Phone AS Customer_Mobile
	-- 	,Customers.Email_Address AS Customer_Email
	-- FROM         
	-- 	Appointments INNER JOIN
	--     Professionals ON Appointments.Professional_ID = Professionals.Professional_ID INNER JOIN
	--     Services ON Appointments.Service_ID = Services.Service_ID INNER JOIN
	--     Customers ON Appointments.Customer_ID = Customers.Customer_ID INNER JOIN
	--     Locations ON Professionals.Location_ID = Locations.Location_ID INNER JOIN
	--     Companies ON Locations.Company_ID = Companies.Company_ID
	-- WHERE
	SELECT 
		Appointments.Appointment_ID    
		,Professionals.First_Name as Professional_First
		,Professionals.Last_Name as Professional_Last
		,Appointments.Start_Time 
		,Predefined_Services.Service_Name	
		,Companies.Web_Address
		,Companies.Company_Name 
		,Locations.Location_Name
		,Locations.Location_Address
		,Locations.Location_Address2
		,Locations.Location_City
		,Locations.Location_State
		,Locations.Location_Postal
		,Locations.Location_Phone
		,Locations.Directions
		,Locations.Time_Zone_ID
		,Locations.Payment_Methods_List
		,Locations.Cancellation_Policy
		,Locations.Parking_Fees
		,Professionals_Services.Price
		-- ,Predefined_Services.Service_Description
		,Professionals_Services.Service_Time
		,Customers.First_Name AS Customer_First
		,Customers.Last_Name AS Customer_Last
		,Customers.Mobile_Phone AS Customer_Mobile
		,Customers.Email_Address AS Customer_Email
	FROM         
		Appointments INNER JOIN
	    Professionals ON Appointments.Professional_ID = Professionals.Professional_ID INNER JOIN
	    Predefined_Services ON Appointments.Service_ID =  Predefined_Services.Service_ID INNER JOIN
	    Customers ON Appointments.Customer_ID = Customers.Customer_ID INNER JOIN
	    Locations ON Professionals.Location_ID = Locations.Location_ID INNER JOIN
	    Companies ON Locations.Company_ID = Companies.Company_ID INNER JOIN
	    Professionals_Services ON  Predefined_Services.Service_ID = Professionals_Services.Service_ID
	WHERE
		<!--- Removed condition so it will catch any alerts that may get lost if script fails to run at any time. --->
		<!--- Start_Time >='#DateFormat(DateAdd('h',26,Now()),'dd-mmm-yyyy')# #TimeFormat(DateAdd('h',26,Now()),'HH:mm')#'
	AND --->
		  Start_Time BETWEEN '#DateFormat(DateAdd('h',25,Now()),'dd-mmm-yyyy')# #TimeFormat(DateAdd('h',24,Now()),'HH:mm')#'
		 AND '#DateFormat(DateAdd('h',25,Now()),'dd-mmm-yyyy')# #TimeFormat(date,'HH:mm')#'
	AND 
		Start_Time > '#DateFormat(Now(),'dd-mmm-yyyy')# #TimeFormat(Now(),'HH:mm')#'
		
		 <!--- Prevents duplicate alerts within 24 hours --->
	AND Appointments.Appointment_ID NOT IN
		(SELECT Appointment_ID FROM Appointment_Alerts WHERE Alert_Date_Time > '#DateFormat(DateAdd('h',-24,Now()),'dd-mmm-yyyy')# #TimeFormat(DateAdd('h',-24,Now()),'HH:mm')#')
</cfquery>


<cfoutput query="getAppointments">
<cfif Len(getAppointments.Customer_Email)>
	<!---#getAppointments.Customer_Email#--->
	<cfmail from="salonworks@salonworks.com" to="#getAppointments.Customer_Email#" bcc="ciredrofdarb@gmail.com" subject="Reminder of Your Appointment with #getAppointments.Professional_First# #getAppointments.Professional_Last#" server="smtp-relay.sendinblue.com" port="587" type="HTML" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
#getAppointments.Customer_First#, 
Your #getAppointments.Service_Name# appointment is scheduled for #DateFormat(getAppointments.Start_Time,'dddd, mmm dd, yyyy')# at #TimeFormat(getAppointments.Start_Time,'hh:mm:tt')# CT with #getAppointments.Professional_First# #getAppointments.Professional_Last#

If you can not make this appointment, please call immediately to reschedule.

#getAppointments.Location_Phone#


#getAppointments.Cancellation_Policy#

See you soon.  We look forward to serving you!
	</cfmail>
</cfif>
<cfdump var="#getAppointments#">
<cfset variables.Customer_Mobile = Replace(getAppointments.Customer_Mobile,'-','','all')>
<cfset variables.TextMessage="This is a reminder of your upcoming appointment with #getAppointments.Professional_First# #getAppointments.Professional_Last#, on #DateFormat(getAppointments.Start_Time,'dddd, mmm dd, yyyy')# at #TimeFormat(getAppointments.Start_Time,'hh:mm')#">
<cfif Len(variables.Customer_Mobile)>
	<cfhttp 
	url="http://api.clickatell.com/http/sendmsg?user=salonworks2&password=AGHdFPDYcHYRIM&api_id=3455257&to=1#variables.Customer_Mobile#,15124974494&text=#URLEncodedFormat(variables.TextMessage)#&from=15128616364&mo=1" 
	method="get">
	</cfhttp>

</cfif>
<cfif Len(getAppointments.Customer_Email) OR Len(variables.Customer_Mobile)>
	<cfquery name="insertAppointmentAlert" datasource="#request.dsn#">
		INSERT
		INTO 
			Appointment_Alerts
			(Appointment_ID
			<cfif Len(variables.Customer_Mobile)>,Confirmation_ID</cfif>
			)
		VALUES
			(#getAppointments.Appointment_ID#
			<cfif Len(variables.Customer_Mobile)>,'#Replace(cfhttp.filecontent,'ID: ','')#'</cfif>
			)
	</cfquery>
</cfif>
</cfoutput>




