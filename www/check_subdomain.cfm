<cfsetting showdebugoutput="No">
<cfquery name="check_subdomain" datasource="#request.dsn#">
	SELECT Company_ID 
	FROM Companies
	WHERE 
		Web_Address = <cfqueryparam value="#url.web_address#" cfsqltype="CF_SQL_VARCHAR"> 
</cfquery>

<cfif check_subdomain.recordcount gt 0>
	We're sorry, the web address #url.web_address#.salonworks.com is not available. Please 
<cfelse>
	Congratulations! #url.web_address#.salonworks.com is available.
</cfif>