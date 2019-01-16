<cfparam name="form.Professional_ID" default="0">
	<cfif not form.Professional_ID gt 0>
		<cfinvoke component="professionals" method="InsertProfessional" returnvariable="variables.Professional_ID">
			<cfinvokeargument name="dsn" value="SalonWorks"> 
		</cfinvoke>
	<cfelse>
		<cfset variables.Professional_ID=form.Professional_ID>
	</cfif>
	
	<cfset professionalObj = CreateObject("component","professionals")>
	<cfset upd_cols = Duplicate(form)>
		
	<cfset StructDelete(upd_cols,"fieldnames")>
	<cfset StructDelete(upd_cols,"staffimagefile")>

	
	<cfset professionalObj.UpdateProfessional( argumentCollection = upd_cols )>
	<!--- <cfinvoke component="professionals" method="UpdateProfessional">
		<cfinvokeargument name="dsn" value="SalonWorks">
		<cfinvokeargument name="Professional_ID" value="#form.Professional_ID#"> 
		<cfinvokeargument name="Location_ID" value="#form.Location_ID#"> 
		<cfinvokeargument name="Title_ID" value=""> <!--- #form.Title_ID# --->
		<cfinvokeargument name="First_Name" value="#form.First_Name#"> 
		<cfinvokeargument name="Last_Name" value="#form.Last_Name#"> 
		<cfinvokeargument name="License_No" value=""> <!--- #form.License_No# --->
		<cfinvokeargument name="License_Expiration_Month" value=""> <!--- #form.License_Expiration_Month# --->
		<cfinvokeargument name="License_Expiration_Year" value=""> <!--- #form.License_Expiration_Year# --->
		<cfinvokeargument name="License_State" value=""> <!--- #form.License_State# --->
		<cfinvokeargument name="Home_Phone" value="#form.Home_Phone#"> 
		<cfinvokeargument name="Mobile_Phone" value="#form.Mobile_Phone#"> 
		<cfinvokeargument name="Home_Address" value="#form.Home_Address#"> 
		<cfinvokeargument name="Home_Address2" value="#form.Home_Address2#"> 
		<cfinvokeargument name="Home_City" value="#form.Home_City#"> 
		<cfinvokeargument name="Home_State" value="#form.Home_State#"> 
		<cfinvokeargument name="Home_Postal" value="#form.Home_Postal#"> 
		<cfinvokeargument name="Email_Address" value="#form.Email_Address#"> 
		<cfinvokeargument name="Password" value="#form.Password#"> 
		<cfinvokeargument name="Services_Offered" value="#form.Services_Offered#"> 
		<cfinvokeargument name="Accredidations" value="#form.Accredidations#"> 
		<cfinvokeargument name="Bio" value="#form.Bio#"> 
		<cfinvokeargument name="Active_Flag" value=""> <!--- #form.Active_Flag# --->
		<cfinvokeargument name="Appointment_Increment" value="#form.Appointment_Increment#"> 
		
	</cfinvoke> --->
	
	
	<!--- <cfif structKeyExists(form, "staffImageFile") AND Len(form.staffImageFile)>
		<cfset variables.FilePath = expandPath("../images/staff/") />

		<cffile action="upload" filefield="staffImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
		<cfset variables.FileExtention = "." & clientFileExt />
		<cfset variables.FileName = clientFile />
		
		<cfimage action="convert" source="#variables.FilePath##clientFile#" destination="#variables.FilePath##Session.Professional_ID#.jpg" overwrite="true" />
   		
		<cfimage action="resize" source="#variables.FilePath##Session.Professional_ID#.jpg" destination="#variables.FilePath##Session.Professional_ID#.jpg" width="300" height="300" overwrite="true" /> 	
	
		<cffile action="delete" file="#variables.FilePath##variables.FileName#" />
	</cfif> --->
	<cfif structKeyExists(form, "staffImageFile") AND Len(form.staffImageFile)>
		<cfset variables.FilePath = expandPath("../images/staff/") />
		<cffile action="upload" filefield="staffImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
		cfset variables.FileExtention = "." & cffile.clientFileExt />
		<cfset variables.FileName = cffile.clientFile />
		<cfimage action="convert" source="#variables.FilePath##cffile.clientFile#" destination="#variables.FilePath##variables.Professional_ID#.jpg" overwrite="true" />

		<cfimage action="resize" source="#variables.FilePath##variables.Professional_ID#.jpg" destination="#variables.FilePath##variables.Professional_ID#.jpg" width="300" height="300" overwrite="true" />

		<cffile action="delete" file="#variables.FilePath##variables.FileName#" />
	</cfif>
	<cfif structKeyExists(form, "professional_tab") >
		<cflocation url="index.cfm?showTab=member-tab" addtoken="no">
	<cfelse>
	<cflocation url="index.cfm?showPage=profile_professionals" addtoken="no">
	</cfif>
	