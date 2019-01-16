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
<cfquery name="getProfessions" datasource="#request.dsn#">
	SELECT Profession_ID,Profession_Name FROM Professions 
</cfquery>
<cfquery name="getTimeZones" datasource="#request.dsn#">
	SELECT Time_Zone_ID, Timezone_Location FROM Time_Zones WHERE enabled = 1
</cfquery>
<cfif (qProfessional.Do_It_Later eq 0 or qProfessional.Do_It_Later eq "") and not structKeyExists(session, "doitlater")>
	<script>
		
		$(window).on('load',function(){

        	$('#modalfirstlog').modal("show");
   		 });
	</script>
</cfif>

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
	line-height: .7;
	-webkit-appearance: none !important;
	border-radius: 30px;

}

.block {
    display: block;
    width: 100%;
   /* background-color: ##f2f2f2;*/
    color: black;
    padding: 14px 28px;
    font-size: 16px;
    cursor: pointer;
    text-align: center;
}

.blockbtn:hover {
    background-color: ##ddd;
    color: black;
}
.servicename{
    height: 50px;
    border: 1px solid grey;
    margin-bottom: 8px;
    padding-top: 15px;
    font-weight: bolder;
}
.serviceadd{
	display: block;
    position: absolute;
    left: 60%;
    height: 88%;
    width: 28%;
    overflow-y:auto;
    overflow-x:auto;
    border-radius: 0px;
}
.mb-10 {
	margin-bottom: 10px;
}
.eachrowBox {

    box-shadow: 1px 1px 5px 1px ##888880;
   	padding-bottom: 10px;
    margin-bottom: 5px;
}
.day{
	height: 40px;
	background-color: ##e6e6e6;
	margin:0 auto;
	margin-bottom: 5px;
}
.texts{
	margin-top: 5px;
}
.savebtn{
	margin-top: 20px; 
	padding: 0px 20px; 
	font-size: 14px; 
	border-radius: 5px; 
	line-height: 20px; 
	height: 30px;
}
.cstm-fst-log button{
  box-shadow: none;
  background:##428bca;
  color:##fff;
  border: 0;
  margin-bottom: 5px;
	padding: 5px;
}
@media only screen and (max-width: 768px) {
	.mbm-10 {
		margin-bottom: 10px;
	}

}
@media only screen and (min-width: 769px) {
	.hours{
		width: 508px;
		margin-left: 57px;
		/*width: 576px;
		margin-left: 40px;*/
	}
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
			        <div class="requestwizard-step">
			            <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
			            <p>Service information</p>
			        </div>
		    	</div>
			</div>
	<cfoutput>
	<form role="form" action="registration_information.cfm" method="post" id="company_info_form" name="company_info_form"  enctype="multipart/form-data">
		<!--- company section --->
	    <div class="row setup-content" id="step-1">
	<!--- <form id="company_info_form" name="company_info_form" action="" method="post"> --->
        	<div class="col-md-12 col-sm-12 col-xs-12">
        		<br>
            	<div class="form-group">
                    <label for="x" class="col-sm-4 control-label">Company&nbsp;Name*</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_Name" class="form-control" id="Cmp_Name" value="#qCompany.Company_Name#" maxlength="50">
					</div>
                </div>
                <br><br>
				<div class="form-group">
					<label for="Company_Address" class="col-sm-4 control-label">Company&nbsp;Address*</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_Address" class="form-control address" id="Cmp_Address" value="#qCompany.Company_Address#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Company_City" class="col-sm-4 control-label">Company&nbsp;City*</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_City" class="form-control city" id="Cmp_City" value="#qCompany.Company_City#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Cmp_State" class="col-sm-4 control-label">Company&nbsp;State*</label>
					<div class="col-sm-8">
						<cfinvoke component="states" method="getStates">
							<cfinvokeargument name="Select_Name" value="Cmp_State">
							<cfinvokeargument name="Selected_State" value="#qCompany.Company_State#">
						</cfinvoke>
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Cmp_Postal" class="col-sm-4 control-label">Company&nbsp;Postal&nbsp;Code*</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_Postal" class="form-control" id="Cmp_Postal" value="#qCompany.Company_Postal#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Cmp_Phone" class="col-sm-4 control-label">Company&nbsp;Phone*</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_Phone" class="form-control phone_us" id="Cmp_Phone" value="#qCompany.Company_Phone#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Cmp_Email" class="col-sm-4 control-label">Company&nbsp;Email</label>
					<div class="col-sm-8">
						<input type="text" name="Cmp_Email" class="form-control" id="Cmp_Email" value="#qCompany.Company_Email#" size="30" maxlength="50" onchange="fnCheckCompanyEmail()">
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
						<div id="Cmp_Description_summernote">#qCompany.Company_Description#</div>
					</div>
				</div>
				<br><br>
				<div class="row">
					<button type="submit" class="btn btn-primary savebtn" name="doitlater">Do it later</button>
	                <button class="btn btn-primary nextBtn btn-lg pull-right savebtn"  name="company_info_btn" id="company_info_btn" type="button">Next</button>
                </div> 
        	</div>
        	<!---  <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" style="margin-top: 20px;" onclick="fnCheckCompanyEmail()">Next</button>  --->
	    </div>
	    <!--- company section end --->
	    <!--- location section --->
	    <div class="row setup-content" id="step-2">
            <div class="col-md-12 col-sm-12 col-xs-12">
            	<br>
            	<div class="form-group">
					<label for="Contact_Name" class="col-sm-4 control-label">Contact&nbsp;Name*</label>
					<div class="col-sm-8">
						<input type="text" name="Cnt_Name" class="form-control" id="Cnt_Name" value="#qLocation.Contact_Name#" size="30" maxlength="50" >
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
						<input type="text" name="Lct_Name" class="form-control" id="Lct_Name" value="#qLocation.Location_Name#" size="30" maxlength="50" >
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_Address" class="col-sm-4 control-label">Location&nbsp;Address*</label>
					<div class="col-sm-8">
						<table>
						<tr>
						<td>
						<input type="text" name="Lct_Address" class="form-control address" id="Lct_Address" value="#qLocation.Location_Address#" size="46" maxlength="50" ></td>
						</tr>
						</table>
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_City" class="col-sm-4 control-label">Location&nbsp;City*</label>
					<div class="col-sm-8">
						<input type="text" name="Lct_City" class="form-control city" id="Lct_City" value="#qLocation.Location_City#" size="30" maxlength="50" >
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_State" class="col-sm-4 control-label">Location&nbsp;State*</label>
					<div class="col-sm-8">
						<cfinvoke component="states" method="getStates">
							<cfinvokeargument name="Select_Name" value="Lct_State">
							<cfinvokeargument name="Selected_State" value="#qLocation.Location_State#">
						</cfinvoke>
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_Postal" class="col-sm-4 control-label">Location&nbsp;Postal*</label>
					<div class="col-sm-8">
						<input type="text" name="Lct_Postal" class="form-control" id="Lct_Postal" value="#qLocation.Location_Postal#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_Phone" class="col-sm-4 control-label">Location&nbsp;Phone*</label>
					<div class="col-sm-8">
						<input type="text" name="Lct_Phone" class="form-control phone_us" id="Lct_Phone" value="#qLocation.Location_Phone#" size="30" maxlength="50" >
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="Location_Fax" class="col-sm-4 control-label">Location&nbsp;Fax</label>
					<div class="col-sm-8">
						<input type="text" name="Lct_Fax" class="form-control phone_us" id="Lct_Fax" value="#qLocation.Location_Fax#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="" class="col-sm-4 control-label">Description</label>
					<div class="col-sm-8">
						<textarea name="Lct_Description" id="Lct_Description" class="form-control" cols="50">#qLocation.Description#</textarea>
					</div>
				</div>
				<br><br>
				<br>
				<div class="form-group">
					<label for="Directions" class="col-sm-4 control-label">Driving&nbsp;Directions</label>
					<div class="col-sm-8">
						<textarea name="Lct_Directions" id="Lct_Directions" class="form-control" cols="50">#qLocation.Directions#</textarea>
					</div>
				</div>
				<br><br><br>
				<div class="form-group">
					<label for="Lct_TimeZone" class="col-sm-4 control-label">Time&nbsp;Zone</label>
					<div class="col-sm-8">
						<select name="Time_Zone_ID" class="form-control" id="Time_Zone_ID">
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
							<td><input type="checkbox" name="Payment_MethodList" value="#Payment_Method_ID#"<cfif ListContains(qLocation.Payment_Methods_List,Payment_Method_ID) >checked</cfif>> </td>
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
						<input type="text" name="Parking_Fee" class="form-control" id="Parking_Fee" value="#qLocation.Parking_Fees#" size="30" maxlength="50">
					</div>
				</div>
				<br><br>
				<div class="form-group">
					<label for="" class="col-sm-4 control-label">Cancellation Policy</label>
					<div class="col-sm-8">
						<textarea name="Cancellation_Policy" id="Cancellation_Policy" class="form-control" cols="50">#qLocation.Cancellation_Policy#</textarea>
					</div>
				</div>
				<br><br><br>
				<div class="form-group">
					<label for="Languages" class="col-sm-4 control-label">Languages</label>
					<div class="col-sm-8">
						<input type="text" name="Language" class="form-control" id="Language" value="#qLocation.Languages#" size="30" maxlength="50">
					</div>
				</div>
				<button type="submit" class="btn btn-primary savebtn" name="doitlater">Do it later</button>
           
                <button id="location_info_btn" class="btn btn-primary nextBtn btn-lg pull-right savebtn" type="button">Next</button>
            </div>
	    </div>
		<!--- location section end --->
		<!--- hours of operation --->
	    <div class="row setup-content" id="step-3">
	    	<div class="col-md-12 col-sm-12 col-xs-12" >
		    	<div class="row" >
		        	<hr>
		        	<div class="col-md-12 col-sm-12 col-xs-12" >
						<h4 style="text-align: center;">Hours of Operation</h4>
		        	</div>
					<div class="col-md-12 col-sm-12 col-xs-12">
						<cfloop from="1" to="7" index="dayindex">
							<cfset opentime=''>
							<cfset closetime=''>
							<cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'))>
								<cfset local.dayhours = listToArray(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'),"&mdash;",false,true)>
								<cfset opentime=local.dayhours[1]>
								<cfset closetime=local.dayhours[2]>
							</cfif>
							<cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_break'))>
								<cfset local.daybreak = listToArray(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_break'),"&mdash;",false,true)>
								<cfset breakstarttime=local.daybreak[1]>
								<cfset breakendtime=local.daybreak[2]>
							</cfif>
							<div class="row mb-10 eachrowBox hours">
								<div class="row day mbm-10">
									<div class="col-md-2 col-xs-12 mbm-10" style="margin-top:12px;font-weight: bolder;" >#DayOfWeekAsString(dayindex)#</div>
								</div>
								<div class="col-md-3 col-xs-12 mbm-10 texts" >Hours</div>
								<div class="col-md-9 col-xs-12 mbm-10 mb-10">
									<div class="row" >
										<div class="col-md-4 col-xs-12 mbm-10">
											<select name="Begins_#dayindex#" id="Begins_#dayindex#" class="form-control">
												<option value="Closed">Closed</option>
												<cfloop from="1" to="24" index="i">
													<cfset meridiem="am">
													<cfif i gt 12>
														<cfset h=i-12>
														<cfset meridiem="pm">
													<cfelse>
														<cfset h=i>
													</cfif>
													<option value="#h#:00 #meridiem#" <cfif opentime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
													<option value="#h#:15 #meridiem#" <cfif opentime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
													<option value="#h#:30 #meridiem#" <cfif opentime eq '#h#:30 #meridiem#'>selected="selected"="selected"ected</cfif>>#h#:30 #meridiem#</option>
													<option value="#h#:45 #meridiem#" <cfif opentime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
												</cfloop>
											</select>
										</div>
										<div class="col-md-4 col-xs-12 text-center mbm-10 texts">
											<small>TO</small>
										</div>
										<div class="col-md-4 col-xs-12 mbm-10">
											<select name="Ends_#dayindex#" id="Ends_#dayindex#" class="form-control">
												<option value="Closed">Closed</option>
												<cfloop from="1" to="24" index="i">
													<cfset meridiem="am">
													<cfif i gt 12>
														<cfset h=i-12>
														<cfset meridiem="pm">
													<cfelse>
														<cfset h=i>
													</cfif>
													<option value="#h#:00 #meridiem#" <cfif closetime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
													<option value="#h#:15 #meridiem#" <cfif closetime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
													<option value="#h#:30 #meridiem#" <cfif closetime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
													<option value="#h#:45 #meridiem#" <cfif closetime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
												</cfloop>
											</select>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-xs-12 mbm-10 texts" >Break</div>
								<div class="col-md-9 col-xs-12 mbm-10" >
									<div class="row" >
										<div class="col-md-4 col-xs-12 mbm-10">
											<select name="BreakBegin_#dayindex#" id="BreakBegin_#dayindex#" class="form-control">
												<option value="NoBreak">No Break</option>
												<cfloop from="1" to="24" index="i">
													<cfset meridiem="am">
													<cfif i gt 12>
														<cfset h=i-12>
														<cfset meridiem="pm">
													<cfelse>
														<cfset h=i>
													</cfif>
													<option value="#h#:00 #meridiem#" <cfif breakstarttime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
													<option value="#h#:15 #meridiem#" <cfif breakstarttime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
													<option value="#h#:30 #meridiem#" <cfif breakstarttime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
													<option value="#h#:45 #meridiem#" <cfif breakstarttime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
												</cfloop>
											</select>
										</div>
										<div class="col-md-4 col-xs-12 text-center mbm-10 texts">
											<small>TO</small>
										</div>
										<div class="col-md-4 col-xs-12 mbm-10">
											<select name="BreakEnd_#dayindex#" id="BreakEnd_#dayindex#" class="form-control">
												<option value="NoBreak">No Break</option>
												<cfloop from="1" to="24" index="i">
													<cfset meridiem="am">
													<cfif i gt 12>
														<cfset h=i-12>
														<cfset meridiem="pm">
													<cfelse>
														<cfset h=i>
													</cfif>
													<option value="#h#:00 #meridiem#" <cfif breakendtime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
													<option value="#h#:15 #meridiem#" <cfif breakendtime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
													<option value="#h#:30 #meridiem#" <cfif breakendtime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
													<option value="#h#:45 #meridiem#" <cfif breakendtime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
												</cfloop>
											</select>
										</div>
									</div>
								</div>
							</div>
						</cfloop>
					</div>	
				</div>	
				<div class="row" >
					<button type="submit" class="btn btn-primary savebtn" name="doitlater">Do it later</button>
					<button id="hours_info_btn" class="btn btn-primary nextBtn btn-lg pull-right savebtn" type="button">Next</button>
				</div>
			</div>
	    </div>    
	    <!--- hours of operation end--->
	    <!--- services section --->
		<div class="row setup-content" id="step-4">
            <div class="col-md-12 col-sm-12 col-xs-12">
				<div class="form-group cstm-fst-log">
					<label for="Profession" class="control-label block">Choose Profession</label>
					<div style="overflow-y: scroll;height: 254px;">
						<cfloop query="getProfessions">
							<button class="block blockbtn profession" type="button" id="#getProfessions.Profession_ID#" data-toggle="modal" data-target="##myModal"  data-professionid="#getProfessions.Profession_ID#">#getProfessions.Profession_Name#</button>
						</cfloop>
					</div>
				</div>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12 text-right">
            	<button type="submit" class="btn btn-primary savebtn" name="doitlater" style="float:left;">Do it later</button>
            	<button id="services_info_btn" class="btn btn-success nextBtn btn-lg savebtn" name="saveall" type="submit">Save</button>
            </div>
	    </div>    
	    <!--- services section end --->
	</form>
	</cfoutput>

<!-- Form ends here -->
		</div>
	</div>
</div>
</div>


<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Choose Service Type</h4>
      </div>
      <div class="modal-body cstm-fst-log">
        <div id="servicetype_btn" style="overflow-y: scroll;height: 224px;">
        </div>
      </div>
      <div class="modal-footer">
		<button type="button" class="btn btn-default showprofession savebtn" data-dismiss="modal" style="float:left"><i class="fa fa-arrow-left" style="font-size:18px"></i></button>
        <button type="button" class="btn btn-default showprofession savebtn" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

<div id="serviceModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Choose Service</h4>
      </div>
      <div class="modal-body" >
        
			<div class="row" id="service_div">

			</div>
        
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-default showservicetype savebtn" data-dismiss="modal" style="float:left"><i class="fa fa-arrow-left" style="font-size:18px"></i></button>
        <button type="button" class="btn btn-default showservicetype savebtn" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

<div class="modal" id="addservice" class="serviceadd">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="serviceheader"></h4>
          
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
			<p>
				<div class="row">
					<input name="serviceid" id="serviceid" type="hidden">
					<div class="col-md-5 form-group input-group">
						<input type="text" id="servicetime" name="servicetime" class="form-control number required" minlength="1" maxlength="3" required />
						<span class="input-group-addon">
							min
						</span>
					</div>
					<div class="col-md-5 form-group input-group">
						<span class="input-group-addon">
							$
						</span>
						<input type="text" id="serviceprice" name="serviceprice" class="form-control money required" maxlength="6" required />
					</div>
				</div>
				<div class="row">
					<div id="serviceMsg" class="col-md-10 alert alert-danger" style="display:none;margin-left: 45px;">
						Missing required fields!
					</div>
				</div>
			</p>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        <button type="button" class="btn btn-primary saveservice">Save</button>
          <button type="button" class="btn btn-danger cancelservice" data-dismiss="modal">Cancel</button>
        </div>
        
      </div>
    </div>
  </div>

 
 <script>


 	$('.showservicetype').click(function(){
		$('#myModal').show();
	});
	$('.showprofession').click(function(){
		$('#modalfirstlog').show();
	});
	
	$('.saveservice').click(function(){
		
		if($('#servicetime').val() == "" && $('#serviceprice').val() == ""){
			
			$('#serviceMsg').css('display','block');
		}
		else{
			$('#serviceMsg').css('display','none');
			var Service_ID=$('#serviceid').val();
			var Service_Time=$('#servicetime').val();
			var Service_Price=$('#serviceprice').val();
			var Professional_ID=<cfoutput>#session.professional_id#</cfoutput>
			$.ajax({
					type: "post",
					url: "registerinfo.cfc?method=insertServiceDetails",
					data: {
						Professional_ID:Professional_ID,
						Service_ID:Service_ID,
						Service_Time:Service_Time,
						Service_Price:Service_Price
						},
					// Define request handlers.
					success: function(data){
						
						
					    }
					

					
			});
			$('#servicetime').val('');
			$('#serviceprice').val('');
			$('#addservice').hide();
			$('#serviceModal').modal("show");
		}
		
	});


	$('.cancelservice').click(function(){
		$('#serviceModal').modal("show");
		$('#serviceMsg').css('display','none');
	});
	

 	$('.profession').click(function() {
 		$('#modalfirstlog').hide();
 		$("button[id=probtn]").remove();
  		var Profession_ID=$(this).attr('data-professionid');
 
  		$.ajax({
					type: "post",
					url: "registerinfo.cfc?method=getServiceTypes",
					data: {
						Profession_ID: Profession_ID
						},
					// Define request handlers.
					success: function(data){
						// $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
						var res = JSON.parse(data);
						
						for (var i in res.DATA) {
					       $('#servicetype_btn').append('<button class="block blockbtn" id="probtn" data-toggle="modal" data-target="#serviceModal" onclick="getServices('+res.DATA[i][0]+')" type="button">'+ res.DATA[i][1]+'</button>')
					    }
					},

					
			});

});

 function  getServices(servicetypeid){
 		$('#myModal').hide();
 		$("div[id=servicetypebtn]").remove();
  		var Service_Type_ID=servicetypeid;
  	
  		$.ajax({
					type: "post",
					url: "registerinfo.cfc?method=getServices",
					data: {
						Service_Type_ID: Service_Type_ID
						},
					// Define request handlers.
					success: function(data){
						// $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
						var res = JSON.parse(data);
						
						for (var i in res.DATA) {
					      $('#service_div').append('<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 servicename" id="servicetypebtn">'+res.DATA[i][1]+'<button class="w3-button w3-circle w3-grey" data-toggle="modal" data-target="#addservice" style="float: right;margin-top: -8px;" onclick="getServiceDetail('+res.DATA[i][0]+')">+</button></div>')
					    }
					},

					
			});

}
 	function getServiceDetail(serviceid){
 		$('#serviceModal').modal("hide");
 		var Service_ID=serviceid;

  		$('#serviceid').val(Service_ID);
					   		
  		$.ajax({
			type: "post",
			url: "registerinfo.cfc?method=getServicesDetail",
			data: { Service_ID: Service_ID },
			// Define request handlers.
			success: function(data){
				// $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
				var res = JSON.parse(data);
		      	$('#serviceheader').html(res.DATA[0][1]);
		      	// if($("#addservice").css("display") == "none") {
		      	// 	$("#addservice").css("display","block");
		      	// }
		      	$('#addservice').modal("show");
			},
		});
  	}
	
	
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
					type: "post",
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
		$('#Cmp_Description').val($('#Cmp_Description_summernote').code());
		var Company_Name = $('#Cmp_Name').val();
		var Company_Address = $('#Cmp_Address').val();
		var Company_City = $('#Cmp_City').val();
		var Company_State = $('#Cmp_State').val();
		var Company_Postal = $('#Cmp_Postal').val();
		var Company_Phone = $('#Cmp_Phone').val();
		var Company_Email = $('#Cmp_Email').val();
		var Company_Fax = $('#Cmp_Fax').val();
		var Company_Description = $('#Cmp_Description').val();
		var company_id = <cfoutput>#session.company_id#</cfoutput>
		$.ajax({
			type: "post",
			url: "registerinfo.cfc?method=updateCompanyDetails",
			dataType: "json",
			data: {
				Company_Name : Company_Name,
				Company_Address : Company_Address,
				Company_City : Company_City,
				Company_State : Company_State,
				Company_Postal : Company_Postal,
				Company_Phone : Company_Phone,
				Company_Email : Company_Email,
				Company_Fax : Company_Fax,
				Company_Description : Company_Description,
				company_id : company_id
			},
			success: function( objResponse ) {
				if (objResponse) {
					$('input[name=Lct_Address]').val(Company_Address);
					$('input[name=Lct_City]').val(Company_City);
					$('#Lct_State').val(Company_State);
					$('input[name=Lct_Postal]').val(Company_Postal);
					$('input[name=Lct_Fax]').val(Company_Fax);
					$('input[name=Lct_Phone]').val(Company_Phone);
				}
			}
		});
	} else {
		alert('Please fill out all required fields');
	}
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
		var Contact_Name = $('#Cnt_Name').val();
		var Contact_Phone = $('#Cnt_Phone').val();
		var Location_Name= $('#Lct_Name').val();
		var Location_Address = $('#Lct_Address').val();
		var Location_City = $('#Lct_City').val();
		var Location_State = $('#Lct_State').val();
		var Location_Postal= $('#Lct_Postal').val();
		var Location_Phone = $('#Lct_Phone').val();
		var Location_Fax = $('#Lct_Fax').text();
		var Location_Description= $('#Lct_Description').val();
		var Driving_Directions = $('#Lct_Directions').val();
		var Time_Zone= $('#Time_Zone_ID').val();
		var Payments_Accepted = [];
		$("input[name='Payment_MethodList']").each( function () {
       		if ($(this).prop("checked") ==true) {

       			 Payments_Accepted.push($(this).val());

       		}

   		});
		var Payments_Accepted=Payments_Accepted.toString();
		var Parking_Fee=$('#Parking_Fee').val();
		var Cancellation_Policy=$('#Cancellation_Policy').val();;
		var Languages=$('#Language').val();;
		var Location_ID=<cfoutput>#session.location_id#</cfoutput>

		$.ajax({
			type: "post",
			url: "registerinfo.cfc?method=updateLocationDetails",
			dataType: "json",
			data: {
				Contact_Name : Contact_Name,
				Contact_Phone : Contact_Phone,
				Location_Name : Location_Name,
				Location_Address : Location_Address,
				Location_City : Location_City,
				Location_State : Location_State,
				Location_Postal : Location_Postal,
				Location_Phone : Location_Phone,
				Location_Fax : Location_Fax,
				Description : Location_Description,
				Driving_Directions : Driving_Directions,
				Time_Zone_ID : Time_Zone,
				Payment_Methods_List : Payments_Accepted,
				Parking_Fees : Parking_Fee,
				Cancellation_Policy : Cancellation_Policy,
				Languages : Languages,
				Location_ID : Location_ID
				
		},
			success: function( objResponse ) {
				
			}
		});
		
	}
	else {
		alert('Please fill out all required fields');
	}
});

$('#hours_info_btn').on('click', function(){
	var valueArray = [];
	for (var i = 1; i <= 7; i++) {
		if($('#Begins_'+i).val()=="Closed"){
			valueArray.push('Closed'+','+'No Break');
		}
		else if($('#BreakBegin_'+i).val()=="NoBreak"){

			valueArray.push($('#Begins_'+i).val().trim()+' &mdash; '+ $('#Ends_'+i).val().trim()+','+'No Break');

		}
		else{
			valueArray.push($('#Begins_'+i).val().trim()+' &mdash; '+ $('#Ends_'+i).val().trim()+','+$('#BreakBegin_'+i).val().trim()+' &mdash; '+ $('#BreakEnd_'+i).val().trim());
		}

		
	}
	var data = JSON.stringify(valueArray);

	var Location_ID=<cfoutput>#session.location_id#</cfoutput>
	$.ajax({
		type: "post",
		url: "registerinfo.cfc?method=updateHoursDetails",
		data: {data : data, Location_ID : Location_ID},
		dataType: "json",
		success: function( objResponse ) {
			
		}
	});
	return false;
});

$(".modal").on('shown.bs.modal', function(event){
    if($(".modal-backdrop").length > 1){
    	$(".modal-backdrop")[1].remove();
    }
});


</script>
<cfinclude template="footer.cfm">
