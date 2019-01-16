<cfset cfvariables.CALANDER_DAYS_SPAN = 7  />
<cfset cfvariables.RECURRENCE_TYPE_NONE = 0 />
<cfset cfvariables.RECURRENCE_TYPE_DAILY_DAYS = 1 />
<cfset cfvariables.RECURRENCE_TYPE_DAILY_WEEKDAYS = 2 />
<cfset cfvariables.RECURRENCE_TYPE_WEEKLY = 3 />
<cfset cfvariables.RECURRENCE_TYPE_MONTHLY_DATE = 4 />
<cfset cfvariables.RECURRENCE_TYPE_MONTHLY_WEEK = 5 />
<cfset cfvariables.RECURRENCE_TYPE_YEARLY_DATE = 6 />
<cfset cfvariables.RECURRENCE_TYPE_YEARLY_MONTH = 7 />

<cfset cfvariables.RECURRENCE_RANGE_TYPE_NO_END_DATE = 1 />
<cfset cfvariables.RECURRENCE_RANGE_TYPE_END_AFTER_OCCURRENCES = 2 />
<cfset cfvariables.RECURRENCE_RANGE_TYPE_END_BY_DATE = 3 />

<cfset cfvariables.RECURRENCE_ORDINAL_TYPE_FIRST = 1 />
<cfset cfvariables.RECURRENCE_ORDINAL_TYPE_SECOND = 2 />
<cfset cfvariables.RECURRENCE_ORDINAL_TYPE_THIRD = 3 />
<cfset cfvariables.RECURRENCE_ORDINAL_TYPE_FOURTH = 4 />
<cfset cfvariables.RECURRENCE_ORDINAL_TYPE_LAST = 5 />

<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_DAY = 1 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_WEEKDAY = 2 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_WEEKEND_DAY = 3 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_SUNDAY = 4 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_MONDAY = 5 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_TUESDAY = 6 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_WEDNESDAY = 7 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_THURSDAY = 8 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_FRIDAY = 9 />
<cfset cfvariables.RECURRENCE_WEEKDAY_INTERVAL_SATURDAY = 10 />

<cfset cfvariables.RECURRENCE_DELETE_TYPE_NONE = 0 />
<cfset cfvariables.RECURRENCE_DELETE_TYPE_SINGLE = 1 />
<cfset cfvariables.RECURRENCE_DELETE_TYPE_SERIES = 2 />
    
<cfset cfvariables.WEEKDAY_SUNDAY = 1 />
<cfset cfvariables.WEEKDAY_MONDAY = 2 />
<cfset cfvariables.WEEKDAY_TUESDAY = 3 />
<cfset cfvariables.WEEKDAY_WEDNESDAY = 4 />
<cfset cfvariables.WEEKDAY_THURSDAY = 5 />
<cfset cfvariables.WEEKDAY_FRIDAY = 6 />
<cfset cfvariables.WEEKDAY_SATURDAY = 7 />

<cfset cfvariables.change_appoinment_id = 1 />
	
<cfif structKeyExists(url, 'StartWeekDate')>
	<cfset cfvariables.StartWeekDate = DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", url.StartWeekDate), "mm/dd/yyyy") />
<cfelse>
	<cfset cfvariables.StartWeekDate = DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now()), "mm/dd/yyyy") />
</cfif>

<cfset cfvariables.EndWeekDate = DateFormat(DateAdd("d", cfvariables.CALANDER_DAYS_SPAN, cfvariables.StartWeekDate ), "mm/dd/yyyy") />
<cfset calendarObj= createObject("component","appointmentsCalendarBean") /> 
<cfset cfvariables.NextAvailabilityEventID = calendarObj.getProfessionalAvailabilityMaxID(Session.Professional_ID)+1 />

<cfset variables.qGetCustomersList  = calendarObj.getCustomersListBy(company_id = Session.company_id)>
<cfset variables.qGetProfessionalService  = calendarObj.getProfessionalServices(Location_ID = Session.location_id, Professional_ID = 0, noCache = now().getTime())>

<cfajaxproxy cfc="admin.appointmentsCalendarBean" jsclassname="calendarAjax" />
<script>
<cfwddx action="cfml2js" input="#Session.Professional_ID#" toplevelvariable="Professional_ID">
<cfwddx action="cfml2js" input="#Session.location_id#" toplevelvariable="location_id">
<cfwddx action="cfml2js" input="#Session.company_id#" toplevelvariable="company_id">
<cfwddx action="cfml2js" input="#cfvariables#" toplevelvariable="cfvariables">
</script>
<!-- basic styles -->

<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

<!--[if IE 7]>
  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
<![endif]-->

<!-- page specific plugin styles -->

<link rel="stylesheet" href="assets/css/fullcalendar.css" />

<!-- fonts -->

<link rel="stylesheet" href="assets/css/ace-fonts.css" />

<!-- ace styles -->

<link rel="stylesheet" href="assets/css/ace.min.css" />
<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="assets/css/ace-skins.min.css" />

<!--[if lte IE 8]>
  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="assets/js/ace-extra.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="assets/js/html5shiv.js"></script>
<script src="assets/js/respond.min.js"></script>
<![endif]-->

<!--- 
<div class="page-header">
	<h1>
		Full Calendar
		<small>
			<i class="icon-double-angle-right"></i>
			with draggable and editable events
		</small>
	</h1>
</div><!-- /.page-header -->
 --->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->

		<div class="row">
			<div class="col-sm-11">
				<div class="space"></div>

				<div id="calendar"></div>
			</div>
			<!---
			<div class="col-sm-2">
				<div class="widget-box transparent">
					<div class="widget-header">
						<h4>Draggable events</h4>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding">
							<div id="external-events">
								<div class="external-event label-grey" data-class="label-grey">
									<i class="icon-move"></i>
									My Event 1
								</div>

								<div class="external-event label-success" data-class="label-success">
									<i class="icon-move"></i>
									My Event 2
								</div>

								<div class="external-event label-danger" data-class="label-danger">
									<i class="icon-move"></i>
									My Event 3
								</div>

								<div class="external-event label-purple" data-class="label-purple">
									<i class="icon-move"></i>
									My Event 4
								</div>

								<div class="external-event label-yellow" data-class="label-yellow">
									<i class="icon-move"></i>
									My Event 5
								</div>

								<div class="external-event label-pink" data-class="label-pink">
									<i class="icon-move"></i>
									My Event 6
								</div>

								<div class="external-event label-info" data-class="label-info">
									<i class="icon-move"></i>
									My Event 7
								</div>

								<label>
									<input type="checkbox" class="ace ace-checkbox" id="drop-remove" />
									<span class="lbl"> Remove after drop</span>
								</label>
							</div>
						</div>
					</div>
				</div>
			</div>--->
		</div>
		<style>
			form ul {	padding: 0.3em;margin:0;list-style:none;}
			form ul li { display:block;}
			label {
				display: block;
				margin-top: 1em;
				margin-bottom: 0.5em;
			}
			select, input[type='text'],input[type='email'],input[type='password'], textarea {
				width: 100%;
				padding: 3px;
			}
			.viewTypeRadio {
				display: inline-block;
				width: 46%;
			}
			.error {
				border: solid 1px #ff0000 !important;
			}
		</style>
		<div id="addCustomerWrap" class="hide">
			<form method="post" id="customer_edit_form">
				<ul>
					<li>
						<label for="customerFirstName">First Name: </label>
						<input type="text" name="customerFirstName" id="customerFirstName" class="required" value="">
					</li>
					<li>
						<label for="customerLastName">Last Name: </label>
						<input type="text" name="customerLastName" id="customerLastName" class="required" value="">
					</li>
					<li>
						<label for="customerMobile">Mobile Phone: </label>
						<input type="text" name="customerMobile" id="customerMobile" value="">
					</li>
					<li>
						<label for="customerPhone">Home Phone: </label>
						<input type="text" name="customerPhone" id="customerPhone" value="">
					</li>
					<li>
						<label for="customerEmail">Email: </label>
						<input type="text" name="customerEmail" id="customerEmail" class="required" value="">
					</li>
					<li>
						<label for="customerPassword">Password: </label>
						<input type="password" name="customerPassword" id="customerPassword" value="" autocomplete>
					</li>
					<p>
						<div id="customerValidateError" class="col-md-12 alert alert-danger" style="display:none;">
							Missing required fields!
						</div>
					</p>
				</ul>
			</form>
		</div>
		<div id="event_edit_container" class="hide">
			<form>
				<input type="hidden" />
				<ul class="availableCheckWrap">
					<li>
						<span class="viewTypeRadio"><input type="radio" name="viewtype" value="Appointment" id="AppointmentView" class="clickToShow" checked="checked"><span>Appointment</span></span>
						<span class="viewTypeRadio"><input type="radio" name="viewtype" value="Available" id="AvailableView" class="clickToShow"><span>Availability</span></span>
					</li>
				</ul>
				<ul class="appointmentWrap" id="appointmentWrap">
					<li>
						<label for="Name">Customer: <a href="javascript:void(0);" style="float:right;" id="quickCustomerAdd" onclick="quickAddCustomer()"><span>Add Customer</span></a></label>
						<select name="name" id="selCustomers">
							<option value="0">Select Customers</option>
							<cfoutput>
								<cfif variables.qGetCustomersList.recordcount>
									<cfloop query="variables.qGetCustomersList">
										<option value="#variables.qGetCustomersList.Customer_ID#">#variables.qGetCustomersList.First_Name# #variables.qGetCustomersList.Last_Name#</option>
									</cfloop>
								</cfif>
							</cfoutput>
						</select>
					</li>
					<li>
						<label for="Service">Services: </label>
						<select name="service" id="selService">
							<option value="0">Select Service</option>
							<cfoutput>
								<cfif variables.qGetProfessionalService.recordcount>
									<cfloop query="variables.qGetProfessionalService">
										<option value="#variables.qGetProfessionalService.Service_ID#">#variables.qGetProfessionalService.Service_Name#</option>
									</cfloop>
								</cfif>
							</cfoutput>
						</select>
					</li>
				</ul>
				<ul class="availabilityWrap" id="availabilityWrap">
					<!---<li>
						<span>Date: </span><span class="date_holder"></span> 
					</li>--->
					<li>
						<label for="start">Start Time: </label>
						<select name="start" id="EventCal_start">
							<option value="06:00:00">6:00 am</option>
							<option value="06:30:00">6:30 am</option>
							<option value="07:00:00">7:00 am</option>
							<option value="07:30:00">7:30 am</option>
							<option value="08:00:00">8:00 am</option>
							<option value="08:30:00">8:30 am</option>
							<option value="09:00:00">9:00 am</option>
							<option value="09:30:00">9:30 am</option>
							<option value="10:00:00">10:00 am</option>
							<option value="10:30:00">10:30 am</option>
							<option value="11:00:00">11:00 am</option>
							<option value="11:30:00">11:30 am</option>
							<option value="12:00:00">12:00 pm</option>
							<option value="12:30:00">12:30 pm</option>
							<option value="13:00:00">1:00 pm</option>
							<option value="13:30:00">1:30 pm</option>
							<option value="14:00:00">2:00 pm</option>
							<option value="14:30:00">2:30 pm</option>
							<option value="15:00:00">3:00 pm</option>
							<option value="15:30:00">3:30 pm</option>
							<option value="16:00:00">4:00 pm</option>
							<option value="16:30:00">4:30 pm</option>
							<option value="17:00:00">5:00 pm</option>
							<option value="17:30:00">5:30 pm</option>
							<option value="18:00:00">6:00 pm</option>
							<option value="18:30:00">6:30 pm</option>
							<option value="19:00:00">7:00 pm</option>
							<option value="19:30:00">7:30 pm</option>
							<option value="20:00:00">8:00 pm</option>
							<option value="20:30:00">8:30 pm</option>
							<option value="21:00:00">9:00 pm</option>
							<option value="21:30:00">9:30 pm</option>
						</select>
					</li>
					<li>
						<label for="end">End Time: </label>
						<select name="end" id="EventCal_end">
							<option value="06:30:00">6:30 am</option>
							<option value="07:00:00">7:00 am</option>
							<option value="07:30:00">7:30 am</option>
							<option value="08:00:00">8:00 am</option>
							<option value="08:30:00">8:30 am</option>
							<option value="09:00:00">9:00 am</option>
							<option value="09:30:00">9:30 am</option>
							<option value="10:00:00">10:00 am</option>
							<option value="10:30:00">10:30 am</option>
							<option value="11:00:00">11:00 am</option>
							<option value="11:30:00">11:30 am</option>
							<option value="12:00:00">12:00 pm</option>
							<option value="12:30:00">12:30 pm</option>
							<option value="13:00:00">1:00 pm</option>
							<option value="13:30:00">1:30 pm</option>
							<option value="14:00:00">2:00 pm</option>
							<option value="14:30:00">2:30 pm</option>
							<option value="15:00:00">3:00 pm</option>
							<option value="15:30:00">3:30 pm</option>
							<option value="16:00:00">4:00 pm</option>
							<option value="16:30:00">4:30 pm</option>
							<option value="17:00:00">5:00 pm</option>
							<option value="17:30:00">5:30 pm</option>
							<option value="18:00:00">6:00 pm</option>
							<option value="18:30:00">6:30 pm</option>
							<option value="19:00:00">7:00 pm</option>
							<option value="19:30:00">7:30 pm</option>
							<option value="20:00:00">8:00 pm</option>
							<option value="20:30:00">8:30 pm</option>
							<option value="21:00:00">9:00 pm</option>
							<option value="21:30:00">9:30 pm</option>
							<option value="22:00:00">10:00 pm</option>
						</select>
					</li>
					<li style="display:none;">
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
                		<option value="1">1</option>
                    <cfloop index="i" from="2" to="30">
                    <cfoutput>
						<option value="#i#">#i#</option>
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
						<span>The </span>
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
						</select>
						<span>of every </span>
						<select name="monthlyWeekEveryMonth" id="monthlyWeekEveryMonth" style="width: 50px;">
						<cfloop index="i" from="1" to="30">
							<cfoutput>
								<option value="#i#">#i#</option>
							</cfoutput>
						</cfloop> 
						</select><span> month(s)</span>
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
			<form>		   
				<label for="recurrence_delete_type"></label>
				<input type="radio" name="recurrence_delete_type" id="recurrence_delete_type1" value="1" onClick="recurrenceDeleteType = 1;" checked="checked" /> Delete this occurence.<br /><br /> 
				<input type="radio" name="recurrence_delete_type" id="recurrence_delete_type2" value="2" onClick="recurrenceDeleteType = 2;" /> Delete the series. 
			</form>
		</div>
		<div id="dialog-update-form" title="Updating Recurring Item" style="display:none;">
			<p class="validateTips">This is a recurring entry.  Do you want to update only this occurence or the series?</p>
			<form>		   
				<label for="recurrence_update_type"></label>
				<input type="radio" name="recurrence_update_type" id="recurrence_update_type1" value="1" onClick="recurrenceUpdateType = 1;" checked="checked" /> Update this occurence.<br /><br /> 
				<input type="radio" name="recurrence_update_type" id="recurrence_update_type2" value="2" onClick="recurrenceUpdateType = 2;" /> Update the series. 
			</form>
		</div>
	</div><!-- /.col -->
</div><!-- /.row -->
<script type="text/javascript">
	window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>
<script type="text/javascript">
	if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>

<!-- page specific plugin scripts -->
<script src="assets/js/fullcalendar.min.js"></script>

<!-- inline scripts related to this page -->
<script>
/* Sets up the start and end time fields in the calendar event form for editing based on the calendar event being edited */
var $endTimeField = $("select[name='end']");
var $endTimeOptions = $endTimeField.find("option");
var $timestampsOfOptions = {start:[],end:[]};

</script>
<script type="text/javascript">
//jQuery(function($) {

	$( "#datepicker" ).datepicker({
		defaultDate: '-2m',
		changeYear: true, 
		changeMonth: true
	});
	
	$(".clickToShow").click(function() {
		$(".clickToShow").removeAttr("checked");
		if($(this).val() == "Appointment") {
			$('#AppointmentView').attr("checked","checked");
			$(".appointmentWrap").css("display","block");
			$('#recurrenceType').parent().hide();
			clearRecurrenceControls();
			$('#recurrenceType').val(0);
			//$('#EventCal_start').find('option').removeAttr("selected");
			//$('#EventCal_start').find('option[value="06:00:00"]').attr("selected",true);
			//$('#EventCal_end').find('option').removeAttr("selected");
			//$('#EventCal_end').find('option[value="06:30:00"]').attr("selected",true);
			$('#selCustomers').val(0);
			$('#selService').val(0);
		} else {
			$('#AvailableView').prop("checked","checked");
			$(".appointmentWrap").css("display","none");
			$('#recurrenceType').parent().show();
			clearRecurrenceControls();
			$('#recurrenceType').val(0);
			//$('#EventCal_start').find('option').removeAttr("selected");
			//$('#EventCal_start').find('option[value="06:00:00"]').attr("selected",true);
			//$('#EventCal_end').find('option').removeAttr("selected");
			//$('#EventCal_end').find('option[value="06:30:00"]').attr("selected",true);
		}
	});
	
	/* initialize the external events
	-----------------------------------------------------------------*/
	$('#external-events div.external-event').each(function() {

		// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
		// it doesn't need to have a start or end
		var eventObject = {
			title: $.trim($(this).text()) // use the element's text as the event title
		};

		// store the Event Object in the DOM element so we can get to it later
		$(this).data('eventObject', eventObject);

		// make the event draggable using jQuery UI
		$(this).draggable({
			zIndex: 999,
			revert: true,      // will cause the event to go back to its
			revertDuration: 0  //  original position after the drag
		});
		
	});
	
	function showHideDialogControls(startDate) {
		$('#EventCal_start').find('option').removeAttr("selected");
		$('#EventCal_end').find('option').removeAttr("selected");
		$('#EventCal_start').find('option[value="06:00:00"]').prop("selected",true);
		$('#EventCal_end').find('option[value="06:30:00"]').prop("selected",true);
		$('#AppointmentView').prop("checked","checked");
		$("#event_edit_container").find('.availableCheckWrap').show();
		var title = $(".clickToShow:checked").val();
		if(title == 'Appointment') {
			$('#appointmentWrap').show();
			$('#recurrenceType').parent().hide();
		} else {
			$('#appointmentWrap').hide();
			$('#recurrenceType').parent().show();
		}
	}
			
	/* initialize the calendar
	-----------------------------------------------------------------*/	
	var currentCalEvent;
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
			
	var calendar = $('#calendar').fullCalendar({
		firstDay: 0,
		slotMinutes: 30,
		minTime: 7,
		maxTime: 22,
		timeslotsPerHour: 4,
		buttonText: {
			prev: '<i class="icon-chevron-left"></i>',
			next: '<i class="icon-chevron-right"></i>'
		},
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		allDayDefault:false,
		events: function(start, end, callback) {
			$.getJSON("calendarEventJSON.cfm", {
				ID: Professional_ID, 
				StartDate: (start.getMonth() + 1) + '/' + start.getDate() + '/' + start.getFullYear(),
				EndDate: (end.getMonth() + 1) + '/' + end.getDate() + '/' + end.getFullYear(),
				DaySpan: cfvariables.calander_days_span,
				noCache: new Date().getTime()
			},  function(result) {
				callback(result);
			});
		}
		,
		eventRender : function(calEvent, $event) {							
			<!--- This is an Appointment type. --->
			if(calEvent.title != 'Availability'){
				$event.css('background-color', 'rgb(235, 126, 126)');
				$event.find('.fc-event-time').css({'background-color':'rgb(226, 109, 109)','border':'solid 1px rgb(226, 109, 109)'});
				$event.css('z-index', '101');
				calEvent.title = calEvent.title.substring(1);
			} 
			else {
				$event.find('.fc-event-time').css({'background-color':'rgb(40, 127, 177)','border':'solid 1px rgb(40, 127, 177)'});
				$event.css('z-index', '100');
			}
			if (calEvent.end.getTime() < new Date().getTime()) {
				if(calEvent.title != 'Availability'){
					$event.css('background-color', 'rgb(243, 165, 165)');
					$event.find('.fc-event-time').css({'background-color':'rgb(238, 142, 142)','border':'solid 1px rgb(238, 142, 142)'});
				} else {
					$event.css('background-color', '#89C0DB');
					$event.find('.fc-event-time').css({'background-color':'rgb(109, 172, 209)','border':'solid 1px rgb(109, 172, 209)'});
				}
			}

		},
		editable: true,
		droppable: true, // this allows things to be dropped onto the calendar !!!
		drop: function(date, allDay) { // this function is called when something is dropped
		
			// retrieve the dropped element's stored Event Object
			var originalEventObject = $(this).data('eventObject');
			var $extraEventClass = $(this).attr('data-class');
			
			// we need to copy it, so that multiple events don't have a reference to the same object
			var copiedEventObject = $.extend({}, originalEventObject);
			
			// assign it the date that was reported
			copiedEventObject.start = date;
			copiedEventObject.allDay = allDay;
			if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];
			
			// render the event on the calendar
			// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
			$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
			
			// is the "remove after drop" checkbox checked?
			if ($('#drop-remove').is(':checked')) {
				// if so, remove the element from the "Draggable Events" list
				$(this).remove();
			}
			
		}
		,
		selectable: true,
		selectHelper: true,
		select: function(start,end,allDay,jsEvent, view) {
			currentCalEvent = new Object();
			currentCalEvent.start = start;
			clearRecurrenceControls();
			showHideDialogControls(start);
			var $dialogContent = $("#event_edit_container");
			var $form = $dialogContent.find('form');			
			resetForm($dialogContent);	
			$dialogContent.removeClass('hide').dialog({
				modal: true,
				width:450,
				close: function(event, ui) 
				{ 
					$dialogContent.dialog("destroy");
					$dialogContent.hide();
				}, 
				buttons: [
					{
						text: "Cancel",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" );							
						} 
					}, 
					{
						text: "Save",
						"class" : "btn btn-primary btn-xs",
						"click": function() {
							start 	= new Date(start);
							end 	= new Date(end);							
							var startEventTime 	= $('#EventCal_start').find("option:selected").val();
							startEventTime 		= startEventTime.split(":");							
							start.setHours(startEventTime[0]);
							start.setMinutes(startEventTime[1]);
							start.setSeconds(startEventTime[2]);							
							var endEventTime 	= $('#EventCal_end').find("option:selected").val();
							endEventTime 		= endEventTime.split(":");
							end.setHours(endEventTime[0]);
							end.setMinutes(endEventTime[1]);
							end.setSeconds(endEventTime[2]);
							var title = $(".clickToShow:checked").val();
							console.log("arun");
							if(title == 'Available') {
								addAvailability(0,start, end);
							} else if(title == 'Appointment') {
								if($("#selCustomers").val() != 0 && $("#selService").val() != 0 ) {
									addAppointment(start,end);
								} else {
									alert("Please choose customer and service");
									return false;
								}
							}
							$( this ).dialog( "close" ); 
						}
					}					
				]
			});
			
			var startTime 	= twoDigitTime(start.getHours()) + ":" + twoDigitTime(start.getMinutes()) + ":" + twoDigitTime(start.getSeconds());
			var endTime 	= twoDigitTime(end.getHours()) + ":" + twoDigitTime(end.getMinutes()) + ":" + twoDigitTime(end.getSeconds());
			setupStartAndEndTimeFields(startTime,endTime);
			calendar.fullCalendar('unselect');
			
		}
		,
				
		eventClick: function(calEvent, jsEvent, view) {
			clearRecurrenceControls();
			var $dialogContent = $("#event_edit_container");
			var $form = $dialogContent.find('form');
			resetForm($dialogContent);
			$dialogContent.find('.availableCheckWrap').hide();
			if(calEvent.title == 'Availability'){
				var titleField = 'Availability';
			} else {
				var titleField = 'Appointment';
			}
			
			currentCalEvent = calEvent;
			if (calEvent.readOnly) {
				return;
			}
			
			$dialogContent.removeClass('hide').dialog({
				modal: true,
				width:400,
				title: "Edit - " + titleField,
				close: function(event, ui) 
				{ 
					$dialogContent.dialog("destroy");
					$dialogContent.hide();
				},
				buttons: [
					{
						text: "Cancel",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					}, 
					{
						text: "Update",
						"class" : "btn btn-primary btn-xs",
						"click": function() {
							var exceptionDate = calEvent.start;
							calEvent.start 	= new Date(calEvent.start);
							var startEventTime 	= $('#EventCal_start').find("option:selected").val();							
							startEventTime 		= startEventTime.split(":");							
							calEvent.start.setHours(startEventTime[0]);
							calEvent.start.setMinutes(startEventTime[1]);
							calEvent.start.setSeconds(startEventTime[2]);
							calEvent.end 	= new Date(calEvent.end);
							var endEventTime 	= $('#EventCal_end').find("option:selected").val();
							endEventTime 		= endEventTime.split(":");
							calEvent.end.setHours(endEventTime[0]);
							calEvent.end.setMinutes(endEventTime[1]);
							calEvent.end.setSeconds(endEventTime[2]);							
							if(calEvent.title == 'Availability'){
								saveAvailability(calEvent.id, calEvent.start, calEvent.end,recurrenceUpdateException,exceptionDate);
							} else {
								if($("#selCustomers").val() != 0 && $("#selService").val() != 0 ) {
									updateAppointment(calEvent.id,calEvent.start,calEvent.end);
									calendar.fullCalendar('updateEvent', calEvent);
									$( this ).dialog( "close" );
									return false;
								} else {
									alert("Please choose customer and service");
									return false;
								}
							}							
						}
					},
					{
						text: "Delete",
						"class" : "btn btn-danger btn-xs",
						"click": function() {
							if(calEvent.title == 'Availability'){
								if($('#recurrenceType').val() == cfvariables.recurrence_type_none){
									
									removeAvailability(calEvent.id, currentCalEvent.start, 0);
									calendar.fullCalendar("removeEvent", calEvent.id);
									 $( this ).dialog( "close" );
									// $( ".ui-dialog" ).css("display","none");
								} else {
									$("#event_edit_container").dialog("close");
									$( "#dialog-form" ).dialog( "open" );
									 $( this ).dialog( "close" );
								}
							} else {
								deleteAppointment(calEvent.id);
								calendar.fullCalendar("removeEvent", calEvent.id);
								$( this ).dialog( "close" );
							}							
						}
					}					
				]
			});
			var startTime 	= twoDigitTime(calEvent.start.getHours()) + ":" + twoDigitTime(calEvent.start.getMinutes()) + ":" + twoDigitTime(calEvent.start.getSeconds());
			var endTime 	= twoDigitTime(calEvent.end.getHours()) + ":" + twoDigitTime(calEvent.end.getMinutes()) + ":" + twoDigitTime(calEvent.end.getSeconds());
			setupStartAndEndTimeFields(startTime,endTime);
			// change the border color just for fun
			if(calEvent.title == 'Availability'){
				loadEventRecurControls(calEvent.id);
			} else {
				loadAppointmentRecurse(calEvent.id);
			}
			$(this).css('border-color', 'red');
		}
	});
	
	var updateAppointment = function(id, apptStartTime, apptEndTime){
		console.log(apptStartTime);
		console.log(apptEndTime);
		var customerId 	= $("#selCustomers").val();
		var ServiceID 	= $('#selService').val();
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackChangeAppointment); 
		e.setErrorHandler(myErrorHandler);
		apptStartTime = apptStartTime.getFullYear() + '-' + (apptStartTime.getMonth()+1) + '-' + apptStartTime.getDate() + ' ' + apptStartTime.getHours() + ':' + apptStartTime.getMinutes() + ':' + apptStartTime.getSeconds();
		apptEndTime = apptEndTime.getFullYear() + '-' + (apptEndTime.getMonth()+1) + '-' + apptEndTime.getDate() + ' ' + apptEndTime.getHours() + ':' + apptEndTime.getMinutes() + ':' + apptEndTime.getSeconds();
		e.updateAppointment(id, apptStartTime, apptEndTime, customerId, ServiceID, new Date().getTime());
	}
	
	var  callBackChangeAppointment = function(res){ 
		$("#calendar").fullCalendar("refetchEvents");
	}
	
	var deleteAppointment = function(id){
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackDeleteAppointment); 
		e.setErrorHandler(myErrorHandler); 
		e.deleteAppointment(id, new Date().getTime());
	}	  

	var  callBackDeleteAppointment = function(res){ 
        $("#calendar").fullCalendar("refetchEvents");
    } 
	
	var loadAppointmentRecurse = function(id) {
		var e = new calendarAjax();
		e.setSyncMode();
		e.setCallbackHandler(callBackLoadAppointment); 
		e.setErrorHandler(myErrorHandler); 
		e.getAppointmentDetails(Professional_ID, id);
	}
	
	var callBackLoadAppointment = function(result) {
		$(".appointmentWrap").css("display","block");
		$('#recurrenceType').parent().hide();
		$('#selCustomers').find("option[value='"+result.DATA[0][result.COLUMNS.findIdx('CUSTOMER_ID')]+"']").prop("selected",true);
		$('#selService').find("option[value='"+result.DATA[0][result.COLUMNS.findIdx('SERVICE_ID')]+"']").prop("selected",true);
	}
	
	var loadEventRecurControls = function(id){
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackLoadEventRecurControls); 
		e.setErrorHandler(myErrorHandler); 
		e.getEventDetails(Professional_ID, id);			
	}
	
	var callBackLoadEventRecurControls = function(res){

		$(".appointmentWrap").css("display","none");
		$('#recurrenceType').parent().show();
		
		var recurrenceTypeValue = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_TYPE_ID')].toString();
		recurrentTypeChange(recurrenceTypeValue);
		$('#recurrenceType').val(recurrenceTypeValue);
		recurrenceUpdateException = recurrenceTypeValue;
		if(recurrenceTypeValue > cfvariables.recurrence_type_none){
			recurrenceRangeType = res.DATA[0][res.COLUMNS.findIdx('RECURRENCE_RANGE_TYPE_ID')].toString();	
			document.getElementById('recurrence_range_type' + recurrenceRangeType).checked = true;
			
			switch(recurrenceTypeValue){
			
			case "1": //RECURRENCE_TYPE_DAILY_DAYS
					document.getElementById('dailyEveryDays').value = res.DATA[0][res.COLUMNS.findIdx('RECUR_COUNT_INTERVAL')];
					break;			
					
			case "3": //RECURRENCE_TYPE_WEEKLY
					var weekDays = res.DATA[0][res.COLUMNS.findIdx('WEEK_DAYS')];	
					weekDays = weekDays.toString();
					
					if(weekDays.indexOf(cfvariables.weekday_sunday.toString()) > -1) document.getElementById('chkSunday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_monday.toString()) > -1) document.getElementById('chkMonday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_tuesday.toString()) > -1) document.getElementById('chkTuesday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_wednesday.toString()) > -1) document.getElementById('chkWednesday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_thursday.toString()) > -1) document.getElementById('chkThursday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_friday.toString()) > -1) document.getElementById('chkFriday').checked = true;
					if(weekDays.indexOf(cfvariables.weekday_saturday.toString()) > -1) document.getElementById('chkSaturday').checked = true;
					
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
			if(recurrenceRangeType == cfvariables.recurrence_range_type_no_end_date){
				//Do nothing
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_after_occurrences){
				document.getElementById('endAfterOccur').value = res.DATA[0][res.COLUMNS.findIdx('END_AFTER_OCURRENCES')];
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_by_date){
				document.getElementById('datepicker').value = res.DATA[0][res.COLUMNS.findIdx('END_RECURRENCE_DATE')];
			}
		}
	} 			

	// Error handler for the asynchronous functions. 
	var myErrorHandler = function(statusCode, statusMsg) { 
		alert('Status: ' + statusCode + ', ' + statusMsg); 
	}
	
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

		 var ExceptionDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
		if(recurType == cfvariables.recurrence_type_none){
			type = 0;
		}
		var DeleteType = type;
		var AvailabilityID = id;
		e.removeAvailability(Professional_ID, AvailabilityID, DeleteType.toString(), ExceptionDate);
	}

	var newReplaceAvailability = function(id, startDate, endDate,type) {
		
		var recurrenceType = type;
		var endRecurrenceDate = '';
		var endAfterOcurrences = 0;
		var recurCountInterval = 0;
		//var typeValue = $('#recurrenceType').val();
		//var typeValue = "0";
       

		if(type > cfvariables.recurrence_type_none){
			//Prepare Range Types Data
			if(recurrenceRangeType == cfvariables.recurrence_range_type_no_end_date){
				//Do nothing
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_after_occurrences){
				endAfterOcurrences = $('#endAfterOccur').val();
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_by_date){
				endRecurrenceDate = $('#datepicker').val();
			}
		}
		var startDate = startDate.getFullYear() + '-' + (startDate.getMonth()+1) + '-' + startDate.getDate() + ' ' + startDate.getHours() + ':' + startDate.getMinutes() + ':' + startDate.getSeconds();
		var endDate = endDate.getFullYear() + '-' + (endDate.getMonth()+1) + '-' + endDate.getDate() + ' ' + endDate.getHours() + ':' + endDate.getMinutes() + ':' + endDate.getSeconds(); 

		var e = new calendarAjax(); 	
		e.setSyncMode();
		e.setCallbackHandler(callBackReplaceAvailability);
		e.setErrorHandler(myErrorHandler);  
		if(recurrenceType == 0) {
			e.updateAvailabilityTypeNone(Professional_ID,id,startDate,endDate);
		}
		if(type == 1) {
			var AvailabilityID = id;
			recurCountInterval = $('#dailyEveryDays').val()
			e.updateAvailabilityTypeDailyDays(Professional_ID,AvailabilityID.toString(),startDate,endDate,recurCountInterval.toString(),endRecurrenceDate,endAfterOcurrences,recurrenceRangeType);
		}
		if(type == 2) {
			var AvailabilityID = id;
			if(endRecurrenceDate.length) {
				endRecurrenceDate = endRecurrenceDate.toString();
			}
			e.updateAvailabilityTypeDailyWeekdays(Professional_ID,AvailabilityID.toString(),startDate,endDate,endRecurrenceDate,endAfterOcurrences,recurrenceRangeType);
		}
		if(type == 3) {
			var weekDays = "";
			if(document.getElementById('chkSunday').checked) weekDays += ",1";
			if(document.getElementById('chkMonday').checked) weekDays += ",2";
			if(document.getElementById('chkTuesday').checked) weekDays += ",3";
			if(document.getElementById('chkWednesday').checked) weekDays += ",4";
			if(document.getElementById('chkThursday').checked) weekDays += ",5";
			if(document.getElementById('chkFriday').checked) weekDays += ",6";
			if(document.getElementById('chkSaturday').checked) weekDays += ",7";
			weekDays = weekDays.substr(1,weekDays.length);
			var AvailabilityID = id;
			if(endRecurrenceDate.length)
			{
				var endRecurrenceDate = endRecurrenceDate.toString();
			}
			recurCountInterval = $('#weeklyEveryWeeks').val(); 
			e.updateAvailabilityTypeWeekly(Professional_ID, AvailabilityID.toString(), startDate, endDate, weekDays, 
						recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences.toString(), recurrenceRangeType);
		}
		if(type == 4) {
			
				var dayValue = $('#monthlyDay').val();
				recurCountInterval =$('#monthlyEveryMonth').val();
				var AvailabilityID = id;
				if(endRecurrenceDate.length)
				{
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				e.updateAvailabilityTypeMonthlyDate(Professional_ID, AvailabilityID.toString(), startDate, endDate, dayValue, 
						recurCountInterval, endRecurrenceDate, endAfterOcurrences.toString(), recurrenceRangeType);
		}
		if(type == 5) {
			recurCountInterval = $('#monthlyWeekEveryMonth').val();
			var recurrenceOrdinalIntervalID = $('#monthlyOrdinalType').val();
			var recurrenceWeekdayIntervalID = $('#monthlyWeeklyType').val();
			var AvailabilityID = id;
			if(endRecurrenceDate.length) {
				var endRecurrenceDate = endRecurrenceDate.toString();
			}
			e.updateAvailabilityTypeMonthlyWeek(Professional_ID, AvailabilityID.toString(), startDate, endDate, 
					recurrenceOrdinalIntervalID.toString(), recurrenceWeekdayIntervalID.toString(), recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
		}
		if(type == 6) {
			var dayValue = $('#yearlyDay').val();
			var yearlyMonth = $('#yearlyEveryMonth').val();
			var AvailabilityID = id;
			if(endRecurrenceDate.length) {
				var endRecurrenceDate = endRecurrenceDate.toString();
			}
			e.updateAvailabilityTypeYearlyDate(Professional_ID, AvailabilityID.toString(), startDate, endDate, 
				dayValue, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
		}
		if(type == 7) {
			var recurrenceOrdinalIntervalID = $('#yearlyOrdinalType').val();
			var recurrenceWeekdayIntervalID = $('#yearlWeeklyType').val();
			var yearlyMonth = $('#yearlyOfMonth').val();
			var AvailabilityID = id;
			if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
			}
			e.updateAvailabilityTypeYearlyMonth(Professional_ID, AvailabilityID.toString(), startDate, endDate, 
					recurrenceOrdinalIntervalID, recurrenceWeekdayIntervalID, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
		}
	}
			
	var replaceAvailability = function(id, startDate, endDate){ 
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackReplaceAvailability); 
		e.setErrorHandler(myErrorHandler);
		var startDate = startDate.getFullYear() + '-' + (startDate.getMonth()+1) + '-' + startDate.getDate() + ' ' + startDate.getHours() + ':' + startDate.getMinutes() + ':' + startDate.getSeconds();
		var endDate = endDate.getFullYear() + '-' + (endDate.getMonth()+1) + '-' + endDate.getDate() + ' ' + endDate.getHours() + ':' + endDate.getMinutes() + ':' + endDate.getSeconds(); 
		e.removeAvailability(Professional_ID, id, 0);
		//e.updateAvailabilityTypeNone(Professional_ID,id,startDate,endDate);
	}
	
	var callBackReplaceAvailability = function(res){ 
		//addAvailability(newID, sDate, eDate);
	}
	
	var saveAvailability = function(currentID, start, end, type, exceptionDate){
		var startDiff 	= new Date('"'+start.getFullYear()+'/'+start.getMonth()+'/'+start.getDate()+'"');
		var EndDiff 	= new Date('"'+end.getFullYear()+'/'+end.getMonth()+'/'+end.getDate()+'"');
		var dateDiff 	= EndDiff.getTime() - startDiff.getTime();
		StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
		// console.log(currentID);
		if( type == cfvariables.recurrence_type_none) {
			newReplaceAvailability(currentID, start, end,type);
			calendar.fullCalendar("updateEvent", currentCalEvent.id);
			$("#event_edit_container").dialog("close");
		} else {
			$("#event_edit_container").dialog("close");
			$( "#dialog-update-form" ).dialog({
				height: 250,
				width: 450,
				modal: true,
				buttons: [
					{
						text: "Cancel",
						"class" : "btn btn-xs",
						click: function() {
							$( this ).dialog( "close" ); 
						} 
					},
					{
						text: "Continue",
						"class" : "btn btn-primary btn-xs",
						click: function() {
							if( recurrenceUpdateType == 1 ) {
								updateRecurrenceAvailability(currentID, start, end, exceptionDate);
								calendar.fullCalendar("updateEvent", currentCalEvent.id);
								$( this ).dialog( "close" );
								$("#event_edit_container").dialog("close");
							} else {
								//replaceAvailability(currentID, start, end);
								newReplaceAvailability(currentID, start, end,type);
								calendar.fullCalendar("updateEvent", currentCalEvent.id);
								$( this ).dialog( "close" );
								$("#event_edit_container").dialog("close");
							}							
						}
					}
				]
			});
		}
	}
			
	function twoDigitTime(number) {
		return (number < 10 ? '0' : '') + number;
	}

	setupStartAndEndTimeFields = function(startTime, endTime) {		
		$("#EventCal_start").find("option").each(function(){
			if($(this).val() == startTime) {
				$(this).prop("selected","selected");
			}
		});
		var startIndex = $("#EventCal_start").find("option:selected").index();
		$("#EventCal_end").find("option").each(function(index){
			if($(this).val() == endTime) {
				$(this).prop("selected","selected");
			}
			if( index < startIndex) {
				$(this).prop("disabled",true);
			}
		});
		$endTimeOptions = $("#EventCal_end").find("option");
	}
		   
	var addAppointment 	= function(start,end) {
		var customerId 	= $("#selCustomers").val();
		var ServiceID 	= $('#selService').val();
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackAppointment); 
		e.setErrorHandler(myErrorHandler);
		var apptStartTime = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
		var apptEndTime = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
		console.log(apptStartTime);
		console.log(apptEndTime);
		e.addAppointment(customerId,Professional_ID,ServiceID,apptStartTime,apptEndTime);
	}
	
	var  callBackAppointment = function(res){
		$("#calendar").fullCalendar("refetchEvents");
	}
		
	var updateRecurrenceAvailability = function(id, startDate, endDate, exceptionDate) { 
		sDate = startDate;
		eDate = endDate;
		var AvailabilityID = id;
		var exceptionDate = exceptionDate.getFullYear() + '-' + (exceptionDate.getMonth()+1) + '-' + exceptionDate.getDate() + ' ' + exceptionDate.getHours() + ':' + exceptionDate.getMinutes() + ':' + exceptionDate.getSeconds();
		
		console.log(exceptionDate);			
		var e = new calendarAjax(); 
		e.setSyncMode();
		e.setCallbackHandler(callBackRecurrenceAvailability); 
		e.setErrorHandler(myErrorHandler); 
		e.updateRecurrenceAvailability(Professional_ID,AvailabilityID,exceptionDate);
	}
	
	var callBackRecurrenceAvailability = function(res){
		addAvailability(0, sDate, eDate);
	}
	
	var addAvailability = function(id,start, end){
		var endRecurrenceDate = '';
		var endAfterOcurrences = 0;
		var recurCountInterval = 0;
		var typeValue = $('#recurrenceType').val();
		//var typeValue = "0";
        var e 	= new calendarAjax();                
        StartWeekDate = (start.getMonth() + 1) + '/' + start.getDate() + '/' +  start.getFullYear();
		
		e.setSyncMode();
		e.setCallbackHandler(callBackAvailability); 
		e.setErrorHandler(myErrorHandler); 

		if(typeValue > cfvariables.recurrence_type_none){
			//Prepare Range Types Data
			if(recurrenceRangeType == cfvariables.recurrence_range_type_no_end_date){
				//Do nothing
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_after_occurrences){
				endAfterOcurrences = $('#endAfterOccur').val();
			}
			else if(recurrenceRangeType == cfvariables.recurrence_range_type_end_by_date){
				endRecurrenceDate = $('#datepicker').val();
			}
		}
				
		switch(typeValue){
			
			case "0": //RECURRENCE_TYPE_NONE
				// console.log(Professional_ID);
				// console.log(id);
				// console.log(start);
				// console.log(end);
				var AvailabilityID = id;
				console.log(AvailabilityID);
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				e.addAvailabilityTypeNone(Professional_ID, AvailabilityID.toString(), StartDate, EndDate);
				break;

			case "1": //RECURRENCE_TYPE_DAILY_DAYS
				recurCountInterval = $('#dailyEveryDays').val();
				console.log(Professional_ID);
				console.log(id);
				console.log(start);
				console.log(end);
				console.log(recurCountInterval);
				console.log(endRecurrenceDate);
				console.log(endAfterOcurrences);
				console.log(recurrenceRangeType);
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				var AvailabilityID = id;	
				var strRecurCountInterval=0;
				if(recurCountInterval == null) {
				recurCountInterval=strRecurCountInterval;
				}
				console.log("recurCountInterval="+recurCountInterval)	;	
				e.addAvailabilityTypeDailyDays(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
				break;			
			
			case "2": //RECURRENCE_TYPE_DAILY_WEEKDAYS
				var AvailabilityID = id;
				console.log(Professional_ID);
				console.log(AvailabilityID);
				console.log(start);
				console.log(end);
				console.log(endRecurrenceDate);
				console.log(endAfterOcurrences);
				console.log(recurrenceRangeType);
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				e.addAvailabilityTypeDailyWeekdays(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
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
				var AvailabilityID = id;
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				if(endRecurrenceDate.length)
				{
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				recurCountInterval = $('#weeklyEveryWeeks').val(); 	
				e.addAvailabilityTypeWeekly(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, weekDays, 
						recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences.toString(), recurrenceRangeType.toString());
				break;		
					
			case "4": //RECURRENCE_TYPE_MONTHLY_DATE
				var dayValue = $('#monthlyDay').val();
				recurCountInterval =$('#monthlyEveryMonth').val();	
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				var AvailabilityID = id;
				if(endRecurrenceDate.length)
				{
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				console.log(Professional_ID);
				console.log(AvailabilityID);
				console.log(StartDate);
				console.log(EndDate);
				console.log(dayValue);
				console.log(recurCountInterval);
				console.log(endRecurrenceDate);
				console.log(endAfterOcurrences);
				console.log(recurrenceRangeType);
				e.addAvailabilityTypeMonthlyDate(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, dayValue, 
						recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences.toString(), recurrenceRangeType);
				break;	
	
			case "5": //RECURRENCE_TYPE_MONTHLY_WEEK
				recurCountInterval = $('#monthlyWeekEveryMonth').val();
				var recurrenceOrdinalIntervalID = $('#monthlyOrdinalType').val();
				var recurrenceWeekdayIntervalID = $('#monthlyWeeklyType').val();
				var AvailabilityID = id;
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();
				if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				console.log(Professional_ID);
				console.log(id);
				console.log(StartDate);
				console.log(EndDate);
				console.log(recurrenceOrdinalIntervalID);
				console.log(recurrenceWeekdayIntervalID);
				console.log(recurCountInterval);
				console.log(endRecurrenceDate);
				console.log(endAfterOcurrences);
				console.log(recurrenceRangeType);
				e.addAvailabilityTypeMonthlyWeek(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, 
					recurrenceOrdinalIntervalID.toString(), recurrenceWeekdayIntervalID.toString(), recurCountInterval.toString(), endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
				break;
						
			case "6": //RECURRENCE_TYPE_YEARLY_DATE
				var dayValue = $('#yearlyDay').val();
				var yearlyMonth = $('#yearlyEveryMonth').val();
				var AvailabilityID	= id;
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();	
				if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
				}
				e.addAvailabilityTypeYearlyDate(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, 
				dayValue, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
				break;	
						
			case "7": //RECURRENCE_TYPE_YEARLY_MONTH 
				var recurrenceOrdinalIntervalID = $('#yearlyOrdinalType').val();
				var recurrenceWeekdayIntervalID = $('#yearlWeeklyType').val();
				var yearlyMonth = $('#yearlyOfMonth').val();
				var AvailabilityID = id;
				var StartDate = start.getFullYear() + '-' + (start.getMonth()+1) + '-' + start.getDate() + ' ' + start.getHours() + ':' + start.getMinutes() + ':' + start.getSeconds();
				var EndDate = end.getFullYear() + '-' + (end.getMonth()+1) + '-' + end.getDate() + ' ' + end.getHours() + ':' + end.getMinutes() + ':' + end.getSeconds();	
				if(endRecurrenceDate.length) {
					var endRecurrenceDate = endRecurrenceDate.toString();
				}	
				console.log(Professional_ID);
				console.log(AvailabilityID);	
				console.log(StartDate);	
				console.log(EndDate);	
				console.log(recurrenceOrdinalIntervalID);	
				console.log(recurrenceWeekdayIntervalID);					
				console.log(yearlyMonth);	
				console.log(endRecurrenceDate);	
				console.log(endAfterOcurrences);	
				console.log(recurrenceRangeType);	
				e.addAvailabilityTypeYearlyMonth(Professional_ID, AvailabilityID.toString(), StartDate, EndDate, 
					recurrenceOrdinalIntervalID, recurrenceWeekdayIntervalID, yearlyMonth, endRecurrenceDate, endAfterOcurrences, recurrenceRangeType);
				break;	
				default:		
		} 
	} 
	
	// Callback function to display the results of the getAvailability 
	var callBackAvailability = function(res){		
		$("#calendar").fullCalendar("refetchEvents");
	} 
	
	// Error handler for the asynchronous functions. 
	var myErrorHandler = function(statusCode, statusMsg) { 
		alert('Status: ' + statusCode + ', ' + statusMsg); 
	}
//})

//reduces the end time options to be only after the start time options.
$("select[name='start']").change(function() {
	var startTime 	= $(this).val();
	var startIndex 	= $(this).find("option:selected").index();
	var endIndex 	= $('#EventCal_end').find("option:selected").index();
	$('#EventCal_end').find('option').prop("disabled",false);
	$('#EventCal_end').find('option').each(function(index) {
		if( index < startIndex) {
			$(this).attr("disabled",true);
		}
	});
	if( endIndex <= startIndex ) {
		$('#EventCal_end').find('option').prop("selected",false).eq(startIndex).prop("selected",true);
	} else {
		$('#EventCal_end').find('option').prop("selected",false).eq(endIndex).prop("selected",true);
	}
	//$('#EventCal_end').find('option[value="06:30:00"]').attr("selected",true);
});

$( "#dialog-form" ).dialog({
	autoOpen:false,
	height: 250,
	width: 450,
	modal: true,
	buttons: [
		{
			text: "Cancel",
			"class" : "btn btn-xs",
			click: function() {
				$( this ).dialog( "close" ); 
			} 
		},
		{
			text: "Continue",
			"class" : "btn btn-primary btn-xs",
			click: function() {
				console.log(recurrenceDeleteType);
				removeAvailability(currentCalEvent.id, currentCalEvent.start, recurrenceDeleteType);
				calendar.fullCalendar("removeEvent", currentCalEvent.id);
				$( this ).dialog( "close" );
				$("#event_edit_container").dialog("close");
			}
		}
	]
});	
   
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

function resetForm($dialogContent) {
	$dialogContent.find("input[type='text']").val("");
	$dialogContent.find("input[type='hidden']").val("");
	$dialogContent.find("input[type='date']").val("");
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
	
	$dialogContent.find("#selCustomers").val(0);			 
	$dialogContent.find("#selService").val(0);			 
	
	$dialogContent.find("input[name='datepicker']").val();
	
	document.getElementById('recurrence_range_type1').checked = true;	 	
	document.getElementById('recurrence_range_type2').checked = false;
	document.getElementById('recurrence_range_type3').checked = false;
	document.getElementById('recurrence_update_type1').checked = true;	 	
	document.getElementById('recurrence_update_type2').checked = false;
	document.getElementById('recurrence_delete_type1').checked = true;
	document.getElementById('recurrence_delete_type2').checked = false;
	recurrenceRangeType = 1;
	recurrenceDeleteType = 1;
	recurrenceUpdateType = 1;
	recurrenceUpdateException = 0;
	$('#EventCal_end').find('option').prop("disabled",false).prop("selected",false);
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


function quickAddCustomer() {
	var $dialogCustomer = $("#addCustomerWrap");
	var $customer_form = $dialogCustomer.find("#customer_edit_form");
	$customer_form.find('#customerValidateError').hide();
	$customer_form.find('label.error').remove();
	$dialogCustomer.removeClass('hide').dialog({
		modal: true,
		width:400,
		title: "Add Customer",
		close: function(event, ui) 
		{ 
			$dialogCustomer.dialog("destroy");
			$dialogCustomer.hide();
		},
		buttons: [
			{
				text: "Cancel",
				"class" : "btn btn-xs",
				click: function() {
					$( this ).dialog( "close" ); 
				} 
			}, 
			{
				text: "Save",
				"class" : "btn btn-primary btn-xs",
				"click": function() {
					$customer_form.validate();
					$customer_form.find(".required").each(function() {
						$(this).rules("add", { required: true, messages: { required: "" } });
					});
					
					var firstname 	= $.trim($customer_form.find('#customerFirstName').val());
					var lastname 	= $.trim($customer_form.find('#customerLastName').val());
					var mobile 		= $.trim($customer_form.find('#customerMobile').val());
					var phone 		= $.trim($customer_form.find('#customerPhone').val());
					//var email 		= $customer_form.find('#customerEmail').val();
					var email  	    = $.trim($customer_form.find('#customerEmail').val());
					var password 	= $customer_form.find('#customerPassword').val();
					var mail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					var charctersOnly =  /^([a-zA-Z]+\s)*[a-zA-Z]+$/;
					var numbersOnly = /^[0-9]+$/;
					if(firstname != '') {		
						if(!(charctersOnly.test(firstname))) {
							$customer_form.find('#customerValidateError').html('Please enter a valid First Name');
							$customer_form.find('#customerValidateError').show();
							return false;
						} 
					}
					if(lastname != '') {		
						if(!(charctersOnly.test(lastname))) {
							$customer_form.find('#customerValidateError').html('Please enter a valid Last Name');
							$customer_form.find('#customerValidateError').show();
							return false;
						} 
					}
					if(mobile != '') {		
						if(!(numbersOnly.test(mobile))) {
							$customer_form.find('#customerValidateError').html('Please enter a valid mobile number');
							$customer_form.find('#customerValidateError').show();
							return false;
						} 
					}
					if(phone != '') {		
						if(!(numbersOnly.test(phone))) {
							$customer_form.find('#customerValidateError').html('Please enter a valid phone number');
							$customer_form.find('#customerValidateError').show();
							return false;
						} 
					}
					if(email != '') {		
						if(!(mail.test(email))) {
							// $('#customerEmail').addClass("error");
							$customer_form.find('#customerValidateError').html('Please enter a valid email address');
							$customer_form.find('#customerValidateError').show();
							return false;
						}
					}
					if ( !$customer_form.valid() ) {
						$customer_form.find('#customerValidateError').html('Missing required fields!');
						$customer_form.find('#customerValidateError').show();
						$customer_form.find('label.error').remove();
						return false;
					} else {
						$customer_form.find('#customerValidateError').hide();
					}	
					var professional_id = $("#professional_id").val();
					$.ajax({
						url: "/admin/customers.cfc?method=addNewCustomer",
						type: "post",
						
						data: {
							firstname:firstname,
							lastName:lastname,
							mobile:mobile,
							phone:phone,
							email:email,
							password:password,
							company_id:company_id,
							professional_id:professional_id,
							location_id:location_id
						},
						success: function(data){
							$("#selCustomers").html(data);							
						}, 
						error: function(data){
							console.log(data);
						}
					});
					$( this ).dialog( "close" );
				}
			}					
		]
	});
}

</script>