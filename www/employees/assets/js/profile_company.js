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

$('.submitFrmData').on('click', function(){
	var $form = $(this).closest("form");
	
	if ( $form.find('#company_id').val() == 0 ) {
		$.ajax({
			url: 'company.cfc?method=InsertCompany&returnformat=json',
			dataType: 'json',
			type: 'POST',
			data: {
				Web_Address: $form.find('#Web_Address').val()
			},
			success: function(data) {
				$form.find('#company_id').val(data);
			}
		});
	}
	
	//var data_post = $form.serialize();
	//var comp_desc = $('#Company_Description').code();
	//data_post = data_post + "&Company_Description=" + comp_desc;
	
	$('#Company_Description').val( $('#Company_Description_summernote').code() );
	
	$.ajax({
		url: 'company.cfc?method=UpdateCompany&returnformat=json',
		dataType: 'json',
		type: 'POST',
		data: $form.serialize(),
		success: function(data) {
			if (data === true) {
				$('#company_msg').attr('class', 'alert alert-success');
				$('#company_msg').html('Company was successfully updated.');
			}
			else {
				$('#company_msg').attr('class', 'alert alert-error');
				$('#company_msg').html(data);
			}
			$('#btn-scroll-up').toggle();
		}
	});
	
});
