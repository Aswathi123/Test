<cfparam name="form.Salon_Name" default="">
<cfparam name="form.Salon_Address" default="">
<cfquery name="insertnote" datasource="salonworks">
	INSERT INTO 
		Salon_Notes
		(Employee_ID
		,Number_Professionals
		,Number_Sells
		,Notes
		,LicenseNo
		,Salon_Name
		,Salon_Address
		,Source)
		VALUES
		(<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER" />
		,<cfqueryparam value="#form.Number_Professionals#" cfsqltype="CF_SQL_INTEGER" />
		,<cfqueryparam value="#form.Number_Sells#" cfsqltype="CF_SQL_INTEGER" />
		,<cfqueryparam value="#form.notes#" cfsqltype="CF_SQL_LONGVARCHAR" />
		,<cfqueryparam value="#form.LicenseNo#" cfsqltype="CF_SQL_VARCHAR" />
		,<cfqueryparam value="#form.Salon_Name#" cfsqltype="CF_SQL_VARCHAR" />
		,<cfqueryparam value="#form.Salon_Address#" cfsqltype="CF_SQL_VARCHAR" />
		,<cfqueryparam value="#form.Source#" cfsqltype="CF_SQL_VARCHAR" />
		)
</cfquery>