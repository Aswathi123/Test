<cfset variables.page_title="Dashboard">
<cfset local.showcompanyupdatemodal = false/>
<cfquery name="checkValues" datasource="#request.dsn#">
	SELECT 1 
	FROM Companies c 
	INNER JOIN 
	Locations l 
	ON c.Company_ID=l.Company_ID 
	WHERE '' IN(
		Company_Name
		,Company_Address
		,Company_City
		,Company_State
		,Company_Postal
		,Company_Phone
		,Contact_Name
		,Location_Name
		,Location_Address
		,Location_City
		,Location_State
		,Location_Postal
		,Location_Phone
		,Sunday_Hours
		,Monday_Hours
		,Tuesday_Hours
		,Wednesday_Hours
		,Thursday_Hours
		,Friday_Hours
		,Saturday_Hours) and c.Company_ID=#session.company_id# 
</cfquery>
<!--- <cfdump var="#checkValues#"> --->
<cfif checkValues.recordcount>
	<cfset local.showcompanyupdatemodal = true/>
</cfif>
<cfinclude template="header.cfm">

<!---  --->
<cfparam name="URL.msg" default="" />
<div style="margin:10px;">
<cfoutput>#URL.msg#


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







 
 
<cfif local.showcompanyupdatemodal >
	<script type="text/javascript">
		function showcompanyupdatemodal() {
			$('#modalfirstlog').modal("show");

		}
		showcompanyupdatemodal();
	</script>
</cfif>	
<cfinclude template="footer.cfm">
