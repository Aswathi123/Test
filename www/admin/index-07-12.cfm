<cfset variables.page_title="Dashboard">
<cfinclude template="header.cfm">
<cfparam name="variables.company_id" default="#session.company_id#">
<!--- added --->
<cfparam name="variables.location_id" default="#session.location_id#">
<!---  --->
<cfinvoke component="company" method="getCompany" returnvariable="qCompany">
	<cfinvokeargument name="Company_ID" value="#variables.company_id#">
</cfinvoke>
<!--- added --->
<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
	<cfinvokeargument name="Location_ID" value="#variables.location_id#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke> 
<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessional">
	<cfinvokeargument name="Location_ID" value="#variables.location_id#">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke> 

<cfquery name="getTimeZones" datasource="#request.dsn#">
	SELECT Time_Zone_ID, Timezone_Location FROM Time_Zones WHERE enabled = 1
</cfquery>

<cfif qLocation.Time_Zone_ID gt 0>
	<cfset variables.TimeZoneID = qLocation.Time_Zone_ID />
<cfelse>
	<!--- Default TO central --->
	<cfset variables.TimeZoneID = 13 />
</cfif>
<!---  --->
<cfparam name="URL.msg" default="" />
<div style="margin:10px;">
<cfoutput>#URL.msg#

<!--- <cfif structKeyExists(form,"company_info")>
	<cfdump var="#form#"><cfabort>
</cfif>	 --->
<style>
	.requestwizard-modal{
	background: rgba(255, 255, 255, 0.8);
	box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
}
.requestwizard-step p {
    margin-top: 10px;
}

.requestwizard-row {
    display: table-row;
}

.requestwizard {
    display: table;
    width: 100%;
    position: relative;
}

.requestwizard-step button[disabled] {
    opacity: 1 !important;
    filter: alpha(opacity=100) !important;
}

.requestwizard-row:before {
    top: 14px;
    bottom: 0;
    position: absolute;
    content: " ";
    width: 100%;
    height: 1px;
    background-color: ##ccc;
    z-order: 0;

}

.requestwizard-step {
    display: table-cell;
    text-align: center;
    position: relative;
}

.btn-circle {
  width: 30px;
  height: 30px;
  text-align: center;
  padding: 6px 0 6px 0;
  font-size: 12px;
  line-height: 1.428571429;
  border-radius: 15px;
}
</style>
<!--- 
<a href="http://#qCompany.Web_Address#.salonworks.com" target="_blank">View your web site</a>
<p>
To enable online booking:<br>
1. <a id="serviceClickhere" class="clickhere" href="##">Click here</a> to add the services that you offer<br>
2. <a id="availabilityClickhere" class="clickhere" href="##">Click here</a> to go to the Calendar and add your availability<br>
</p> --->
<div class="row">
	<div class="col-sm-12">
		<div class="widget-box transparent" id="recent-box">
			<div class="widget-header">
				<h4 class="widget-title lighter smaller">
					<i class="icon-desktop"></i>Profile
				</h4>

				<div class="widget-toolbar no-border">
					<ul class="nav nav-tabs" id="recent-tab">
						<li class="active">
							<a data-toggle="tab" href="##task-tab">Company</a>
						</li>

						<li>
							<a data-toggle="tab" href="##member-tab">Professional</a>
						</li>

						<li>
							<a data-toggle="tab" href="##comment-tab">Location</a>
						</li>

						<li>
							<a data-toggle="tab" href="##service-tab">Services</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="widget-body">
				<div class="widget-main padding-4">
					<div class="tab-content padding-8">
						<div id="task-tab" class="tab-pane active">
							<cfset variables.company_tab = "company_tab" />
							<cfinclude template="company_form.cfm" >

						</div>

						<div id="member-tab" class="tab-pane">
							<cfset variables.professional_tab = "professional_tab" />
							<cfinclude template="professionals_form.cfm" >
						</div><!-- /.##member-tab -->

						<div id="comment-tab" class="tab-pane">
							<cfset variables.location_tab = "location_tab" />
							<cfinclude template="location_form.cfm" >
						</div>
						<div id="service-tab" class="tab-pane">
							<cfset variables.service_tab = "service_tab" />
							<cfinclude template="services_form.cfm" >
						</div>
					</div>
				</div><!-- /.widget-main -->
			</div><!-- /.widget-body -->
		</div><!-- /.widget-box -->
	</div><!-- /.col -->

	<!--- <div class="col-sm-6">
		<div class="widget-box">
			<div class="widget-header">
				<h4 class="widget-title lighter smaller">
					<i class="ace-icon fa fa-comment blue"></i>
					Conversation
				</h4>
			</div>

			<div class="widget-body">
				<div class="widget-main no-padding">
					
				</div><!-- /.widget-main -->
			</div><!-- /.widget-body -->
		</div><!-- /.widget-box -->
	</div><!-- /.col --> --->
</div><!-- /.row -->

</cfoutput>
</div>


<!--- <div id="modalfirstlog" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Congratulations! <cfdump var="#session#"></h4>
      </div>
      <div class="modal-body">
        <p>Some text in the modal.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
 --->



<!---- Modal --->
	<!-- line modal -->
	<div class="modal fade" id="modalfirstlog" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="max-width: 700px;width: 100%;margin: 10px auto;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button> --->
				<h3 class="modal-title" id="lineModalLabel">Registration Information</h3>
			</div>
			<div class="modal-body">
			    <!-- Steps starts here -->
			<div class="requestwizard">
				<div class="requestwizard-row setup-panel">
					<div class="requestwizard-step">
			            <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
			            <p>Company information</p>
			        </div>
			        <div class="requestwizard-step">
			            <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
			            <p>Location information</p>
			        </div>
			        <div class="requestwizard-step">
			            <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
			            <p>Hours of Operation</p>
			        </div>
			        <!--- <div class="requestwizard-step">
			            <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
			            <p>Service information</p>
			        </div> --->
		    	</div>
			</div>
	<cfoutput>
	<form role="form" action="registration_information.cfm" method="post" id="company_info_form" name="company_info_form"  enctype="multipart/form-data">
		<!--- company section --->
	    <div class="row setup-content" id="step-1">
	    	<!--- <form id="company_info_form" name="company_info_form" action="" method="post"> --->
	            <div class="col-md-12">
	            	<div class="col-md-12">
	            		<br>
		            	<div class="form-group">
		                    <label for="x" class="col-sm-4 control-label">Company&nbsp;Name*</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Name" class="form-control" id="Cmp_Name" value="" maxlength="50" required>
							</div>
		                </div>
		                <br><br>
						<div class="form-group">
							<label for="Company_Address" class="col-sm-4 control-label">Company&nbsp;Address*</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Address" class="form-control address" id="Cmp_Address" value="" size="30" maxlength="50" required>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Company_City" class="col-sm-4 control-label">Company&nbsp;City*</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_City" class="form-control city" id="Cmp_City" value="" size="30" maxlength="50" required>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Cmp_State" class="col-sm-4 control-label">Company&nbsp;State*</label>
							<div class="col-sm-8">
								<cfinvoke component="states" method="getStates">
									<cfinvokeargument name="Select_Name" value="Cmp_State">
									<cfinvokeargument name="Selected_State" value="#qCompany.Company_State#">
									<cfinvokeargument name="IsRequired" value="true">
								</cfinvoke>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Cmp_Postal" class="col-sm-4 control-label">Company&nbsp;Postal&nbsp;Code*</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Postal" class="form-control" id="Cmp_Postal" value="" size="30" maxlength="50" required>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Cmp_Phone" class="col-sm-4 control-label">Company&nbsp;Phone*</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Phone" class="form-control phone_us" id="Cmp_Phone" value="" size="30" maxlength="50" required>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Cmp_Email" class="col-sm-4 control-label">Company&nbsp;Email</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Email" class="form-control" id="Cmp_Email" value="" size="30" maxlength="50" onchange="fnCheckCompanyEmail()">
							</div>
						</div>
		                
						<br><br><br>
						<div class="form-group">
							<label for="Cmp_Fax" class="col-sm-4 control-label">Company&nbsp;Fax</label>
							<div class="col-sm-8">
								<input type="text" name="Cmp_Fax" class="form-control phone_us" id="Cmp_Fax" value="#qCompany.Company_Fax#" size="30" maxlength="50">
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="companyImageFile" class="col-sm-4 control-label">Company&nbsp;Picture</label>
							<div class="col-sm-8">
								<table>
								<tr>
								<td>
								<input type="file" name="company_ImageFile" id="company_ImageFile" value="" accept="image/gif, image/jpeg,image/png"> (.jpg, .gif, or .png)</td>
								</tr>
								</table>
							    	
							    <cfif Find(cgi.script_name,"/dev/admin")>
								    <cfset variables.webpathC = "../images/company/" />
								<cfelse>
									<cfset variables.webpathC = "/images/company/" />
								</cfif>
								<cfset variables.pathC = expandPath(variables.webpathC) />
								<cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
								<cfif FileExists(variables.FilePathC)>
									<a href="#variables.webpathC##session.company_id#.jpg?#now().getTime()#" target="_blank" width="300" height="300" border="0">View Image</a>
								</cfif>
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<label for="Company_Description" class="col-sm-4 control-label">Company&nbsp;Description</label>
							<div class="col-sm-8">
								<input type="hidden" id="Cmp_Description" name="Cmp_Description" />
								<div id="Cmp_Description_summernote"></div>
							</div>
						</div>
						<br><br>
		                <button class="btn btn-primary nextBtn btn-lg pull-right"  name="company_info_btn" id="company_info_btn" type="button" style="margin-top: 20px;">Next</button> 
	            	</div>
	            	<!---  <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" style="margin-top: 20px;" onclick="fnCheckCompanyEmail()">Next</button>  --->
	       		</div>
	    </div>
	    <!--- company section end --->
	    <!--- location section --->
	    <div class="row setup-content" id="step-2">
	        <div class="col-xs-12">
	            <div class="col-md-12">
	            	<br>
	            	<div class="form-group">
						<label for="Contact_Name" class="col-sm-4 control-label">Contact&nbsp;Name*</label>
						<div class="col-sm-8">
							<input type="text" name="Cnt_Name" class="form-control" id="Cnt_Name" value="#qLocation.Contact_Name#" size="30" maxlength="50" required>
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Contact_Phone" class="col-sm-4 control-label">Contact&nbsp;Phone</label>
						<div class="col-sm-8">
							<input type="text" name="Cnt_Phone" class="form-control phone_us" id="Cnt_Phone" value="#qProfessional.Mobile_Phone#" size="30" maxlength="50" >
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_Name" class="col-sm-4 control-label">Location&nbsp;Name*</label>
						<div class="col-sm-8">
							<input type="text" name="Lct_Name" class="form-control" id="Lct_Name" value="" size="30" maxlength="50" required>
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_Address" class="col-sm-4 control-label">Location&nbsp;Address*</label>
						<div class="col-sm-8">
							<table>
							<tr>
							<td>
							<input type="text" name="Lct_Address" class="form-control address" id="Lct_Address" value="##" size="46" maxlength="50" required></td>
							</tr>
							</table>
						</div>
					</div>
<!--- 					<br><br>
					<div class="form-group">
						<label for="Location_Address2" class="col-sm-4 control-label"></label>
						<div class="col-sm-8">
							<input type="text" name="Location_Address2" class="form-control address" id="Location_Address2" value="#qLocation.Location_Address2#" size="30" maxlength="50">
						</div>
					</div> --->
					<br><br>
					<div class="form-group">
						<label for="Location_City" class="col-sm-4 control-label">Location&nbsp;City*</label>
						<div class="col-sm-8">
							<input type="text" name="Lct_City" class="form-control city" id="Lct_City" value="" size="30" maxlength="50" required>
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_State" class="col-sm-4 control-label">Location&nbsp;State*</label>
						<div class="col-sm-8">
							<cfinvoke component="states" method="getStates">
								<cfinvokeargument name="Select_Name" value="Lct_State">
								<cfinvokeargument name="Selected_State" value="##">
								<cfinvokeargument name="IsRequired" value="true">
							</cfinvoke>
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_Postal" class="col-sm-4 control-label">Location&nbsp;Postal*</label>
						<div class="col-sm-8">
							<input type="text" name="Lct_Postal" class="form-control" id="Lct_Postal" value="" size="30" maxlength="50">
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_Phone" class="col-sm-4 control-label">Location&nbsp;Phone*</label>
						<div class="col-sm-8">
							<input type="text" name="Lct_Phone" class="form-control phone_us" id="Lct_Phone" value="" size="30" maxlength="50" required>
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="Location_Fax" class="col-sm-4 control-label">Location&nbsp;Fax</label>
						<div class="col-sm-8">
							<input type="text" name="Lct_Fax" class="form-control phone_us" id="Lct_Fax" value="" size="30" maxlength="50">
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="" class="col-sm-4 control-label">Description</label>
						<div class="col-sm-8">
							<textarea name="Lct_Description" class="form-control" cols="50"></textarea>
						</div>
					</div>
					<br><br>
					<br>
					<div class="form-group">
						<label for="Directions" class="col-sm-4 control-label">Driving&nbsp;Directions</label>
						<div class="col-sm-8">
							<textarea name="Lct_Directions" class="form-control" cols="50"></textarea>
						</div>
					</div>
					<br><br><br>
					<div class="form-group">
						<label for="Lct_TimeZone" class="col-sm-4 control-label">Time&nbsp;Zone</label>
						<div class="col-sm-8">
							<select name="Time_Zone_ID" class="form-control">
								<cfloop query="getTimeZones">
								<option value="#getTimeZones.Time_Zone_ID#" <cfif getTimeZones.Time_Zone_ID EQ variables.TimeZoneID>selected="selected"</cfif>>#getTimeZones.Timezone_Location#</option>
								</cfloop>
							</select>
						</div>
					</div>
					<br><br>

					<div class="form-group" >
						<label for="Payments" class="col-sm-4 control-label">Payments&nbsp;Accepted</label>
						<div class="col-sm-8">
							<table>
								<cfloop query="getPaymentMethods">
								<tr>
								<td><input type="checkbox" name="Payment_MethodList" value="#Payment_Method_ID#" <cfif ListContains(qLocation.Payment_Methods_List,Payment_Method_ID)>checked</cfif>> </td>
								 <td>#Payment_Method#</td>
								</tr>
								</cfloop>
							</table>
						</div>
					</div>
					<br><br><br><br><br><br><br><br><br>
					<div class="form-group">
						<label for="Parking_Fee" class="col-sm-4 control-label">Parking Fees</label>
						<div class="col-sm-8">
							<input type="text" name="Parking_Fee" class="form-control" id="Parking_Fee" value="" size="30" maxlength="50">
						</div>
					</div>
					<br><br>
					<div class="form-group">
						<label for="" class="col-sm-4 control-label">Cancellation Policy</label>
						<div class="col-sm-8">
							<textarea name="Cancellation_Policy" class="form-control" cols="50"></textarea>
						</div>
					</div>
					<br><br><br>
					<div class="form-group">
						<label for="Languages" class="col-sm-4 control-label">Languages</label>
						<div class="col-sm-8">
							<input type="text" name="Language" class="form-control" id="Language" value="" size="30" maxlength="50">
						</div>
					</div>
	                <button id="location_info_btn" class="btn btn-primary nextBtn btn-lg pull-right" type="button" style="margin-top: 20px;">Next</button>
	            </div>
	        </div>
	    </div>
		<!--- location section end --->
		<!--- hours of operation --->
	    <div class="row setup-content" id="step-3">
	        <div class="col-xs-12">
	            <div class="col-md-12">
	            	<br>
					<div class="form-group">
						<label for="" class="col-sm-4 control-label">Hours of Operation</label>
						<div class="col-sm-8">
							<table>
							<cfloop from="1" to="7" index="dayindex">
								<cfset opentime=''>
								<cfset closetime=''>
								<cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'))>
								<cfset opentime=Trim(ListGetAt(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'),1,'&mdash;'))>
								<cfset closetime=Trim(ListGetAt(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'),2,'&mdash;'))>
								</cfif>
								<tr>
									<td>#DayOfWeekAsString(dayindex)#</td>
										<td><select name="Begins_#dayindex#" id="Begins_#dayindex#" class="form-control" style="width:150px;">
											<option value="Closed">Closed</option>
											<cfloop from="1" to="24" index="i">
												<cfset meridiem="am">
												<cfif i gt 12>
													<cfset h=i-12>
													<cfset meridiem="pm">
												<cfelse>
													<cfset h=i>
												</cfif>
												<option value="#i#:00" <cfif opentime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
												<option value="#i#:15" <cfif opentime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
												<option value="#i#:30" <cfif opentime eq '#h#:30 #meridiem#'>selected="selected"="selected"ected</cfif>>#h#:30 #meridiem#</option>
												<option value="#i#:45" <cfif opentime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
											</cfloop>
										</select></td>

										<td>TO</td>

										<td><select name="Ends_#dayindex#" id="Ends_#dayindex#" class="form-control" style="width:150px;">
											<option value="Closed">Closed</option>
											<cfloop from="1" to="24" index="i">
												<cfset meridiem="am">
												<cfif i gt 12>
													<cfset h=i-12>
													<cfset meridiem="pm">
												<cfelse>
													<cfset h=i>
												</cfif>
												<option value="#i#:00" <cfif closetime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
												<option value="#i#:15" <cfif closetime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
												<option value="#i#:30" <cfif closetime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
												<option value="#i#:45" <cfif closetime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
											</cfloop>
										</select>
										</td>
									</tr>
							</cfloop>
							</table>
						</div>
						<div class="form-group">
							<label for="BreakTime" class="col-sm-4 control-label" style="padding-top: 30px;">Break Time</label>
							<div class="col-sm-8" style="padding-top: 30px;">
								<table>
							<cfloop from="1" to="7" index="dayindex">
								<tr>
									<td>#DayOfWeekAsString(dayindex)#</td>
										<td><select name="BreakBegin_#dayindex#" id="BreakBegin_#dayindex#" class="form-control" style="width:150px;">
											<option value="NoBreak">No Break</option>
											<cfloop from="1" to="24" index="i">
												<cfset meridiem="am">
												<cfif i gt 12>
													<cfset h=i-12>
													<cfset meridiem="pm">
												<cfelse>
													<cfset h=i>
												</cfif>
												<option value="#i#:00">#h#:00 #meridiem#</option>
												<option value="#i#:15">#h#:15 #meridiem#</option>
												<option value="#i#:30">#h#:30 #meridiem#</option>
												<option value="#i#:45">#h#:45 #meridiem#</option>
											</cfloop>
										</select></td>

										<td>TO</td>

										<td><select name="BreakEnd_#dayindex#" id="BreakEnd_#dayindex#" class="form-control" style="width:150px;">
											<option value="NoBreak">No Break</option>
											<cfloop from="1" to="24" index="i">
												<cfset meridiem="am">
												<cfif i gt 12>
													<cfset h=i-12>
													<cfset meridiem="pm">
												<cfelse>
													<cfset h=i>
												</cfif>
												<option value="#i#:00">#h#:00 #meridiem#</option>
												<option value="#i#:15">#h#:15 #meridiem#</option>
												<option value="#i#:30">#h#:30 #meridiem#</option>
												<option value="#i#:45">#h#:45 #meridiem#</option>
											</cfloop>
										</select>
										</td>
									</tr>
							</cfloop>
							</table>
							</div>
						</div>
						<button id="hours_info_btn" class="btn btn-primary nextBtn btn-lg pull-right" type="submit" style="margin-top: 20px;">Submit</button>
					</div>
	            </div>
	        </div>
	    </div>    
	    <!--- hours of operation end--->
	</form>
	</cfoutput>

<!-- Form ends here -->
		</div>
	</div>
</div>
</div>
 
 <script>
	
	$(document).ready(function () {

	$('#Cmp_Description_summernote').summernote({
	    height: 100,
	    focus: false,
	     toolbar: [
	       ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
	       ['fontsize', ['fontsize']],
	       ['color', ['color']],
	       ['para', ['ul', 'ol', 'paragraph']]
	     ]
	 });

    var navListItems = $('div.setup-panel div a'),
            allWells = $('.setup-content'),
            allNextBtn = $('.nextBtn');

    allWells.hide();

    navListItems.click(function (e) {
        e.preventDefault();
        var $target = $($(this).attr('href')),
                $item = $(this);

        if (!$item.hasClass('disabled')) {
            navListItems.removeClass('btn-primary').addClass('btn-default');
            $item.addClass('btn-primary');
            allWells.hide();
            $target.show();
            $target.find('input:eq(0)').focus();
        }
    });

    allNextBtn.click(function(){


    	
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
            curInputs = curStep.find("input[type='text'],input[type='url']"),
            isValid = true;
            ;
           
        
        $(".form-group").removeClass("has-error");
        for(var i=0; i<curInputs.length; i++){
            if (!curInputs[i].validity.valid){
                isValid = false;
                $(curInputs[i]).closest(".form-group").addClass("has-error");
            }
        }

        if (isValid && $("#company_info_form").valid())
            nextStepWizard.removeAttr('disabled').trigger('click');
    });

    $('div.setup-panel div a.btn-primary').trigger('click');
});

	fnCheckCompanyEmail = function(){
		if($('#Cmp_Email').val().length){

			$.ajax({
					type: "get",
					url: "company.cfc",
					data: {
						method: "isExistingCompanyEmail",
						CompanyEmail: $('#Cmp_Email').val(),
						noCache: new Date().getTime()
						},
					dataType: "json",

					// Define request handlers.
					success: function( objResponse ){
						// Check to see if request was successful.
						if (objResponse.SUCCESS){
							if(objResponse.DATA){
								alert('The Company Email, ' + $('#Company_Email').val() + ', entered already exist.  Please enter a different address.');
								$('#Cmp_Email').val('');
								$('#Cmp_Email').focus();
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
$('#company_info_btn').on('click', function(){

	$( "#company_info_form" ).validate({
		rules: {
		Cmp_Name: {
		required: true
		},
		Cmp_Address:{
		required: true
		},

		Cmp_Phone:{
		required: true,
		phoneUS: true
		},

		Cmp_City:{
		required: true
		},

		Cmp_Fax:{
		required: false,
		phoneUS: true
		},

		Cmp_Email:{
		required: false,
		email: true
		},
		Cmp_Postal:{
		required: true,
		zipcodeUS:true
		},

		}
	});



	if($("#company_info_form").valid()){
		
		
	}
	else{

		alert('Please fill out all required fields');

	}
	

    $('input[name=Lct_Address]').val($('input[name=Cmp_Address]').val());
    $('input[name=Lct_City]').val($('input[name=Cmp_city]').val());
    $('#Lct_State').val($('#Cmp_State').val());
    $('input[name=Lct_Postal]').val($('input[name=Cmp_Postal]').val());
    $('input[name=Lct_Fax]').val($('input[name=Cmp_Fax]').val());
    $('input[name=Lct_Phone]').val($('input[name=Cmp_Phone]').val());
});

$('#location_info_btn').on('click', function(){
	// alert($('#Lct_Postal').val());
	$( "#company_info_form" ).validate({
		rules: {
		Cnt_Name: {
		required: true
		},

		Lct_Name:{
		required: true
		},

		Lct_Address:{
		required: true
		},

		Lct_Phone:{
		required: true,
		phoneUS: true
		},

		Lct_City:{
		required: true
		},

		Lct_Fax:{
		required: false,
		phoneUS: true
		},

		Lct_Email:{
		required: false,
		email: true
		},

		Lct_Postal:{
		required: true,
		zipcodeUS:true
		},


		}
	});


	if($("#company_info_form").valid()){
		$('#Cmp_Description').val( $('#Cmp_Description_summernote').code() );
		// $('#company_info_form').submit();
	}
	else {
		alert('Please fill out all required fields');
	}
});




</script>
<cfinclude template="footer.cfm">
