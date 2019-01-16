<!--- variable declaration begins --->
<cfset variables.page_title = "Email customers">
<cfset variables.professional_id = session.professional_id>
<cfset variables.company_id = session.company_id>
<cfset variables.getServiceList = "">
<cfset variables.emailContent = "">
<cfset variables.emailSubject = "">
<cfset variables.successMessage ="">
<cfset variables.selectedRadioButton = 0>
<cfset variables.serviceId = "">
<cfset variables.objEmail_campaign = createObject("component","admin.email_campaign")>
<!--- variable declaration ends --->

<!--- control flow begins --->
<cfif isDefined("sendMailBtn")>	
	<cfset getValuesFromForm()>
	<cfif variables.selectedRadioButton eq 1>
		<cfset variables.objEmail_campaign.sendMailToALLCustomers(variables)>
		<cflocation url="email_campaign.cfm?msg=allCustomer" addtoken="false">
	<cfelse>
		<cfset variables.objEmail_campaign.sendMailToSelectedCustomers(variables)>	
		<cflocation url="email_campaign.cfm?msg=selectedCustomer" addtoken="false">
	</cfif>	
	<cfset variables.objEmail_campaign.addEmailDetailsToDatabase(variables)>
<cfelseif isDefined("url.msg")>
	<cfif url.msg eq "allCustomer">
		<cfset variables.successMessage = "Email sent successfully to all customers">	
	<cfelse>
		<cfset variables.successMessage = "Email sent successfully to customers with selected services">
	</cfif>	
</cfif>
<cfset variables.getServiceList = variables.objEmail_campaign.getServices(variables.professional_id)>
<!--- control flow ends --->

<!--- function block begins --->
<cffunction name="getValuesFromForm" description="To get values from form">
    <cfset variables.emailContent = form.content>
	<cfset variables.emailSubject = form.emailSubject>
	<cfset variables.selectedRadioButton = form.radio_customer_mail>
	<cfif variables.selectedRadioButton eq 2>
		<cfset variables.serviceId = form.serviceId>	
	</cfif>
</cffunction>

<cffunction name="getUrlMessage" description="To get service Id from form">
    <cfreturn url.msg>
</cffunction>
<!--- function block ends --->

<!--- HTML Block begins --->
<cfinclude template="header.cfm"> 
<cfoutput>
	<cfif len(trim(successMessage))>
		<div class="alert alert-success showDiv">
			<i class="icon-ok green"></i>
			<a href="##" class="close" data-dismiss="alert" aria-label="close"><i class="icon-remove"></i></a>
    		<cfoutput>#variables.successMessage#</cfoutput>
    	</div>
	</cfif>	
	<div class="row">
		<div class="col-sm-9" style="margin-left: 250px;">
			<form method="POST" action="" onsubmit="getMessage()">
				<div class="row">
					<div class="form-group">
						<div class="bold">
							<label for="radio_customer_mail" class="col-sm-3 control-label">Send email to* : </label>
						</div>
						<div class="col-sm-10">
							<input type="radio"  name="radio_customer_mail" id="to_all_customers" value="1" />
							All customers 
							<div class="bottom">
								<input type="radio"  name="radio_customer_mail" id="to_service_customers" value="2"/>
								Customers who have purchased following services:
							</div>
						</div>
						<div class="form-group hide" id="customerList">							
							<cfif variables.getServiceList.recordcount GT 0>
								<div class="servicesDiv">
									<div class="row "></div>
									<cfset variables.counter = 0>
									<cfloop query="variables.getServiceList" >								
										<input name="serviceId" value="#variables.getServiceList.SERVICE_ID#" type="checkbox" class="services"
										id="#variables.getServiceList.SERVICE_ID#">#variables.getServiceList.SERVICE_NAME#  &nbsp;	
										<cfset variables.counter ++>
										<cfif (variables.counter % 4) eq 0>
											<div></div>
										</cfif>												
									</cfloop>
								</div>	
							<cfelse>
								<div class="NoservicesDiv">
									No services available
								</div>
							</cfif>					
						</div>
					</div>
				</div>
				<div class="row">
					<div class="emailSubjectDiv">
						<div >
							<label for="emailSubject" class="col-sm-3 control-label ">Subject*</label>
						</div>
						<div class="emailSubjectTextDiv">
							<input type="text" name="emailSubject" class="form-control" id="emailSubject" value="">
						</div>
					</div>
					<div class="form-group bottom">
						<div class="col-sm-9">
							<div id="email_campaign_summernote" class="bottom"></div>
						</div>
					</div>
				</div>
				<div class="row top">
					<div class="form-group top">
						<div class="col-sm-9">
							<input type="submit" id="sendMailBtn" name="sendMailBtn" value="SendMail" disabled />
						</div>
					</div>
				</div>
				<div class="hiddenDiv">
					<textarea id="content" name="content" value=""></textarea>
				<div>
			</form>
		</div>
	</div>
</cfoutput>
<cfinclude template="footer.cfm">
<!--- HTML Block ends ---> 

<!--- script begins --->
<script type="text/javascript">
	function getMessage(){
		var sHTML = document.getElementsByClassName('note-editable')[0];
		var contents = $('#email_campaign_summernote').code();
		$("#content").val(contents);
	}
	$(document).ready(function() {
		$('#email_campaign_summernote').summernote({
			height: 300,
		  	focus: false,
		    toolbar: [
	      		['style', ['style', 'bold', 'italic', 'underline', 'clear']],
		      	['fontsize', ['fontsize']],
		      	['color', ['color']],
		      	['para', ['ul', 'ol', 'paragraph']]
		    ]
		});
		var radioButtonsTo_all_customers = $("#to_all_customers");
		radioButtonsTo_all_customers.click(function() {
		  	$("#sendMailBtn").attr("disabled", !radioButtonsTo_all_customers.is(":checked"));
		});
		var radioButtonsTo_service_customers = $("#to_service_customers");
		radioButtonsTo_service_customers.click(function() {
			$("#customerList").removeClass('hide');
		  	$("#sendMailBtn").attr("disabled", radioButtonsTo_service_customers.is(":checked"));
	  		$("input[type='checkbox']").prop("checked", false);
		});
		var chekbox = $("input[type='checkbox']");
		chekbox.click(function() {
 	 		$("#sendMailBtn").attr("disabled", !chekbox.is(":checked"));
		});
		$('#to_all_customers').click(function(){
			$("#customerList").hide();
		});
		$("#customerList").hide();
		$('#to_service_customers').click(function(){
			$("#customerList").show();
		});
	});
</script>
<!--- script ends --->