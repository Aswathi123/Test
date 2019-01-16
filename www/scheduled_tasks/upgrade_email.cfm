<cfquery name="getUsers" datasource="salonworks">
SELECT    DISTINCT dbo.Professionals.First_Name, dbo.Professionals.Last_Name, dbo.Companies.Web_Address, dbo.Professionals.Email_Address, dbo.Professionals.Password, 
                      dbo.Companies.Trial_Expiration
FROM         dbo.Professionals INNER JOIN
                      dbo.Locations ON dbo.Professionals.Location_ID = dbo.Locations.Location_ID INNER JOIN
                      dbo.Companies ON dbo.Locations.Company_ID = dbo.Companies.Company_ID
WHERE
	dbo.Companies.Trial_Expiration = '2014-10-28'
	AND dbo.Professionals.Email_Address like '%@%'
	and dbo.Professionals.Password > ''
	AND dbo.Professionals.Email_Address not like '%ciredrofdarb@gmail.com%'

</cfquery>
<cfdump var="#getUsers#" abort="true"><!---  --->
<cfmail from="salonworks@salonworks.com" to="#getUsers.Email_Address#" subject="Your SalonWorks Trial Has Been Extended!" type="HTML" query="getUsers">
<!doctype html>
 <html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="viewport" content="initial-scale=1.0" />
  <meta name="format-detection" content="telephone=no" />
  <title></title>
  <style type="text/css">
 	body {
		width: 100%;
		margin: 0;
		padding: 0;
		-webkit-font-smoothing: antialiased;
	}
	@media only screen and (max-width: 600px) {
		table[class="table-row"] {
			float: none !important;
			width: 98% !important;
			padding-left: 20px !important;
			padding-right: 20px !important;
		}
		table[class="table-row-fixed"] {
			float: none !important;
			width: 98% !important;
		}
		table[class="table-col"], table[class="table-col-border"] {
			float: none !important;
			width: 100% !important;
			padding-left: 0 !important;
			padding-right: 0 !important;
			table-layout: fixed;
		}
		td[class="table-col-td"] {
			width: 100% !important;
		}
		table[class="table-col-border"] + table[class="table-col-border"] {
			padding-top: 12px;
			margin-top: 12px;
			border-top: 1px solid ##E8E8E8;
		}
		table[class="table-col"] + table[class="table-col"] {
			margin-top: 15px;
		}
		td[class="table-row-td"] {
			padding-left: 0 !important;
			padding-right: 0 !important;
		}
		table[class="navbar-row"] , td[class="navbar-row-td"] {
			width: 100% !important;
		}
		img {
			max-width: 100% !important;
			display: inline !important;
		}
		img[class="pull-right"] {
			float: right;
			margin-left: 11px;
            max-width: 125px !important;
			padding-bottom: 0 !important;
		}
		img[class="pull-left"] {
			float: left;
			margin-right: 11px;
			max-width: 125px !important;
			padding-bottom: 0 !important;
		}
		table[class="table-space"], table[class="header-row"] {
			float: none !important;
			width: 98% !important;
		}
		td[class="header-row-td"] {
			width: 100% !important;
		}
	}
	@media only screen and (max-width: 480px) {
		table[class="table-row"] {
			padding-left: 16px !important;
			padding-right: 16px !important;
		}
	}
	@media only screen and (max-width: 320px) {
		table[class="table-row"] {
			padding-left: 12px !important;
			padding-right: 12px !important;
		}
	}
	@media only screen and (max-width: 608px) {
		td[class="table-td-wrap"] {
			width: 100% !important;
		}
	}
  </style>
 </head>
 <body style="font-family: Arial, sans-serif; font-size:13px; color: ##444444; min-height: 200px;" bgcolor="##E4E6E9" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
 <table width="100%" height="100%" bgcolor="##E4E6E9" cellspacing="0" cellpadding="0" border="0">
 <tr><td width="100%" align="center" valign="top" bgcolor="##E4E6E9" style="background-color:##E4E6E9; min-height: 200px;">
<table style="table-layout: auto; width: 100%; background-color: ##438eb9;" width="100%" bgcolor="##438eb9" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td width="100%" align="center" style="width: 100%; background-color: ##438eb9;" bgcolor="##438eb9" valign="top"><table class="table-row-fixed" height="50" width="600" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="navbar-row-td" valign="middle" height="50" width="600" data-skipstyle="true" align="left">
 <table class="table-row" style="table-layout: auto; padding-right: 16px; padding-left: 16px; width: 600px;" width="600" cellspacing="0" cellpadding="0" border="0"><tbody><tr style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
   <td class="table-row-td" style="padding-right: 16px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; vertical-align: middle;" valign="middle" align="left">
     <a href="##" style="color: ##ffffff; text-decoration: none; padding: 10px 0px; font-size: 18px; line-height: 20px; height: auto; background-color: transparent;">
	 Your SalonWorks Trial Has Been Extended!
	 </a>
   </td> 
 </tr></tbody></table>
</td></tr></tbody></table></td></tr></tbody></table>


<table class="table-space" height="8" style="height: 8px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="8" style="height: 8px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td></tr></tbody></table>

<table class="table-row-fixed" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-fixed-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 24px; padding-right: 24px;" valign="top" align="left">
   <table class="table-col" align="left" width="285" style="padding-right: 18px; table-layout: fixed;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	 <table class="header-row" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="267" style="font-size: 28px; margin: 0px; font-family: Arial, sans-serif; font-weight: normal; line-height: 23px; color: ##478fca; padding-bottom: 10px; padding-top: 15px;" valign="top" align="left">Hi #getUsers.First_Name# #getUsers.Last_Name#,</td></tr></tbody></table>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
We have great news! We have extended your trial account until #DateFormat(getUsers.Trial_Expiration,'mm/dd/yyyy')# to give you the opportunity to take advantage of our new features:
</p><br>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
<span style="font-family: Arial, sans-serif; line-height: 19px; color: ##333333; font-size: 16px;">New and Improved Calendar</span><br>
We have completely revamped our Calendar from scratch.  It is much more user-friendly and flexible.  You can add your availability in blue and your appointments in red.  Your customers will get an email confirmation of their appointment and reminder by email and text 24 hours before their scheduled time.  
</p><br>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
<span style="font-family: Arial, sans-serif; line-height: 19px; color: ##333333; font-size: 16px;">Customer Management</span><br>
Now you can manage all of your clientele online.  Keep information about each of your customers including things like their birthday and other notes.  Your customers now also have the ability to manage their own profiles.
</p><br>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
<span style="font-family: Arial, sans-serif; line-height: 19px; color: ##333333; font-size: 16px;">Photo Gallery</span><br>
Begin uploading images of your work!  Our new photo gallery makes it easy to upload photos to your website, which are displayed in an attractive page for visitors to your site to view.
</p><br>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
<span style="font-family: Arial, sans-serif; line-height: 19px; color: ##333333; font-size: 16px;">Blog</span><br>
Keep your website current by publishing articles to your site.  This is a good way to keep users coming back to your site.
	 </p><br>
<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">
<span style="font-family: Arial, sans-serif; line-height: 19px; color: ##333333; font-size: 16px;">Inquiries Interface</span><br>
When users fill out the form on your Contact page, you will receive an e-mail of each message.  Now, with the new Inquiries Interface, you can see all those messages in one place and manage them easily.
</p>
   </td></tr></tbody></table>
   <table class="table-col" align="left" width="267" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="267" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
    <table class="table-space" height="6" style="height: 6px; font-size: 0px; line-height: 0; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="6" style="height: 6px; width: 267px; background-color: ##ffffff;" width="267" bgcolor="##FFFFFF" align="left">&nbsp;</td></tr></tbody></table>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
		<div align="center"><img src="http://salonworks.com/img/logo.png"></div>
		<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 0px;" valign="top" align="left">Your Login Information</td></tr></tbody></table> 
		<table class="table-space" height="10" style="height: 10px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="10" style="height: 10px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td></tr></tbody></table>

	<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">Username: #getUsers.Email_Address#</p><br>
	<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">Password: #getUsers.Password#</p><br>
	
	<p style="margin: 0px; font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px;">Your web address is http://#getUsers.Web_Address#.salonworks.com </p>
<br>
<div align="center"><a href="http://www.salonworks.com/admin/" style="color: ##ffffff; text-decoration: none; margin: 0px; text-align: center; vertical-align: baseline; border: 4px solid ##d15b47; padding: 4px 9px; font-size: 14px; line-height: 19px; background-color: ##d15b47;"> &nbsp; &nbsp; &nbsp; Login Now! &nbsp; &nbsp; &nbsp; </a></div>
	</td></tr></tbody></table>
	<br>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td width="100%" bgcolor="##f5f5f5" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding: 19px; border: 1px solid ##e3e3e3; background-color: ##f5f5f5;" valign="top" align="left">
		
		<table class="table-space" height="12" style="height: 12px; font-size: 0px; line-height: 0; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="12" style="height: 12px; width: 100px; background-color: transparent;" width="100" bgcolor="transparent" align="left">&nbsp;</td></tr></tbody></table> 
		<table class="header-row" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="header-row-td" width="100%" style="font-family: Arial, sans-serif; font-weight: normal; line-height: 19px; color: ##478fca; margin: 0px; font-size: 18px; padding-bottom: 8px; padding-top: 10px;" valign="top" align="left">Contact Info</td></tr></tbody></table>
		Phone: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">(978) 352-0235</span>
		<br>
		Email: <span style="font-family: Arial, sans-serif; line-height: 19px; color: ##31708f; font-size: 13px;">salonworks@salonworks.com</span>
	</td></tr></tbody></table>
   </td></tr></tbody></table>
</td></tr></tbody></table>

<table class="table-space" height="32" style="height: 32px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="32" style="height: 32px; width: 600px; padding-left: 18px; padding-right: 18px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="center">&nbsp;<table bgcolor="##E8E8E8" height="0" width="100%" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td bgcolor="##E8E8E8" height="1" width="100%" style="height: 1px; font-size:0;" valign="top" align="left">&nbsp;</td></tr></tbody></table></td></tr></tbody></table>

<table class="table-row" width="600" bgcolor="##FFFFFF" style="table-layout: fixed; background-color: ##ffffff;" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-row-td" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal; padding-left: 36px; padding-right: 36px;" valign="top" align="left">
 <table class="table-col" align="left" width="528" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed;"><tbody><tr><td class="table-col-td" width="528" style="font-family: Arial, sans-serif; line-height: 19px; color: ##444444; font-size: 13px; font-weight: normal;" valign="top" align="left">
	 <div style="font-family: Arial, sans-serif; line-height: 19px; color: ##777777; font-size: 14px; text-align: center;">&copy; 2014 SalonWorks.com</div> 
 </td></tr></tbody></table>
</td></tr></tbody></table>
<table class="table-space" height="14" style="height: 14px; font-size: 0px; line-height: 0; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="table-space-td" valign="middle" height="14" style="height: 14px; width: 600px; background-color: ##ffffff;" width="600" bgcolor="##FFFFFF" align="left">&nbsp;</td></tr></tbody></table>
</td></tr>
 </table>
 </body>
 </html>
</cfmail>