<cfset variables.subdomain = ListgetAt(cgi.server_name,1,'.')>
<!--- added on 08/01/2019 --->
<!--- <cfif !ListFindNoCase("www,salonworks",variables.subdomain)>
  <cfset variables.subdomain=variables.subdomain>
<cfelse>
  <cfset variables.subdomain="">
</cfif> --->

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
   <!--- SalonWorks.com Header --->
   <cfinclude template="site_header.cfm">
   <cfparam name="variables.company_id" default="0">
   <cfparam name="variables.location_id" default="0">
   <cfparam name="variables.professional_id" default="0">
   <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
   <script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
   <script src="https://www.google.com/recaptcha/api.js" async defer></script>
   <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-50779113-1"></script>
<script>
 
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-50779113-1');
</script>

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
   <script language="javascript" src="/js/indexscript.js"></script>

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
   
   <div class="col-md-12 p-0 sldr-otr">
      <div id="carouselExampleControls" class="carousel carousel-fade slide" data-ride="carousel" data-interval="15000"  data-pause="false">
         <!-- Indicators -->
         <ul class="carousel-indicators">
            <li data-target="#carouselExampleControls" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleControls" data-slide-to="1"></li>
            <li data-target="#carouselExampleControls" data-slide-to="2"></li>
            <li data-target="#carouselExampleControls" data-slide-to="3"></li>
         </ul>
         <div class="carousel-inner">
            <div class="carousel-item active">
               <img class="d-block w-100" src="img/banner.jpg" alt="First slide">
               <div class="carousel-caption d-md-block">
                  <h2 class="animated1 bounceInRight1">Websites and online scheduling TEST</h2>
                  <h4 class="animated1 bounceInRight1">for the modern salon</h4>
                  <div class="col-sm-12 p-0 btr-carsl">
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="SIGN UP FOR FREE" class="btn-s-1 signup">
                     </div>
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="VIEW DEMO SITE" class="btn-s-2" onclick="window.open('http://demo.salonworks.com');">
                     </div>
                  </div>
               </div>
            </div>
            <div class="carousel-item">
               <img class="d-block w-100" src="img/banner1.jpg" alt="First slide">
               <div class="carousel-caption d-md-block caption-2">
                  <h2 class="animated1 bounceInRight1">Appointment Reminders by Text/Email</h2>
                  <h4  class="animated1 fadeInUp1">Reduce missed appointments! Whether a client booked their appointment online or by telephone, they will receive an automated text message and/or email as a courtesy reminder 24 hours before their appointment. </h4>
                  <div class="col-sm-12 p-0 btr-carsl">
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="SIGN UP FOR FREE" class="btn-s-1 signup">
                     </div>
                     <div  class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="VIEW DEMO SITE" class="btn-s-2" onclick="window.open('http://demo.salonworks.com');">
                     </div>
                  </div>
               </div>
            </div>
            <div class="carousel-item">
               <img class="d-block w-100" src="img/banner2.jpg" alt="First slide">
               <div class="carousel-caption d-md-block caption-2">
                  <h2 class="animated1 fadeInUp1">24/7 Online Client Booking</h2>
                  <h4 class="animated1 fadeInUp1">Think of your new web site as your personal receptionist!  There will be no need to interrupt your day to take appointments.  Just enter your availability using your own password protected administration site, and your clients will be able to book their own appointments online on their computer, smartphone, or mobile device </h4>
                  <div class="col-sm-12 p-0 btr-carsl">
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="SIGN UP FOR FREE" class="btn-s-1 signup">
                     </div>
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="VIEW DEMO SITE" class="btn-s-2" onclick="window.open('http://demo.salonworks.com');">
                     </div>
                  </div>
               </div>
            </div>
            <div class="carousel-item">
               <img class="d-block w-100" src="img/banner3.jpg" alt="First slide">
               <div class="carousel-caption d-md-block caption-2">
                  <h2 class="animated1 bounceInRight1">Free 
                     <br/>Custom Website
                  </h2>
                  <h4  class="animated1 fadeInUp1">Whether you decide to continue your 30 day trial of our advanced features, you can keep your custom website for free.  With your site you can customize your layout, publish pictures, and even manage your own blog.</h4>
                  <div class="col-sm-12 p-0 btr-carsl">
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="SIGN UP FOR FREE" class="btn-s-1 signup">
                     </div>
                     <div class="float-left wd-ff animated1 fadeInUp1">
                        <input type="button" value="VIEW DEMO SITE" class="btn-s-2" onclick="window.open('http://demo.salonworks.com');">
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!--- Video section --->
   <div class="col-md-12 video-otr">
      <div class="row">
         <div class="col-md-7 bg-vido-lft">
               <article>
                  <h2>
                   Learn
                  </h2>
                  <h3>
                  How to Manage Your
                  Appointments Online
                  </h3>
               </article>
         </div>
         <div class="col-md-5 bg-video">
           <div class="video-container">
              <div class="js-video ng-isolate-scope" >
                <div class="video-poster">
                </div> 
                  <div class="play"><i class="fas fa-play"></i></div> 
              </div>    
            </div>
         </div>
         <div class="triangle-mdl triangle-lft cf">
             <div class="t-1 wow fadeIn" data-wow-duration=".5s" data-wow-delay=".9s""></div>
             <div class="t-2 wow fadeIn" data-wow-duration=".8s" data-wow-delay="1.5s""></div>
             <div class="t-3 wow fadeIn" data-wow-duration="1s" data-wow-delay="1s""></div>
             <div class="t-4 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.4s""></div>
             <div class="t-5 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s""></div>
             
             <div class="t-7 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.7s""></div>
             <div class="t-8 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.8s""></div>
             <div class="t-9 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s""></div>
         </div>
      </div>
   </div>
   
  <div class="col-md-12 container-secn featr-otur mx-auto" id="feature">
     <div class="row row-tp scroll-anim animatedParent animateOnce" data-appear-top-offset='-300'>
       <div class="col-md-6 bkr-otr animated bounceInLeft slower">
         <h3>Online Booking Test</h3>
         <div class="col-md-12 p-0 bkr-cont">
           Think of your new website as your personal receptionist!  There will be no need to interrupt your day to take appointments.  Just enter your availability your own password protected administration site, and your clients will be able to book their own appointments online on their computer, smartphone, or mobile device.
           <br/>
           <br/>
           By indicating your availability, clients can book their appointments online at any time based on your schedule, day or night. You will receive notifications of the appointments and can view and manage them from your calendar interface.  
           <ul class="col-md-12">
             <li>Online Appointment Settings</li>
             <li>Set the lead time required for online appointments, giving you time to make yourself available.</li>
             <li>Set the search appointments interval 15, 20, 30 minutes etc. Set the order in which service providers are listed.</li>
             <li>Set whether a customer can cancel or reschedule online. Enter a cancellation policy to protect yourself from no shows.</li>
             <li>Require clients to provide credit card information for all or just specific appointments.</li>
             <li>Automatically accept all online appointments or require requests for appointments based on your desired criteria. Example: new customers or customers with no shows.</li>

           </ul>

         </div>
       </div>
       <div class="col-md-6 p-0 bkr-img animated bounceInRight slower">
         <img src="img/ftr1.jpg">
       </div>
     </div>
     <div class="row row-tp animatedParent animateOnce" data-appear-top-offset='-300'>
       <div class="col-md-6 p-0 bkr-img animated bounceInLeft slower">
         <img src="img/ftr2.jpg">
       </div>
       <div class="col-md-6 bkr-otr tp-fv animated bounceInRight slower">
          <h3>Email and <br/>Text Communication</h3>
         <div class="col-md-12 p-0 bkr-cont">
           Whether a client books their appointment in person, online or by phone, they can receive automated text messages and/or emails as a courtesy reminder 24 hours before their appointment allowing them time to reschedule or cancel if needed. Message all your customers with bulk messages to let them know about new offers or special holiday hours. 
         </div>
       </div>          
     </div>
     <div class="row row-tp animatedParent animateOnce" data-appear-top-offset='-300'>
       <div class="col-md-6 bkr-otr tp-sv animated bounceInLeft slower">
         <h3>Manage Your Calendar</h3>
         <div class="col-md-12 p-0 bkr-cont">
          Experience more flexibility with our online calendar. This convenient feature allows you to manage your schedule from anywhere using your computer or mobile device. By entering your availability, this allows your clients to book upcoming appointments, and even reschedule.  It also includes color-coded services to make it easier to see what's coming up for you and your clients.

         </div>
       </div>
       <div class="col-md-6 p-0 bkr-img animated bounceInRight slower">
         <img src="img/ftr3.jpg">
       </div>
     </div>
     <div class="row row-tp animatedParent animateOnce bdt-none" data-appear-top-offset='-300'>
       <div class="col-md-6 p-0 bkr-img animated bounceInLeft slower">
         <img src="img/ftr4.jpg">
       </div>
       <div class="col-md-6 bkr-otr tp-hv animated bounceInRight slower">
         <h3>Custom Website</h3>
         <div class="col-md-12 p-0 bkr-cont">
         With your new website, you can customize your layout, display photos, and publish your very own blog. Salon Works provides an amazing opportunity for you to strengthen your online reputation for your business. Whether you decide to continue after your free 30-day trial of our advanced features, you can keep your custom website for free. Manage your business from your desktop, tablet, and smartphone with SalonWorks!  
         </div>
       </div>          
     </div>
   </div>
    <!--- 13-10-18 >>Pricing section --->
    <div class="col-sm-12 pricing-secn"  id="pricing">
      <div class="col-sm-12 hed text-center">
        <h3>
          Free Lifetime 
          <br/>
          Website And Setup
        </h3>
        <h4>
          Free 30 day trial! No credit card is needed and there is no obligation to continue!
        </h4>
      </div>
        <div class="col-md-12">
          <div class="col-md-12 container-secn mx-auto p-0">
            <div class="row">
              <div class="col-md-12 pricing-otr">
                <ul class="pricing-cont-detl">
                  <li class="plan-section">
                      <ul>
                        <li class="pricing-typ">
                          <h4>Starter</h4>
                          <h3>Free</h3>
                        </li>
                      </ul>
                      <ul class="pd-lef">
                        <li class="cont-dl">
                          <span>Custom Web Site</span>
                        </li>
                        <li class="cont-dl">
                          <span>Blog</span>
                        </li>
                        <li class="cont-dl">
                          <span>Photo Gallery</span>
                        </li>   
                      </ul>
                      <ul>
                        <li class="text-center">
                          <button type="button" class="but-prc signup">GET STARTED</button>
                        </li>
                      </ul>
                  </li>
                  <li class="plan-section">
                      <ul>
                        <li class="pricing-typ">
                          <h4 class="">Professional</h4>
                          <h3><span>$</span>49.99/month</h3>
                        </li>
                      </ul>
                      <ul class="pd-lef">
                          <li class="cont-dl">
                            <span>  Custom Web Site</span>
                          </li>
                          <li class="cont-dl">
                            <span>Blog</span>
                          </li>
                          <li class="cont-dl">
                              <span>Photo Gallery</span>
                          </li> 
                           <li class="cont-dl">
                              <span>Online Booking</span>
                          </li> 
                           <li class="cont-dl">
                              <span>Email and Text Appointment Reminders</span>
                          </li> 
                           <li class="cont-dl">
                              <span>Customer Relationship Management</span>
                          </li> 
                      </ul>
                      <ul>
                        <li class="text-center">
                          <button type="button" class="but-prc signup">GET STARTED</button>
                        </li>
                      </ul>
                  </li>         
                </ul>
              </div>
            </div>
          </div>
        </div>
    </div>
    <!--- Pricing section ends --->
   <div class="col-md-12 form-web-otr" id="signup">
      <div class="col-sm-12 container-secn mx-auto p-0">
         <div class="row cont-otr-frm">
            <div class="col-sm-6 p-0 img-secn">
               <div class="col-sm-12 imgr"><img src="img/form-img.png"></div>
               <!-- triangle End-->
               <!-- triangle -->
               <div class="triangle-mdlm1 triangle-mdl-btmm1 cf">
                  <div class="t-1 wow fadeIn" data-wow-duration=".5s" data-wow-delay=".9s""></div>
                  <div class="t-2 wow fadeIn" data-wow-duration=".8s" data-wow-delay="1.5s""></div>
                  <div class="t-3 wow fadeIn" data-wow-duration="1s" data-wow-delay="1s""></div>
                  <div class="t-4 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.4s""></div>
                  <div class="t-5 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s""></div>
                  <div class="t-6 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.6s""></div>
                  <div class="t-7 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.7s""></div>
                  <div class="t-8 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.8s""></div>
                  <div class="t-9 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s""></div>
                  <div class="t-10 wow fadeIn"  data-wow-duration=".6s" data-wow-delay="1.2s""></div>
                  <div class="t-11 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.1s""></div>
                  <div class="t-12 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.2s""></div>
                  <div class="t-13 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.4s""></div>
               </div>
               <div class="triangle-btr cf">
                  <div class="t-1 wow fadeIn" data-wow-duration=".5s" data-wow-delay=".9s" ></div>
                  <div class="t-2 wow fadeIn" data-wow-duration=".8s" data-wow-delay="2s"></div>
                  <div class="t-3 wow fadeIn" data-wow-duration="1s" data-wow-delay="1s"></div>
                  <div class="t-4 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.4s"></div>
                  <div class="t-5 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s"></div>
                  <div class="t-6 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.6s"></div>
                  <div class="t-7 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.7s"></div>
                  <div class="t-8 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.8s"></div>
                  <div class="t-9 wow fadeIn" data-wow-duration="1s" data-wow-delay="1.5s"></div>
                  <div class="t-10 wow fadeIn"  data-wow-duration=".6s" data-wow-delay="1.2s"></div>
                  <div class="t-11 wow fadeIn" data-wow-duration="1s" data-wow-delay="2s"></div>
                  <div class="t-12  wow fadeIn" data-wow-duration="1s" data-wow-delay="2s"></div>
                  <div class="t-13  wow fadeIn" data-wow-duration="1s" data-wow-delay="2s"></div>
               </div>
            </div>
            <div class="col-sm-6 form-sec-otr">
               <div class="col-sm-12 cont-form-secn p-0">
                  <h3>
                     Sign up for your 
                     <br/>
                     <span>FREE trial,</span>Today!
                  </h3>
                  <h5>
                     Take the steps TODAY to fill your appointment book by completing the form below. Try out all features <!---FREE for 30 days,---> with no credit card required, and watch your business grow while simplifying your appointments. <span>Just fill out the form below!</span>
                  </h5>
               </div>
               <div class="container p-0">
                  <form role="form" action="admin/process_registration.cfm" method="POST" id="register_form" enctype="multipart/form-data" class="erroron_form">
                     <div class="panel panel-primary setup-content" id="step-1">
                        <div class="panel-body row">
                           <div class="col-sm-10 p-0 txt-frm-otr" >
                              <h4>Personal Information</h4>
                              <div class="col-sm-12 p-0 txt-frm">
                                 <label>First Name *</label>
                                 <div class="input-holder">
                                    <input type="text" placeholder="First Name *" class="form-control"  name="First_Name" required="required" value="">
                                 </div>
                              </div>
                              <div class="col-sm-12 p-0 txt-frm">
                                 <label>Last Name *</label>
                                 <div class="input-holder">
                                    <input type="text" placeholder="Last Name *" class="form-control" 
                                       name="Last_Name" required="required" value="">
                                 </div>
                              </div>
                             <!---  <div class="col-sm-12 p-0 txt-frm">
                                 <label>Create Password</label>
                                 <div class="input-holder">
                                    <input type="password" placeholder="Create Password *" class="form-control" required="required" id="Password" name="Password" minlength="3" maxlength="20">
                                    <span class="info-sec"><a data-toggle="popover"  data-trigger="hover" title="" data-content="Create any password you would like to login your account in the future.  Use a password that you can easily remember." data-original-title="Password"><i class="fas fa-info-circle"></i></a></span>
                                 </div>
                              </div> --->
                              <div class="col-sm-12 p-0 txt-frm" style="">
                                 <label>Email *</label>
                                 <div class="input-holder">
                                    <input type="email" placeholder="Email *" class="form-control" required="required" name="Email_Address" onChange="fnCheckEmailAddress()" id="Email_Address" value="">
                                    <span class="info-sec"><a data-toggle="popover" data-trigger="hover" title="" data-content="Your e-mail address will be used to log in to your account. Your personal e-mail address will not be published on your web site.  You will have the opportunity to add a company e-mail address, on the Company Information tab, which will be published if you would like." data-original-title="Email"><i class="fas fa-info-circle"></i></a></span>
                                 </div>
                              </div>
                              <input type="hidden" id="Web_Address" name="web_address" value="" >
                              <!--- <div class="clearfix"></div>
                              <div class="row">
                                <div class="col-sm-9  txt-frm">
                                   <label>Web Address </label>
                                      <div class="input-holder">
                                         <input type="text" placeholder="Web Address " class="form-control"  id="Web_Address" name="web_address" value="" onChange="fnCheckWebAddress()">
                                      </div>
                                </div>
                                <div class="col-sm-3 dot-cm-otr">
                                    <span class="dot-cm" style="font-size:12px;">.salonworks.com</span>
                                    <span class="info-sec-dot"><a data-toggle="popover" data-trigger="hover" title="Information" data-content="Enter the address you would like for your website. For example: mysite.salonworks.com"><i class="fas fa-info-circle"></i></a></span>
                                </div>
                              </div> --->
                              <div class="col-sm-12 p-0 txt-frm" >
                                 <label>Mobile Phone *</label>
                                 <div class="input-holder">
                                    <input type="text" placeholder="Mobile Phone *" class="form-control phone_us" name="Mobile_Phone" value="" required="required">
                                    <span class="info-sec"><a data-toggle="popover" data-trigger="hover" title="" data-content="A mobile number is required if you would like to receive text alerts when clients schedule appointments" data-original-title="Mobile Phone"><i class="fas fa-info-circle"></i></a>
                                    </span>
                                 </div>
                              </div>
                              <!--- <div class="col-sm-12 p-0 txt-frm ">
                                <div class="g-recaptcha" data-sitekey="6Lcsu3oUAAAAAPd4XSHG9EpISI2MRsB17dN4L27Q"></div>
                                   <input type="hidden" class="hiddenRecaptcha required" name="hiddenRecaptcha" id="hiddenRecaptcha">
                              </div> --->
                              <div class="col-sm-12 p-0 txt-frm-btn" style="margin-top:12px;">
                                <input type="hidden" value="firstsignup" id="firstsignup" name="firstsignup">
                                <input type="submit" value="Finish" class="frms-btn finishBtn">
                            </div>
                          </div>
                        </div>
                     </div>
                </form>
            </div>
        </div>
    </div>
  </div>
</div>
<div class="free-demo-btn">
  <a data-toggle="modal" href="#freeDemoModal">
    <span>Schedule A Free Demo</span>
  </a>
</div>
<!--- Form for personal demo registration --->
<!-- The Modal Free Demo >> -->
<div class="modal fade loginModal freedemo" id="freeDemoModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->

      <!-- Modal body -->
      <div class="modal-body">
        <button type="button" class="close " data-dismiss="modal" id="demo_close">&times;</button>
        <h4 class="modal-title">Schedule a free demo</h4>
        <br>
        Let us show you how SalonWorks can simplify running your business.<br><br> 
        Fill out the form below and an expert will contact you to schedule a personal demonstration. 
       <form action="#" name="personolized_demo_form" id="personolized_demo_form" method="POST" class="erroron_form">
          <div class="row">
          <div class="form-group col-md-6">
            <input type="text" class="form-control" placeholder="First Name" required="required" name="first_name_demo">
          </div>
           <div class="form-group col-md-6">
            <input type="text" class="form-control" id="pwd" placeholder="Last Name" required="required" name="last_name_demo">
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-12">
            <input type="text" class="form-control" placeholder="Email" required="required" name="email_id_demo">
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-12">
            <input type="text" class="form-control" placeholder="Phone" required="required" name="mobile_phone_demo">
          </div>
        </div>
        
          <!-- <div class="form-group form-check">
            <label class="form-check-label">
              <input class="form-check-input" type="checkbox"> Remember me
            </label>
          </div> -->
          <button type="submit" class="btn btn-block btn-primary" name="personolized_demo_btn">Schedule A Free Demo</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- The Modal Free Demo  << -->

<script>
   $(document).ready(function(){
     
      $('.social_url').keyup(function(){
          var socialId = $(this).data('social_url_id');
          console.log(socialId);
         switch (socialId) {
            case 1:
               if (($(this).val().length > 0) && ($(this).val().substr(0,24) != 'http://www.facebook.com/')
                || ($(this).val() == '')){
                  $(this).val('http://www.facebook.com/');    
               }
               break;
            case 2:
               if (($(this).val().length > 0) && ($(this).val().substr(0,23) != 'http://www.twitter.com/')
                || ($(this).val() == '')){
                  $(this).val('http://www.twitter.com/');    
               }
               break;
            case 3:
               if (($(this).val().length > 0) && ($(this).val().substr(0,24) != 'https://plus.google.com/')
                || ($(this).val() == '')){
                  $(this).val('https://plus.google.com/');    
               }
               break;
            case 4:
               if (($(this).val().length > 0) && ($(this).val().substr(0,23) != 'http://www.youtube.com/')
                || ($(this).val() == '')){
                  $(this).val('http://www.youtube.com/');    
               }
               break;
            case 5:
               if (($(this).val().length > 0) && ($(this).val().substr(0,26) != 'https://www.pinterest.com/')
                || ($(this).val() == '')){
                  $(this).val('https://www.pinterest.com/');    
                }
                break;
                case 6:
                if (($(this).val().length > 0) && ($(this).val().substr(0,25) != 'https://www.linkedin.com/')
                || ($(this).val() == '')){
                  $(this).val('https://www.linkedin.com/');    
               }
            break;
         }
          
      });

   });
         
</script>
<cfinclude template="site_footer.cfm">
<!--- SalonWorks.com Footer --->
<!--- if the subdomain is a valid customer site, render the customer site --->
<cfelse>
  
<cfinclude template="./customer_sites/index.cfm">
<!--- Customer Homepage --->
</cfif>