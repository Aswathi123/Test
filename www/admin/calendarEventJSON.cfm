<cfprocessingdirective suppresswhitespace="yes">

<cfif Not (isDefined("URL.ID") AND isDefined("URL.StartDate") AND isDefined("URL.EndDate") AND isDefined("URL.DaySpan"))>
	<cfabort  />
</cfif>
<cfsetting showdebugoutput="no">
<cfset variables.Calendar = createObject("component","appointmentsCalendarBean") />

<cfset variables.qryResults = variables.Calendar.getCalendarAvailabilityEventJSONS(Professional_ID = URL.ID, CalendarStartDate = URL.StartDate, CalendarEndDate = URL.EndDate, CalendarDaysSpan = URL.DaySpan, noCache = URL.noCache) /> 


<cfcontent type="application/x-javascript">
<cfoutput>#Trim(variables.qryResults)#</cfoutput> 
</cfprocessingdirective>