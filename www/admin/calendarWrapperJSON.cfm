<cfprocessingdirective suppresswhitespace="yes">
<cfif Not (isDefined("URL.ID") AND isDefined("URL.StartDate") AND isDefined("URL.DaySpan"))>
	<cfabort  />
</cfif>
<cfsetting showdebugoutput="no">
<cfset variables.Calendar = createObject("component","appointmentsCalendarBean") />

<cfset variables.qryResults = variables.Calendar.getCalendarAvailabilityJSONString(URL.ID, URL.StartDate, URL.DaySpan, URL.noCache) /> 


<cfcontent type="application/x-javascript">
<cfoutput>#Trim(variables.qryResults)#</cfoutput> 
</cfprocessingdirective>