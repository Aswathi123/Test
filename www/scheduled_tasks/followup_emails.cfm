<cfif not ListContains('99.103.70.43,107.194.73.65,75.103.109.211',cgi.REMOTE_ADDR)><cfabort></cfif>
<!--- Send E-mail One Week After Registration --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>

<!--- If, after 7 days, user hasn't completed configuration, send an email outlining all incomplete  --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>
<cfmail>
Hello #getUsers.FirstName# #getUsers.Last_Name#,

My name is Eric Bradford and as owner of SalonWorks, I would like to congratulate you on your new website, http://#getUsers#.salonworks.com!  I look forward to seeing your website become a successful tool in your overall business.

I encourage you to upload a photo to your front page and also a photo of yourself on your staff page.  To get the most of the service we provide, you will want to enter your services and availability to your calendar.  That will allow your clients to see all the services you provide and book their appointments online.  This will also give them the ability to receive text and/or email notifications of their upcoming appointments.  

Feel free to email me or call me at (978) 352-0235 if you need any help setting up your site.  I am here to help!

Thanks for your business,

Eric Bradford
</cfmail>
<!--- Day 21 of trial send email reminder that trial is almost over --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>
<cfmail>
Hello #getUsers.FirstName# #getUsers.Last_Name#,

This is just a friendly reminder that your free 30 day trial is going to expire soon.  Your site at http://#getUsers#.salonworks.com will always be free, however, you must upgrade your account to continue using Online Booking and other features of your website.  

Click the link below to upgrade your account and ensure that your Online Booking and other features are not interrupted.
</cfmail>
<!--- Send E-mail Day Trial Ends --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>
<cfmail>
Hello #getUsers.FirstName# #getUsers.Last_Name#,


</cfmail>
<!--- Send E-mail 7 days after trial ends --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>

<!--- Send E-mail every 3 months --->
<cfquery name="getUsers" datasource="#request.dsn#">

</cfquery>