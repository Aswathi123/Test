<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/"> --->
<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<cfinclude template="template_header.cfm">
<cfinclude template="header.cfm">
<cfoutput>	
		<div class="row m-0 timing-row">
			<div class="container outer-container-layout timing-inner-container">
				<div class="timing-child open-title">
					<h4>OUR OPENING HOURS!</h4>
				</div>
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
			</div>
		</div>
		<!-- Welcome salon -->
			
			<section class="welcome-section">
				<div class="container outer-container-layout welcome-container">
					<div class="row">
						<div class="col-md-7 col-sm-12 col-12 welcome-text-content">
							<h2>WELCOME TO #qCompany.COMPANY_NAME#</h2>
							#qCompany.COMPANY_DESCRIPTION#
						</div>
						<div class="col-md-5 col-sm-12 col-12 welcome-img-content">
							<img src="<cfoutput>#templatePath#img/tools.png</cfoutput>" alt="Welcome" class="img-fluid">
						</div>
					</div>
				</div>
			</section>		
			<cfinclude template="info_bar.cfm">
			<!-- Service and blog -->
			<section class="service-section">
				<div class="container outer-container-layout service-container">
					<div class="row">
						<div class="col-lg-6 col-md-12 col-12 service-child">
							<div class="row title-row">
								<h2>Services offered</h2>
								 <!-- <div class="line-dsgn"></div> -->
							</div>						
							<cfinclude template="/customer_sites/services.cfm" >
							<cfif qService.recordcount gt 0>							
								<cfloop query="qService">		
									<div class="row serives-list-row">
										<div class="serives-thumb-img">
											<img src="<cfoutput>#templatePath#img/service-1.png</cfoutput>" alt="Service">
										</div>
										<div class="about-service">
											<cfoutput>
												<h4>#SERVICE_NAME#</h4>
												<h4 class="price">$#PRICE#</h4>
												<!--- <p>#SERVICE_DESCRIPTION#</p> --->
												<p><a href="##">View More</a></p>
											</cfoutput>									
										</div>
									</div>
									<hr class="service-separator">
								</cfloop>
							<cfelse>
								No services available
							</cfif>	
						</div>
						<cfinclude template="/customer_sites/include_blog.cfm">
						<div class="col-lg-6 col-md-12 col-12 blog-child-right">
							<div class="row title-row">
								<h2>From Our Blog</h2>
							</div>
							<cfif qGetBlogPost.recordcount gt 0>							
								<cfloop query="qGetBlogPost" startrow="1" endrow="2">						
									<div class="row blog-inner-row leftPadding">
										<cfset variables.dates = #CREATED_DATE#>	
										<cfset variables.day = DateTimeFormat(dates, "dd")>						
										<cfset variables.month = DateTimeFormat(dates, "MMM")>										
										<div class="blog-img">
											<span class="blog-img-inner-layout">												
												<div class="blog-date">
													<p class="month">#variables.month#</p>
													<p class="day">#variables.day#</p>
												</div>
											</span>
										</div>
										<div class="col-lg-7 col-md-8 col-sm-7 col-12 blog-details">
											<h4>#TITLE#</h4>
											<p class="name">by By #First_Name# #Last_Name#</p>
											<cfset variables.DescriptionHtml = #DESCRIPTION#>										
											<cfset variables.DescriptionString = REReplace(variables.DescriptionHtml,"<[^>]*>","","All")>
											<cfset variables.ShortDescription = Mid(variables.DescriptionString,1,101)>
											<p class="content">#variables.ShortDescription#...</p>					
											<p><a href="blog.cfm?blogId=#BLOG_ID###blogDiv" class="read-more-btn">Read More</a></p>
										</div>
									</div>
									<hr>
								</cfloop>
								<p><a href="blog.cfm?page=1##blogDiv" id="readmore" class="read-more-btn linkStyle">Read More Blogs</a></p>
							<cfelse>
								No blogs available
							</cfif>
						</div>
					</div>
				</div>	
			</section>
		</cfoutput>
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
		<!-- footer -->
	<cfinclude template="template_footer.cfm">
	<!-- Scripts -->
		<script src="<cfoutput>#templatePath#js/owl.carousel.min.js</cfoutput>"></script>
		<script src="<cfoutput>#templatePath#js/script.js</cfoutput>"></script>
		<!--<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJJWxLBBhbeTKxCOHdvD6ktNoeUrtRwRo&callback=initMap"></script>-->
	</body>
</html>
		
		