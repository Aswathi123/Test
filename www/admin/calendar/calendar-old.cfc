<cfcomponent displayname="calendar" hint="calendar" output="false">
	<cfset this.CALANDER_DAYS_SPAN = 7  />
    
	<cfset this.RECURRENCE_TYPE_NONE = 0  />
    <cfset this.RECURRENCE_TYPE_DAILY_DAYS = 1  />
    <cfset this.RECURRENCE_TYPE_DAILY_WEEKDAYS = 2  />
    <cfset this.RECURRENCE_TYPE_WEEKLY = 3  />
    <cfset this.RECURRENCE_TYPE_MONTHLY_DATE = 4  />
    <cfset this.RECURRENCE_TYPE_MONTHLY_WEEK = 5  />
    <cfset this.RECURRENCE_TYPE_YEARLY_DATE = 6  />
    <cfset this.RECURRENCE_TYPE_YEARLY_MONTH = 7  />
    
    <cfset this.RECURRENCE_RANGE_TYPE_NO_END_DATE = 1  />
    <cfset this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES = 2  />
    <cfset this.RECURRENCE_RANGE_TYPE_END_BY_DATE = 3  />

    <cfset this.RECURRENCE_ORDINAL_TYPE_FIRST = 1  />
    <cfset this.RECURRENCE_ORDINAL_TYPE_SECOND = 2  />
    <cfset this.RECURRENCE_ORDINAL_TYPE_THIRD = 3  />
    <cfset this.RECURRENCE_ORDINAL_TYPE_FOURTH = 4  />
    <cfset this.RECURRENCE_ORDINAL_TYPE_LAST = 5  />

    <cfset this.WEEKDAY_SUNDAY = 1  />
    <cfset this.WEEKDAY_MONDAY = 2  />
    <cfset this.WEEKDAY_TUESDAY = 3  />
    <cfset this.WEEKDAY_WEDNESDAY = 4  />
    <cfset this.WEEKDAY_THURSDAY = 5  />
    <cfset this.WEEKDAY_FRIDAY = 6  />
    <cfset this.WEEKDAY_SATURDAY = 7  />    
 
 
 
 
 
 
 	<cffunction name="getCalendarAvailability" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
		
		<cfset var local = StructNew() />
        
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />  
              
        <cfset var qryRecurrenceTypeNone = this.getRecurrenceTypeNone(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeDailyDays = this.getRecurrenceTypeDailyDays(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
    <cfset var qryRecurrenceTypeDailyWeekdays = this.getRecurrenceTypeDailyWeekdays(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeWeekly = this.getRecurrenceTypeWeekly(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeMonthlyDay = this.getRecurrenceTypeMonthlyDay(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeMonthlyWeek = this.getRecurrenceTypeMonthlyWeek(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeYearlyDate = this.getRecurrenceTypeYearlyDate(arguments.Professional_ID, arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        <cfset var qryRecurrenceTypeYearlyMonth = this.getRecurrenceTypeYearlyMonth(arguments.Professional_ID,arguments.CalendarStartDate,arguments.CalendarDaysSpan) />

		<cfquery name="qryResults" dbtype="Query">
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeNone
				
				UNION 
			
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeDailyDays

				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeDailyWeekdays
				
				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeWeekly  
				
				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeMonthlyDay        
				
				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeMonthlyWeek
				
				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeYearlyDate
				
				UNION
				
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryRecurrenceTypeYearlyMonth                                                                     
		</cfquery>
		
		<cfquery name="local.qryResultsSorted" dbtype="Query">
				SELECT Calendar_Date, Start_Time, End_Time
				FROM qryResults
				GROUP BY Calendar_Date, Start_Time, End_Time
				ORDER BY Calendar_Date, Start_Time, End_Time
		</cfquery>		
		
		<cfreturn local.qryResultsSorted />
	</cffunction> 
	
    
     
    
    <cffunction name="getCalendarRangeDates" access="public" output="false" returntype="array">
        <cfargument name="CalendarStartDate" type="String" required="true" />
        <cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
        <cfset var local = StructNew() />
        <cfset var RangeDates = ArrayNew(1) />
        
        <cfset arguments.CalendarStartDate = DateFormat(arguments.CalendarStartDate, "mm/dd/yyyy") />
        
        
        <cfloop from="0" to="#arguments.CalendarDaysSpan - 1#" index="local.i">
        	<cfset RangeDates[local.i + 1] = DateFormat(DateAdd("d", local.i, arguments.CalendarStartDate) , "mm/dd/yyyy") />
        </cfloop>
        
        <cfreturn RangeDates />
    </cffunction>
    
    <cffunction name="getRecurrenceTypeNone" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="string" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
        <cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
        
		<cfset arguments.CalendarStartDate = DateFormat(arguments.CalendarStartDate, "mm/dd/yyyy") />
        
		
		<cfquery name="qryResults" datasource="#Application.datasource#">
        	SELECT Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time
            FROM Availability
            WHERE 
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_NONE#" cfsqltype="cf_sql_integer" /> AND 
            		Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                   	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                   	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan#
            ORDER BY Availability_Start_Date, Start_Time
		</cfquery>
		
		<cfreturn qryResults />
	</cffunction>        

	<cffunction name="getRecurrenceTypeDailyDays" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>


        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopModCount = 0 />
            
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") /> 
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfif local.EndAfterOcurrences GT 0>
                            <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        <cfelse>
                            <cfbreak />
                        </cfif>
                    </cfif>
                    
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                <cfset local.RecurCountInterval = local.qryRecurResults.Recur_Count_Interval />
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfif (local.LoopModCount MOD local.RecurCountInterval) EQ 0>
                        <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") /> 
                        <cfif local.CurrentLoopDate LTE local.EndRecurrenceDate>
                            <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                        <cfelse>
                            <cfbreak />
                        </cfif>
                    </cfif>
                    <cfset local.LoopModCount = local.LoopModCount + 1 />
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  

    
	<cffunction name="getRecurrenceTypeDailyWeekdays" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_WEEKDAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopCount = 0 />
            
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                    <cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") />
                    <cfif DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    <cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>
                
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
                	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") />
					<cfif local.EndAfterOcurrences GT 0>  
                    	<cfif DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
							<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                        	<cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />                        
						</cfif>
					<cfelse>
                    	<cfbreak />
                    </cfif>
                	<cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>
                        
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>
            	<cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
					<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopCount, local.qryRecurResults.Calendar_Date) , "mm/dd/yyyy") /> 

                    <cfif 	local.CurrentLoopDate LTE local.EndRecurrenceDate  AND
							DayOfWeek(local.CurrentLoopDate) GT this.WEEKDAY_SUNDAY AND 
							DayOfWeek(local.CurrentLoopDate) LT this.WEEKDAY_SATURDAY>
                        <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    </cfif>
                    
                    <cfset local.LoopCount = local.LoopCount + 1 />
                </cfloop>            
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  
    
    
    

 	<!--- 	Recurrence_Type_ID = 3	"Weekly"
			Weekly:  Recur every [Recur_Count_Interval] weeks(s) on:  [Week_Days: comma seperated list of possible {1-7} corresponding to Su-Sa] --->
	<cffunction name="getRecurrenceTypeWeekly" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Week_Days
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_WEEKLY#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
        	<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = local.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Calendar_Date />
            <cfset local.WeekDaysList = local.qryRecurResults.Week_Days />    
            
			<!--- Find first week hit to start with --->
            <cfloop condition="ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) EQ 0 AND local.CurrentLoopDate LTE local.RangeEndDate">
                <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
            </cfloop>            
            
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                	</cfif>
                    <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
                    	<!--- Put on Next Sunday start of week --->
                    	<cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        <!--- Add week(s) recur count --->
                        <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                        	<cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                        </cfif>
                     <cfelse>
                    	 <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                    </cfif>
                </cfloop>

            
			<!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
      				<cfif local.EndAfterOcurrences GT 0>
						<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
                            <cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                            
                        </cfif>
                        <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
                            <!--- Put on Next Sunday start of week --->
                            <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                            <!--- Add week(s) recur count --->
                            <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                                <cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                                <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                            </cfif>
                         <cfelse>
                             <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        </cfif>
                 	<cfelse>
                    	<cfbreak />
                 	</cfif>                        
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfif ListContains(local.WeekDaysList, DayOfWeek(local.CurrentLoopDate)) GT 0>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                	</cfif>
                    <cfif DayOfWeek(local.CurrentLoopDate) EQ this.WEEKDAY_SATURDAY><!--- End of Week then start new week by recur count --->
                    	<!--- Put on Next Sunday start of week --->
                    	<cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                        <!--- Add week(s) recur count --->
                        <cfif local.qryRecurResults.Recur_Count_Interval GT 1>
                        	<cfset local.CurrentLoopDate = DateAdd('ww', local.qryRecurResults.Recur_Count_Interval - 1, local.CurrentLoopDate) />
                        </cfif>
                     <cfelse>
                    	 <cfset local.CurrentLoopDate = DateAdd('d', 1, local.CurrentLoopDate) /> 
                    </cfif>
                </cfloop>                          
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />	
    </cffunction>  


    
    
 	<!--- 	Recurrence_Type_ID = 4	"Monthly Date"
			Monthly:  Day [Day_Value] of every [Recur_Count_Interval] month(s) --->
    <cffunction name="getRecurrenceTypeMonthlyDay" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Day_Value
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_MONTHLY_DATE#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = local.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Calendar_Date />
                
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        <cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
						<cfif local.EndAfterOcurrences GT 0>
							<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        	<cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        <cfelse>
                            <cfbreak />
                        </cfif>                        
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfif DatePart("d", local.CurrentLoopDate ) EQ local.qryRecurResults.Day_Value>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        <cfset local.CurrentLoopDate = DateAdd('m', local.qryRecurResults.Recur_Count_Interval, local.CurrentLoopDate) />
                    <cfelse>
                    	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', 1, local.CurrentLoopDate), "mm/dd/yyyy") />
                	</cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>    
    
 	


<!--- 
			OrdinalIntervals
			this.RECURRENCE_ORDINAL_TYPE_FIRST = 1 
			this.RECURRENCE_ORDINAL_TYPE_SECOND = 2  
			this.RECURRENCE_ORDINAL_TYPE_THIRD = 3 
			this.RECURRENCE_ORDINAL_TYPE_FOURTH = 4  
			this.RECURRENCE_ORDINAL_TYPE_LAST = 5      
--->    
<!---  
			WeekdayTypes
			1	Day
			2	Weekday
			3	Weekend Day
			4	Sunday
			5	Monday
			6	Tuesday
			7	Wednesday
			8	Thursday
			9	Friday
			10	Saturday 
---> 


	<!--- Recurrence_Type_ID = 5	Monthly Week
		Monthly:  The [Recurrence_Ordinal_Interval_ID: 1st,2nd,3rd,4th,last] [Recurrence_Weekday_Interval_ID: day,weekday,weekend,Su-Sa] 
		of every [Recur_Count_Interval] month(s) --->
 	<cffunction name="getRecurrenceTypeMonthlyWeek" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
                    Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_MONTHLY_WEEK#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = local.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = local.qryRecurResults.Calendar_Date />
                
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                    <cfif local.CurrentLoopDate LTE local.RangeEndDate>
						<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                    	<cfset local.CurrentLoopDate = 
								DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />                    
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.EndAfterOcurrences GT 0>
                        <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
						<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                    	<cfset local.CurrentLoopDate = 
									DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />

				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate>
						<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                    	<cfset local.CurrentLoopDate = 
									DateAdd('m', local.qryRecurResults.Recur_Count_Interval, CreateDate(Year(local.CurrentLoopDate),Month(local.CurrentLoopDate),1)) />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>    


		<!--- Recurrence_Type_ID = 6	Yearly Date
        		Yearly:  Every [Yearly_Month, 1-12] [Day_Value]  --->
    <cffunction name="getRecurrenceTypeYearlyDate" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID, Day_Value, Yearly_Month
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_YEARLY_DATE#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = local.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Calendar_Date), local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />

            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE local.qryRecurResults.Calendar_Date">
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />
                </cfloop>
                
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE local.qryRecurResults.Calendar_Date">
                	<cfif local.EndAfterOcurrences GT 0>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />
                        <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
					<cfelse>
                        <cfbreak />
                    </cfif>                           
                </cfloop>                

    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate GTE local.qryRecurResults.Calendar_Date AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        <cfset local.CurrentLoopDate = 
										CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, local.qryRecurResults.Day_Value) />                   
                </cfloop>               
			</cfif>

			
            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>  



	<!--- Recurrence_Type_ID = 7	Yearly Month
    			Yearly:  The [Recurrence_Ordinal_Interval_ID: 1st,2nd,3rd,4th,last] [Recurrence_Weekday_Interval_ID: day,weekday,weekend,Su-Sa] of [Yearly_Month: 1-12]
     --->
 	<cffunction name="getRecurrenceTypeYearlyMonth" access="public" output="true" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
 
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date, End_After_Ocurrences, Recurrence_Range_Type_ID,
                    Recurrence_Ordinal_Interval_ID, Recurrence_Weekday_Interval_ID, Yearly_Month
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_YEARLY_MONTH#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                            
        <cfloop query="local.qryRecurResults">
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.RangeEndDate = local.CalendarRangeDates[arguments.CalendarDaysSpan] />
            <cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Calendar_Date), 
															local.qryRecurResults.Yearly_Month, 1) />
               
            <cfif local.qryRecurResults.Calendar_Date GT local.CurrentLoopDate>
            	<cfset local.CurrentLoopDate = CreateDate(Year(local.qryRecurResults.Calendar_Date) + 1, 
															local.qryRecurResults.Yearly_Month, 1) />            	
            </cfif>
                
            <!--- Range of Occurrence: No End Date --->
            <cfif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_NO_END_DATE>
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                     

                    <cfif local.CurrentLoopDate LTE local.RangeEndDate>
                    	<cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
                        	<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        </cfif>
                    	<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) />                     
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
			
            <!--- Range of Occurrence: End After Occurrences --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES>
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
            	<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.EndAfterOcurrences GT 0>
                        <cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
                        	<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        </cfif>
						<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) /> 
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>
    
            <!--- Range of Occurrence: End By Date --->
            <cfelseif local.qryRecurResults.Recurrence_Range_Type_ID EQ this.RECURRENCE_RANGE_TYPE_END_BY_DATE>         
                <cfset local.EndRecurrenceDate = DateFormat(local.qryRecurResults.End_Recurrence_Date, "mm/dd/yyyy") />

				<cfloop condition="local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate">
                	<cfset local.CurrentLoopDate = getXOfMonth(local.CurrentLoopDate, 
                				local.qryRecurResults.Recurrence_Ordinal_Interval_ID, local.qryRecurResults.Recurrence_Weekday_Interval_ID) />
                	
					<cfif local.CurrentLoopDate LTE local.RangeEndDate AND local.CurrentLoopDate LTE local.EndRecurrenceDate>
                    	<cfif Month(local.CurrentLoopDate) EQ local.qryRecurResults.Yearly_Month>
							<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(local.CurrentLoopDate, "mm/dd/yyyy") />
                        </cfif>
						<cfset local.CurrentLoopDate = CreateDate(Year(local.CurrentLoopDate) + 1, local.qryRecurResults.Yearly_Month, 1) /> 	
					<cfelse>
                    	<cfbreak />
                    </cfif>
                </cfloop>                
			</cfif>

            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>    

 
    <cffunction name="IsWeekDay" access="public" output="false" returntype="boolean">
        <cfargument name="TestDate" type="String" required="true" default="#ToString(Now())#" />
		
        <cfset var local = StructNew() />
        <cfset var bolResults = false />
        <cftry>
        	<cfset bolResults = (DayOfWeek(arguments.TestDate) GTE 2 AND DayOfWeek(arguments.TestDate) LTE 6) />
            <cfcatch type="any">
                
             </cfcatch>            
        </cftry>

        <cfreturn bolResults />
    </cffunction>
    
    <cffunction name="IsWeekEnd" access="public" output="false" returntype="boolean">
        <cfargument name="TestDate" type="String" required="true" default="#ToString(Now())#" />
		
        <cfset var local = StructNew() />
        <cfset var bolResults = false />
        <cftry>
        	<cfset bolResults = (DayOfWeek(arguments.TestDate) EQ 1 OR DayOfWeek(arguments.TestDate) EQ 7) />
            <cfcatch type="any">
                
             </cfcatch>            
        </cftry>

        <cfreturn bolResults />
    </cffunction>
       
    

	<cffunction name="getXOfMonth" access="public" returntype="date" output="true">
        <cfargument name="Date" type="date" required="true"   />
        <cfargument name="OrdinalInterval" type="numeric" required="true"  />
		<cfargument name="WeekdayType" type="numeric" required="true"  />    	
    
    	<cfset var local = StructNew() />
<!--- 
			OrdinalIntervals
			this.RECURRENCE_ORDINAL_TYPE_FIRST = 1 
			this.RECURRENCE_ORDINAL_TYPE_SECOND = 2  
			this.RECURRENCE_ORDINAL_TYPE_THIRD = 3 
			this.RECURRENCE_ORDINAL_TYPE_FOURTH = 4  
			this.RECURRENCE_ORDINAL_TYPE_LAST = 5      
--->    
<!---  
			WeekdayTypes
			1	Day
			2	Weekday
			3	Weekend Day
			4	Sunday
			5	Monday
			6	Tuesday
			7	Wednesday
			8	Thursday
			9	Friday
			10	Saturday 
---> 
        <cfset local.StartDate = CreateDate(Year(arguments.Date),Month( arguments.Date ),1) />
        <cfset local.FinalDate = local.StartDate />
        <cfset local.incrementBy = 1 />
        
        <cfif arguments.OrdinalInterval EQ this.RECURRENCE_ORDINAL_TYPE_LAST>
        	<cfreturn getLastXOfMonth(arguments.Date, arguments.WeekdayType) />
        <cfelse>
        	<cfset local.ContinueLoop = true />
            <cfloop condition="local.ContinueLoop">
            	<cfset local.OrdinalInterval = arguments.OrdinalInterval  />
                <cfswitch expression="#WeekdayType#">
                    <cfcase value="1"><!--- Day --->
                        <cfset local.FinalDate = DateAdd( "d", local.OrdinalInterval - 1, local.StartDate ) />
                    </cfcase>
                    <cfcase value="2"><!--- Weekday --->
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif IsWeekDay(local.StartDate)>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>
                    </cfcase>     
                    <cfcase value="3"><!--- Weekend Day --->
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif IsWeekEnd(local.StartDate)>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval -1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>                                  
                    </cfcase>   
                    <cfcase value="4">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_SUNDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop> 
                                            
                    </cfcase>   
                    <cfcase value="5">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_MONDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>   
                    
                    <cfcase value="6">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_TUESDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>         	
                    </cfcase>   
                    <cfcase value="7">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_WEDNESDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>   
                    <cfcase value="8">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_THURSDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>            	
                    </cfcase>   
                    <cfcase value="9">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_FRIDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>             	
                    </cfcase>   
                    <cfcase value="10">
                        <cfloop condition="local.OrdinalInterval GT 0">
                            <cfif DayOfWeek(local.StartDate) EQ this.WEEKDAY_SATURDAY>
                                <cfset local.FinalDate = DateFormat(local.StartDate,"mm/dd/yyyy") />
                                <cfset local.OrdinalInterval = local.OrdinalInterval - 1 />
                            </cfif>
                            <cfset local.StartDate = DateAdd('d', local.incrementBy, local.StartDate) />
                        </cfloop>           	
                    </cfcase>                                                                                                          
                    <cfdefaultcase></cfdefaultcase>
                </cfswitch>
                
                <cfif local.FinalDate LT arguments.Date>
					<cfset local.StartDate = DateAdd('m', 1, CreateDate(Year(local.FinalDate),Month(local.FinalDate),1)) />
                    <cfset local.FinalDate = local.StartDate />
                <cfelse>
                	<cfset local.ContinueLoop = false />
                </cfif>
       		</cfloop>
        </cfif>

    	<cfreturn DateFormat(local.FinalDate,"mm/dd/yyyy") />        
    </cffunction>

    <cffunction name="getLastXOfMonth" access="public" returntype="date" output="true"> 
        <cfargument name="Date" type="date" required="true"   />
		<cfargument name="WeekdayType" type="numeric" required="true"  />
        <cfset var local = StructNew() />

        <cfset local.ThisMonth = CreateDate(Year(arguments.Date),Month(arguments.Date),1) />
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
        <cfset local.ContinueLoop = true />
        <cfloop condition="local.ContinueLoop">
            <cfswitch expression="#WeekdayType#">
                <cfcase value="1">
                    <!--- Already calculated  --->
                </cfcase>
                <cfcase value="2">
                    <cfloop condition="Not IsWeekDay(local.LastDay)">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>     
                <cfcase value="3">
                    <cfloop condition="Not IsWeekEnd(local.LastDay)">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>   
                <cfcase value="4">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_SUNDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>
                </cfcase>   
                <cfcase value="5">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_MONDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="6">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_TUESDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="7">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_WEDNESDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="8">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_THURSDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="9">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_FRIDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>   
                <cfcase value="10">
                    <cfloop condition="DayOfWeek(local.LastDay) NEQ this.WEEKDAY_SATURDAY">
                        <cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
                    </cfloop>            	
                </cfcase>                                                                                                          
                <cfdefaultcase></cfdefaultcase>
             </cfswitch>
    
            <cfif local.LastDay LT arguments.Date>
                <cfset local.ThisMonth = DateAdd('m', 1, CreateDate(Year(local.ThisMonth),Month(local.ThisMonth),1)) />
        		<cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
            <cfelse>
                <cfset local.ContinueLoop = false />
            </cfif>         
         </cfloop>

    	<cfreturn local.LastDay />
    </cffunction>
    
    <cffunction name="getLastWeekendDayOfMonth" access="public" returntype="date" output="false"> 
        <cfargument name="Date" type="date" required="true"   />

        <cfset var local = StructNew() />

        <cfset local.ThisMonth = CreateDate(Year( arguments.Date ),Month( arguments.Date ),1) />
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
        
        <cfloop condition="Not IsWeekEnd(local.LastDay)">
			<cfset local.LastDay = DateAdd('d', -1, local.LastDay) />
        </cfloop>
    
    	<cfreturn local.LastDay />
    </cffunction>    
    
    <cffunction name="getLastDayOfWeekOfMonth" access="public" returntype="date" output="false" hint="Returns the date of the last given weekday of the given month.">
        <cfargument name="Date" type="date" required="true"hint="Any date in the given month we are going to be looking at."  />
        <cfargument name="DayOfWeek" type="numeric" required="true" hint="The day of the week of which we want to find the last monthly occurence." />
     
        <!--- Define the local scope. --->
        <cfset var local = StructNew() />
     
        <!--- Get the current month based on the given date. --->
        <cfset local.ThisMonth = CreateDate(Year( arguments.Date ),Month( arguments.Date ),1) />
     
        <!---Now, get the last day of the current month. We can get this by subtracting 1 from the first day of the next month.--->
        <cfset local.LastDay = (DateAdd( "m", 1, local.ThisMonth ) - 1) />
     
        <!---
            Now, the last day of the month is part of the last
            week of the month. However, there is no guarantee
            that the target day of this week will be in the current
            month. Regardless, let's get the date of the target day
            so that at least we have something to work with.
        --->
        <cfset local.Day = (local.LastDay - DayOfWeek( local.LastDay ) + arguments.DayOfWeek) />
     
        <!---
            Now, we have the target date, but we are not exactly
            sure if the target date is in the current month. if
            is not, then we know it is the first of that type of
            the next month, in which case, subracting 7 days (one
            week) from it will give us the last occurence of it in
            the current Month.
        --->
        <cfif (Month( local.Day ) NEQ Month( local.ThisMonth ))>
            <!--- Subract a week. --->
            <cfset local.Day = (local.Day - 7) />
        </cfif>
     
     
        <!--- Return the given day. --->
        <cfreturn DateFormat( local.Day ) />
    </cffunction>

    
    
	<!--- <cffunction name="getRecurrenceTypeDailyDaysNoEndDate" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
        
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                    Recurrence_Range_Type_ID = #this.RECURRENCE_RANGE_TYPE_NO_END_DATE# AND
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopModCount = 0 />
			<cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
            	<cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, Calendar_Date) , "mm/dd/yyyy") /> 
                	<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                </cfif>
                <cfset local.LoopModCount = local.LoopModCount + 1 />
            </cfloop>
			
            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>
    
    
	<cffunction name="getRecurrenceTypeDailyDaysEndAfterOcurrences" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
        
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_After_Ocurrences,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                    Recurrence_Range_Type_ID = #this.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES# AND
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
   
        <cfloop query="local.qryRecurResults">
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopModCount = 0 />
            <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
            
			<cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
            	<cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                    <cfif local.EndAfterOcurrences GT 0>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = DateFormat(DateAdd('d', local.LoopModCount, Calendar_Date) , "mm/dd/yyyy") />
                        <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfif>
                
                <cfset local.LoopModCount = local.LoopModCount + 1 />
            </cfloop>
			
            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction>


    
      
	<cffunction name="getRecurrenceTypeDailyDaysEndByDate" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
        
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_Recurrence_Date,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                    Recurrence_Range_Type_ID = #this.RECURRENCE_RANGE_TYPE_END_BY_DATE# AND
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
            
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
                
        <cfloop query="local.qryRecurResults">
        
			<cfset local.position = local.qryRecurResults.position />
			<cfset local.TargetDates = ArrayNew(1) />
            <cfset local.LoopModCount = 0 />
			<cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.k">
            	<cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                	<cfset local.CurrentLoopDate = DateFormat(DateAdd('d', local.LoopModCount, Calendar_Date) , "mm/dd/yyyy") /> 
                    <cfif local.CurrentLoopDate LTE local.qryRecurResults.End_Recurrence_Date>
                		<cfset local.TargetDates[ArrayLen(local.TargetDates)+1] = local.CurrentLoopDate />
                    <cfelse>
                    	<cfbreak />
                    </cfif>
                </cfif>
                <cfset local.LoopModCount = local.LoopModCount + 1 />
            </cfloop>
			
            <cfset local.TargetDateList = ArrayToList(local.TargetDates) />
			<cfloop index="i" array="#local.CalendarRangeDates#">
            	<cfif ListContains(local.TargetDateList, i) GT 0>
					<cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                    <cfset QuerySetCell(qryResults, "Calendar_Date", i, local.CurrentRow) />
                    <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                    <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	                    
                </cfif> 
            </cfloop>
        </cfloop>
        
        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />		
    </cffunction> --->
    
    

    
    
	<!--- <cffunction name="getRecurrenceTypeDailyDays" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />
		<cfargument name="CalendarDaysSpan" type="numeric" required="true" />
        
		<cfset var local = StructNew() />
		<cfset var qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
        
		<cfset arguments.CalendarStartDate = DateFormat(arguments.CalendarStartDate, "mm/dd/yyyy") />
        
		<cfquery name="local.qryRecurResults" datasource="#Application.datasource#">
        	SELECT 	Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time, 
            		Recur_Count_Interval, End_After_Ocurrences, End_Recurrence_Date, Has_End_Date,
            		DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date)as position
            FROM Availability
            WHERE 	
            		Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_DAYS#" cfsqltype="cf_sql_integer" /> AND 
           			Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND 
                	(
                    	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) <= 0 
                        OR
                        (	
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) >= 0 AND
                        	DATEDIFF(day, '#arguments.CalendarStartDate#', Availability_Start_Date) < #arguments.CalendarDaysSpan# 
                         )
                    )
            
		</cfquery>

        <cfif local.qryRecurResults.RecordCount GT 0>
        	<cfset local.CalendarRangeDates = getCalendarRangeDates(arguments.CalendarStartDate, arguments.CalendarDaysSpan) />
        </cfif>
    	
        <!--- Loop through all Daily Days Entries --->
        <cfloop query="local.qryRecurResults">
        
        	<!--- Has Range of Recurrence End By Date --->
        	<cfif local.qryRecurResults.Has_End_Date EQ true>
				<cfset local.position = local.qryRecurResults.position />
  
                <cfif local.position LT 0>
                    <cfset local.position = 0 />
                </cfif>

                <cfset local.LoopModCount = 0 />
                <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.i">
                    <cfif local.CalendarRangeDates[local.i + 1] GT local.qryRecurResults.End_Recurrence_Date>
                    	<cfbreak />
                    </cfif> 
                
                    <!--- Add entry if Recur Count Interval has elapsed "Every x days" --->
                    <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                        <cfset QuerySetCell(qryResults, "Calendar_Date", local.CalendarRangeDates[local.i + 1], local.CurrentRow) />
                        <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                        <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	
                    </cfif> 
    
                    <cfset local.LoopModCount = local.LoopModCount + 1 />	                    
                </cfloop>   

			<!--- Has End After Ocurrences --->
			<cfelseif local.qryRecurResults.End_After_Ocurrences NEQ ''>

				<cfset local.ContinueProcess = true />
                <cfset local.position = local.qryRecurResults.position />
                <cfset local.EndAfterOcurrences = local.qryRecurResults.End_After_Ocurrences />
                
                <cfif local.position LT 1>
                    <!--- Check the End After Occurrences has not concluded prior to Calendar Range --->
                    <cfloop from="#local.position#" to="0" index="local.j" step="1">
                        <cfif (local.j MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                        </cfif>                    
                    </cfloop> 
                    
                    <!--- End After Occurences have been generated prior to this Calendar Range of Dates --->
                    <cfif local.EndAfterOcurrences LT 0>
                        <cfset local.ContinueProcess = false />
                    <cfelse>
                        <cfset local.position = 0 />
                    </cfif>
                </cfif>
    
                <cfif local.ContinueProcess EQ true>
                    <cfset local.LoopModCount = 0 />
                    <cfloop from="#local.position#" to="#arguments.CalendarDaysSpan-1#" index="local.i">
                        <!--- Add entry if Recur Count Interval has elapsed "Every x days" --->
                        <cfif (local.LoopModCount MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                            <!---  Increment End After Occurences counter --->
                            <cfset local.EndAfterOcurrences = local.EndAfterOcurrences - 1 />
                            <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                            <cfset QuerySetCell(qryResults, "Calendar_Date", local.CalendarRangeDates[local.i + 1], local.CurrentRow) />
                            <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                            <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	
                        </cfif> 
                        <!---  End After Occurences have been generated within Calendar Range of Dates  --->
                        <cfif local.EndAfterOcurrences LTE 0>
                            <cfbreak />
                        </cfif>	
                        <cfset local.LoopModCount = local.LoopModCount + 1 />	                    
                    </cfloop>
                </cfif>                 
                
             <!--- Does not have End Date or End After Occurences --->            
            <cfelse>
				<cfset local.position = local.qryRecurResults.position />
  
               <cfif local.position LT 0>
                    <cfset local.position = local.qryRecurResults.Recur_Count_Interval + local.position + 1 />
                </cfif> 

                 
                <cfloop from="0" to="#arguments.CalendarDaysSpan-local.position#" index="local.i">

					<!--- Add entry if Recur Count Interval has elapsed "Every x days" --->
                    <cfif  (local.i MOD local.qryRecurResults.Recur_Count_Interval) EQ 0>
                        <cfset local.CurrentRow = QueryAddRow(qryResults, 1) />
                        <cfset QuerySetCell(qryResults, "Calendar_Date", local.CalendarRangeDates[local.i + local.position], local.CurrentRow) />
                        <cfset QuerySetCell(qryResults, "Start_Time", local.qryRecurResults.Start_Time, local.CurrentRow) />	
                        <cfset QuerySetCell(qryResults, "End_Time", local.qryRecurResults.End_Time, local.CurrentRow) />	
                    </cfif> 
    
                    <!--- <cfset local.LoopModCount = local.LoopModCount + 1 />	 --->                    
                </cfloop>              
            </cfif>
        </cfloop> 

        <cfquery name="local.qryResultsSorted" dbtype="query">
        	SELECT * FROM qryResults ORDER BY Calendar_Date, Start_Time
        </cfquery>
		
		<cfreturn local.qryResultsSorted />
	</cffunction>  --->
        
<!---     <cffunction name="getRecurrenceTypeDailyWeekdays" access="public" output="false" returntype="Query">
    	<cfargument name="Professional_ID" type="numeric" required="true" />
		<cfargument name="CalendarStartDate" type="String" required="true" />

		<cfset var local = StructNew() />


		<cfset local.qryResults = QueryNew("Calendar_Date, Start_Time, End_Time", "VarChar, Integer, Integer") />
		<cfquery name="local.qryResults" datasource="#Application.datasource#">
        	SELECT Convert(varchar, Availability_Start_Date, 101) as Calendar_Date, Start_Time, End_Time
            FROM Availability
            WHERE 	Recurrence_Type_ID = <cfqueryparam value="#this.RECURRENCE_TYPE_DAILY_WEEKDAYS#" cfsqltype="cf_sql_integer" /> AND 
            		Professional_ID = <cfqueryparam value="#arguments.Professional_ID#" cfsqltype="cf_sql_integer" /> AND

		</cfquery>
		
		<cfreturn local.qryResults />
	</cffunction>   --->

 
</cfcomponent>