<cfset variables.subdomain = ListgetAt(cgi.server_name,1,'.')>
<cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
   <cfinvokeargument name="Web_Address" value="#variables.subdomain#">
</cfinvoke>
<cfif qCompany.recordcount gt 0 AND !ListFindNoCase("www,salonworks",variables.subdomain)>
<cfset variables.Company_ID=qCompany.Company_ID>
<cfelse>
<cfset variables.Company_ID=0>
</cfif>
<cfif variables.Company_ID eq 0>
   <cfset variables.feature_text="Meet your New Personal Receptionist!!">
   <cfparam name="variables.company_id" default="0">
   <cfparam name="variables.location_id" default="0">
   <cfparam name="variables.professional_id" default="0">
   <cfset variables.companyCFC = createObject("component","admin.company") />
   <cfset variables.qrySocialMedia = variables.companyCFC.getCompanySocialMediaPlus(variables.company_id) />
   <!--- Query to get the payment methods --->
   <cfquery name="getPaymentMethods" datasource="#request.dsn#">
      SELECT Payment_Method_ID, Payment_Method From Payment_Methods Order By Order_By
   </cfquery>
   <!--- Query to get the time zones --->
   <cfquery name="getTimeZones" datasource="#request.dsn#">
      SELECT Time_Zone_ID, Timezone_Location FROM Time_Zones WHERE enabled = 1
   </cfquery>
   <cfinvoke component="admin.company" method="getCompany" returnvariable="qCompany">
      <cfinvokeargument name="Company_ID" value="#variables.company_id#">
   </cfinvoke>
    <cfif structKeyExists(form, 'personolized_demo_btn')>
      <cfinvoke component="admin.company" method="setPersonalDemo" returnvariable="demo_id">
        <cfinvokeargument name="First_name" value="#form.first_name_demo#">
        <cfinvokeargument name="Last_name" value="#form.last_name_demo#">
        <cfinvokeargument name="Email" value="#form.email_id_demo#">
        <cfinvokeargument name="Mobile" value="#form.mobile_phone_demo#">
      </cfinvoke>
   </cfif>
<!doctype html>
<html class="no-js" lang="en">
    <cfset strPath = "">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no">
        <meta name="format-detection" content="telephone=no">
        <title>Home</title>
        <link rel="icon" type="image/x-icon" href="salonnewhome/img/favicon.png" />
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="salonnewhome/css/bootstrap/bootstrap.css">
        <link rel="stylesheet" href="salonnewhome/css/main.css">
        <link rel="stylesheet" href="salonnewhome/css/cutom.css">
        <link rel="stylesheet" href="salonnewhome/css/slick.css">
        <link rel="stylesheet" href="salonnewhome/css/fontello.css">
        <link rel="stylesheet" href="salonnewhome/css/magnific-popup.css">
        <link href="https://fonts.googleapis.com/css?family=Hind+Vadodara:300,400,500,600|Poppins:100,200,300,400,500,600,700,900" rel="stylesheet">


        <!--- old  --->
       
        <!--- <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/bootstrap.css"> --->
        <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/main.css">
        <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/animations.css">
        <link rel="stylesheet" href="<cfoutput>#strPath#</cfoutput>css/animate.min.css">
        <link rel="stylesheet" href="css/editor.css">
    
        <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,500,600,700,800" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="<cfoutput>#strPath#</cfoutput>js/vendor/modernizr-2.8.3.min.js"></script>
        <script src="salonnewhome/js/vendor/modernizr-2.8.3.min.js"></script>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script type="text/javascript" src="js/common_validations.js"></script> 
        <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>
         
        <script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/jquery.validate.additional-methods.min.js"></script> 
        <script language="javascript" src="js/indexscript.js"></script>
          <!--- end --->

          <style type="text/css">
      .col-sm-2 {width:200px;}
      textarea.error, input.error {
      border: 1px solid #FF0000;
      }
      .erroron_form label.error {
      color: #FF0000 !important;
      margin-left: 0px;
      width: auto;
      display: inline;
      /* margin-top: -8px;*/
      display: inline-block;
      float: left;
      width: 100%;
      }
      a.anchor{margin-top: -100px;
      padding-top: 125px;}
      .address, .city  {
      text-transform:capitalize;
      }
      .eml {display:none;}
      }
      /*Stle for email demo*/
       .form-button {
         position: fixed;
         right: 0px;
         bottom: 10px;
         width: 73px;
         height: 400px;
         z-index: 1400;
         cursor: pointer;
       }
         
      .form-button .box .textWrapper {
          width: 0px;
          height: 0px;
          position: relative;
          top: 96px;
          left: -38px;
      }
      .form-button .box {
          float: left;
          width: 73px;
          height: 223px;
          background: #e31e25;
      }
      .form-button .box .text {
          font-family: bebas-neue,Helvetica Neue,helvetica,arial,sans-serif;
          letter-spacing: 1px;
          width: 150px;
          text-align: center;
          color: #ffffff;
          -webkit-transform: rotate(270deg) translate(0px,0px);
          -moz-transform: rotate(270deg) translate(0px,0px);
          -o-transform: rotate(270deg) translate(0px,0px);
          -ms-transform: rotate(270deg) translate(0px,0px);
          transform: rotate(270deg) translate(0px,0px);
          font-size: 22px;
          display: block;
      }
   </style>
          
    </head>
    <body>
        <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        
        <header>
            <div class="min-hd">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="top-cnt-scnt">
                                <ul>
                                    <li><i><img src="salonnewhome/img/icon-clock.png" alt=""></i>Mon - Fri: 8:00AM-5:00PM CST</li>
                                    <li><i><img src="salonnewhome/img/icon-call.png" alt=""></i><a href="tel:(978) 352-0235">(978) 352-0235</a></li>
                                    <li><i><img src="salonnewhome/img/icon-mail.png" alt=""></i><a href="mailto:salonworks@salonworks.com">salonworks@salonworks.com</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-3">
                        <div class="logo"><a href=""><img src="salonnewhome/img/logo.png" alt=""></a></div>
                    </div>
                    <div class="col-xl-9 col-md-9">
           <div class="flx-algin">
                                <div class="menu-wrp">
                                    <!--  Nav start here -->
                                        <nav class="main-nav">
                                            <ul>
                                                <li>
                                                    <a class="nav-link active" href="#">Home <span class="sr-only">(current)</span></a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#features">Features</a>
                                                </li>
                                                <li>
                                                    <a class="nav-link" href="#">Pricing</a>
                                                </li>                                    <li>
                                                <a class="nav-link" href="" data-toggle="modal" data-target="#modalSupport">Support</a>
                                            </li>
                                            <li>
                                                <a class="nav-link" href="http://demo.salonworks.com">Demo Site </a>
                                            </li>
                                      
                                            <li>
                                                <a class="nav-link clr-rd line" href="#signupform" >SIGN-UP</a>
                                            </li>
                                            <li>
                                                <a class="nav-link clr-rd" href="" data-toggle="modal" data-target="#modalLogin">LOGIN</a>
                                            </li>
                                       
                                        </ul>
                                        </nav>
                                    <div class="mob-btn">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </div>
                                    <div class="overlay"></div>
                                    <!-- Nav End here -->
                                </div>

                    <div class="search-otr">
                        <form class="searchbox">
                            <input type="search" placeholder="Search..." name="search" class="searchbox-input" onkeyup="buttonUp();" required>
                            
                            <span class="searchbox-icon"></span>
                        </form>
                    </div>
 </div>
                </div>

            </div>
        </div>
    </header>
    <div class="banner">
        <div class="banner-slide">
            
            <div class="banner-bg-1" style="background:#2a272e url(salonnewhome/img/banner-bg-02.jpg) no-repeat">
                <div class="container">
                    <div class="row flex-row-reverse">
                        <div class="col-xl-6">
                            <div class="bnr-caption-otr">
                                <div class="bnr-txt">
                                    <h2>WEBSITES AND ONLINE<br>SCHEDULING</h2>
                                    <p class="light">For the modern salon</p>
                                </div>
                                <button type="button" class="btn btn-primary mrg-rgt signupform"><a href="#signupform" style="text-decoration: none;">sign up for free</a> </button>
                                <button type="button" class="btn btn-secondary" onclick="window.open('http://demo.salonworks.com');">View demo site</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="banner-bg-2" style="background:#2a272e url(salonnewhome//img/banner-bg-03.jpg) no-repeat">
                <div class="container">
                    <div class="row flex-row-reverse">
                        <div class="col-xl-6">
                            <div class="bnr-caption-otr">
                                <div class="bnr-txt">
                                    <h2>APPOINTMENT REMINDERS<br> BY TEXT/EMAIL</h2>
                                    <p>Reduce Missed Appointments! Whether A Client Booked Their Appointment Online Or By Telephone, They Will Receive An Automated Text Message And/Or Email As A Courtesy Reminder 24 Hours Before Their Appointment.</p>
                                </div>
                                <button type="button" class="btn btn-primary mrg-rgt"><a href="#signupform" style="text-decoration: none;">sign up for free</a> </button>
                                <button type="button" class="btn btn-secondary" onclick="window.open('http://demo.salonworks.com');">View demo site</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="banner-bg-3" style="background:#2a272e url(salonnewhome//img/banner-bg-04.jpg) no-repeat">
                <div class="container">
                    <div class="row flex-row-reverse">
                        <div class="col-xl-6">
                            <div class="bnr-caption-otr">
                                <div class="bnr-txt">
                                    <h2>24/7 ONLINE CLIENT<br> BOOKING</h2>
                                    <p>Think Of Your New Web Site As Your Personal Receptionist! There Will Be No Need To Interrupt Your Day To Take Appointments. Just Enter Your Availability Using Your Own Password Protected Administration Site, And Your Clients Will Be Able To Book Their Own Appointments Online On Their Computer, Smartphone, Or Mobile Device</p>
                                </div>
                                <button type="button" class="btn btn-primary mrg-rgt"><a href="#signupform" style="text-decoration: none;">sign up for free</a> </button>
                                <button type="button" class="btn btn-secondary" onclick="window.open('http://demo.salonworks.com');">View demo site</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="banner-bg-4" style="background:#2a272e url(salonnewhome//img/banner-bg-01.jpg) no-repeat">
                <div class="container">
                    <div class="row flex-row-reverse">
                        <div class="col-xl-6">
                            <div class="bnr-caption-otr">
                                <div class="bnr-txt">
                                    <h2>FREE<br> CUSTOM WEBSITE</h2>
                                    <p>Whether You Decide To Continue Your 30 Day Trial Of Our Advanced Features, You Can Keep Your Custom Website For Free. With Your Site You Can Customize Your Layout, Publish Pictures, And Even Manage Your Own Blog.</p>
                                </div>
                                <button type="button" class="btn btn-primary mrg-rgt"><a href="#signupform" style="text-decoration: none;">sign up for free</a> </button>
                                <button type="button" class="btn btn-secondary" onclick="window.open('http://demo.salonworks.com');">View demo site</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <section class="top-grid" id="features">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h1>Salon & Spa Management Software</h1>
                </div>
                <div class="otr-dflx">
                    <div class="col-lg-3 col-md-6 d-flex align-items-stretch">
                        <div class="card text-center">
                            <i><img src="salonnewhome/img/grid-icon-01.png" alt=""></i>
                            <div class="card-body">
                                <h5 class="card-title">Email & Text Notifications</h5>
                                <div class="content"><p class="card-text">Decrease no shows and cancellations with our automated courtesy appointment reminder system</p></div>
                                <a href="#" class="btn btn-primary">READ MORE</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 d-flex align-items-stretch">
                        <div class="card text-center">
                            <i><img src="salonnewhome/img/grid-icon-02.png" alt=""></i>
                            <div class="card-body">
                                <h5 class="card-title">Online Booking</h5>
                                <div class="content"><p class="card-text">User friendly appointment management for yourself and your clients</p></div>
                                <a href="#" class="btn btn-primary">READ MORE</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 d-flex align-items-stretch">
                        <div class="card text-center">
                            <i><img src="salonnewhome/img/grid-icon-03.png" alt=""></i>
                            <div class="card-body">
                                <h5 class="card-title">Custom Website</h5>
                                <div class="content"><p class="card-text">Increase online presence with a fully customizable website; included at no additional charge.</p></div>
                                <a href="#" class="btn btn-primary">READ MORE</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 d-flex align-items-stretch">
                        <div class="card text-center">
                            <i><img src="salonnewhome/img/grid-icon-04.png" alt=""></i>
                            <div class="card-body">
                                <h5 class="card-title">Manage Your Calendar</h5>
                                <div class="content"><p class="card-text">Allow your clients to view availability and schedule accordingly from your computer or smart phone</p></div>
                                <a href="#" class="btn btn-primary">READ MORE</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="container-fluid">
        <div class="row">
            <div class="video-mang-scnt ">
                <div class="col-xl-6 col-md-12 d-flex align-items-stretch">
          <div class="video-bx">
            <a class="popup-youtube" href="https://www.youtube.com/watch?v=Jz-W4mLjkwA"><img src="salonnewhome/img/video-bg.jpg" alt="">
              <div class="ply-btn"></div></a>
            </div>
                </div>
                <div class="col-xl-6 col-md-12 d-flex align-items-stretch">
                    <div class="content-box">
                        <article>
                            <h2>Manage Appointments Online</h2>
                            <strong>WITH YOUR FREE WEBSITE & ONLINE SCHEDULING SOFTWARE FOR THE MODERN SALON
                            </strong>
                            <div class="content">
                                <p>Think of your new website as your personal receptionist!  There will be no need to interrupt your day to
                                    take appointments.  Just enter your availability your own password protected administration site, and your
                                clients will be able to booak their own appointments online on their computer, smartphone, or mobile device. </p>
                                <p>By indicating your availability, clients can book their appointments online at any time based on your schedule,
                                    day or night. You will receive notifications of the appointments and can view and manage them from your
                                calendar interface.</p>
                            </div>
                            <a href="http://demo.salonworks.com" class="btn btn-primary">VIEW DEMO</a>
                            <a href="#" class="btn btn-primary btn-clr-rd">See pricing</a>
                        </article>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="sctin-csmt ">
                <div class="col-md-12">
                    <div class="text-center">
                        <h3>Save time with SalonWorks</h3>
                        <strong>
                        SAVE TIME BY HAVING EVERYTHING YOU NEED IN ONE PLACE
                        </strong>
                    </div>
                </div>
                <div class="mid-grid otr-dflx ">
                    <div class="col-lg-4 col-md-12 d-flex align-items-stretch">
                        <div class="card text-center">
                            
                            <div class="card-body">
                                <h5 class="card-title">Get More Appointments</h5>
                                <div class="content"><p class="card-text">Increase you number of appointments by
                                    allowing customers to conveniently check your
                                calendar, book online, & even reschedule.</p></div>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 d-flex align-items-stretch">
                        <div class="card text-center">
                            
                            <div class="card-body">
                                <h5 class="card-title">Plan Your Day</h5>
                                <div class="content"><p class="card-text">Our color coded calendar will allow you to manage
                                    appointments, openings and cancellations all in one
                                easy to manage place.</p></div>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 d-flex align-items-stretch">
                        <div class="card text-center">
                            
                            <div class="card-body">
                                <h5 class="card-title">Client Retention</h5>
                                <div class="content"><p class="card-text">Automatic text & e-mail confirmations will
                                    remind your clients of upcoming appointments
                                    and when it’s time for their next visit.
                                </p></div>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="forms-otr" id="demo_close">
        <div class="container">
            <div class="row">
                <form action="#" name="personolized_demo_form" id="personolized_demo_form" method="POST" class="erroron_form">
                <div class="col-md-12">
                    <h4>Schedule A Free Demo</h4>
                    <div class="form-list">
                        <ul class="forms">
                            <li>
                                <div class="input-holder">
                                    <input type="text" class="form-control" placeholder="First Name" required="required" name="first_name_demo">
                                </div>
                            </li>
                            <li>
                                <div class="input-holder">
                                    <input type="text" placeholder="Last Name" required="required" name="last_name_demo">
                                </div>
                            </li>
                            <li>
                                <div class="input-holder">
                                    <input type="text" placeholder="Email" required="required" name="email_id_demo">
                                </div>
                            </li>
                            <li>
                                <div class="input-holder">
                                    <input type="text" placeholder="Mobile Phone" required="required" name="mobile_phone_demo">
                                </div>
                            </li>
                            <li>
                                <div class="submt-btn">
                                    <button type="submit" class="sbmt btn btn-block btn-primary"  name="personolized_demo_btn">Schedule Demo</button>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
            </div>
        </div>
    </div>
    <!-- <div class="fetrd-artcls">
        <h3>Featured Articles</h3>
        <strong>
        Follow us online for tips to help you run a successful salon business.
        </strong>
        <div class="featured-slide">
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 2</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 2</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 3</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 4</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 5</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
            <div class="box-full">
                <div class="box"></div>
                <strong>Article 6</strong>
                <p>Duis aute irure reprehender voluptate velit ese acium
                fugiat nulla pariatur excepteur ipsum.</p>
            </div>
        </div>
    </div> -->
    <section class="sctn-btm" >
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <!-- <i class="icon-check-1"></i>
                    <h4>Over <span>1,500</span> appointments booked online using SalonWorks platform.</h4> -->
                </div>
            </div>
        </div>
    </section>
    <!-- <div class="client-slide-otr">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="client-slide">
                        <div class="box-full">
                            <div class="box">
                                <i><img src="img/img-01.jpg" alt=""></i>
                                <div class="content">
                                    <strong>NAME HERE</strong>
                                    <span>JOB TITLE</span>
                                    <p>SalongWorks uis aute irure reprehender voluptate velit ese acium fugiat
                                        nulla pariatur lorem excepteur ipsum et dolore magna aliqua. Ut enim
                                        minim veniam quis nostrud exercitation ullamco.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="box-full">
                            <div class="box">
                                <i><img src="img/img-01.jpg" alt=""></i>
                                <div class="content">
                                    <strong>NAME HERE</strong>
                                    <span>JOB TITLE</span>
                                    <p>SalongWorks uis aute irure reprehender voluptate velit ese acium fugiat
                                        nulla pariatur lorem excepteur ipsum et dolore magna aliqua. Ut enim
                                        minim veniam quis nostrud exercitation ullamco.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="box-full">
                            <div class="box">
                                <i><img src="img/img-01.jpg" alt=""></i>
                                <div class="content">
                                    <strong>NAME HERE</strong>
                                    <span>JOB TITLE</span>
                                    <p>SalongWorks uis aute irure reprehender voluptate velit ese acium fugiat
                                        nulla pariatur lorem excepteur ipsum et dolore magna aliqua. Ut enim
                                        minim veniam quis nostrud exercitation ullamco.
                                    </p>
                                </div></div>
                            </div>
                            <div class="box-full">
                                <div class="box">
                                    <i><img src="img/img-01.jpg" alt=""></i>
                                    <div class="content">
                                        <strong>NAME HERE</strong>
                                        <span>JOB TITLE</span>
                                        <p>SalongWorks uis aute irure reprehender voluptate velit ese acium fugiat
                                            nulla pariatur lorem excepteur ipsum et dolore magna aliqua. Ut enim
                                            minim veniam quis nostrud exercitation ullamco.
                                        </p>
                                    </div></div>
                                </div>
                                <div class="box-full">
                                    <div class="box">
                                        <i><img src="img/img-01.jpg" alt=""></i>
                                        <div class="content">
                                            <strong>NAME HERE</strong>
                                            <span>JOB TITLE</span>
                                            <p>SalongWorks uis aute irure reprehender voluptate velit ese acium fugiat
                                                nulla pariatur lorem excepteur ipsum et dolore magna aliqua. Ut enim
                                                minim veniam quis nostrud exercitation ullamco.
                                            </p>
                                        </div>
                                    </div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->
                <div class="faq-sign-otr" >
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="faq-content">
                                    <h4>Read FAQ’s</h4>
                                    <strong>Find the answers to your questions about our salon booking software services.</strong>
                                    <div class="accordion" id="accordionExample">
                                        <div class="card">
                                            <div class="card-header" id="headingOne">
                                                <h5 class="mb-0">
                                                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                What is included in my trial?
                                                </button>
                                                </h5>
                                            </div>
                                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    Duis aute irure reprehender voluptate velits fugiat nulla pariatur excepteur
                                                    doloe amet consecteur adipisicing elit labore et dolore magna aliquaut enim
                                                    minim veniam, quis nostrud exercitation ullamco.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingTwo">
                                                <h5 class="mb-0">
                                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Can I cancel at anytime?
                                                </button>
                                                </h5>
                                            </div>
                                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingThree">
                                                <h5 class="mb-0">
                                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                What is included with my free website?
                                                </button>
                                                </h5>
                                            </div>
                                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingFive">
                                                <h5 class="mb-0">
                                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseTwo">
                                                Does SalonWorks process credit card payments?
                                                </button>
                                                </h5>
                                            </div>
                                            <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-header" id="headingSix">
                                                <h5 class="mb-0">
                                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseTwo">
                                                Can I use SalonWorks to manage multiple locations?
                                                </button>
                                                </h5>
                                            </div>
                                            <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="col-md-6 form-web-otr" id="signupform">
                                <form role="form" action="admin/process_registration.cfm" method="POST" id="register_form" enctype="multipart/form-data" class="erroron_form">
                                <div class="sign-up-hm">

                                    <h5>Sign up to start your <span>FREE</span> 30 Day Trial!</h5>
                                    <p>Take the steps TODAY to fill your appointment book by completing the form below.
                                        Try out all features with no credit card required, and watch your business grow while simplifying
                                        your appointments. Just fill out the form below!
                                    </p>
                                    <div class="forms-hm-otr">
                                    <div class="forms">
                                    <input type="hidden" id="Web_Address" name="web_address" value="" >
                                    <div class="col-md-6">
                                        <div class="input-holder">
                                            <input type="text" placeholder="First Name" class="form-control"  name="First_Name" required="required" value="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-holder">
                                            <input type="text" placeholder="Last Name" class="form-control" 
                                       name="Last_Name" required="required" value="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-holder">
                                            <input type="text" placeholder="Email" class="form-control" required="required" name="Email_Address" onChange="fnCheckEmailAddress()" id="Email_Address" value="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-holder">
                                            <input type="text" placeholder="Mobile Phone" class="form-control" name="Mobile_Phone" value="" required="required">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                      <div class="g-recaptcha" data-sitekey="6Lcsu3oUAAAAAPd4XSHG9EpISI2MRsB17dN4L27Q"></div>
                                        <input type="hidden" class="hiddenRecaptcha required" name="hiddenRecaptcha" id="hiddenRecaptcha">
                                    </div>
                                    <div class="col-md-12">
                                        <label class="check-box">Yes, contact me to schedule a live demo.
                                            <input type="checkbox">
                                            <span class="checkmark"></span>
                                        </label>
                                        <div class="submt-btn">
                                            <div class="input-holder">
                                                <input type="hidden" value="firstsignup" id="firstsignup" name="firstsignup">
                                                <button type="submit" class="sbmt finishBtn" value="Submit">SIGN-UP</button>
                                            </div>
                                        </div>
                                    </div>

                                    
                                           </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        </div>
                    </div>
                </div>

          
          <footer>
              <div class="container">
                  <div class="row">
                      <div class="col-md-5">
                          <div class="ftr-logo-cnt">
                              <a href="#"><img src="salonnewhome/img/footer-logo.png" alt=""></a>
                              <p>Salon and spa management tool designed
to bring simplicity to growing your clientele 
and operating your business in the digital age.</p>

<div class="scl-ftr">
    <ul>
        <li ><a class="icon-facebook" href="https://www.facebook.com/Salonworks-1434509316766493"></a></li>
        <li ><a class="icon-twitter" href=""></a></li>
        <li ><a class="icon-linkedin" href=""></a></li>
        <li ><a class="icon-instagram" href=""></a></li>
        <li ><a class="icon-youtube-play" href=""></a></li>
    </ul>
</div>
                          </div>
                      </div>
                      <div class="col-md-4">
                          <div class="ftr-menu">
                            <strong>FEATURES</strong>
                              <ul>
                                  <li><a href="#features">Custom Website</a></li>
                                  <li><a href="#features">Calendar</a></li>
                                  <li><a href="#features">Online Booking</a></li>
                                  <li><a href="">Photo Gallery</a></li>
                                  <li><a href="#features">E-Mail & Text</a></li>
                              </ul>
                          </div>
                      </div>
                   <!--    <div class="col-md-3">
                     <div class="ftr-menu">
                         <strong>BLOG POSTS</strong>
                           <ul>
                               <li><a href="">ARTICLE 1</a></li>
                               <li><a href="">ARTICLE 2</a></li>
                               <li><a href="">ARTICLE 3</a></li>
                               <li><a href="">ARTICLE 4</a></li>
                               <li><a href="">ARTICLE 5</a></li>
                           </ul>
                       </div>
                   </div> -->
                    <div class="col-md-3">
                         <div class="ftr-menu adrs">
                            <address>
                            <strong>Address Information</strong>
                            <h6>Call us<a href="tel:(978) 352-0235"><span> (978) 352-0235</span></a> </h6>
                            <div class="ftr-contact">
                                <ul>
                                    <li><i><img src="salonnewhome/img/icon-mail.png" alt=""></i><a href="mailto:salonworks@salonworks.com">salonworks@salonworks.com</a></li>
                                    <li><i><img src="salonnewhome/img/icon-clock.png" alt=""></i>Mon - Fri: 8:00AM-5:00PM CST</li>
                                </ul>
                            </div>
                             </address>
                          </div>
                      </div>
                      </div>

                  </div>
              </div>
              <div class="ftr-strip">
                  <p>Copyrights SALONWORKS  All rights reserved. <a href="">Privacy Policy</a> <a href="">Terms & Conditions</a> </p>
              </div>
          </footer>
            
            <!-- The Modal login >> -->
            <div class="modal fade loginModal" id="modalLogin">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <!-- Modal Header -->
                     <!-- Modal body -->
                     <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Log In</h4>
                        <form action="admin/login.cfm" id="loginFrm" method="POST" class="erroron_form">
                           <div class="form-group">
                              <input type="email" name="Email_Address_log" id="login-email" class="form-control" placeholder="Email">
                           </div>
                           <div class="form-group">
                              <input type="password" class="form-control" name="password" id="login-password" placeholder="Password">
                           </div>
                           <!-- <div class="form-group form-check">
                              <label class="form-check-label">
                                <input class="form-check-input" type="checkbox"> Remember me
                              </label>
                              </div> -->
                           <button type="button" id="loginBtn" class="btn btn-block" style="background-color:#8a171a;color:white;">Log In</button>
                           <div id="msgLogin" style="color:red; display:none;margin-top:10px;text-align: center;">&nbsp;</div>
                        </form>
                        <a class="float-right link-default" data-dismiss="modal" data-toggle="modal" href="#modalForgotPassword">Forgot password?</a>
                     </div>
                     <!-- Modal footer -->
                     <div class="modal-footer">
                        <p>
                           Don't have an account? <br>

                           <a data-dismiss="modal" class="signup-trial" href="">Sign up for your FREE 30 Day Trial now!</a>
                          
                        </p>
                     </div>
                  </div>
               </div>
            </div>
        <script>

            $(document).ready(function(){
    $(".signup-trial").click(function(){
        $(".modal-backdrop").removeClass("modal-backdrop fade");
    });
});
</script>
            <!-- The Modal login << -->
            <!-- The Modal Forgot Password >> -->
            <div class="modal fade loginModal" id="modalForgotPassword">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <!-- Modal Header -->
                     <!-- Modal body -->
                     <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Forgot Password</h4>
                        <form action="#" id="forgotPassForm" method="POST" class="erroron_form">
                           <div class="form-group">
                              <input type="email" class="form-control" name="Email_Address_forgot" id="forgotPassEmail" placeholder="Email" required="required">
                           </div>
                           <button type="button" class="btn btn-block" id="forgotPassSubmit" style="background-color:#8a171a;color:white;">Send Mail</button>
                        </form>
                     </div>
                     <!-- Modal footer -->
                     <div class="modal-footer">
                        <p>
                           We are ready to help you <br>
                           <a href="#">Keep in touch with us and enjoy our services!</a>
                        </p>
                     </div>
                  </div>
               </div>
            </div>
            <div class="modal fade modalsucces" id="emailsuccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        Your password has been<br> send to your email address
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnEmailOk">Ok</button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- The Modal  Forgot Password << -->
            <!-- The Modal Support >> -->
            <div class="modal fade loginModal modalSupport" id="modalSupport">
               <div class="modal-dialog">
                  <div class="modal-content">
                     <!-- Modal Header -->
                     <!-- Modal body -->
                     <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Need help? We're here to assist you!</h4>
                        <form action="support.cfm" id="modalSupportform" method="POST" class="erroron_form">
                           <div class="form-group">
                              <input type="text" class="form-control" placeholder="Name" name="Name" id="support-name" required>
                           </div>
                           <div class="form-group">
                              <input type="email" class="form-control" placeholder="Email" name="Email" id="support-email">
                           </div>
                           <div class="form-group">
                              <input type="text" class="form-control" placeholder="Subject" name="Subject" id="support-support">
                           </div>
                           <div class="form-group">
                              <textarea class="form-control" placeholder="Enter Your Question or Message" name="Message"></textarea>
                           </div>
                           <button type="submit" class="btn btn-block" name="submit" style="background-color:#8a171a;color:white;">Submit</button>
                        </form>
                     </div>
                     <!-- Modal footer -->
                     <div class="modal-footer">
                        <p>
                           We are ready to help you <br>
                           <a href="#">Keep in touch and enjoy our services!</a>
                        </p>
                     </div>
                  </div>
               </div>
            </div>
            <!-- The Modal  Support << -->

                <script src="salonnewhome/js/vendor/jquery-3.3.1.slim.min.js"></script>
                <script src="salonnewhome/js/vendor/popper.min.js"></script>
                <script src="salonnewhome/js/vendor/bootstrap.min.js"></script>
                <script src="salonnewhome/js/vendor/slick.min.js"></script>
                <script src="salonnewhome/js/vendor/jquery.magnific-popup.js"></script>
                <script src="salonnewhome/js/main.js"></script>  



                <!--- old scripts --->
                <script src="<cfoutput>#strPath#</cfoutput>js/vendor/jquery-3.3.1.slim.min.js"></script>
                <script src="<cfoutput>#strPath#</cfoutput>js/vendor/wow.min.js"></script>
                <script src="<cfoutput>#strPath#</cfoutput>js/main.js"></script>
                <script src="js/editor.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
                <script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/css3-animate-it.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.10/jquery.mask.js"></script>
                <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
                <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
                <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>
                <script type="text/javascript" src="js/error_messages.js"></script>
                <!--- end --->
                <script type="text/javascript">
                   $(document).ready(function(){        
                        $('#modalLoad').modal('show');
                    }); 
                </script>

            <script>
               var inputemail = document.getElementById("login-email");
               var inputpw = document.getElementById("login-password");
               
               inputemail.addEventListener("keyup", function(event) {
                   event.preventDefault();
                   if (event.keyCode === 13) {
                       document.getElementById("loginBtn").click();
                   }
               });
               inputpw.addEventListener("keyup", function(event) {
                   event.preventDefault();
                   if (event.keyCode === 13) {
                       document.getElementById("loginBtn").click();
                   }
               });
            </script>

            <script>
               $(document).ready(function() {
                   $("#loginFrm").validate({
                       rules: {
                           Email_Address_log: {
                               required: true,
                               email: true
                           },
                           password: {
                               required: true
                           }
               
                       },
                       messages: {
                           Email_Address_log: {
                               required: "Email is required"
                           },
                           password: "Password is required"
                       }
                   });
                   $("#forgotPassForm").validate({
                       rules: {
                           Email_Address_forgot: {
                               required: true,
                               email: true
                           },
                       },
                       messages: {
                           Email_Address_forgot: {
                               required: "Email is required"
                           },
                       }
                   });
                   $("#modalSupportform").validate({
                       rules: {
                           Email: {
                               required: true,
                               email: true
                           },
                           Name: {
                               required: true
                           },
                           Subject: {
                               required: true
                           },
                           Message: {
                               required: true
                           }
                       },
                       messages: {
                           Email: {
                               required: "Email is required"
                           },
                           Name: "Name is required",
                           Subject: "Subject is required",
                           Message: "Message is required"
                       }
                   });
                   $('#modalSupportform').validate({});
                   if ($("#modalSupportform").valid()) {
                       $('#modalSupportform').submit();
                   } else {
                       return false;
                   }
               
               });
            </script>

            <script type="text/javascript">
               $(".signup-trial").click(function() {
                   $('#modalLogin').modal('hide');
                   $('#modalLoad').modal('hide');
                   $('html,body').stop(true, false).animate({
               
                       scrollTop: $(".form-web-otr").offset().top - 80
                   }, 1000);
                   return false;
                   $('html,body').animate({
               
                       scrollTop: $(window.location.hash).offset().top - 90
                   }, 500);
               });
            </script>

            <script type="text/javascript">
               $(".video-but").click(function() {
                   $('#modalLoad').modal('hide');
                   $('html,body').stop(true, false).animate({
               
                       scrollTop: $(".video-otr").offset().top - 80
                   }, 1000);
                   return false;
                   $('html,body').animate({
               
                       scrollTop: $(window.location.hash).offset().top - 90
                   }, 500);
               });
            </script>

            <script>
               $(document).ready(function() {
                   $('[data-toggle="popover"]').popover();
               });
            </script>

            <script type="text/javascript">
               $(function() {
                   fnCheckEmailAddress = function() {
                        
                       if ($('#Email_Address').val().length) {
               
                           $.ajax({
                               type: "get",
                               url: "admin/company.cfc",
                               data: {
                                   method: "isExistingEmailAddress",
                                   EmailAddress: $('#Email_Address').val(),
                                   noCache: new Date().getTime()
                               },
                               dataType: "json",
               
                               // Define request handlers.
                               success: function(objResponse) {
                                   // Check to see if request was successful.
                                   if (objResponse.SUCCESS) {
                                       if (objResponse.DATA) {
                                           alert('The Email address, ' + $('#Email_Address').val() + ', entered already exist.  Please enter a different address.');
                                           $('#Email_Address').val('');
                                           $('#Email_Address').focus();
                                       }
               
                                   } else {
                                       alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help.');
                                   }
                               },
               
                               error: function(objRequest, strError) {
                                   alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help. ' + strError);
                               }
                           });
                       }
                   }

                   fnCheckWebAddress = function(){
                    $('.finishBtn').prop('disabled', false);
                       var checkaddress = /^[a-zA-Z0-9]+(?:--?[a-zA-Z0-9]+)*$/;
                       if($('#Web_Address').val().length){
                           console.log($('#Web_Address').val());
                           if (!checkaddress.test($('#Web_Address').val())) {
                                   alert("Please enter a valid web address");
                                   $('#Web_Address').val('');
                                   $('#Web_Address').focus();
                               return false;
                               }
                           if($('#Web_Address').val().toLowerCase() == 'www'){
                               alert('Web Address can not be "www".');
                               $('#Web_Address').val('');
                               $('#Web_Address').focus();
                               return false;
                           }
                                
                           $.ajax({
                                   type: "get",
                                   url: "admin/company.cfc",
                                   data: {
                                       method: "isExistingWebAddress",
                                       WebAddress: $('#Web_Address').val(),
                                       noCache: new Date().getTime()
                                       },
                                   dataType: "json",
                   
                                   // Define request handlers.
                                   success: function( objResponse ){
                                       // Check to see if request was successful.
                                       if (objResponse.SUCCESS){
                                           if(objResponse.DATA){
                                               alert('The web address, ' + $('#Web_Address').val() + ', entered already exist.  Please enter a different address.');
                                               $('#Web_Address').val('');
                                               $('#Web_Address').focus();
                                               $('.finishBtn').prop('disabled', true);
                                               return false;
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
               
                   $('.close').click(function() {
                       console.log(1);
                       // $('#video-learn iframe').attr("src", jQuery("#video-learn iframe").attr("src"));
                   });
               });
            </script>            


        </body>

        

        </html>
       
<cfelse>
<cfinclude template="./customer_sites/index.cfm">
<!--- Customer Homepage --->
</cfif>

