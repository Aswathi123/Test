<cfparam name="Company_Email" default="">
<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/"> --->
<cfoutput>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<cfinclude template="#templatePath#contact_content.cfm">	
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
				console.log(data);
				if( data == true ) {
					$('#msgContact').addClass('alert-success');
					$('#msgContact').html('Thank you for your message. Someone will respond to you promptly.');
					$('#frmContact').find("input[type=text], textarea").val("");
				}
				else {
					$('#msgContact').addClass('alert-danger');
					$('#msgContact').html(data);
				}
			}
		});
	});
</script>