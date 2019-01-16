<cfoutput>
	<cfset local.response = getHttpRequestData()>
	<cftry>
		<cfdocument format="PDF" filename="webhookresponseDev.PDF" overwrite="true">
			<cfdump var="#local.response#">
		</cfdocument>
		<cfset variables.developmentserver = true >
		<cfif variables.developmentserver >
				<cfset variables.url_CIM_ARB = "https://apitest.authorize.net/xml/v1/request.api">
				<cfset variables.login = "7xG5qVRm65k">
				<cfset variables.transactionkey = "97p5B2MD2v4v7tA3">
		<cfelse>
				<cfset variables.url_CIM_ARB = "https://api.authorize.net/xml/v1/request.api">
				<cfset variables.login = "3wqGHT3Vw48w">
				<cfset variables.transactionkey = "68R2Jujw26By29y5">
		</cfif>
		<cfset local.filecontent = deserializeJSON(local.response.content) />
			<cfif structKeyExists(local.filecontent, 'eventType')  and
			  local.filecontent.eventType eq 'net.authorize.payment.authcapture.created' >
				<cfif structKeyExists(local.filecontent, 'payload') and  
				structKeyExists(local.filecontent.payload, 'entityName') and
						local.filecontent.payload.entityName eq 'transaction'  
				>
					<cfsavecontent variable="myXml"><?xml version="1.0" encoding="utf-8"?>
						<getTransactionDetailsRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
						    <merchantAuthentication>
						        <name>#variables.login#</name>
						        <transactionKey>#variables.transactionkey#</transactionKey>
						    </merchantAuthentication>
						    <transId>#local.filecontent.payload.id#</transId>
						</getTransactionDetailsRequest>
					</cfsavecontent>

					<cfset response.XmlRequest = xmlParse(myXml)>
					
					<cfhttp url="#variables.url_CIM_ARB#" method="POST">
					<cfhttpparam type="XML" name="xml" value="#myXml#">
					</cfhttp>
					
					<cfset response.XmlResponse = REReplace( cfhttp.FileContent, "^[^<]*", "", "all" ) />

					<cfset response.XmlResponse = xmlParse(response.XmlResponse)>
					<CFIF isDefined('response.XmlResponse.getTransactionDetailsResponse.messages.message')>
						<CFIF response.XmlResponse.getTransactionDetailsResponse.messages.resultCode.XmlText is "Ok">
					
							<cfset response.subscriptionId = response.XmlResponse.getTransactionDetailsResponse.transaction.subscription.id.XmlText>
							<cfset response.transactionid = response.XmlResponse.getTransactionDetailsResponse.transaction.transId.XmlText>
							<cfset response.authAmount = response.XmlResponse.getTransactionDetailsResponse.transaction.authAmount.XmlText>
							<cfset response.Transaction_Time = response.XmlResponse.getTransactionDetailsResponse.transaction.submitTimeUTC.XmlText>
							
							<cfquery name="insertTransaction" datasource="#request.dsn#">
									INSERT INTO 
										Transactions
										( webhook_status
										,Amount_Paid
										,Transaction_Time
										,Transaction_ID
										,subscription_id)
									VALUES
									(
										<cfqueryparam value="#serializeJSON(local.response)#" cfsqltype="cf_sql_nvarchar" />
										,<cfqueryparam value="#local.filecontent.payload.authAmount#" cfsqltype="cf_sql_money" />
										,<cfqueryparam value="#local.filecontent.eventDate#" cfsqltype="cf_sql_date" />
										,<cfqueryparam value="#local.filecontent.payload.id#" cfsqltype="cf_sql_varchar" />
										,<cfqueryparam value="#response.subscriptionId#" cfsqltype="cf_sql_numeric" />
										)
									SELECT @@IDENTITY AS 'Invoice_ID';
							</cfquery>
						</CFIF>
		
					</cfif>
				</cfif>
			</CFIF>
	<cfcatch>
		<cfdump var="#cfcatch#"/>
	</cfcatch>
	</cftry>
</cfoutput>