<cfif Not structKeyExists(Session, 'Professional_ID')>
	<cflocation url="login.cfm" />
</cfif>

<cfset variables.CALANDER_DAYS_SPAN = 7  />
<cfif structKeyExists(url, 'StartWeekDate')>
	<cfset variables.StartWeekDate = DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", url.StartWeekDate), "mm/dd/yyyy") />
<cfelse>
	<cfset variables.StartWeekDate = DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now()), "mm/dd/yyyy") />
</cfif>

<cfset variables.EndWeekDate = DateFormat(DateAdd("d", variables.CALANDER_DAYS_SPAN, variables.StartWeekDate ), "mm/dd/yyyy") />
<cfset variables.Calendar = createObject("component","appointmentsCalendarBean") /> 
<cfset variables.NextAvailabilityEventID = variables.Calendar.getProfessionalAvailabilityMaxID(Session.Professional_ID) />

<cfajaxproxy cfc="appointmentsCalendarBean" jsclassname="calendarAjax" />

	<cfinclude template="header.cfm" />
    <link rel='stylesheet' type='text/css' href='calendar/interface/libs/css/smoothness/jquery-ui-1.8.11.custom.css' />
    <link rel='stylesheet' type='text/css' href='calendar/interface/jquery.weekcalendar.css' />
    <link rel='stylesheet' type='text/css' href='calendar/interface/skins/default.css' />
    <link rel='stylesheet' type='text/css' href='calendar/interface/reset.css' />
    <link rel='stylesheet' type='text/css' href='calendar/interface/demo.css' />
  
	<style type='text/css'>
		body {
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		margin: 0;
		}
		
		h1 {
		margin:0 0 2em;
		padding: 0.5em;
		font-size: 1.3em;
		}
		
		p.description {
		font-size: 0.8em;
		padding: 1em;
		position: absolute;
		top: 3.2em;
		margin-right: 400px;
		}
		
		.clearer {
		clear: both;
		}
		
		#calendar_selection {
		font-size: 0.7em;
		position: absolute;
		top: 1em;
		right: 1em;
		padding: 1em;
		background: #ffc;
		border: 1px solid #dda;
		width: 270px;
		}
		
		#message {
		font-size: 0.7em;
		padding: 1em;
		margin-right: 1em;
		margin-bottom: 10px;
		background: #ddf;
		border: 1px solid #aad;
		width: 270px;
		float: right;
    }
    </style>
	<!--- <script type='text/javascript' src='calendar/interface/libs/jquery-1.4.4.min.js'></script>
    <script type='text/javascript' src='calendar/interface/libs/jquery-ui-1.8.11.custom.min.js'></script> --->

<script type='text/javascript' src='//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js'></script>

    <script type="text/javascript" src="calendar/interface/libs/date.js"></script>
    <script type='text/javascript' src='calendar/interface/jquery.weekcalendar.js'></script>
    <script type='text/javascript' src='calendar/interface/calendar.tables.globals.js'></script>
	<script type='text/javascript'>
		<cfoutput>
		var newID = 0;
		var sDate = "";
		var eDate = "";			
		var StartWeekDate = '#variables.StartWeekDate#';
		var calendarSpan = #variables.CALANDER_DAYS_SPAN#;
		var Professional_ID = #Session.Professional_ID#;
		var year = #Year(variables.StartWeekDate)#;
		var month = #Month(variables.StartWeekDate)-1#;
		var day = #Day(variables.StartWeekDate)#;
		var eventData = {events:[]};
		var NextAvailabilityEventID = #(variables.NextAvailabilityEventID + 1)#;
		var recurrenceRangeType = 1;
		var recurrenceDeleteType = 1;
		var currentCalEvent = null;
		var timeSelectOptionsStart = '<option value="07:00 AM">07:00 AM</option><option value="07:15 AM">07:15 AM</option><option value="07:30 AM">07:30 AM</option><option value="07:45 AM">07:45 AM</option><option value="08:00 AM">08:00 AM</option><option value="08:15 AM">08:15 AM</option><option value="08:30 AM">08:30 AM</option><option value="08:45 AM">08:45 AM</option><option value="09:00 AM">09:00 AM</option><option value="09:15 AM">09:15 AM</option><option value="09:30 AM">09:30 AM</option><option value="09:45 AM">09:45 AM</option><option value="10:00 AM">10:00 AM</option><option value="10:15 AM">10:15 AM</option><option value="10:30 AM">10:30 AM</option><option value="10:45 AM">10:45 AM</option><option value="11:00 AM">11:00 AM</option><option value="11:15 AM">11:15 AM</option><option value="11:30 AM">11:30 AM</option><option value="11:45 AM">11:45 AM</option><option value="12:00 PM">12:00 PM</option><option value="12:15 PM">12:15 PM</option><option value="12:30 PM">12:30 PM</option><option value="12:45 PM">12:45 PM</option><option value="01:00 PM">01:00 PM</option><option value="01:15 PM">01:15 PM</option><option value="01:30 PM">01:30 PM</option><option value="01:45 PM">01:45 PM</option><option value="02:00 PM">02:00 PM</option><option value="02:15 PM">02:15 PM</option><option value="02:30 PM">02:30 PM</option><option value="02:45 PM">02:45 PM</option><option value="03:00 PM">03:00 PM</option><option value="03:15 PM">03:15 PM</option><option value="03:30 PM">03:30 PM</option><option value="03:45 PM">03:45 PM</option><option value="04:00 PM">04:00 PM</option><option value="04:15 PM">04:15 PM</option><option value="04:30 PM">04:30 PM</option><option value="04:45 PM">04:45 PM</option><option value="05:00 PM">05:00 PM</option><option value="05:15 PM">05:15 PM</option><option value="05:30 PM">05:30 PM</option><option value="05:45 PM">05:45 PM</option><option value="06:00 PM">06:00 PM</option><option value="06:15 PM">06:15 PM</option><option value="06:30 PM">06:30 PM</option><option value="06:45 PM">06:45 PM</option><option value="07:00 PM">07:00 PM</option><option value="07:15 PM">07:15 PM</option><option value="07:30 PM">07:30 PM</option><option value="07:45 PM">07:45 PM</option><option value="08:00 PM">08:00 PM</option><option value="08:15 PM">08:15 PM</option><option value="08:30 PM">08:30 PM</option><option value="08:45 PM">08:45 PM</option><option value="09:00 PM">09:00 PM</option><option value="09:15 PM">09:15 PM</option><option value="09:30 PM">09:30 PM</option><option value="09:45 PM">09:45 PM</option>';
		var timeSelectOptionsEnd = '<option value="07:15 AM">07:15 AM</option><option value="07:30 AM">07:30 AM</option><option value="07:45 AM">07:45 AM</option><option value="08:00 AM">08:00 AM</option><option value="08:15 AM">08:15 AM</option><option value="08:30 AM">08:30 AM</option><option value="08:45 AM">08:45 AM</option><option value="09:00 AM">09:00 AM</option><option value="09:15 AM">09:15 AM</option><option value="09:30 AM">09:30 AM</option><option value="09:45 AM">09:45 AM</option><option value="10:00 AM">10:00 AM</option><option value="10:15 AM">10:15 AM</option><option value="10:30 AM">10:30 AM</option><option value="10:45 AM">10:45 AM</option><option value="11:00 AM">11:00 AM</option><option value="11:15 AM">11:15 AM</option><option value="11:30 AM">11:30 AM</option><option value="11:45 AM">11:45 AM</option><option value="12:00 PM">12:00 PM</option><option value="12:15 PM">12:15 PM</option><option value="12:30 PM">12:30 PM</option><option value="12:45 PM">12:45 PM</option><option value="01:00 PM">01:00 PM</option><option value="01:15 PM">01:15 PM</option><option value="01:30 PM">01:30 PM</option><option value="01:45 PM">01:45 PM</option><option value="02:00 PM">02:00 PM</option><option value="02:15 PM">02:15 PM</option><option value="02:30 PM">02:30 PM</option><option value="02:45 PM">02:45 PM</option><option value="03:00 PM">03:00 PM</option><option value="03:15 PM">03:15 PM</option><option value="03:30 PM">03:30 PM</option><option value="03:45 PM">03:45 PM</option><option value="04:00 PM">04:00 PM</option><option value="04:15 PM">04:15 PM</option><option value="04:30 PM">04:30 PM</option><option value="04:45 PM">04:45 PM</option><option value="05:00 PM">05:00 PM</option><option value="05:15 PM">05:15 PM</option><option value="05:30 PM">05:30 PM</option><option value="05:45 PM">05:45 PM</option><option value="06:00 PM">06:00 PM</option><option value="06:15 PM">06:15 PM</option><option value="06:30 PM">06:30 PM</option><option value="06:45 PM">06:45 PM</option><option value="07:00 PM">07:00 PM</option><option value="07:15 PM">07:15 PM</option><option value="07:30 PM">07:30 PM</option><option value="07:45 PM">07:45 PM</option><option value="08:00 PM">08:00 PM</option><option value="08:15 PM">08:15 PM</option><option value="08:30 PM">08:30 PM</option><option value="08:45 PM">08:45 PM</option><option value="09:00 PM">09:00 PM</option><option value="09:15 PM">09:15 PM</option><option value="09:30 PM">09:30 PM</option><option value="09:45 PM">09:45 PM</option><option value="10:00 PM">10:00 PM</option>'; 
		
		<!--- <cfset dtMinutes = CreateTimeSpan(
			0, <!--- Days. --->
			0, <!--- Hours. --->
			15, <!--- Minutes. --->
			0 <!--- Seconds. --->
			) />
			
		<cfset timeOptions = "" />
		<cfloop index="dtTime" from="7:00 AM" to="9:45 PM" step="#dtMinutes#">
 			<cfset timeOptions = timeOptions & '<option value="#TimeFormat( dtTime, "hh:mm TT" )#">#TimeFormat( dtTime, "hh:mm TT" )#</option>'/>
		</cfloop>
		var timeSelectOptionsStart = '#timeOptions#';
				
		<cfset timeOptions = "" />
		<cfloop index="dtTime" from="7:15 AM" to="10:00 PM" step="#dtMinutes#">
 			<cfset timeOptions = timeOptions & '<option value="#TimeFormat( dtTime, "hh:mm TT" )#">#TimeFormat( dtTime, "hh:mm TT" )#</option>'/>
		</cfloop>
		var timeSelectOptionsEnd = '#timeOptions#'; --->
						
		</cfoutput>

		// Function to find the index in an array of the first entry with a specific value. 
		//it is used to get the index of a column in the column list. 
            Array.prototype.findIdx = function(value){ 
                for (var i=0; i < this.length; i++) { 
                    if (this[i] == value) { 
                        return i; 
                    } 
                } 
            }
			
            var removeAvailability = function(id, start, type){ 
                var e = new calendarAjax(); 
				var recurType = $('#recurrenceType').val();
				StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
				
				e.setSyncMode();
                e.setCallbackHandler(callBackAvailability); 
                e.setErrorHandler(myErrorHandler); 
								
				if(recurType == RECURRENCE_TYPE_NONE){
					type = 0;
				}
				e.removeAvailability(Professional_ID, id, type, start);
			}
			
            var replaceAvailability = function(id, nId, startDate, endDate){ 
                newID = nId;
				sDate = startDate;
				eDate = endDate;
				            	
                var e = new calendarAjax(); 
				e.setSyncMode();
                e.setCallbackHandler(callBackReplaceAvailability); 
                e.setErrorHandler(myErrorHandler); 
				e.removeAvailability(Professional_ID, id, 0);
			}			
			
            var callBackReplaceAvailability = function(res){ 
            	addAvailability(newID, sDate, eDate);
             	//window.location.href = "availabilityCalendar.cfm?StartWeekDate=" + StartWeekDate;
			}				
			
			var saveAvailability = function(currentID, newID, start, end){
				StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
				replaceAvailability(currentID, newID, start, end);
			}
			
            var addAvailability = function(id, start, end){ 
				var endRecurrenceDate = '';
				var endAfterOcurrences = 0;
				var recurCountInterval = 0;
				var typeValue = $('#recurrenceType').val(); 
                var e = new calendarAjax(); 
                
                StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
				
				e.setSyncMode();
                e.setCallbackHandler(callBackAvailability); 
                e.setErrorHandler(myErrorHandler); 

				if(typeValue > RECURRENCE_TYPE_NONE){
					//Prepare Range Types Data
					if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_NO_END_DATE){
						//Do nothing
					}
					else if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES){
						endAfterOcurrences = $('#endAfterOccur').val();
					}
					else if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_END_BY_DATE){
						endRecurrenceDate = $('#datepicker').val();
					}
				}
				
				switch(typeValue){
				case "0": //RECURRENCE_TYPE_NONE
						e.addAvailabilityTypeNone(Professional_ID, id, start, end);
						break;

 				case "1": //RECURRENCE_TYPE_DAILY_DAYS
						recurCountInterval = $('#dailyEveryDays').val();				
						e.addAvailabilityTypeDailyDays(Professional_ID, id, start, end, recurCountInterval, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;			
					
				case "2": //RECURRENCE_TYPE_DAILY_WEEKDAYS
						e.addAvailabilityTypeDailyWeekdays(Professional_ID, id, start, end, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;
						
				case "3": //RECURRENCE_TYPE_WEEKLY
						var weekDays = "";
						if(document.getElementById('chkSunday').checked) weekDays += ",1";
						if(document.getElementById('chkMonday').checked) weekDays += ",2";
						if(document.getElementById('chkTuesday').checked) weekDays += ",3";
						if(document.getElementById('chkWednesday').checked) weekDays += ",4";
						if(document.getElementById('chkThursday').checked) weekDays += ",5";
						if(document.getElementById('chkFriday').checked) weekDays += ",6";
						if(document.getElementById('chkSaturday').checked) weekDays += ",7";
						
						weekDays = weekDays.substr(1,weekDays.length);
						
						recurCountInterval = $('#weeklyEveryWeeks').val(); 				
						e.addAvailabilityTypeWeekly(Professional_ID, id, start, end, weekDays, 
								recurCountInterval, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;		
							
				case "4": //RECURRENCE_TYPE_MONTHLY_DATE
						var dayValue = $('#monthlyDay').val();
						recurCountInterval =$('#monthlyEveryMonth').val();						
												
						e.addAvailabilityTypeMonthlyDate(Professional_ID, id, start, end, dayValue, 
								recurCountInterval, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;	
			
				case "5": //RECURRENCE_TYPE_MONTHLY_WEEK
						recurCountInterval = $('#monthlyWeekEveryMonth').val();
						var recurrenceOrdinalIntervalID = $('#monthlyOrdinalType').val();
						var recurrenceWeekdayIntervalID = $('#monthlyWeeklyType').val();
						
						e.addAvailabilityTypeMonthlyWeek(Professional_ID, id, start, end, 
							recurrenceOrdinalIntervalID, recurrenceWeekdayIntervalID, recurCountInterval, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;
						
				case "6": //RECURRENCE_TYPE_YEARLY_DATE
						var dayValue = $('#yearlyDay').val();
						var yearlyMonth = $('#yearlyEveryMonth').val();
												
						e.addAvailabilityTypeYearlyDate(Professional_ID, id, start, end, 
						dayValue, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;	
								
				case "7": //RECURRENCE_TYPE_YEARLY_MONTH 
						var recurrenceOrdinalIntervalID = $('#yearlyOrdinalType').val();
						var recurrenceWeekdayIntervalID = $('#yearlWeeklyType').val();
						var yearlyMonth = $('#yearlyOfMonth').val();
											
						e.addAvailabilityTypeYearlyMonth(Professional_ID, id, start, end, 
							recurrenceOrdinalIntervalID, recurrenceWeekdayIntervalID, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
						break;	
					default:		
				}	 		 
            } 
			
            // Callback function to display the results of the getAvailability 
            var callBackAvailability = function(res){
            	 //window.location.href = "availabilityCalendar.cfm?StartWeekDate=" + StartWeekDate;
            	  //$("#calendar").weekCalendar("refresh");
            } 
			
			var loadEventRecurControls = function(id){
                var e = new calendarAjax(); 
				e.setSyncMode();
                e.setCallbackHandler(callBackLoadEventRecurControls); 
                e.setErrorHandler(myErrorHandler); 
				e.getEventDetails(Professional_ID, id);	
					
			}
						
            var callBackLoadEventRecurControls = function(res){ 
				var recurrenceTypeValue = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_TYPE_ID')].toString();
				recurrentTypeChange(recurrenceTypeValue);
				$('#recurrenceType').val(recurrenceTypeValue);
							
				if(recurrenceTypeValue > RECURRENCE_TYPE_NONE){
					recurrenceRangeType = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_RANGE_TYPE_ID')].toString();	
					document.getElementById('recurrence_range_type' + recurrenceRangeType).checked = true;
					switch(recurrenceTypeValue){
	
					case "1": //RECURRENCE_TYPE_DAILY_DAYS
							document.getElementById('dailyEveryDays').value = res.DATA[0][res.COLUMNS.findIdx('RECUR_COUNT_INTERVAL')];
							break;			
							
					case "3": //RECURRENCE_TYPE_WEEKLY
							var weekDays = res.DATA[0][res.COLUMNS.findIdx('WEEK_DAYS')];	
							weekDays = weekDays.toString();
							
							if(weekDays.indexOf(WEEKDAY_SUNDAY.toString()) > -1) document.getElementById('chkSunday').checked = true;
							if(weekDays.indexOf(WEEKDAY_MONDAY.toString()) > -1) document.getElementById('chkMonday').checked = true;
							if(weekDays.indexOf(WEEKDAY_TUESDAY.toString()) > -1) document.getElementById('chkTuesday').checked = true;
							if(weekDays.indexOf(WEEKDAY_WEDNESDAY.toString()) > -1) document.getElementById('chkWednesday').checked = true;
							if(weekDays.indexOf(WEEKDAY_THURSDAY.toString()) > -1) document.getElementById('chkThursday').checked = true;
							if(weekDays.indexOf(WEEKDAY_FRIDAY.toString()) > -1) document.getElementById('chkFriday').checked = true;
							if(weekDays.indexOf(WEEKDAY_SATURDAY.toString()) > -1) document.getElementById('chkSaturday').checked = true;
							
							document.getElementById('weeklyEveryWeeks').value = res.DATA[0][res.COLUMNS.findIdx('RECUR_COUNT_INTERVAL')];
							break;		
								
					case "4": //RECURRENCE_TYPE_MONTHLY_DATE
							document.getElementById('monthlyDay').value = res.DATA[0][res.COLUMNS.findIdx('DAY_VALUE')];
							document.getElementById('monthlyEveryMonth').value = res.DATA[0][res.COLUMNS.findIdx('RECUR_COUNT_INTERVAL')];
							break;	
					
					case "5": //RECURRENCE_TYPE_MONTHLY_WEEK
							document.getElementById('monthlyWeekEveryMonth').value = res.DATA[0][res.COLUMNS.findIdx('RECUR_COUNT_INTERVAL')];
							document.getElementById('monthlyOrdinalType').value = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_ORDINAL_INTERVAL_ID')];
							document.getElementById('monthlyWeeklyType').value = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_WEEKDAY_INTERVAL_ID')];
							break;
							
					case "6": //RECURRENCE_TYPE_YEARLY_DATE
							document.getElementById('yearlyDay').value = res.DATA[0][res.COLUMNS.findIdx('DAY_VALUE')];
							document.getElementById('yearlyEveryMonth').value = res.DATA[0][res.COLUMNS.findIdx('YEARLY_MONTH')];
							break;	
									
					case "7": //RECURRENCE_TYPE_YEARLY_MONTH 
							document.getElementById('yearlyOrdinalType').value = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_ORDINAL_INTERVAL_ID')];
							document.getElementById('yearlWeeklyType').value = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_WEEKDAY_INTERVAL_ID')];
							document.getElementById('yearlyOfMonth').value = res.DATA[0][res.COLUMNS.findIdx('YEARLY_MONTH')];
							break;	
									
						default:
								
					}	 		 					
					
					//Prepare Range Types Data
					if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_NO_END_DATE){
						//Do nothing
					}
					else if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES){
						document.getElementById('endAfterOccur').value = res.DATA[0][res.COLUMNS.findIdx('END_AFTER_OCURRENCES')];
					}
					else if(recurrenceRangeType == RECURRENCE_RANGE_TYPE_END_BY_DATE){
						document.getElementById('datepicker').value = res.DATA[0][res.COLUMNS.findIdx('END_RECURRENCE_DATE')];
					}
				}
            } 			
 
            // Error handler for the asynchronous functions. 
            var myErrorHandler = function(statusCode, statusMsg) { 
                alert('Status: ' + statusCode + ', ' + statusMsg); 
            }  	 

		function resetForm($dialogContent) {
			$dialogContent.find("input").val("");
			$dialogContent.find("textarea").val("");
			$dialogContent.find("select[name='recurrenceType']").val(0);
			$dialogContent.find("select[name='dailyEveryDays']").val(0);
			$dialogContent.find("select[name='weeklyEveryWeeks']").val(0);
			$dialogContent.find("select[name='monthlyDay']").val(0);
			$dialogContent.find("select[name='monthlyEveryMonth']").val(0);
			$dialogContent.find("select[name='monthlyOrdinalType']").val(0);	 
				
			$dialogContent.find("select[name='monthlyWeeklyType']").val(0);
			$dialogContent.find("select[name='monthlyWeekEveryMonth']").val(0);
			$dialogContent.find("select[name='yearlyEveryMonth']").val(0);
			$dialogContent.find("select[name='yearlyDay']").val(0);
			$dialogContent.find("select[name='endAfterOccur']").val(0);			 
			
			$dialogContent.find("input[name='datepicker']").val(<cfoutput>'#variables.EndWeekDate#'</cfoutput>);
			
			document.getElementById('recurrence_range_type1').checked = true;	 	
			document.getElementById('recurrence_range_type2').checked = false;
			document.getElementById('recurrence_range_type3').checked = false;
			recurrenceRangeType = 1;
		}

	function recurrentTypeChange(val){
		clearRecurrenceControls();
		document.getElementById('EndView').style.display = 'block';
		
		var recurrenceTypeValue = val.toString();

		switch(recurrenceTypeValue){
		
			case "0": //RECURRENCE_TYPE_NONE
					document.getElementById('EndView').style.display = 'none';
					break;
			case "1": //RECURRENCE_TYPE_DAILY_DAYS
					document.getElementById('DailyEveryDaysView').style.display = 'block';
					break;			
			case "2": //RECURRENCE_TYPE_DAILY_WEEKDAYS
					document.getElementById('DailyEveryWeekdayView').style.display = 'block';
					break;			
			case "3": //RECURRENCE_TYPE_WEEKLY
					document.getElementById('WeeklyView').style.display = 'block';
					break;			
			case "4": //RECURRENCE_TYPE_MONTHLY_DATE
					document.getElementById('monthlyDay').value = currentCalEvent.start.getDate();
					document.getElementById('MonthlyDateView').style.display = 'block';
					break;			
			case "5": //RECURRENCE_TYPE_MONTHLY_WEEK
					document.getElementById('MonthlyWeekView').style.display = 'block';
					break;			
			case "6": //RECURRENCE_TYPE_YEARLY_DATE
					document.getElementById('yearlyEveryMonth').value = currentCalEvent.start.getMonth() + 1;
					document.getElementById('yearlyDay').value = currentCalEvent.start.getDate();
					document.getElementById('YearlyDateView').style.display = 'block';
					break;			
			case "7": //RECURRENCE_TYPE_YEARLY_MONTH 
					document.getElementById('yearlyOfMonth').value = currentCalEvent.start.getMonth() + 1;
					document.getElementById('YearlyMonthView').style.display = 'block';
					break;			
			default:
		}	
	  }
	  
	  function clearRecurrenceControls(){
		document.getElementById('DailyEveryDaysView').style.display = 'none';
		document.getElementById('DailyEveryWeekdayView').style.display = 'none';
		document.getElementById('WeeklyView').style.display = 'none';
		document.getElementById('MonthlyDateView').style.display = 'none';
		document.getElementById('MonthlyWeekView').style.display = 'none';
		document.getElementById('YearlyDateView').style.display = 'none';
		document.getElementById('YearlyMonthView').style.display = 'none';
		document.getElementById('EndView').style.display = 'none';
	  }		
	  
	  
	  
	  
	var removeAvailability = function(id, start, type){ 
                var e = new calendarAjax(); 
				var recurType = $('#recurrenceType').val();
				StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
				
				e.setSyncMode();
                e.setCallbackHandler(callBackAvailability); 
                e.setErrorHandler(myErrorHandler); 
								
				if(recurType == RECURRENCE_TYPE_NONE){
					type = 0;
				}
				e.removeAvailability(Professional_ID, id, type, start);
			}
			
				  
	 var changeAppointment = function(id, apptDate, apptStartTime, apptEndTime){
            var e = new calendarAjax(); 
			e.setSyncMode();
            e.setCallbackHandler(callBackChangeAppointment); 
            e.setErrorHandler(myErrorHandler); 
			e.changeAppointment(id, apptDate, apptStartTime, apptEndTime, new Date().getTime());
		}	  
	  
	  
	  var  callBackChangeAppointment = function(res){ 
            	 $("#calendar").weekCalendar("refresh");
      } 


	 var deleteAppointment = function(id){
            var e = new calendarAjax(); 
			e.setSyncMode();
            e.setCallbackHandler(callBackDeleteAppointment); 
            e.setErrorHandler(myErrorHandler); 
			e.deleteAppointment(id, new Date().getTime());
		}	  

	  var  callBackDeleteAppointment = function(res){ 
            	 $("#calendar").weekCalendar("refresh");
      } 
	  
   	
		$(document).ready(function() {
			$('#dialog-appointment').hide();
			$("#apptDate").datepicker();
			
			$( "#check" ).button();
			
			$( "#dialog:ui-dialog" ).dialog( "destroy" );
			
			$( "#dialog-form" ).dialog({
				autoOpen: false,
				height: 225,
				width: 350,
				modal: true,
				buttons: {
					Continue: function() {
						removeAvailability(currentCalEvent.id, currentCalEvent.start, recurrenceDeleteType);
						$calendar.weekCalendar("removeEvent", currentCalEvent.id);
						$( this ).dialog( "close" );
						$("#event_edit_container").dialog("close");
					}
				}
			});
			

			

		   	var $calendar = $('#calendar');
		   	var id = NextAvailabilityEventID;
			
			$('#calendar').weekCalendar({
				date: new Date(year, month, day),
				businessHours :{start: 7, end: 22, limitDisplay: true},
				data: function(start, end, callback) {
					console.log(start,end);
				  $.getJSON("calendarWrapperJSON.cfm", {
						ID: Professional_ID, 
						StartDate: (start.getMonth() + 1) + '/' + start.getDate() + '/' + start.getFullYear(), 
						DaySpan: calendarSpan,
						noCache: new Date().getTime()
				   },  function(result) {
					 callback(result);
				   });
				},			  
		
			  	timeslotsPerHour: 4,
			  	height: function($calendar){
					return $(window).height() - $('h1').outerHeight() - $('.description').outerHeight();
			  	},
				
			  	eventRender : function(calEvent, $event) {
					if (calEvent.end.getTime() < new Date().getTime()) {
					  $event.css('backgroundColor', '#aaa');
					  $event.find('.time').css({'backgroundColor': '#999', 'border':'1px solid #888'});
					}
					
					<!--- This is an Appointment type. --->
					if(calEvent.title.indexOf('|') > -1){
			  			$event.css('backgroundColor', '#E68A8A');
			  			$event.css('z-index', '101');
			  			calEvent.title = calEvent.title.substring(1);
			  		} 
			  		else {
			  			$event.css('z-index', '100');
			  		}

				},
				

				eventNew : function(calEvent, $event) {
						 currentCalEvent = calEvent;
						 clearRecurrenceControls();
						 var $dialogContent = $("#event_edit_container");
						 resetForm($dialogContent);
						 var startField = $dialogContent.find("select[name='start']").val(calEvent.start);
						 var endField = $dialogContent.find("select[name='end']").val(calEvent.end);
						 var titleField = 'Available';//$dialogContent.find("input[name='title']");
						 //var bodyField = $dialogContent.find("textarea[name='body']");
				
						 $dialogContent.dialog({
							modal: true,
							title: "Add Availability Block",
							close: function() {
							   $dialogContent.dialog("destroy");
							   $dialogContent.hide();
							   $('#calendar').weekCalendar("removeUnsavedEvents");
							},
							buttons: {
							   save : function() {
								  calEvent.id = id;
								  id++;
								  calEvent.start = new Date(startField.val());
								  calEvent.end = new Date(endField.val());
								  console.log(calEvent.start);
								  console.log(calEvent.end);
								  calEvent.title = 'Available';
								  //titleField.val();
								  //calEvent.body = bodyField.val();
								 // var start = (calEvent.start.getMonth() + 1) + '/' + calEvent.start.getDate() + '/' +  calEvent.start.getFullYear();
								  addAvailability(calEvent.id, calEvent.start, calEvent.end);
									
								  $calendar.weekCalendar("removeUnsavedEvents");
								  $calendar.weekCalendar("updateEvent", calEvent);
								  $dialogContent.dialog("close");
							   },
							   cancel : function() {
								  $dialogContent.dialog("close");
							   }
							}
						 }).show();
				
						 $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
						 setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));
					  },				
				
				draggable : function(calEvent, $event) {
						 return false;
				}, 
				
				resizable : function(calEvent, $event) {
						 return false;
				}, 
				
				eventClick : function(calEvent, $event) {
				  	//Show different dialog for Appointments
				  	if(calEvent.title != 'Available'){

				  		var $dialogAppointment = $("#dialog-appointment");
				  		
				  		$("#apptDate").val($("#calendar").weekCalendar("formatDate", calEvent.start, "m/d/Y"));
				  		
				  		$("#apptStartTime").empty();
				  		$("#apptStartTime").append(timeSelectOptionsStart);
				  		$("#apptStartTime").val($("#calendar").weekCalendar("formatTime", calEvent.start, "h:i A"));
		
				  		$("#apptEndTime").empty();
				  		$("#apptEndTime").append(timeSelectOptionsEnd);			
				  		$("#apptEndTime").val($("#calendar").weekCalendar("formatTime", calEvent.end, "h:i A"));
			
						$("#apptStartTime").focus();
						
						$dialogAppointment.dialog({
							height: 400,
							width: 350,
							modal: true,
							title: calEvent.title,
							buttons: {
								Save: function() {
									changeAppointment(calEvent.id, $("#apptDate").val(), $("#apptStartTime").val(), $("#apptEndTime").val());
									$calendar.weekCalendar("removeEvent", calEvent.id);
									
									$( this ).dialog( "close" );
									$dialogAppointment.dialog("close");
								},
								
								"Delete" : function() {
									deleteAppointment(calEvent.id);
									$calendar.weekCalendar("removeEvent", calEvent.id);
									$( this ).dialog( "close" );
									$dialogAppointment.dialog("close");
						   		},
						   		
								Cancel : function() {
									$dialogAppointment.dialog("close");
								}
							}
						}).show();
			
			
	
				  		
				  		
				  		
				  		
				  		
				  		return;
				  	} 
				  	
					currentCalEvent = calEvent;
					 if (calEvent.readOnly) {
						return;
					 }
					
					 var $dialogContent = $("#event_edit_container");
					 resetForm($dialogContent);
					 
					 var startField = $dialogContent.find("select[name='start']").val(calEvent.start);
					 var endField = $dialogContent.find("select[name='end']").val(calEvent.end);
					 var titleField = 'Available';
					 //$dialogContent.find("input[name='title']").val(calEvent.title);
					 //var bodyField = $dialogContent.find("textarea[name='body']");
					 //bodyField.val(calEvent.body);

					 $dialogContent.dialog({
						modal: true,
						title: "Edit - " + calEvent.title,
						close: function() {
						   $dialogContent.dialog("destroy");
						   $dialogContent.hide();
						   $('#calendar').weekCalendar("removeUnsavedEvents");
						},
						buttons: {
							
						   save : function() {
								currentID = calEvent.id;
								id++;
								newID = id;
								calEvent.id = newID;
							    calEvent.start = new Date(startField.val());
								calEvent.end = new Date(endField.val()); 
							  	saveAvailability(currentID, newID, calEvent.start, calEvent.end);
							  	$calendar.weekCalendar("updateEvent", calEvent);
							  	$dialogContent.dialog("close");
						   },
						   "delete" : function() {
								if($('#recurrenceType').val() == RECURRENCE_TYPE_NONE){
									removeAvailability(currentCalEvent.id, currentCalEvent.start, 0);
									$calendar.weekCalendar("removeEvent", currentCalEvent.id);
									$( this ).dialog( "close" );					
								}else{
									$( "#dialog-form" ).dialog( "open" );
								}
						   },
						   cancel : function() {
							  $dialogContent.dialog("close");
						   }
						}
					 }).show();
			
					 var startField = $dialogContent.find("select[name='start']").val(calEvent.start);
					 var endField = $dialogContent.find("select[name='end']").val(calEvent.end);
					 $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
					 setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));
					 $(window).resize().resize(); //fixes a bug in modal overlay size ??
					 loadEventRecurControls(calEvent.id);
			
				  },				
			  			  
			});
		  });
  	
	
	   /* Sets up the start and end time fields in the calendar event form for editing based on the calendar event being edited */
	   function setupStartAndEndTimeFields($startTimeField, $endTimeField, calEvent, timeslotTimes) {
		  $startTimeField.empty();
		  $endTimeField.empty();
	
		  for (var i = 0; i < timeslotTimes.length; i++) {
			 var startTime = timeslotTimes[i].start;
			 var endTime = timeslotTimes[i].end;
			 var startSelected = "";
			 if (startTime.getTime() === calEvent.start.getTime()) {
				startSelected = "selected=\"selected\"";
			 }
			 var endSelected = "";
			 if (endTime.getTime() === calEvent.end.getTime()) {
				endSelected = "selected=\"selected\"";
			 }
			 $startTimeField.append("<option value=\"" + startTime + "\" " + startSelected + ">" + timeslotTimes[i].startFormatted + "</option>");
			 $endTimeField.append("<option value=\"" + endTime + "\" " + endSelected + ">" + timeslotTimes[i].endFormatted + "</option>");
	
			 $timestampsOfOptions.start[timeslotTimes[i].startFormatted] = startTime.getTime();
			 $timestampsOfOptions.end[timeslotTimes[i].endFormatted] = endTime.getTime();
	
		  }
		  $endTimeOptions = $endTimeField.find("option");
		  $startTimeField.trigger("change");
	   }
	
	   var $endTimeField = $("select[name='end']");
	   var $endTimeOptions = $endTimeField.find("option");
	   var $timestampsOfOptions = {start:[],end:[]};

	   //reduces the end time options to be only after the start time options.
	   $("select[name='start']").change(function() {
		  var startTime = $timestampsOfOptions.start[$(this).find(":selected").text()];
		  var currentEndTime = $endTimeField.find("option:selected").val();
		  $endTimeField.html(
				$endTimeOptions.filter(function() {
				   return startTime < $timestampsOfOptions.end[$(this).text()];
				})
				);
	
		  var endTimeSelected = false;
		  $endTimeField.find("option").each(function() {
			 if ($(this).val() === currentEndTime) {
				$(this).attr("selected", "selected");
				endTimeSelected = true;
				return false;
			 }
		  });
	
		  if (!endTimeSelected) {
			 //automatically select an end date 2 slots away.
			 $endTimeField.find("option:eq(1)").attr("selected", "selected");
		  }
	
	   });	
	   

	$(function() {
		$( "#datepicker" ).datepicker();
	});
	
	
	toggleAppointments = function(blnShow){
		if(!blnShow){
			var objData = $('#calendar').data();
			var arrEvents = $('#calendar').data().weekCalendar.serializeEvents();
			for(var i=0; i < arrEvents.length;i++){
				if(arrEvents[i].title != 'Available'){ 
					$("#calendar").weekCalendar("removeEvent", arrEvents[i].id);
				}
			}	
			$('#checkLabel').text('Show Appointments');
		}else{
			$('#checkLabel').text('Hide Appointments');
			$("#calendar").weekCalendar("refresh"); 
		}
	}
	
	</script>
</head>
<body>
	<div align="center"><input type="checkbox" id="check" onchange="toggleAppointments(this.checked)" checked="true" /><label for="check" id="checkLabel">Hide Appointments</label></div>
	<div id="calendar"></div>
	<div id="event_edit_container">
		<form>
			<input type="hidden" />
			<ul>
				<li>
					<span>Date: </span><span class="date_holder"></span> 
				</li>
				<li>
					<label for="start">Start Time: </label><select name="start"><option value="">Select Start Time</option></select>
				</li>
				<li>
					<label for="end">End Time: </label><select name="end"><option value="">Select End Time</option></select>
				</li>
                <li>
                	<label for="recurrenceType">Recurrence Type: </label>
                    <select name="recurrenceType" id="recurrenceType" onChange="recurrentTypeChange(this.value);">
                        <option value="0" selected="selected">None</option>
                        <option value="1">Daily Every Day(s)</option>
                        <option value="2">Daily Every Weekday</option>
                        <option value="3">Weekly</option>
                        <option value="4">Monthly Day of Month(s)</option>
                        <option value="5">Monthly Day of Week</option>
                        <option value="6">Yearly Day of Month</option>
                        <option value="7">Yearly Day of Week</option>            
                    </select><br /><br />
                </li>
                <!--- RECURRENCE_TYPE_DAILY_DAYS --->
                <li id="DailyEveryDaysView"> 
                	Repeat Every <select name="dailyEveryDays" id="dailyEveryDays" style="width: 50px;">
                    <option value="1" selected>1</option>
                    <cfloop index="i" from="2" to="30">
                    <cfoutput>
						<option value="#i#">#i#test</option>
					</cfoutput>
                    </cfloop>        
                    </select> day(s)
                </li>
                <!--- RECURRENCE_TYPE_DAILY_WEEKDAYS --->
                <li id="DailyEveryWeekdayView">
                	Repeat Every Weekday
                </li>
          
                <!--- RECURRENCE_TYPE_WEEKLY --->
                <li id="WeeklyView">
                	Repeat every  
					<select name="weeklyEveryWeeks" id="weeklyEveryWeeks" style="width: 50px;">
                    <cfloop index="i" from="1" to="30">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select> week(s) on <br />
                    <input type="checkbox" name="chkSunday" id="chkSunday" value="1" /> Sun &nbsp;
                    <input type="checkbox" name="chkMonday"  id="chkMonday" value="2" /> Mon &nbsp;
                    <input type="checkbox" name="chkTuesday"  id="chkTuesday" value="3" /> Tue &nbsp;
                    <input type="checkbox" name="chkWednesday"  id="chkWednesday" value="4" /> Wed<br />
                    <input type="checkbox" name="chkThursday"  id="chkThursday" value="5" /> Thu &nbsp;
                    <input type="checkbox" name="chkFriday"  id="chkFriday" value="6" /> Fri &nbsp;
                    <input type="checkbox" name="chkSaturday"  id="chkSaturday" value="7" /> Sat &nbsp;
                </li>                
                <!--- RECURRENCE_TYPE_MONTHLY_DATE  --->
                <li id="MonthlyDateView">
                	Day 
                    <select name="monthlyDay" id="monthlyDay" style="width: 50px;">
                    <cfloop index="i" from="1" to="31">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select>
                     of every 
                    <select name="monthlyEveryMonth" id="monthlyEveryMonth" style="width: 50px;">
                    <cfloop index="i" from="1" to="30">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select>  month(s)                   
                </li>   

                                 
                <!--- RECURRENCE_TYPE_MONTHLY_WEEK  --->
                <li id="MonthlyWeekView">
                	The 
                    <select name="monthlyOrdinalType" id="monthlyOrdinalType" style="width: 100px;">
						<option value="1">first</option>
                        <option value="2">second</option>
                        <option value="3">third</option>
                        <option value="4">fourth</option>
                        <option value="5">last</option>
                    </select>
          
                    <select name="monthlyWeeklyType" id="monthlyWeeklyType" style="width: 100px;">
						<option value="1">day</option>
                        <option value="2">weekday</option>
                        <option value="3">weekend day</option>
                        <option value="4">Sunday</option>
                        <option value="5">Monday</option>
                        <option value="6">Tuesday</option>
                        <option value="7">Wednesday</option>
                        <option value="8">Thursday</option>
                        <option value="9">Friday</option>
                        <option value="10">Saturday</option>
                    </select><br />
                    of every 
                    <select name="monthlyWeekEveryMonth" id="monthlyWeekEveryMonth" style="width: 50px;">
                    <cfloop index="i" from="1" to="30">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select> month(s)
                </li>                
                <!--- RECURRENCE_TYPE_YEARLY_DATE  --->
                <li id="YearlyDateView">
                	Every 
                    <select name="yearlyEveryMonth" id="yearlyEveryMonth" style="width: 100px;">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                    <select name="yearlyDay" id="yearlyDay" style="width: 50px;">
                    <cfloop index="i" from="1" to="31">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select>
                </li>              
				  
                <!--- RECURRENCE_TYPE_YEARLY_MONTH   --->              
                <li id="YearlyMonthView">
                	The
                    <select name="yearlyOrdinalType" id="yearlyOrdinalType" style="width: 100px;">
						<option value="1">first</option>
                        <option value="2">second</option>
                        <option value="3">third</option>
                        <option value="4">fourth</option>
                        <option value="5">last</option>
                    </select>
                    <select name="yearlWeeklyType" id="yearlWeeklyType" style="width: 100px;">
						<option value="1">day</option>
                        <option value="2">weekday</option>
                        <option value="3">weekend day</option>
                        <option value="4">Sunday</option>
                        <option value="5">Monday</option>
                        <option value="6">Tuesday</option>
                        <option value="7">Wednesday</option>
                        <option value="8">Thursday</option>
                        <option value="9">Friday</option>
                        <option value="10">Saturday</option>
                    </select><br />
                    of
                    <select name="yearlyOfMonth" id="yearlyOfMonth" style="width: 100px;">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                </li>                
                <li id="EndView">
                	<label for="recurrence_range_type">Ends: </label>
                	<input type="radio" name="recurrence_range_type" id="recurrence_range_type1" value="1" onClick="recurrenceRangeType = 1;" checked="checked" /> Never <br /> <br />
                    <input type="radio" name="recurrence_range_type" id="recurrence_range_type2" value="2" onClick="recurrenceRangeType = 2;" /> After 
                    
                    <select name="endAfterOccur" id="endAfterOccur" style="width: 50px;">
                    <cfloop index="i" from="1" to="365">
                    <cfoutput>
						<option value="#i#">#i#</option>
					</cfoutput>
                    </cfloop> 
                    </select> occurrences<br /> <br />
                    <input type="radio" name="recurrence_range_type" id="recurrence_range_type3" value="3" onClick="recurrenceRangeType = 3;" /> On 
                    	<input id="datepicker" name="datepicker" type="text" style="width: 100px;"><br />
                </li>               
			</ul>
		</form>
	</div>
    
    
    <div id="dialog-form" title="Delete Recurring Item">
        <p class="validateTips">This is a recurring entry.  Do you want to delete only this occurence or the series?</p>
    	<br />
        <form>
       
            <label for="recurrence_delete_type"></label>
                	<input type="radio" name="recurrence_delete_type" id="recurrence_delete_type1" value="1" onClick="recurrenceDeleteType = 1;" checked="checked" /> Delete this occurence.<br /><br /> 
                    <input type="radio" name="recurrence_delete_type" id="recurrence_delete_type2" value="2" onClick="recurrenceDeleteType = 2;" /> Delete the series. 
        </form>
    </div>
	
	
	<div id="dialog-appointment">
		<form>
				<div>
					<label for="apptStartTime" style="width: 100px;">Start Time: </label><br /><select id="apptStartTime" name="apptStartTime" style="width: 100px;"></select>
				</div>
				<br />
				<div>
					<label for="apptEndTime" style="width: 100px;">End Time: </label><br /><select id="apptEndTime" name="apptEndTime" style="width: 100px;"></select>
				</div>
				<br />
				<div>
					<label for="apptDate" style="width: 100px;">Date: </label><br /><input type="text" id="apptDate" style="width: 100px;" />
				</div>			
			
		</form>
	</div>

    <cfinclude template="footer.cfm" />
</body> 
</html>
