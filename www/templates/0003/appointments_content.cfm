<!--- 	<div class="col-md-8" id="page-content">
		<br><br>
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
				
	</div>
<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput> --->


<cfinclude template="header.cfm">
<cfoutput>
	<section class="contact-body-content">
			<section class="contact-mail-section">
			<!-- contact-form -->
			 <section class="contact-section operations-section">
				<div class="container outer-container-layout welcome-container">
					<div class="row">
						<div class="col-lg-8 col-md-12 col-12 contact-section">														
							<h1><span class="title">BOOK YOUR NEXT APPOINTMENT ONLINE</span></h1>										 					
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
										<div class="col-sm-8 form-cntrl">
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
										<div class="col-sm-8 form-cntrl">	
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
										<div class="col-sm-8 form-cntrl">
											<br />
											<select id="selAvailableTimes" name="selAvailableTimes" disabled="true" class="form-control">
												<option value="0">Available Time Slots</option>	
											</select>	
										</div>
									</div>
									<hr />
									<div class="row" id="actionAppointment">
										<div class="col-sm-8">
											<button id="btnMakeAppointment" type="button" class="btn buttonStyle">Make an Appointment</button>
										</div>
									</div>
									<div id="msgAppointment" class="alert">&nbsp;</div>
								</form>
							</div>               
						</div>
						<div class="col-lg-4 col-md-12 col-12 timing-table-content">
							<h1 class="title">INFO</h1>
							<h2>Hours of Operation</h2>
							<div class="row">

								<div class="col-md-12 col-sm-12 col-12">
									<table class="timing-table">
										<tbody>
											<tr>
												<td>Sunday</td>
												<td>: #qLocation.SUNDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Monday</td>
												<td>: #qLocation.MONDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Tuesday</td>
												<td>: #qLocation.TUESDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Wednesday</td>
												<td>: #qLocation.WEDNESDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Thursday</td>
												<td>: #qLocation.THURSDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Friday</td>
												<td>: #qLocation.FRIDAY_HOURS#</td>
											</tr>
											<tr>
												<td>Saturday</td>
												<td>: #qLocation.SATURDAY_HOURS#</td>
											</tr>
										</tbody>
									</table>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</section>
		</section>
		<!-- Payment -->
		<section class="payment-section">
			<div class="container outer-container-layout payment-container">
				<div class="row">
					<div class="payment-inner-child payment-img-left">
					<h2>Payment methods</h2>
					</div>
					<div class="payment-inner-child payment-method-right">
						<cfinclude template="/customer_sites/include_payment_methods.cfm" >
						<ul class="payment-ul">
							<cfloop query="getPaymentMethods">
								<li>
									<img src="images/#getPaymentMethods.Logo_File#" alt="getPaymentMethods.PAYMENT_METHOD">
								</li>
							</cfloop>
						</ul>
					</div>
				</div>
			</div>
		</section>
		<!-- Payment -->		
	</section>
	<section class="contact-section">
			<div class="row contact-inner-row m-0">
				<div class="col-12 map-content">
					<!--- <div id="mapHome"></div> --->
					<div>
					<cfoutput>
						<p>
							<iframe height="450" width="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,
							+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;output=embed">
							</iframe><br />
							<small><a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;z=14&amp;ll=30.524347,-97.863141" style="color:##0000FF;text-align:left" target="_blank">View Larger Map</a></small> 
						</p>
					</cfoutput>
				</div>	
				</div>
				<div class="col-12 map-inner-contact">
					<cfoutput>
						<h3>#qCompany.COMPANY_NAME#</h3>
						<p class="address">#qCompany.COMPANY_ADDRESS#<br>
						#qCompany.COMPANY_ADDRESS2#<br>
						#qCompany.COMPANY_CITY#, #qCompany.COMPANY_POSTAL#</p>
						<br>
						<p class="phone">#qCompany.COMPANY_PHONE#</p>
						<p class="mail"><a href="##">#qCompany.COMPANY_EMAIL#</a></p>
					</cfoutput>
				</div>
			</div>
		</section>
</cfoutput>