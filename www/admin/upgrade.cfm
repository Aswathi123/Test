<cfset variables.page_title = "Upgrade Your Account">	
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
	<cfelseif url.msg eq 13>
		<cfset local.Response = 'The credit card has expired.'>
	<cfelseif url.msg eq 27 >
		<cfset local.Response = "The credit card number is invalid please check the card number!!!">
	<cfelse>
	    <cfset local.Response = 'Something went wrong!!'>
	 </cfif>
</cfif>	
<cfquery name="getPrice" datasource="#request.dsn#">
	SELECT 
		Price
	FROM
		Company_Prices
	WHERE
		Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfinclude template="header.cfm"> 
<cfoutput>
<cfif len(local.Response)>
	<div class="alert alert-block #local.alertstyle#">#local.Response#</div>
</cfif>
<h4>Enable all available features by upgrading your account</h4>
<div class="col-sm-6">
	<form action="process_payment.cfm" method="post" id="payment_form" autocomplete="off">
		<cfinclude template="billing_form_elements.cfm">
		<div class="col-sm-12">
			Your credit card will be charged #DollarFormat(getPrice.Price)#
		</div>
		<div class="col-sm-12">
			<input type="submit" value="Upgrade" class="btn btn-info btn-sm">
		</div>
	</form>
</div>
</cfoutput>
<cfinclude template="footer.cfm">