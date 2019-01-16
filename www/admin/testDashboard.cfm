
<cfset variables.page_title="Dashboard">
<cfinclude template="header.cfm">
                        
<div class="row">
    <cfparam name="variables.company_id" default="#session.company_id#">
    <cfinvoke component="company" method="getCompany" returnvariable="qCompany">
        <cfinvokeargument name="Company_ID" value="#variables.company_id#">
    </cfinvoke> 
    <cfparam name="URL.msg" default="" />
    <div style="margin:10px;">
        <cfoutput>#URL.msg#

        <a href="http://#qCompany.Web_Address#.salonworks.com" target="_blank">View your web site</a>
        <p>
        To enable online booking:<br>
        1. <a id="serviceClickhere" class="clickhere" href="##">Click here</a> to add the services that you offer<br>
        2. <a id="availabilityClickhere" class="clickhere" href="##">Click here</a> to go to the Calendar and add your availability<br>
        </p>
        </cfoutput>
    </div>
    <div class="space-6"></div>

    <div class="vspace-12-sm"></div>

    <div class="col-sm-7">
        <div class="widget-box">
            <div class="widget-header widget-header-flat widget-header-small">
                <h5 class="widget-title">
                    <i class="ace-icon fa fa-signal"></i>
                   Calendar
                </h5>

                <!--- <div class="widget-toolbar no-border">
                    <div class="inline dropdown-hover">
                        <button class="btn btn-minier btn-primary">
                            This Week
                            <i class="ace-icon fa fa-angle-down icon-on-right bigger-110"></i>
                        </button>
                    </div>
                </div> --->
            </div>

            <div class="widget-body">
                <div class="widget-main">
                    <div id='calendar'></div>
                </div><!-- /.widget-main -->
            </div><!-- /.widget-body -->
        </div><!-- /.widget-box -->
    </div><!-- /.col -->

    <div class="col-sm-5 ">
       
        <div class="widget-box widget-color-blue" id="widget-box-2">
            <div class="widget-header">
                <h5 class="widget-title bigger lighter">
                    <i class="ace-icon fa fa-table"></i>
                    Statistics
                </h5>
            </div>

            <div class="widget-body">
                <div class="widget-main no-padding">
                    <table class="table table-striped table-bordered table-hover">
                        <thead class="thin-border-bottom">
                            <tr>
                                <th>
                                   
                                    Day
                                </th>

                                <th>
                                    
                                    Visitors
                                </th>
                                <th>
                                    
                                    Total(past 30 days)
                                </th>
                               
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td class="">Alex</td>

                                <td>
                                    <a href="#">50</a>
                                </td>


                            </tr>

                            <tr>
                                <td class="">Fred</td>

                                <td>
                                    <a href="#">100</a>
                                </td>

                                
                            </tr>

                            <tr>
                                <td class="">Jack</td>

                                <td>
                                    <a href="#">250</a>
                                </td>

                                
                            </tr>

                            <tr>
                                <td class="">John</td>

                                <td>
                                    <a href="#">10</a>
                                </td>

                               
                            </tr>

                            <tr>
                                <td class="">James</td>

                                <td>
                                    <a href="#">50</a>
                                </td>

                               <td>
                                    460
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

</div><!-- /.row -->

<div class="hr hr32 hr-dotted"></div>

<div class="row">
    <div class="col-sm-5">
        <div class="widget-box transparent">
            <div class="widget-header widget-header-flat">
                <h4 class="widget-title lighter">
                    <i class="ace-icon fa fa-star orange"></i>
                    Configuration process
                </h4>

                <div class="widget-toolbar">
                    <a href="#" data-action="collapse">
                        <i class="ace-icon fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>

            <div class="widget-body">
                <div class="widget-main no-padding">
                    <table class="table table-bordered table-striped">
                        <thead class="thin-border-bottom">
                            <tr>
                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>Section
                                </th>

                                <th>
                                    <i class="ace-icon fa fa-caret-right blue"></i>sub section
                                </th>

                                <th class="hidden-480">
                                    <i class="ace-icon fa fa-caret-right blue"></i>status
                                </th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td>Profile</td>

                                <td>
                                    
                                    <b class="green">Email</b>
                                </td>

                                <td class="hidden-480">
                                    <span class="label label-danger arrowed">pending</span>
                                </td>
                            </tr>

                            <tr>
                                <td>Company</td>

                                <td>
                                    <b class="blue">Details</b>
                                </td>

                                <td class="hidden-480">
                                    <span class="label label-success arrowed-in arrowed-in-right">approved</span>
                                </td>
                            </tr>

                            <tr>
                                <td>Calendar</td>

                                <td>
                                    <b class="blue">Appointment</b>
                                </td>

                                <td class="hidden-480">
                                    <span class="label label-danger arrowed">pending</span>
                                </td>
                            </tr>

                            
                        </tbody>
                    </table>
                </div><!-- /.widget-main -->
            </div><!-- /.widget-body -->
        </div><!-- /.widget-box -->
    </div><!-- /.col -->

    <div class="col-sm-7" widget-container-col" id="widget-container-col-11">
        
            <div class="widget-box widget-color-dark" id="widget-box-11">
                <div class="widget-header">
                    <h6 class="widget-title">Inqueries</h6>

                    <div class="widget-toolbar">
                        <a href="#" data-action="settings">
                            <i class="ace-icon fa fa-cog"></i>
                        </a>

                        <a href="#" data-action="reload">
                            <i class="ace-icon fa fa-refresh"></i>
                        </a>

                        <a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>

                        <a href="#" data-action="close">
                            <i class="ace-icon fa fa-times"></i>
                        </a>

                        <a href="#" data-action="fullscreen" class="orange2">
                            <i class="ace-icon fa fa-expand"></i>
                        </a>
                    </div>
                </div>

                <div class="widget-body">
                    <div class="widget-main padding-4 scrollable" data-size="125">
                        <div class="content">
                            <div class="alert alert-info">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            <div class="alert alert-danger">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            <div class="alert alert-success">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            <div class="alert">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            <div class="alert alert-info">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            <div class="alert alert-danger">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            
                            <div class="alert alert-danger">
                                Lorem ipsum dolor sit amet, consectetur adipiscing.
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
    <!--- .widget-box --> --->
    </div><!-- /.col -->
</div><!-- /.row -->

<div class="hr hr32 hr-dotted"></div>



<!-- PAGE CONTENT ENDS -->
                           
        <!-- basic scripts -->

        <!--[if !IE]> -->
        

        <!-- <![endif]-->

        <!--[if IE]>
<script src="assets/js/jquery-1.11.3.min.js"></script>
<![endif]-->
        <script type="text/javascript">
            if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
        </script>
        <script type="text/javascript">
          // page is now ready, initialize the calendar...

        $(document).ready(function() {

    $('#calendar').fullCalendar({
        theme: true,
        header: {
            defaultView:'basicWeek',
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        editable: true,

        // add event name to title attribute on mouseover
        eventMouseover: function(event, jsEvent, view) {
            if (view.name !== 'agendaDay') {
                $(jsEvent.target).attr('title', event.title);
            }
        }
    });

        });
    </script>
        <!-- page specific plugin scripts -->

        <!--[if lte IE 8]>
          <script src="assets/js/excanvas.min.js"></script>
        <![endif]-->
       

        <!-- inline scripts related to this page -->
        <!--- <script type="text/javascript">
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
                        animate: ace.vars['old_ie'] ? false : 1000,
                        size: size
                    });
                })
            
                $('.sparkline').each(function(){
                    var $box = $(this).closest('.infobox');
                    var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
                    $(this).sparkline('html',
                                     {
                                        tagValuesAttribute:'data-values',
                                        type: 'bar',
                                        barColor: barColor ,
                                        chartRangeMin:$(this).data('min') || 0
                                     });
                });
            
            
              //flot chart resize plugin, somehow manipulates default browser resize event to optimize it!
              //but sometimes it brings up errors with normal resize event handlers
              $.resize.throttleWindow = false;
            
              var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});
              var data = [
                { label: "social networks",  data: 38.7, color: "#68BC31"},
                { label: "search engines",  data: 24.5, color: "#2091CF"},
                { label: "ad campaigns",  data: 8.2, color: "#AF4E96"},
                { label: "direct traffic",  data: 18.6, color: "#DA5430"},
                { label: "other",  data: 10, color: "#FEE074"}
              ]
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
            
            
              //pie chart tooltip example
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
            
                /////////////////////////////////////
                $(document).one('ajaxloadstart.page', function(e) {
                    $tooltip.remove();
                });
            
            
            
            
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
            
            
                $('#recent-box [data-rel="tooltip"]').tooltip({placement: tooltip_placement});
                function tooltip_placement(context, source) {
                    var $source = $(source);
                    var $parent = $source.closest('.tab-content')
                    var off1 = $parent.offset();
                    var w1 = $parent.width();
            
                    var off2 = $source.offset();
                    //var w2 = $source.width();
            
                    if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
                    return 'left';
                }
            
            
                $('.dialogs,.comments').ace_scroll({
                    size: 300
                });
                
                
                //Android's default browser somehow is confused when tapping on label which will lead to dragging the task
                //so disable dragging when clicking on label
                var agent = navigator.userAgent.toLowerCase();
                if(ace.vars['touch'] && ace.vars['android']) {
                  $('#tasks').on('touchstart', function(e){
                    var li = $(e.target).closest('#tasks li');
                    if(li.length == 0)return;
                    var label = li.find('label.inline').get(0);
                    if(label == e.target || $.contains(label, e.target)) e.stopImmediatePropagation() ;
                  });
                }
            
                $('#tasks').sortable({
                    opacity:0.8,
                    revert:true,
                    forceHelperSize:true,
                    placeholder: 'draggable-placeholder',
                    forcePlaceholderSize:true,
                    tolerance:'pointer',
                    stop: function( event, ui ) {
                        //just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
                        $(ui.item).css('z-index', 'auto');
                    }
                    }
                );
                $('#tasks').disableSelection();
                $('#tasks input:checkbox').removeAttr('checked').on('click', function(){
                    if(this.checked) $(this).closest('li').addClass('selected');
                    else $(this).closest('li').removeClass('selected');
                });
            
            
                //show the dropdowns on top or bottom depending on window height and menu position
                $('#task-tab .dropdown-hover').on('mouseenter', function(e) {
                    var offset = $(this).offset();
            
                    var $w = $(window)
                    if (offset.top > $w.scrollTop() + $w.innerHeight() - 100) 
                        $(this).addClass('dropup');
                    else $(this).removeClass('dropup');
                });
            
            })
        </script> --->
    <cfinclude template="footer.cfm">

