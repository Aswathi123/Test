<!--- <cfcomponent name="domain_suggesstions">
	<cffunction name="get_suggestions"> --->
		<cfhttp url="http://api.domaintools.com/v1/domain-suggestions/?query=domain%20tools&format=xml" method="GET"></cfhttp>
		<!--- <cfdump var="#cfhttp.filecontent#"> --->
		<cfset DomainList="">
		<cfxml variable="suggestions_xml">
		<cfoutput>#cfhttp.filecontent#</cfoutput>
		</cfxml>
		<cfdump var="#suggestions_xml#" label="xml">
		<cfoutput>
		<cfloop from="1" to="#ArrayLen(suggestions_xml.whoisapi.response.suggestions)#" index="i">
		#suggestions_xml.whoisapi.response.suggestions[i].domain.XmlText#<br>
		<cfif Left(suggestions_xml.whoisapi.response.suggestions[i].status.XmlText,1) eq 'q'>
			<cfset DomainList=ListAppend(DomainList,suggestions_xml.whoisapi.response.suggestions[i].domain.XmlText&'.com')>
		</cfif>
		</cfloop>
		</cfoutput>
		
		<cfdump var="#DomainList#" label="domainlist">
	<!--- </cffunction>
</cfcomponent> --->