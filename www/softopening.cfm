<cfsetting RequestTimeout = "999999"> 
<cfquery name="getEmails" datasource="preferredce">
	SELECT  distinct top 2000 Email, Max(FirstName) as FirstName, Max(LastName) as LastName, StudentID
	FROM Students
	WHERE 
	--Email IN (SELECT Email FROM SoftOpening)
	--AND 
	Email like '%@%'
	 AND StudentID < 92087 
	-- AND LTrim(RTrim(Email)) NOT IN (SELECT LTrim(RTrim(Email)) as Email FROM SoftOpening)
	AND Email IN (
SELECT TOP 2000 [Email] 
  FROM [SoftOpening]
  where DateAdded is not null
  and email !='ciredrofdarb@gmail.com'
  Order by DateAdded desc
	)
	GROUP BY Email, StudentID
	 ORDER BY StudentID desc
</cfquery> 
<cfdump var="#getEmails#" abort="true">

<cfoutput query="getEmails">
<cftry>
<cfquery name="getexisting" datasource="preferredce">
select email from softopening where Email='#Replace(getEmails.Email,' ', '','all')#'
</cfquery>
<!---<cfdump var="#getexisting#">--->
<cfif getexisting.recordcount eq 0 or 1 eq 1>
<cfmail from="salonworks@salonworks.com" to="#Replace(getEmails.Email,' ', '','all')#" subject="Manage Your Salon Appointments Online" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" type="HTML">
<cfmailpart type="text/html">
		<div style="background: ##f0f3f6; min-height: 100vh;">
			<div class="container" style="margin: auto; max-width: 100%; width: 840px; border:1px solid ##ddd; border-bottom: 0; background: ##fff;">
				<table class="main-width" style="border-spacing: 0; width:100%;" border="0" cellspacing="0" cellpadding="0"><!--logo-space-->
					<tbody>
						<tr>
							<td>
								<table style="width: 840px; margin: auto; border-spacing: 0px;"><!--text-content-->
									<tbody>
										<tr class="" style="width: 100%; background: ##fff; text-align: center;">
											<td style="padding: 20px 0;"> <a href=""><img src="http://salonworks.com/img/logo.png" alt=""></a></td>
										</tr>
										<table border="0" cellspacing="0" cellpadding="0" style=" height:265px; width: 100%; text-align: left;">
											<tr>
												<td style="padding: 10px 50px;">

													<h2 style="font-family: Roboto, sans-serif, arial;" >Hello #getEmails.FirstName# #getEmails.LastName#,</h2>

													<p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; margin-bottom:40px;">
														Welcome to the SalonWorks Soft Opening! You have been chosen to receive an absolutely free account that will make running your day-to-day business more efficient.<br><br>

														We would like to extend an offer to you to try our new website featuring our appointment booking system. Bring your business online by allowing your clients to book their own appointments, reduce no-shows with client text reminders, and much more.<br><br>

														This is not a trial, but it is a promotion for you to use our product at no cost to you.  To take advantage of this offer, simply sign up on our site before 9/30/2018. All registrations before that date will be free for life.  All we ask is that you give us honest feedback.  That's it!!  There is absolutely no risk to you.  <br><br>

														Visit our site at www.salonworks.com to sign up!  Or e-mail salonworks@salonworks.com to schedule a demo.<br><br>

														<a href="https://www.youtube.com/watch?v=Jz-W4mLjkwA">View our video below to learn more.</a><br><br>

														

														If you have any questions or comments you can contact us using the information below
														salonworks@salonworks.com<br><br>


														(978) 352-0235
													</p>
												</td>
											</tr>
											<tr>
												<td style="padding: 10px 50px;">
													<p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; padding-top: 25px; border-top: 1px solid ##eee;">
														Regards,<br>
														SalonWorks Customer Support<br>
														salonworks@salonworks.com
											 		</p>
												</td>
											</tr>
										</table>
										<table border="0" cellspacing="0" cellpadding="0" style=" height:95px; width: 100%; text-align: center; background: ##2995d3; padding: 34px 5px;">
											<tr>
												<td style="width: 33%; float: left; ">
													<a href="https://www.facebook.com/pages/Salonworks/1434509316766493" style="margin-right: 10px;"><img src="http://salonworks.com/images/facebook_round.png" alt=""></a>
												</td>
												<td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
													<img src="http://salonworks.com/images/call.png" alt="" style="vertical-align: middle; margin-right: 5px;">
													<label>
													 <a href="tel:+ (978) 352-0235" style="color: ##fff; text-decoration:  none;">+ (978) 352-0235</a>
													</label>
												</td>
												<td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
													<img src="http://salonworks.com/images/mail.png" alt="" style="vertical-align: middle; margin-right: 5px;">
													<label>
													 <a href="mailto:salonworks@salonworks.com" style="color: ##fff; text-decoration:  none;">salonworks@salonworks.com </a>
													</label>
												</td>
											</tr>
										</table>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</cfmailpart>
</cfmail>
</cfif>
<cfcatch>
</cfcatch>
</cftry>
<cfquery name="insert" datasource="preferredce">
INSERT INTO SoftOpening (Email) VALUES('#getEmails.Email#')
</cfquery> 
</cfoutput>