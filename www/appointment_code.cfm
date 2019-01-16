
<cfset variables.company_phone = "" />
<cfset variables.blnShowBooking = false />
<cfset variables.blnFailed = false />
<cfset variables.FailedMsg = "" />
<cfset variables.Professional_ID = 0 />
<cfset variables.companyid = 0 />
<cfset variables.ServiceID = 0 />
<cfset variables.locationid = 0/>
<cfset variables.AvailableDate = DateFormat(Now(),'mm/dd/yyyy') />
<cfset variables.AvailableTime = 0 />
<cfset variables.ServiceTime = 0 />
<cfset session.Company_Name_Customr ="">
<cfset variables.code = "">
<cfset session.ucode = "">

<cfif structKeyExists(url, "ucode") and len(trim(url.ucode))>
   <cfset variables.code = url.ucode>
   <cfset session.ucode = url.ucode>
</cfif>

<cfquery name="getDetailsId" datasource="#request.dsn#">
   SELECT 
      professional.Professional_ID
      ,Locations.Location_ID
      ,Professionals_Services.Service_ID
      ,Companies.Company_ID,Companies.Company_Name,Companies.appointment_code

   FROM [Companies] AS Companies INNER JOIN [Locations] AS Locations
   ON Locations.Company_ID = Companies.Company_ID

   INNER JOIN [Professionals] AS professional
   ON professional.Location_ID = Locations.Location_ID

   INNER JOIN [Professionals_Services] AS Professionals_Services
   ON Professionals_Services.Professional_ID = professional.Professional_ID

   WHERE Companies.appointment_code = '#variables.code#'
</cfquery>

<!--- <cfdump var="#getDetailsId#" /> --->
<cfif structKeyExists(getDetailsId, "recordcount") and getDetailsId.recordcount>
   <!--- <cfset variables.ServiceID = getDetailsId.SERVICE_ID> --->
   <!--- <cfset variables.companyid = getDetailsId.COMPANY_ID> --->
   <cfset variables.Professional_ID = getDetailsId.PROFESSIONAL_ID>
   <cfset variables.locationid = getDetailsId.LOCATION_ID>
   <cfif len(trim(getDetailsId.Company_Name))>
      <cfset session.Company_Name_Customr = getDetailsId.Company_Name>
   </cfif>
</cfif>

<cfif structKeyExists(form, 'submitType') AND Len(form.submitType) AND structKeyExists(form, 'availableDate') AND Len(form.availableDate) >
   <cfset variables.objCFC =  createObject("component","admin.appointmentsCalendarBean") />
   <cfset variables.Professional_ID = form.selProfessional />
   <cfset variables.ServiceID = form.selService />
   <cfset variables.AvailableDate = form.availableDate />
   <cfset variables.AvailableTime = form.selAvailableTimes />
   <cfset variables.ServiceTime = form.serviceTime />
   
   <cfif form.submitType EQ "Register">
      <!--- register and login --->
      <cfset variables.results = variables.objCFC.registerCustomer(form.emailAddress, form.pw, form.firstName, form.lastName, form.ph) />
      <cfif Not variables.results.Success>
         <cfset variables.blnFailed = true />
         <cfset variables.FailedMsg = variables.results.FailedMsg />
      </cfif>
   <cfelseif form.submitType EQ "Login">
      <!--- login --->
      <cfset variables.results = variables.objCFC.loginCustomer(form.emailAddress, form.pw) />
      <cfif Not variables.results.Success>
         <cfset variables.blnFailed = true />
         <cfset variables.FailedMsg = variables.results.FailedMsg />
      </cfif>      
   </cfif>
   
   <!--- If after register or login above then book ---> 
   <cfif form.submitType EQ "Book" Or (Not variables.blnFailed)>
      <cfset variables.AppointmentStartTime = ParseDateTime(form.availableDate & " " & form.selAvailableTimes) />
      <cfset variables.AppointmentEndTime = DateAdd("n", form.serviceTime, variables.AppointmentStartTime) />
      <cfif form.changeAppointmentID GT 0>
         <cfset variables.qryOldAppointment = variables.objCFC.getBookAppointment(form.changeAppointmentID) />
      </cfif>         
      <cfset variables.results = variables.objCFC.bookAppointment(
                                                   CustomerID = Session.CustomerID,
                                                   Professional_ID = form.selProfessional,
                                                   ServiceID = form.selService,
                                                   StartDateTime = variables.AppointmentStartTime,
                                                   EndDateTime = variables.AppointmentEndTime,
                                                   ChangeAppointmentID = form.changeAppointmentID
                                                   ) />
      <cfif Not variables.results.Success>
         <cfset variables.blnFailed = true />
         <cfset variables.FailedMsg = variables.results.FailedMsg />
      <cfelse>
         <cfset variables.blnShowBooking = true />
         <cfset variables.qryResults = variables.results.qryResults />
         <cfset variables.AppointmentID = variables.qryResults.Appointment_ID />
         <!--- Email Customer #variables.qryResults.CustomerEmail#--->
         <cfmail from="no-reply@salonworks.com" server="smtp-relay.sendinblue.com" port="587" To="#variables.qryResults.CustomerEmail#" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" replyto="no-reply@salonworks.com" Subject="Appointment" type="html">
            <html>
               <body>
                  <p>#variables.qryResults.CustomerName#,</p>
                  <p>
                     Appointment Details: <strong>#form.serviceDesc#</strong><br />
                     Date: <strong>#DateFormat(variables.AppointmentStartTime,"long")#</strong><br />
                     Time: <strong>#TimeFormat(variables.AppointmentStartTime,"medium")#</strong><br />
                     Stylist: <strong>#variables.qryResults.ProfessionalName#</strong><br />
                     Location: <strong>#variables.qryResults.Location_Name# (ph: #variables.qryResults.Location_Phone#)</strong> <br />
                     Address: <strong>#variables.qryResults.LocationDesc#</strong>
                  </p>                  
                  <p><br /></p>
                  <p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IS NOT MONITORED--</em></p>
               </body>      
            </html> 
         </cfmail>

         <!--- Email Previous Appointment Professional --->
         <cfif form.changeAppointmentID GT 0>
            <cfmail from="no-reply@salonworks.com" server="smtp-relay.sendinblue.com" port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" To="#variables.qryOldAppointment.Email_Address#" replyto="no-reply@salonworks.com" Subject="Appointment Cancellation" type="html">
               <html>
                  <body>
                     <p>#variables.qryOldAppointment.First_Name# #variables.qryOldAppointment.Last_Name#,</p>
                     <p>The following appointment has been cancelled. </p>
                     <p>
                        Appointment Details: <strong>#variables.qryOldAppointment.Service_Name#</strong><br />
                        Date: <strong>#DateFormat(variables.qryOldAppointment.Start_Time,"long")#</strong><br />
                        Time: <strong>#TimeFormat(variables.qryOldAppointment.End_Time,"medium")#</strong><br />
                        Location: <strong>#variables.qryOldAppointment.Location_Name#</strong> <br />
                        Address: <strong>
                              #variables.qryOldAppointment.Location_Address# 
                              #variables.qryOldAppointment.Location_Address2# <br />
                              #variables.qryOldAppointment.Location_City# 
                                    #variables.qryOldAppointment.Location_State#
                              #variables.qryOldAppointment.Location_Postal#
                              </strong>
                     </p>                    
                     <p><br /></p>
                     <p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IT NOT MONITORED--</em></p>
                  </body>      
               </html> 
            </cfmail>
         </cfif>
                  
         <cfif Len(variables.qryResults.ProfessionalEmail)>
            <!--- Email Professional To="#variables.qryResults.ProfessionalEmail#"--->
            <cfmail from="salonworks@salonworks.com"server="smtp-relay.sendinblue.com"port="587" username="ciredrofdarb@gmail.com" password="2xf5ZLbMdyDr0VSv" To="#variables.qryResults.ProfessionalEmail#"  replyto="no-reply@salonworks.com" Subject="Appointment Notification" type="html">
               <html>
                  <body>
                     <p>#variables.qryResults.ProfessionalName#,</p>
                     <p>
                        Appointment Details: <strong>#form.serviceDesc#</strong><br />
                        Date: <strong>#DateFormat(variables.AppointmentStartTime,"long")#</strong><br />
                        Time: <strong>#TimeFormat(variables.AppointmentStartTime,"medium")#</strong><br />
                        Customer: <strong>#variables.qryResults.CustomerName# (ph: #variables.qryResults.CustomerPhone#)</strong><br />
                        Location: <strong>#variables.qryResults.Location_Name#</strong> <br />
                        Address: <strong>#variables.qryResults.LocationDesc#</strong>
                     </p>                    
                     <p><br /></p>
                     <p><em>--PLEASE DO NOT REPLY TO THIS EMAIL.  THIS EMAIL ACCOUNT IS NOT MONITORED--</em></p>
                  </body>      
               </html> 
            </cfmail>               
         </cfif>
         <cfset variables.ServiceID = 0 />
      </cfif>
   </cfif> 
</cfif>

<cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
   <cfinvokeargument name="appointment_code" value="#variables.code#">
</cfinvoke>
<!--- <cfdump var="#qCompany#" /> --->
<cfif qCompany.recordcount gt 0 AND len(qCompany.Web_Address)>
   <cfset variables.Company_ID=qCompany.Company_ID>
<cfelse>
  <cfset variables.Company_ID=0>
</cfif>

<cfif variables.Company_ID eq 0>
   <cfinclude template="site_header.cfm">
   <style type="text/css">
      input.error,label.error {
      color:#FF0000;
      }
   </style>
   <div class="col-md-12 bg-trms">
       <h2>MAKE AN APPOINTMENT</h2>
   </div>  
   <div class="col-md-12 p-0 sldr-otr ">
   <form id="frmDefault" name="frmDefault" class="form " role="form"> 
      <input type="hidden" id="pw" name="pw"   />
      <!--- <input type="password" id="pw" name="pw"  hidden="true"  /> --->
      <input type="hidden" id="emailAddress" name="emailAddress"  />
      <input type="hidden" id="firstName" name="firstName"  />
      <input type="hidden" id="lastName" name="lastName"  />
      <input type="hidden" id="ph" name="ph" />
      <input type="hidden" id="availableDate" name="availableDate" />
      <input type="hidden" id="serviceTime" name="serviceTime" />
      <input type="hidden" id="serviceDesc" name="serviceDesc" />
      <input type="hidden" id="submitType" name="submitType" />
      <input type="hidden" id="changeAppointmentID" name="changeAppointmentID" value="0" />
      <div class="col-md-12 container-secn-trm mx-auto book-apnt">
         <div class="row">        
            <div class="col-md-8 form-dtl" style="margin-left: 169px;">
               <h3>BOOK YOUR NEXT APPOINTMENT ONLINE</h3>
               <div class="col-sm-12 p-0 txt-frm">
                     <label>Choose Professional</label>
                     <div class="input-holder">
                     <select id="selProfessional" name="selProfessional" class="form-control" onChange="fnProfessionalChange()">
                     </select>
                  </div>
               </div> 
               <div class="col-sm-12 p-0 txt-frm">
                  <label>Select your service</label>
                  <div class="input-holder">
                     <select id="selService" name="selService" class="form-control" onChange="fnServicesChange()">
                        <option value="0">Select Your Service</option>
                     </select>
                  </div>
               </div>  
               <div class="col-sm-12 p-0 txt-frm">
                  <label>Choose Date</label>
                  <div class="input-holder">
                     <input type="text" id="cdrAvailable" name="cdrAvailable" class="form-control" 
                        readonly="true" disabled="true" style="width: 97%; float:left;" />
                  </div>
               </div> 
               <div class="col-sm-12 p-0 txt-frm">
                  <label>Available Time Slots</label>
                  <div class="input-holder">
                     <select id="selAvailableTimes" name="selAvailableTimes" disabled="true" class="form-control">
                        <option value="0">Available Time Slots</option> 
                     </select>
                  </div>
               </div>  
               <div class="col-sm-12 p-0 txt-frm-btn" id="actionAppointment">
                  <button id="btnMakeAppointment" type="button" class="btn btn-danger frms-btn">Make an Appointment</button>
               </div> 
                  <div id="msgAppointment" class="alert">&nbsp;</div>  
               </a>       
            </div>
         </div>
      </div> 
   </form>
   <cfinclude template="site_footer.cfm">
<cfelse>
   <!--- <cfinclude template="./customer_sites/index.cfm"> --->
  <cflocation url="http://#qCompany.Web_Address#.salonworks.com" addtoken="false" >
</cfif>


<!-- The Modal login -->
<div class="modal fade loginModal modalLoginn" id="modalLoginn">
   <div class="modal-dialog">
      <div class="modal-content">
      <!-- Modal Header -->
         <!-- Modal body -->
         <div class="modal-body">
           <button type="button" class="close" data-dismiss="modal" id="logClose">&times;</button>
           <h4 class="modal-title">Log In</h4>
            <form name="frmSignin" id="frmSignin" role="form" class="form-horizontal" action="#">
               <div class="form-group">
                  <input type="email" class="form-control" placeholder="Email Id" name="emailAddress">
               </div>
               <div class="form-group">
                  <input type="password" class="form-control"  placeholder="Password" name="pw">
               </div>
             <button type="button" class="btn btn-block btn-primary btnSignin" >Log In</button>
            </form>
         </div>
         <div id="signin-msg" class="alert"></div>
         <!-- Modal footer -->
         <div class="modal-footer">
           <p>
               Don't have an account? <br>
               <a data-dismiss="modal"  class="a_register">Sign up Now!</a>
           </p>
         </div>
      </div>
   </div>
</div>
<!-- The Modal Register -->
<div class="modal fade loginModal" id="registerModal">
  <div class="modal-dialog">
      <div class="modal-content">
         <!-- Modal Header -->
         <!-- Modal body -->
         <div class="modal-body">
           <button type="button" class="close" data-dismiss="modal" id="regClose">&times;</button>
           <h4 class="modal-title">Sign Up</h4>

            <form name="frmRegister" id="frmRegister" role="form" action="#">
               <div class="form-group">
                  <input type="email" class="form-control" placeholder="Email Id" name="emailAddress">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="First Name" name="firstName">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="Last Name" name="lastName">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="Phone" name="ph">
                  <div class="col-md-12 p-0 exm">
                    Example: 512-753-0000
                  </div>
               </div>
               <div class="form-group">
                  <input type="password" class="form-control" name="pw" placeholder="Password">
               </div>
               <button type="button" class="btn btn-block btn-primary" id="btnRegister">Log In</button>
            </form>
         </div>
         <div id="register-msg" class="alert"></div>
         <!-- Modal footer -->
         <div class="modal-footer">
            <p>
               Already User? <br>

               <a data-dismiss="modal" class="a_signin">Login Now!</a>
            </p>
         </div>
      </div>
   </div>
</div>
<!-- script  -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="js/error_messages.js"></script>
<script type="text/javascript">   
   <cfoutput>
      var pageLoaded = false;
      var str = "#variables.company_phone#";
      var company_phone = str.replace(/ +/g, "");
      console.log(company_phone);
      
      var availableDates = [];
      var customerID = 0;
      var pid = #variables.Professional_ID#;
      var ucode = "#session.ucode#" ;
   </cfoutput>
   
   <cfwddx action="cfml2js" input="#variables.locationid#" toplevelvariable="Location_ID" />
   <cfwddx action="cfml2js" input="#variables.Professional_ID#" toplevelvariable="Professional_ID" />
   <cfwddx action="cfml2js" input="#variables.ServiceID#" toplevelvariable="ServiceID" />
   <cfwddx action="cfml2js" input="#variables.companyid#" toplevelvariable="company_id" />
   <cfwddx action="cfml2js" input="#variables.blnFailed#" toplevelvariable="blnFailed" />
   <cfwddx action="cfml2js" input="#DateFormat(Now(),'mm/dd/yyyy')#" toplevelvariable="minDate" />
   <cfwddx action="cfml2js" input="#DatePart("m",Now())#" toplevelvariable="minMonth" />
   <cfwddx action="cfml2js" input="#DatePart("yyyy",Now())#" toplevelvariable="minYear" />
   <cfwddx action="cfml2js" input="#variables.AvailableDate#" toplevelvariable="pickedDate" />
   <cfwddx action="cfml2js" input="#variables.AvailableTime#" toplevelvariable="availableTime" />
   <cfwddx action="cfml2js" input="#DatePart("yyyy",Now())#" toplevelvariable="minYear" />

   <cfif structKeyExists(session, 'customerID') AND session.customerID GT 0>
      <cfwddx action="cfml2js" input="#session.customerID#" toplevelvariable="customerID" />
   </cfif>

   fnRegister = function(){
      var $regform = $("#frmRegister");
      $regform.validate();
      if( !$regform.valid() )
         return false;
      $.ajax({
            type: "post",
            url: "cfc/customers.cfc?method=registerCustomer&returnFormat=JSON&companyId="+company_id,
            data: $regform.serialize(),
            dataType: "json",
            success: function (rs){
               $('#register-msg').show();
               if ( rs.SUCCESS == true ) {
                  $('#register-msg').addClass('alert-success');
                  $('#register-msg').html('You have successfully registered as a customer!');
                  window.location.href="/appointment_code.cfm?ucode="+ucode;
               }
               else {
                  $('#register-msg').addClass('alert-error');
                  $('#register-msg').html(rs.FAILEDMSG);
               }
            }
      });
   }
   
   fnBookAppointment = function(){
      $("#pw").val('');
      $("#emailAddress").val('');
      $("#firstName").val('');
      $("#lastName").val('');
      $("#ph").val('');
      $("#availableDate").val($("#cdrAvailable").val());
      $("#serviceTime").val($("#selService option:selected").attr("time"));
      $("#serviceDesc").val($("#selService option:selected").text());
      $.ajax({
            type: "POST",
            url: "admin/appointmentsCalendarBean.cfc",
            data: {
               method: "bookAppointment",
               CustomerID:  customerID,
               Professional_ID: $("#selProfessional").val(),
               ServiceID: $("#selService option:selected").val(),
               //StartDateTime: $("#AppointmentStartTime").val(),
               //EndDateTime: $("#AppointmentEndTime").val(),
               AppointmentStartDate: $('#availableDate').val(),
               AppointmentStartTime: $('#selAvailableTimes').val(),
               serviceTime: $("#selService option:selected").attr("time"),
               
               ChangeAppointmentID: $("#changeAppointmentID").val()
            },
            dataType: "json",
            success: function (rs){
               console.log(rs);
               if( rs.SUCCESS == true ) {
               $('#btnMakeAppointment').hide();
               $('#modalLoginn').modal('hide');
                  $('#msgAppointment').addClass('alert-success');
                  $('#msgAppointment').html('An apppointment was successfully booked.');
                  $('.alert-success').fadeIn(100);
                  $('#frmDefault')[0].reset();
                  $('.alert-success').fadeOut(8000);
                  $("#cdrAvailable").val("Choose Date");
                  return false;
               }
               else {
                  console.log(rs);
                  $('#msgAppointment').addClass('alert-danger');
                  $('#msgAppointment').html(rs.FAILEDMSG);
               }
            },
            error: function (rs){
               console.log(rs);
               $('#msgAppointment').addClass('alert-danger');
               $('#msgAppointment').html(rs);
            }
      }); 
   }  
      
   monthChanged = function(year, month, instance) {

      if($("#selProfessional").val() != null){
         fnGetAvailableDates(month, year, true);
      }
   }

   isAvailable = function(date){

      var dateAsString = (date.getMonth()+1).toString() + "/" + date.getDate() + "/" + date.getFullYear().toString();
      var result = (availableDates.length && $.inArray(dateAsString, availableDates) > -1) ? [true] : [false];
      return result;    
   }
   
   fnProfessionalChange = function(){
      var Professional_ID = parseInt($("#selProfessional").val());
      var serviceId = parseInt($("#selService").val());
      if(serviceId == 0) fnLoadServices(Professional_ID);
      if(Professional_ID == 0){
         $("#selService").find('option').remove();
         $("#selService").append($("<option></option>").attr("value",0).text("Select Your Service"));
      }
      if(Professional_ID && serviceId){
         fnGetAvailableDates(minMonth, minYear, false);
         $("#selAvailableTimes").removeAttr("disabled"); 
      }
      else if(!(Professional_ID && serviceId)){
         fnClearAvailableDateTimes();     
      }  
   }

   fnServicesChange = function(){
      var Professional_ID = parseInt($("#selProfessional").val());
      var serviceId = parseInt($("#selService").val());      
      if(Professional_ID == 0) fnLoadProfessionals(serviceId);      
      //alert('Professional_ID = ' + Professional_ID + '    serviceId = ' + serviceId);
      if(Professional_ID && serviceId){
         fnGetAvailableDates(minMonth, minYear, false);
         $("#selAvailableTimes").removeAttr("disabled");          
      }
      else if(!(Professional_ID && serviceId)){
         fnClearAvailableDateTimes();
      }     
   }
   
   fnClearAvailableDateTimes = function(){
      $("#cdrAvailable").val("Choose Date");
      availableDates = [];      
      $("#selAvailableTimes").find('option').remove();
      $("#selAvailableTimes").append($("<option></option>").attr("value",0).text('Available Time Slots'));  
      $("#selAvailableTimes").attr("disabled", "true");      
      //$("#btnMakeAppointment").hide();
      $("#actionAppointment").hide();
   }

   fnLoadInitialDropDowns = function(Professional_ID, serviceId){
      $.ajax({
         type: "get",
         url: "admin/appointmentsCalendarBean.cfc",
         data: {
            method: "getProfessionalsListByService",
            Location_ID: Location_ID,
            ServiceID: serviceId, 
            noCache: new Date().getTime()
         },
         dataType: "json",
         returnFormat: "json",
         success: function (rs){
            $("#selProfessional").find('option').remove();
            $("#selProfessional").append($("<option></option>").attr("value",0).text('Choose Professional')); 
            console.log(rs.DATA);
            if(rs.DATA.length){
               for (var i = 0; i < rs.DATA.length; i++) {
                  $("#selProfessional").append($("<option></option>").attr("value",rs.DATA[i].PROFESSIONAL_ID).text(rs.DATA[i].LAST_NAME + ', ' + rs.DATA[i].FIRST_NAME)); 
               }

               $.ajax({
                  type: "get",
                  url: "admin/appointmentsCalendarBean.cfc",
                  data: {
                     method: "getServicesListByProfessional",
                     Location_ID: Location_ID,
                     Professional_ID: Professional_ID, 
                     noCache: new Date().getTime()
                     },
                  dataType: "json",
                  returnFormat: "json",
                  success: function (rs){
                     // Populate Professional List based on Service selection
                     // var options = '<option value="0">Select Your Service</option>';              
                     console.log(rs);
                     if(rs.DATA.length){                         
                        for (var i = 0; i < rs.DATA.length; i++) {  
                           $("#selService").append($("<option time="+ rs.DATA[i].SERVICE_TIME +"></option>").attr("value",rs.DATA[i].SERVICE_ID).text(rs.DATA[i].SERVICE_NAME));                         
                           // options += '<option time="'+ rs.DATA[i].SERVICE_TIME + '" value="' + rs.DATA[i].SERVICE_ID + '">' + rs.DATA[i].SERVICE_NAME + '</option>';
                        }                       
                     }        
                     else{
                        // options = '<option value="0">No Services Found</option>';  
                        $("#selService").append($("<option></option>").attr("value",0).text("No Services Found"));     
                     }     
                     // $("#selService").html(options);
                     $("#selProfessional").val(Professional_ID);                     
                     // $("#selService").val(serviceId);
                     // console.log(options);    
                     if(Professional_ID && serviceId){
                        var serviceTime = $("#selService option:selected").attr("time");
                        console.log(serviceTime);
                        console.log(minMonth);
                        console.log(minYear);
                        if ( serviceTime != undefined ) {
                           $.ajax("admin/appointmentsCalendarBean.cfc", {
                              // send a GET HTTP operation
                              type: "get",
                              dataType: "json",
                              returnFormat:'json',
                              data: {
                                 method: "getAvailableDatesArray",
                                 Location_ID: Location_ID,
                                 ServiceID: serviceId,
                                 Professional_ID: Professional_ID,
                                 ServiceTime: serviceTime,
                                 Month: minMonth,
                                 Year: minYear, 
                                 noCache: new Date().getTime()
                              },
                              success: function (rs){
                                 availableDates = rs.slice(0);
                                 
                                 $('#cdrAvailable').datepicker("refresh");
                                 $("#cdrAvailable").datepicker("setDate" , pickedDate);
                                 $("#cdrAvailable").removeAttr("disabled");
                                 console.log(pickedDate);        
                                                
                                 $.ajax("admin/appointmentsCalendarBean.cfc", {
                                    type: "get",
                                    dataType: "json",
                                    returnFormat:'json',
                                    data: {
                                       method: "getAvailableSlots",
                                       Professional_ID: Professional_ID,
                                       ServiceID: serviceId,
                                       AppointmentDate: pickedDate,
                                       ServiceTime: serviceTime, 
                                       noCache: new Date().getTime()
                                    },
                                    success: function (rs){
                                       $("#selAvailableTimes").find('option').remove();
                                       console.log(rs);
                                          if(rs.DATA.length){
                                             $("#btnMakeAppointment").show();
                     
                                             $("#selAvailableTimes").append($("<option></option>").attr("value",0).text(' Available Time Slots')); 
                                             for (var i = 0; i < rs.DATA.length; i++) {
                                                $("#selAvailableTimes").append($("<option></option>").attr("value", rs.DATA[i]).text(rs.DATA[i])); 
                                             }
                                       }        
                                       else{
                                          $("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots')); 
                                          $("#btnMakeAppointment").hide(); 
                                       }  
                                       
                                       $("#selAvailableTimes").removeAttr("disabled");
                                       $("#selAvailableTimes").val(availableTime);
                              
                                    },
                                    error: function (xhr, textStatus, errorThrown){
                                       alert("error: "   + errorThrown);
                                    }
                                 }); 
                              },
                              error: function (xhr, textStatus, errorThrown){
                                 alert("error: "   + errorThrown);
                              }
                           });
                        } //if ( serviceTime != undefined ) {                                
                     }
            
                     if(!pageLoaded){
                        $('#loading').fadeOut(3000);
                        pageLoaded = true;
                     }                       
                  },
                  error: function (xhr, textStatus, errorThrown){
                           alert("error LoadServices: "   + errorThrown);
                  }
               });                     
            }        
            else{
               $('.msgcontent').html("We're sorry, but Online Booking is not currently configured on our site. Please call " +company_phone+ " to book your appointment."); 
               /*$("#selProfessional").find('option').remove();
               $("#selProfessional").append($("<option></option>").attr("value",0).text('No Professional Found')); */
               $('#loading').fadeOut(3000);
               pageLoaded = true;   
            }                          
         },
         error: function (xhr, textStatus, errorThrown){
                  alert("error LoadProfessionals: "   + errorThrown);
         }
      });            
   }  
   
   fnLoadProfessionals = function(serviceId){

      $.ajax({
         type: "get",
         url: "admin/appointmentsCalendarBean.cfc",
         data: {
            method: "getProfessionalsListByService",
            Location_ID: Location_ID,
            ServiceID: serviceId, 
            noCache: new Date().getTime()
            },
         dataType: "json",
         returnFormat: "json",
         success: function (rs){
                  $("#selProfessional").find('option').remove();
                  $("#selProfessional").append($("<option></option>").attr("value",0).text('Choose Professional')); 
                     if(rs.DATA.length){
                     for (var i = 0; i < rs.DATA.length; i++) {
                        $("#selProfessional").append($("<option></option>").attr("value",rs.DATA[i].PROFESSIONAL_ID).text(rs.DATA[i].LAST_NAME + ', ' + rs.DATA[i].FIRST_NAME)); 
                     }
                  }        
                  else{
                     $("#selProfessional").append($("<option></option>").attr("value",0).text('No Professional Found'));   
                  }                          
               },
 
         error: function (xhr, textStatus, errorThrown){
                  alert("error LoadProfessionals: "   + errorThrown);
         }
      });         
   }
   
   fnLoadServices = function (Professional_ID){
      $.ajax({
         type: "get",
         url: "admin/appointmentsCalendarBean.cfc",
         data: {
            method: "getServicesListByProfessional",
            Location_ID: Location_ID,
            Professional_ID: Professional_ID, 
            noCache: new Date().getTime()
            },
         dataType: "json",
         returnFormat: "json",
         success: function (rs){
            // Populate Professional List based on Service selection
            // var options = '<option value="0">Select Your Service</option>';
            $("#selService").find('option').remove();
            $("#selService").append($("<option></option>").attr("value",0).text("Select Your Service"));
            if(rs.DATA.length){                         
               for (var i = 0; i < rs.DATA.length; i++) {  
                  $("#selService").append($("<option time="+ rs.DATA[i].SERVICE_TIME +"></option>").attr("value",rs.DATA[i].SERVICE_ID).text(rs.DATA[i].SERVICE_NAME));                         
                  // options += '<option time="'+ rs.DATA[i].SERVICE_TIME + '" value="' + rs.DATA[i].SERVICE_ID + '">' + rs.DATA[i].SERVICE_NAME + '</option>';
               }                       
            }        
            else{
               // options = '<option value="0">No Services Found</option>';  
            $("#selService").append($("<option></option>").attr("value",0).text("No Services Found"));     
            }     
            // $("#selService").html(options);            
            if(!pageLoaded){
               $('#loading').fadeOut(3000);
               pageLoaded = true;
            }                       
         },
         error: function (xhr, textStatus, errorThrown){
            alert("error LoadServices: "   + errorThrown);
         }
      });   
   }

   fnGetAvailableDates = function(month, year, isMonthChange){
      var serviceTime = $("#selService option:selected").attr("time");
      var serviceId = $("#selService").val();
      var Professional_ID = $("#selProfessional").val();      
      if ( serviceTime != undefined ) {
         $.ajax("admin/appointmentsCalendarBean.cfc", {
            // send a GET HTTP operation
            type: "get",
            dataType: "json",
            returnFormat:'json',
            data: {
                  method: "getAvailableDatesArray",
                  Location_ID: Location_ID,
                  ServiceID: serviceId,
                  Professional_ID: Professional_ID,
                  ServiceTime: serviceTime,
                  Month: month,
                  Year: year, 
                  noCache: new Date().getTime()
            },
            success: function (rs){
                  availableDates = rs.slice(0);
                  if(!isMonthChange){
                     $("#cdrAvailable").datepicker("setDate" , availableDates[0]);
                     /*bs datetimepicker                    
                      $('#cdrAvailable').data("DateTimePicker").setDate(availableDates[0]); */                     
                     fnLoadAvailableTimes(Professional_ID, serviceId, availableDates[0], serviceTime);
                  }
                  $('#cdrAvailable').datepicker("refresh");
            },
            error: function (xhr, textStatus, errorThrown){
                  alert("error: "   + errorThrown);
            }
         }); 
      }
   }
   
   fnLoadAvailableTimes = function(Professional_ID, serviceId, selectedDate, serviceTime){
      $("#selAvailableTimes").find('option').remove();
      if(selectedDate == undefined){
         $("#btnMakeAppointment").hide();
         $("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots'));
      } 
      else{
         if (serviceTime != undefined) {
            $.ajax("admin/appointmentsCalendarBean.cfc", {
                  type: "get",
                  dataType: "json",
                  returnFormat:'json',
                  data: {
                        method: "getAvailableSlots",
                        Professional_ID: Professional_ID,
                        ServiceID: serviceId,
                        AppointmentDate: selectedDate,
                        ServiceTime: serviceTime, 
                        noCache: new Date().getTime()
                  },
                  success: function (rs){
                           if(rs.DATA.length){
                              $("#btnMakeAppointment").show();
                           $("#selAvailableTimes").append($("<option></option>").attr("value",0).text('Available Time Slots'));
                           
                           for (var i = 0; i < rs.DATA.length; i++) {
                              $("#selAvailableTimes").append($("<option></option>").attr("value", rs.DATA[i]).text(rs.DATA[i])); 
                           }
                        }        
                        else{
                           $("#selAvailableTimes").append($("<option></option>").attr("value",0).text('No Available Time Slots')); 
                           $("#btnMakeAppointment").hide(); 
                        }  
                  },
                  error: function (xhr, textStatus, errorThrown){
                        alert("error: "   + errorThrown);
                  }
            }); 
         }
      }
   };
   
   $(document).ready(function() {      
      $('#modalLoad').modal('hide');
      $('#actionAppointment').hide();
      $('#username_code').html('');
      $('#selAvailableTimes').change(function(){
         if( $(this).val() != 0)
            $('#actionAppointment').show();
         else
            $('#actionAppointment').hide();
      });     

      $("#cdrAvailable").datepicker({
         numberOfMonths: 2,
         showOn: "button",
         buttonImage: "images/calendar.png",
         buttonImageOnly: true,
         onChangeMonthYear : monthChanged, 
         beforeShowDay: isAvailable,
         onSelect: function(dateText) {
                  var serviceTime = $("#selService option:selected").attr("time");
                  var serviceId = $("#selService").val();
                  var Professional_ID = $("#selProfessional").val();
                  fnLoadAvailableTimes(Professional_ID, serviceId, this.value, serviceTime);
         }
      });

      // $("#cdrAvailable").datepicker("setDate" , pickedDate);
      $("#cdrAvailable").datepicker("option", "minDate" , minDate);
      $("#cdrAvailable").val("Choose Date");
           
      $("#btnMakeAppointment").button({
         icons: { primary: "ui-icon-calendar"},
         text: true
      });  

      $("#btnMakeAppointment").click(function() {

         <!--- Customer is not logged in --->
         console.log(customerID);
        /* customerID = 0;*/
         if(customerID == 0){
            //$("#dlgRegisterLogin").dialog("open");
            $('#frmSignin')[0].reset();
            $('#signin-msg').hide();
            $('#modalLoginn').modal('show');
            //$("#registerModal").modal('show');
         } 
         else{
            $('#modalLoginn').modal('hide');
            fnBookAppointment();
         }
      });

      $("#frmLogIn").validate({
           rules:{
               loginEmail:{required: true, email: true},
               loginPassword:{required: true}
           }
       });      
         
      $("#frmSignup").validate({
           rules:{
               registerEmail:{required: true, email: true},
               registerFirstName:{required: true},
               registerLastName:{required: true},
               registerPhone:{required: true},
               registerPassword:{required: true} 
           }
       });

      $('#logClose').click(function() {
         validatorLog.resetForm();
      });

      $('#regClose').click(function() {
         validatorReg.resetForm();
      });

      var validatorReg = $("#frmRegister").validate({
           rules:{
               emailAddress:{required: true, email: true},
               firstName:{required: true},
               lastName:{required: true},
               ph:{required: true,phoneUs:true},
               pw:{required: true} 
           }
       });

        var validatorLog = $("#frmSignin").validate({
           rules:{
               emailAddress:{required: true, email: true},
               pw:{required: true}
           }
       }); 

      $("#btnLogin").button({
         icons: {
            primary: "ui-icon-play"
         },
         text: true
      });   
      
      fnLoadInitialDropDowns(Professional_ID, ServiceID);

      if ( !blnFailed )
         $("#btnMakeAppointment").hide();

      // For registration and login to customer site
      $('.a_signin').on('click' ,function(){
         validatorReg.resetForm();
         $('#frmSignin')[0].reset();
         $('#modalLoginn').modal('show');
         $('#signin-msg').hide();
      });
   
      $('#a_signout').on('click' ,function(){
         $.ajax({
            type: "get",
            url: "cfc/customers.cfc?method=logoutCustomer",
            dataType: "html",
            success: function (data){
               $('#sign-in').removeClass('hidden');
               $('#profile-menu').addClass('hidden');
               $('.user-email').html('');
               $('.user-name').html('');
               $('#username_code').html('');
               window.location.href='/appointment_code.cfm?ucode='+ucode;
            }
         });
      });
   
      $('.btnSignin').on('click', function() {
         var $frmSignin = $('#frmSignin');
          $frmSignin.validate();
         if( !$frmSignin.valid() )
            return false;

         $.ajax({
            type: "get",
            url: "cfc/customers.cfc?method=loginCustomer",
            data: $frmSignin.serialize(),
            dataType: "json",
            success: function (data){
               if (data.SUCCESS == true) {
                  $('#sign-in').addClass('hidden');
                  $('#profile-menu').removeClass('hidden');
                  $('.user-email').html(data.EMAIL_ADDRESS);
                  $('.user-name').html(data.NAME);
                   $('#username_code').html(data.NAME);
                  $('#modalLoginn').modal('hide');               
                  //refresh page
                     window.location.href = "/appointment_code.cfm?ucode="+ucode;
               }
               else {
                  $('#signin-msg').show();
                  $('#signin-msg').addClass('alert-danger');
                  $('#signin-msg').html(data.FAILEDMSG);
               }
            }, 
            error: function (data){
               console.log(data);
               $('#signin-msg').show();
               $('#signin-msg').addClass('alert-danger');
               $('#signin-msg').html('Exception occured!');
            }
         });
      });
      
      $('#btnRegister').on('click', function() {
         /*var company_id = $('#qCompanyId').val();*/
         var $regform = $("#frmRegister");
         $regform.validate();
         if( !$regform.valid() )
            return false;
         
         $.ajax({
            type: "post",
            url: "cfc/customers.cfc?method=registerCustomer&returnFormat=JSON&companyId="+company_id+"&Professional_ID="+Professional_ID,
            data: $regform.serialize(),
            dataType: "json",
            success: function (rs){
               $('#register-msg').show();
               if ( rs.SUCCESS == true ) {
                  $('#register-msg').addClass('alert-success');
                  $('#register-msg').html('You have successfully registered as a customer!');
                     $('#modalLoginn').fadeOut(8000);
                  /*window.location.href='/appointment_code.cfm?ucode='+ucode;*/
               }
               else {
                  $('#register-msg').addClass('alert-error');
                  $('#register-msg').html(rs.FAILEDMSG);
               }
            }
         });
      });
   
      $('.a_register').on('click', function() {
         validatorLog.resetForm();
         $('#modalLoginn').modal('hide');
         if ( $('#frmRegister') )
            $('#frmRegister')[0].reset();
         $('#register-msg').hide();
         $("#registerModal").modal('show');
      });
   });      
</script>

