<cfoutput>

<ul class="nav navbar-nav">
	<li class="dropdown active">
		<a href="/" class="mainmenu a_home">Home</a>
	</li>
	<li class="dropdown">
		<a href="staff.cfm" class="mainmenu a_servicesstaff">Services & Staff</a>
		<!--- <a href="##" class="dropdown-toggle" data-toggle="dropdown">Services
			<cfif getServices.recordcount><b class="caret"></b></cfif>
		</a>
		<cfif getServices.recordcount>
			<ul class="dropdown-menu">
				<cfloop query="getServices">
					<li><a href="ui-elements.html##buttons">#getServices.service_name#</a></li>
				</cfloop>
			</ul>
		</cfif> --->
	</li>
	<!--- <li class="dropdown hidden-sm">
		<a href="##" class="a_staff">Staff</a>
	</li> --->
	<li class="dropdown hidden-sm">
		<a href="contact.cfm" class="mainmenu a_contact">Contact us</a>
	</li>
	<cfif getPlan.Company_Service_Plan_ID gt 1>
		<li class="dropdown">
			<a href="appointments.cfm" id="a_onlinebooking" class="mainmenu">Online booking</a>
		</li>
		<li class="dropdown">
			<a href="gallery.cfm" class="mainmenu a_gallery">Photo Gallery</a>
		</li>
		<li class="dropdown">
			<a href="blog.cfm" class="mainmenu a_blog">Blog</a>
		</li>
		<!-- Profile links for extra small screens -->
		<li class="visible-xs"><a href="##" class="mainmenu a_signin">Sign In</a></li>
		<li class="visible-xs"><a href="##">Sign Out</a></li>
	</ul>
	<ul class="nav navbar-nav navbar-right hidden-xs">
		<!--- <cfif not structKeyExists(session,"customerid")> --->
		<cfif variables.customerid eq 0>
			<li id="sign-in" class="show"><a href="##" class="mainmenu a_signin">Sign In</a></li>
		</cfif>
		<cfset hiddenClass = "hidden">
		<!--- <cfif structKeyExists(session,"customerid")> --->
		<cfif variables.customerid neq 0>
			<cfset hiddenClass = "">
		</cfif>
		<!-- Signed in. Profile Menu -->
		<li id="cogs-menu" class="#hiddenClass#">
			<a href="edit-profile.html" class="mainmenu">
				<i class="fa fa-gears fa-lg"></i>
			</a>
		</li>
		<li id="profile-menu" class="dropdown #hiddenClass#">
			<a href="##" class="dropdown-toggle mainmenu" data-toggle="dropdown"><span class="user-name">#variables.user_name#</span> <b class="caret"></b></a>
			<ul class="dropdown-menu">
				<li class="account">
					<div class="avatar"></div>
					<p><span class="user-email">#variables.user_email#</span></p>
					
					<p><a href="customer_profile.cfm" class="a_profile">Profile</a> | <a href="customer_appointment_history.cfm" class="a_apphistory">Appointment History</a> | <a href="##" id="a_signout">Sign out</a></p>
					<div class="clearfix"></div>
				</li>
			</ul>
		</li>
		
	</ul>
	</cfif>
</cfoutput>