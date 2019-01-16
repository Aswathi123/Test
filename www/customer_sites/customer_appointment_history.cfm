<cfoutput>
<div class="block-header">
	<h2>
		<span class="title">Appointment History</span>
	</h2>
</div>
<div class="content">
	<cfif IsDefined("session.CustomerID")>
		<cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />	
		<cfset variables.qryResults = variables.objCFC.getCustomerAppointmentHistory(session.CustomerID) />
		
		<cfif variables.qryResults.RecordCount>
			<table class="table table-bordered table-hover">
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
</div><!-- content -->
</cfoutput>	