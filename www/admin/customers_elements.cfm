<cfparam name="variables.company_id" default=#session.company_id#>
<cfparam name="variables.professional_id" default=#session.professional_id#>

<cfif isDefined('session.professional_id')>
	<cfset variables.professional_id 	= session.Professional_ID>
</cfif>
<cfif isDefined('session.Company_ID')>
	<cfset variables.Company_ID			= session.Company_ID>
</cfif>
<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessionals">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<cfinvoke component="customers" method="getCustomers" returnvariable="qGetCustomers">
	<cfinvokeargument name="Company_ID" value="#variables.Company_ID#"> 
	<cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#"> 
</cfinvoke>
<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_customers td {
		vertical-align:middle;
	}
	#table_customers td img {
		width:250px !important;
	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
</style>
<cfoutput>
	<div class="row">
		<div class="table-responsive col-sm-12">
			<table id="table_customers" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="col-sm-1">
							<button type="button" id="add-customer" class="btn btn-info btn-sm">Add Customer</button>
						</th>
						<th class="col-sm-2">First Name</th>
						<th class="col-sm-2">Last Name</th>
					</tr>
				</thead>
				<tbody>
					<cfif qGetCustomers.recordcount>
						<cfloop query="qGetCustomers">
							<tr>
								<td align="center">
									<div class="visible-md visible-lg hidden-sm hidden-xs btn-group">
										<a href="##" class="edit-customer" id="custumer_#qGetCustomers.Customer_ID#">
										<i class="icon-edit"></i>
										</a>
										<a href="##" class="delete-custumer" id="custumer_#qGetCustomers.Customer_ID#">
										<font color="red"><i class="icon-trash"></i></font>
										</a>
									</div>
								</td>
								<td>#qGetCustomers.First_Name#</td>
								<td>#qGetCustomers.Last_Name#</td>
							</tr>
						</cfloop>
					<cfelse>
						<tr>
							<td align="center" colspan="4">No Customers Found</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
		<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage">
	</div>		
</cfoutput>