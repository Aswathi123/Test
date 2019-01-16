<cfinvoke component="company" method="getCompany" returnvariable="qCompany">
	<cfinvokeargument name="Company_ID" value="#variables.company_id#">
</cfinvoke>

<cfset variables.companyCFC = createObject("component","company") />
<cfset variables.qrySocialMedia = variables.companyCFC.getCompanySocialMediaPlus(variables.company_id) />

<script>
	fnCheckWebAddress = function(){

		if($('#Web_Address').val().length){
			if($('#Web_Address').val().toLowerCase() == 'www'){
				alert('Web Address can not be "www".');
				$('#Web_Address').val('');
				$('#Web_Address').focus();
				return false;
			}
			$.ajax({
					type: "get",
					url: "/admin/company.cfc",
					data: {
						method: "isExistingWebAddress",
						WebAddress: $('#Web_Address').val(),
						noCache: new Date().getTime()
						},
					dataType: "json",

					// Define request handlers.
					success: function( objResponse ){
						// Check to see if request was successful.
						if (objResponse.SUCCESS){
							if(objResponse.DATA){
								alert('The web address, ' + $('#Web_Address').val() + ', entered already exist.  Please enter a different address.');
								$('#Web_Address').val('');
								$('#Web_Address').focus();
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

	fnCheckCompanyEmail = function(){

		if($('#Company_Email').val().length){

			$.ajax({
					type: "get",
					url: "/admin/company.cfc",
					data: {
						method: "isExistingCompanyEmail",
						CompanyEmail: $('#Company_Email').val(),
						noCache: new Date().getTime()
						},
					dataType: "json",

					// Define request handlers.
					success: function( objResponse ){
						// Check to see if request was successful.
						if (objResponse.SUCCESS){
							if(objResponse.DATA){
								alert('The Company Email, ' + $('#Company_Email').val() + ', entered already exist.  Please enter a different address.');
								$('#Company_Email').val('');
								$('#Company_Email').focus();
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


isAllowedNavigationANKeys = function(code) {
	//backspace 	delete 			tab 		escape  	enter			l-arrow		u-arrow			r-arrow			d-arrow
	if (code == 46 || code == 8 || code == 9 || code == 27 || code == 13 || code == 37 || code == 38 || code == 39 || code == 40 || code == 189 || code == 109) {
		return true;
	} else {
		return false;
	}
}

keydownAcceptFilterAlphaNumeric = function(e) {
	e = e || event;
	var code = e.which || e.keyCode;


	if(e.shiftKey || code == 16){
		(e.preventDefault) ? e.preventDefault() : e.returnValue = false;
		return false;
	}


	if (isAllowedNavigationANKeys(code)) {
		//Allow Navigation Keys
	} else if ((code < 48 || code > 90 ) && (code < 96 || code > 105 )) {
		//Allow only numbers from keyboard and pad

		(e.preventDefault) ? e.preventDefault() : e.returnValue = false;
		return false;
	}
}

 $(document).ready(function(){
	$("#Web_Address").keydown(function(e){keydownAcceptFilterAlphaNumeric(e);});
	$('.phone_us').mask('(000) 000-0000');
 });



</script>


<cfoutput>
<input type="hidden" name="company_id" id="company_id" value="#variables.company_id#">
<div class="form-group">
	<label for="Web_Address" class="col-sm-3 control-label">Web&nbsp;Address*</label>
	<div class="col-sm-9">
		<table>
		<tr>
		<td><input type="text" name="Web_Address" class="form-control" onChange="fnCheckWebAddress()" style="width:200px" id="Web_Address" value="#qCompany.Web_Address#" size="30" maxlength="50" required></td><td>.salonworks.com  <span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-placement="top" data-content="Enter the address you would like for your website. For example: mysite.salonworks.com"></span></td>
		</tr>
		</table>
	</div>
</div>
<div class="form-group">
	<label for="x" class="col-sm-3 control-label">Company&nbsp;Name*</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Name" class="form-control" id="Company Name" value="#qCompany.Company_Name#" maxlength="50" required>
	</div>
</div>

<div class="form-group">
	<label for="Company_Address" class="col-sm-3 control-label">Company&nbsp;Address*</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Address" class="form-control address" id="Company_Address" value="#qCompany.Company_Address#" size="30" maxlength="50" required>
	</div>
</div>

<div class="form-group">
	<label for="Company_Address2" class="col-sm-3 control-label"></label>
	<div class="col-sm-9">
	<input type="text" name="Company_Address2" class="form-control address" id="Company_Address2" value="#qCompany.Company_Address2#" size="30" maxlength="50">
	</div>
</div>
<div class="form-group">
	<label for="Company_City" class="col-sm-3 control-label">Company&nbsp;City*</label>
	<div class="col-sm-9">
		<input type="text" name="Company_City" class="form-control city" id="Company_City" value="#qCompany.Company_City#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Company_State" class="col-sm-3 control-label">Company&nbsp;State*</label>
	<div class="col-sm-9">
		<cfinvoke component="states" method="getStates">
			<cfinvokeargument name="Select_Name" value="Company_State">
			<cfinvokeargument name="Selected_State" value="#qCompany.Company_State#">
			<cfinvokeargument name="IsRequired" value="true">
		</cfinvoke>
	</div>
</div>
<div class="form-group">
	<label for="Company_Postal" class="col-sm-3 control-label">Company&nbsp;Postal&nbsp;Code*</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Postal" class="form-control" id="Company_Postal" value="#qCompany.Company_Postal#" size="30" maxlength="50" required>
	</div>
</div>

<div class="form-group">
	<label for="Company_Phone" class="col-sm-3 control-label">Company&nbsp;Phone*</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Phone" class="form-control phone_us" id="Company_Phone" value="#qCompany.Company_Phone#" size="30" maxlength="50">
	</div>
</div>
<div class="form-group">
	<label for="Company_Email" class="col-sm-3 control-label">Company&nbsp;Email</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Email" class="form-control" id="Company_Email" value="#qCompany.Company_Email#" size="30" maxlength="50">
	</div>
</div>

<div class="form-group">
	<label for="Company_Fax" class="col-sm-3 control-label">Company&nbsp;Fax</label>
	<div class="col-sm-9">
		<input type="text" name="Company_Fax" class="form-control phone_us" id="Company_Fax" value="#qCompany.Company_Fax#" size="30" maxlength="50">
	</div>
</div>

<div class="form-group">
	<label for="companyImageFile" class="col-sm-3 control-label">Company&nbsp;Picture</label>
	<div class="col-sm-9">
		<table>
		<tr>
		<td>
		<input type="file" name="companyImageFile" id="companyImageFile" value=""> (.jpg, .gif, or .png)  <span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-placement="top" data-content="Upload an image to be displayed on the front page of your website"></span></td>
		</tr>
		</table>
	    <cfif Find(cgi.script_name,"/admin")>
		    <cfset variables.webpathC = "../images/company/" />
		<cfelse>
			<cfset variables.webpathC = "/images/company/" />
		</cfif>
		<cfset variables.pathC = expandPath(variables.webpathC) />
		<cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
		<cfif FileExists(variables.FilePathC)>
			<a href="#variables.webpathC##session.company_id#.jpg" target="_blank" width="300" height="300" border="0">View Image</a>
		</cfif>
	</div>
</div>
<div class="form-group">
	<label for="x" class="col-sm-3 control-label">Company&nbsp;Description</label><span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-placement="top" data-content="This description will appear on the front page of your web site describing your business."></span>
	<div class="col-sm-9">
		<!--- <cftextarea name="Company_Description"  class="form-control txteditor" rows="10" cols="50" richtext="yes" toolbar="Basic" onchange="$('##Company_Description').val(this.value);">
		#qCompany.Company_Description#
		</cftextarea> --->
		<input type="hidden" id="Company_Description" name="Company_Description" />
		<div id="Company_Description_summernote">#qCompany.Company_Description#</div>
	</div>
</div>
<h2>Social Media</h2>
<cfloop query="variables.qrySocialMedia">
 	<div class="form-group">
		<label for="x" class="col-sm-3 control-label">#variables.qrySocialMedia.Site_Name#<img src="../images/#variables.qrySocialMedia.Logo_File#" border="0" width="25"/></label>
		<div class="col-sm-9">
			 <input type="text" class="form-control" id="socialMediaURLurl_#variables.qrySocialMedia.Social_Media_ID#" name="url_#variables.qrySocialMedia.Social_Media_ID#" value="#variables.qrySocialMedia.url#" />
		</div>
	</div>
</cfloop>
</cfoutput>