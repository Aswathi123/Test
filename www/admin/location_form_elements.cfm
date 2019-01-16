<cfquery name="getPaymentMethods" datasource="#request.dsn#">
	SELECT Payment_Method_ID, Payment_Method From Payment_Methods Order By Order_By
</cfquery>
<cfquery name="getTimeZones" datasource="#request.dsn#">
	SELECT Time_Zone_ID, Timezone_Location FROM Time_Zones WHERE enabled = 1
</cfquery>

<cfif qLocation.Time_Zone_ID gt 0>
	<cfset variables.TimeZoneID = qLocation.Time_Zone_ID />
<cfelse>
	<!--- Default TO central --->
	<cfset variables.TimeZoneID = 13 />
</cfif>
<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
	<cfinvokeargument name="Location_ID" value="#variables.location_id#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<script>
	$(document).ready(function(){
	    $('[data-toggle="popover"]').popover(); 
	});
</script>
<cfoutput>
<div class="form-group">
	<cfif structKeyExists(variables, 'location_tab')>
	<input type="hidden" name ="location_tab" value="#variables.location_tab#">
	</cfif>
	<label for="Contact_Name" class="col-sm-3 control-label">Contact&nbsp;Name*</label>
	<div class="col-sm-9">
		<input type="text" name="Contact_Name" class="form-control" id="Contact_Name" value="#qLocation.Contact_Name#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Contact_Phone" class="col-sm-3 control-label">Contact&nbsp;Phone</label>
	<div class="col-sm-9">
		<input type="text" name="Contact_Phone" class="form-control phone_us" id="Contact_Phone" value="#qLocation.Contact_Phone#" size="30" maxlength="50" >
	</div>
</div>
<div class="form-group">
	<label for="Location_Name" class="col-sm-3 control-label">Location&nbsp;Name*</label>
	<div class="col-sm-9">
		<input type="text" name="Location_Name" class="form-control" id="Location_Name" value="#qLocation.Location_Name#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Location_Address" class="col-sm-3 control-label">Location&nbsp;Address*</label>
	<div class="col-sm-9">
		<table>
		<tr>
		<td>
		<input type="text" name="Location_Address" class="form-control address" id="Location_Address" value="#qLocation.Location_Address#" size="30" maxlength="50" required></td><td><span class="glyphicon glyphicon-info-sign"  data-container="body" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Your address will be displayed at the bottom of each page of your website.  A google map will also be placed on the front page of you website mapped to your location."></span></td>
		</tr>
		</table>
	</div>
</div>
<div class="form-group">
	<label for="Location_Address2" class="col-sm-3 control-label"></label>
	<div class="col-sm-9">
		<input type="text" name="Location_Address2" class="form-control address" id="Location_Address2" value="#qLocation.Location_Address2#" size="30" maxlength="50">
	</div>
</div>
<div class="form-group">
	<label for="Location_City" class="col-sm-3 control-label">Location&nbsp;City*</label>
	<div class="col-sm-9">
		<input type="text" name="Location_City" class="form-control city" id="Location_City" value="#qLocation.Location_City#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-3 control-label">Location&nbsp;State*</label>
	<div class="col-sm-9">
		<cfinvoke component="states" method="getStates">
			<cfinvokeargument name="Select_Name" value="Location_State">
			<cfinvokeargument name="Selected_State" value="#qLocation.Location_State#">
			<cfinvokeargument name="IsRequired" value="true">
		</cfinvoke>
	</div>
</div>
<div class="form-group">
	<label for="Location_Postal" class="col-sm-3 control-label">Location&nbsp;Postal*</label>
	<div class="col-sm-9">
		<input type="text" name="Location_Postal" class="form-control" id="Location_Postal" value="#qLocation.Location_Postal#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Location_Phone" class="col-sm-3 control-label">Location&nbsp;Phone*</label>
	<div class="col-sm-9">
		<input type="text" name="Location_Phone" class="form-control phone_us" id="Location_Phone" value="#qLocation.Location_Phone#" size="30" maxlength="50" required>
	</div>
</div>
<div class="form-group">
	<label for="Location_Fax" class="col-sm-3 control-label">Location&nbsp;Fax</label>
	<div class="col-sm-9">
		<input type="text" name="Location_Fax" class="form-control phone_us" id="Location_Fax" value="#qLocation.Location_Fax#" size="30" maxlength="50">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-3 control-label">Description</label>
	<div class="col-sm-9">
		<textarea name="Description" class="form-control" cols="50">#qLocation.Description#</textarea>
	</div>
</div>
<div class="form-group">
	<label for="Directions" class="col-sm-3 control-label">Driving&nbsp;Directions</label>
	<div class="col-sm-9">
		<textarea name="Directions" class="form-control" cols="50">#qLocation.Directions#</textarea>
	</div>
</div>

<div class="form-group">
	<label for="" class="col-sm-3 control-label">Hours of Operation</label>
	<div class="col-sm-9">
		<table>
		<cfloop from="1" to="7" index="dayindex">
			<cfset opentime=''>
			<cfset closetime=''>
			<cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'))>
				<!--- <cfset local.dayhours = Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours').Split("&mdash;")> --->
				<cfset local.dayhours = listToArray(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'),"&mdash;",false,true)>
				
				<cfset opentime=local.dayhours[1]>
				<cfset closetime=local.dayhours[2]>
				
			</cfif>
			<tr>
				<td>#DayOfWeekAsString(dayindex)#</td>
					
					<td><select name="Begin_#dayindex#" id="Begin_#dayindex#" class="form-control" style="width:150px;">
						<option value="Closed">Closed</option>
						<cfloop from="1" to="24" index="i">

							<cfset meridiem="am">
							<cfif i gt 12>
								<cfset h=i-12>
								<cfset meridiem="pm">
							<cfelse>
								<cfset h=i>
							</cfif>

							<!--- <cfdump var="#h#"><cfdump var="#meridiem#"><cfabort> --->
							<option value="#i#:00 #meridiem#" <cfif trim(opentime) eq '#h#:00 #meridiem#'> selected="selected"</cfif>>#h#:00 #meridiem#</option>
							<option value="#i#:15 #meridiem#" <cfif trim(opentime) eq '#h#:15 #meridiem#'> selected="selected"</cfif>>#h#:15 #meridiem#</option>
							<option value="#i#:30 #meridiem#" <cfif trim(opentime) eq '#h#:30 #meridiem#'> selected="selected"</cfif>>#h#:30 #meridiem#</option>
							<option value="#i#:45 #meridiem#" <cfif trim(opentime) eq '#h#:45 #meridiem#'> selected="selected"</cfif>>#h#:45 #meridiem#</option>
						</cfloop>
						
					</select></td>

					<td>TO</td>

					<td><select name="End_#dayindex#" id="End_#dayindex#" class="form-control" style="width:150px;">
						
						<option value="Closed">Closed</option>
						
						<cfloop from="1" to="24" index="i">
							<cfset meridiem="am">
							<cfif i gt 12>
								<cfset h=i-12>
								<cfset meridiem="pm">
							<cfelse>
								<cfset h=i>
							</cfif>

							<option value="#i#:00 #meridiem#" <cfif trim(closetime) eq '#h#:00 #meridiem#'> selected="selected"</cfif>>#h#:00 #meridiem#</option>
							<option value="#i#:15 #meridiem#" <cfif trim(closetime) eq '#h#:15 #meridiem#'> selected="selected"</cfif>>#h#:15 #meridiem#</option>
							<option value="#i#:30 #meridiem#" <cfif trim(closetime) eq '#h#:30 #meridiem#'> selected="selected"</cfif>>#h#:30 #meridiem#</option>
							<option value="#i#:45 #meridiem#" <cfif trim(closetime) eq '#h#:45 #meridiem#'> selected="selected"</cfif>>#h#:45 #meridiem#</option>
						</cfloop>
					</select>
					</td>
				</tr>
		</cfloop>
		</table>
	</div>
</div>

<div class="form-group">
	<label for="" class="col-sm-3 control-label">Time&nbsp;Zone</label>
	<div class="col-sm-9">
		<select name="Time_Zone_ID" class="form-control">
			<cfloop query="getTimeZones">
			<option value="#getTimeZones.Time_Zone_ID#" <cfif getTimeZones.Time_Zone_ID EQ variables.TimeZoneID>selected="selected"</cfif>>#getTimeZones.Timezone_Location#</option>
			</cfloop>
		</select>
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-3 control-label">Payments&nbsp;Accepted</label>
	<div class="col-sm-9">
		<table>
			<cfloop query="getPaymentMethods">
			<tr>
			<td><input type="checkbox" name="Payment_Methods_List" value="#Payment_Method_ID#" <cfif ListContains(qLocation.Payment_Methods_List,Payment_Method_ID)>checked</cfif>> </td>
			 <td>#Payment_Method#</td>
			</tr>
			</cfloop>
		</table>
	</div>
</div>
<div class="form-group">
	<label for="Parking_Fees" class="col-sm-3 control-label">Parking Fees</label>
	<div class="col-sm-9">
		<input type="text" name="Parking_Fees" class="form-control" id="Parking_Fees" value="#qLocation.Parking_Fees#" size="30" maxlength="50">
	</div>
</div>
<div class="form-group">
	<label for="" class="col-sm-3 control-label">Cancellation Policy</label>
	<div class="col-sm-9">
		<textarea name="Cancellation_Policy" class="form-control" cols="50">#qLocation.Cancellation_Policy#</textarea>
	</div>
</div>
<div class="form-group">
	<label for="Languages" class="col-sm-3 control-label">Languages</label>
	<div class="col-sm-9">
		<input type="text" name="Languages" class="form-control" id="Languages" value="#qLocation.Languages#" size="30" maxlength="50">
	</div>
</div>
<input  type="hidden" name="Location_ID" value="#qLocation.Location_ID#">
<input  type="hidden" name="Company_ID" value="#qLocation.Company_ID#">
</cfoutput>
