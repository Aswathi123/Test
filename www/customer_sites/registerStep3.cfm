<cfif NOT len(cgi.http_referer) OR NOT findnocase(cgi.http_host,cgi.http_referer) OR Not IsDefined("Session.Form")>
   <cflocation url="registerStep1.cfm" />
</cfif>


<!--- Submitted from Step 2.  Save Company Information --->
<cfif IsDefined("FORM.btnSubmitStep2")>
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

  
    <cfset Session.ReachedPage = "3" />
    <cfif Session.LastPageReached LT Session.ReachedPage>
		<cfset Session.LastPageReached = Session.ReachedPage />
	</cfif>    
</cfif>

<cfinclude template="header.cfm">
<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script type="text/javascript" src="/js/form_validation.js"></script>
<script language="javascript" type="text/javascript">

	$(document).ready(function(){
		initializePage();
		$("#frmDataForm").validate();
	
	  });
	  
	function initializePage(){
		var optionsToSelect = [<cfoutput>#Session.Form.PaymentMethodsList#</cfoutput>];
		var elSelect = document.getElementById('PaymentMethodsList');
		
		for(var i = 0; i < elSelect.options.length; i++){
			o = elSelect.options[i];
			for(var j=0; j < optionsToSelect.length; j++){
				if(o.value == optionsToSelect[j]){
					o.selected = true;
				}
			}
		}
	}
</script>

<cfoutput>
<div id="form-main"> 
<cfif session.form.contactname eq ''>
	<cfset session.form.contactname = session.form.FirstName&' '&session.form.LastName>
</cfif>

<cfif session.form.ContactPhone eq ''>
	<cfset session.form.ContactPhone = session.form.COMPANYPHONE>
</cfif>

<cfif session.form.LocationAddress eq ''>
	<cfset session.form.LocationAddress = session.form.COMPANYADDRESS>
</cfif>

<cfif session.form.LocationAddress2 eq ''>
	<cfset session.form.LocationAddress2 = session.form.COMPANYADDRESS2>
</cfif>

<cfif session.form.LocationCity eq ''>
	<cfset session.form.LocationCity = session.form.CompanyCity>
</cfif>


<cfif session.form.LocationState eq ''>
	<cfset session.form.LocationState = session.form.CompanyState>
</cfif>
<cfif session.form.LocationPostal eq ''>
	<cfset session.form.LocationPostal = session.form.CompanyPostal>
</cfif>

<cfif session.form.LocationPhone eq ''>
	<cfset session.form.LocationPhone = session.form.CompanyPhone>
</cfif>
<cfif session.form.LocationFax eq ''>
	<cfset session.form.LocationFax = session.form.CompanyFax>
</cfif>


<!--- onsubmit="return validateForm();"  --->
    <form id="frmDataForm" name="frmDataForm" method="post" action="registerProcess.cfm">  
        <ul id="tabs">
            <li id="l1">Step 1. Professional Information</li>
            <li id="l2">Step 2. Company Information</li>
            <li id="l3" class="current">Step 3. Location Information</li>                  
        </ul>
        <br clear="all" />            
		<br clear="all" />
        
        <div id="form-controls">
            <div class="control-row">
               <label for="LocationName">Location Name &nbsp;&nbsp;</label>
                    <input type="text" name="LocationName" id="LocationName" value="#Session.Form.LocationName#" class="txt-med" maxlength="50" />
            </div>

            <div class="control-row">
               <label for="ContactName">Contact Name &nbsp;&nbsp;</label>
                    <input type="text" name="ContactName" id="ContactName" value="#Session.Form.ContactName#" class="txt-med" maxlength="50" />
            </div>


            <div class="control-row">
               <label for="ContactPhone">Contact Phone &nbsp;&nbsp;</label>
                    <input type="text" name="ContactPhone" id="ContactPhone" value="#Session.Form.ContactPhone#" class="txt-med" maxlength="10" />
            </div>



            <div class="control-row">
               <label for="LocationAddress">Location Address &nbsp;&nbsp;</label>
                    <input type="text" name="LocationAddress" id="LocationAddress" value="#Session.Form.LocationAddress#" class="txt-med" maxlength="50" />
            </div>  

            <div class="control-row">
			<label for="LocationAddress2">&nbsp;&nbsp;</label>
                    <input type="text" name="LocationAddress2" id="LocationAddress2" value="#Session.Form.LocationAddress2#" class="txt-med" maxlength="50" />
            </div>  

            <div class="control-row">
               <label for="LocationCity">Location City &nbsp;&nbsp;</label>
                    <input type="text" name="LocationCity" id="LocationCity" value="#Session.Form.LocationCity#" class="txt-med" maxlength="50" />
            </div>

			<div class="control-row">
               <label for="LocationState">Location State &nbsp;&nbsp;</label>
                <cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="LocationState">
                    <cfinvokeargument name="Selected_State" value="#Session.Form.LocationState#">
                </cfinvoke>
            </div> 

            <div class="control-row">
               <label for="LocationPostal">Location Postal &nbsp;&nbsp;</label>
                    <input type="text" name="LocationPostal" id="LocationPostal" value="#Session.Form.LocationPostal#" class="txt-sm" maxlength="20" />
            </div>   

            <div class="control-row">
               <label for="LocationPhone">Location Phone &nbsp;&nbsp;</label>
                    <input type="text" name="LocationPhone" id="LocationPhone" value="#Session.Form.LocationPhone#" class="txt-med" maxlength="20" />
            </div>

            <div class="control-row">
               <label for="CompanyPhone">Location Fax &nbsp;&nbsp;</label>
                    <input type="text" name="LocationFax" id="LocationFax" value="#Session.Form.LocationFax#" class="txt-med" maxlength="20" />
            </div>

			<div class="control-row" style="height:100%">
               <label for="Description">Description &nbsp;&nbsp;</label>
                    <textarea id="Description" name="Description" maxlength="4000" cols="50" rows="5">#Session.Form.Description#</textarea>
            </div>
            <br /> 

			<div class="control-row" style="height:100%">
               <label for="Directions">Directions &nbsp;&nbsp;</label>
                    <textarea id="Directions" name="Directions" maxlength="4000" cols="50" rows="5">#Session.Form.Directions#</textarea>
            </div>
            <br /> 

            <div class="control-row">
               	<label for="SundayHoursFrom">Sunday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="SundayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.SundayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="SundayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.SundayHoursTo#">
                </cfinvoke>                
            </div> 
            
            <div class="control-row">
               	<label for="MondayHoursFrom">Monday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="MondayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.MondayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="MondayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.MondayHoursTo#">
                </cfinvoke>                
            </div> 

            <div class="control-row">
               	<label for="TuesdayHoursFrom">Tuesday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="TuesdayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.TuesdayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="TuesdayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.TuesdayHoursTo#">
                </cfinvoke>                
            </div> 

            <div class="control-row">
               	<label for="WednesdayHoursFrom">Wednesday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="WednesdayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.WednesdayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="WednesdayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.WednesdayHoursTo#">
                </cfinvoke>                
            </div> 

            <div class="control-row">
               	<label for="ThursdayHoursFrom">Thursday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="ThursdayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.ThursdayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="ThursdayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.ThursdayHoursTo#">
                </cfinvoke>                
            </div> 

            <div class="control-row">
               	<label for="FridayHoursFrom">Friday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="FridayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.FridayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="FridayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.FridayHoursTo#">
                </cfinvoke>                
            </div> 
 
            <div class="control-row">
               	<label for="SaturdayHoursFrom">Saturday &nbsp;&nbsp;</label>
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="SaturdayHoursFrom">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.SaturdayHoursFrom#">
                </cfinvoke> TO 
                <cfinvoke component="admin.selectHours" method="getHours">
                    <cfinvokeargument name="Select_Name" value="SaturdayHoursTo">
                    <cfinvokeargument name="Select_Value" value="#Session.Form.SaturdayHoursTo#">
                </cfinvoke>                
            </div> 

<!---             <div class="control-row">
               <label for="TimeZoneID">Time Zone &nbsp;&nbsp;</label>
                    <select name="TimeZoneID" id="TimeZoneID" class="txt-med" maxlength="50" />
            </div> --->

             <cfquery name="getPaymentMethods" datasource="#request.dsn#">
                SELECT Payment_Method_ID, Payment_Method From Payment_Methods Order By Order_By
            </cfquery>
			<div class="control-row" style="height:100%">
               <label for="PaymentMethodsList">Payment Methods List &nbsp;&nbsp;</label>
			   	<cfloop query="getPaymentMethods">
                	<input type="checkbox" name="PaymentMethodsList" value="#Payment_Method_ID#">&nbsp;#Payment_Method#<br/> 
                </cfloop>
			   
            </div>  
			<br />
            
 			<div class="control-row" style="height:100%">
               <label for="ServicesList">Services List &nbsp;&nbsp;</label>
                    <textarea id="ServicesList" name="ServicesList" maxlength="50" cols="50" rows="5">#Session.Form.ServicesOffered#</textarea>
            </div>
            <br />  

            <div class="control-row">
               <label for="ParkingFees">Parking Fees &nbsp;&nbsp;</label>
                    <input type="text" name="ParkingFees" id="ParkingFees" value="#Session.Form.ParkingFees#" class="txt-med" maxlength="50" />
            </div>

 			<div class="control-row" style="height:100%">
               <label for="CancellationPolicy">Cancellation Policy &nbsp;&nbsp;</label>
                    <textarea id="CancellationPolicy" name="CancellationPolicy" maxlength="50" cols="50" rows="5">#Session.Form.CancellationPolicy#</textarea>
            </div>
            <br />  
            <div class="control-row">
               <label for="Languages">Languages &nbsp;&nbsp;</label>
                    <input type="text" name="Languages" id="Languages" value="#Session.Form.Languages#" class="txt-med" maxlength="100" />
            </div>

           <br clear="all" />
        </div>
       <br clear="all" />
        <div>
        <input type="submit" id="btnSubmitStep3Back" name="btnSubmitStep3Back" value="Previous Step" style="width: 100px" onclick="this.form.action = 'registerStep2.cfm';" />
        <input type="submit" id="btnSubmitStep3" name="btnSubmitStep3" value="Finish" style="width: 100px" /></div>
    </form>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">
