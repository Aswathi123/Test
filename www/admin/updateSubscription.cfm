<cfset local.Response = "">
<cfif structKeyExists(url, 'msg') and len(trim(url.msg))>
	<cfif structKeyExists(url, 'altCode')>
		<cfif val(url.altCode) eq 1>
			<cfset local.alertstyle = 'alert-success'>
		<cfelse>
			<cfset local.alertstyle = 'alert-danger'>
		</cfif>
	</cfif>
	<cfif url.msg eq 0>
		<cfset local.Response = 'Your Subscription has been updated!'>
		<cfif structKeyExists(url, 'type') and len(url.type) and trim(url.type) eq 'create'>
			<cfset local.Response = 'Your account has been upgraded!'>
		</cfif>
	<cfelseif url.msg eq 13>
		<cfset local.Response = 'The credit card has expired.'>
	<cfelseif url.msg eq 27 >
		<cfset local.Response = "The credit card number is invalid please check the card number!!!">
	<cfelse>
	    <cfset local.Response = 'Something went wrong!!'>
	 </cfif>
</cfif>
<cfinclude template="header.cfm">
<cfoutput>
	<cfif len(local.Response)>
		<div class="alert alert-block #local.alertstyle#">#local.Response#</div>
	</cfif>
	<div>
		<cfquery name="getsuscriptionid" datasource="#request.dsn#">
		   SELECT 
		   subscriptionId, subscriber_fname, subscriber_lname, subscriber_start_date, card_expry_date, subscription_status, Billing_Address, Billing_City, Billing_State, Billing_Postal
		   FROM
		   Companies
		   WHERE
		   Company_ID=
		   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfif getsuscriptionid.recordcount gt 0>
			<cfset variables.Billing_First_Name = getsuscriptionid.subscriber_fname>
			<cfset variables.Billing_Last_Name = getsuscriptionid.subscriber_lname>
			<cfset variables.Billing_Address1 = getsuscriptionid.Billing_Address>
			<cfset variables.Billing_City = getsuscriptionid.Billing_City>
			<cfset variables.Billing_State = getsuscriptionid.Billing_State>
			<cfset variables.Billing_Zip = getsuscriptionid.Billing_Postal>
		</cfif>
		<cfif getsuscriptionid.recordcount and len(getsuscriptionid.subscriptionId) gt 1 >
			<h2>Update Subcription</h2>
			
			<form action="process_payment.cfm" method="post" id="payment_form" autocomplete="off"> 
				<cfinclude template="billing_form_elements.cfm">
				<input type="hidden" name="subscriptionId" id="subscriptionId" value="#getsuscriptionid.subscriptionId#">
				<input type="submit" class="btn btn-lg btn-primary" name ="updateSubscription" value="Update subscription" id="updateSubscription">
			</form>
		</cfif>
		
	</div>
</cfoutput>
<cfinclude template ="footer.cfm">