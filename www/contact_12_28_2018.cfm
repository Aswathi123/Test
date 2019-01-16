<cfparam name="Company_Email" default="">
<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/0001/"> --->
<cfoutput>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">

	<div class="col-md-8" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Contact Us</span>
			</h2>
		</div>
		<div class="content">
			<cfif Len(Trim(qCompany.Company_Email))>
				<cfset Company_Email = qCompany.Company_Email>
			</cfif>
			<cfif Len(Trim(qLocation.Location_Address))>
				<div class="row col-md-12">#qLocation.Location_Address#</div>
			</cfif>
			<cfif Len(Trim(qLocation.Location_Address2))>
				<div class="row col-md-12">#qLocation.Location_Address2#</div>
			</cfif>
			<cfif Len(Trim(qLocation.Location_City))>
				<div class="row col-md-12">#qLocation.Location_City#, #qLocation.Location_State# #qLocation.Location_Postal#</div>
			</cfif>
			<cfif Len(Trim(qLocation.Location_Phone))>
				<div class="row col-md-12">Phone: #qLocation.Location_Phone#</div>
			</cfif>
			<cfif Len(Trim(qLocation.Location_Fax))>
				<div class="row col-md-12">Fax: #qLocation.Location_Fax#</div>
			</cfif>
			<cfif Len(Trim(qCompany.Company_Email))>
				<div class="row col-md-12">Email: #qCompany.Company_Email#</div>
			</cfif>
			<div class="row col-md-12">
				<hr />
			</div>
			
			<form id="frmContact" name="frmContact" action="contact.cfm" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="Location_ID" value="#qLocation.location_id#">
				<input type="hidden" name="Company_Email" value="#Company_Email#">
				<div class="row col-md-12">
					<p>
						To leave us a message, fill out the form below: <br/>
					</p>
				<div id="msgContact" class="alert">&nbsp;</div>
				</div>
				<div class="form-group">
					<label for="Name" class="control-group col-md-4">Name:</label>
					<div class="col-md-6">
						<input type="text" id="Name" name="Name" class="form-control" maxlength="100" />
					</div>
				</div>
				<div class="form-group">
					<label for="Email" class="control-group col-md-4">Email Address:</label>
					<div class="col-md-6">
						<input type="text" id="Email" name="Email" class="form-control" maxlength="50" />
					</div>
				</div>
				<div class="form-group">
					<label for="Phone" class="control-group col-md-4">Phone Number:</label>
					<div class="col-md-6">
						<input type="text" id="Phone" name="Phone" class="form-control" maxlength="50" />
					</div>
				</div>
				<div class="form-group">
					<label for="Message" class="control-group col-md-4">Enter message below:</label>
					<div class="col-md-6">
						<textarea name="Message" class="form-control"></textarea>
					</div>
				</div>
				<hr />
				<div class="form-group">
					<div class="col-md-10">
						<button type="button" id="btnSendMessage" class="btn btn-danger" >Send</button>
					</div>
				</div>
			</form> 
		<!---  <cfif isDefined('form.name')>
				Thank you for your message. Someone will respond to you promptly.
				<cfdump var="#Len(Trim(qCompany.Company_Email))#"><cfabort> 
		</cfif>	 --->
			
				<!---	<cfquery name="qryLogInquiry" datasource="#request.dsn#">
					INSERT INTO Inquiries (Sender_Name,Sender_Email,Sender_Phone,Sender_Message,Location_ID)
					VALUES
						(
							<cfqueryparam value="#form.Name#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#form.Phone#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#form.Message#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#qLocation.Location_ID#" cfsqltype="cf_sql_integer" />
						)
				</cfquery>	
						
				<cfif Len(Trim(qCompany.Company_Email))>
					<cfmail from="noreply@salonworks.com" to="#qCompany.Company_Email#" subject="Web Site Inquiry">
					This message was sent from you the Contact Us page on your SalonWorks web site.
					
					Name: #form.Name#
					Email Address: #form.Email#
					Phone Number: #form.Phone#
					Message:
					#Message#
					</cfmail>
				</cfif>
			
			
			<cfelse>
				<cfform action="contact.cfm" method="post">
				To leave us a message, fill out the form below: 
				<table border="0">
					<tr><td>Name:</td> <td><input type="text" name="Name"></td> </tr>
				<tr>	<td>Email Address:</td> <td><input type="text" name="Email"></td> </tr>
				<tr>	<td>Phone Number:</td> <td><input type="text" name="Phone"></td> </tr>
					<tr><td colspan="2">Enter message below</td></tr> 
					<tr><td colspan="2"><textarea name="Message" cols="30" rows="5"></textarea></td> </tr>
					<tr><td colspan="2"><input type="submit" value="Submit"></td></tr>
				</table>
				</cfform>
			</cfif> --->
			
		</div><!-- content -->
	</div>
	<div class="col-md-4">
		<div class="block-header">
			<h2>
			<span class="title">INFO</span>
			</h2>
		</div>
		<cfinclude template="#templatePath#info_sidebar.cfm">					
	</div>
	<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput>

<script type="text/javascript">
$('#btnSendMessage').on('click', function() {
	
	$('#frmContact').validate({
		rules: {
			Name: { required: true },
			Email: { required: true, email: true },
			Phone: { required: true },
			Message: { required: true }
		}
	});
	
	if ( !$('#frmContact').valid() )
		return false;
		
	$.ajax({
			type: "post",
			url: "/cfc/inquiries.cfc?method=logInquiry&returnFormat=JSON",
			dataType: "json",
			data: $('#frmContact').serialize(),
			success: function (data){
				if( data == true ) {
					$('#msgContact').addClass('alert-success');
					$('#msgContact').html('Thank you for your message. Someone will respond to you promptly.');
				}
				else {
					$('#msgContact').addClass('alert-danger');
					$('#msgContact').html(data);
				}
			}
	});
});
</script>