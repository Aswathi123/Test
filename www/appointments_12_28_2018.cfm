<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/0001/"> --->
<cfif not structKeyExists(form, 'submitType') >
<cfset variables.company_phone = "" />
<cfoutput>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<cfif structKeyExists(qCompany, "Company_Phone")>
		<cfset variables.company_phone = qCompany.Company_Phone/>
	</cfif>
</cfoutput>
</cfif>
<!--- <cfset variables.PageTitle ="Book Your Next Appointment Online">
<cfset variables.title_no = 3>
<cfinclude template="/templates/0001/header.cfm"> --->
<cfset variables.blnShowBooking = false />
<cfset variables.blnFailed = false />
<cfset variables.FailedMsg = "" />
<cfset variables.Professional_ID = 0 />
<cfset variables.ServiceID = 0 />
<cfset variables.AvailableDate = DateFormat(Now(),'mm/dd/yyyy') />
<cfset variables.AvailableTime = 0 />
<cfset variables.ServiceTime = 0 />

<cfif structKeyExists(form, 'submitType') AND Len(form.submitType) AND structKeyExists(form, 'availableDate') AND Len(form.availableDate) >

	<cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />	

	<cfset variables.Professional_ID = form.selProfessional />
	<cfset variables.ServiceID = form.selService />
	<cfset variables.AvailableDate = form.availableDate />
	<cfset variables.AvailableTime = form.selAvailableTimes />
	<cfset variables.ServiceTime = form.serviceTime />
	
	<cfif form.submitType EQ "Register">
		<!--- register and login --->
		<cfset variables.results = variables.objCFC.registerCustomer(form.emailAddress, form.pw, form.firstName, form.lastName, form.ph) />
	
		<cfif Not variables.results.Success>
			<cfset variables.blnFailed = true />
			<cfset variables.FailedMsg = variables.results.FailedMsg />
		</cfif>
	<cfelseif form.submitType EQ "Login">
		<!--- login --->
		<cfset variables.results = variables.objCFC.loginCustomer(form.emailAddress, form.pw) />
		
		<cfif Not variables.results.Success>
			<cfset variables.blnFailed = true />
			<cfset variables.FailedMsg = variables.results.FailedMsg />
		</cfif>
		
	</cfif>
	
	<!--- If after register or login above then book --->	
	<cfif form.submitType EQ "Book" Or (Not variables.blnFailed)>
		<cfset variables.AppointmentStartTime = ParseDateTime(form.availableDate & " " & form.selAvailableTimes) />
		<cfset variables.AppointmentEndTime = DateAdd("n", form.serviceTime, variables.AppointmentStartTime) />
		
		<cfif form.changeAppointmentID GT 0>
			<cfset variables.qryOldAppointment = variables.objCFC.getBookAppointment(form.changeAppointmentID) />
		</cfif>
			
		<cfset variables.results = variables.objCFC.bookAppointment(
																	CustomerID = Session.CustomerID,
																	Professional_ID = form.selProfessional,
																	ServiceID = form.selService,
																	StartDateTime = variables.AppointmentStartTime,
																	EndDateTime = variables.AppointmentEndTime,
																	ChangeAppointmentID = form.changeAppointmentID) />

		<cfif Not variables.results.Success>
			<cfset variables.blnFailed = true />
			<cfset variables.FailedMsg = variables.results.FailedMsg />
		<cfelse>
			<cfset variables.blnShowBooking = true />
			<cfset variables.qryResults = variables.results.qryResults />
			<cfset variables.AppointmentID = variables.qryResults.Appointment_ID />

			<!--- Email Customer #variables.qryResults.CustomerEmail#--->
			<cfmail from="no-reply@salonworks.com" server="smtp-relay.sendinblue.com" port="587" To="#variables.qryResults.CustomerEmail#" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" replyto="no-reply@salonworks.com" Subject="Appointment" type="html">
		    <html>
			<body>
				<p>#variables.qryResults.CustomerName#,</p>
				<p>
					Appointment Details: <strong>#form.serviceDesc#</strong><br />
					Date: <strong>#DateFormat(variables.AppointmentStartTime,"long")#</strong><br />
					Time: <strong>#TimeFormat(variables.AppointmentStartTime,"medium")#</strong><br />
					Stylist: <strong>#variables.qryResults.ProfessionalName#</strong><br />
					Location: <strong>#variables.qryResults.Location_Name# (ph: #variables.qryResults.Location_Phone#)</strong> <br />
					Address: <strong>#variables.qryResults.LocationDesc#</strong>
				</p>
				
				<p><br /></p>
				<p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IS NOT MONITORED--</em></p>
			</body>      
			</html> 
           	</cfmail>

			<!--- Email Previous Appointment Professional --->
		 	<cfif form.changeAppointmentID GT 0>
				<cfmail from="no-reply@salonworks.com" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" To="#variables.qryResults.ProfessionalEmail#" replyto="no-reply@salonworks.com" Subject="Appointment Cancellation" type="html">
			    <html>
				<body>
					<p>#variables.qryOldAppointment.First_Name# #variables.qryOldAppointment.Last_Name#,</p>
					<p>The following appointment has been cancelled. </p>
					<p>
						Appointment Details: <strong>#variables.qryOldAppointment.Service_Name#</strong><br />
						Date: <strong>#DateFormat(variables.qryOldAppointment.Start_Time,"long")#</strong><br />
						Time: <strong>#TimeFormat(variables.qryOldAppointment.End_Time,"medium")#</strong><br />
						Location: <strong>#variables.qryOldAppointment.Location_Name#</strong> <br />
						Address: <strong>
								#variables.qryOldAppointment.Location_Address# 
								#variables.qryOldAppointment.Location_Address2# <br />
								#variables.qryOldAppointment.Location_City# 
		                        #variables.qryOldAppointment.Location_State#
								#variables.qryOldAppointment.Location_Postal#
								</strong>
					</p>
					
					<p><br /></p>
					<p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IT NOT MONITORED--</em></p>
				</body>      
                </html> 
            	</cfmail>
			</cfif>
						
			<cfif Len(variables.qryResults.ProfessionalEmail)>
				<!--- Email Professional To="#variables.qryResults.ProfessionalEmail#"--->
				<cfmail from="salonworks@salonworks.com"server="smtp-relay.sendinblue.com"port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" To="#variables.qryResults.ProfessionalEmail#"  replyto="no-reply@salonworks.com" Subject="Appointment Notification" type="html">
			    <html>
				<body>
					<p>#variables.qryResults.ProfessionalName#,</p>
					<p>
						Appointment Details: <strong>#form.serviceDesc#</strong><br />
						Date: <strong>#DateFormat(variables.AppointmentStartTime,"long")#</strong><br />
						Time: <strong>#TimeFormat(variables.AppointmentStartTime,"medium")#</strong><br />
						Customer: <strong>#variables.qryResults.CustomerName# (ph: #variables.qryResults.CustomerPhone#)</strong><br />
						Location: <strong>#variables.qryResults.Location_Name#</strong> <br />
						Address: <strong>#variables.qryResults.LocationDesc#</strong>
					</p>
					
					<p><br /></p>
					<p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IT NOT MONITORED--</em></p>
				</body>      
                </html> 
            	</cfmail> 	 				
			</cfif>
			<cfset variables.ServiceID = 0 />
		</cfif>
	</cfif> 
</cfif>

<style>
	
	.ui-datepicker {
		font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
		font-size: .95em !important;
	}
	input, select, button {width:200px;}
	#loading {
		fotn-size: 14px;
		font-weight: bold;
		vertical-align: top;
		text-align:center;
		background:#fff url(images/ajax-loader.gif) no-repeat center center;
		height: 75px;
		width: 100px;
		position: fixed;
		left: 50%;
		top: 50%;
		margin: -25px 0 0 -25px;
		z-index: 1000;
	}
	
	
	.containerPadding{padding: 5px; margin: 15px;}
	
	div.error, textarea.error, input.error {border: 1px solid #FF0000;}

	form label.error {
		color: #FF0000;
		margin-left: 10px;
		width: auto;
		display: inline;	
	}
	
	.date-form { margin: 10px; }
	label.control-label i { cursor: pointer; }
	.alert-error {
		color:#D9534F;
	}
</style>

<script type="text/javascript">
	<cfoutput>
		var pageLoaded = false;
		var str = "#variables.company_phone#";
		var company_phone = str.replace(/ +/g, "");
		console.log(company_phone);
		//var Location_ID = #variables.Location_ID#;
		//var minDate = "#DateFormat(Now(),'mm/dd/yyyy')#";
		//var minMonth = #DatePart("m",Now())#;
		//var minYear = #DatePart("yyyy",Now())#;
		//var pickedDate = "#variables.AvailableDate#";
		var availableDates = [];
		var customerID = 0;
		//var availableTime = "#variables.AvailableTime#";	
	</cfoutput>
	
	<cfwddx action="cfml2js" input="#variables.Location_ID#" toplevelvariable="Location_ID" />
	<cfwddx action="cfml2js" input="#variables.Professional_ID#" toplevelvariable="Professional_ID" />
	<cfwddx action="cfml2js" input="#variables.ServiceID#" toplevelvariable="ServiceID" />
	<cfwddx action="cfml2js" input="#variables.blnFailed#" toplevelvariable="blnFailed" />
	<cfwddx action="cfml2js" input="#variables.company_id#" toplevelvariable="company_id" />
	
	<cfwddx action="cfml2js" input="#DateFormat(Now(),'mm/dd/yyyy')#" toplevelvariable="minDate" />
	<cfwddx action="cfml2js" input="#DatePart("m",Now())#" toplevelvariable="minMonth" />
	<cfwddx action="cfml2js" input="#DatePart("yyyy",Now())#" toplevelvariable="minYear" />
	<cfwddx action="cfml2js" input="#variables.AvailableDate#" toplevelvariable="pickedDate" />
	<cfwddx action="cfml2js" input="#variables.AvailableTime#" toplevelvariable="availableTime" />
	<cfwddx action="cfml2js" input="#DatePart("yyyy",Now())#" toplevelvariable="minYear" />
	
	
	<cfif structKeyExists(session, 'customerID') AND session.customerID GT 0>
		<cfwddx action="cfml2js" input="#session.customerID#" toplevelvariable="customerID" />
	</cfif>
	/*
	fnLogin = function(){
		if($("#frmLogIn").valid()){
				
			$("#pw").val($("#loginPassword").val());
			$("#emailAddress").val($("#loginEmail").val());
			
			//reset dialog form fields
			$("#firstName").val('');
			$("#lastName").val('');
			$("#ph").val('');
			
			//pass dialog form data to default form fields
			$("#availableDate").val($("#cdrAvailable").val());
			$("#serviceTime").val($("#selService option:selected").attr("time"));
			$("#serviceDesc").val($("#selService option:selected").text());
			$("#submitType").val('Login');
			$("#frmDefault").submit();
		}
	} 
	*/
	
	fnRegister = function(){
		var $regform = $("#frmRegister");
		$regform.validate();
		
		if( !$regform.valid() )
			return false;
		
		$.ajax({
				type: "post",
				url: "cfc/customers.cfc?method=registerCustomer&returnFormat=JSON&companyId="+company_id,
				data: $regform.serialize(),
				dataType: "json",
				success: function (rs){
					$('#register-msg').show();
					if ( rs.SUCCESS == true ) {
						$('#register-msg').addClass('alert-success');
						$('#register-msg').html('You have successfully registered as a customer!');
						window.location.href='index.cfm';
					}
					else {
						$('#register-msg').addClass('alert-error');
						$('#register-msg').html(rs.FAILEDMSG);
					}
				}
		});
		
			/*
			$("#pw").val($("#registerPassword").val());
			$("#emailAddress").val($("#registerEmail").val());
			$("#firstName").val($("#registerFirstName").val());
			$("#lastName").val($("#registerLastName").val());
			$("#ph").val($("#registerPhone").val());
			$("#availableDate").val($("#cdrAvailable").val());
			$("#serviceTime").val($("#selService option:selected").attr("time"));
			$("#serviceDesc").val($("#selService option:selected").text());
			$("#submitType").val('Register');
			$("#frmDefault").submit();
			*/
	}
	
	fnBookAppointment = function(){
			$("#pw").val('');
			$("#emailAddress").val('');
			$("#firstName").val('');
			$("#lastName").val('');
			$("#ph").val('');
			$("#availableDate").val($("#cdrAvailable").val());
			$("#serviceTime").val($("#selService option:selected").attr("time"));
			$("#serviceDesc").val($("#selService option:selected").text());
			//$("#submitType").val('Book');
			
			$.ajax({
					type: "POST",
					url: "admin/appointmentsCalendarBean.cfc",
					data: {
						method: "bookAppointment",
						CustomerID:  customerID,
						Professional_ID: $("#selProfessional").val(),
						ServiceID: $("#selService option:selected").val(),
						//StartDateTime: $("#AppointmentStartTime").val(),
						//EndDateTime: $("#AppointmentEndTime").val(),
						AppointmentStartDate: $('#availableDate').val(),
						AppointmentStartTime: $('#selAvailableTimes').val(),
						serviceTime: $("#selService option:selected").attr("time"),
						
						ChangeAppointmentID: $("#changeAppointmentID").val()
					},
					dataType: "json",
					success: function (rs){
						console.log(rs);
						if( rs.SUCCESS == true ) {
							$('#msgAppointment').addClass('alert-success');
							$('#msgAppointment').html('An apppointment was successfully booked.');
							$('.alert-success').fadeIn(100);
							$('#btnMakeAppointment').hide();
							$('#frmDefault')[0].reset();
							$('.alert-success').fadeOut(8000);
						}
						else {
							$('#msgAppointment').addClass('alert-danger');
							$('#msgAppointment').html(rs.FAILEDMSG);
						}
					},
					error: function (rs){
						$('#msgAppointment').addClass('alert-danger');
						$('#msgAppointment').html(rs);
					}
			});				
				
			
			//$("#frmDefault").submit();
	}	
		
	monthChanged = function(year, month, instance) {
		if($("#selProfessional").val() != null){
			fnGetAvailableDates(month, year, true);
		}
	}

	isAvailable = function(date){
		var dateAsString = (date.getMonth()+1).toString() + "/" + date.getDate() + "/" + date.getFullYear().toString();
		var result = (availableDates.length && $.inArray(dateAsString, availableDates) > -1) ? [true] : [false];
		return result;		
	}
	

	fnProfessionalChange = function(){
		var Professional_ID = parseInt($("#selProfessional").val());
		var serviceId = parseInt($("#selService").val());
		if(serviceId == 0) fnLoadServices(Professional_ID);
		
		if(Professional_ID && serviceId){
			fnGetAvailableDates(minMonth, minYear, false);
			$("#selAvailableTimes").removeAttr("disabled"); 
		}
		else if(!(Professional_ID && serviceId)){
			fnClearAvailableDateTimes();		
		}  
	}

	fnServicesChange = function(){
		var Professional_ID = parseInt($("#selProfessional").val());
		var serviceId = parseInt($("#selService").val());
		
		if(Professional_ID == 0) fnLoadProfessionals(serviceId);
		
		//alert('Professional_ID = ' + Professional_ID + '    serviceId = ' + serviceId);
		if(Professional_ID && serviceId){
			fnGetAvailableDates(minMonth, minYear, false);
			$("#selAvailableTimes").removeAttr("disabled"); 			
		}
		else if(!(Professional_ID && serviceId)){
			fnClearAvailableDateTimes();
		} 		
	}
	
	fnClearAvailableDateTimes = function(){
		$("#cdrAvailable").val("");
		availableDates = [];
		
		$("#selAvailableTimes").find('option').remove();
		$("#selAvailableTimes").append($("<option></option>").attr("value",0).text('Available Time Slots')); 	
		$("#selAvailableTimes").attr("disabled", "true");
		
		//$("#btnMakeAppointment").hide();
		$("#actionAppointment").hide();
	}

	fnLoadInitialDropDowns = function(Professional_ID, serviceId){
		$.ajax({
			type: "get",
			url: "admin/appointmentsCalendarBean.cfc",
			data: {
				method: "getProfessionalsListByService",
				Location_ID: Location_ID,
				ServiceID: serviceId, 
				noCache: new Date().getTime()
			},
			dataType: "json",
 			returnFormat: "json",
			success: function (rs){
				console.log(rs);
				$("#selProfessional").find('option').remove();
				$("#selProfessional").append($("<option></option>").attr("value",0).text('Choose Professional')); 
				
				if(rs.DATA.length){
					for (var i = 0; i < rs.DATA.length; i++) {
						$("#selProfessional").append($("<option></option>").attr("value",rs.DATA[i].PROFESSIONAL_ID).text(rs.DATA[i].LAST_NAME + ', ' + rs.DATA[i].FIRST_NAME)); 
					}

					$.ajax({
						type: "get",
						url: "admin/appointmentsCalendarBean.cfc",
						data: {
							method: "getServicesListByProfessional",
							Location_ID: Location_ID,
							Professional_ID: Professional_ID, 
							noCache: new Date().getTime()
							},
						dataType: "json",
			 			returnFormat: "json",
						success: function (rs){
							console.log(rs);
							// Populate Professional List based on Service selection
							var options = '<option value="0">Select Your Service</option>';
							if(rs.DATA.length){
						   		var groupName = "";
								for (var i = 0; i < rs.DATA.length; i++) {
									if(groupName != rs.DATA[i].TYPE_NAME){
										if(i > 0) options += "</optgroup>";
										
										groupName = rs.DATA[i].TYPE_NAME;
										//options += ' <optgroup label="' + groupName + '">';
									}
									options += '<option time="'+ rs.DATA[i].SERVICE_TIME + '" value="' + rs.DATA[i].SERVICE_ID + '">' + rs.DATA[i].SERVICE_NAME + '</option>';
								}
								options += '</optgroup>';
							}			
							else{
								options = '<option value="0">No Services Found</option>';		
							}		
							$("#selService").html(options);
							$("#selProfessional").val(Professional_ID);
							$("#selService").val(serviceId);
											
							if(Professional_ID && serviceId){

								var serviceTime = $("#selService option:selected").attr("time");

								if ( serviceTime != undefined ) {
									$.ajax("admin/appointmentsCalendarBean.cfc", {
										// send a GET HTTP operation
										type: "get",
										dataType: "json",
										returnFormat:'json',
										data: {
											method: "getAvailableDatesArray",
											Location_ID: Location_ID,
											ServiceID: serviceId,
											Professional_ID: Professional_ID,
											ServiceTime: serviceTime,
											Month: minMonth,
											Year: minYear, 
											noCache: new Date().getTime()
										},
										success: function (rs){
											console.log(rs);
											availableDates = rs.slice(0);
											
											$('#cdrAvailable').datepicker("refresh");
											$("#cdrAvailable").datepicker("setDate" , pickedDate);
											$("#cdrAvailable").removeAttr("disabled");
																
																
											$.ajax("admin/appointmentsCalendarBean.cfc", {
												type: "get",
												dataType: "json",
												returnFormat:'json',
												data: {
													method: "getAvailableSlots",
													Professional_ID: Professional_ID,
													ServiceID: serviceId,
													AppointmentDate: pickedDate,
													ServiceTime: serviceTime, 
													noCache: new Date().getTime()
												},
												success: function (rs){
													$("#selAvailableTimes").find('option').remove();
												   	if(rs.DATA.length){
												   		$("#btnMakeAppointment").show();
							
														for (var i = 0; i < rs.DATA.length; i++) {
															$("#selAvailableTimes").append($("<option></option>").attr("value", rs.DATA[i]).text(rs.DATA[i])); 
														}
													}			
													else{
														$("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots')); 
														$("#btnMakeAppointment").hide();	
													}	
													
													$("#selAvailableTimes").removeAttr("disabled");
													$("#selAvailableTimes").val(availableTime);
										
												},
												error: function (xhr, textStatus, errorThrown){
													alert("error: "   + errorThrown);
												}
											}); 
										},
										error: function (xhr, textStatus, errorThrown){
											alert("error: "   + errorThrown);
										}
									});
								} //if ( serviceTime != undefined ) { 											
							}
				
							if(!pageLoaded){
								$('#loading').fadeOut(3000);
								pageLoaded = true;
							}								
						},
						error: function (xhr, textStatus, errorThrown){
									alert("error LoadServices: "   + errorThrown);
						}
					});							
				}			
				else{
					$('.msgcontent').html("We're sorry, but Online Booking is not currently configured on our site. Please call " +company_phone+ " to book your appointment."); 
					/*$("#selProfessional").find('option').remove();
					$("#selProfessional").append($("<option></option>").attr("value",0).text('No Professional Found')); */
					$('#loading').fadeOut(3000);
					pageLoaded = true;	
				}									
			},
			error: function (xhr, textStatus, errorThrown){
						alert("error LoadProfessionals: "   + errorThrown);
			}
		});				
	}	
	
	fnLoadProfessionals = function(serviceId){
		$.ajax({
			type: "get",
			url: "admin/appointmentsCalendarBean.cfc",
			data: {
				method: "getProfessionalsListByService",
				Location_ID: Location_ID,
				ServiceID: serviceId, 
				noCache: new Date().getTime()
				},
			dataType: "json",
 			returnFormat: "json",
			success: function (rs){
						$("#selProfessional").find('option').remove();
						$("#selProfessional").append($("<option></option>").attr("value",0).text('Choose Professional')); 
					   	if(rs.DATA.length){
							for (var i = 0; i < rs.DATA.length; i++) {
								$("#selProfessional").append($("<option></option>").attr("value",rs.DATA[i].PROFESSIONAL_ID).text(rs.DATA[i].LAST_NAME + ', ' + rs.DATA[i].FIRST_NAME)); 
							}
						}			
						else{
							$("#selProfessional").append($("<option></option>").attr("value",0).text('No Professional Found')); 	
						}									
					},
 
			error: function (xhr, textStatus, errorThrown){
						alert("error LoadProfessionals: "   + errorThrown);
			}
		});			
	}
	
	fnLoadServices = function (Professional_ID){
		$.ajax({
			type: "get",
			url: "admin/appointmentsCalendarBean.cfc",
			data: {
				method: "getServicesListByProfessional",
				Location_ID: Location_ID,
				Professional_ID: Professional_ID, 
				noCache: new Date().getTime()
				},
			dataType: "json",
 			returnFormat: "json",
			success: function (rs){
				// Populate Professional List based on Service selection
				var options = '<option value="0">Select Your Service</option>';
				if(rs.DATA.length){
			   		var groupName = "";
					for (var i = 0; i < rs.DATA.length; i++) {
						if(groupName != rs.DATA[i].TYPE_NAME){
							if(i > 0) options += "</optgroup>";
							
							groupName = rs.DATA[i].TYPE_NAME;
							//options += ' <optgroup label="' + groupName + '">';
						}
						if(rs.DATA[i].SERVICE_TIME == "") {
							rs.DATA[i].SERVICE_TIME = 0;
						}
						options += '<option time="'+ rs.DATA[i].SERVICE_TIME + '" value="' + rs.DATA[i].SERVICE_ID + '">' + rs.DATA[i].SERVICE_NAME + '</option>';
					}
					options += '</optgroup>';
				}			
				else{
					options = '<option value="0">No Services Found</option>';		
				}		
				$("#selService").html(options);
				
				if(!pageLoaded){
					$('#loading').fadeOut(3000);
					pageLoaded = true;
				}								
			},
			error: function (xhr, textStatus, errorThrown){
				alert("error LoadServices: "   + errorThrown);
			}
		});	
	}

	fnGetAvailableDates = function(month, year, isMonthChange){
		var serviceTime = $("#selService option:selected").attr("time");
		var serviceId = $("#selService").val();
		var Professional_ID = $("#selProfessional").val();
		
		if ( serviceTime != undefined ) {

			$.ajax("admin/appointmentsCalendarBean.cfc", {
				// send a GET HTTP operation
				type: "get",
				dataType: "json",
				returnFormat:'json',
				data: {
						method: "getAvailableDatesArray",
						Location_ID: Location_ID,
						ServiceID: serviceId,
						Professional_ID: Professional_ID,
						ServiceTime: serviceTime,
						Month: month,
						Year: year, 
						noCache: new Date().getTime()
				},
				success: function (rs){

						availableDates = rs.slice(0);
						if(!isMonthChange){
							$("#cdrAvailable").datepicker("setDate" , availableDates[0]);
							/* 
							bs datetimepicker 
							*/
							/* $('#cdrAvailable').data("DateTimePicker").setDate(availableDates[0]); */
							
							fnLoadAvailableTimes(Professional_ID, serviceId, availableDates[0], serviceTime);
						}
						$('#cdrAvailable').datepicker("refresh");
				},
				error: function (xhr, textStatus, errorThrown){
						alert("error: "   + errorThrown);
				}
			}); 
		}
	}
	
 	fnLoadAvailableTimes = function(Professional_ID, serviceId, selectedDate, serviceTime){
 		$("#selAvailableTimes").find('option').remove();
 		
 		if(selectedDate == undefined){
 			$("#btnMakeAppointment").hide();
 			$("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots'));
 		} 
 		else{
 			if (serviceTime != undefined) {
				$.ajax("admin/appointmentsCalendarBean.cfc", {
						type: "get",
						dataType: "json",
						returnFormat:'json',
						data: {
								method: "getAvailableSlots",
								Professional_ID: Professional_ID,
								ServiceID: serviceId,
								AppointmentDate: selectedDate,
								ServiceTime: serviceTime, 
								noCache: new Date().getTime()
						},
						success: function (rs){
							   	if(rs.DATA.length){
							   		$("#btnMakeAppointment").show();
									$("#selAvailableTimes").append($("<option></option>").attr("value",0).text('Available Time Slots'));
									
									for (var i = 0; i < rs.DATA.length; i++) {
										$("#selAvailableTimes").append($("<option></option>").attr("value", rs.DATA[i]).text(rs.DATA[i])); 
									}
								}			
								else{
									$("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots')); 
									$("#btnMakeAppointment").hide();	
								}	
		
						},
						error: function (xhr, textStatus, errorThrown){
								alert("error: "   + errorThrown);
						}
				}); 
			}
		}
	};
	
	$(document).ready(function() {	
		
		$('#actionAppointment').hide();
		
		$('#selAvailableTimes').change(function(){
			if( $(this).val() != 0)
				$('#actionAppointment').show();
			else
				$('#actionAppointment').hide();
		});
		
		$("#cdrAvailable").datepicker({
			numberOfMonths: 2,
		 	showOn: "button",
			buttonImage: "images/calendar.png",
			buttonImageOnly: true,
			onChangeMonthYear : monthChanged, 
			beforeShowDay: isAvailable,
			onSelect: function(dateText) {
						var serviceTime = $("#selService option:selected").attr("time");
						var serviceId = $("#selService").val();
						var Professional_ID = $("#selProfessional").val();
						fnLoadAvailableTimes(Professional_ID, serviceId, this.value, serviceTime);
			}
		});
		$("#cdrAvailable").datepicker("setDate" , pickedDate);
		$("#cdrAvailable").datepicker("option", "minDate" , minDate);
           
		$("#btnMakeAppointment").button({
			icons: { primary: "ui-icon-calendar"},
			text: true
		});
					
		$("#btnMakeAppointment").click(function() {
			<!--- Customer is not logged in --->
			if(customerID == 0){
				//$("#dlgRegisterLogin").dialog("open");
				$('#frmSignin')[0].reset();
				$('#signin-msg').hide();
				$('#signinModal').modal('show');
				//$("#registerModal").modal('show');
			} 
			else{
				fnBookAppointment();
			}
			
		});


	 	$("#frmLogIn").validate({
	        rules:{
	            loginEmail:{required: true, email: true},
	            loginPassword:{required: true}
	        }
	    });	    
		 	
 		$("#frmSignup").validate({
	        rules:{
	            registerEmail:{required: true, email: true},
	            registerFirstName:{required: true},
	            registerLastName:{required: true},
	            registerPhone:{required: true},
	            registerPassword:{required: true} 
	        }
	    });
			 
	  	$("#btnLogin").button({
  			icons: {
				primary: "ui-icon-play"
			},
			text: true
		}); 
		
		/*	
		$("#btnRegister").button({
			icons: {
				primary: "ui-icon-check"
			},
			text: true
		}); 
		*/
		/*$('#btnRegister').click(function() {
			fnRegister();
		});*/
					
			
		fnLoadInitialDropDowns(Professional_ID, ServiceID);
		if ( !blnFailed )
			$("#btnMakeAppointment").hide();
	});
		
</script>

<!--- <cfset variables.PageTitle ="Book Your Next Appointment Online">
<cfset variables.title_no = 3>
<cfinclude template="/templates/0001/header.cfm">
<link href="/templates/0001/inner.css" rel="stylesheet" type="text/css" /> --->
	<div class="col-md-8" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Book Your Next Appointment Online</span>
			</h2>
		</div>
		<cfoutput>
		<div class="col-sm-12">
			<div class="headline"></div>
			<div class="content msgcontent">
				<form id="frmDefault" name="frmDefault" class="form" role="form">
					<input type="hidden" id="pw" name="pw"   />
					<!--- <input type="password" id="pw" name="pw"  hidden="true"  /> --->
					<input type="hidden" id="emailAddress" name="emailAddress"  />
					<input type="hidden" id="firstName" name="firstName"  />
					<input type="hidden" id="lastName" name="lastName"  />
					<input type="hidden" id="ph" name="ph" />
					<input type="hidden" id="availableDate" name="availableDate" />
					<input type="hidden" id="serviceTime" name="serviceTime" />
					<input type="hidden" id="serviceDesc" name="serviceDesc" />
					<input type="hidden" id="submitType" name="submitType" />
					
					<div class="row">
						<div class="col-sm-8">
							<cfif structKeyExists(url, 'changeAppointmentID') AND Len(url.changeAppointmentID)>
								<label class="sr-only">Change Appointment: #URLDecode(url.apptDesc)#</label>
								<input type="hidden" id="changeAppointmentID" name="changeAppointmentID" value="<cfoutput>#url.changeAppointmentID#</cfoutput>" />
							<cfelse>
								<label class="sr-only">Book Your Next Appointment Online</label>
								<input type="hidden" id="changeAppointmentID" name="changeAppointmentID" value="0" />
							</cfif>
						
							<!--- <div class="input-group"> --->
								<!--- <label class="sr-only" for="subscribe-email">Email address</label> --->
								<select id="selProfessional" name="selProfessional" class="form-control" onChange="fnProfessionalChange()">
								</select>
								<!--- <span class="input-group-btn">
								<button type="submit" class="btn btn-default">OK</button>
								</span> --->
							<!--- </div> --->
							<br />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8">	
							<select id="selService" name="selService" class="form-control" onChange="fnServicesChange()">
							</select>
							<br />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8">	
							<input type="text" id="cdrAvailable" name="cdrAvailable" class="form-control col-sm-4" 
									readonly="true" disabled="true" style="width: 90%;" />
							<!--- <div class='input-group date' id='cdrAvailable'>
								<input type='text' class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div> --->
							
							<br />
						</div>
					</div>	
					
					<div class="row">
						<div class="col-sm-8">
							<br />
							<select id="selAvailableTimes" name="selAvailableTimes" disabled="true" class="form-control">
								<option value="0">Available Time Slots</option>	
							</select>	
						</div>
					</div>
					<hr />
					<div class="row" id="actionAppointment">
						<div class="col-sm-8">
							<button id="btnMakeAppointment" type="button" class="btn btn-danger">Make an Appointment</button>
						</div>
					</div>
					<div id="msgAppointment" class="alert">&nbsp;</div>
				</form>
			</div>
		</div>
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

<!--- 
***********************************************************************************************************************************************************
********************************************    DIALOG HTML     *******************************************************************************************
***********************************************************************************************************************************************************
 --->
<!--- <div id="dlgRegisterLogin" title="Signup/Login">
	<div style="width: 500px;">
		<div style="font-size: .85em">To book an appointment you must be a registered user and logged in</div>
				
		<div style="float: left; width: 200px;" class="containerPadding">					
		 	<form id="frmSignup" name="frmSignup">
				<div><strong>Sign up for an account</strong></div>
 				<br />
				
				<div>
					<label>Your email address:</label><br />
					<input type="text" id="registerEmail" name="registerEmail" maxlength="100" />
				</div>	
				<br />
				<div> 
					<label>Your first name:</label><br />
					<input type="text" id="registerFirstName" name="registerFirstName" maxlength="50" />
				</div>
				<br />
				<div>
					<label>Your last name:</label><br />
					<input type="text" id="registerLastName" name="registerLastName" maxlength="50" />
				</div>
				<br />
				<div>
					<label>Your phone:</label><br />
					<input type="text" id="registerPhone" name="registerPhone" maxlength="12" /><br />
					Example: 512-753-0000
				</div>
				<br />			
				<div>
					<label>Choose a password:</label><br />
					<input type="password" id="registerPassword" name="registerPassword"  maxlength="20" />
				</div>
				<br />

				<div>  
					<button type="button" id="btnRegister" onclick="fnRegister()" style="width:200px">Sign Up Now</button>
				</div>
			</form>		
		</div>
			 
		<div style="float: left; width: 3px;background-color: #cccccc;min-height: 300px;margin-top:10px"></div>
	 
		<div style="float: left; width: 200px;" class="containerPadding">	
		 	<form id="frmLogIn" name="frmLogIn">
			<div><strong>Login</strong></div>
			<br />
			<div>
				<label>Your email address:</label><br />
				<input type="text" id="loginEmail" name="loginEmail" maxlength="100" />
			</div>
			<br />
			<div>
				<label>Password:</label><br />
				<input type="password" id="loginPassword" name="loginPassword" maxlength="100" />
			</div>
			<br />  
			<div>
				<button type="button" id="btnLogin" onclick="fnLogin()" style="width:200px">Login</button>
			</div>	
			</form>		
		 </div>
	 		 
		<br style="clear: left;" />
	</div>
</div> --->
