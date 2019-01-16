$.ajaxSetup({cache:false});

// detect browser scroll bar width
var scrollDiv = $('<div class="scrollbar-measure"></div>')
	.appendTo(document.body)[0],
	scrollBarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth;

$(document)
.on('hidden.bs.modal', '.modal', function(evt) {
	// use margin-right 0 for IE8
	$(document.body).css('margin-right', '');
})
.on('show.bs.modal', '.modal', function() {
	// When modal is shown, scrollbar on body disappears.  In order not
	// to experience a "shifting" effect, replace the scrollbar width
	// with a right-margin on the body.
	if ($(window).height() < $(document).height()) {
		$(document.body).css('margin-right', scrollBarWidth + 'px');
	}
});
function leapYear(year)
		{
		  return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
		}
$(document).ready(function() {
	var isleapyear = false;
		$('#year').on("click",function() {
			var yearid = $('#year').val();
			if(yearid != '') {
				var year = $("#year option:selected").text();
				var leapyear = leapYear(year);
				if(leapyear == true) {
					isleapyear = true;
					$("#day option[value='29']").attr("disabled",false);
				}else {
					isleapyear = true;
					$("#day option[value='29']").attr("disabled",true);
				}
			}
		});

		$('#month').on("click",function() {
			var monthid = $('#month').val();
			console.log(isleapyear);
			var yearid = $('#year').val();
			if(yearid != '') {
				var year = $("#year option:selected").text();
				var leapyear = leapYear(year);
				if(leapyear == true) {
					isleapyear = true;
				}
			}
			if(monthid == 2){
				if(isleapyear == true) {
					$("#day option[value='29']").attr("disabled",false);
				}else {
					$("#day option[value='29']").attr("disabled",true);
				}
				$("#day option[value='30']").attr("disabled",true);
				$("#day option[value='31']").attr("disabled",true);
			}
			
			else if(monthid == 4){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 6){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 9){
				$("#day option[value='31']").attr("disabled",true);
			}
			else if(monthid == 11){
				$("#day option[value='31']").attr("disabled",true);
			} else{
				$("#day option[value='29']").attr("disabled",false);
				$("#day option[value='30']").attr("disabled",false);
				$("#day option[value='31']").attr("disabled",false);
			}
		});
	$('a.mainmenu').each(function() {
		$(this).on('click' ,function(){
			$(this).parent().parent().find('li').each(function() {
				$(this).removeClass("active");
			});
			$(this).parent().addClass("active");
		});
	});
	/*
	$('#a_onlinebooking').on('click' ,function(){
		$('#page-content').load('appointments.cfm');
	});*/
	
	$('.a_signin').on('click' ,function(){
		$('#frmSignin')[0].reset();
		$('#signinModal').modal('show');
		$('#signin-msg').hide();
	});
	
	$('#a_signout').on('click' ,function(){
		$.ajax({
			type: "get",
			url: "/cfc/customers.cfc?method=logoutCustomer",
			dataType: "html",
			success: function (data){
				// $('#sign-in').removeClass('hideDiv');
				// $('#profile-menu').addClass('hideDiv');
				$('.user-email').html('');
				$('.user-name').html('');
				window.location.href='index.cfm';
			}
		});
	});
	
	$('.btnSignin').on('click', function() {
		var $frmSignin = $('#frmSignin');
		$frmSignin.validate();

		if( !$frmSignin.valid() )
			return false;

		$.ajax({
			type: "get",
			url: "/cfc/customers.cfc?method=loginCustomer",
			data: $frmSignin.serialize(),
			dataType: "json",
			success: function (data){
				console.log(data);
				if (data.SUCCESS == true) {	
					$('#sign-in').addClass('hideDiv');					
					$('.user-email').html(data.EMAIL_ADDRESS);
					$('.user-name').html(data.NAME);
					$('#profile-menu').removeClass('hideDiv');				
					$('#signinModal').modal('hide');
							
					//refresh page
					if ( $('#a_onlinebooking').parent().hasClass('active') )
						/*$('#page-content').load('appointments.cfm');*/
						window.location.href = "/appointments.cfm";	
					else
						window.location.reload();
				}
				else {
					$('#signin-msg').show();
					$('#signin-msg').addClass('alert-danger');
					$('#signin-msg').html(data.FAILEDMSG);
				}
			}, 
			error: function (data){
				$('#signin-msg').show();
				$('#signin-msg').addClass('alert-danger');
				$('#signin-msg').html('Exception occured!');
			}
		});
	});
	
	$('#btnRegister').on('click', function() {
		var company_id = $('#qCompanyId').val();
		var $regform = $("#frmRegister");
		$regform.validate();

		if( !$regform.valid() )
			return false;
		
		$.ajax({
				type: "post",
				url: "cfc/customers.cfc?method=registerCustomer&returnFormat=JSON&companyId="+company_id,
				data: $regform.serialize(),
				dataType: "json",
				success: function (rs){
					if(typeof fnBookAppointment =='function'){
						fnBookAppointment();
					}					
					$('#register-msg').show();
					if ( rs.SUCCESS == true ) {
						$('#register-msg').addClass('alert-success');
						$('#register-msg').empty();
						$('#register-msg').html('You have successfully registered as a customer!');
						window.location.href='index.cfm';
					}
					else {
						$('#register-msg').addClass('alert-error');
						$('#register-msg').empty();
						$('#register-msg').html(rs.FAILEDMSG);
					}
				}
		});
	});
	
	$('.a_register').on('click', function() {
		$('#signinModal').modal('hide');
		if ( $('#frmRegister') )
			$('#frmRegister')[0].reset();
		$('#register-msg').hide();
		$("#registerModal").modal('show');
	});
	/*
	$('.a_profile').on('click' ,function(){
		$('#page-content').load('customer_profile.cfm');
	});
	
	$('.a_apphistory').on('click' ,function(){
		$('#page-content').load('customer_appointment_history.cfm');
	});
	
	$('.a_contact').on('click' ,function(){
		$('#page-content').load('contact.cfm');
	});
	
	$('.a_servicesstaff').on('click' ,function(){
		$('#page-content').load('staff.cfm');
	});
	
	$('.a_gallery').on('click' ,function(){
		$('#page-content').parent().load('gallery.cfm');
	});
	
	$('.a_blog').on('click' ,function(){
		$('#page-content').load('blog.cfm');
	});
	*/
});