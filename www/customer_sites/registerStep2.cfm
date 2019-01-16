<!--- <cfif NOT len(cgi.http_referer) OR NOT findnocase(cgi.http_host,cgi.http_referer) OR Not IsDefined("Session.Form")>
   <cflocation url="registerStep1.cfm" />
</cfif> --->

<!--- Submitted from Step 1.  Save Professional Information--->
<cfif IsDefined("FORM.btnSubmitStep1")>
    <cfparam name="FORM.FirstName" default="" />
    <cfparam name="FORM.LastName" default="" />
    <cfparam name="FORM.LicenseNumber" default="" />
    <cfparam name="FORM.LicenseExpirationMonth" default="" />
    <cfparam name="FORM.LicenseExpirationYear" default="" />
    <cfparam name="FORM.LicenseState" default="" />
    <cfparam name="FORM.HomePhone" default="" />
    <cfparam name="FORM.MobilePhone" default="" />
    <cfparam name="FORM.HomeAddress" default="" />
    <cfparam name="FORM.HomeAddress2" default="" />
    <cfparam name="FORM.HomeCity" default="" />
    <cfparam name="FORM.HomePostal" default="" />
    <cfparam name="FORM.HomeState" default="" />
    <cfparam name="FORM.EmailAddress" default="" />
    <cfparam name="FORM.Password" default="" />
    <cfparam name="FORM.ServicesOffered" default="" />
    <cfparam name="FORM.Accredidations" default="" />
    <cfparam name="FORM.Bio" default="" />
    
    <cfset Session.Form.FirstName = HTMLEditFormat(Form.FirstName) />
    <cfset Session.Form.LastName = HTMLEditFormat(Form.LastName) />
    <cfset Session.Form.LicenseNumber = HTMLEditFormat(Form.LicenseNumber) />
    <cfset Session.Form.LicenseExpirationMonth = HTMLEditFormat(Form.LicenseExpirationMonth) />
    <cfset Session.Form.LicenseExpirationYear = HTMLEditFormat(Form.LicenseExpirationYear) />
    <cfset Session.Form.LicenseState = HTMLEditFormat(Form.LicenseState) />
    <cfset Session.Form.HomePhone = HTMLEditFormat(Form.HomePhone) />
    <cfset Session.Form.MobilePhone = HTMLEditFormat(Form.MobilePhone) />
    <cfset Session.Form.HomeAddress = HTMLEditFormat(Form.HomeAddress) />
    <cfset Session.Form.HomeAddress2 = HTMLEditFormat(Form.HomeAddress2) />
    <cfset Session.Form.HomeCity = HTMLEditFormat(Form.HomeCity) />
    <cfset Session.Form.HomePostal = HTMLEditFormat(Form.HomePostal) />
    <cfset Session.Form.HomeState = HTMLEditFormat(Form.HomeState) />
    <cfset Session.Form.EmailAddress = HTMLEditFormat(Form.EmailAddress) />
    <cfset Session.Form.Password = HTMLEditFormat(Form.Password) />
    <cfset Session.Form.ServicesOffered = HTMLEditFormat(Form.ServicesOffered) />
    <cfset Session.Form.Accredidations = HTMLEditFormat(Form.Accredidations) />
    <cfset Session.Form.Bio = HTMLEditFormat(Form.Bio) />    
  
    <cfset Session.ReachedPage = "2" />
	<!--- 2/25/2013 For now I am commenting this out because I'm getting an errror: Element LASTPAGEREACHED is undefined in SESSION --->
<!---    --->   <cfif Session.LastPageReached LT Session.ReachedPage>
		<cfset Session.LastPageReached = Session.ReachedPage />
	</cfif>   
</cfif>

<cfif IsDefined("FORM.btnSubmitStep3Back")>
	<cfparam name="FORM.LocationName" default="" />
	<cfparam name="FORM.ContactName" default="" />
	<cfparam name="FORM.ContactPhone" default="" />
	<cfparam name="FORM.LocationAddress" default="" />
    <cfparam name="FORM.LocationAddress2" default="" />
    <cfparam name="FORM.LocationCity" default="" />
    <cfparam name="FORM.LocationState" default="" />
    <cfparam name="FORM.LocationPostal" default="" />
    <cfparam name="FORM.LocationPhone" default="" />
    <cfparam name="FORM.LocationFax" default="" />
    <cfparam name="FORM.Description" default="" />
    <cfparam name="FORM.PaymentMethodsList" default="" />
    <cfparam name="FORM.ParkingFees" default="" />
    <cfparam name="FORM.CancellationPolicy" default="" />
    <cfparam name="FORM.Languages" default="" />
    <cfparam name="FORM.Directions" default="" />
    <cfparam name="FORM.SundayHoursFrom" default="" />
    <cfparam name="FORM.SundayHoursTo" default="" />
    <cfparam name="FORM.MondayHoursFrom" default="" />
    <cfparam name="FORM.MondayHoursTo" default="" />
    <cfparam name="FORM.TuesdayHoursFrom" default="" />
    <cfparam name="FORM.TuesdayHoursTo" default="" />
    <cfparam name="FORM.WednesdayHoursFrom" default="" />
    <cfparam name="FORM.WednesdayHoursTo" default="" />
    <cfparam name="FORM.ThursdayHoursFrom" default="" />
    <cfparam name="FORM.ThursdayHoursTo" default="" />
    <cfparam name="FORM.FridayHoursFrom" default="" />
    <cfparam name="FORM.FridayHoursTo" default="" />
    <cfparam name="FORM.SaturdayHoursFrom" default="" />
    <cfparam name="FORM.SaturdayHoursTo" default="" />                    

	<cfset Session.Form.LocationName = HTMLEditFormat(Form.LocationName) />
	<cfset Session.Form.ContactName = HTMLEditFormat(Form.ContactName) />
	<cfset Session.Form.ContactPhone = HTMLEditFormat(Form.ContactPhone) />
	<cfset Session.Form.LocationAddress = HTMLEditFormat(Form.LocationAddress) />
    <cfset Session.Form.LocationAddress2 = HTMLEditFormat(Form.LocationAddress2) />
    <cfset Session.Form.LocationCity = HTMLEditFormat(Form.LocationCity) />
    <cfset Session.Form.LocationState = HTMLEditFormat(Form.LocationState) />
    <cfset Session.Form.LocationPostal = HTMLEditFormat(Form.LocationPostal) />
    <cfset Session.Form.LocationPhone = HTMLEditFormat(Form.LocationPhone) />
    <cfset Session.Form.LocationFax = HTMLEditFormat(Form.LocationFax) />
    <cfset Session.Form.Description = HTMLEditFormat(Form.Description) />
    <cfset Session.Form.PaymentMethodsList = HTMLEditFormat(Form.PaymentMethodsList) />
    <cfset Session.Form.ServicesList = HTMLEditFormat(Form.ServicesList) />
    <cfset Session.Form.ParkingFees = HTMLEditFormat(Form.ParkingFees) />
    <cfset Session.Form.CancellationPolicy = HTMLEditFormat(Form.CancellationPolicy) />
    <cfset Session.Form.Languages = HTMLEditFormat(Form.Languages) />
    <cfset Session.Form.Directions = HTMLEditFormat(Form.Directions) />
    <cfset Session.Form.SundayHoursFrom = Form.SundayHoursFrom />
    <cfset Session.Form.SundayHoursTo = Form.SundayHoursTo />
    <cfset Session.Form.MondayHoursFrom = Form.MondayHoursFrom />
    <cfset Session.Form.MondayHoursTo = Form.MondayHoursTo />
    <cfset Session.Form.TuesdayHoursFrom = Form.TuesdayHoursFrom />
    <cfset Session.Form.TuesdayHoursTo = Form.TuesdayHoursTo />
    <cfset Session.Form.WednesdayHoursFrom = Form.WednesdayHoursFrom />
    <cfset Session.Form.WednesdayHoursTo = Form.WednesdayHoursTo />
    <cfset Session.Form.ThursdayHoursFrom = Form.ThursdayHoursFrom />
    <cfset Session.Form.ThursdayHoursTo = Form.ThursdayHoursTo />
    <cfset Session.Form.FridayHoursFrom = Form.FridayHoursFrom />
    <cfset Session.Form.FridayHoursTo = Form.FridayHoursTo />
    <cfset Session.Form.SaturdayHoursFrom = Form.SaturdayHoursFrom />
    <cfset Session.Form.SaturdayHoursTo = Form.SaturdayHoursTo />
</cfif>

<cfinclude template="header.cfm">
<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script language="javascript" type="text/javascript">

	$(document).ready(function(){
		initializePage();
		$("#frmDataForm").validate();
	
	  });
	  
	function initializePage(){

	}
</script>

<cfoutput>
<div id="form-main">
    <form id="frmDataForm" name="frmDataForm" method="post" action="registerStep3.cfm">  
        <ul id="tabs">
            <li id="l1">Step 1. Professional Information</li>
            <li id="l2" class="current">Step 2. Company Information</li>
            <li id="l3">Step 3. Location Information</li>                  
        </ul>
        <br clear="all" />
		<br clear="all" />
        
        <div id="form-controls">
            <div class="control-row">
               <label for="WebAddress">Web Address &nbsp;&nbsp;</label>
                    <input type="text" name="WebAddress" id="WebAddress" value="#Session.Form.WebAddress#" class="txt-med required" maxlength="50" />.salonworks.com
            </div>
            <div class="control-row">
               <label for="CompanyName">Company Name  &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyName" id="CompanyName" value="#Session.Form.CompanyName#" class="txt-med" maxlength="50" />
            </div>            
            
            <div class="control-row">
               <label for="CompanyAddress">Company Address &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyAddress" id="CompanyAddress" value="#Session.Form.CompanyAddress#" class="txt-med" maxlength="50" />
            </div>  

            <div class="control-row">
			<label for="CompanyAddress2">&nbsp;&nbsp;</label>
                   <input type="text" name="CompanyAddress2" id="CompanyAddress2" value="#Session.Form.CompanyAddress2#" class="txt-med" maxlength="50" />
            </div>  
                                 
            <div class="control-row">
               <label for="CompanyCity">Company City &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyCity" id="CompanyCity" value="#Session.Form.CompanyCity#" class="txt-med" maxlength="50" />
            </div>             

			<div class="control-row">
               <label for="CompanyState">Company State &nbsp;&nbsp;</label>
                <cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="CompanyState">
                    <cfinvokeargument name="Selected_State" value="#Session.Form.CompanyState#">
                </cfinvoke>
            </div>   
                       
            <div class="control-row">
               <label for="CompanyPostal">Company Postal &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyPostal" id="CompanyPostal" value="#Session.Form.CompanyPostal#" class="txt-sm" maxlength="50" />
            </div>   
            
            <div class="control-row">
               <label for="CompanyPhone">Company Phone &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyPhone" id="CompanyPhone" value="#Session.Form.CompanyPhone#" class="txt-med" maxlength="50" />
            </div> 
            
            <div class="control-row">
               <label for="CompanyEmail">Company Email &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyEmail" id="CompanyEmail" value="#Session.Form.CompanyEmail#" class="txt-med email" maxlength="50" />
            </div>                         
          
            
            <div class="control-row">
               <label for="CompanyFax">Company Fax &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyFax" id="CompanyFax" value="#Session.Form.CompanyFax#" class="txt-med" maxlength="50" />
            </div>  
            
			<div class="control-row" style="height:100%">
               <label for="CompanyDescription">Company Description &nbsp;&nbsp;</label>
                    <textarea id="CompanyDescription" name="CompanyDescription" maxlength="4000" cols="50" rows="5">#Session.Form.CompanyDescription#</textarea>
            </div> 


           <br clear="all" />
        </div>
       <br clear="all" />
        <div>
        	<input type="submit" id="btnSubmitStep2Back" name="btnSubmitStep2Back" value="Previous Step" style="width: 100px" onclick="this.form.action = 'registerStep1.cfm';" />
        	<input type="submit" id="btnSubmitStep2" name="btnSubmitStep2" value="Next Step" style="width: 100px" /></div>
    </form>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">