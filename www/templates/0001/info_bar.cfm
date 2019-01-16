<cfparam name="variables.info_bar_float" default="right">
<cfset variables.companyCFC = createObject("component","admin.company") /> 
<cfset variables.qrySocialMedia = variables.companyCFC.getCompanySocialMediaPlus(#qCompany.Company_ID#) /> 
<cfset variables.bolHasSocialMedia = variables.companyCFC.hasCompanySocialMedia(#qCompany.Company_ID#) />
<cfoutput>
<div class="rightdetails" style="float:#variables.info_bar_float#;">
		<div class="point">
			<div class="head">Hours of Operation</div>
			<div class="desc">
				<cfinclude template="/customer_sites/include_hours.cfm">
			</div> <!-- desc -->
		</div> <!-- point -->
		<div class="point">
			<div class="head2">Payment Methods</div>
			<div class="desc">
				<cfinclude template="/customer_sites/include_payment_methods.cfm">
			</div> <!-- desc -->
		</div> <!-- point -->
		<div class="point">
			<div class="head3">Cancellation Policy</div>
			<div class="desc">#qLocation.Cancellation_Policy#</div> <!-- desc -->
		</div> <!---  --->
	<div class="point">
		<div class="head4">Parking Fees</div>
		<div class="desc">#qLocation.Parking_Fees#</div>
		<div class="media">
			<table class="table table-bordered table-hover">
			  <tr>
				<cfif variables.bolHasSocialMedia><td width="100" nowrap>Follow us on</td></cfif>
				<cfloop query="variables.qrySocialMedia">	
					<cfif variables.qrySocialMedia.URL gt 0>			
			    		<td><a href="http://#Replace(variables.qrySocialMedia.URL,'http://','')#" target="_blank"><img src="/images/#variables.qrySocialMedia.Logo_File#" border="0" width="35" height="35" alt="#variables.qrySocialMedia.Site_Name#" /></a></td>
					</cfif> 
				</cfloop>
			    <!--- <td><a href="##"><img src="/images/facebook.png" border="0" width="35" height="35" /></a></td>
			    <td><a href="##"><img src="/images/twitter.png" border="0" width="35" height="35" /></a></td>
			    <td><a href="##"><img src="/images/googleplus.png" border="0" width="35" height="35" /></a></td>
			    <td><a href="##"><img src="/images/youtube.png" border="0" width="35" height="35" /></a></td>
			    <td><a href="##"><img src="/images/pinterest.png" border="0" width="35" height="35" /></a></td>
			    <td><a href="##"><img src="/images/linkedin.png" border="0" width="35" height="35" /></a></td> --->
			  </tr>
			</table>
		</div>
	</div> <!-- point -->
</div> <!-- rightdetails -->
</cfoutput>