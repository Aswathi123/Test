<cfset variables.page_title="Dashboard">
<cfinclude template="header.cfm">
<cfparam name="variables.company_id" default="#session.company_id#">
<cfinvoke component="company" method="getCompany" returnvariable="qCompany">
	<cfinvokeargument name="Company_ID" value="#variables.company_id#">
</cfinvoke> 
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
<cfinclude template="footer.cfm">
