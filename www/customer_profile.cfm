<cfparam name="templatePath" type="string" default="/templates/#NumberFormat(application.template_id,'0000')#/">
<!--- <cfparam name="templatePath" type="string" default="/templates/#NumberFormat(variables.Template_ID,'0000')#/"> --->
<cfoutput>
	<cfset variables.PageTitle ="Profile">
	<cfset variables.title_no = 0>
	<cfinclude template="/customer_sites/customer_header.cfm">
	<cfinclude template="#templatePath#template_header.cfm">
	<cfinclude template="#templatePath#customerProfile_content.cfm">
</cfoutput>
<!--- <cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />

<cfset variables.msg = "" />

<cfif structKeyExists(form, 'profileCustomerID') AND Len(form.profileCustomerID)>
	
	<cfset variables.objCFC.updateCustomerProfile(
					CustomerID = form.profileCustomerID,
					FirstName = form.FirstName,
					LastName = form.LastName,
					Address = form.Address,
					City = form.City,  
					State = form.State,
					Postal = form.Postal,
					MobilePhone = form.Phone,
					EmailAddress = form.Email,
					Password = form.Password				 					 
					) />
	<cfset variables.msg = "Update Completed" />

</cfif>


	
<cfset variables.qryCustomer = variables.objCFC.getCustomerProfile(session.CustomerID) />
		
<cfoutput>
<cfset variables.PageTitle ="Profile">
<cfset variables.title_no = 0>
<cfinclude template="/templates/0001/header.cfm">

<link href="/templates/0001/inner.css" rel="stylesheet" type="text/css" />
<div class="midContent">
	<div class="content" align="left">
		<div class="heading">Profile</div> 
		<cfif Len(variables.msg)>
			<p>#variables.msg#</p>
		</cfif>
		<form id="frmProfile" name="frmProfile" action="customer_profile.cfm" method="post">
			<input type="hidden" name="profileCustomerID" value="#session.CustomerID#" />
			
			<br />
			<div>
				<label for="Email">Your email address:</label><br />
				<input type="text" id="Email" name="Email" maxlength="100" value="#qryCustomer.Email_Address#" />
			</div>	
			<br />
			<div> 
				<label for="FirstName">Your first name:</label><br />
				<input type="text" id="FirstName" name="FirstName" maxlength="50" value="#qryCustomer.First_Name#" />
			</div>
			<br />
			<div>
				<label for="LastName">Your last name:</label><br />
				<input type="text" id="LastName" name="LastName" maxlength="50" value="#qryCustomer.Last_Name#" />
			</div>
			<br />
			<div>
				<label for="Phone">Your phone:</label><br />
				<input type="text" id="Phone" name="Phone" maxlength="12" value="#qryCustomer.Mobile_Phone#" /><br />
				Example: 512-753-0000
			</div>
			<br />

			<div> 
				<label for="Address">Your Address:</label><br />
				<input type="text" id="Address" name="Address" maxlength="50" value="#qryCustomer.Address#" />
			</div>
			<br />
			<div> 
				<label for="City">Your City:</label><br />
				<input type="text" id="City" name="City" maxlength="50" value="#qryCustomer.City#" />
			</div>
			<br />						
			<div> 
				<label for="State">Your State:</label><br />
				<cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="State">
                    <cfinvokeargument name="Selected_State" value="#qryCustomer.State#">
                </cfinvoke>
			</div>
			<br />
			<div> 
				<label for="Postal">Your Postal:</label><br />
				<input type="text" id="Postal" name="Postal" maxlength="5" value="#qryCustomer.Postal#" />
			</div>
			<br />	
					
			<div>
				<label for="Password">Your Password:</label><br />
				<input type="password" id="Password" name="Password"  maxlength="20" value="#qryCustomer.Password#" />
			</div>
			<br />

			<div>  
				<button type="button" id="btnUpdateProfile" onclick="fnUpdateProfile()" style="width:200px">Update Profile</button>
			</div>
		</form>
	</div> 
	<cfinclude template="/templates/0001/info_bar.cfm">
</div>  <!-- midContent -->
<cfinclude template="/templates/0001/footer.cfm">
</cfoutput>	
<script type="text/javascript">

fnUpdateProfile = function(){
		$('#frmProfile').submit();
}
</script> --->