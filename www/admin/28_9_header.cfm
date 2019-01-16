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
   SELECT 
   Trial_Expiration
   FROM
   Companies
   WHERE
   Company_ID=
   <cfqueryparam value="#session.Company_ID#" cfsqltype="cf_sql_integer" />
</cfquery>
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
                  <a href="inquiries.cfm">
                  <i class="icon-envelope"></i>
                  <span class="menu-text"> Inquiries </span>
                  </a>
               </li>
               <li class="">
                  <cfif getPlan.Company_Service_Plan_ID gt 1>
                     <a id="eventcalendar" href="##">
                        <i class="icon-calendar"></i>
                        <span class="menu-text">
                           Calendar
                           <span class="badge badge-transparent tooltip-error" title="2&nbsp;Important&nbsp;Events">
                              <!--- <i class="icon-warning-sign red bigger-130"></i> --->
                           </span>
                        </span>
                     </a>
                     <cfelse>
                     <a href="upgrade.cfm">
                     <i class="icon-group"></i>
                     <span class="menu-text"> Calendar
                     <span class="badge badge-transparent tooltip-error" title="Upgrade your account to enable this feature">
                     <i class="icon-warning-sign red bigger-130"></i>
                     </span>
                     </span>
                     </a>
                  </cfif>
               </li>
               <li class="">
                  <cfif getPlan.Company_Service_Plan_ID gt 1>
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
                  <cfif getPlan.Company_Service_Plan_ID gt 1>
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
                  <cfif getPlan.Company_Service_Plan_ID gt 1>
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
               <cfif getPlan.Company_Service_Plan_ID gt 1 AND DateDiff('d',Now(),getTrialExpiration.Trial_Expiration) lt 14>
                  <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     Your trial will expire on #DateFormat(getTrialExpiration.Trial_Expiration,'mm/dd/yyyy')#.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and avoid losing any features to your website.
                  </div>
               </cfif>
               <cfif getPlan.Company_Service_Plan_ID eq 1>
                  <div class="alert alert-block alert-success">
                     <button type="button" class="close" data-dismiss="alert">
                     <i class="icon-remove"></i>
                     </button>
                     <i class="icon-ok green"></i> 
                     Your account level is Free.  Click <a href="upgrade.cfm">here</a> to upgrade your account now and reenable all the features to your website.
                  </div>
               </cfif>
</cfoutput>