<cfset variables.companyCFC = createObject("component","admin.company") /> 
<cfset variables.qCompany = variables.companyCFC.getCompany( Company_ID = variables.Company_ID ) />

<cfoutput>
<p>
	<div class="row">#qCompany.company_address#</div>
	<cfif len(qCompany.company_address2)>
		<div class="row">#qCompany.company_address2#</div>
	</cfif>
	<div class="row">#qCompany.company_city# #qLocation.location_state#, #qLocation.location_postal#</div>
	<div class="row">Phone: #qCompany.company_phone#</div>
	<cfif len(qCompany.company_fax)>
		<div class="row">Fax: #qCompany.company_fax#</div>
	</cfif>
	<cfif len(qCompany.web_address)>
		<div class="row">Email: <a href="mailto:#qCompany.Company_Email#">#qCompany.Company_Email#</a></div>
	</cfif>
</p>
</cfoutput>