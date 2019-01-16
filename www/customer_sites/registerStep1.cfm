<cfinclude template="header.cfm">

<cfif Not IsDefined("Session.Form")>
	<cfset Session.Form = StructNew() />
	<cfinclude template="registerInit.cfm" />
    <cfset Session.ReachedPage = "1" />
    
    <cfif Session.LastPageReached LT Session.ReachedPage>
		<cfset Session.LastPageReached = Session.ReachedPage />
	</cfif>
</cfif>
<cfoutput>#Session.LastPageReached#</cfoutput>
 

<!--- Submitted from Step 2 through Previous Button  Save Company Information --->
<cfif IsDefined("FORM.btnSubmitStep2Back")>
	<cfparam name="FORM.WebAddress" default="" />
    <cfparam name="FORM.CompanyName" default="" />
    <cfparam name="FORM.CompanyAddress" default="" />
    <cfparam name="FORM.CompanyAddress2" default="" />
    <cfparam name="FORM.CompanyCity" default="" />
    <cfparam name="FORM.CompanyState" default="" />
    <cfparam name="FORM.CompanyPostal" default="" />
    <cfparam name="FORM.CompanyPhone" default="" />
    <cfparam name="FORM.CompanyEmail" default="" />
    <cfparam name="FORM.CompanyFax" default="" />
    <cfparam name="FORM.CompanyDescription" default="" />

	<cfset Session.Form.WebAddress = HTMLEditFormat(Form.WebAddress) />
    <cfset Session.Form.CompanyName = HTMLEditFormat(Form.CompanyName) />
    <cfset Session.Form.CompanyAddress = HTMLEditFormat(Form.CompanyAddress) />
    <cfset Session.Form.CompanyAddress2 = HTMLEditFormat(Form.CompanyAddress2) />
    <cfset Session.Form.CompanyCity = HTMLEditFormat(Form.CompanyCity) />
    <cfset Session.Form.CompanyState = HTMLEditFormat(Form.CompanyState) />
    <cfset Session.Form.CompanyPostal = HTMLEditFormat(Form.CompanyPostal) />
    <cfset Session.Form.CompanyPhone = HTMLEditFormat(Form.CompanyPhone) />
    <cfset Session.Form.CompanyEmail = HTMLEditFormat(Form.CompanyEmail) />
    <cfset Session.Form.CompanyFax = HTMLEditFormat(Form.CompanyFax) />
    <cfset Session.Form.CompanyDescription = HTMLEditFormat(Form.CompanyDescription) />  
</cfif>

<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>

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
<div id="form-main">
    <cfform class="cmxform" id="frmDataForm" name="frmDataForm" method="post" action="registerStep2.cfm">  
        <ul id="tabs">
            <li id="l1" class="current">Step 1. Professional Information</li>
            <li id="l2">Step 2. Company Information</li>
            <li id="l3">Step 3. Location Information</li>                 
        </ul>
        <br clear="all" />
		<br clear="all" />
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
            </div>  

            <div class="control-row">
			<label for="HomeAddress2">&nbsp;&nbsp;</label>
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
                    <cftextarea id="ServicesOffered" name="ServicesOffered" maxlength="1000" cols="50" rows="5" richtext="no">#Session.Form.ServicesOffered#</cftextarea>
            </div> 
			<br />
			<div class="control-row" style="height:100%">
               <label for="Bio">Bio &nbsp;&nbsp;</label>
                    <cftextarea id="Bio" name="Bio" maxlength="4000" cols="50" rows="5" richtext="no">#Session.Form.Bio#</cftextarea>
            </div> 
			<div class="control-row" style="height:100%">
               <label for="Accredidations">Accredidations &nbsp;&nbsp;</label>
                    <textarea id="Accredidations" name="Accredidations" maxlength="1000" cols="50" rows="5">#Session.Form.Accredidations#</textarea>
            </div> 
			<br />

           <br clear="all" />
        </div>
       <br clear="all" />
        <div><input type="submit" id="btnSubmitStep1" name="btnSubmitStep1" value="Next Step" style="width: 100px" /></div>
    </cfform>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">