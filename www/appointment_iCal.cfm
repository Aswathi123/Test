<cfsetting enablecfoutputonly="true">
<cfsetting showdebugoutput="false">
<cfif structKeyExists(url, 'apptid') AND Len(url.apptid)>

	<cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />
	<cfset variables.qryResults = variables.objCFC.getBookAppointment(url.apptid) />

	<cfif variables.qryResults.RecordCount>
		<cfinclude template="iCalUS.cfm">
		<cfset variables.location = variables.qryResults.Location_Address  />
		<cfif Len(variables.qryResults.Location_Address2)><cfset variables.location = variables.location & " " & variables.qryResults.Location_Address2  /></cfif>
		<cfset variables.location = variables.location & " " & variables.qryResults.Location_City & ", " & variables.qryResults.Location_State & "   " & variables.qryResults.Location_Postal  />
		
		<cfset eventStr = StructNew() />
		<cfset eventStr.organizerName = variables.qryResults.First_Name & " " & variables.qryResults.Last_Name />
		<cfset eventStr.organizerEmail = variables.qryResults.Email_Address />
		<cfset eventStr.startTime = variables.qryResults.Start_Time /> <!--- this is Eastern time  --->
		<cfset eventStr.endTime = variables.qryResults.End_Time />
		<cfset eventStr.subject = "Appointment - " & variables.qryResults.Service_Name />
		<cfset eventStr.location = variables.location />
		<cfset eventStr.description = "Appointment - " & variables.qryResults.Service_Name />
		<cfset eventStr.timeZoneOffset = variables.qryResults.Offset/>
		<cfset eventStr.timeZoneDesc = variables.qryResults.Timezone_Location/>
			
		<cfcontent type="text/calendar" reset="Yes">
		<cfheader name="Content-Disposition" value="inline; filename=newAppointment.ics"><cfoutput>#iCalUS(eventStr)#</cfoutput></cfif>
</cfif>