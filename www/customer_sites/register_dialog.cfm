<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="Register" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="registerModalLabel">Sign up for an account</h4>
			</div>
			<div class="modal-body">
				<form name="frmRegister" id="frmRegister" role="form" class="form-horizontal">
				
					<div class="form-group">
						<label class="control-group col-sm-4">Your email address:</label>
						<div class="col-sm-6">
							<input type="text" id="emailAddress" name="emailAddress" class="form-control required" required maxlength="100" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-group col-sm-4">Your first name:</label>
						<div class="col-sm-6">	
							<input type="text" id="firstName" name="firstName" class="form-control required" required maxlength="50" />
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-group col-sm-4">Your last name:</label>
						<div class="col-sm-6">	
							<input type="text" id="lastName" name="lastName" class="form-control required" required maxlength="50" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-group col-sm-4">Your phone:</label>
						<div class="col-sm-6">	
							<input type="text" id="ph" name="ph" class="form-control required" required maxlength="12" /><br />
							Example: 512-753-0000
						</div>
					</div>
					<div class="form-group">
						<label class="control-group col-sm-4">Choose a password:</label>
						<div class="col-sm-6">	
							<input type="password" id="pw" name="pw" class="form-control required" required maxlength="20" />
						</div>
					</div>
				</form>
					
				<div id="register-msg" class="alert"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="btnRegister">Continue</button>
				</div>
				
			</div>
		</div>
	</div>
</div>
<!--- 
<cfset variables.CustomerID = 0 />
<cfset variables.blnFailed = false />
<cfset variables.FailedMsg = ""/>

<div id="dlgTopLogin" title="Sign in">
	<div class="containerPadding">	
	 	<form id="frmTopLogIn" name="frmTopLogIn" action="#Replace(cgi.PATH_INFO,'/','')#" method="post">
			<cfif Len(variables.FailedMsg)>
			<div class="error">#variables.FailedMsg#</div>
			</cfif>
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
				<button type="button" id="btnLogin" onclick="fnTopLogin()" style="width:200px">Login</button>
			</div>
		</form>		
	</div>
	 		 
	<br style="clear: left;" />
</div> --->