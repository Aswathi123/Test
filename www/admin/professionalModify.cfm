<cfinclude template="header.cfm" />
<cfif Not IsDefined("Session.Professional_ID")>
		<cflocation url="login.cfm" />
</cfif>
<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script>
<script language="javascript" type="text/javascript">

	$(document).ready(function(){
		initializePage();
		$("#frmDataForm").validate();
	
	  });
	  
	function initializePage(){
		<cfoutput>
			document.getElementById('LicenseExpirationMonth').value = "#Session.Form.LicenseExpirationMonth#";
			document.getElementById('LicenseExpirationYear').value = "#Session.Form.LicenseExpirationYear#";
		</cfoutput>
	}
</script>

<cfoutput>
<br />
<div id="form-main">
    <form class="cmxform" id="frmDataForm" name="frmDataForm" method="post" action="professionalModifyProcess.cfm" enctype="multipart/form-data">  
        <div id="form-controls">
            <div class="control-row">
               <label for="FirstName">First Name <em>*</em></label>
                    <input type="text" name="FirstName" id="FirstName" value="#Session.Form.FirstName#" class="txt-med enabled required" maxlength="50" />
            </div>
            <div class="control-row">
               <label for="LastName">Last Name &nbsp;&nbsp;</label>
                    <input type="text" name="LastName" id="LastName" value="#Session.Form.LastName#" class="txt-med" maxlength="50" />
            </div>            
            
            <div class="control-row">
               <label for="LicenseNumber">License Number &nbsp;&nbsp;</label>
                    <input type="text" name="LicenseNumber" id="LicenseNumber" value="#Session.Form.LicenseNumber#" class="txt-med" maxlength="50" />
            </div>  
            
			<div class="control-row">
               <label for="LicenseExpirationMonth">License Expiration Month &nbsp;&nbsp;</label>
                    <select name="LicenseExpirationMonth" id="LicenseExpirationMonth">
                        <option value="">Please Select One</option>
                        <cfloop from="#Evaluate(Year(now())-2)#" to="#Evaluate(Year(now())+6)#" index="y">
                            <option value="#y#">#y#</option>
                        </cfloop>
                    </select>
            </div>

			<div class="control-row">
               <label for="LicenseExpirationYear">License Expiration Year &nbsp;&nbsp;</label>
                    <select name="LicenseExpirationYear" id="LicenseExpirationYear">
                        <option value="">Please Select One</option>
                        <cfloop from="1" to="12" index="m">
                        	<option value="#m#">#MonthAsString(m)#</option>
                        </cfloop>
                    </select>
            </div>                       
        
			<div class="control-row">
               <label for="LicenseState">License State &nbsp;&nbsp;</label>
                <cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="LicenseState">
                    <cfinvokeargument name="Selected_State" value="#Session.Form.LicenseState#">
                </cfinvoke>
            </div>              

            <div class="control-row">
               <label for="HomePhone">Home Phone &nbsp;&nbsp;</label>
                    <input type="text" name="HomePhone" id="HomePhone" value="#Session.Form.HomePhone#" class="txt-med" maxlength="20" />
            </div> 
            
            <div class="control-row">
               <label for="MobilePhone">Mobile Phone &nbsp;&nbsp;</label>
                    <input type="text" name="MobilePhone" id="MobilePhone" value="#Session.Form.MobilePhone#" class="txt-med" maxlength="20" />
            </div>                         
            
            <div class="control-row">
               <label for="HomeAddress">Home Address &nbsp;&nbsp;</label>
                    <input type="text" name="HomeAddress" id="HomeAddress" value="#Session.Form.HomeAddress#" class="txt-med" maxlength="50" />
                    <input type="text" name="HomeAddress2" id="HomeAddress2" value="#Session.Form.HomeAddress2#" class="txt-med" maxlength="50" />
            </div>              
            
            <div class="control-row">
               <label for="HomeCity">Home City &nbsp;&nbsp;</label>
                    <input type="text" name="HomeCity" id="HomeCity" value="#Session.Form.HomeCity#" class="txt-med" maxlength="50" />
            </div>  
            
			<div class="control-row">
               <label for="HomeState">Home State &nbsp;&nbsp;</label>
                <cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="HomeState">
                    <cfinvokeargument name="Selected_State" value="#Session.Form.HomeState#">
                </cfinvoke>
            </div> 
            
            <div class="control-row">
               <label for="HomePostal">Home Postal &nbsp;&nbsp;</label>
                    <input type="text" name="HomePostal" id="HomePostal" value="#Session.Form.HomePostal#" class="txt-sm" maxlength="20" />
            </div>    
            
            <div class="control-row">
               <label for="EmailAddress">Email Address &nbsp;&nbsp;</label>
                    <input type="text" name="EmailAddress" id="EmailAddress" value="#Session.Form.EmailAddress#" class="txt-xlg email" maxlength="150" />
            </div>
            
            
            <div class="control-row">
               <label for="Password">Password &nbsp;&nbsp;</label>
                    <input type="password" name="Password" id="Password" value="#Session.Form.Password#" class="txt-med" maxlength="100" />
            </div> 
            
			<div class="control-row" style="height:100%">
               <label for="ServicesOffered">Services Offered &nbsp;&nbsp;</label>
                    <textarea id="ServicesOffered" name="ServicesOffered" maxlength="1000" cols="50" rows="5">#Session.Form.ServicesOffered#</textarea>
            </div> 
			<br />
			<div class="control-row" style="height:100%">
               <label for="Accredidations">Accredidations &nbsp;&nbsp;</label>
                    <textarea id="Accredidations" name="Accredidations" maxlength="1000" cols="50" rows="5">#Session.Form.Accredidations#</textarea>
            </div> 
			<br />
			<div class="control-row" style="height:100%">
               <label for="Bio">Bio &nbsp;&nbsp;</label>
                    <textarea id="Bio" name="Bio" maxlength="4000" cols="50" rows="5">#Session.Form.Bio#</textarea>
            </div> 

			<div class="control-row" style="height:100%">  
               <label for="Bio">Profile Picture &nbsp;&nbsp;</label>
                    <input type="file" id="staffImageFile" name="staffImageFile"/> (jpg, gif, or png) 
				<cfset variables.FilePath = expandPath("../images/staff/") & session.Professional_ID & ".jpg" />
				<cfif FileExists(variables.FilePath)>
					<a href="../images/staff/#session.Professional_ID#.jpg" target="_blank" width="300" height="300" border="0">View Image</a>
				</cfif>
            </div> 


			<br clear="all" />
            <div style="margin-left: 50px;"><input type="submit" id="btnSave" name="btnSave" 
            		value="Save" style="width: 100px"  /></div>  
        </div>
    </form>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">