<cfset variables.page_title = "Upgrade Your Account">		
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
<h4>Enable all available features by upgrading your account</h4>
<div class="col-sm-6">
	<form action="process_payment.cfm" method="post" id="payment_form">
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