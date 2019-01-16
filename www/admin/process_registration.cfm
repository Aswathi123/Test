<cfif !Len(form.First_Name)><cfabort></cfif>
<style>
  .center-info{
    width: 30%;
      margin: 14% auto;
      text-align: center;
  }
  .center-info h1{
    font-size: 6em;
  }
  .center-info p{
    font-size: 20px;
  }
  *, *:before, *:after{
      box-sizing: border-box;
  }
  body{
    min-width: 320px !important;
    margin: 0;
    padding: 0;
  }
  #outlook a{padding:0;}
    body{width:100% !important;-webkit-text-size-adjust:none;
    -ms-text-size-adjust:none;margin:0 !important; padding:0 !important;
  }
  p {
    word-break: break-all;
  }
  .main-width{
    width: 100%;
  }
</style>
 <cftry> 
<!--- <cfdump var="#Form["g-Recaptcha-Response"]#"><cfabort> --->
<!--- <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post" result="captchaResponse">
  <cfhttpparam  name="secret"  type="FORMFIELD"  value="6Lcsu3oUAAAAAOkP692ccbozimy2_sx_1HBkTDji">
  <cfhttpparam  name="response"  type="FORMFIELD"  value="#Form["g-Recaptcha-Response"]#">  
</cfhttp> 
<cfset local.resultContent = deserializeJSON(captchaResponse.Filecontent)>
<cfset variables.captchaStatus = local.resultContent.success >  --->
  <!--- <cfdump var="#variables.captchaStatus#"><cfabort> --->
<!--- <cfmail from="salonworks@salonworks.com" to="ciredrofdarb@gmail.com" subject="salonworks" type="HTML">
  <cfdump var="#cgi#">
  <cfdump var="#form#">
</cfmail> --->
<cfif 1 > 
<!---<cfif !FindNoCase('salonworks.com',cgi.HTTP_REFERER) OR !Len(form.Email_Address)>Please enter a  valid email<cfabort></cfif>  --->
<!--- Insert Company --->
<cfparam name="form.Payment_Methods_List" default="">
<cfinvoke component="admin.company" method="InsertCompany" returnvariable="variables.Company_ID">
  <cfinvokeargument name="Web_Address" value="#form.web_address#">
</cfinvoke>
<cfinvoke component="admin.company" method="UpdateCompany">
  <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
  <cfif structKeyExists(form, "Web_Address")>
    <cfinvokeargument name="Web_Address" value="#form.web_address#">
  </cfif>
  <cfif structKeyExists(form, "Company_Name")>
    <cfinvokeargument name="Company_Name" value="#form.Company_Name#">
  </cfif>
  <cfif structKeyExists(form, "Company_Address")>
    <cfinvokeargument name="Company_Address" value="#form.Company_Address#">
  </cfif>
  <cfif structKeyExists(form, "Company_Address2")>
    <cfinvokeargument name="Company_Address2" value="#form.Company_Address2#">
  </cfif>
  <cfif structKeyExists(form, "Company_City")>
    <cfinvokeargument name="Company_City" value="#form.Company_City#">
  </cfif>
  <cfif structKeyExists(form, "Company_State")>
    <cfinvokeargument name="Company_State" value="#form.Company_State#">
  </cfif>
  <cfif structKeyExists(form, "Company_Postal")>
    <cfinvokeargument name="Company_Postal" value="#form.Company_Postal#">
  </cfif>
  <cfif structKeyExists(form, "Company_Phone")>
    <cfinvokeargument name="Company_Phone" value="#form.Company_Phone#">
  </cfif>
  <cfif structKeyExists(form, "Company_Email")>
    <cfinvokeargument name="Company_Email" value="#form.Company_Email#">
  </cfif>
  <cfif structKeyExists(form, "Company_Fax")>
    <cfinvokeargument name="Company_Fax" value="#form.Company_Fax#">
  </cfif>
  <cfif structKeyExists(form, "Company_Description")>
    <cfinvokeargument name="Company_Description" value="#form.Company_Description#">
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
</cfinvoke>

<cfif structKeyExists(form, "companyImageFile") AND Len(form.companyImageFile)>
  <cfset variables.FilePath = expandPath("/images/company/") />
  <cffile action="upload" filefield="companyImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
  <cfset variables.FileExtention = "." & cffile.clientFileExt />
  <cfset variables.FileName = cffile.clientFile />

  <cfimage action="convert" source="#variables.FilePath##cffile.clientFile#" destination="#variables.FilePath##variables.Company_ID#.jpg" overwrite="true" />

  <cfimage action="resize" source="#variables.FilePath##variables.Company_ID#.jpg" destination="#variables.FilePath##variables.Company_ID#.jpg" width="300" height="300" overwrite="true" />

  <cffile action="delete" file="#variables.FilePath##variables.FileName#" />
</cfif>


<!--- Insert Location --->
<cfif structKeyExists(form, 'Begin_1')>
  <cfif form.Begin_1 neq 'Closed' and form.End_1 neq 'Closed'>
    <cfset variables.Sunday_Hours = TimeFormat(form.Begin_1,'h:mm tt')&' &mdash; '&TimeFormat(form.End_1,'h:mm tt')>
  <cfelse>
    <cfset variables.Sunday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_2')>
  <cfif form.Begin_2 neq 'Closed' and form.End_2 neq 'Closed'>
    <cfset variables.Monday_Hours = TimeFormat(form.Begin_2,'h:mm tt')&' &mdash; '&TimeFormat(form.End_2,'h:mm tt')>
  <cfelse>
    <cfset variables.Monday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_3')>
  <cfif form.Begin_3 neq 'Closed' and form.End_3 neq 'Closed'>
    <cfset variables.Tuesday_Hours = TimeFormat(form.Begin_3,'h:mm tt')&' &mdash; '&TimeFormat(form.End_3,'h:mm tt')>
  <cfelse>
    <cfset variables.Tuesday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_4')>
  <cfif form.Begin_4 neq 'Closed' and form.End_4 neq 'Closed'>
    <cfset variables.Wednesday_Hours = TimeFormat(form.Begin_4,'h:mm tt')&' &mdash; '&TimeFormat(form.End_4,'h:mm tt')>
  <cfelse>
    <cfset variables.Wednesday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_5')>
  <cfif form.Begin_5 neq 'Closed' and form.End_5 neq 'Closed'>
    <cfset variables.Thursday_Hours = TimeFormat(form.Begin_5,'h:mm tt')&' &mdash; '&TimeFormat(form.End_5,'h:mm tt')>
  <cfelse>
    <cfset variables.Thursday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_6')>
  <cfif form.Begin_6 neq 'Closed' and form.End_6 neq 'Closed'>
    <cfset variables.Friday_Hours = TimeFormat(form.Begin_6,'h:mm tt')&' &mdash; '&TimeFormat(form.End_6,'h:mm tt')>
  <cfelse>
    <cfset variables.Friday_Hours="Closed">
  </cfif>
</cfif>
<cfif structKeyExists(form, 'Begin_7')>
  <cfif form.Begin_7 neq 'Closed' and form.End_7 neq 'Closed'>
    <cfset variables.Saturday_Hours = TimeFormat(form.Begin_7,'h:mm tt')&' &mdash; '&TimeFormat(form.End_7,'h:mm tt')>
  <cfelse>
    <cfset variables.Saturday_Hours="Closed">
  </cfif>
</cfif>

<cfinvoke component="admin.location" method="InsertLocation" returnvariable="variables.Location_ID">
</cfinvoke>
<cfinvoke component="admin.location" method="UpdateLocation">
  <cfinvokeargument name="dsn" value="#request.dsn#">
  <cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
  <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
  <cfif structKeyExists(form, "Contact_Phone")>
    <cfinvokeargument name="Contact_Phone" value="#form.Contact_Phone#">
  </cfif>
  <cfif structKeyExists(form, "Location_Name")>
    <cfinvokeargument name="Location_Name" value="#form.Location_Name#">
  </cfif>
  <cfif structKeyExists(form, "Location_Address")>
    <cfinvokeargument name="Location_Address" value="#form.Location_Address#">
  </cfif>
  <cfif structKeyExists(form, "First_Name") and structKeyExists(form, "Last_Name")>
    <cfinvokeargument name="Contact_Name" value="#form.First_Name# #form.Last_Name#">
  </cfif>
  <cfif structKeyExists(form, "Location_Address")>
    <cfinvokeargument name="Location_Address" value="#form.Location_Address#">
  </cfif>
  <cfif structKeyExists(form, "Location_Address2")>
    <cfinvokeargument name="Location_Address2" value="#form.Location_Address2#">
  </cfif>
  <cfif structKeyExists(form, "Location_City")>
    <cfinvokeargument name="Location_City" value="#form.Location_City#">
  </cfif>
  <cfif structKeyExists(form, "Location_State")>
    <cfinvokeargument name="Location_State" value="#form.Location_State#">
  </cfif>
  <cfif structKeyExists(form, "Location_Postal")>
    <cfinvokeargument name="Location_Postal" value="#form.Location_Postal#">
  </cfif>
  <cfif structKeyExists(form, "Location_Phone")>
    <cfinvokeargument name="Location_Phone" value="#form.Location_Phone#">
  </cfif>
  <cfif structKeyExists(form, "Location_Fax")>
    <cfinvokeargument name="Location_Fax" value="#form.Location_Fax#">
  </cfif>
  <cfif structKeyExists(form, "Description")>
    <cfinvokeargument name="Description" value="#form.Description#">
  </cfif>
  <cfif structKeyExists(form, "time_zone_id")>
    <cfinvokeargument name="time_zone_id" value="#form.time_zone_id#">
  </cfif>
  <cfif structKeyExists(form, "Sunday_Hours")>
    <cfinvokeargument name="Sunday_Hours" value="#form.Sunday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Monday_Hours")>
    <cfinvokeargument name="Monday_Hours" value="#form.Monday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Tuesday_Hours")>
    <cfinvokeargument name="Tuesday_Hours" value="#form.Tuesday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Wednesday_Hours")>
    <cfinvokeargument name="Wednesday_Hours" value="#form.Wednesday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Thursday_Hours")>
    <cfinvokeargument name="Thursday_Hours" value="#form.Thursday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Friday_Hours")>
    <cfinvokeargument name="Friday_Hours" value="#form.Friday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Saturday_Hours")>
    <cfinvokeargument name="Saturday_Hours" value="#form.Saturday_Hours#">
  </cfif>
  <cfif structKeyExists(form, "Payment_Methods_List")>
    <cfinvokeargument name="Payment_Methods_List" value="#form.Payment_Methods_List#">
  </cfif>
  <cfif structKeyExists(form, "Parking_Fees")>
    <cfinvokeargument name="Parking_Fees" value="#form.Parking_Fees#">
  </cfif>
  <cfif structKeyExists(form, "Cancellation_Policy")>
    <cfinvokeargument name="Cancellation_Policy" value="#form.Cancellation_Policy#">
  </cfif>
  <cfif structKeyExists(form, "Languages")>
    <cfinvokeargument name="Languages" value="#form.Languages#">
  </cfif>
  <cfif structKeyExists(form, "Directions")>
    <cfinvokeargument name="Directions" value="#form.Directions#">
  </cfif>
  <cfinvokeargument name="Services_List" value="">
</cfinvoke>
<!--- Insert Professional --->

<cfinvoke component="admin.professionals" method="InsertProfessional" returnvariable="variables.Professional_ID">
</cfinvoke>

<cfinvoke component="admin.professionals" method="UpdateProfessional" returnvariable="variables.password">
  <cfinvokeargument name="Professional_ID" value="#variables.Professional_ID#">
  <cfinvokeargument name="Location_ID" value="#variables.Location_ID#">
  <cfinvokeargument name="First_Name" value="#form.First_Name#">
  <cfinvokeargument name="Last_Name" value="#form.Last_Name#">
  <cfinvokeargument name="License_No" value="">
  <cfinvokeargument name="License_Expiration_Month" value="">
  <cfinvokeargument name="License_Expiration_Year" value="">
  <cfinvokeargument name="License_State" value="">
  <!--- <cfinvokeargument name="Title_ID" value="#form.Title_ID#">  --->
  <!--- <cfinvokeargument name="License_No" value="#form.License_No#">
  <cfinvokeargument name="License_Expiration_Month" value="#form.License_Expiration_Month#">
  <cfinvokeargument name="License_Expiration_Year" value="#form.License_Expiration_Year#">
  <cfinvokeargument name="License_State" value="#form.License_State#">  --->
  <cfif structKeyExists(form, "Home_Phone")>
    <cfinvokeargument name="Home_Phone" value="#form.Home_Phone#">
  </cfif>
  <cfif structKeyExists(form, "Home_Address")>
    <cfinvokeargument name="Home_Address" value="#form.Home_Address#">
  </cfif>
  <cfif structKeyExists(form, "Home_Address2")>
    <cfinvokeargument name="Home_Address2" value="#form.Home_Address2#">
  </cfif>
  <cfif structKeyExists(form, "Home_City")>
    <cfinvokeargument name="Home_City" value="#form.Home_City#">
  </cfif>
  <cfif structKeyExists(form, "Home_State")>
    <cfinvokeargument name="Home_State" value="#form.Home_State#">
  </cfif>
  <cfif structKeyExists(form, "Home_Postal")>
    <cfinvokeargument name="Home_Postal" value="#form.Home_Postal#">
  </cfif>
  <cfif structKeyExists(form, "Mobile_Phone")>
    <cfinvokeargument name="Mobile_Phone" value="#form.Mobile_Phone#">
  </cfif>
  <cfif structKeyExists(form, "Email_Address")>
    <cfinvokeargument name="Email_Address" value="#form.Email_Address#">
  </cfif>
  <cfif structKeyExists(form, "Password")>
    <cfinvokeargument name="Password" value="#form.Password#">
  </cfif>
  <!--- <cfinvokeargument name="Mobile_Phone" value="#form.Mobile_Phone#">
  <cfinvokeargument name="Email_Address" value="#form.Email_Address#">
  <cfinvokeargument name="Password" value="#form.Password#"> --->
  <cfif structKeyExists(form, "Services_Offered") >
    <cfinvokeargument name="Services_Offered" value="">- <!--- #form.Services_Offered# --->
  </cfif>
  <cfif structKeyExists(form, "Accredidations") >
    <cfinvokeargument name="Accredidations" value="">- <!---#form.Accredidations# --->
  </cfif>
  <cfif structKeyExists(form, 'Bio')>
    <cfinvokeargument name="Bio" value="#form.Bio#">
  </cfif>
  <cfif structKeyExists(form, "Appointment_Increment") >
    <cfinvokeargument name="Appointment_Increment" value="#Form.Appointment_Increment#">
  </cfif>
  <!--- <cfinvokeargument name="Active_Flag" value="#form.Active_Flag#">  --->
</cfinvoke>
<cfif structKeyExists(form, "staffImageFile") AND Len(form.staffImageFile)>
  <cfset variables.FilePath = expandPath("/images/staff/") />

  <cffile action="upload" filefield="staffImageFile" destination="#variables.FilePath#" nameConflict="Overwrite" accept="image/jpeg, image/jpg, image/gif, image/png" />
  <cfset variables.FileExtention = "." & cffile.clientFileExt />
  <cfset variables.FileName = cffile.clientFile />

  <cfimage action="convert" source="#variables.FilePath##cffile.clientFile#" destination="#variables.FilePath##variables.Professional_ID#.jpg" overwrite="true" />

  <cfimage action="resize" source="#variables.FilePath##variables.Professional_ID#.jpg" destination="#variables.FilePath##variables.Professional_ID#.jpg" width="300" height="300" overwrite="true" />

  <cffile action="delete" file="#variables.FilePath##variables.FileName#" />
</cfif>

<cfset variables.companyCFC = createObject("component","company") />
<cfset variables.qrySocialMedia = variables.companyCFC.getSocialMedia() />
<cfset Form.socialIdList = "" />

  <cfloop query="variables.qrySocialMedia">
    <cfif structKeyExists(form, "Form.URL_" & Social_Media_ID)>
      <cfif Len(#Evaluate("Form.URL_" & Social_Media_ID)#)>
        <cfset Form.socialIdList = ListAppend(Form.socialIdList,Social_Media_ID) />
      </cfif> 
    </cfif>
  </cfloop>

<cfif ListLen(Form.socialIdList)>
  <cfset variables.companyCFC.saveSocialMediaForm(variables.Company_ID, Form) />
</cfif>
<cfmail from="salonworks@salonworks.com" to="#form.Email_Address#" bcc="ciredrofdarb@gmail.com" subject="Welcome To SalonWorks" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" type="HTML">
  <cfmailpart type="text/html">
    <div style="background: ##f0f3f6; min-height: 100vh;">
      <div class="container" style="margin: auto; max-width: 100%; width: 840px; border:1px solid ##ddd; border-bottom: 0; background: ##fff;">
        <table class="main-width" style="border-spacing: 0; width:100%;" border="0" cellspacing="0" cellpadding="0"><!--logo-space-->
          <tbody>
            <tr>
              <td>
                <table style="width: 840px; margin: auto; border-spacing: 0px;"><!--text-content-->
                  <tbody>
                    <tr class="" style="width: 100%; background: ##fff; text-align: center;">
                      <td style="padding: 20px 0;"> <a href=""><img src="http://salonworks.com/img/logo.png" alt=""></a></td>
                    </tr>
                    <table border="0" cellspacing="0" cellpadding="0" style=" height:265px; width: 100%; text-align: left;">
                      <tr>
                        <td style="padding: 10px 50px;">

                          <h2 style="font-family: Roboto, sans-serif, arial;" >Hello #form.First_Name#  #form.Last_Name#!</h2>

                          <p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; margin-bottom:40px;">
                        
                            Congratulations on your new account with SalonWorks.com!<br><br>
                            
                            Log in to your account using your email address and the password below:<br>
                            
                            <strong>Email:</strong> #form.Email_Address# <br>
                            <strong>Password:</strong>#variables.password.pw#<br><br>

                            Once you log in, you will be able to personalize your custom web site.<br><br>

                            *Add <strong>salonworks@salonwkorks</strong> to your address book to make sure you don't miss out on our emails.
                          </p>
                        </td>
                      </tr>
                      <tr>
                        <td style="padding: 10px 50px;">
                          <p style="font: 17px/23px 'Roboto', sans-serif, arial; color:##646464; padding-top: 25px; border-top: 1px solid ##eee;">
                            Regards,<br>
                            SalonWorks Customer Support<br>
                            salonworks@salonworks.com
                          </p>
                        </td>
                      </tr>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0" style=" height:95px; width: 100%; text-align: center; background: ##2995d3; padding: 34px 5px;">
                      <tr>
                        <td style="width: 33%; float: left; ">
                          <a href="https://www.facebook.com/pages/Salonworks/1434509316766493" style="margin-right: 10px;"><img src="http://salonworks.com/images/facebook_round.png" alt=""></a>
                        </td>
                        <td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
                          <img src="http://salonworks.com/images/call.png" alt="" style="vertical-align: middle; margin-right: 5px;">
                          <label>
                           <a href="tel:+ (978) 352-0235" style="color: ##fff; text-decoration:  none;">+ (978) 352-0235</a>
                          </label>
                        </td>
                        <td style="width: 33%; float: left; font:14px/23px 'Roboto', sans-serif, arial;">
                          <img src="http://salonworks.com/images/mail.png" alt="" style="vertical-align: middle; margin-right: 5px;">
                          <label>
                           <a href="mailto:salonworks@salonworks.com" style="color: ##fff; text-decoration:  none;">salonworks@salonworks.com </a>
                          </label>
                        </td>
                      </tr>
                    </table>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </cfmailpart>
</cfmail>
<cfif structKeyExists(form, 'firstsignup')>
  <cfset local.firstsignup = form.firstsignup >
</cfif>
<cfset professionalsObj = CreateObject("component","professionals")>
<cfset professionalsObj.loginProfessional(Email_Address = #form.EMAIL_ADDRESS#, Password = #variables.Password.pw#,firstsignup =#local.firstsignup#)>
<cfelse>
  <div class="main-wrap">
    <div class="center-info">
       <p>Captcha Validation Error</p>
       <p><a href="..\index.cfm">Click here to go back</p>
    </div>
  </div>
</cfif> 
<cfcatch><cfdump var="#cfcatch#" abort="true"></cfcatch>
</cftry>
