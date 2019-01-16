<cfset variables.companyCFC = createObject("component","admin.company") /> 
<cfset variables.qrySocialMedia = variables.companyCFC.getCompanySocialMediaPlus(#qCompany.Company_ID#) /> 
<cfset variables.bolHasSocialMedia = variables.companyCFC.hasCompanySocialMedia(#qCompany.Company_ID#) />

<cfoutput>
<cfif variables.bolHasSocialMedia>
	<p>Follow us on</p>
	<div class="row">	
		<cfloop query="variables.qrySocialMedia">
			<cfif variables.qrySocialMedia.URL gt 0>
				<div class="col-xs-1">
					<a href="#variables.qrySocialMedia.WEB_SITE&Replace(variables.qrySocialMedia.URL,'http://','')#" target="_blank">
					<img src="/images/#variables.qrySocialMedia.Logo_File#" border="0" width="35" height="35" alt="#variables.qrySocialMedia.Site_Name#" /></a>
				</div>
			</cfif>
		</cfloop>
	</div>
</cfif>
</cfoutput>