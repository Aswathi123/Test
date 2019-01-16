<!--- <cfdump var="#form#"><cfabort> --->
	<cfif not form.Company_ID gt 0>
		<cfinvoke component="company" method="InsertCompany" returnvariable="variables.Company_ID"> 
			<cfinvokeargument name="Web_Address" value="#form.Web_Address#">
		</cfinvoke>
	<cfelse>
		<cfset variables.Company_ID=form.Company_ID>
	</cfif>
	
	<cfinvoke component="company" method="UpdateCompany">
		<cfinvokeargument name="dsn" value="salonWorks">
		<cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
		<cfinvokeargument name="Web_Address" value="#form.Web_Address#">
		<cfinvokeargument name="Company_Name" value="#form.Company_Name#">
		<cfinvokeargument name="Company_Address" value="#form.Company_Address#">
		<cfinvokeargument name="Company_Address2" value="#form.Company_Address2#">
		<cfinvokeargument name="Company_City" value="#form.Company_City#">
		<cfinvokeargument name="Company_State" value="#form.Company_State#">
		<cfinvokeargument name="Company_Postal" value="#form.Company_Postal#">
		<cfinvokeargument name="Company_Phone" value="#form.Company_Phone#">
		<cfinvokeargument name="Company_Email" value="#form.Company_Email#">
		<cfinvokeargument name="Company_Fax" value="#form.Company_Fax#">
		<cfinvokeargument name="Company_Description" value="#form.Company_Description#">
		<cfif structKeyExists(form, "Professional_Admin_ID") >
			<cfinvokeargument name="Professional_Admin_ID" value="#form.Professional_Admin_ID#">
		</cfif>
		<!--- <cfinvokeargument name="Credit_Card_No" value="#form.Credit_Card_No#">
		<cfinvokeargument name="Name_On_Card" value="#form.Name_On_Card#">
		<cfinvokeargument name="Billing_Address" value="#form.Billing_Address#">
		<cfinvokeargument name="Billing_Address2" value="#form.Billing_Address2#">
		<cfinvokeargument name="Billing_City" value="#form.Billing_City#">
		<cfinvokeargument name="Billing_State" value="#form.Billing_State#">
		<cfinvokeargument name="Billing_Postal" value="#form.Billing_Postal#">
		<cfinvokeargument name="Credit_Card_ExpMonth" value="#form.Credit_Card_ExpMonth#">
		<cfinvokeargument name="Credit_Card_ExpYear" value="#form.Credit_Card_ExpYear#">
		<cfinvokeargument name="CVV_Code" value="#form.CVV_Code#"> 
		<cfinvokeargument name="Hosted" value="#form.Hosted#"> --->
	</cfinvoke>
	
	
	<cfif structKeyExists(form, "companyImageFile") AND Len(form.companyImageFile)>
		<cfset variables.FilePath = expandPath("../images/company/") />
		<cffile action="upload" filefield="companyImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
		<cfset variables.FileExtention = "." & cffile.clientFileExt />
		<cfset variables.FileName = cffile.clientFile />

		<cfimage action="convert" source="#variables.FilePath##cffile.clientFile#" destination="#variables.FilePath##variables.Company_ID#.jpg" overwrite="true" />

		<cfimage action="resize" source="#variables.FilePath##variables.Company_ID#.jpg" destination="#variables.FilePath##variables.Company_ID#.jpg" width="300" height="300" overwrite="true" />

		<cffile action="delete" file="#variables.FilePath##variables.FileName#" />
	</cfif>

		
	
	<cfset variables.companyCFC = createObject("component","company") /> 
	<cfset variables.qrySocialMedia = variables.companyCFC.getSocialMedia() /> 
	<cfset Form.socialIdList = "" />
	<cfloop query="variables.qrySocialMedia">
		<cfif Len(Evaluate("Form.URL_" & Social_Media_ID))>
			<cfset Form.socialIdList = ListAppend(Form.socialIdList,Social_Media_ID) />
		</cfif>
	</cfloop>
	<cfif ListLen(Form.socialIdList)>
		<cfset variables.companyCFC.saveSocialMediaForm(session.company_id, Form) />
	</cfif>
	<cfif structKeyExists(form, "company_tab") >
		<cflocation url="index.cfm?showTab=task-tab" addtoken="no">
	<cfelse>
	<cflocation url="index.cfm?showPage=profile_company" addtoken="no">
	</cfif>