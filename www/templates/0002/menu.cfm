<cfparam name="variables.title_no" default=1>
<div class="menu">
	<ul>
		<li><a href="/"  <cfif variables.title_no eq 1> class="current"</cfif>>Home</a></li>
		<li><a href="services.cfm" <cfif variables.title_no eq 2> class="current"</cfif>>Services</a></li>
		<li><a href="appointments.cfm" <cfif variables.title_no eq 3> class="current"</cfif>>Online Booking</a></li>
		<li><a href="/staff.cfm" <cfif variables.title_no eq 4> class="current"</cfif>>Staff</a></li>
		<!--- <li><a href="##">Gift Certificates</a></li>
		<li><a href="##">Testimonials</a></li> --->
		<li><a href="contact.cfm" <cfif variables.title_no eq 5> class="current"</cfif>>Contact Us</a></li>
	</ul>
</div> <!-- menu -->