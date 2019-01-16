<cfif Not IsDefined("Session.LocationID")>
	<cflocation url="login.cfm" />
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SalonWorks Admin</title>
	<cfoutput>
	<link rel="stylesheet" href="/css/new_style.cfm?company_id=#Session.LocationID#" type="text/css" media="screen,projection" />
    </cfoutput>
    <style type="text/css">
		#nav-cat{ font-size:12px;}
		body {font-size:12px;}
	</style>
   
</head>
<body>

<ul id="nav-cat" class="clearfloat">
	<li><a href="index.cfm" target="_self">Home</a></li>
    <li><a href="companyModify.cfm" target="_self">Modify Company</a></li> 
    <li><a href="locationModify.cfm" target="_self">Modify Location</a></li> 
    <li><a href="professionalModify.cfm" target="_self">Modify Professional</a></li> 
    <li><a href="companyThemesModify.cfm" target="_self">Modify Theme</a></li>
    <li><a href="availabilityCalendar.cfm" target="_self">Professional Availability</a></li>
</ul>
