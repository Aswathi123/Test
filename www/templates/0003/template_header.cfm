<!doctype html>
<html class="no-js" lang="en">
	<head>
		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta name="format-detection" content="telephone=no">
		<title>Index</title>
		<link rel="stylesheet" href="/jquery-ui-1.8.21/themes/smoothness/jquery.ui.all.css">	
		<link rel="icon" type="image/x-icon" href="<cfoutput>#templatePath#img/favicon.ico</cfoutput>" />
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/bootstrap.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/main.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/font-awesome.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/owl.theme.default.min.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/owl.carousel.min.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#fonts/font.css</cfoutput>">
		<link rel="stylesheet" href="<cfoutput>#templatePath#css/custom.css</cfoutput>">
		<script src="js/vendor/jquery-3.3.1.slim.min.js"></script>
		<script src="jquery-ui-1.8.21/ui/jquery-ui-1.8.21.custom.js"></script>
		<script src="js/jquery-migrate-1.2.1.min.js"></script> 
		<script src="<cfoutput>#templatePath#js/vendor/bootstrap.min.js</cfoutput>"></script>
		<script src="js/jquery.validate.js"></script>

		<style>
			.sticky {
			  position: fixed;
			  top: 0;
			  width: 100%;
		      background-color: #000000;
			}
			.hideDiv{			
			    display: none;
			}
			.profileLink{
				background-color:#252525;
			}
			.profileMenu {
				    position: absolute;
				    top: 57px;
				    left: -73%;
			}
		</style>
	</head>
	<body>
		<cfinclude template="menu.cfm">
		<!-- Sigin Modal -->
		<div class="modal sigin-modal fade" id="signinModal" tabindex="-1" role="dialog" aria-labelledby="signInModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="signInModalLabel">Sign In</h5>
						<button type="button" class="close signin-close-btn" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="signin-content">
							<form name="frmSignin" id="frmSignin" role="form" class="form-horizontal">
								<div class="form-group">
									<input type="email" id="emailAddress" name="emailAddress" class="signin-field" placeholder="Your email address" required maxlength="50" />		
								</div>
								<div class="form-group">
									<input class="signin-field" id="pw" name="pw" type="password" required maxlength="50" placeholder="Your password">
								</div>
								<div id="signin-msg"></div>
								<div class="form-group">
									<button type="button" class="signin btnSignin">Log in</button>										
								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<p>New member?</p>
						<button type="button"  href="#" class="btn signin-footer-btn btn-secondary" data-target="#registerModal" data-toggle="modal" data-dismiss="modal">Register</button>							
					</div>
				</div>
			</div>
		</div>
		<!-- Signin Modal end -->
		<!-- registration Modal -->
		<div class="modal sigin-modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="signInModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="signInModalLabel">Sign up for an account</h5>
						<button type="button" class="close signin-close-btn" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="signin-content">
							<div id="register-msg"></div>
							<form name="frmRegister" id="frmRegister" role="form" class="form-horizontal">
								<input type="hidden" id="qCompanyId" value="<cfoutput>#company_id#</cfoutput>"/>
								<input type="hidden" name="companyId" value="">

								<div class="form-group">
									<input type="text" id="firstName" name="firstName" class="signin-field required" placeholder="Your first Name" required maxlength="50"/>		
								<!--- </div>
								<div class="form-group"> --->
									<input type="text" id="lastName" name="lastName" class="signin-field required" placeholder="Your last Name" required maxlength="50"/>		
								<!--- </div>
								<div class="form-group"> --->
									<input type="email" name="emailAddress" class="signin-field emailAddress required" placeholder="Your email address" required maxlength="100"/>		
								<!--- </div>
								<div class="form-group"> --->
									<input class="signin-field required" id="ph" name="ph" type="text" placeholder="Your mobile Number"required maxlength="12"/>
									Example: 512-753-0000
								<!--- </div>
								<div class="form-group"> --->
									<input  class="signin-field required" type="password" id="pw" placeholder="choose a password" name="pw"  required maxlength="20" />
								</div>
								<div id="register-msg" class="form-group"></div>
								<div class="modal-footer">
									<button type="button" class="signin" id="btnRegister">Continue</button>
									<button type="button" class="signin" data-dismiss="modal">Close</button>		
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- registration Modal end -->

			
		
		

	

		