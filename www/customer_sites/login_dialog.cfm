<div class="modal fade" id="signinModal" tabindex="-1" role="dialog" aria-labelledby="Sign in" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="frmSignin" id="frmSignin" role="form" class="form-horizontal">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="signinModalLabel">Sign in</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="control-group col-sm-4">Your email address:</label>
						<div class="col-sm-6">
							<input type="text" id="emailAddress" name="emailAddress" class="form-control" maxlength="100" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-group col-sm-4">Password:</label>
						<div class="col-sm-6">	
							<input type="password" id="pw" name="pw" class="form-control" maxlength="100" />
						</div>
					</div>
				</div>
				<div id="signin-msg" class="alert"></div>
				<div class="modal-footer">
					<div class="col-sm-12">
						<button type="button" class="btn btn-primary btnSignin">Sign in</button>
					</div>
					<div class="col-sm-5"><hr></div>
					<div class="col-sm-2">OR</div>
					<div class="col-sm-5"><hr></div>
					<div class="col-sm-12">
						<button type="button" class="btn btn-danger a_register">Register</button>
					</div>
				</div>
			</form>
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