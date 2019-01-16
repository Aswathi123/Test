
<!--- <cfquery name="qryLogin" datasource="#request.dsn#">
update Locations 
set company_id = 39
where location_id = 3
</cfquery>
locations <br />
<cfdump var="#qryLogin#" /> --->
<!--- 
<cfquery name="qryPro" datasource="#request.dsn#">
SELECT * FROM Professionals
where email_address = 'ciredrofdarb@gmail.com'
</cfquery>
pro <br />
<cfdump var="#qryPro#" />

professional_id = 12
location_id = 3 

<cfquery name="qryLogin" datasource="#request.dsn#">
SELECT * FROM Locations where location_id = 3
</cfquery>
locations <br />
<cfdump var="#qryLogin#" />

<cfquery name="qryLogin" datasource="#request.dsn#">
SELECT * FROM Companies
</cfquery>
Companies <br />
<cfdump var="#qryLogin#" /> --->
<cfset local.error_msg = "" />
<cfif isDefined('url.e') and isDefined('url.p')>
	<cfset form.Email_Address=url.e>
	<cfset form.Password=url.p>
</cfif>
<cfif isDefined('form.Email_Address_log') AND isDefined('form.Password')>
	<cfset local.error_msg = "" />
	<cfif not len(form.Email_Address_log) OR not len(form.Password)>
		<cfset local.error_msg = "Login Failed ! Please fill the required fields!" />
	</cfif>
	<cfinvoke component="login" method="login" returnvariable="loggedin">
		<cfinvokeargument name="Email_Address_log" value="#Trim(form.Email_Address_log)#">
		<cfinvokeargument name="Password" value="#Trim(form.Password)#">
	</cfinvoke>
	<cfif loggedin>
		<cfif StructKeyExists(url,'r')>
			<cflocation url="/admin/#url.r#" addtoken="no"/>
		</cfif>
		 <cflocation url="/admin/index.cfm" addtoken="no"/>
	<cfelse>
		Failed Login
    </cfif>
    <!--- <cfif qLogin.RecordCount GT 0>
		<cfset session.Professional_ID = qLogin.Professional_ID>
        <cfset session.Professional_ID  =  qLogin.Professional_ID />
        <cfset session.Location_ID = qLogin.Location_ID>
        <cfset session.First_Name = qLogin.First_Name>
        <cfset session.Last_Name = qLogin.Last_Name>
        <cfset session.Company_ID = qLogin.Company_ID>
        <cfset session.company_id = qLogin.Company_ID>
        <cfset session.Company_Admin = qLogin.Company_Admin>
        <cfinclude template="loadSessionForm.cfm" />
        
        <cflocation url="/admin/index.cfm" addtoken="yes"/>
     <cfelse>
		Failed Login
    </cfif> --->
</cfif>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>Login Page - Ace Admin</title>

		<meta name="description" content="User login page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!-- basic styles -->

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->

		<!-- fonts -->

		<link rel="stylesheet" href="assets/css/ace-fonts.css" />

		<!-- ace styles -->

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
	</head>

	<body class="login-layout">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<!--- <h1>
									<i class="icon-leaf green"></i>
									<span class="red">Ace</span>
									<span class="white">Application</span>
								</h1> --->
								<h4 class="blue">&copy; Salonworks</h4>
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="icon-key green"></i>
												Please Enter Your Information
											</h4>

											<div class="space-6"></div>
								
											<form action="login.cfm" method="post" id="admin_log_form">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" name="Email_Address_log" value="" id="Email_Address_log">
															<i class="icon-user"></i>
														</span>
													</label>
								
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" name="Password" id="Password">
															<i class="icon-lock"></i>
														</span>
													</label>

													<div class="space"></div>
													<p style="color:red;" class="error_box"><cfoutput>#local.error_msg#</cfoutput></p>
													<div class="clearfix">
														<button type="button" class="width-35 pull-right btn btn-sm btn-primary" id="admin_log_btn">
															<i class="icon-key"></i>
															Login
														</button>
													</div>
								
													<div class="space-4"></div>
												</fieldset>
											</form>
										</div><!-- /widget-main -->

										<div class="toolbar clearfix">
											<div>
												<a href="#" onclick="show_box('forgot-box'); return false;" class="forgot-password-link">
													<i class="icon-arrow-left"></i>
													I forgot my password
												</a>
											</div>
										</div>
									</div><!-- /widget-body -->
								</div><!-- /login-box -->
								
								<div id="forgot-box" class="forgot-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header red lighter bigger">
												<i class="icon-key"></i>
												Retrieve Password
											</h4>

											<div class="space-6"></div>
											<p>
												Enter your email and to receive instructions
											</p>

											<form action="#" method="POST" id="forgot_form">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" name="Email_Address_forgot" id="forgotPassEmail" placeholder="Email" />
															<i class="icon-envelope"></i>
														</span>
													</label>

													<div class="clearfix">
														<button type="button" class="width-35 pull-right btn btn-sm btn-danger" id="forgotPassSubmit">
															<i class="icon-lightbulb"></i>
															Send Me!
														</button>
														<p class="error_box_forgot" style="color:red;"></p>
													</div>
												</fieldset>
											</form>
										</div><!-- /widget-main -->

										<div class="toolbar center">
											<a href="#" onclick="show_box('login-box'); return false;" class="back-to-login-link">
												Back to login
												<i class="icon-arrow-right"></i>
											</a>
										</div>
									</div><!-- /widget-body -->
								</div><!-- /forgot-box -->
								
							</div><!-- /position-relative -->
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div>
		</div><!-- /.main-container -->
		<div class="modal fade" id="emailsuccess" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Your password has been send to your email address</h4>
		        </div>
		        <div class="modal-body">
		           <div class="form-group btnEmailOkWrapper">
		            <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnEmailOk">Ok
		            </button>
		          </div>
		        </div>
		      <!-- /.modal-content --> 
		    </div>
		    <!-- /.modal-dialog --> 
		  </div>
		  <!-- /.modal --> 
		</div>

		<!-- basic scripts -->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>

		<!-- inline scripts related to this page -->

		<script type="text/javascript">
			function show_box(id) {
			 jQuery('.widget-box.visible').removeClass('visible');
			 jQuery('#'+id).addClass('visible');
			}
		</script>
		<script>
			var inputemail = document.getElementById("Email_Address_log");
			var inputpw = document.getElementById("Password");

			inputemail.addEventListener("keyup", function(event) {
				event.preventDefault();
				if (event.keyCode === 13) {
					document.getElementById("admin_log_btn").click();
				}
			});
			inputpw.addEventListener("keyup", function(event) {
				event.preventDefault();
				if (event.keyCode === 13) {
					document.getElementById("admin_log_btn").click();
				}
			});
		</script>
		<script> 
			$('.error_box').html("");
			$('.error_box').hide();
			$('.error_box_forgot').html("");
			$('.error_box_forgot').hide();
			var email =  /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
			$('#admin_log_btn').click(function() {
				var user_mail = $('#Email_Address_log').val();
				var error_flag = true;
				if((user_mail.length == 0 ) && ($('#Password').val().length == 0)) {
					error_flag = false;
					$('.error_box').html("Email and password is required");
					$('.error_box').show();
				}
				else if(user_mail.length == 0 ) {
					error_flag = false;
					$('.error_box').html("Email is required");
					$('.error_box').show();
				}
				else if(!(email.test(user_mail)) && ($('#Password').val().length == 0)) {
					error_flag = false;
					$('.error_box').html("Email is not valid and password is required");
					$('.error_box').show();
				}
				else if(!(email.test(user_mail))) {
					error_flag = false;
					$('.error_box').html("Email is not valid");
					$('.error_box').show();
				}
				else if($('#Password').val().length == 0) {
					error_flag = false;
					$('.error_box').html("Password is required");
					$('.error_box').show();
				}
                else {
                	$('.error_box').html("");
					$('.error_box').hide();
					$.ajax({
		              type: "get",
		              url: "company.cfc",
		              data: {
		                method: "isExistingEmailAddress",
		                EmailAddress: $('#Email_Address_log').val(),
						password : $('#Password').val(),
		                noCache: new Date().getTime()
		                },
		              dataType: "json",
		   
		              // Define request handlers.
		              success: function( objResponse ){
		               
		                  if(objResponse.DATA){
		                  	$('.error_box').html("");
							$('.error_box').hide();
		                    $('#admin_log_form').submit();
		                  }
		   				 else {
		                  $('.error_box').html("Invalid credentials");
		                  $('.error_box').show();
		                }
		              },
		   
		          });
					
                }
			});
			$('#forgotPassSubmit').on('click', function(){
				$('.error_box_forgot').html("");
				$('.error_box_forgot').hide();
		         var email_user=$.trim($('#forgotPassEmail').val());
		         console.log(email);
		          if(email_user.length ==0) {
		          	 $('.error_box_forgot').html("Email is required");
		          	 $('.error_box_forgot').show();
		          }else if(!email.test(email_user)) {
		          	$('.error_box_forgot').html("Email is not valid");
		          	$('.error_box_forgot').show();
		          }
		         else{
		         	$('.error_box_forgot').html("");
		         	$('.error_box_forgot').hide();
		            $.ajax({
		               url: "professionals.cfc?method=forgotPassword&showtemplate=false",
		               type: 'POST',
		               data:{email:email_user},
		               success: function(data){
		                  console.log(data);
		                  if(data==1){
		                  	alert("Your password has been send to your email address");
		                  	$('#forgot_form')[0].reset();
		                  }
		                  else{
		                     alert("Invalid email address.Make sure this is your registered email address");
		                  }
		               },
		            });
		         }
		    });
		</script>
	</body>
</html>
<!--- <form action="login.cfm" method="post">
	Email Address: <input type="text" name="Email_Address" value=""><br>
	Password: <input type="password" name="Password"><br>
	<input type="submit" value="Login">
</form> --->