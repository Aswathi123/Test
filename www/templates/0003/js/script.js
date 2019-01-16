
// Home page map
function initMap() {
	var myLatLng = {lat: -25.363, lng: 131.044};

	var map = new google.maps.Map(document.getElementById('mapHome'), {
		zoom: 4,
		center: myLatLng
	});

	var marker = new google.maps.Marker({
		position: myLatLng,
		map: map,
		title: 'Hello World!'
	});
}

// Home page map end


$(document).ready(function() {
	var template_path = $("#templatePath").val();
	$("#staff_slider").owlCarousel({
		nav : true, // Show next and prev buttons
		navText: ["<span class='arrow-left'><img src='"+template_path+"img/arrow-left.png'></span>","<span class='arrow-right'><img src='"+template_path+"img/arrow-right.png'></span>"],
		slideSpeed : 300,
		paginationSpeed : 400,
		items: 1
	});

	$('.play').on('click',function(){
		owl.trigger('play.owl.autoplay',[1000])
	});
	$('.stop').on('click',function(){
		owl.trigger('stop.owl.autoplay')
	});
	// $(window).scroll(function(){
	//   $('#topDiv').addClass("sticky");
	// });
});