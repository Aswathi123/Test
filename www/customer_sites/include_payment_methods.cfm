<cfquery name="getPaymentMethods" datasource="#request.dsn#">
	SELECT 
		Payment_Method_ID
		,Payment_Method 
		,Logo_File
	FROM 
		Payment_Methods 
	WHERE 
		Payment_Method_ID IN 
		(<cfif qLocation.PAYMENT_METHODS_LIST gt ''>#qLocation.PAYMENT_METHODS_LIST#<cfelse>0</cfif>)
	ORDER BY Order_By ASC
</cfquery>

<cfoutput query="getPaymentMethods">
	<img src="/images/#getPaymentMethods.Logo_File#" Alt="#getPaymentMethods.Payment_Method#" width="32" style="padding:3px;"><!--- &nbsp;&nbsp;#getPaymentMethods.Payment_Method# ---> 
</cfoutput>
	