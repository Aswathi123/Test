<cfinclude template="header.cfm">
<cfoutput>
	<cfif Len(Trim(qCompany.Company_Email))>
		<cfset Company_Email = qCompany.Company_Email>
	</cfif>
	<section class="contact-body-content">
			<section class="contact-mail-section">
			<!-- contact-form -->
			 <section class="contact-section operations-section">
				<div class="container outer-container-layout welcome-container">
					<div class="row">
						<div class="col-lg-8 col-md-12 col-12 contact-section">
							<h1 class="title">CONTACT US</h1>
							<cfif Len(Trim(qCompany.Company_Email))>
								<cfset Company_Email = qCompany.Company_Email>
							</cfif>
							<cfif Len(Trim(qLocation.Location_Address))>
								<div class="row col-md-12">#qLocation.Location_Address#</div>
							</cfif>
							<cfif Len(Trim(qLocation.Location_Address2))>
								<div class="row col-md-12">#qLocation.Location_Address2#</div>
							</cfif>
							<cfif Len(Trim(qLocation.Location_City))>
								<div class="row col-md-12">#qLocation.Location_City#, #qLocation.Location_State# #qLocation.Location_Postal#</div>
							</cfif>
							<cfif Len(Trim(qLocation.Location_Phone))>
								<div class="row col-md-12">Phone: #qLocation.Location_Phone#</div>
							</cfif>
							<cfif Len(Trim(qLocation.Location_Fax))>
								<div class="row col-md-12">Fax: #qLocation.Location_Fax#</div>
							</cfif>
							<cfif Len(Trim(qCompany.Company_Email))>
								<div class="row col-md-12">Email: #qCompany.Company_Email#</div>
							</cfif>
							<hr>						
							To leave us a message, fill out the form below: 					
							<div id="msgContact" class="alert"></div>
							<div class="col-lg-12 col-md-12 col-12 p-0">
								<div class="contact-form">
									<form id="frmContact" name="frmContact" action="contact.cfm" method="post" role="form">
										<input type="hidden" name="Location_ID" value="#qLocation.location_id#">
										<input type="hidden" name="Company_Email" value="#Company_Email#">
										<div class="form-group">
											<input class="form-text" type="text" placeholder="Name" id="Name" name="Name">
										</div>
										<div class="form-group">
											<input class="form-text" type="text" placeholder="Email Address" id="Email" name="Email">
										</div>
										<div class="form-group">
											<input class="form-text" type="text" placeholder="Phone Number" id="Phone" name="Phone">
										</div>
										<div class="form-group">
											<textarea class="form-text" name="Message" placeholder="Enter Message here"></textarea>
										</div>
										<div class="form-group">
											<button type="button" id="btnSendMessage" class="signin">Send</button>
										</div>
									</form>
								</div>
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
	<!-- body end	 -->