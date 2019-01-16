<script type="text/javascript">
$(".nav a").on("click", function(){
   $(".nav").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});
</script>
<cfoutput>
<cfinvoke component="admin.blog" method="getBlogPost" returnvariable="qBlogPost">
	<cfinvokeargument name="Company_ID" value="#qCompany.Company_ID#"> 	
</cfinvoke>
<ul class="nav navbar-nav">
	<li  <cfif cgi.script_name eq '/index.cfm'>class="dropdown active"<cfelse>class="dropdown" </cfif> >
		<a href="/" class="mainmenu a_home">Home</a>
	</li>
	<li  <cfif cgi.script_name eq '/staff.cfm'>class="dropdown active" <cfelse> class="dropdown"</cfif>>
		<a href="staff.cfm"  class="mainmenu a_servicesstaff">Services & Staff</a>
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
	<li  <cfif cgi.script_name eq '/contact.cfm'>class="dropdown active hidden-sm" <cfelse> class="dropdown hidden-sm"</cfif>>
		<a href="contact.cfm" class="mainmenu a_contact">Contact us</a>
	</li>
	<cfif not( getPlan.Company_Service_Plan_ID gt 1  AND (DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0 AND (NOT getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)))) >
		<li  <cfif cgi.script_name eq '/appointments.cfm'>class="dropdown active " <cfelse> class="dropdown"</cfif>>
			<a href="appointments.cfm" id="a_onlinebooking" class="mainmenu">Online booking</a>
		</li>
		<li  <cfif cgi.script_name eq '/gallery.cfm'>class="dropdown active " <cfelse> class="dropdown"</cfif>>
			<a href="gallery.cfm" class="mainmenu a_gallery">Photo Gallery</a>
		</li>
		<cfif qBlogPost.recordcount>
			<li  <cfif cgi.script_name eq '/blog.cfm'>class="dropdown active " <cfelse> class="dropdown"</cfif>>
				<a href="blog.cfm" class="mainmenu a_blog">Blog</a>
			</li>
		</cfif>
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