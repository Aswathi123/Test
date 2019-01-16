<cfset variables.feature_text="SalonWorks Support">
<cfset variables.title_no=5><!--- The number that determines the selected page in the nav menu --->
<cfinclude template="site_header.cfm">


<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script> 
<script>
$().ready(function() {
	$("#commentForm").validate();
});
</script>
<link href="sub_how.css" rel="stylesheet" type="text/css" />
<div class="welcome"> 
	<div class="txt"> 
	<cfif isDefined('form.submit')>
	<cfmail from="#form.email#" to="salonworkssupport@salonworks.com" cc="ciredrofdarb@gmail.com" subject="#form.subject#" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv">
From: #form.Name#
	
#form.Message#
	</cfmail>
	Thank you for your message.  We will respond to your request promptly.
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<cfelse>
	<h3>Need help? We're here to assist you!</h3>
	Fill out the form below and we will respond to your request promptly.
	<form action="support.cfm" method="post" id="commentForm">
	<table>
		<tr>
			<td>Name *</td>
			<td><input type="text" name="Name" size="44" required></td>
		</tr>
		<tr>
			<td>Email Address *</td>
			<td><input type="text" name="Email" size="44" required></td>
		</tr>
		<tr>
			<td>Subject *</td>
			<td><input type="text" name="Subject" size="44" required></td>
		</tr>
		<tr valign="top">
			<td>Message *</td>
			<td><textarea name="Message" cols="35" rows="10" required></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="Submit" name="submit" value="Submit Request"></td>
		</tr>
	</table>
	</cfif>
	</form>
	</div> <!-- txt -->
</div>  <!--  welcome --> 
<cfinclude template="site_footer.cfm">