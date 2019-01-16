	<div class="col-md-8" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Book Your Next Appointment Online</span>
			</h2>
		</div>
		<cfoutput>
		<div class="col-sm-12">
			<div class="headline"></div>
			<div class="content msgcontent">
				<form id="frmDefault" name="frmDefault" class="form" role="form">
					<input type="hidden" id="pw" name="pw"   />
					<!--- <input type="password" id="pw" name="pw"  hidden="true"  /> --->
					<input type="hidden" id="emailAddress" name="emailAddress"  />
					<input type="hidden" id="firstName" name="firstName"  />
					<input type="hidden" id="lastName" name="lastName"  />
					<input type="hidden" id="ph" name="ph" />
					<input type="hidden" id="availableDate" name="availableDate" />
					<input type="hidden" id="serviceTime" name="serviceTime" />
					<input type="hidden" id="serviceDesc" name="serviceDesc" />
					<input type="hidden" id="submitType" name="submitType" />
					
					<div class="row">
						<div class="col-sm-8">
							<cfif structKeyExists(url, 'changeAppointmentID') AND Len(url.changeAppointmentID)>
								<label class="sr-only">Change Appointment: #URLDecode(url.apptDesc)#</label>
								<input type="hidden" id="changeAppointmentID" name="changeAppointmentID" value="<cfoutput>#url.changeAppointmentID#</cfoutput>" />
							<cfelse>
								<label class="sr-only">Book Your Next Appointment Online</label>
								<input type="hidden" id="changeAppointmentID" name="changeAppointmentID" value="0" />
							</cfif>
						
							<!--- <div class="input-group"> --->
								<!--- <label class="sr-only" for="subscribe-email">Email address</label> --->
								<select id="selProfessional" name="selProfessional" class="form-control" onChange="fnProfessionalChange()">
								</select>
								<!--- <span class="input-group-btn">
								<button type="submit" class="btn btn-default">OK</button>
								</span> --->
							<!--- </div> --->
							<br />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8">	
							<select id="selService" name="selService" class="form-control" onChange="fnServicesChange()">
							</select>
							<br />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8">	
							<input type="text" id="cdrAvailable" name="cdrAvailable" class="form-control col-sm-4" 
									readonly="true" disabled="true" style="width: 90%;" />
							<!--- <div class='input-group date' id='cdrAvailable'>
								<input type='text' class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div> --->
							
							<br />
						</div>
					</div>	
					
					<div class="row">
						<div class="col-sm-8">
							<br />
							<select id="selAvailableTimes" name="selAvailableTimes" disabled="true" class="form-control">
								<option value="0">Available Time Slots</option>	
							</select>	
						</div>
					</div>
					<hr />
					<div class="row" id="actionAppointment">
						<div class="col-sm-8">
							<button id="btnMakeAppointment" type="button" class="btn btn-danger">Make an Appointment</button>
						</div>
					</div>
					<div id="msgAppointment" class="alert">&nbsp;</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<div class="block-header">
			<h2>
			<span class="title">INFO</span>
			</h2>
		</div>
		<cfinclude template="/templates/0001/info_sidebar.cfm">					
	</div>
<!--- <cfinclude template="#templatePath#template_footer.cfm">
 --->
 </cfoutput>