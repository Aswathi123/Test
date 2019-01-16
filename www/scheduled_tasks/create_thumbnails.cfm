<cfquery name="getcompanies" datasource="#request.dsn#">
	SELECT 
		web_address
		,company_id
	FROM
		Companies
	WHERE web_address > ''
</cfquery>

<cfoutput query="getcompanies">
	<cfdocument src="http://#getcompanies.web_address#.salonworks.com" name="pdfdata" format="pdf" />
	<cfpdf source="pdfdata" pages="1" action="thumbnail" destination="E:\Sites\SalonWorks\www\images\company\#getcompanies.company_id#\" format="jpg" overwrite="true" resolution="high" scale="50">
</cfoutput>
