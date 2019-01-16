
<cfinclude template="header.cfm" >
<cfparam name="variables.page_title" default="Cancel subscription">
<cfoutput>
	<div>
		<cfquery name="getsuscriptionid" datasource="#request.dsn#">
		   SELECT 
		   subscriptionId
		   FROM
		   Companies
		   WHERE
		   Company_ID=
		   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfif getsuscriptionid.recordcount and len(getsuscriptionid.subscriptionId) gt 1 >
			<h2>Cancel Subcription</h2>
			<h4>By cancelling your subscription,can lead to lost the existing features of your website ! </h4>
			<form action="process_payment.cfm" method="post" id="calcel_subscription_form"> 
				<input type="hidden" name="subscriptionId" id="subscriptionId" value="#getsuscriptionid.subscriptionId#">
				<input type="submit" class="btn btn-lg btn-primary" name ="cancelSubscription" value="Cancel subscription" id="cancelSubscription">
			</form>
		</cfif>
		
	</div>
</cfoutput>
<cfinclude template="footer.cfm">