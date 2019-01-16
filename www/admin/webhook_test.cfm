<cfoutput>
    <cfset local.apilogin = "7xG5qVRm65k" >
    <cfset local.transactionKey = "97p5B2MD2v4v7tA3" >

    <cfset local.webhookresponse = GetHttpRequestData()/>
	
	 
	 <cfdump var="#local.webhookresponse#"><cfabort>
    <!---<cfquery name="getWebhooks" datasource="#request.dsn#">
       insert into Transactions
	   (
		webhook_status,Transaction_ID
	   )
       values(
	   '#serializeJSON(local.webhookresponse)#' ,''
	   ) 
       
    </cfquery>--->
	
	<!--- setting transaction table --->
		--->
	<!---<cfif structKeyExists(content, 'notifications')  and #len(content.notifications.notificationId)# and content.notifications.eventType eq 'net.authorize.payment.capture.created' >
		<cfquery name="insertTransaction" datasource="#request.dsn#">
			INSERT INTO 
				Transactions
			(Company_ID, subscription_id ,webhook_status,Transaction_ID)
			VALUES
			(<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#local.subscriptionId#" cfsqltype="cf_sql_numeric" />
				)
			SELECT @@IDENTITY AS 'Invoice_ID';
		</cfquery>

	</cfif>--->
</cfoutput>