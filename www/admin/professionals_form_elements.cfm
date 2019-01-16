<cfif isDefined("session.Professional_ID") and session.Professional_ID gt 0>
	<cfset variables.Professional_ID=session.Professional_ID>
</cfif>
<cfif isDefined("session.Company_ID") and session.Company_ID gt 0>
	<cfset variables.Company_ID=session.Company_ID>
</cfif>
<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>

<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessional">
	<cfinvokeargument name="Professional_ID" value="#variables.professional_id#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<cfparam name="variables.Promo_Code" default="">

<cfparam name="variables.First_Name" default="">
<cfparam name="variables.Last_Name" default="">
<cfparam name="variables.Home_Phone" default="">
<cfparam name="variables.Mobile_Phone" default="">
<cfparam name="variables.Home_Address" default="">
<cfparam name="variables.Home_Address2" default="">
<cfparam name="variables.Home_City" default="">
<cfparam name="variables.Home_State" default="">
<cfparam name="variables.Home_Postal" default="">
<cfparam name="variables.Email_Address" default="">
<cfparam name="variables.Password" default="">
<cfparam name="variables.Services_Offered" default="">
<cfparam name="variables.Accredidations" default="">
<cfparam name="variables.Bio" default="">
<cfparam name="variables.Appointment_Increment" default="15">
<cfif isDefined('session.u') AND NOT FindNoCase('/admin/',cgi.SCRIPT_NAME)>
	<cfset variables.First_Name=getCosmotrainingUser.FirstName>
	<cfset variables.Last_Name=getCosmotrainingUser.LastName>
	<cfset variables.Home_Address=getCosmotrainingUser.Address>
	<cfset variables.Home_Address2=getCosmotrainingUser.Address2>
	<cfset variables.Home_City=getCosmotrainingUser.City>
	<cfset variables.Home_State=getCosmotrainingUser.State>
	<cfset variables.Home_Postal=getCosmotrainingUser.PostalCode>
	<cfset variables.Home_Phone=getCosmotrainingUser.Telephone>
	<cfset variables.Email_Address=getCosmotrainingUser.Email>
	<cfset variables.Appointment_Increment=getCosmotrainingUser.Appointment_Increment>

</cfif>

<cfif qProfessional.recordcount gt 0>
	<cfset variables.First_Name=qProfessional.First_Name>
	<cfset variables.Last_Name=qProfessional.Last_Name>
	<cfset variables.Home_Phone=qProfessional.Home_Phone>
	<cfset variables.Mobile_Phone=qProfessional.Mobile_Phone>
	<cfset variables.Home_Address=qProfessional.Home_Address>
	<cfset variables.Home_Address2=qProfessional.Home_Address2>
	<cfset variables.Home_City=qProfessional.Home_City>
	<cfset variables.Home_State=qProfessional.Home_State>
	<cfset variables.Home_Postal=qProfessional.Home_Postal>
	<cfset variables.Email_Address=qProfessional.Email_Address>
	<cfset variables.Password=qProfessional.Password>
	<cfset variables.Services_Offered=qProfessional.Services_Offered>
	<cfset variables.Accredidations=qProfessional.Accredidations>
	<cfset variables.Bio=qProfessional.Bio>
	<cfset variables.Appointment_Increment=qProfessional.Appointment_Increment>
</cfif>

<script>
	$(document).ready(function(){
	    $('[data-toggle="popover"]').popover(); 
	});
	fnCheckEmailAddress = function(){

		if($('#Email_Address').val().length){

			$.ajax({
					type: "get",
					url: "company.cfc",
					data: {
						method: "isExistingEmailAddress",
						EmailAddress: $('#Email_Address').val(),
						noCache: new Date().getTime()
						},
					dataType: "json",

					// Define request handlers.
					success: function( objResponse ){
						// Check to see if request was successful.
						if (objResponse.SUCCESS){
							if(objResponse.DATA){
								alert('The Email address, ' + $('#Email_Address').val() + ', entered already exist.  Please enter a different address.');
								$('#Email_Address').val('');
								$('#Email_Address').focus();
							}

						} else {
							alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help.');
						}
					},

					error: function( objRequest, strError){
						alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help. ' + strError);
					}
			});
		}
	}

</script>

<cfoutput>
<cfif structKeyExists(variables, 'professional_tab')>
<input type="hidden" name ="professional_tab" value="#variables.professional_tab#">
</cfif>
<input type="hidden" name="Professional_ID" id="Professional_ID" value="#variables.Professional_ID#"> 
<cfif FindNoCase('/admin/',cgi.SCRIPT_NAME)>
	<div class="form-group">
		<label for="Location_ID" class="col-sm-3 control-label">Location</label>
		<div class="col-sm-9">
			<select name="Location_ID" id="Location_ID" class="form-control">
				<cfloop query="qLocation">
					<option value="#qLocation.Location_ID#" <cfif qLocation.Location_ID eq qProfessional.Location_ID>selected</cfif>>#qLocation.Location_Name#
					</option>
				</cfloop>
			</select>
		</div>
	</div>
</cfif>
<div class="form-group">
	<label for="First_Name" class="col-sm-3 control-label">First&nbsp;Name*</label>
	<div class="col-sm-9">
		<input type="text" name="First_Name" class="form-control" id="First_Name" value="#variables.First_Name#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Last_Name" class="col-sm-3 control-label">Last&nbsp;Name*</label>
	<div class="col-sm-9">
		<input type="text" name="Last_Name" class="form-control" id="Last_Name" value="#variables.Last_Name#" size="30" maxlength="50" required>
	</div>
</div>

<div class="form-group">
	<label for="Email_Address" class="col-sm-3 control-label">Email&nbsp;Address*</label>
	<div class="col-sm-9">
		<table>
			<tr>
			<td>
				<input type="text" name="Email_Address" class="form-control" onChange="fnCheckEmailAddress()" id="Email_Address" value="#variables.Email_Address#" size="30" maxlength="50" required>
			</td>
			<td>
				<span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Your e-mail address will be used to log in to your account. Your personal e-mail address will not be published on your web site.  You will have the opportunity to add a company e-mail address, on the Company Information tab, which will be published if you would like."></span>
			</td>
			</tr>
		</table>
	</div>
	<!--- <label for="Email_Address" class="col-sm-3 control-label">Email&nbsp;Address*</label>
	<div class="col-sm-9">
		<div class="input-group">
			<div class="input-group-addon">@</div>
			<input type="text" name="Email_Address" class="form-control" onChange="fnCheckEmailAddress()" id="Email_Address" value="#variables.Email_Address#" size="30" maxlength="50" required>
		</div>
	</div> --->
</div>
<div class="form-group">
		<label for="Mobile_Phone" class="col-sm-3 control-label">Mobile&nbsp;Phone *</label>
		<div class="col-sm-9">
			<table>
				<tr>
				<td>
			<input type="text" name="Mobile_Phone" class="form-control phone_us" id="Mobile_Phone" value="#variables.Mobile_Phone#" size="30" maxlength="50" required>
				</td>
				<td>
					<span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="A mobile number is required if you would like to receive text alerts when clients schedule appointments"></span>
				</td>
				</tr>
			</table>
		</div>
	</div>
<cfif NOT FindNoCase('/admin/',cgi.SCRIPT_NAME)>
	<!---
	<div class="form-group">
		<label for="Confirm_Email_Address" class="col-sm-3 control-label">Confirm&nbsp;Email*</label>
		<div class="col-sm-9">
			<input type="text" name="Confirm_Email_Address" class="form-control" id="Confirm_Email_Address" value="" size="30" maxlength="50" required>
		</div>
	</div>
	--->
	<div class="form-group">
		<label for="Password" class="col-sm-3 control-label">Create a Password*</label>
		<div class="col-sm-9">
			<table>
				<tr>
				<td>
					<input type="password" name="Password" class="form-control" id="Password" value="" size="30" maxlength="50" required>
				</td>
				<td>
					<span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Create any password you would like to log into your account in the future.  Use a password that you can easily remember."></span>
				</td>
				</tr>
			</table>
		</div>
	</div>
	<!---
	<div class="form-group">
		<label for="Confirm_Password" class="col-sm-3 control-label">Confirm&nbsp;Password*</label>
		<div class="col-sm-9">
			<input type="password" name="Confirm_Password" class="form-control" id="Confirm_Password" value="" size="30" maxlength="50" required>
		</div>
	</div>
	--->
	<div class="form-group">
		<label for="Promo_Code" class="col-sm-3 control-label">Promo&nbsp;Code</label>
		<div class="col-sm-9">
			<input type="text" name="Promo_Code" class="form-control" id="Promo_Code" value="#variables.Promo_Code#" size="30" maxlength="50">
		</div>
	</div>
<cfelse>
	<div class="form-group">
		<span class="col-sm-3 control-label">
			<a href="##" class="changeProfPassword" id="prof_#variables.Professional_ID#">Change password</a>
		</span>
	</div>
</cfif>
<div id="optionalpro" class="col-sm-12">
	<h2 style="color:##369FD9">Optional</h2>
	<!---<div class="form-group">
		<label for="Mobile_Phone" class="col-sm-3 control-label">Mobile&nbsp;Phone</label>
		<div class="col-sm-9">
			<table>
				<tr>
				<td>
			<input type="text" name="Mobile_Phone" class="form-control phone_us" id="Mobile_Phone" value="#variables.Mobile_Phone#" size="30" maxlength="50">
				</td>
				<td>
					<span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="A mobile number is required if you would like to receive text alerts when clients schedule appointments"></span>
				</td>
				</tr>
			</table>
		</div>
	</div>--->
	<!--- <div class="form-group">
		<label for="Home_Phone" class="col-sm-3 control-label">Home&nbsp;Phone</label>
		<div class="col-sm-9">
			<input type="text" name="Home_Phone" class="form-control phone_us" id="Home_Phone" value="#variables.Home_Phone#" size="30" maxlength="50">
		</div>
	</div>
	
	<div class="form-group">
		<label for="Home_Address" class="col-sm-3 control-label">Address</label>
		<div class="col-sm-9">
			<input type="text" name="Home_Address" class="form-control address" id="Home_Address" value="#variables.Home_Address#" size="30" maxlength="50">
		</div>
	</div>
	<div class="form-group">
		<label for="" class="col-sm-3 control-label"></label>
		<div class="col-sm-9">
			<input type="text" name="Home_Address2" class="form-control address" id="Home_Address2" value="#variables.Home_Address2#" size="30" maxlength="50">
		</div>
	</div>
	<div class="form-group">
		<label for="Home_City" class="col-sm-3 control-label">City</label>
		<div class="col-sm-9">
			<input type="text" name="Home_City" class="form-control city" id="Home_City" value="#variables.Home_City#" size="30" maxlength="50">
		</div>
	</div>

	<div class="form-group">
		<label for="Home_State" class="col-sm-3 control-label">State</label>
		<div class="col-sm-9">
			<cfinvoke component="states" method="getStates">
				<cfinvokeargument name="Select_Name" value="Home_State">
				<cfinvokeargument name="Selected_State" value="#variables.Home_State#">
			</cfinvoke>
		</div>
	</div>

	<div class="form-group">
		<label for="Home_Postal" class="col-sm-3 control-label">Postal</label>
		<div class="col-sm-9">
			<input type="text" name="Home_Postal" class="form-control" id="Home_Postal" value="#variables.Home_Postal#" size="30" maxlength="50">
		</div>
	</div> --->
	<input type="hidden" name="Home_Phone" value="">
	<input type="hidden" name="Home_Address" value="">
	<input type="hidden" name="Home_Address2" value="">
	<input type="hidden" name="Home_City" value="">
	<input type="hidden" name="Home_State" value="">
	<input type="hidden" name="Home_Postal" value="">
	<div class="form-group">
		<label for="staffImageFile" class="col-sm-3 control-label">Profile Picture</label>
		<div class="col-sm-9">
			<table>
			<tr>
			<td>
			<input type="file" id="staffImageFile" name="staffImageFile" accept="image/gif, image/jpeg,image/png"/> (jpg, gif, or png)  <span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="If you decide to upload an image of yourself, it will be displayed along with your name and bio on the staff page of your website."></span>
		    <cfif Find(cgi.script_name,"/dev/admin")>
			    <cfset variables.webpath = "../images/staff/" />
			<cfelse>
				<cfset variables.webpath = "/images/staff/" />
			</cfif>
			<cfset variables.path = expandPath(variables.webpath) />
			<cfset variables.FilePath = variables.path & variables.professional_id & ".jpg" />
			<cfif FileExists(variables.FilePath)>
				<a href="#variables.webpath##session.Professional_ID#.jpg?#now().getTime()#" target="_blank" width="300" height="300" border="0">View Image</a>
			</cfif></td>
			</tr>
			</table>
		</div>
	</div>
	<div class="form-group">
		<label for="Bio" class="col-sm-3 control-label">Bio <span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Your bio will appear next to your name on the staff page of your website. You can use the toolbar to add formating (bold, italics, etc) to your bio."></span></label>
		<div class="col-sm-9">
			<!--- <cftextarea name="Bio" richtext="yes" toolbar="Basic" rows="10" cols="50" value="#variables.Bio#" /> --->
			<input type="hidden" id="Bio" name="Bio" />
			<div id="Bio_summernote">#variables.Bio#</div>
		</div>
	</div>
	<div class="form-group">
		<label for="Appointment_Increment" class="col-sm-3 control-label">Appointment Increment</label>
		<div class="col-sm-9">
			<select id="Appointment_Increment" name="Appointment_Increment">
				<option value="15" <cfif variables.Appointment_Increment EQ 15>selected="selected"</cfif>>15 Minutes</option>
				<option value="30" <cfif variables.Appointment_Increment EQ 30>selected="selected"</cfif>>30 Minutes</option>
				<option value="60" <cfif variables.Appointment_Increment EQ 60>selected="selected"</cfif>>60 Minutes</option>
			</select>
		</div>
	</div>
</div>
</cfoutput>
<cfif NOT FindNoCase('/admin/',cgi.SCRIPT_NAME)>
	<div class="eml">
	<input type="text" name="emailaddress" size="1">
	</div>
</cfif>