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

<cfajaxproxy cfc="appointmentsCalendarBean" jsclassname="calendarAjax" />
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
						<input type="password" name="customerPassword" id="customerPassword" value="">
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
						<span class="viewTypeRadio"><input type="radio" name="viewtype" value="Available" id="Avai