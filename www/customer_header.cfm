<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">

<cfset variables.subdomain = ListgetAt(cgi.server_name,1,'.')>

<cfif session.Company_ID gt 0>
	<cfset variables.Company_ID = session.Company_ID>
</cfif>
<cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
	<cfinvokeargument name="Web_Address" value="#variables.subdomain#">
</cfinvoke>
<cfif session.Company_ID eq 0>
	<cfif qCompany.recordcount gt 0>
		<cfset variables.Company_ID=qCompany.Company_ID>
	<cfelse>
		<cfset variables.Company_ID=0>
	</cfif>
</cfif>
<cfinvoke component="admin.location" method="getLocation" returnvariable="qLocation">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>

<cfif qLocation.recordcount gt 0>
	<cfset variables.Location_ID=qLocation.Location_ID>
<cfelse>
	<cfset variables.Location_ID=0>
</cfif>

<cfinvoke component="admin.professionals" method="getProfessional" returnvariable="qProfessional">
	<cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
</cfinvoke>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<cfoutput>
		<title>#qCompany.Company_Name#</title>
		<link rel="stylesheet" href="/css/new_style.cfm?company_id=#variables.company_id#" type="text/css" media="screen,projection" />
</cfoutput>
		<script type="text/javascript">
			<!--
			if (parent.frames.length > 0) { parent.location.href = location.href; }
			-->
		</script>
	</head> 
	<body>
		<div id="page">
			<div id="wrapper" class="clearfloat">
				<div class="clearfloat" id="masthead">
					<div align="center"><img src="/images/masthead.jpg" alt="" /></div>
					<!--- <div id="description"> </div>  --->
				</div><!--END MASTHEAD-->
				<ul id="nav-cat" class="clearfloat">
					<li><a href="/" target="_self">Home</a></li>
				<cfif FindNoCase('/admin/',cgi.SCRIPT_NAME)>
					<li><a href="/admin/company_form.cfm" target="_self">Modify Company</a></li> 
					<li><a href="/admin/location_form.cfm" target="_self">Modify Location</a></li> 
					<li><a href="/admin/professionals_form.cfm" target="_self">Modify Professional</a></li> 				
				<cfelseif variables.Company_ID gt 0>
					<li><a href="contact.cfm" target="_self">Contact Us</a></li>   
					<li><a href="services.cfm" target="_self">Services</a></li>
					<li><a href="staff.cfm" target="_self">Staff</a></li><!--- 
					<li><a href="gallery.cfm" target="_self">Gallery</a></li> --->
				<cfelse>
					<li><a href="registerStep1.cfm" target="_self">Register</a></li>  
				</cfif>
				</ul>
				   <div id="content">			
	
<br />