<!doctype html>
<html class="no-js" lang="en">
<!---<cfset strPath="<cfoutput>#strPath#</cfoutput>">--->
<cfset strPath = "">
   <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
      <meta name="format-detection" content="telephone=no">
      <meta name="SalonWorks" content="Salonworks ,online Salon appointment booking website,  Customised  online salon booking, Manage salon appointments online, online appointment availability checking,  Email notification of online booking, hair and spa appt booking,Salon website">
       <meta name="keywords" content="Salonworks ,online Salon appointment booking website,  Customised  online salon booking, Manage salon appointments online, online appointment availability checking,  Email notification of online booking, hair and spa appt booking,Salon website">
        <meta name="description" content="Salonworks ,online Salon appointment booking website,  Customised  online salon booking, Manage salon appointments online, online appointment availability checking,  Email notification of online booking, hair and spa appt booking,Salon website">
        <meta name="robots" content="index,nofollow">
      <title>SalonWorks</title>
      <link rel="icon" type="image/x-icon" href="" />
      <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/bootstrap.css">
      <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/main.css">
      <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/animations.css">
      <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/animate.min.css">
      <link rel="stylesheet" href="css/editor.css">
      <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,500,600,700,800" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700" rel="stylesheet">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css" rel="stylesheet"/>
      <!---<link rel="stylesheet" type="text/css" href="jquery-ui-1.8.21/css/smoothness/jquery-ui-1.8.21.custom.css"/>--->
	  <link rel="stylesheet" type="text/css" href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.24/themes/pepper-grinder/jquery-ui.css"/>
      <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
      <script src="<cfoutput>#strPath#</cfoutput>js/vendor/modernizr-2.8.3.min.js"></script>
      <!--- <script type="text/javascript" src=/dev/js/jquery.mask.min.js"></script> --->
      <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
      <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>
      <!--- <script type="text/javascript" src="js/common_validations.js"></script>  --->
      <script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/jquery.validate.additional-methods.min.js"></script> 
      <!--Retina.js plugin - @see: http://retinajs.com/-->
      <script src="plugins/retina/js/retina-1.1.0.min.js"></script>
      <script src="js/jquery.mask.min.js" type="text/javascript"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.10/jquery.mask.js"></script>
      <!---<script src="jquery-ui-1.8.21/ui/jquery-ui-1.8.21.custom.js"></script>--->
	  <!---<script src=" http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>--->
	<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-K86HR56');</script>
<!-- End Google Tag Manager -->
   <script>
       $('.phone_us').mask('(000) 000-0000');
    </script>
   </head>
   <body>
		<!-- Google Tag Manager (noscript) -->
		<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-K86HR56"
		height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
		<!-- End Google Tag Manager (noscript) -->
      <div class="col-sm-12 p-0 nav-otr">
         <nav class="navbar navbar-expand-lg navbar-light bg-light mx-auto container-secn">
            <cfif not structKeyExists(url, 'ucode')>
               <a class="navbar-brand" href="#"><img src="img/logo.png"></a>
            <cfelse>
               <!--- #session.Company_Name_Customr# --->
               <cfif structKeyExists(session, 'Company_Name_Customr')>
                  <a class="navbar-brand com-nme" href="#"><cfoutput>#session.Company_Name_Customr#</cfoutput></a>
               <cfelse>
                  <a class="navbar-brand com-nme" href="#"><cfoutput>Company name</cfoutput></a>
               </cfif>
            </cfif>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
               <ul class="navbar-nav ml-auto">
                  <cfif not structKeyExists(url, 'ucode')>
                     <li class="nav-item">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                     </li>
                     <li class="nav-item feature">
                        <a class="nav-link" href="#">Features</a>
                     </li>
                     <li class="nav-item pricing">
                        <a class="nav-link" href="#">Pricing</a>
                     </li>
                     <li class="nav-item support">
                        <a class="nav-link" href="" data-toggle="modal" data-target="#modalSupport">Support</a>
                     </li>
                     <li class="nav-item">
                       <a class="nav-link log-green" href="http://demo.salonworks.com" target="_blank"></i> View Demo Site</a>
                     </li>
                     <li class="nav-item signup">
                        <a class="nav-link log-clr" href="#"><i class="far fa-user"></i> SignUp </a>
                     </li>
                     <li class="nav-item">
                        <a class="nav-link log-dash ml-0" href="#">|</a>
                     </li>
                     <li class="nav-item">
                       <a class="nav-link log-clr ml-0" href="" data-toggle="modal" data-target="#modalLogin"><i class="fas fa-lock"></i> Login</a>
                     </li>
                   <cfelse>
                        <li class="nav-item">
                           <cfif structKeyExists(session, 'CustomerID') and len(session.CustomerID)>
                              <a class="nav-link log-clr ml-0" href="##" id="a_signout">Logout</a>
                           <cfelse>
                              <a class="nav-link log-clr ml-0" href="" data-toggle="modal" data-target="#modalLoginn"><i class="fas fa-lock"></i> Login</a>
                           </cfif>
                        </li>
                  </cfif>
               </ul>
            </div>
         </nav>
      </div>
      
      
      