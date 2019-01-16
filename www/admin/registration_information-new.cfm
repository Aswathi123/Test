
<cfset variables.Company_ID=session.Company_ID>
<!--- <cfparam name="form.Payment_Methods_List" default="">
<cfinvoke component="admin.registerinfo" method="UpdateCompany">
	<cfinvokeargument name="Company_ID" value="#session.Company_ID#">
	<!--- <cfif structKeyExists(form, "Web_Address")>
		<cfinvokeargument name="Web_Address" value="#form.Web_Address#">
	</cfif> --->
	<cfif structKeyExists(form, "Cmp_Name")>
		<cfinvokeargument name="Company_Name" value="#form.Cmp_Name#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Address")>
		<cfinvokeargument name="Company_Address" value="#form.Cmp_Address#">
	</cfif>
	<!--- <cfif structKeyExists(form, "Company_Address2")>
		<cfinvokeargument name="Company_Address2" value="#form.Company_Address2#">
	</cfif> --->
	<cfif structKeyExists(form, "Cmp_City")>
		<cfinvokeargument name="Company_City" value="#form.Cmp_City#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_State")>
		<cfinvokeargument name="Company_State" value="#form.Cmp_State#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Postal")>
		<cfinvokeargument name="Company_Postal" value="#form.Cmp_Postal#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Phone")>
		<cfinvokeargument name="Company_Phone" value="#form.Cmp_Phone#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Email")>
		<cfinvokeargument name="Company_Email" value="#form.Cmp_Email#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Fax")>
		<cfinvokeargument name="Company_Fax" value="#form.Cmp_Fax#">
	</cfif>
	<cfif structKeyExists(form, "Cmp_Description")>
		<cfinvokeargument name="Company_Description" value="#form.Cmp_Description#">
	</cfif>
	<cfif structKeyExists(form, "Promo_Code")>
		<cfinvokeargument name="Promo_Code" value="#form.Promo_Code#">
	</cfif>
	<cfinvokeargument name="Professional_Admin_ID" value="">
	<cfinvokeargument name="Credit_Card_No" value="">
	<cfinvokeargument name="Name_On_Card" value="">
	<cfinvokeargument name="Billing_Address" value="">
	<cfinvokeargument name="Billing_Address2" value="">
	<cfinvokeargument name="Billing_City" value="">
	<cfinvokeargument name="Billing_State" value="">
	<cfinvokeargument name="Billing_Postal" value="">
	<cfinvokeargument name="Credit_Card_ExpMonth" value="">
	<cfinvokeargument name="Credit_Card_ExpYear" value="">
	<cfinvokeargument name="CVV_Code" value="">
	<cfinvokeargument name="Hosted" value="">
</cfinvoke> --->

<cfif structKeyExists(form, "company_ImageFile") AND Len(form.company_ImageFile)>
	<cfset variables.FilePath = expandPath("/images/company/") />
	<cffile action="upload" filefield="company_ImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png"/>
	<cfset variables.FileExtention = "." & cffile.clientFileExt />
	<cfset variables.FileName = cffile.clientFile />

	<cfimage action="convert" source="#variables.FilePath##cffile.clientFile#" destination="#variables.FilePath##variables.Company_ID#.jpg" overwrite="true" />

	<cfimage action="resize" source="#variables.FilePath##variables.Company_ID#.jpg" destination="#variables.FilePath##variables.Company_ID#.jpg" width="300" height="300" overwrite="true" />
	
	<cffile action="delete" file="#variables.FilePath##variables.FileName#" />
</cfif>
<cfif structKeyExists(form, "doitlater")>
	<cfset session.doitlater=1>
	<cfquery name="updateDoItLater" datasource="#request.dsn#" result="updateDoitlater">
			UPDATE Professionals
			SET Do_It_Later = 0
			WHERE Professional_ID = #session.professional_Id#
	</cfquery>
<cfelseif  structKeyExists(form, "saveall")>
	<cfquery name="updateDoItLater" datasource="#request.dsn#" result="updateDoitlater">
			UPDATE Professionals
			SET Do_It_Later = 1
			WHERE Professional_ID = #session.professional_Id#
	</cfquery>
</cfif>


<!--- <cfif structKeyExists(form, 'Begins_1')>
	<cfif form.Begins_1 neq 'Closed' and form.Ends_1 neq 'Closed'>
		<cfset variables.Sunday_Hours = TimeFormat(form.Begins_1,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_1,'h:mm tt')>
	<cfelse>
		<cfset variables.Sunday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_2')>
	<cfif form.Begins_2 neq 'Closed' and form.Ends_2 neq 'Closed'>
		<cfset variables.Monday_Hours = TimeFormat(form.Begins_2,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_2,'h:mm tt')>
	<cfelse>
		<cfset variables.Monday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_3')>
	<cfif form.Begins_3 neq 'Closed' and form.Ends_3 neq 'Closed'>
		<cfset variables.Tuesday_Hours = TimeFormat(form.Begins_3,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_3,'h:mm tt')>
	<cfelse>
		<cfset variables.Tuesday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_4')>
	<cfif form.Begins_4 neq 'Closed' and form.Ends_4 neq 'Closed'>
		<cfset variables.Wednesday_Hours = TimeFormat(form.Begins_4,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_4,'h:mm tt')>
	<cfelse>
		<cfset variables.Wednesday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_5')>
	<cfif form.Begins_5 neq 'Closed' and form.Ends_5 neq 'Closed'>
		<cfset variables.Thursday_Hours = TimeFormat(form.Begins_5,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_5,'h:mm tt')>
	<cfelse>
		<cfset variables.Thursday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_6')>
	<cfif form.Begins_6 neq 'Closed' and form.Ends_6 neq 'Closed'>
		<cfset variables.Friday_Hours = TimeFormat(form.Begins_6,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_6,'h:mm tt')>
	<cfelse>
		<cfset variables.Friday_Hours="Closed">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'Begins_7')>
	<cfif form.Begins_7 neq 'Closed' and form.Ends_7 neq 'Closed'>
		<cfset variables.Saturday_Hours = TimeFormat(form.Begins_7,'h:mm tt')&' &mdash; '&TimeFormat(form.Ends_7,'h:mm tt')>
	<cfelse>
		<cfset variables.Saturday_Hours="Closed">
	</cfif>
</cfif>


<cfif structKeyExists(form, 'BreakBegin_1')>
	<!--- <cfdump var="#form#"><cfabort> --->
	<cfif form.BreakBegin_1 neq 'NoBreak' and form.BreakEnd_1 neq 'NoBreak'>
		<cfset variables.Sunday_Break = TimeFormat(form.BreakBegin_1,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_1,'h:mm tt')>
	<cfelse>
		<cfset variables.Sunday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_2')>
	<cfif form.BreakBegin_2 neq 'NoBreak' and form.BreakEnd_2 neq 'NoBreak'>
		<cfset variables.Monday_Break = TimeFormat(form.BreakBegin_2,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_2,'h:mm tt')>
	<cfelse>
		<cfset variables.Monday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_3')>
	<cfif form.BreakBegin_3 neq 'NoBreak' and form.BreakEnd_3 neq 'NoBreak'>
		<cfset variables.Tuesday_Break = TimeFormat(form.BreakBegin_3,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_3,'h:mm tt')>
	<cfelse>
		<cfset variables.Tuesday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_4')>
	<cfif form.BreakBegin_4 neq 'NoBreak' and form.BreakEnd_4 neq 'NoBreak'>
		<cfset variables.Wednesday_Break = TimeFormat(form.BreakBegin_4,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_4,'h:mm tt')>
	<cfelse>
		<cfset variables.Wednesday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_5')>
	<cfif form.BreakBegin_5 neq 'NoBreak' and form.BreakEnd_5 neq 'NoBreak'>
		<cfset variables.Thursday_Break = TimeFormat(form.BreakBegin_5,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_5,'h:mm tt')>
	<cfelse>
		<cfset variables.Thursday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_6')>
	<cfif form.BreakBegin_7 neq 'NoBreak' and form.BreakEnd_6 neq 'NoBreak'>
		<cfset variables.Friday_Break = TimeFormat(form.BreakBegin_6,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_6,'h:mm tt')>
	<cfelse>
		<cfset variables.Friday_Break="NoBreak">
	</cfif>
</cfif>
<cfif structKeyExists(form, 'BreakBegin_7')>
	<cfif form.BreakBegin_7 neq 'NoBreak' and form.BreakEnd_7 neq 'NoBreak'>
		<cfset variables.Saturday_Break = TimeFormat(form.BreakBegin_7,'h:mm tt')&' &mdash; '&TimeFormat(form.BreakEnd_7,'h:mm tt')>
	<cfelse>
		<cfset variables.Saturday_Break="NoBreak">
	</cfif>
</cfif>

<cfinvoke component="admin.registerinfo" method="UpdateLocation">
	<cfinvokeargument name="dsn" value="#request.dsn#">
	<cfinvokeargument name="Location_ID" value="#session.Location_ID#">
	<cfinvokeargument name="Company_ID" value="#session.Company_ID#">
	<cfif structKeyExists(form, "Cnt_Phone")>
		<cfinvokeargument name="Contact_Phone" value="#form.Cnt_Phone#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Name")>
		<cfinvokeargument name="Location_Name" value="#form.Lct_Name#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Address")>
		<cfinvokeargument name="Location_Address" value="#form.Lct_Address#">
	</cfif>
	<cfif structKeyExists(form, "First_Name") and structKeyExists(form, "Last_Name")>
		<cfinvokeargument name="Contact_Name" value="#form.First_Name# #form.Last_Name#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Address")>
		<cfinvokeargument name="Location_Address" value="#form.Lct_Address#">
	</cfif>
	<cfif structKeyExists(form, "Location_Address2")>
		<cfinvokeargument name="Location_Address2" value="#form.Location_Address2#">
	</cfif>
	<cfif structKeyExists(form, "Lct_City")>
		<cfinvokeargument name="Location_City" value="#form.Lct_City#">
	</cfif>
	<cfif structKeyExists(form, "Lct_State")>
		<cfinvokeargument name="Location_State" value="#form.Lct_State#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Postal")>
		<cfinvokeargument name="Location_Postal" value="#form.Lct_Postal#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Phone")>
		<cfinvokeargument name="Location_Phone" value="#form.Lct_Phone#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Fax")>
		<cfinvokeargument name="Location_Fax" value="#form.Lct_Fax#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Description")>
		<cfinvokeargument name="Description" value="#form.Lct_Description#">
	</cfif>
	<cfif structKeyExists(form, "time_zone_id")>
		<cfinvokeargument name="time_zone_id" value="#form.time_zone_id#">
	</cfif>
	<cfif structKeyExists(variables, "Sunday_Hours")>
		<cfinvokeargument name="Sunday_Hours" value="#variables.Sunday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Monday_Hours")>
		<cfinvokeargument name="Monday_Hours" value="#variables.Monday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Tuesday_Hours")>
		<cfinvokeargument name="Tuesday_Hours" value="#variables.Tuesday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Wednesday_Hours")>
		<cfinvokeargument name="Wednesday_Hours" value="#variables.Wednesday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Thursday_Hours")>
		<cfinvokeargument name="Thursday_Hours" value="#variables.Thursday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Friday_Hours")>
		<cfinvokeargument name="Friday_Hours" value="#variables.Friday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Saturday_Hours")>
		<cfinvokeargument name="Saturday_Hours" value="#variables.Saturday_Hours#">
	</cfif>
	<cfif structKeyExists(variables, "Sunday_Break")>
		<cfinvokeargument name="Sunday_Break" value="#variables.Sunday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Monday_Break")>
		<cfinvokeargument name="Monday_Break" value="#variables.Monday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Tuesday_Break")>
		<cfinvokeargument name="Tuesday_Break" value="#variables.Tuesday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Wednesday_Break")>
		<cfinvokeargument name="Wednesday_Break" value="#variables.Wednesday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Thursday_Break")>
		<cfinvokeargument name="Thursday_Break" value="#variables.Thursday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Friday_Break")>
		<cfinvokeargument name="Friday_Break" value="#variables.Friday_Break#">
	</cfif>
	<cfif structKeyExists(variables, "Saturday_Break")>
		<cfinvokeargument name="Saturday_Break" value="#variables.Saturday_Break#">
	</cfif>
	<cfif structKeyExists(form, "Payment_MethodList")>
		<cfinvokeargument name="Payment_Methods_List" value="#form.Payment_MethodList#">
	</cfif>
	<cfif structKeyExists(form, "Parking_Fee")>
		<cfinvokeargument name="Parking_Fees" value="#form.Parking_Fee#">
	</cfif>
	<cfif structKeyExists(form, "Cancellation_Policy")>
		<cfinvokeargument name="Cancellation_Policy" value="#form.Cancellation_Policy#">
	</cfif>
	<cfif structKeyExists(form, "Language")>
		<cfinvokeargument name="Languages" value="#form.Language#">
	</cfif>
	<cfif structKeyExists(form, "Lct_Directions")>
		<cfinvokeargument name="Directions" value="#form.Lct_Directions#">
	</cfif>
	<!--- <cfinvokeargument name="Services_List" value=""> --->
</cfinvoke> --->
<cflocation url="index.cfm" addtoken="no">