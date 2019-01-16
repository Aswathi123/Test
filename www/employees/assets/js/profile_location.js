$('.phone_us').mask('(000) 000-0000');

$('.submitFrmData').on('click', function(){
	var $form = $(this).closest("form");
	
	$form.validate();
	
	if ( !$form.valid() )
		return false;
	
	$.ajax({
		url: 'location.cfc?method=UpdateLocation&returnformat=json',
		dataType: 'json',
		type: 'POST',
		data: $form.serialize(),
		success: function(data) {
			if (data === true) {
				$('#location_msg').attr('class', 'alert alert-success');
				$('#location_msg').html('Location was successfully updated.');
			}
			else {
				$('#location_msg').attr('class', 'alert alert-error');
				$('#location_msg').html(data);
			}
			$('#btn-scroll-up').toggle();
		}
	});
	
});
