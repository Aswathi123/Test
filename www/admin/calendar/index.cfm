<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<cfset variables.CALANDER_DAYS_SPAN = 35  />
<cfset variables.StartWeekDate = "04/29/2012" />
<cfset variables.Calendar = createObject("component","calendar") />
<cfset variables.Professional_ID = 1  />
<cfset variables.Recurrence_Type_ID = 3  />



	<!--- Recurrence_Type_ID = 5	Monthly Week
		Monthly:  The [Recurrence_Ordinal_Interval_ID: 1st,2nd,3rd,4th,last] [Recurrence_Weekday_Interval_ID: day,weekday,weekend,Su-Sa] 
		of every [Recur_Count_Interval] month(s) --->
        
<cfoutput>
			WeekdayTypes<br />
			1	Day<br />
			2	Weekday<br />
			3	Weekend Day<br />
			4	Sunday<br />
			5	Monday<br />
			6	Tuesday<br />
			7	Wednesday<br />
			8	Thursday<br />
			9	Friday<br />
			10	Saturday <br />

<!--- 		<cfloop from="1" to="5" index="loopOrd">
        	<cfloop from="1" to="10" index="loopWeekType">
            getXOfMonth(#DateFormat(StartWeekDate,"mm/dd/yyyy")#, #loopOrd#, #loopWeekType#) = #DateFormat(variables.Calendar.getXOfMonth(variables.StartWeekDate, loopOrd, loopWeekType),"mm/dd/yyyy")#<br />
            </cfloop>
        	<br />
        </cfloop> --->

 </cfoutput>

<cfquery name="qryFirst" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Week_Days
                    
            FROM Availability
            WHERE 	Recurrence_Type_ID = #variables.Recurrence_Type_ID# AND 
            		Professional_ID = #Professional_ID# AND
                   (
					(DATEDIFF(day, '#variables.StartWeekDate#', Availability_Start_Date) <= 0) OR
                    (	DATEDIFF(day, '#variables.StartWeekDate#', Availability_Start_Date) >= 0 AND 
                    	DATEDIFF(day, '#variables.StartWeekDate#', Availability_Start_Date) < #variables.CALANDER_DAYS_SPAN#)
                   )
			ORDER BY Availability_Start_Date, Start_Time 
</cfquery>
<cfdump var="#qryFirst#" />
<!--- 
<cfset variables.myArray = variables.Calendar.getCalendarRangeDates(StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#variables.myArray#" /> --->

<!--- <cfset variables.qryResults = variables.Calendar.getRecurrenceTypeDailyWeekdays(Professional_ID, StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#variables.qryResults#" /> --->

<!--- <cfset variables.qryResults = variables.Calendar.getRecurrenceTypeMonthlyDay(Professional_ID, StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#variables.qryResults#" /> ---> 

<!--- <cfset local.qryResults = variables.Calendar.getRecurrenceTypeMonthlyWeek(variables.Professional_ID, variables.StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#local.qryResults#" /> --->



<!--- <cfset local.qryResults = variables.Calendar.getRecurrenceTypeYearlyDate(variables.Professional_ID, variables.StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#local.qryResults#" />  --->

<!--- <cfset local.qryResults = variables.Calendar.getRecurrenceTypeYearlyMonth(variables.Professional_ID, variables.StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#local.qryResults#" />   --->

<cfset local.qryResults = variables.Calendar.getCalendarAvailability(variables.Professional_ID, variables.StartWeekDate, variables.CALANDER_DAYS_SPAN) />
<cfdump var="#local.qryResults#" />  

</body>
</html>
