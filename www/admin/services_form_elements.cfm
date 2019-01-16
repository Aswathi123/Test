<cfsetting showdebugoutput="false" />

<cfparam name="variables.company_id" default=#session.company_id#>
<cfparam name="variables.professional_id" default=#session.professional_id#>
<!--- URL and FORM Company_ID can only be used by adminsitrator --->
<cfif isDefined('form.professional_id')>
	<cfset variables.professional_id=form.professional_id>
<cfelseif isDefined('url.professional_id')>
	<cfset variables.professional_id=url.professional_id>
</cfif> 

<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessionals">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<cfquery name="qServices" datasource="#request.dsn#">
	Select Predefined_Services.Service_ID,Predefined_Services.Service_Type_ID,Predefined_Services.Service_Name,Cast(CONVERT(DECIMAL(10,2),Professionals_Services.Price) as nvarchar) as price ,Professionals_Services.Service_Time 
	from Professionals_Services left join Predefined_Services on Professionals_Services.Service_ID = Predefined_Services.Service_ID where Professional_ID='#variables.professional_id#'
</cfquery>
<!--- <cfinvoke component="services" method="getServices" returnvariable="qServices">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
</cfinvoke>
 --->
<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />

<cfoutput>
<cfif structKeyExists(variables, 'service_tab')>
	<input type="hidden" name ="service_tab" value="#variables.service_tab#">
</cfif>
<div class="row">
	<div class="table-responsive col-sm-8">
		<table id="table_sevices" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th></th>
					<th>Professional</th>
					<th colspan="3">
						<input type="hidden" id="company_id_service" name="company_id_service" value="#variables.company_id#">
						<select id="professional_id_service" name="professional_id_service" class="form-control">
							<cfloop query="qProfessionals">
								<option value="#qProfessionals.professional_id#" <cfif qProfessionals.professional_id EQ variables.professional_id> selected = selected </cfif> >
									#qProfessionals.first_name#&nbsp;#qProfessionals.last_name#</option>
							</cfloop>
						</select>
					</th>
				</tr>
				<tr>
					<th class="col-sm-1"><button type="button" id="addnewservice" class="btn btn-info btn-sm">Add service</button></th>
					<th class="col-sm-2">Name</th>
					<!--- <th class="col-sm-3">Description</th> --->
					<th class="hidden-480 col-sm-1">Time</th>
					<th class="col-sm-1">$&nbsp;Price</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="qServices">
					<tr>
						<td align="center">
							<div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
								<a href="##" class="edit-servicedetail" id="srv_#qServices.service_id#">
								<i class="icon-edit"></i>
								</a>
								<a href="##" class="delete-servicedetail" id="srv_#qServices.service_id#">
								<font color="red"><i class="icon-trash"></i></font>
								</a>
							</div>
						</td>
						<td>
							<a href="##" class="edit-servicedetail" id="srv_#qServices.service_id#" data-servicename="#qServices.service_name#" data-serviceprice="#qServices.price#" data-servicetime="#qServices.service_time#">#qServices.service_name#</a>
						</td>
						<!--- <td>#qServices.service_description#</td> --->
						<td class="hidden-480" align="right">#qServices.service_time#</td>
						<td align="right">#DecimalFormat(qServices.price)#</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</div>		
</cfoutput>