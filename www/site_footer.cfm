<a href="#" id="to-top" class="iconWrapper"><i class="fa fa-chevron-up" aria-hidden="true"></i></a>
<cfif not structKeyExists(url, 'ucode')>
  <footer class="footer" >
   <div class="container-fluid container-secn featr-otr mx-auto">
      <div class="row">
         <div class="col-sm-4 ft-img">
          <cfif not structKeyExists(url, 'ucode')>
            <img src="img/logo-f.png">
          </cfif>
         </div>
         <cfif not structKeyExists(url, 'ucode')>
           <div class="col-sm-2 ft-list">
              <ul class="footer_list">
                 <li>
                    <a href="#" class="">HOME</a>
                 </li>
                 <li>
                    <a href="#" class="feature">FEATURES</a>
                 </li>
                 <li>
                  <a href="#" class="pricing">PRICING</a>
                </li>
                 <li>
                    <a href="" class="support" data-toggle="modal" data-target="#modalSupport">SUPPORT</a>
                 </li>
                 <li>
                    <a href="#" class="signup">SIGN UP FOR FREE</a>
                 </li>
              </ul>
           </div>

           <div class="col-sm-3 sal-txt">
              <h3>SALON WORKS</h3>
              <div class="col-sm-12 p-0 sl-desc">
                 Salon and spa management tool designed to bring simplicity to growing your clientele and operating your business in the digital age.
              </div>
           </div>
           <div class="col-sm-3 sal-txt plf">
              <h3>CONTACT US</h3>
              <div class="col-sm-12 p-0 sl-icn">
                 <i class="fas fa-phone ph-sec"></i> <span>(978) 352-0235</span>
              </div>
              <div class="col-sm-12 p-0 sl-icn">
                 <i class="fas fa-envelope"></i> <span>salonworks@salonworks.com</span>
              </div>
           </div>
         <cfelse>
            <div class="col-sm-3 sal-txt plf">
              <ul class="trm">
                  <li><a href="http://salonworks.com/" target="_blank">Powered by SalonWorks.com</a> </li>
               </ul>
           </div>
         </cfif>
      </div>
   </div>
   <cfif not structKeyExists(url, 'ucode')>
     <div class="col-sm-12 p-0 ftr-pd">
        <div class="container-fluid container-secn featr-otr mx-auto">
           <div class="row">
              <div class="col-sm-6">
                 <ul class="trm">
                    <li><a href="terms.cfm">Terms and conditions</a> </li>
                    <li>Copyright 2013 - 2018 ©SalonWorks</li>
                 </ul>
              </div>
              <div class="col-sm-6 text-right sl-otr">
                 <ul class="social">
                    <li>Follow Us on</li>
                    <li><a href="https://www.facebook.com/pages/Salonworks/1434509316766493"><i class="fab fa-facebook-f"></i></a></li>
                 </ul>
              </div>
           </div>
        </div>
     </div>
    </cfif>
</footer>
<cfelse>
  <footer class="footer" style=" padding: 0px 25px 15px;min-height: 55px">
   <div class="container-fluid container-secn featr-otr mx-auto">
      <div class="row">
         <div class="col-sm-4 ft-img">
          <cfif not structKeyExists(url, 'ucode')>
            <img src="img/logo-f.png">
          </cfif>
         </div>
         <cfif not structKeyExists(url, 'ucode')>
           <div class="col-sm-2 ft-list">
              <ul class="footer_list">
                 <li>
                    <a href="#" class="">HOME</a>
                 </li>
                 <li>
                    <a href="#" class="feature">FEATURES</a>
                 </li>
                 <li>
                    <a href="" class="support" data-toggle="modal" data-target="#modalSupport">SUPPORT</a>
                 </li>
                 <li>
                    <a href="#" class="signup">SIGN UP FOR FREE</a>
                 </li>
              </ul>
           </div>

           <div class="col-sm-3 sal-txt">
              <h3>SALON WORKS</h3>
              <div class="col-sm-12 p-0 sl-desc">
                 Salon and spa management tool designed to bring simplicity to growing your clientele and operating your business in the digital age.
              </div>
           </div>
           <div class="col-sm-3 sal-txt plf">
              <h3>CONTACT US</h3>
              <div class="col-sm-12 p-0 sl-icn">
                 <i class="fas fa-phone ph-sec"></i> <span>(978) 352-0235</span>
              </div>
              <div class="col-sm-12 p-0 sl-icn">
                 <i class="fas fa-envelope"></i> <span>salonworks@salonworks.com</span>
              </div>
           </div>
         <cfelse>
            <div class="col-sm-3 sal-txt plf">
              <ul class="trm">
                  <li><a href="http://salonworks.com/" target="_blank">Powered by SalonWorks.com</a> </li>
               </ul>
           </div>
         </cfif>
      </div>
   </div>
   <cfif not structKeyExists(url, 'ucode')>
     <div class="col-sm-12 p-0 ftr-pd">
        <div class="container-fluid container-secn featr-otr mx-auto">
           <div class="row">
              <div class="col-sm-6">
                 <ul class="trm">
                    <li><a href="terms.cfm">Terms and conditions</a> </li>
                    <li>Copyright 2013 - 2018 ©SalonWorks</li>
                 </ul>
              </div>
              <div class="col-sm-6 text-right sl-otr">
                 <ul class="social">
                    <li>Follow Us on</li>
                    <li><a href="https://www.facebook.com/pages/Salonworks/1434509316766493"><i class="fab fa-facebook-f"></i></a></li>
                 </ul>
              </div>
           </div>
        </div>
     </div>
    </cfif>
</footer>
</cfif>

<!-- The Modal loading Promotional>> -->
<!--- 03-10-18 Commented promotional modal --->
<!--- <div class="modal fade modal-load" id="modalLoad">
   <div class="modal-dialog">
      <div class="modal-content">
         <!-- Modal Header -->
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <!-- Modal body -->
         <div class="modal-body">
            <div class="col-md-6 md-content float-left">
               <h3>Welcome to the <br/>SalonWorks Soft Opening!</h3>
               <h4>Sign up for an absolutely <a class="fr-ac signup-trial">Free account</a>
                  that will make running your day-to-day business more efficient
               </h4>
               <div class="col-md-12 p-0 sub-content">
                  We would like to extend an offer to you to try our new website featuring our appointment booking system. Bring your business online by allowing your clients to book their own appointments, reduce no-shows with client text reminders, and much more.
                  <br/>
                  <br/>
                  This is not a trial, but it is a promotion for you to use our product at no cost to you. To take advantage of this offer, simply sign up before 9/30/2018. All registrations before that date will be free for life. All we ask is that you give us honest feedback. That's it!! There is absolutely no risk to you.
                  <br/>
                  <br/>
                  If you have any questions or comments you can contact us using the information below.
                  <br/>
                  <span class="eml">salonworks@salonworks.com</span>
               </div>
            </div>
            <div class="col-md-6 md-bg-img float-left">
               <div class="col-md-12 text-center">
                  <input type="button" value="View a demo site" class="demo-site-but" onclick="window.open('http://demo.salonworks.com');">
               </div>
               <div class="col-md-12 text-center or-option">
                  OR
               </div>
               <div class="col-md-12 text-center">
                  <input type="button" value="Watch our video" class="video-but" >
               </div>
            </div>
         </div>
      </div>
   </div>
</div> --->
<!-- The Modal loading<< -->
<!-- The Modal login >> -->
<div class="modal fade loginModal" id="modalLogin">
   <div class="modal-dialog">
      <div class="modal-content">
         <!-- Modal Header -->
         <!-- Modal body -->
         <div class="modal-body">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Log In</h4>
            <form action="<cfoutput>#strPath#</cfoutput>admin/login.cfm" id="loginFrm" method="POST" class="erroron_form">
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
               <button type="button" id="loginBtn" class="btn btn-block btn-primary">Log In</button>
               <div id="msgLogin" style="color:red; display:none;margin-top:10px;text-align: center;">&nbsp;</div>
            </form>
            <a class="float-right link-default" data-dismiss="modal" data-toggle="modal" href="#modalForgotPassword">Forgot password?</a>
         </div>
         <!-- Modal footer -->
         <div class="modal-footer">
            <p>
               Don't have an account? <br>
               <a class="signup-trial">Sign up for your FREE 30 Day Trial now!</a>
            </p>
         </div>
      </div>
   </div>
</div>
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
               <button type="button" class="btn btn-block btn-primary" id="forgotPassSubmit">Send Mail</button>
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
               <button type="submit" class="btn btn-block btn-primary" name="submit">Submit</button>
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
<script src="<cfoutput>#strPath#</cfoutput>js/vendor/jquery-3.3.1.slim.min.js"></script>
<script src="<cfoutput>#strPath#</cfoutput>js/vendor/wow.min.js"></script>
<script src="<cfoutput>#strPath#</cfoutput>js/main.js"></script>
<script src="js/editor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/css3-animate-it.js"></script>
<script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/summernote.js"></script>
<!--- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.10/jquery.mask.js"></script> --->
<!---<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>--->
<script src="<cfoutput>#strPath#</cfoutput>js/validate.min.js"></script>
<script type="text/javascript" src="<cfoutput>#strPath#</cfoutput>js/jquery.validate.additional-methods.min.js"></script>

<!---<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>--->
<script type="text/javascript" src="js/error_messages.js"></script>
<!---<script type="text/javascript">
jQuery.curCSS = function(element, prop, val) {
    return jQuery(element).css(prop, val);
};
</script>--->
<!---<script type="text/javascript">
   $(document).ready(function(){  
      if (window.location.search.indexOf('ucode') > -1) {      
        $('#modalLoad').modal('hide');
      }else {
        $('#modalLoad').modal('show');
      }
    }); 
</script> --->
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
<script type="text/javascript">
   $(document).ready(function() {
       $('html,body').animate({
   
           scrollTop: $(window.location.hash).offset().top - 90
       }, 500);
   
   });
</script>
<script type="text/javascript">
   jQuery(document).ready(function() {
       jQuery('.play').click(function(event) {
           event.preventDefault();
           //var url = $(this).html(); //this will not work  
           $(".js-video").append('<iframe width="100%" height="421" src="//www.youtube.com/embed/Jz-W4mLjkwA?rel=0&amp;autoplay=1&amp;html5=1" frameborder="0" allowfullscreen=""></iframe>');
           $(this).hide();
           //$('video-poster').css('z-index','-1');
   
       });
   });
</script>
<script type="text/javascript">
   // Check distance to top and display back-to-top.
   $(window).scroll(function() {
       if ($(this).scrollTop() > 800) {
           $('.iconWrapper').addClass('show-back-to-top');
       } else {
           $('.iconWrapper').removeClass('show-back-to-top');
       }
   });
   // Click event to scroll to top.
   $('.iconWrapper').click(function() {
       $('html, body').animate({
           scrollTop: 0
       }, 800);
       return false;
   });
</script>
<script>
   $(document).ready(function() {
       $(".feature").click(function() {
           $('html,body').stop(true, false).animate({
   
               scrollTop: $(".featr-otur").offset().top - 90
           }, 500);
           return false;
           $('html,body').animate({
   
               scrollTop: $(window.location.hash).offset().top - 90
           }, 500);
   
       });
       $(".pricing").click(function() {
           $('html,body').stop(true, false).animate({
   
               scrollTop: $(".pricing-secn").offset().top - 80
           }, 1000);
           return false;
           $('html,body').animate({
   
               scrollTop: $(window.location.hash).offset().top - 90
           }, 500);
       });
   
       $(".signup").click(function() {
           $('html,body').stop(true, false).animate({
   
               scrollTop: $(".form-web-otr").offset().top - 80
           }, 1000);
           return false;
           $('html,body').animate({
   
               scrollTop: $(window.location.hash).offset().top - 90
           }, 500);
       });
   $(".signupid2").click(function() {
           $('html,body').stop(true, false).animate({
   
               scrollTop: $(".form-web-otr").offset().top - 80
           }, 1000);
           return false;
           $('html,body').animate({
   
               scrollTop: $(window.location.hash).offset().top - 90
           }, 500);
       });
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
      /* $('#modalLoad').modal('hide');*/
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
      /* $('#modalLoad').modal('hide');*/
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
       errorFlag = 0;
       fnCheckEmailAddress = function() {
        errorFlag = 0;
           if ($('#Email_Address').val().length) {
   
               $.ajax({
                   type: "get",
                   url: "<cfoutput>#strPath#</cfoutput>admin/company.cfc",
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
                                errorFlag = 1;
                           }
   
                       } else {
                           alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help.');
                           errorFlag = 1;
                       }
                   },
                    
                   error: function(objRequest, strError) {
                       alert('Error: There is a problem with the system.  Please try again.  If problem presist, contact site help. ' + strError);
                       errorFlag = 1;
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
                       url: "<cfoutput>#strPath#</cfoutput>admin/company.cfc",
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
      $('.finishBtn').click(function() {
        console.log(errorFlag);
        if ( $( "#register_form" ).valid() && errorFlag ==0 ) {
          $( "#register_form" ).submit();
           // $('#video-learn iframe').attr("src", jQuery("#video-learn iframe").attr("src"));
        } else {
          return false;
        }
       });
       $('.close').click(function() {
           console.log(1);
           // $('#video-learn iframe').attr("src", jQuery("#video-learn iframe").attr("src"));
       });
   });
</script>
</body>
</html>