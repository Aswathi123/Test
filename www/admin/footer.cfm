<!-- PAGE CONTENT ENDS -->
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.page-content -->
      </div><!-- /.main-content -->
    </div><!-- /.main-container-inner -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="icon-double-angle-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->
<!--- support dialog form --->
<cfinclude template="support_form.cfm">

<!-- basic scripts -->
<!--[if !IE]> -->
<!-- <![endif]-->
<script type="text/javascript">
   if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- summernote editor -->
<script src="assets/js/summernote.min.js"></script>
<script src="assets/js/typeahead-bs2.min.js"></script>
<!-- page specific plugin scripts -->
<!--[if lte IE 8]>
<script src="assets/js/excanvas.min.js"></script>
<![endif]-->
<!--- <script src="assets/js/bootstrap.min.js"></script>
 ---><script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.touch/1.1.0/jquery.touch.min.js"></script>
<script src="assets/js/jquery.slimscroll.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/easy-pie-chart/2.1.6/jquery.easypiechart.min.js"></script>
<script src="assets/js/jquery.sparkline.min.js"></script>
<script src="assets/js/flot/jquery.flot.min.js"></script>
<script src="assets/js/flot/jquery.flot.pie.min.js"></script>
<script src="assets/js/flot/jquery.flot.resize.min.js"></script>
<!-- page specific plugin scripts -->
<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>

<!--- 
   <link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
    --->
<!--- <script src="assets/js/x-editable/1.5.0/bootstrap3-editable/bootstrap-editable.min.js"></script> --->
<!-- ace scripts -->
<!---<script src="assets/js/ace-elements.min.js"></script>
<script src="assets/js/ace-extra.min.js"></script>
<script src="assets/js/ace.min.js"></script>--->
<!-- inline scripts related to this page -->
<script type="text/javascript">
	$(document).ready(function(){
    //First login modal

         if (window.location.search.indexOf('swflg') > -1) {
            $('#modalfirstlog').modal('show');
           
        }/*else*/ 
          /*$('#modalfirstlog1').modal('hide'); */
		$('#btn-scroll-up').hide();
		$(window).scroll(function(){
	        if ($(this).scrollTop() > 100) {
	            $('#btn-scroll-up').show().fadeIn();
	        } else {
	            $('#btn-scroll-up').fadeOut().hide();
	        }
	    });
     $('[data-toggle="popover"]').popover();
	});
   $.ajaxSetup({cache:false});
   
   jQuery(function($) {
   
	   	$('.easy-pie-chart.percentage').each(function(){
	   		var $box = $(this).closest('.infobox');
	   		var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
	   		var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
	   		var size = parseInt($(this).data('size')) || 50;
	   		$(this).easyPieChart({
	   			barColor: barColor,
	   			trackColor: trackColor,
	   			scaleColor: false,
	   			lineCap: 'butt',
	   			lineWidth: parseInt(size/10),
	   			animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
	   			size: size
	   		});
	   	})
   
	   	$('.sparkline').each(function(){
	   		var $box = $(this).closest('.infobox');
	   		var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
	   		$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
	   	});
   
   
   	
	   	if($('#piechart-placeholder').size())
	   	{
	   	  var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
	   	  var data = [
	   		{ label: "social networks",  data: 38.7, color: "#68BC31"},
	   		{ label: "search engines",  data: 24.5, color: "#2091CF"},
	   		{ label: "ad campaigns",  data: 8.2, color: "#AF4E96"},
	   		{ label: "direct traffic",  data: 18.6, color: "#DA5430"},
	   		{ label: "other",  data: 10, color: "#FEE074"}
	   	  ];
	   		  function drawPieChart(placeholder, data, position) {
	   		 	  $.plot(placeholder, data, {
	   				series: {
	   					pie: {
	   						show: true,
	   						tilt:0.8,
	   						highlight: {
	   							opacity: 0.25
	   						},
	   						stroke: {
	   							color: '#fff',
	   							width: 2
	   						},
	   						startAngle: 2
	   					}
	   				},
	   				legend: {
	   					show: true,
	   					position: position || "ne", 
	   					labelBoxBorderColor: null,
	   					margin:[-30,15]
	   				}
	   				,
	   				grid: {
	   					hoverable: true,
	   					clickable: true
	   				}
	   			 })
	   		 }
	    		drawPieChart(placeholder, data);
	   
	   		 /**
	   		 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
	   		 so that's not needed actually.
	   		 */
	   		 placeholder.data('chart', data);
	   		 placeholder.data('draw', drawPieChart);
	   		
	   		
	   		
	   		  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
	   		  var previousPoint = null;
	   		
	   		  placeholder.on('plothover', function (event, pos, item) {
	   			if(item) {
	   				if (previousPoint != item.seriesIndex) {
	   					previousPoint = item.seriesIndex;
	   					var tip = item.series['label'] + " : " + item.series['percent']+'%';
	   					$tooltip.show().children(0).text(tip);
	   				}
	   				$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
	   			} else {
	   				$tooltip.hide();
	   				previousPoint = null;
	   			}
	   			
	   		});
	   	}
   
   
	   	var d1 = [];
	   	for (var i = 0; i < Math.PI * 2; i += 0.5) {
	   		d1.push([i, Math.sin(i)]);
	   	}
	   
	   	var d2 = [];
	   	for (var i = 0; i < Math.PI * 2; i += 0.5) {
	   		d2.push([i, Math.cos(i)]);
	   	}
	   
	   	var d3 = [];
	   	for (var i = 0; i < Math.PI * 2; i += 0.2) {
	   		d3.push([i, Math.tan(i)]);
	   	}
   	
	   	if($('#sales-charts').size()){
	   		var sales_charts = $('#sales-charts').css({'width':'100%' , 'height':'220px'});
	   		$.plot("#sales-charts", [
	   			{ label: "Domains", data: d1 },
	   			{ label: "Hosting", data: d2 },
	   			{ label: "Services", data: d3 }
	   		], {
	   			hoverable: true,
	   			shadowSize: 0,
	   			series: {
	   				lines: { show: true },
	   				points: { show: true }
	   			},
	   			xaxis: {
	   				tickLength: 0
	   			},
	   			yaxis: {
	   				ticks: 10,
	   				min: -2,
	   				max: 2,
	   				tickDecimals: 3
	   			},
	   			grid: {
	   				backgroundColor: { colors: [ "#fff", "#fff" ] },
	   				borderWidth: 1,
	   				borderColor:'#555'
	   			}
	   		});
	   	}
   
	   	$('#recent-box [data-rel="tooltip"]').tooltip({placement: tooltip_placement});
	   	function tooltip_placement(context, source) {
	   		var $source = $(source);
	   		var $parent = $source.closest('.tab-content')
	   		var off1 = $parent.offset();
	   		var w1 = $parent.width();
	   
	   		var off2 = $source.offset();
	   		var w2 = $source.width();
	   
	   		if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
	   		return 'left';
	   	}
   
   
	   	$('.dialogs,.comments').slimScroll({
	   		height: '300px'
	       });
   	
   	
   	//Android's default browser somehow is confused when tapping on label which will lead to dragging the task
   	//so disable dragging when clicking on label
   	
	   	var agent = navigator.userAgent.toLowerCase();
	   	if("ontouchstart" in document && /applewebkit/.test(agent) && /android/.test(agent))
	   	  $('#tasks').on('touchstart', function(e){
	   		var li = $(e.target).closest('#tasks li');
	   		if(li.length == 0)return;
	   		var label = li.find('label.inline').get(0);
	   		if(label == e.target || $.contains(label, e.target)) e.stopImmediatePropagation() ;
	   	});
   
	   	$('#tasks').sortable({
	   		opacity:0.8,
	   		revert:true,
	   		forceHelperSize:true,
	   		placeholder: 'draggable-placeholder',
	   		forcePlaceholderSize:true,
	   		tolerance:'pointer',
		   		stop: function( event, ui ) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
		   			$(ui.item).css('z-index', 'auto');
		   		}
	   		}
   		);
	   	$('#tasks').disableSelection();
	   	$('#tasks input:checkbox').removeAttr('checked').on('click', function(){
	   		if(this.checked) $(this).closest('li').addClass('selected');
	   		else $(this).closest('li').removeClass('selected');
	   	});
   	
   });
   
   //$(document).ready(function(){
   	
   	$(".PhoneFormat").keydown(function(e){keydownAcceptFilterInteger(e);});
   	
   	$( ".PhoneFormat" ).change(function() {
   		var str = $(this).val().replace("(","").replace(")","").replace("-","");
   	
   		if(str.length == 10){
   			var strFinal = "(" + str.substring(0,3) + ")" + str.substring(3,6) + "-" + str.substring(6,10) ;
   			$(this).val(strFinal);
   		}
   	});
   	
   	$('.admin-support').on('click', function(){
   		
   		var $dialog = $('#dialog-support');
   		var $support_form = $dialog.find('#support_form');
   		$support_form[0].reset();
   		$dialog.find('#supportMsg').html('');
   		$dialog.find('#supportMsg').hide();
   		
   		$dialog.removeClass('hide').dialog({
   			modal: true,
   			buttons: [ 
   				{
   					text: "Cancel",
   					"class" : "btn btn-xs",
   					click: function() {
   						$( this ).dialog( "close" ); 
   						$support_form[0].reset();
   					} 
   				},
   				{
   					text: "Send",
   					"class" : "btn btn-primary btn-xs",
   					click: function() {
   						
   						$support_form.validate();
   						if ( !$support_form.valid() )
   							return false;
   						$.ajax({
   							url: 'system.cfc?method=sendEmail&returnFormat=JSON',
   							dataType: 'json',
                async:true,
   							type: 'post',
   							data: $support_form.serialize(),
   							success: function(data){
   								if (data  === true) {
   									$dialog.find('#supportMsg').attr('class','alert alert-success');
   									$dialog.find('#supportMsg').html('You message has been sent successfully.');
   								}
   								else {
   									$dialog.find('#supportMsg').attr('class','alert alert-danger');
   									$dialog.find('#supportMsg').html('You message has been not sent. Please contact Salonworks!');
   									
   								}
   								$dialog.find('#supportMsg').show();
   								
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
   				}
   			]
   		});
   	});
    
    
   	$('#profile_company').on('click' ,function(){
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Profile</li><li class='active'>Company</li>");
   		$('#page-content').load('company_form.cfm');
      
   	}); 
   	$('#profile_location').on('click' ,function(){
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Profile</li><li class='active'>Location</li>");
   		$('#page-content').load('location_form.cfm');
   	}); 
   	
   	$('#profile_professionals').on('click' ,function(){
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Profile</li><li class='active'>Professionals</li>");
   		$('#page-content').load('professionals_form.cfm');
   	}); 
   	
   	$('#profile_services').on('click' ,function(){
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Profile</li><li class='active'>Services</li>");
   		$('#page-content').load('services_form.cfm');
   	});

   	<!--- SW - 75 Calender menu - Appointment --->
   	$('#eventcalendar').on('click' ,function(){
      $('#page-content').html('<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage" id="calendarLoader">');
      $('#page-content').load('calendars.cfm?isScheduled=0');
      $("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Calendar</li>");
    });

    <!--- SW- 75 Calender menu - schedule --->
    $('#scheduleweek').on('click' ,function(){
   		$('#page-content').html('<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage" id="calendarLoader">');
   		$('#page-content').load('calendars.cfm?isScheduled=1');
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Calendar</li>");
   	});

   	$('#serviceClickhere').on('click' ,function(){
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Profile</li><li class='active'>Services</li>");
   		$('#page-content').load('services_form.cfm');
   	});
   	$('#availabilityClickhere').on('click' ,function(){
   		$('#page-content').html('<img src="../admin/assets/img/loading.gif" alt="loading" class="loaderImage" id="calendarLoader">');
   		$('#page-content').load('calendars.cfm');
   		$("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li id='profileBreadcrumbs'>Calendar</li>");
   	});

    // $('#previewSection').on('click' ,function(){
    //   $("#profileBreadcrumbs").parent().html("<li><i class='icon-home home-icon'></i><a href='http://salonworks.com/admin/'>Home</a></li><li class='active'>Templates</li>");
    // });
   
   
   	$("#payment_form").validate({
      rules: {
        Billing_First_Name :{
          required: true
        },
            Billing_Last_Name :{
                required: true
            },
            Billing_Address1 :{
                required: true
            },
            Billing_City :{
                required: true
            },
            Billing_State :{
                required: true
            },
            Billing_Zip :{
                zipcodeUS:true,
                required: true
            },
            Credit_Card :{
                required: true,
                creditcard: true
            },
            cardCode :{
              number:true,
              minlength:3,
              maxlength:3,
              required: true
            },
      }
    });
    $("#service_form").validate({
        rules: {
            service_time :{
                required: true,
                minlength:1,
                    maxlength:3
            },
        }
    });
   	
   	$( "#register_form" ).validate({
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
              Location_Postal:{
              required: true,
              zipcodeUS:true
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
              
              First_Name:"required",
              Last_Name:"required",
              Billing_First_Name:"required",
   		Billing_Last_Name:"required",
   		Billing_Address1:"required",
   		Billing_City :"required",
   		Billing_State:"required",
   		Billing_Zip:{
   		required:true,
   		zipcodeUS:true
   		},
   		Credit_Card:{
   			required: true,
   			creditcard:true,
   			maxlength:16,
   			minlength:12
   		}
           },
            messages: {
              First_Name:"First name is required",
              Last_Name : "Last name is required",
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
              zipcodeUS :"Postal code is not valid",
              },
               Location_Phone:{
              required: "Location phone is required",
              },
              web_address:"Web address is required",
              Company_Name :"Company name is required",
              Company_Address: "Company address is required",
              Company_State: "Company state is required",
              Company_city: "Company city is required",
              Contact_Name :"Contact name is required",
              Location_Name: "Contact name is required",
              Location_Address :"Location address is required",
              Location_City: "Location city is required",
              Billing_First_Name :"First name is required",
   		Billing_Last_Name:"Last name is required",
   		Billing_Address1 :"Address is required",
   		Billing_City : "City is required ",
   		Billing_State : "State is required",
   		Billing_Zip:{
   			required: "Zip is required",
              	zipcodeUS :"Zip code is not valid",
   		},
            }
        });
   	$('.firstLtrUpperApply').change(function(){
   		var str = $(this).val();
   		$(this).val(str.charAt(0).toUpperCase() + str.substring(1,str.length));
   	});			
   //});
   
   if (window.location.search.indexOf('showPage') > -1) {
   	var url = window.location.href;
    console.log(url);
   	var res = url.split("?");
   	var pageName = res[1].split("=");
   	var paramid = pageName[1].replace("#",'');
       $("#"+paramid).trigger("click");
   } 
   if (window.location.search.indexOf('showTab') > -1) {
    var url = window.location.href;
    console.log(url);
    var res = url.split("?");
    var pageName = res[1].split("=");
    var paramid = pageName[1].replace("#",'');
       $("#"+paramid).trigger("click");
   } 
   

</script>

<script>


  $('.showservicetype').click(function(){
    $('#myModal').show();

  });
  $('.showprofession').click(function(){
    $('#modalfirstlog').show();
    $("button.servicetypes").remove();
  });
  
  $('.saveservice').click(function(){
    
    if($('#servicetime').val() == "" && $('#serviceprice').val() == ""){
      
      $('#serviceMsg').css('display','block');
    }
    else{
      // $('#addedservices').html('');
      $('#serviceMsg').css('display','none');
      var Service_Name=$('#serviceheader').html();
      var Service_Type_ID=$('#servicetypeid').val();
      var Service_ID=$('#serviceid').val();
      var Service_Time=$('#servicetime').val();
      var Service_Price=$('#serviceprice').val();
      var Professional_ID=<cfoutput>#session.professional_id#</cfoutput>
      $.ajax({
          type: "post",
          url: "registerinfo.cfc?method=insertServiceDetails",
          data: {
            Professional_ID:Professional_ID,
            Service_ID:Service_ID,
            Service_Time:Service_Time,
            Service_Price:Service_Price
            },
          // Define request handlers.
          success: function(data){
              // $('#service_'+Service_Type_ID+'').append('<h6>'+Service_Name+' Price:$'+Service_Price+'&nbsp;&nbsp;Duration:'+Service_Time+'min</h6>')
              $('#addedservices').append('<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 addedservicename" id="addedservicebtn_'+Service_ID+'">'+Service_Name+'<button class="w3-button w3-circle w3-red" style="float: right;margin-top: -8px;" onclick="deleteServiceDetail('+Professional_ID+','+Service_ID+')">-</button><div class="row" style="font-size:10px;">Price:&nbsp;$'+Service_Price+'&nbsp;Duration:&nbsp;'+Service_Time+'min</div></div>')
              $("#servicebtn_"+Service_ID).css("display","none");
            
              }
          

          
      });

      $('#servicetime').val('');
      $('#serviceprice').val('');
      $('#addservice').hide();
      $('#serviceModal').modal("show");
    }
    
  });


  $('.cancelservice').click(function(){
    $('#serviceModal').modal("show");
    $('#serviceMsg').css('display','none');
  });
  

  function deleteServiceDetail(professional_id,service_id){
    var Professional_ID=professional_id;
    var Service_ID=service_id;
    $.ajax({
        type: "post",
        url: "registerinfo.cfc?method=deleteServiceDetails",
        data: {
          Professional_ID:Professional_ID,
          Service_ID:Service_ID
          },
        // Define request handlers.
        success: function(data){
            $("#servicebtn_"+Service_ID).show();
            $("#addedservicebtn_"+Service_ID).remove();
            }
    });     
  }

  $('.profession').click(function() {
    $('#modalfirstlog').hide();
    $("button[id=probtn]").remove();
      var Profession_ID=$(this).attr('data-professionid');
 
      $.ajax({
          type: "post",
          url: "registerinfo.cfc?method=getServiceTypes",
          data: {
            Profession_ID: Profession_ID
            },
          // Define request handlers.
          success: function(data){
            // $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
            var res = JSON.parse(data);
            console.log(res);
            for (var i in res.DATA) {
              console.log(i);
                 $('#servicetype_btn').append('<button class="block blockbtn servicetypes" id="service_'+res.DATA[i][0]+'" data-toggle="modal" data-target="#serviceModal" onclick="getServices('+res.DATA[i][0]+')" type="button">'+ res.DATA[i][1]+'</button>')
              }
          },

          
      });

});

function  getServices(servicetypeid){
  $('#myModal').hide();
  $("div.servicename").remove();
  var Service_Type_ID=servicetypeid;

  $.ajax({
    type: "post",
    url: "registerinfo.cfc?method=getServices",
    data: { Service_Type_ID: Service_Type_ID },
    // Define request handlers.
    success: function(data){
      // $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
      var res = JSON.parse(data);
      // console.log(res);
      var status = false;
      $('#addedservices').html("");
      for (var i in res.DATA) {
        
        if(res.DATA[i][3] != "") {
          $('#addedservices').append('<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 addedservicename" id="addedservicebtn_'+res.DATA[i][0]+'">'+res.DATA[i][2]+'<button class="w3-button w3-circle w3-red" style="float: right;margin-top: -8px;" onclick="deleteServiceDetail('+res.DATA[i][3]+','+res.DATA[i][0]+')">-</button><div class="row" style="font-size:10px;">Price:&nbsp;$'+res.DATA[i][4]+'&nbsp;Duration:&nbsp;'+res.DATA[i][5]+'min</div></div>');
            $("#servicebtn_"+res.DATA[i][0]).css("display","none");
            $('#service_div').append('<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 servicename"  id="servicebtn_'+res.DATA[i][0]+'" style="display:none;">'+res.DATA[i][2]+'<button class="w3-button w3-circle w3-grey" data-toggle="modal" data-target="#addservice" style="float: right;margin-top: -8px;" onclick="getServiceDetail('+res.DATA[i][0]+','+Service_Type_ID+')">+</button></div>')
        } else {
          // $('#service_div').html("");
          $('#service_div').append('<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 servicename"  id="servicebtn_'+res.DATA[i][0]+'">'+res.DATA[i][2]+'<button class="w3-button w3-circle w3-grey" data-toggle="modal" data-target="#addservice" style="float: right;margin-top: -8px;" onclick="getServiceDetail('+res.DATA[i][0]+','+Service_Type_ID+')">+</button></div>')
        }
        }
    }
  });
}

  function getServiceDetail(serviceid,servicetypeid){
  $('#serviceModal').modal("hide");
  var Service_ID=serviceid;
  var Service_Type_ID=servicetypeid
  $('#serviceid').val(Service_ID);
  $('#servicetypeid').val(Service_Type_ID);
            
    $.ajax({
      type: "post",
      url: "registerinfo.cfc?method=getServicesDetail",
      data: { Service_ID: Service_ID },
      // Define request handlers.
      success: function(data){
        // $('#Service_Type_ID').append('<option value='0'>'Select Service Type'</option>')
        var res = JSON.parse(data);
            $('#serviceheader').html(res.DATA[0][1]);
            $('#addservice').modal("show");
      }
    });
  }
  
  
  $(document).ready(function () {

    

    $('#Cmp_Description_summernote').summernote({
        height: 100,
        focus: false,
         toolbar: [
           ['style', ['style', 'bold', 'italic', 'underline', 'clear']],
           ['fontsize', ['fontsize']],
           ['color', ['color']],
           ['para', ['ul', 'ol', 'paragraph']]
         ]
     });

      var navListItems = $('div.setup-panel div a'),
              allWells = $('.setup-content'),
              allNextBtn = $('.nextBtn');

      allWells.hide();

      navListItems.click(function (e) {
          e.preventDefault();
          var $target = $($(this).attr('href')),
                  $item = $(this);

          if (!$item.hasClass('disabled')) {
              navListItems.removeClass('btn-primary').addClass('btn-default');
              $item.addClass('btn-primary');
              allWells.hide();
              $target.show();
              $target.find('input:eq(0)').focus();
          }
      });

      allNextBtn.click(function(){


        
          var curStep = $(this).closest(".setup-content"),
              curStepBtn = curStep.attr("id"),
              nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
              curInputs = curStep.find("input[type='text'],input[type='url']"),
              isValid = true;
              ;
             
          
          $(".form-group").removeClass("has-error");
          for(var i=0; i<curInputs.length; i++){
              if (!curInputs[i].validity.valid){
                  isValid = false;
                  $(curInputs[i]).closest(".form-group").addClass("has-error");
              }
          }

          if (isValid && $("#company_info_form").valid())
              nextStepWizard.removeAttr('disabled').trigger('click');
      });

      $('div.setup-panel div a.btn-primary').trigger('click');
  });

  fnCheckCompanyEmail = function(){
    if($('#Cmp_Email').val().length){

      $.ajax({
          type: "post",
          url: "company.cfc",
          data: {
            method: "isExistingCompanyEmail",
            CompanyEmail: $('#Cmp_Email').val(),
            noCache: new Date().getTime()
            },
          dataType: "json",

          // Define request handlers.
          success: function( objResponse ){
            // Check to see if request was successful.
            if (objResponse.SUCCESS){
              if(objResponse.DATA){
                alert('The Company Email, ' + $('#Company_Email').val() + ', entered already exist.  Please enter a different address.');
                $('#Cmp_Email').val('');
                $('#Cmp_Email').focus();
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
$('#company_info_btn').on('click', function(){

  $( "#company_info_form" ).validate({
    rules: {
    Cmp_Name: {
    required: true
    },
    Cmp_Address:{
    required: true
    },

    Cmp_Phone:{
    required: true,
    phoneUS: true
    },

    Cmp_City:{
    required: true
    },

    Cmp_Fax:{
    required: false,
    phoneUS: true
    },

    Cmp_Email:{
    required: false,
    email: true
    },
    Cmp_Postal:{
    required: true,
    zipcodeUS:true
    },

    }
  });

  if($("#company_info_form").valid()){
    $('#Cmp_Description').val( $('#Cmp_Description_summernote').code() );
    var Company_Name = $('#Cmp_Name').val();
    var Company_Address = $('#Cmp_Address').val();
    var Company_City = $('#Cmp_City').val();
    var Company_State = $('#Cmp_State').val();
    var Company_Postal = $('#Cmp_Postal').val();
    var Company_Phone = $('#Cmp_Phone').val();
    var Company_Email = $('#Cmp_Email').val();
    var Company_Fax = $('#Cmp_Fax').val();
    var Company_Description = $('#Cmp_Description').val();
    var company_id = <cfoutput>#session.company_id#</cfoutput>
    $.ajax({
      type: "post",
      url: "registerinfo.cfc?method=updateCompanyDetails",
      dataType: "json",
      data: {
        Company_Name : Company_Name,
        Company_Address : Company_Address,
        Company_City : Company_City,
        Company_State : Company_State,
        Company_Postal : Company_Postal,
        Company_Phone : Company_Phone,
        Company_Email : Company_Email,
        Company_Fax : Company_Fax,
        Company_Description : Company_Description,
        company_id : company_id
      },
      success: function( objResponse ) {
        if (objResponse) {
          $('input[name=Lct_Address]').val(Company_Address);
          $('input[name=Lct_City]').val(Company_City);
          $('#Lct_State').val(Company_State);
          $('input[name=Lct_Postal]').val(Company_Postal);
          $('input[name=Lct_Fax]').val(Company_Fax);
          $('input[name=Lct_Phone]').val(Company_Phone);
        }
      }
    });
  } else {
    alert('Please fill out all required fields');
  }
});

$('#location_info_btn').on('click', function(){
  // alert($('#Lct_Postal').val());
  $( "#company_info_form" ).validate({
    rules: {
    Cnt_Name: {
    required: true
    },

    Lct_Name:{
    required: true
    },

    Lct_Address:{
    required: true
    },

    Lct_Phone:{
    required: true,
    phoneUS: true
    },

    Lct_City:{
    required: true
    },

    Lct_Fax:{
    required: false,
    phoneUS: true
    },

    Lct_Email:{
    required: false,
    email: true
    },

    Lct_Postal:{
    required: true,
    zipcodeUS:true
    },


    }
  });


  if($("#company_info_form").valid()){
    
    var Contact_Name = $('#Cnt_Name').val();
    var Contact_Phone = $('#Cnt_Phone').val();
    var Location_Name= $('#Lct_Name').val();
    var Location_Address = $('#Lct_Address').val();
    var Location_City = $('#Lct_City').val();
    var Location_State = $('#Lct_State').val();
    var Location_Postal= $('#Lct_Postal').val();
    var Location_Phone = $('#Lct_Phone').val();
    var Location_Fax = $('#Lct_Fax').text();
    var Location_Description= $('#Lct_Description').val();
    var Driving_Directions = $('#Lct_Directions').val();
    var Time_Zone= $('#Time_Zone_ID').val();
    var Payments_Accepted = [];
    $("input[name='Payment_MethodList']").each( function () {
          if ($(this).prop("checked") ==true) {

             Payments_Accepted.push($(this).val());

          }

      });
    var Payments_Accepted=Payments_Accepted.toString();
    var Parking_Fee=$('#Parking_Fee').val();
    var Cancellation_Policy=$('#Cancellation_Policy').val();;
    var Languages=$('#Language').val();;
    var Location_ID=<cfoutput>#session.location_id#</cfoutput>

    $.ajax({
      type: "post",
      url: "registerinfo.cfc?method=updateLocationDetails",
      dataType: "json",
      data: {
        Contact_Name : Contact_Name,
        Contact_Phone : Contact_Phone,
        Location_Name : Location_Name,
        Location_Address : Location_Address,
        Location_City : Location_City,
        Location_State : Location_State,
        Location_Postal : Location_Postal,
        Location_Phone : Location_Phone,
        Location_Fax : Location_Fax,
        Description : Location_Description,
        Driving_Directions : Driving_Directions,
        Time_Zone_ID : Time_Zone,
        Payment_Methods_List : Payments_Accepted,
        Parking_Fees : Parking_Fee,
        Cancellation_Policy : Cancellation_Policy,
        Languages : Languages,
        Location_ID : Location_ID
        
    },
      success: function( objResponse ) {
        
      }
    });
    
  }
  else {
    alert('Please fill out all required fields');
  }
});

$('#hours_info_btn').on('click', function(){
  var valueArray = [];
  for (var i = 1; i <= 7; i++) {
    if($('#Begins_'+i).val()=="Closed"){
      valueArray.push('Closed'+','+'No Break');
    }
    else if($('#BreakBegin_'+i).val()=="NoBreak"){

      valueArray.push($('#Begins_'+i).val().trim()+' &mdash; '+ $('#Ends_'+i).val().trim()+','+'No Break');

    }
    else{
      valueArray.push($('#Begins_'+i).val().trim()+' &mdash; '+ $('#Ends_'+i).val().trim()+','+$('#BreakBegin_'+i).val().trim()+' &mdash; '+ $('#BreakEnd_'+i).val().trim());
    }

    
  }
  var data = JSON.stringify(valueArray);

  var Location_ID=<cfoutput>#session.location_id#</cfoutput>
  $.ajax({
    type: "post",
    url: "registerinfo.cfc?method=updateHoursDetails",
    data: {data : data, Location_ID : Location_ID},
    dataType: "json",
    success: function( objResponse ) {
      
    }
  });
  return false;
});

$(".modal").on('shown.bs.modal', function(event){
    if($(".modal-backdrop").length > 1){
      $(".modal-backdrop")[1].remove();
    }
});


$("#company_ImageFile").on("change",function(){
  if($(this).val() != ""){
    var file_data = $(this).prop('files')[0];
        var form_data = new FormData();
        form_data.append('file', file_data);
        $.ajax({
            url: 'registerinfo.cfc?method=upload_company_img', // point to server-side controller method
            dataType: 'text', // what to expect back from the server
            cache: false,
            contentType: false,
            processData: false,
            data: form_data,
            type: 'post',
            success: function (response) {
                
            },
            error: function (response) {
                alert(response); // display error response from the server
            }
        });
  }
});

$('#Begins_2').change(function(){
  $('#Begins_3').val($('#Begins_2').val());
  $('#Begins_4').val($('#Begins_2').val());
  $('#Begins_5').val($('#Begins_2').val());
  $('#Begins_6').val($('#Begins_2').val());
  $('#Begins_7').val($('#Begins_2').val());
});
$('#Ends_2').change(function(){
  $('#Ends_3').val($('#Ends_2').val());
  $('#Ends_4').val($('#Ends_2').val());
  $('#Ends_5').val($('#Ends_2').val());
  $('#Ends_6').val($('#Ends_2').val());
  $('#Ends_7').val($('#Ends_2').val());
});
$('#BreakBegin_2').change(function(){
  $('#BreakBegin_3').val($('#BreakBegin_2').val());
  $('#BreakBegin_4').val($('#BreakBegin_2').val());
  $('#BreakBegin_5').val($('#BreakBegin_2').val());
  $('#BreakBegin_6').val($('#BreakBegin_2').val());
  $('#BreakBegin_7').val($('#BreakBegin_2').val());
});
$('#BreakEnd_2').change(function(){
  $('#BreakEnd_3').val($('#BreakEnd_2').val());
  $('#BreakEnd_4').val($('#BreakEnd_2').val());
  $('#BreakEnd_5').val($('#BreakEnd_2').val());
  $('#BreakEnd_6').val($('#BreakEnd_2').val());
  $('#BreakEnd_7').val($('#BreakEnd_2').val());
});




</script>
</body>
</html>