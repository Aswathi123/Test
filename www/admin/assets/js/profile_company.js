$('.phone_us').mask('(000) 000-0000');

$('#Company_Description_summernote').summernote({
	//height: 200,
  	focus: false,
    toolbar: [
      ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
      ['fontsize', ['fontsize']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']]
    ]
});

$(document).ready(function(){
	 if (window.location.search.indexOf('showPage=profile_company') > -1) {
        $('#company_msg').removeClass('hide');
        setTimeout(function(){
          $('#company_msg').addClass('hide');
          }, 6000);
      }
//For social media url
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
$('.submitFrmDataCompany').on('click', function(){
	var $form = $(this).closest("form");
	console.log($form);
	$( "#register_form_company" ).validate({
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
		},
		Company_Email:{
		required: false,
		email: true
		},
		Company_Postal:{
		required: true,
		zipcodeUS:true
		},

		}
	});
	
	if($("#register_form_company").valid()){
		$('#Company_Description').val( $('#Company_Description_summernote').code() );
		$('#register_form_company').submit();
	}
	else {
		alert('Please fill out all required fields');
	}

});
