<cfinclude template="header.cfm">
<cfparam name="URL.LicenseNo" default="">
<cfparam name="URL.Source" default="">
<cfquery name="getnotes" datasource="salonworks">
	SELECT 
		Number_Professionals
		,Number_Sells
		,Notes
		,Employee_ID
		,DateTimeStamp
	FROM
		Salon_Notes
	WHERE 		
		LicenseNo=<cfqueryparam value="#URL.LicenseNo#" cfsqltype="CF_SQL_VARCHAR" />
	AND
		Source=<cfqueryparam value="#URL.Source#" cfsqltype="CF_SQL_VARCHAR" />
</cfquery>
<cfquery name="getsalon" datasource="salonworks">
	SELECT 
	 Salon_Name
      ,Address_1
      ,Address_2
      ,City
      ,State
      ,Zip_Code
      ,County
      ,Salon_Type
      ,Source
      ,LicenseNo
	FROM 
		Salons
	WHERE 		
		LicenseNo=<cfqueryparam value="#URL.LicenseNo#" cfsqltype="CF_SQL_VARCHAR" />
	AND
		Source=<cfqueryparam value="#URL.Source#" cfsqltype="CF_SQL_VARCHAR" />
</cfquery>
<cfoutput>
<h2>#getsalon.Salon_Name#</h2>
	<table>
	<tr>
		<th>Date / Time</th>
		<th>Number of Professionals</th>
		<th>Number of Sells</th>
		<th>Employee</th>
	</tr>
<cfloop query ="getnotes">
	<tr>
		<td>#DateTimeStamp#</td>
		<td>#Number_Professionals#</td>
		<td>#Number_Sells#</td>
		<td>#Notes#</td>
		<td>#Employee_ID#</td>
	</tr>
</cfloop>
	</table>
<form action="updatenotes.cfm" method="post">
<input type="hidden" name="LicenseNo" value="#url.LicenseNo#">
<input type="hidden" name="Source" value="#url.source#">
Number of Professionals:<br>
<select name="Number_Professionals">
	<cfloop from="1" to="19" index="i">
		<option value="#i#">#i#</option>
	</cfloop>
	<cfloop from="20" to="100" index="i" step="10">
		<option value="#i#">#i#</option>
	</cfloop>
</select>
<p></p>
Number of Trials Sold:<br>
<select name="Number_Sells">
	<cfloop from="0" to="20" index="i">
		<option value="#i#">#i#</option>
	</cfloop>
</select>
<p></p>
<cfif url.LicenseNo eq ''>
Salon Name<br>
<input type="text" name="salon_name">
<p></p>
Salon Address<br>
<textarea name="salon_address" cols="40" rows="5"></textarea>
</cfif>
<p></p>
Notes:<br>
<textarea name="notes" cols="40" rows="9"></textarea>
<p></p>
<input type="submit" value="Enter Note">
</form>
</cfoutput>
<cfinclude template="footer.cfm">