<cfquery name="getusers" datasource="salonworks">
SELECT DISTINCT 
                      dbo.Professionals.First_Name, dbo.Professionals.Last_Name, dbo.Professionals.Email_Address, dbo.Professionals.Password, dbo.Companies.Web_Address
FROM         dbo.Professionals INNER JOIN
                      dbo.Locations ON dbo.Professionals.Location_ID = dbo.Locations.Location_ID INNER JOIN
                      dbo.Companies ON dbo.Locations.Company_ID = dbo.Companies.Company_ID AND dbo.Professionals.Email_Address LIKE '%@%' AND 
                      dbo.Professionals.Password <> ''
<!--- WHERE 
	Professionals.Professional_ID=57 --->
</cfquery>
<cfabort>

<cfmail from="salonworks@salonworks.com" to="#getusers.Email_Address#" bcc="ciredrofdarb@gmail.com" subject="Your New SalonWorks Website Design" server="smtp.mandrillapp.com" port="587" username="salonworks@salonworks.com" password="foUbE3X7lPWKYiSPPCphlg" type="HTML">
<cfmailpart type="text/html">
<table width="800">
	<tr>
		<td align="center"><img src="http://salonworks.com/index_files/logo.png" border="0" align="center"></td>
	</tr>
	<tr>
		<td>			
			<p>
			<strong>Dear #getusers.First_Name#,</strong><br>
			We wanted to take a few minutes to let you know about the new look to <strong>your</strong> web site!  We have changed <strong>your</strong> SalonWorks website to use our new design and will be following with more designs to choose from soon.</p>

			<p>Follow the link below and give us your feedback! <br>
			<strong>http://#getusers.Web_Address#.salonworks.com</strong></p>
			 		
			<p>If you have not done so already, set up your availability and services to begin taking appointments from your clients online.</p>
			<p><a href="http://www.salonworks.com/admin/login.cfm?e=#getusers.Email_Address#&p=#getusers.Password#">Click to begin configuring your calendar and services</a></p>
			<p>Remember, your basic website is always free and your trial account that includes online booking has been extended through June 1, 2014!</p>

			<p>Your login information is as follows:<br>
			<strong>Username:</strong> #getusers.Email_Address# <br>
			<strong>Password:</strong> #getusers.Password# <br>			
			</p>
			
			<p>*Add salonworks@salonwkorks to your address book to make sure you don't miss out on our emails.</p> 
			
			<p>
			SalonWorks Customer Support<br>
			salonworks@salonworks.com<br>
			(978) 352-0235
			</p>
		</td>
	</tr>
</table>

</cfmailpart>

</cfmail>