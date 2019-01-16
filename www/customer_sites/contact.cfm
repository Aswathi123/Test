<cfinclude template="header.cfm">
<cfoutput><h1>#qCompany.Company_Name#</h1> 
<p>&nbsp;</p>
<cfif Len(qLocation.Location_Address)><div>#qLocation.Location_Address#</div></cfif>
<cfif Len(qLocation.Location_Address2)><div>#qLocation.Location_Address2#</div></cfif>
<cfif Len(qLocation.Location_City)><div>#qLocation.Location_City#, #qLocation.Location_State# #qLocation.Location_Postal#</div></cfif>
<cfif Len(qLocation.Location_Phone)><div>Phone: #qLocation.Location_Phone#</div></cfif>
<cfif Len(qLocation.Location_Fax)><div>Fax: #qLocation.Location_Fax#</div></cfif>
<cfif Len(qCompany.Company_Email)><div>Email: #qCompany.Company_Email#</div></cfif>
<br />
<br />
</cfoutput>
<div align="left">
<cfform action="contact.cfm" method="post">
	Name <input type="text" name="Name"><br>
	Email Address: <input type="text" name="Name"><br>
	Enter inquiry below<br>
	<textarea name="inquiry"></textarea><br>
	<input type="submit" value="Submit">
</cfform>
</div>
<cfinclude template="footer.cfm">