<cfif Not IsDefined("Session.Professional_ID")>
		<cflocation url="login.cfm" />
</cfif>

<cfinclude template="header.cfm" />
<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script>
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
<br />
<div id="form-main">
    <form class="cmxform" id="frmDataForm" name="frmDataForm" method="post" action="locationModifyProcess.cfm">  
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
                    <input type="text" name="ContactPhone" id="ContactPhone" value="#Session.Form.ContactPhone#" class="txt-med" maxlength="12" />
            </div>



            <div class="control-row">
               <label for="LocationAddress">Location Address &nbsp;&nbsp;</label>
                    <input type="text" name="LocationAddress" id="LocationAddress" value="#Session.Form.LocationAddress#" class="txt-med" maxlength="50" />
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
                <select id="PaymentMethodsList" name="PaymentMethodsList" multiple="multiple">
                <cfloop query="getPaymentMethods">
                	<option value="#Payment_Method_ID#">#Payment_Method#</option>
                </cfloop>                
                </select>
            </div>  
			<br />
            
 			<div class="control-row" style="height:100%">
               <label for="ServicesList">Services List &nbsp;&nbsp;</label>
                    <textarea id="ServicesList" name="ServicesList" maxlength="50" cols="50" rows="5">#Session.Form.ServicesList#</textarea>
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
            <div style="margin-left: 50px;"><input type="submit" id="btnSave" name="btnSave" 
            		value="Save" style="width: 100px" /></div>  
        </div>
    </form>  
</div>
</cfoutput>

<cfdump var="#Session.Form#" />
<cfinclude template="footer.cfm">