$(document).ready(function(){
	 if (window.location.search.indexOf('showPage=profile_professionals') > -1) {
        $('#professional_msg').removeClass('hide');
        setTimeout(function(){
          $('#professional_msg').addClass('hide');
          }, 6000);
      }

	$('.phone_us').mask('(000) 000-0000');

	var initDialog = function($dialog, okBtnAction){
		$dialog.removeClass('hide').dialog({
			modal: true,
			buttons: [ 
				{
					text: "Cancel",
					"class" : "btn btn-xs",
					click: function() {
						var $changepass_form = $dialog.find('#changepass_form');
						$changepass_form[0].reset();
						$('#page-content').load('professionals_form.cfm');
						$( this ).dialog( "close" ); 
					} 
				},
				{
					text: "OK",
					"class" : "btn btn-primary btn-xs",
					click: function() {
						okBtnAction();
					} 
				}
			]
		});
	}
	$("#changepass_form").validate({
	        rules: {
	          password:{
	          required: true,
	          minlength: 3
	          },
	           Confirm_Password:{
	          required: true
	          },
	        },
	        messages:{
	          password:{
	            required: "Password is required",
	            minlength:"Atleast 3 characters required"
	          },
	          Confirm_Password:{
	            required: "Password is required"
	          },
	        }
	       }); 
		
	$('.changeProfPassword').on('click', function() {
		
		var $dialog = $('#dialog-changepassword');
		var $changepass_form = $dialog.find('#changepass_form');
		console.log( $changepass_form);
		$changepass_form[0].reset();
		$dialog.find('#changePassMsg').hide();
		
		okBtnAction = function() {
			$changepass_form.validate();
			
			if ( !$changepass_form.valid() )
				return false;
			
			if ( $changepass_form.find('#password').val() != $changepass_form.find('#Confirm_Password').val() ) {
				$dialog.find('#changePassMsg').show();
				return false;
			}
					
			$.ajax({
				url: 'professionals.cfc?method=UpdateProfessional&returnFormat=JSON&passwordStatus=1',
				dataType: 'json',
				type: 'post',
				data: $changepass_form.serialize(),
				success: function(data){
					if (data.VALUE  === true) {
						$dialog.find('#changePassMsg').attr('class','alert alert-success');
						$dialog.find('#changePassMsg').html('The password was changed successfully.');
					}
					else {
						$dialog.find('#changePassMsg').attr('class','alert alert-danger');
						$dialog.find('#changePassMsg').html(data);
						
					}
					$dialog.find('#changePassMsg').show();
					
					$dialog.dialog({ buttons: [
						{
							text: "Close",
							"class" : "btn btn-xs",
							click: function() {
								$('#page-content').load('changepass_form');
								$dialog.dialog( "close" );
							} 
						}
					]});
				}
			});
		}

		initDialog( $dialog,  okBtnAction);
		
	});

	$('#Bio_summernote').summernote({
		//height: 200,
	  	focus: false,
	    toolbar: [
	      ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
	      ['fontsize', ['fontsize']],
	      ['color', ['color']],
	      ['para', ['ul', 'ol', 'paragraph']]
	    ]
	});

	$('.submitFrmDataprofessional').on('click', function(){
		var $form = $(this).closest("form");
		
		$form.validate({
			rules: {
			    Email_Address:{
				required: true,
				email: true
				},
			}
		});
		
		if ( !$form.valid() )
			return false;
		
		$('#Bio').val( $('#Bio_summernote').code() );
		$('#register_form_professional').submit();
		// $.ajax({
		// 	url: 'professionals.cfc?method=UpdateProfessional&returnformat=json',
		// 	dataType: 'json',
		// 	type: 'POST',
		// 	data: $form.serialize(),
		// 	success: function(data) {
		// 		if (data === true) {
		// 			$('#professional_msg').attr('class', 'alert alert-success');
		// 			$('#professional_msg').html('Professional was successfully updated.');
		// 		}
		// 		else {
		// 			$('#professional_msg').attr('class', 'alert alert-error');
		// 			$('#professional_msg').html(data);
		// 		}
		// 		$('#btn-scroll-up').toggle();
		// 	}
		// });

	});
    
});
