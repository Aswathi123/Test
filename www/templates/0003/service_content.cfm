<cfset variables.staffImagePath = ExpandPath("/images/staff/")> 
<cfset variables.staffImageFilepath = staffImagePath & "#qProfessional.Professional_ID#.jpg">
<!--- <cfdump var="#qProfessional.Professional_ID#"><cfabort> --->
<div id="serviceDiv"></div>
<div class="row m-0 timing-row">
	<div class="container outer-container-layout timing-inner-container" >
		<div class="timing-child open-title">
			<h4>OUR OPENING HOURS!</h4>
		</div>
<cfoutput>
		<div class=" timing-child">
			<p class="p-left">Monday To Friday: 
			<cfif qLocation.MONDAY_HOURS neq "closed">
				#qLocation.MONDAY_HOURS#
			<cfelseif qLocation.TUESDAY_HOURS neq "closed">
				#qLocation.TUESDAY_HOURS#
			<cfelseif qLocation.WEDNESDAY_HOURS neq "closed">
				#qLocation.WEDNESDAY_HOURS#
			<cfelseif qLocation.THURSDAY_HOURS neq "closed">
				#qLocation.THURSDAY_HOURS#
			<cfelseif qLocation.FRIDAY_HOURS neq "closed">
				#qLocation.FRIDAY_HOURS#
			<cfelse>
				closed
			</cfif>
			</p><span class="time-devider"></span><p class="p-right">Saturday: #qLocation.SATURDAY_HOURS#</p>
			<a href="##infoDiv" class="view-more-btn">View More</a>
		</div>
</cfoutput>
	</div>
</div>
<!-- Service body -->
<input type="hidden" name="templatePath" id="templatePath" value="<cfoutput>#templatePath#</cfoutput>">
<section class="service-body-content">
	<section class="service-staff-section">
		<div class="container outer-container-layout service-staff-container">
			<div class="row service-staff-header-section">
				<div class="col-xl-3 col-lg-4 col-md-5 col-12 service-staff-title" >
					<h1>Our Services and Staff TEST</h1>
				</div>
				<div class="col-xl-9 col-lg-8 col-md-7 col-12 service-staff-caption">
					<p></p>
				</div>
			</div>
			<div class="row ">
				<div class="service-block">
					<cfinclude template="/customer_sites/services.cfm" >
					<cfif qService.recordcount gt 0>					
						<cfloop query="qService">
							<div class="col-lg-4 col-md-6 col-12 layout-pading">															
								<div class="service-block-inner-content">
									<div class="service-img">
										<img src="<cfoutput>#templatePath#img/service-thumb-1.png</cfoutput>" alt="">
									</div>
									<div class="service-text-content">
										<cfoutput>
											<h4>#qService.SERVICE_NAME#</h4>
											<h4 class="price">$#qService.PRICE#</h4>
										<!--- 	<p>#qService.SERVICE_DESCRIPTION#</p> --->
											<p><a href="##">View More</a></p>
										</cfoutput>	
									</div>
								</div>													
							</div>	
						</cfloop>	
					<cfelse>
						No services available
					</cfif>						
				</div>
			</div>
		</div>
	</section>
	<!-- Our staff -->
	<cfoutput>
		<section class="our-staff-section">
			<div class="container outer-container-layout">
				<div class="row title-row">
					<div class="title-inner-content">
						<h2>Our Dedicated Staff</h2>
						<div class="border-layout"></div>
					</div>
				</div>
				<div class="row m-0 staff-slider-content">
					<div id="staff_slider" class="owl-carousel owl-theme">
						<cfif qProfessional.recordcount gt 0>						
							<cfloop query="qProfessional">			
								<div class="item staff-item-holder">
									<div class="row staff-item-holder-row m-0">
										<div class="col-lg-4 col-md-5 col-12 staff-img-holder">
											<cfif fileExists(variables.staffImageFilepath)>
												<img src="/images/staff/#qProfessional.Professional_ID#.jpg" alt="">
											</cfif>
										</div>
										<div class="col-lg-8 col-md-7 col-12 staff-details">
											<h3>#FIRST_NAME# #LAST_NAME#</h3>
											<p>#BIO#</p>
										</div>
									</div>
								</div>
							</cfloop>
						<cfelse>
							No staff avilable
						</cfif>
					</div>
				</div>
			</div>
		</section>	
		<!-- operations -->
		<section class="welcome-section operations-section">
			<div class="container outer-container-layout welcome-container">
				<div class="row" id="infoDiv">
					<div class="col-lg-6 col-md-12 col-12 welcome-text-content">
						<h2>Hours of Operation</h2>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
					</div>
					<div class="col-lg-6 col-md-12 col-12 timing-table-content">
						<div class="row">
							<div class="col-md-6 col-sm-6 col-12">
								<table class="timing-table">
									<tbody>
										<tr class="header">
											<td>Sunday</td>
											<td>: #qLocation.SUNDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Monday</td>
											<td>: #qLocation.MONDAY_HOURS#</td>
										</tr>
										<tr>
											<td>Tuesday</td>
											<td  style="font-size: 13px;">: #qLocation.TUESDAY_HOURS#</td>
										</tr>
										<tr class="bottom">
											<td>Wednesday</td>
											<td>: #qLocation.WEDNESDAY_HOURS#</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="col-md-6 col-sm-6 col-12">
								<table class="timing-table">
									<tbody>
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
											<td class="closed">: Closed</td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</cfoutput>
<!-- body end	 -->
<!-- Contact -->
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
</section>
<!--- Script --->
