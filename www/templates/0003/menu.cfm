<cfquery name="getTrialExpiration" datasource="#request.dsn#">
   SELECT 
   Trial_Expiration
   FROM
   Companies
   WHERE
   Company_ID=
   <cfqueryparam value="#variables.company_Id#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfinclude template="/customer_sites/include_blog.cfm">
<!-- Nav -->
		<div class="nav-outer-row m-0 sticky" id="topDiv">
			<div class="container nav-outer-container" style="padding-left: 0px;">
				<nav class="navbar navbar-expand-lg navbar-dark">
					<cfset tp="templates/0003/">
					<a class="navbar-brand" href="/index.cfm"><img src="<cfoutput>#templatePath#img/logo.png</cfoutput>" alt=""> </a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="collapsibleNavbar">
						<ul class="navbar-nav">
							<li class="nav-item">
								<a class="nav-link" href="/index.cfm">Home</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="/staff.cfm#serviceDiv">Services & staff</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="/contact.cfm#contactDiv">Contact us</a>
							</li>
							<!--- <cfdump var="#getPlan.Company_Service_Plan_ID#">
<cfdump var="#DateDiff('d',Now(),getTrialExpiration.Trial_Expiration)#"><cfabort> --->
							<cfif ( getPlan.Company_Service_Plan_ID gt 1  AND (DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0 AND ( getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)))) >
								<li class="nav-item">
									<a class="nav-link" href="/appointments.cfm#appointmentDiv">Online booking</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="/gallery.cfm#galleryDiv">Photo Gallery</a>
								</li>
								<cfif qGetBlogPost.recordcount>
									<li class="nav-item">
									<a class="nav-link" href="/blog.cfm?page=1#blogDiv">Blog</a>
								</li>
								</cfif>								
								<cfif variables.customerid eq 0>
									<li id="sign-in" class="show nav-item">
										<a href="##" class="mainmenu a_signin nav-link">Sign In</a>
									</li>
								</cfif>
								<cfset hiddenClass = "hideDiv">
								<cfif variables.customerid neq 0>
									<cfset hiddenClass = "">
								</cfif>
								<!--- <div id="sign-in">
									<li class="show" id="sign-in" >
										<a class="nav-link signin-btn" href="#" data-toggle="modal" data-target="#signinModal"><img src="<cfoutput>#templatePath#img/user-login.png</cfoutput>" alt="Sign in" alt=""> Sign in</a>
									</li>
								</div> --->
								<cfoutput>
									<div class="#hiddenClass#" id="profile-menu">
										<li id="profile-menu" class="dropdown">
											<a href="##" class="dropdown-toggle mainmenu" data-toggle="dropdown"><span class="user-name">#variables.user_name#</span> <b class="caret"></b></a>									
											<ul class="dropdown-menu profileMenu">
												<li class="account">
													<div class="avatar"></div>
													<p><span class="user-email">#variables.user_email#</span></p>												
													<div class="profileLink">
														<p><a  href="customer_profile.cfm" class="a_profile">Profile</a></p>
														<p><a href="##" id="a_signout">Sign out</a></p>
														<p><a href="customer_appointment_history.cfm" class="a_apphistory">Appointment History</a></p>
													</div>
													<div class="clearfix"></div>
												</li>
											</ul>									
										</li>									
									</div>
								</cfoutput>
							</cfif>
						</ul>
					</div>
				</nav>
			</div>
		</div>
		<!-- Nav End -->