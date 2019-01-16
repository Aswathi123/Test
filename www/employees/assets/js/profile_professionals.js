$('.phone_us').mask('(000) 000-0000');

var initDialog = function($dialog, okBtnAction){
	$dialog.removeClass('hide').dialog({
		modal: true,
		buttons: [ 
			{
				text: "Cancel",
				"class" : "btn btn-xs",
				click: function() {
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
	
$('.changeProfPassword').on('click', function() {
	
	var $dialog = $('#dialog-changepassword');
	var $changepass_form = $dialog.find('#changepass_form');
	
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
			url: '/admin/professionals.cfc?method=UpdateProfessional&returnFormat=JSON',
			dataType: 'json',
			type: 'post',
			data: $changepass_form.serialize(),
			success: function(data){
				if (data  === true) {
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

$('.submitFrmData').on('click', function(){
	var $form = $(this).closest("form");
	
	$form.validate();
	
	if ( !$form.valid() )
		return false;
	
	$('#Bio').val( $('#Bio_summernote').code() );
	
	$.ajax({
		url: 'professionals.cfc?method=UpdateProfessional&returnformat=json',
		dataType: 'json',
		type: 'POST',
		data: $form.serialize(),
		success: function(data) {
			if (data === true) {
				$('#professional_msg').attr('class', 'alert alert-success');
				$('#professional_msg').html('Professional was successfully updated.');
			}
			else {
				$('#professional_msg').attr('class', 'alert alert-error');
				$('#professional_msg').html(data);
			}
			$('#btn-scroll-up').toggle();
		}
	});
	
});
