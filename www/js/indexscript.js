function inputFocus(i){
        if(i.value==i.defaultValue){ i.value="";  }
      }
      
      function inputBlur(i){
        if(i.value==""){ i.value=i.defaultValue; }
      }
      
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
       
        
      // $("#First_Name").blur(function() {
      //    $("#Contact_Name").val($("#First_Name").val()+" "+$("#Last_Name").val());
      // });
      
      // $("#Last_Name").blur(function() {
      //    alert(1);
      //    $("#Contact_Name").val($("#First_Name").val()+" "+$("#Last_Name").val());
      // });
      // $("#Company_Address").blur(function() {
      //    $("#Location_Address").val($("#Company_Address").val());
      // });
      // $("#Company_Address2").blur(function() {
      //    $("#Location_Address2").val($("#Company_Address2").val());
      // });
      // $("#Company_City").blur(function() {
      //    $("#Location_City").val($("#Company_City").val());
      // });
      // $("#Company_State").blur(function() {
      //    $("#Location_State").val($("#Company_State").val());
      // });
      // $("#Company_Postal").blur(function() {
      //    $("#Location_Postal").val($("#Company_Postal").val());
      // });
      // $("#Company_Phone").blur(function() {
      //    $("#Location_Phone").val($("#Company_Phone").val());
      // });
      // $("#Company_Fax").blur(function() {
      //    $("#Location_Fax").val($("#Company_Fax").val());
      // });
      
      $("#Begin_2").change(function() {
         console.log($("#Begin_2").val());
         console.log($('#End_2').val());
         if(($("#Begin_2").val() != 'Closed') &&  $('#End_2').val() == "Closed") {
           alert("Please choose a 'To' value");
         }
         $("#Begin_3").val($("#Begin_2").val());
         $("#Begin_4").val($("#Begin_2").val());
         $("#Begin_5").val($("#Begin_2").val());
         $("#Begin_6").val($("#Begin_2").val());
         $("#Begin_7").val($("#Begin_2").val());
      });
      $("#End_2").change(function() {
         if(($("#Begin_2").val() == 'Closed') &&  $('#End_2').val() != "Closed") {
           alert("Please choose a 'From' value");
         }
         $("#End_3").val($("#End_2").val());
         $("#End_4").val($("#End_2").val());
         $("#End_5").val($("#End_2").val());
         $("#End_6").val($("#End_2").val());
         $("#End_7").val($("#End_2").val());
      });
      
      $("#Begin_3").change(function() {
         $("#Begin_4").val($("#Begin_3").val());
         $("#Begin_5").val($("#Begin_3").val());
         $("#Begin_6").val($("#Begin_3").val());
         $("#Begin_7").val($("#Begin_3").val());
      });
      $("#End_3").change(function() {
         $("#End_4").val($("#End_3").val());
         $("#End_5").val($("#End_3").val());
         $("#End_6").val($("#End_3").val());
         $("#End_7").val($("#End_3").val());
      });
      // $('.Editor-editor').click(function() {
      //    $("#bio").val($('.Editor-editor').html());
      // });
      // $("#bio").next().change(function() {
      //    $("#bio").val($('.Editor-editor').html());
      // });
      $("#Company_Description").next().change(function() {
         $("#Company_Description").val($('.Editor-editor').html());
      });

      $('#msgLogin').hide();
      $('#msgLogin').html('');

      $('#loginBtn').on('click', function(){
         $('#msgLogin').hide();
         $('#msgLogin').html('');
         $( "#loginFrm" ).validate({});
         if ( !$( "#loginFrm" ).valid())
            return false;
      
         $.ajax({
            url: 'admin/login.cfc?method=login&returnFormat=JSON',
            dataType: 'json',
            type: 'POST',
            data: $('#loginFrm').serialize(),
            success: function(data){
               if( data == true ) {
                  $( "#loginFrm" ).submit();
               }
               else {
                  $('#msgLogin').html('Invalid Email or password!.');
                  $('#msgLogin').show();
                  setTimeout(function() {
                    $('#msgLogin').hide();
                     $('#loginFrm')[0].reset();
                  }, 5000);
               }
            },
            error: function(){}
         });
      });
      
      $('#freeTrial').on('click', function(){
         $("#login-modal").modal('hide');
      });
      $('#forgotPassButton').on('click', function(){
         $("#login-modal").modal('hide');
         $("#forgotPass").modal('show');
      });

      $('#forgotPassSubmit').on('click', function(){
         var email=$.trim($('#forgotPassEmail').val());
         console.log(email);
          $( "#forgotPassForm" ).validate({});
         if(! $("#forgotPassForm").valid()){
            return false;
         } 
         else{
            $.ajax({
               url: "cfc/customers.cfc?method=forgotPassword&showtemplate=false",
               type: 'POST',
               data:{email:email},
               success: function(data){
                  console.log(data);
                  if(data==1){
                     $("#modalForgotPassword").modal('hide');
                     $("#emailsuccess").modal('show');
                  }
                  else{
                     alert("Invalid email address.Make sure this is your registered email address");
                  }
               },
            });
         }
      });
     /* jQuery.validator.addMethod("alphanumeric", function(value, element) {
       return this.optional(element) || /^[\w.]+$/i.test(value);
   }, "Letters, numbers, and underscores only please");*/
      
      jQuery.validator.addMethod("alphanumeric", function(value, element) {
       return this.optional(element) || /^[a-zA-Z0-9]+(?:--?[a-zA-Z0-9]+)*$/.test(value);
   }, "Letters, numbers, and underscores only please");
      //$("#register_form").validate();
      
      $( "#register_form" ).validate({
         ignore: [".ignore"],
         rules: {
            Mobile_Phone: {
            required: true,
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
            Location_Name:{
            required: true
            },
            Location_Phone:{
            required: true,
            phoneUS: true
            },
            
            Company_Fax:{
            required: false,
            phoneUS: true
            },
            Company_city:{
            required: true
            },
            Company_Email:{
            required: false,
            email: true
            },
            
            Location_Fax:{
            required: false,
            phoneUS: true
            },
            Location_Postal:{
            required: true,
            zipcodeUS:true
            },
            Email_Address:{
            required: true,
            email: true
            },
            Company_Postal:{
            required: true,
            zipcodeUS:true
            },
            Password:{
            required: true,
            minlength:3,
            maxlength:20
            },
            
            First_Name:{
               required: true
            },
            Last_Name:{
               required: true
            },
            
            Company_Name:{
               
               required: true
            },
            
            Company_State:"required",
            hiddenRecaptcha: {
                required: function () {
                    if (grecaptcha.getResponse() == '') {
                        return true;
                    } else {
                        return false;
                    }
                }
            },
         },
          messages: {
            First_Name:{
               required: "First name is required"
            },
            Last_Name:{
               required: "Last name is required"
            },
            Password : {
            required: "Password is required",
            minlength: "Your password must be at least 3 characters long",
            maxlength: "Your password must be at most 20 characters long"
            },
            Email_Address:{
            required: "Email is required",
            },
            Company_Postal:{
            required: "Company postal is required",
            },
            Company_Phone:{
            required: "Company phone is required",
            },
            Location_Postal:{
            required: "Location postal is required",
            },
            Location_Phone:{
            required: "Location phone is required",
            },
            hiddenRecaptcha:{
            required: "Click I am not a robot",
            },
            
            Company_Name :{
               required:"Company name is required",
            },
            Company_Address: "Company address is required",
            Mobile_Phone: {
               required:"Mobile phone is required"},
            Company_State: "Company state is required",
            Company_city: "Company city is required",
            Contact_Name :"Contact name is required",
            Location_Name: "Location name is required",
            Location_Address :"Location address is required",
            Location_City: "Location city is required",
          }
      });

      //Personolized_demo_form
       $("#demo_close").click(function() {
          validator.resetForm();
         });
    var validator =  $( "#personolized_demo_form" ).validate({
            ignore: [".ignore"],
            rules: {
               mobile_phone_demo: {
               required: true,
               phoneUS: true
               },
               email_id_demo:{
               required: true,
               email: true
               },
               first_name_demo:{
                  required: true
               },
               last_name_demo:{
                  required: true
               }
            },
             messages: {
               first_name_demo:{
                  required: "First name is required"
               },
               last_name_demo:{
                  required: "Last name is required"
               },
               email_id_demo:{
               required: "Email is required",
               },
               mobile_phone_demo: {
                  required:"Mobile phone is required"
               }
             }
      });     
   });