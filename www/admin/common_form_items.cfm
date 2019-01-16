<!--- Professional_form_elements content --->
<cfif isDefined("session.Professional_ID") and session.Professional_ID gt 0>
<cfset variables.Professional_ID=session.Professional_ID>
</cfif>
<cfif isDefined("session.Company_ID") and session.Company_ID gt 0>
<cfset variables.Company_ID=session.Company_ID>
</cfif>
<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
   <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessional">
   <cfinvokeargument name="Professional_ID" value="#variables.professional_id#">
   <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke>
<cfparam name="variables.Promo_Code" default="">
<cfparam name="variables.First_Name" default="">
<cfparam name="variables.Last_Name" default="">
<cfparam name="variables.Home_Phone" default="">
<cfparam name="variables.Mobile_Phone" default="">
<cfparam name="variables.Home_Address" default="">
<cfparam name="variables.Home_Address2" default="">
<cfparam name="variables.Home_City" default="">
<cfparam name="variables.Home_State" default="">
<cfparam name="variables.Home_Postal" default="">
<cfparam name="variables.Email_Address" default="">
<cfparam name="variables.Password" default="">
<cfparam name="variables.Services_Offered" default="">
<cfparam name="variables.Accredidations" default="">
<cfparam name="variables.Bio" default="">
<cfparam name="variables.Appointment_Increment" default="15">
<cfif isDefined('session.u') AND NOT FindNoCase('/admin/',cgi.SCRIPT_NAME)>
<cfset variables.First_Name=getCosmotrainingUser.FirstName>
<cfset variables.Last_Name=getCosmotrainingUser.LastName>
<cfset variables.Home_Address=getCosmotrainingUser.Address>
<cfset variables.Home_Address2=getCosmotrainingUser.Address2>
<cfset variables.Home_City=getCosmotrainingUser.City>
<cfset variables.Home_State=getCosmotrainingUser.State>
<cfset variables.Home_Postal=getCosmotrainingUser.PostalCode>
<cfset variables.Home_Phone=getCosmotrainingUser.Telephone>
<cfset variables.Email_Address=getCosmotrainingUser.Email>
<cfset variables.Appointment_Increment=getCosmotrainingUser.Appointment_Increment>
</cfif>
<cfif qProfessional.recordcount gt 0>
   <cfset variables.First_Name=qProfessional.First_Name>
   <cfset variables.Last_Name=qProfessional.Last_Name>
   <cfset variables.Home_Phone=qProfessional.Home_Phone>
   <cfset variables.Mobile_Phone=qProfessional.Mobile_Phone>
   <cfset variables.Home_Address=qProfessional.Home_Address>
   <cfset variables.Home_Address2=qProfessional.Home_Address2>
   <cfset variables.Home_City=qProfessional.Home_City>
   <cfset variables.Home_State=qProfessional.Home_State>
   <cfset variables.Home_Postal=qProfessional.Home_Postal>
   <cfset variables.Email_Address=qProfessional.Email_Address>
   <cfset variables.Password=qProfessional.Password>
   <cfset variables.Services_Offered=qProfessional.Services_Offered>
   <cfset variables.Accredidations=qProfessional.Accredidations>
   <cfset variables.Bio=qProfessional.Bio>
   <cfset variables.Appointment_Increment=qProfessional.Appointment_Increment>
</cfif>
<script>
   fnCheckEmailAddress = function(){
      if($('#Email_Address').val().length){
         $.ajax({
               type: "get",
               url: "/admin/company.cfc",
               data: {
                  method: "isExistingEmailAddress",
                  EmailAddress: $('#Email_Address').val(),
                  noCache: new Date().getTime()
                  },
               dataType: "json",
   
               // Define request handlers.
               success: function( objResponse ){
                  // Check to see if request was successful.
                  if (objResponse.SUCCESS){
                     if(objResponse.DATA){
                        alert('The Email address, ' + $('#Email_Address').val() + ', entered already exist.  Please enter a different address.');
                        $('#Email_Address').val('');
                        $('#Email_Address').focus();
                     }
   
                  } else {
                     alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help.');
                  }
               },
   
               error: function( objRequest, strError){
                  alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help. ' + strError);
               }
         });
      }
   }
   
</script>