<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/0001/"> --->
<cfoutput>
	<cfset variables.PageTitle ="Appointment History">
	<cfset variables.title_no = 0>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<link href="/templates/0001/inner.css" rel="stylesheet" type="text/css" />
	<div class="col-md-8" id="page-content">
		<div class="midContent">
			<cfinclude template="/customer_sites/customer_appointment_history.cfm">
		</div>
	</div>
	<div class="col-md-4">
		<div class="block-header">
			<h2>
			<span class="title">INFO</span>
			</h2>
		</div>
		<cfinclude template="#templatePath#info_sidebar.cfm">					
	</div>
<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>
<!---<cfoutput>
<cfset variables.PageTitle ="Appointment History">
<cfset variables.title_no = 0>
<cfparam name="templatePath" type="string" default="/templates/0001/">
<cfinclude template="/customer_sites/customer_header.cfm">
<cfinclude template="#templatePath#template_header.cfm">
<link href="#templatePath#inner.css" rel="stylesheet" type="text/css" />
	<div class="content col-md-8" align="left">
		<div class="heading">Appointment History</div> 
<!---	<cfif IsDefined("session.CustomerID")>
		<cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />	
		<cfset variables.qryResults = variables.objCFC.getCustomerAppointmentHistory(session.CustomerID) />
		
		<cfif variables.qryResults.RecordCount>
			<table border="1" cellpadding="3" cellspacing="0">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th align="left">Appointment Date/Time</th>
					<th align="left"><strong>Service</strong></th>
					<th align="left">Professional Name</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="variables.qryResults">
				<tr>
					<td>
						<cfif Start_Time GT Now()>
							<cfset variables.apptDesc = URLEncodedFormat('#Service_Name# on #DateFormat(Start_Time,"mm/dd/yyyy")# #TimeFormat(Start_Time,"short")#') />
							<a href="appointments.cfm?changeAppointmentID=#Appointment_ID#&apptDesc=#variables.apptDesc#">Reschedule</a>
						<cfelse>
							&nbsp;
						</cfif>
					</td>
					<td>#DateFormat(Start_Time,"mm/dd/yyyy")# #TimeFormat(Start_Time,"short")#</td>
					<td>#Service_Name#</td>
					<td>#First_Name# #Last_Name#</td>
				</tr>
				</cfloop>
			</tbody>
			</table>	
		<cfelse>
		<p>No Appointments were found</p>
		</cfif>
			
	</cfif>			
		--->
	</div>
	<div class="col-md-4">
		<div class="block-header">
			<h2>
			<span class="title">INFO</span>
			</h2>
		</div>
		<cfinclude template="#templatePath#info_sidebar.cfm">					
	</div>
<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>--->