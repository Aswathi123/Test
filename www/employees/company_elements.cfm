<cfset variables.employee_id = session.employee_id>
<cfinvoke component="company" method="getCompanyReport" returnvariable="qGetCompanies">
	<cfinvokeargument name="employee_id" value="#variables.employee_id#"> 
</cfinvoke>
<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_companies td {
		vertical-align:middle;
	}
	#table_companies td img {
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
			<table id="table_companies" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="col-sm-2">Company Name</th>
						<th class="col-sm-2">Company Email</th>
						<th class="col-sm-2">Account Type</th>
						<th class="col-sm-2">Order Expiration</th>
						<th class="col-sm-2">Trial Expiration</th>
					</tr>
				</thead>
				<tbody>
					<cfif qGetCompanies.recordcount>
						<cfloop query="qGetCompanies">
							<tr>
								<td>#qGetCompanies.company_name#</td>
								<td>#qGetCompanies.company_email#</td>
								<td>
									<cfif len(trim(qGetCompanies.trial_expiration)) AND NOT len(trim(qGetCompanies.order_date))>
										Trial
										<cfif DateFormat(qGetCompanies.trial_expiration,"yyyymmdd") LT DateFormat(now(),"yyyymmdd")>
											 Expired
										</cfif>
									<cfelseif len(trim(qGetCompanies.order_date))>
										Paid
									</cfif>
								</td>
								<td>#DateFormat(qGetCompanies.order_date,"MMM dd, yyyy")#</td>
								<td>#DateFormat(qGetCompanies.trial_expiration,"MMM dd, yyyy")#</td>
							</tr>
						</cfloop>
					<cfelse>
						<tr>
							<td align="center" colspan="4">No Companies Found</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
		<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage">
	</div>		
</cfoutput>