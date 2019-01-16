<!DOCTYPE html>
<cfquery name="getPlan" datasource="#request.dsn#">
   SELECT 
   Company_Service_Plan_ID
   FROM
   Company_Prices
   WHERE
   Company_ID=
   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="getTrialExpiration" datasource="#request.dsn#">
   SELECT top 1
   Trial_Expiration,subscriptionId, subscription_status
   FROM
   Companies
   WHERE
   Company_ID=
   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfparam name="variables.company_id" default="#session.company_id#">
<!--- added --->
<cfparam name="variables.location_id" default="#session.location_id#">
<!---  --->
<cfinvoke component="company" method="getCompany" returnvariable="qCompany">
   <cfinvokeargument name="Company_ID" value="#variables.company_id#">
</cfinvoke>
<!--- added --->
<cfinvoke component="location" method="getLocation" returnvariable="qLocation">
   <cfinvokeargument name="Location_ID" value="#variables.location_id#">
   <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke> 
<cfinvoke component="professionals" method="getProfessional" returnvariable="qProfessional">
   <cfinvokeargument name="Location_ID" value="#variables.location_id#">
   <cfinvokeargument name="Company_ID" value="#variables.Company_ID#">
</cfinvoke> 

<cfquery name="getProfessions" datasource="#request.dsn#">
   SELECT pf.Profession_ID,pf.Profession_Name from Professions pf
   INNER JOIN Predefined_Service_Types pst on pf.Profession_ID = pst.Profession_ID 
   GROUP BY pf.Profession_ID,pf.Profession_Name 
   -- SELECT Profession_ID,Profession_Name FROM Professions 
</cfquery>
<cfquery name="getPaymentMethods" datasource="#request.dsn#">
      SELECT Payment_Method_ID, Payment_Method From Payment_Methods Order By Order_By
</cfquery>
<cfquery name="getTimeZones" datasource="#request.dsn#">
   SELECT Time_Zone_ID, Timezone_Location FROM Time_Zones WHERE enabled = 1
</cfquery>

<cfif qLocation.Time_Zone_ID gt 0>
   <cfset variables.TimeZoneID = qLocation.Time_Zone_ID />
<cfelse>
   <!--- Default TO central --->
   <cfset variables.TimeZoneID = 13 />
</cfif>
<cfif DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0 AND (not getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)) and not (len(getTrialExpiration.subscriptionId) gt 1)>
   <cfquery name="updatePlan" datasource="#request.dsn#">
      UPDATE 
         Company_Prices 
      SET
         Company_Service_Plan_ID = 1
      WHERE
         Company_ID=<cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
   </cfquery>
</cfif> 


<!--- <cfif Not IsDefined("Session.Location_ID")>
   <cflocation url="login.cfm" />
   </cfif> --->
<cfparam name="variables.page_title" default="">
<cfoutput>
   <html lang="en">
      <head>
         <meta charset="utf-8" />
         <title>#variables.page_title# - SalonWorks Admin</title>
         <meta name="description" content="overview &amp; stats" />
         <meta name="viewport" content="width=device-width, initial-scale=1.0" />
         <!-- basic styles -->
         <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/> -->
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
         <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
         <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
         <link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.full.min.css" />
         <!--[if IE 7]>
         <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
         <![endif]-->
         <!-- page specific plugin styles -->
         <!-- summernote editor -->
         <link rel="stylesheet" href="assets/css/summernote.css" />
         <link rel="stylesheet" href="assets/css/summernote-bs3.css" />
         <!--- <link rel="stylesheet" href="assets/css/salon-custom.css" /> --->
         <!-- fonts -->
         <link rel="stylesheet" href="assets/css/ace-fonts.css" />
         <!-- ace styles -->
         <link rel="stylesheet" href="assets/css/ace.min.css" />
         <link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
         <link rel="stylesheet" href="assets/css/ace-skins.min.css" />
         <link rel="stylesheet" href="assets/css/fullcalendar.css" />
         <link rel="stylesheet" href="assets/css/style.css" />

         <!--[if lte IE 8]>
         <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
         <![endif]-->
         <!-- inline styles related to this page -->
         <!-- ace settings handler -->
         <script src="assets/js/jquery-1.10.2.min.js"></script>
         <script src="https://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
         <script src="assets/js/jquery.mask.min.js" type="text/javascript"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js" ></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="assets/js/ace-extra.min.js"></script>
         <script src="assets/js/ace-elements.min.js"></script>
        <script src="assets/js/ace.min.js"></script>
         

         <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
         <!--[if lt IE 9]>
         <script src="assets/js/html5shiv.js"></script>
         <script src="assets/js/respond.min.js"></script>
         <![endif]-->
         <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
         <!--- <script type="text/javascript" src="assets/js/common_validations.js"></script> --->
         <script type="text/javascript" src="assets/js/jquery.validate.additional-methods.min.js"></script> 
         <!--- <script type="text/javascript" src="assets/js/timeout.js"></script> --->
         <!--- <link rel="stylesheet" href="/css/new_style.cfm?company_id=#Session.Location_ID#" type="text/css" media="screen,projection" />  --->
         <script src="assets/js/summernote.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.js"></script>
   
         <script src="assets/js/typeahead-bs2.min.js"></script>
         <style type="text/css">
            ##nav-cat{ font-size:12px;}
            body {font-size:12px;}
            textarea.error, input.error {
            border: 1px solid ##FF0000;
            }
            ##professional_form label.error {
            color: ##FF0000;
            margin-left: 10px;
            width: auto;
            display: inline;  
            }
            .address, .city  {
            text-transform:capitalize;
            }
            /*.tpr
         {
             margin-top:45px;
         }*/
            
         </style>
         <!--- modal style --->
         <style>
         .requestwizard-modal{
            background: rgba(255, 255, 255, 0.8);
            box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
         }
         .requestwizard-step p {
             margin-top: 10px;
         }

         .requestwizard-row {
             display: table-row;
         }

         .requestwizard {
             display: table;
             width: 100%;
             position: relative;
         }

         .requestwizard-step button[disabled] {
             opacity: 1 !important;
             filter: alpha(opacity=100) !important;
         }

         .requestwizard-row:before {
             top: 14px;
             bottom: 0;
             position: absolute;
             content: " ";
             width: 100%;
             height: 1px;
             background-color: ##ccc;
             z-order: 0;

         }

         .requestwizard-step {
             display: table-cell;
             text-align: center;
             position: relative;
         }

         .btn-circle {
            width: 30px;
            height: 30px;
            text-align: center;
            padding: 6px 0 6px 0;
            font-size: 12px;
            line-height: .7;
            -webkit-appearance: none !important;
            border-radius: 30px;

         }

         .block {
             display: block;
             width: 100%;
            /* background-color: ##f2f2f2;*/
             color: black;
             padding: 14px 28px;
             font-size: 16px;
             cursor: pointer;
             text-align: center;
         }

         .blockbtn:hover {
             background-color: ##ddd;
             color: black;
         }
         .servicename{
             height: 50px;
             border: 1px solid grey;
             margin-bottom: 8px;
             padding-top: 15px;
             font-weight: bolder;
         }
         .serviceadd{
            display: block;
             position: absolute;
             left: 60%;
             height: 88%;
             width: 28%;
             overflow-y:auto;
             overflow-x:auto;
             border-radius: 0px;
         }
         .addedservicename{
            height: 56px;
             border: 1px solid grey;
             margin-bottom: 8px;
             padding-top: 15px;
             font-weight: bolder;
         }
         .mb-10 {
            margin-bottom: 10px;
         }
         .eachrowBox {

             box-shadow: 1px 1px 5px 1px ##888880;
               padding-bottom: 10px;
             margin-bottom: 5px;
         }
         .day{
            height: 40px;
            background-color: ##e6e6e6;
            margin:0 auto;
            margin-bottom: 5px;
         }
         .texts{
            margin-top: 5px;
         }
         .savebtn{
            margin-top: 20px; 
            padding: 0px 20px; 
            font-size: 14px; 
            border-radius: 5px; 
            line-height: 20px; 
            height: 30px;
         }
         .cstm-fst-log button{
           box-shadow: none;
           background:##428bca;
           color:##fff;
           border: 0;
           margin-bottom: 5px;
            padding: 5px;
         }
         @media only screen and (max-width: 768px) {
            .mbm-10 {
               margin-bottom: 10px;
            }

         }
         @media only screen and (min-width: 769px) {
            .hours{
               width: 508px;
               margin-left: 57px;
               /*width: 576px;
               margin-left: 40px;*/
            }
         }
         </style>
         <!--- modal style ends --->
         <!--Start of Tawk.to Script-->
            <!--Start of Tawk.to Script-->
   <!--- <script type="text/javascript">
   var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
   (function(){
   var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
   s1.async=true;
   s1.src='https://embed.tawk.to/5b97497fc9abba5796776b78/default';
   s1.charset='UTF-8';
   s1.setAttribute('crossorigin','*');
   s0.parentNode.insertBefore(s1,s0);
   })();
   </script> --->
   <!--End of Tawk.to Script-->
         <script>
            isAllowedNavigationKeys = function(code) {
               //backspace    delete         tab      escape    enter         l-arrow        u-arrow     r-arrow     d-arrow
               if (code == 46 || code == 8 || code == 9 || code == 27 || code == 13 || code == 37 || code == 38 || code == 39 || code == 40) {
                  return true;
               } else {
                  return false;
               }
            }
            
            
            keydownAcceptFilterInteger = function(e) {
               e = e || event;
               var code = e.which || event.keyCode;
               //alert(code);
               if (isAllowedNavigationKeys(code)) {
                  //Allow Navigation Keys
               } else if (e.shiftKey || (code < 48 || code > 57 ) && (code < 96 || code > 105 )) {
                  //Allow only numbers from keyboard and pad
            
                  (e.preventDefault) ? e.preventDefault() : e.returnValue = false;
                  return false;
               }
            }
            
            $(document).ready(function(){
               var str = "/admin/company_form.cfm,/admin/professionals_form.cfm,/admin/location_form.cfm";
               if (str.toLowerCase().indexOf(window.location.pathname) >= 0) {
                  $('##profileSection').parent().addClass('open');
                  $('##profileSection').parent().find('.submenu').show();
               }

               var company_id = <cfoutput>#session.company_id#</cfoutput>;
               $.ajax({
               url: "company.cfc?method=updateTrialPlan&showtemplate=false",
               type: 'POST',
               data:{company_id:company_id},
               success: function(data){
                  console.log(data);
                  if(data==1){
                     console.log(1);
                  }
                  else{
                     console.log(0);
                  }
                 
                  
               },
            });
            });
            
            /*
            $(document).ready(function(){
               $(".PhoneFormat").keydown(function(e){keydownAcceptFilterInteger(e);});
               
               $( ".PhoneFormat" ).change(function() {
                  var str = $(this).val().replace("(","").replace(")","").replace("-","");
               
                  if(str.length == 10){
                     var strFinal = "(" + str.substring(0,3) + ")" + str.substring(3,6) + "-" + str.substring(6,10) ;
                     $(this).val(strFinal);
                  }
               });
               
               
               $( "##register_form" ).validate({
                  rules: {
                     Mobile_Phone: {
                     required: false,
                     phoneUS: true
                     },
                     Home_Phone:{
                     required: false,
                     phoneUS: true
                     },
                     
                     Company_Phone:{
                     required: true,
                     phoneUS: true
                     },
                     
                     Contact_Phone:{
                     required: false,
                     phoneUS: true
                     },
                                 
                     Location_Phone:{
                     required: true,
                     phoneUS: true
                     },
                     
                     Company_Fax:{
                     required: false,
                     phoneUS: true
                     },
                     
                     Location_Fax:{
                     required: false,
                     phoneUS: true
                     }
                  }
               });
                           
            
               $('.firstLtrUpperApply').change(function(){
                  var str = $(this).val();
                  $(this).val(str.charAt(0).toUpperCase() + str.substring(1,str.length));
               });               
                           
            });
            */
               
         </script>
      </head>
      <body>

         <!---- Modal --->
   <!-- line modal -->
   <div class="modal fade" id="modalfirstlog" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
     <div class="modal-dialog" style="max-width: 700px;width: 100%;margin: 10px auto;">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button> --->
            <h3 class="modal-title" id="lineModalLabel">Registration Information</h3>
         </div>
         <div class="modal-body">
             <!-- Steps starts here -->
         <div class="requestwizard">
            <div class="requestwizard-row setup-panel">
               <div class="requestwizard-step">
                     <a href="##step-1" type="button" class="btn btn-primary btn-circle step1">1</a>
                     <p>Company information</p>
                 </div>
                 <div class="requestwizard-step">
                     <a href="##step-2" type="button" class="btn btn-default btn-circle step2" disabled="disabled">2</a>
                     <p>Location information</p>
                 </div>
                 <div class="requestwizard-step">
                     <a href="##step-3" type="button" class="btn btn-default btn-circle step3" disabled="disabled">3</a>
                     <p>Hours of Operation</p>
                 </div>
                 <div class="requestwizard-step">
                     <a href="##step-4" type="button" class="btn btn-default btn-circle step4" disabled="disabled">4</a>
                     <p>Service information</p>
                 </div>
            </div>
         </div>
   <cfoutput>
   <form role="form" action="" method="post" id="company_info_form" name="company_info_form"  enctype="multipart/form-data">
      <!--- company section --->
       <div class="row setup-content" id="step-1">
   <!--- <form id="company_info_form" name="company_info_form" action="" method="post"> --->
         <div class="col-md-12 col-sm-12 col-xs-12">
            <br>
               <div class="form-group">
                    <label for="x" class="col-sm-4 control-label">Company&nbsp;Name*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Name" class="form-control" id="Cmp_Name" value="#qCompany.Company_Name#" maxlength="50">
               </div>
                </div>
                <br><br>
            <div class="form-group">
               <label for="Company_Address" class="col-sm-4 control-label">Company&nbsp;Address*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Address" class="form-control address" id="Cmp_Address" value="#qCompany.Company_Address#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Company_City" class="col-sm-4 control-label">Company&nbsp;City*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_City" class="form-control city" id="Cmp_City" value="#qCompany.Company_City#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Cmp_State" class="col-sm-4 control-label">Company&nbsp;State*</label>
               <div class="col-sm-8">
                  <cfinvoke component="states" method="getStates">
                     <cfinvokeargument name="Select_Name" value="Cmp_State">
                     <cfinvokeargument name="Selected_State" value="#qCompany.Company_State#">
                  </cfinvoke>
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Cmp_Postal" class="col-sm-4 control-label">Company&nbsp;Postal&nbsp;Code*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Postal" class="form-control" id="Cmp_Postal" value="#qCompany.Company_Postal#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Cmp_Phone" class="col-sm-4 control-label">Company&nbsp;Phone*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Phone" class="form-control phone_us" id="Cmp_Phone" value="#qCompany.Company_Phone#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Cmp_Email" class="col-sm-4 control-label">Company&nbsp;Email</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Email" class="form-control" id="Cmp_Email" value="#qCompany.Company_Email#" size="30" maxlength="50" onchange="fnCheckCompanyEmail()">
               </div>
            </div>
                
            <br><br><br>
            <div class="form-group">
               <label for="Cmp_Fax" class="col-sm-4 control-label">Company&nbsp;Fax</label>
               <div class="col-sm-8">
                  <input type="text" name="Cmp_Fax" class="form-control phone_us" id="Cmp_Fax" value="#qCompany.Company_Fax#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="companyImageFile" class="col-sm-4 control-label">Company&nbsp;Picture</label>
               <div class="col-sm-8">
                  <table>
                  <tr>
                  <td>
                  <input type="file" name="company_ImageFile" id="company_ImageFile" value="" accept="image/gif, image/jpeg,image/png"> (.jpg, .gif, or .png)</td>
                  </tr>
                  </table>
                     
                   <cfif Find(cgi.script_name,"/dev/admin")>
                      <cfset variables.webpathC = "../images/company/" />
                  <cfelse>
                     <cfset variables.webpathC = "/images/company/" />
                  </cfif>
                  <cfset variables.pathC = expandPath(variables.webpathC) />
                  <cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
                  <cfif FileExists(variables.FilePathC)>
                     <a href="#variables.webpathC##session.company_id#.jpg?#now().getTime()#" target="_blank" width="300" height="300" border="0">View Image</a>
                  </cfif>
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Company_Description" class="col-sm-4 control-label">Company&nbsp;Description</label>
               <div class="col-sm-8">
                  <input type="hidden" id="Cmp_Description" name="Cmp_Description" />
                  <div id="Cmp_Description_summernote">#qCompany.Company_Description#</div>
               </div>
            </div>
            <br><br>
            <div class="row">
                   <button class="btn btn-primary nextBtn btn-lg pull-right savebtn"  name="company_info_btn" id="company_info_btn" type="button">Next</button>
                </div> 
         </div>
         <!---  <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" style="margin-top: 20px;" onclick="fnCheckCompanyEmail()">Next</button>  --->
       </div>
       <!--- company section end --->
       <!--- location section --->
       <div class="row setup-content" id="step-2">
            <div class="col-md-12 col-sm-12 col-xs-12">
               <br>
               <div class="form-group">
               <label for="Contact_Name" class="col-sm-4 control-label">Contact&nbsp;Name*</label>
               <div class="col-sm-8">
                  <input type="text" name="Cnt_Name" class="form-control" id="Cnt_Name" value="#qLocation.Contact_Name#" size="30" maxlength="50" >
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Contact_Phone" class="col-sm-4 control-label">Contact&nbsp;Phone</label>
               <div class="col-sm-8">
                  <input type="text" name="Cnt_Phone" class="form-control phone_us" id="Cnt_Phone" value="#qProfessional.Mobile_Phone#" size="30" maxlength="50" >
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_Name" class="col-sm-4 control-label">Location&nbsp;Name*</label>
               <div class="col-sm-8">
                  <input type="text" name="Lct_Name" class="form-control" id="Lct_Name" value="#qLocation.Location_Name#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_Address" class="col-sm-4 control-label">Location&nbsp;Address*</label>
               <div class="col-sm-8">
                  <table>
                  <tr>
                  <td>
                  <input type="text" name="Lct_Address" class="form-control address" id="Lct_Address" value="#qLocation.Location_Address#" size="46" maxlength="50" ></td>
                  </tr>
                  </table>
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_City" class="col-sm-4 control-label">Location&nbsp;City*</label>
               <div class="col-sm-8">
                  <input type="text" name="Lct_City" class="form-control city" id="Lct_City" value="#qLocation.Location_City#" size="30" maxlength="50" >
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_State" class="col-sm-4 control-label">Location&nbsp;State*</label>
               <div class="col-sm-8">
                  <cfinvoke component="states" method="getStates">
                     <cfinvokeargument name="Select_Name" value="Lct_State">
                     <cfinvokeargument name="Selected_State" value="#qLocation.Location_State#">
                  </cfinvoke>
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_Postal" class="col-sm-4 control-label">Location&nbsp;Postal*</label>
               <div class="col-sm-8">
                  <input type="text" name="Lct_Postal" class="form-control" id="Lct_Postal" value="#qLocation.Location_Postal#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_Phone" class="col-sm-4 control-label">Location&nbsp;Phone*</label>
               <div class="col-sm-8">
                  <input type="text" name="Lct_Phone" class="form-control phone_us" id="Lct_Phone" value="#qLocation.Location_Phone#" size="30" maxlength="50" >
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="Location_Fax" class="col-sm-4 control-label">Location&nbsp;Fax</label>
               <div class="col-sm-8">
                  <input type="text" name="Lct_Fax" class="form-control phone_us" id="Lct_Fax" value="#qLocation.Location_Fax#" size="30" maxlength="50" ">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="" class="col-sm-4 control-label">Description</label>
               <div class="col-sm-8">
                  <textarea name="Lct_Description" id="Lct_Description" class="form-control" cols="50">#qLocation.Description#</textarea>
               </div>
            </div>
            <br><br>
            <br>
            <div class="form-group">
               <label for="Directions" class="col-sm-4 control-label">Driving&nbsp;Directions</label>
               <div class="col-sm-8">
                  <textarea name="Lct_Directions" id="Lct_Directions" class="form-control" cols="50">#qLocation.Directions#</textarea>
               </div>
            </div>
            <br><br><br>
            <div class="form-group">
               <label for="Lct_TimeZone" class="col-sm-4 control-label">Time&nbsp;Zone</label>
               <div class="col-sm-8">
                  <select name="Time_Zone_ID" class="form-control" id="Time_Zone_ID">
                     <cfloop query="getTimeZones">
                     <option value="#getTimeZones.Time_Zone_ID#" <cfif getTimeZones.Time_Zone_ID EQ variables.TimeZoneID>selected="selected"</cfif>>#getTimeZones.Timezone_Location#</option>
                     </cfloop>
                  </select>
               </div>
            </div>
            <br><br>

            <div class="form-group" >
               <label for="Payments" class="col-sm-4 control-label">Payments&nbsp;Accepted</label>
               <div class="col-sm-8">
                  <table>
                     <cfloop query="getPaymentMethods">
                     <tr>
                     <td><input type="checkbox" name="Payment_MethodList" value="#Payment_Method_ID#"<cfif ListContains(qLocation.Payment_Methods_List,Payment_Method_ID) >checked</cfif>> </td>
                      <td>#Payment_Method#</td>
                     </tr>
                     </cfloop>
                  </table>
               </div>
            </div>
            <br><br><br><br><br><br><br><br><br>
            <div class="form-group">
               <label for="Parking_Fee" class="col-sm-4 control-label">Parking Fees</label>
               <div class="col-sm-8">
                  <input type="text" name="Parking_Fee" class="form-control" id="Parking_Fee" value="#qLocation.Parking_Fees#" size="30" maxlength="50">
               </div>
            </div>
            <br><br>
            <div class="form-group">
               <label for="" class="col-sm-4 control-label">Cancellation Policy</label>
               <div class="col-sm-8">
                  <textarea name="Cancellation_Policy" id="Cancellation_Policy" class="form-control" cols="50">#qLocation.Cancellation_Policy#</textarea>
               </div>
            </div>
            <br><br><br>
            <div class="form-group">
               <label for="Languages" class="col-sm-4 control-label">Languages</label>
               <div class="col-sm-8">
                  <input type="text" name="Language" class="form-control" id="Language" value="#qLocation.Languages#" size="30" maxlength="50">
               </div>
            </div>
            
           
                <button id="location_info_btn" class="btn btn-primary nextBtn btn-lg pull-right savebtn" type="button">Next</button>
            </div>
       </div>
      <!--- location section end --->
      <!--- hours of operation --->
       <div class="row setup-content" id="step-3">
         <div class="col-md-12 col-sm-12 col-xs-12" >
            <div class="row" >
               <hr>
               <div class="col-md-12 col-sm-12 col-xs-12" >
                  <h4 style="text-align: center;">Hours of Operation</h4>
               </div>
               <div class="col-md-12 col-sm-12 col-xs-12">
                  
                  <cfloop from="1" to="7" index="dayindex">
                     <cfset opentime=''>
                     <cfset closetime=''>
                     <cfset breakstarttime=''>
                     <cfset breakendtime=''>
                     <cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'))>
                        <cfset local.dayhours = listToArray(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_hours'),"&mdash;",false,true)>
                        <cfset opentime=local.dayhours[1]>
                        <cfset closetime=local.dayhours[2]>
                     </cfif>
                     <cfif FindNoCase('&mdash;',Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_break'))>
                        <cfset local.daybreak = listToArray(Evaluate('qLocation.#DayOfWeekAsString(dayindex)#_break'),"&mdash;",false,true)>
                        <cfset breakstarttime=local.daybreak[1]>
                        <cfset breakendtime=local.daybreak[2]>
                     </cfif>
                     <div class="row mb-10 eachrowBox hours">
                        <div class="row day mbm-10">
                           <div class="col-md-2 col-xs-12 mbm-10" style="margin-top:12px;font-weight: bolder;" >#DayOfWeekAsString(dayindex)#</div>
                        </div>
                        <div class="col-md-3 col-xs-12 mbm-10 texts" >Hours</div>
                        <div class="col-md-9 col-xs-12 mbm-10 mb-10">
                           <div class="row" >
                              <div class="col-md-4 col-xs-12 mbm-10">
                                 <select name="Begins_#dayindex#" id="Begins_#dayindex#" class="form-control">
                                    <option value="Closed">Closed</option>
                                    <cfloop from="1" to="24" index="i">
                                       <cfset meridiem="am">
                                       <cfif i gt 12>
                                          <cfset h=i-12>
                                          <cfset meridiem="pm">
                                       <cfelse>
                                          <cfset h=i>
                                       </cfif>
                                       <option value="#i#:00 #meridiem#" <cfif trim(opentime) eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
                                       <option value="#i#:15 #meridiem#" <cfif trim(opentime) eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
                                       <option value="#i#:30 #meridiem#" <cfif trim(opentime) eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
                                       <option value="#i#:45 #meridiem#" <cfif trim(opentime) eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
                                    </cfloop>
                                 </select>
                              </div>
                              <div class="col-md-4 col-xs-12 text-center mbm-10 texts">
                                 <small>TO</small>
                              </div>
                              <div class="col-md-4 col-xs-12 mbm-10">
                                 <select name="Ends_#dayindex#" id="Ends_#dayindex#" class="form-control">
                                    <option value="Closed">Closed</option>
                                    <cfloop from="1" to="24" index="i">
                                       <cfset meridiem="am">
                                       <cfif i gt 12>
                                          <cfset h=i-12>
                                          <cfset meridiem="pm">
                                       <cfelse>
                                          <cfset h=i>
                                       </cfif>
                                       <option value="#i#:00 #meridiem#" <cfif trim(closetime) eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
                                       <option value="#i#:15 #meridiem#" <cfif trim(closetime) eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
                                       <option value="#i#:30 #meridiem#" <cfif trim(closetime) eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
                                       <option value="#i#:45 #meridiem#" <cfif trim(closetime) eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
                                    </cfloop>
                                 </select>
                              </div>
                           </div>
                        </div>
                        <div class="col-md-3 col-xs-12 mbm-10 texts" >Break</div>
                        <div class="col-md-9 col-xs-12 mbm-10" >
                           <div class="row" >
                              <div class="col-md-4 col-xs-12 mbm-10">
                                 <select name="BreakBegin_#dayindex#" id="BreakBegin_#dayindex#" class="form-control">
                                    <option value="NoBreak">No Break</option>
                                    <cfloop from="1" to="24" index="i">
                                       <cfset meridiem="am">
                                       <cfif i gt 12>
                                          <cfset h=i-12>
                                          <cfset meridiem="pm">
                                       <cfelse>
                                          <cfset h=i>
                                       </cfif>
                                       <option value="#h#:00 #meridiem#" <cfif breakstarttime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
                                       <option value="#h#:15 #meridiem#" <cfif breakstarttime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
                                       <option value="#h#:30 #meridiem#" <cfif breakstarttime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
                                       <option value="#h#:45 #meridiem#" <cfif breakstarttime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
                                    </cfloop>
                                 </select>
                              </div>
                              <div class="col-md-4 col-xs-12 text-center mbm-10 texts">
                                 <small>TO</small>
                              </div>
                              <div class="col-md-4 col-xs-12 mbm-10">
                                 <select name="BreakEnd_#dayindex#" id="BreakEnd_#dayindex#" class="form-control">
                                    <option value="NoBreak">No Break</option>
                                    <cfloop from="1" to="24" index="i">
                                       <cfset meridiem="am">
                                       <cfif i gt 12>
                                          <cfset h=i-12>
                                          <cfset meridiem="pm">
                                       <cfelse>
                                          <cfset h=i>
                                       </cfif>
                                       <option value="#h#:00 #meridiem#" <cfif breakendtime eq '#h#:00 #meridiem#'>selected="selected"</cfif>>#h#:00 #meridiem#</option>
                                       <option value="#h#:15 #meridiem#" <cfif breakendtime eq '#h#:15 #meridiem#'>selected="selected"</cfif>>#h#:15 #meridiem#</option>
                                       <option value="#h#:30 #meridiem#" <cfif breakendtime eq '#h#:30 #meridiem#'>selected="selected"</cfif>>#h#:30 #meridiem#</option>
                                       <option value="#h#:45 #meridiem#" <cfif breakendtime eq '#h#:45 #meridiem#'>selected="selected"</cfif>>#h#:45 #meridiem#</option>
                                    </cfloop>
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                  </cfloop>
               </div>   
            </div>   
            <div class="row" >
               <button id="hours_info_btn" class="btn btn-primary nextBtn btn-lg pull-right savebtn" type="button">Next</button>
            </div>
         </div>
       </div>    
       <!--- hours of operation end--->
       <!--- services section --->

      <div class="row setup-content" id="step-4">
            <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="form-group cstm-fst-log">
               <label for="Profession" class="control-label block">Choose Profession</label>
               <div style="overflow-y: scroll;height: 254px;">
                  <cfloop query="getProfessions">
                     <button class="block blockbtn profession" type="button" id="#getProfessions.Profession_ID#" data-toggle="modal" data-target="##myModal"  data-professionid="#getProfessions.Profession_ID#">#getProfessions.Profession_Name#</button>
                  </cfloop>
               </div>
            </div>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12 text-right">
               <button id="services_info_btn" class="btn btn-primary nextBtn btn-lg savebtn" type="submit">Save</button>
            </div>
       </div>    
       <!--- services section end --->
   </form>
   </cfoutput>

<!-- Form ends here -->
      </div>
   </div>
</div>
</div>


<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Choose Service Type</h4>
      </div>
      <div class="modal-body cstm-fst-log">
        <div id="servicetype_btn" style="overflow-y: scroll;height: 224px;">
        </div>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-default showprofession savebtn" data-dismiss="modal" style="float:left"><i class="fa fa-arrow-left" style="font-size:18px"></i></button>
        <button type="button" class="btn btn-default showprofession savebtn" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

<div id="serviceModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Choose Service</h4>
      </div>
      <div class="modal-body" >
        <div class="row" id="service_div" style="overflow-y: scroll;height: 112px;margin-bottom: 27px;">
      </div>
      <div style="height: 33px;">
         <h5 style="text-align: center;">Services List </h5>
      </div>
      <div class="row" id="addedservices" style="overflow-y: scroll;height: 112px;padding-top: 10px;">
      </div>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-default showservicetype savebtn" data-dismiss="modal" style="float:left"><i class="fa fa-arrow-left" style="font-size:18px"></i></button>
        <button type="button" class="btn btn-default showservicetype savebtn" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

<div class="modal" id="addservice" class="serviceadd">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="serviceheader"></h4>
          
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
         <p>
            <div class="row">
               <input name="serviceid" id="serviceid" type="hidden">
               <input name="servicetypeid" id="servicetypeid" type="hidden">
               <div class="col-md-5 form-group input-group">
                  <input type="text" id="servicetime" name="servicetime" class="form-control number required" minlength="1" maxlength="3" required />
                  <span class="input-group-addon">
                     min
                  </span>
               </div>
               <div class="col-md-5 form-group input-group">
                  <span class="input-group-addon">
                     $
                  </span>
                  <input type="text" id="serviceprice" name="serviceprice" class="form-control money required" maxlength="6" required />
               </div>
            </div>
            <div class="row">
               <div id="serviceMsg" class="col-md-10 alert alert-danger" style="display:none;margin-left: 45px;">
                  Missing required fields!
               </div>
            </div>
         </p>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        <button type="button" class="btn btn-primary saveservice">Save</button>
          <button type="button" class="btn btn-danger cancelservice" data-dismiss="modal">Cancel</button>
        </div>
        
      </div>
    </div>
  </div>

  <div class="modal" id="editservice">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="srvheader"></h4>
          
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
         <p>
            <div class="row">
               <input name="srvid" id="srvid" type="hidden">
               <input name="srvtypeid" id="srvtypeid" type="hidden">
               <div class="col-md-5 form-group input-group">
                  <input type="text" id="srvtime" name="srvtime" class="form-control number required" minlength="1" maxlength="3" required />
                  <span class="input-group-addon">
                     min
                  </span>
               </div>
               <div class="col-md-5 form-group input-group">
                  <span class="input-group-addon">
                     $
                  </span>
                  <input type="text" id="srvprice" name="srvprice" class="form-control money required" maxlength="6" required />
               </div>
            </div>
            <div class="row">
               <div id="srvMsg" class="col-md-10 alert alert-danger" style="display:none;margin-left: 45px;">
                  Missing required fields!
               </div>
            </div>
         </p>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        <button type="button" class="btn btn-primary savesrv">Save</button>
          <button type="button" class="btn btn-danger cancelsrv" data-dismiss="modal">Cancel</button>
        </div>
        
      </div>
    </div>
</div>

  <!--- modals end --->

         <div class="navbar navbar-default navbar-fixed-top" id="navbar">
            <script type="text/javascript">
               try{ace.settings.check('navbar' , 'fixed')}catch(e){ console.log(e);}
            </script>
            <div class="navbar-container" id="navbar-container">
               <div class="navbar-header pull-left">
                  <a href="##" class="navbar-brand">
                  <small>
                  <i class="icon-leaf"></i>
                  SalonWorks Admin
                  </small>
                  </a><!-- /.brand -->
               </div>
               <!-- /.navbar-header --> 
               <div class="navbar-header pull-right" role="navigation">
                  <ul class="nav ace-nav">
                     <li class="light-blue">
                        <a data-toggle="dropdown" href="##" class="dropdown-toggle">
                           <!--- Commented out until photo available --->
                           <!--- <img class="nav-user-photo" src="assets/avatars/user.jpg" alt="#session.first_name#'s Photo" /> --->
                           <span class="user-info">
                           <small>Welcome, #session.first_name#</small>
                           </span>
                           <i class="icon-caret-down"></i>
                        </a>
                        <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                           <!--- <li>
                              <a href="##">
                                 <i class="icon-cog"></i>
                                 Settings
                              </a>
                              </li> --->
                           <li>
                              <a href="professional_view.cfm" >
                              <i class="icon-user"></i>
                              Profile
                              </a>
                           </li>
                           <li class="divider"></li>
                           <li>
                              <a href="logout.cfm">
                              <i class="icon-off"></i>
                              Logout
                              </a>
                           </li>
                        </ul>
                     </li>
                  </ul>
                  <!-- /.ace-nav -->
               </div>
            </div>
            <!-- /.container -->
         </div>
         <div class="main-container tpr" id="main-container">
         <script type="text/javascript">
            try{ace.settings.check('main-container' , 'fixed')}catch(e){}
         </script>
         <div class="main-container-inner">
         <a class="menu-toggler" id="menu-toggler" href="##">
         <span class="menu-text"></span>
         </a>
         <div class="sidebar" id="sidebar">
            <script type="text/javascript">
               try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
            </script>
            <div class="sidebar-shortcuts" id="sidebar-shortcuts">
               <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                  <span class="btn btn-success"></span>
                  <span class="btn btn-info"></span>
                  <span class="btn btn-warning"></span>
                  <span class="btn btn-danger"></span>
               </div>
            </div>
            <!-- ##sidebar-shortcuts -->
            <ul class="nav nav-list">
               <li class="active">
                  <a href="./index.cfm">
                  <i class="icon-dashboard"></i>
                  <span class="menu-text"> Dashboard </span>
                  </a>
               </li>
               <li>
                  <a href="##" class="dropdown-toggle" id="profileSection">
                  <i class="icon-desktop"></i>
                  <span class="menu-text"> Profile </span>
                  <b class="arrow icon-angle-down"></b>
                  </a>
                  <ul class="submenu">
                     <li>
                        <a id="profile_company" href="##">
                        <i class="icon-double-angle-right"></i>
                        Company
                        </a>
                     </li>
                     <li>
                        <a id="profile_professionals" href="##">
                        <i class="icon-double-angle-right"></i>
                        Professional
                        </a>
                     </li>
                     <li>
                        <a id="profile_location" href="##">
                        <i class="icon-double-angle-right"></i>
                        Location
                        </a>
                     </li>
                     <li>
                        <a id="profile_services" href="##">
                        <i class="icon-double-angle-right"></i>
                        Services
                        </a>
                     </li>
                  </ul>
               </li>
               <li>
                  <cfif  getPlan.Company_Service_Plan_ID gt 1  >

                     <a href="inquiries.cfm">
                     <i class="icon-envelope"></i>
                     <span class="menu-text"> Inquiries </span>
                     </a>
                  <cfelse>
                     <a href="upgrade.cfm">
                        <i class="icon-calendar"></i>
                        <span class="menu-text"> 
                           Inquiries 
                           <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                           <i class="icon-warning-sign red bigger-130"></i>
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                     </a>  
                  </cfif>
               </li>
               <!--- SW - 75 Calender menu - added two new sub menu's --->
               <li class="">
                  <cfif   getPlan.Company_Service_Plan_ID gt 1    >
                      <a href="##" class="dropdown-toggle" id="calenderId">
                        <i class="icon-calendar"></i>
                        <span class="menu-text"> 
                           Calendar 
                           <span class="badge badge-transparent tooltip-error" title="2&nbsp;Important&nbsp;Events">
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                        <b class="arrow icon-angle-down"></b>
                     </a>  
                     <ul class="submenu">
                        <li>
                           <a href="##" id="eventcalendar">
                           <i class="icon-double-angle-right"></i>
                           Appointment
                           </a>
                        </li>
                        <li>
                           <a id="scheduleweek" href="##">
                           <i class="icon-double-angle-right"></i>
                           Schedule
                           </a>
                        </li>
                     </ul>
                     <!--- <a id="eventcalendar" href="##">
                        <i class="icon-calendar"></i>
                        <span class="menu-text">
                           Calendar
                           <span class="badge badge-transparent tooltip-error" title="2&nbsp;Important&nbsp;Events">
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                     </a> --->
                  <cfelse>
                     <!--- <a href="upgrade.cfm">
                     <i class="icon-group"></i>
                     <span class="menu-text"> Calendar
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </span>
                     </a> --->
                     <a href="upgrade.cfm">
                        <i class="icon-calendar"></i>
                        <span class="menu-text"> 
                           Calendar 
                           <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                           <i class="icon-warning-sign red bigger-130"></i>
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                     </a>  
                  </cfif>
               </li>
               <li class="">
                 <cfif  getPlan.Company_Service_Plan_ID gt 1    >
                     <a href="customers.cfm">
                     <i class="icon-group"></i>
                     <span class="menu-text"> Customers </span>
                     </a>
                  <cfelse>
                     <a href="upgrade.cfm">
                     <i class="icon-group"></i>
                     <span class="menu-text"> Customers
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </span>
                     </a>
                  </cfif>
               </li>
               <!---
                  <li>
                     <a href="giftcertificates.cfm">
                        <i class="icon-gift"></i>
                        <span class="menu-text"> Gift Certificates </span>
                     </a>
                  </li>--->
               <li>
                  <cfif  getPlan.Company_Service_Plan_ID gt 1>
                     <a href="gallery.cfm">
                     <i class="icon-picture"></i>
                     <span class="menu-text"> Photo Gallery</span>
                     </a>
                     <cfelse>
                     <a href="upgrade.cfm">
                     <i class="icon-picture"></i>
                     <span class="menu-text"> Photo Gallery 
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </a>
                  </cfif>
               </li>
               <li>
                  <cfif  getPlan.Company_Service_Plan_ID gt 1 >
                     <a href="blog.cfm">
                     <i class="icon-book"></i>
                     <span class="menu-text"> Blog </span>
                     </a>
                  <cfelse>
                     <a href="upgrade.cfm">
                     <i class="icon-book"></i>
                     <span class="menu-text"> Blog 
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </a>
                  </cfif>
               </li>
               <!--- Email campaigns --->
               <li>
                 <cfif   getPlan.Company_Service_Plan_ID gt 1  >
                     <a href="email_campaign.cfm">
                        <i class="icon-envelope"></i>
                        <span class="menu-text"> Email Customers</span>
                     </a>
                  <cfelse>
                     <a href="upgrade.cfm">
                     <i class="icon-envelope"></i>
                     <span class="menu-text">  Email Customers 
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </a>
                  </cfif>
               </li>
               <!--- Survey --->
               <li>
                  <cfif   getPlan.Company_Service_Plan_ID gt 1  >
                     <a href="##" class="dropdown-toggle" id="surveySection">
                     <i class="icon-list"></i>
                     <span class="menu-text"> Survey </span>
                     <b class="arrow icon-angle-down"></b>
                     </a>
                     <ul class="submenu">
                        <li>
                           <a id="add_survey" href="add_survey.cfm">
                           <i class="icon-double-angle-right"></i>
                           Add Survey
                           </a>
                        </li>
                        <li>
                           <a id="add_survey" href="survey_list.cfm">
                           <i class="icon-double-angle-right"></i>
                           Survey List
                           </a>
                        </li>
                     </ul>
                  <cfelse>
                     <a href="upgrade.cfm">
                        <i class="icon-envelope"></i>
                        <span class="menu-text">  Survey
                        <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                        <i class="icon-warning-sign red bigger-130"></i>
                        </span>
                     </a>
                  </cfif>
               </li>
               <li>
                  <!--- <cfif  getPlan.Company_Service_Plan_ID gt 1  > --->

                     <a href="##" class="dropdown-toggle" id="subscribtionplan">
                     <i class="icon-credit-card"></i>
                     <span class="menu-text"> Subscription </span>
                     <b class="arrow icon-angle-down"></b>
                     </a>
                     <ul class="submenu">
                        <!--- <li>
                           <a id="" href="Upgrade.cfm">
                           <i class="icon-double-angle-right"></i>
                           Subscribe
                           </a>
                        </li> --->
                        <cfif getTrialExpiration.recordcount and getTrialExpiration.subscription_status eq 1 >
                           <li>
                              <a id="" href="updateSubscription.cfm">
                              <i class="icon-double-angle-right"></i>Update
                              </a>
                           </li>
                        <cfelse>
                           <li>
                              <a id="" href="Upgrade.cfm">
                                 <i class="icon-double-angle-right"></i>Subscribe
                              </a>
                           </li>
                        </cfif>
                       
                        <cfif getTrialExpiration.recordcount and getTrialExpiration.subscription_status eq 1 >
                            <li>
                              <a id="" href="cancelSubscription.cfm">
                              <i class="icon-double-angle-right"></i>
                              Cancel
                              </a>
                           </li>
                        </cfif>
                     </ul>
                    
                 <!---  <cfelse>
                     <a href="upgrade.cfm">
                        <i class="icon-calendar"></i>
                        <span class="menu-text"> 
                           Subscription 
                           <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                           <i class="icon-warning-sign red bigger-130"></i>
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                     </a>  
                  </cfif> --->
               </li>
                
              <li>
                  <!--- <cfif not( getPlan.Company_Service_Plan_ID gt 1  AND (DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0 AND (NOT getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)))) > --->
                  <cfif   getPlan.Company_Service_Plan_ID gt 1  >
                     <a href="templateSelection.cfm" class="" id="previewSection">
                     <i class="icon-picture"></i>
                     <span class="menu-text">Templates</span>
                     <b class=""></b>
                     </a>
                  <cfelse>
                     <a href="upgrade.cfm">
                        <i class="icon-picture"></i>
                        <span class="menu-text"> Templates
                        <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                        <i class="icon-warning-sign red bigger-130"></i>
                        </span>
                     </a>
                  </cfif>
               </li>
            </ul>
            <!-- /.nav-list -->
            <div class="sidebar-collapse" id="sidebar-collapse">
               <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
            </div>
            <script type="text/javascript">
               try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
            </script>
         </div>
         <div class="main-content">
         <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
               try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>
            <ul class="breadcrumb" >
               <li>
                  <i class="icon-home home-icon"></i>
                  <a href="http://salonworks.com/admin/">Home</a>
               </li>
               <li class="active" id="profileBreadcrumbs">#variables.page_title#</li>
            </ul>
            <!-- .breadcrumb -->
            <ul class="breadcrumb pull-right">
               <li class="active pull-right">
                  <a href="##" class="admin-support">
                  <span class="label label-warning arrowed-in"> <i class="icon-envelope"></i>
                  Support
                  </span>
                  </a>
               </li>
            </ul>
         </div>
         <div class="page-content" id="page-content">
            <div class="page-header">
               <h1>#variables.page_title#</h1>
            </div>
         <!-- /.page-header -->
          <div class="row">
            <div class="col-xs-12">
         <!-- PAGE CONTENT BEGINS -->
        <!---  <cfdump var="#DateDiff('d',Now(),getTrialExpiration.Trial_Expiration)#">
         <cfdump var="#DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 30#"> --->
              <!---  <cfif not (getPlan.Company_Service_Plan_ID gt 1 AND ( DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lte 30 AND (not getTrialExpiration.Trial_Expiration LTE CreateDate(2018,9,30)))) >
                  <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     <cfif DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0>
                        Your trial expired on #DateFormat(getTrialExpiration.Trial_Expiration,'mm/dd/yyyy')#.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and add the lost features to your website.
                     <cfelse>
                        Your trial will expire on #DateFormat(getTrialExpiration.Trial_Expiration,'mm/dd/yyyy')#.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and avoid losing any features to your website.
                     </cfif>
                  </div>
               </cfif> --->
               <cfif getPlan.Company_Service_Plan_ID eq 1>
                   <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     
                        Your trial expired on #DateFormat(getTrialExpiration.Trial_Expiration,'mm/dd/yyyy')#.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and add the lost features to your website.
                    
                  </div>
               </cfif>
                <cfif getPlan.Company_Service_Plan_ID eq 2 and not DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 0>
                   <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     
                        Your trial will expire on #DateFormat(getTrialExpiration.Trial_Expiration,'mm/dd/yyyy')#.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and avoid losing any features to your website.
                  </div>
               </cfif>
               <!--- <cfif getPlan.Company_Service_Plan_ID eq 1>
                  <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     Your account level is Free.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and reenable all the features to your website.
                  </div>
               </cfif> --->
</cfoutput>