<cfinclude template="/templates/0001/header.cfm">
<div>
<cfoutput query="qProfessional">
	<div><strong>#qProfessional.First_Name# #qProfessional.Last_Name#</strong> </div>
	<div>#qProfessional.Bio# </div>
	<div>#qProfessional.Services_Offered# </div>
	<div>#qProfessional.Accredidations#</div>
</cfoutput>
</div><!--- 
<cfdump var="#qProfessional#"> --->
<cfinclude template="/templates/0001/footer.cfm">