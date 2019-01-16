<!--- 
TESTING CODE
						Location_ID: <cfoutput>#Session.Location_ID#</cfoutput>
						, ServiceID: $("#selService").val() 
						, Professional_ID: $("#selProfessional").val()
						, Month: month
						, Year: year
						
					
<cfset variables.appointmentsBean = createObject("component","admin.appointmentsCalendarBean") /> 
<cfset variables.qryResults = variables.appointmentsBean.getAvailableDatesArray(1, 7, 1, 9, 2012) /> 
<cfdump var="#variables.qryResults#" label="FINAL RETURN" />     
 --->	
 
<cfset Session.Location_ID = 246 />
<cfparam name="variables.minDate" default="#DateFormat(Now(),'mm/dd/yyyy')#" />
<cfparam name="Form.datepicker" default="#variables.minDate#" />
<cfparam name="Form.selProfessional" default="0" />
<cfparam name="Form.selService" default="0" />

<cfset Session.CustomerID = 1 />

<!--- <cfif Not IsDefined("Session.objServices")> --->
	<cfset Session.objServices = StructNew() />
    <cfquery name="Session.objServices.qryData" datasource="#request.dsn#">
        -- SELECT     	Service_Types.Service_Type_Name, 
        --             Services.Service_ID, Services.Service_Name, Services.Price, Services.Service_Time
        -- FROM        Services INNER JOIN
        --                       Service_Types ON Services.Service_Type_ID = Service_Types.Service_Type_ID
        -- ORDER BY Service_Types.Service_Type_Display_Order
        SELECT     	Predefined_Service_Types.Service_Type_Name, 
                    Predefined_Services.Service_ID, Predefined_Services.Service_Name, Professionals_Services.Price, Professionals_Services.Service_Time
        FROM        Predefined_Services INNER JOIN
                              Predefined_Service_Types ON Predefined_Services.Service_Type_ID = Predefined_Service_Types.Service_Type_ID
                              INNER JOIN
                              Professionals_Services ON Professionals_Services.Service_ID=Predefined_Services.Service_ID
    </cfquery>
    
    <cfset Session.objServices.arrData = ArrayNew(1) />
    <cfset variables.ArrayIndex = 1 />
	<cfloop query="Session.objServices.qryData" >
    	<cfset Session.objServices.arrData[variables.ArrayIndex] = StructNew() />
        <cfset Session.objServices.arrData[variables.ArrayIndex].ServiceID = Session.objServices.qryData.Service_ID />
        <cfset Session.objServices.arrData[variables.ArrayIndex].ServiceTypeName = Session.objServices.qryData.Service_Type_Name />
        <cfset Session.objServices.arrData[variables.ArrayIndex].ServiceName = Session.objServices.qryData.Service_Name />
        <cfset Session.objServices.arrData[variables.ArrayIndex].Price = Session.objServices.qryData.Price />
        <cfset Session.objServices.arrData[variables.ArrayIndex].ServiceTime = Session.objServices.qryData.Service_Time />
        <cfset variables.ArrayIndex = variables.ArrayIndex + 1 />
    </cfloop>
    
<!--- </cfif> --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Untitled Document</title>
    <link href="jquery-ui-1.8.21/themes/base/jquery.ui.all.css" rel="stylesheet">
    <link href="css/forms.css" rel="stylesheet">
    
	<script src="jquery-ui-1.8.21/jquery-1.7.2.js"></script>
	<script src="jquery-ui-1.8.21/ui/jquery.ui.core.js"></script>
	<script src="jquery-ui-1.8.21/ui/jquery.ui.widget.js"></script>
	<script src="jquery-ui-1.8.21/ui/jquery.ui.datepicker.js"></script>

	<script>

	$(document).ready(function() {
		
		$("#selService").change(function(){
		
			$.ajax("admin/appointmentsCalendarBean.cfc", {
				// send a GET HTTP operation
				type: "get"
				// tell jQuery we're getting JSON back
				,dataType: "json"
				,returnFormat:'json'
				// send the data to the CFC
				, data: {
						// the method in the CFC to run
						  method: "getServiceProfessionalsList"
						, Location_ID: <cfoutput>#Session.Location_ID#</cfoutput>
						, ServiceID: $(this).attr('value') 
					}
				// this gets the data returned on success
				, success: function (rs){
						// Populate Professional List based on Service selection
						var options = '';
						$("#selProfessional").removeAttr("disabled");
						   if(rs.DATA.length){
								for (var i = 0; i < rs.DATA.length; i++) {
									options += '<option value="' + rs.DATA[i][rs.COLUMNS.findIdx('PROFESSIONAL_ID')] + '">' + 
												rs.DATA[i][rs.COLUMNS.findIdx('LAST_NAME')] + ', ' + rs.DATA[i][rs.COLUMNS.findIdx('FIRST_NAME')] +'</option>';
								}
								$("#datepicker").removeAttr("disabled");
								$("#btnSubmit").removeAttr("disabled");
							}			
							else{
								options = '<option value="0">No Professional Found</option>';		
							}		
							
							$("#selProfessional").html(options);
							$('#selProfessional option:first').attr('selected', 'selected');	 
							
							
							//Update Calendar Unavailable dates array since a new service and first professional is selected
							getAvailableDates($("#datepicker").datepicker("getDate").getMonth() + 1, $("#datepicker").datepicker("getDate").getFullYear());
					}
				// this runs if an error
				, error: function (xhr, textStatus, errorThrown){
						alert("error: "   + errorThrown);
					}
				});
		});
		
		
		$("#selProfessional").change(function(){
			getAvailableDates($("#datepicker").datepicker("getDate").getMonth() + 1, $("#datepicker").datepicker("getDate").getFullYear());
		});
		
		$("#datepicker").click(function(){
			getAvailableDates($("#datepicker").datepicker("getDate").getMonth() + 1, $("#datepicker").datepicker("getDate").getFullYear());
		});
				
		$("#datepicker").change(function(){
			if($("#datepicker").datepicker("getDate") == null){
				$("#datepicker").val('<cfoutput>#variables.minDate#</cfoutput>');
			}
		});
						
		//
		
		
		$(function() {
			$("#datepicker").datepicker({numberOfMonths: 2, onChangeMonthYear : monthChanged, beforeShowDay: isAvailable});
			$("#datepicker").datepicker("setDate" , <cfoutput>'#Form.datepicker#'</cfoutput>);
			$("#datepicker").datepicker("option", "minDate" , <cfoutput>'#variables.minDate#'</cfoutput>);

			$("#selService").val(<cfoutput>#Form.selService#</cfoutput>);
			$("#selProfessional").val(<cfoutput>#Form.selProfessional#</cfoutput>);
			
			//won't work because there is no values in professional drop-down... maybe load if btnSubmit exists.

			<cfif Not IsDefined("Form.btnSubmit")>
				$("#datepicker").attr('disabled', 'disabled');
				$("#selProfessional").attr('disabled', 'disabled');
				$("#btnSubmit").attr('disabled', 'disabled');
			</cfif>

		}); 
	});


	function getAvailableDates(month, year){
		
			$.ajax("admin/appointmentsCalendarBean.cfc", {
				// send a GET HTTP operation
				type: "get"
				// tell jQuery we're getting JSON back
				,dataType: "json"
				,returnFormat:'json'
				// send the data to the CFC
				, data: {
						// the method in the CFC to run
						  method: "getAvailableDatesArray"
						, Location_ID: <cfoutput>#Session.Location_ID#</cfoutput>
						, ServiceID: $("#selService").val() 
						, Professional_ID: $("#selProfessional").val()
						, Month: month
						, Year: year
					}
				// this gets the data returned on success
				, success: function (rs){
						availableDates = rs.slice(0);
			
						//if(!isMonthChange) $('#datepicker').datepicker( "refresh" );//$('#datepicker').datepicker('option', {}); //Refresh
						$('#datepicker').datepicker( "refresh" );
					}
				// this runs if an error
				, error: function (xhr, textStatus, errorThrown){
						alert("error: "   + errorThrown);
					}
				}); 
	}


	function monthChanged(year, month, instance) {
	
		if($("#selProfessional").val() != null){
			getAvailableDates(month, year);
		}
	}

	var availableDates = [];
	
	function isAvailable(date){

		var dateAsString = (date.getMonth()+1).toString() + "/" + date.getDate() + "/" + date.getFullYear().toString();

 		<!--- if($("#selProfessional").val() == 1){
			alert("dateAsString = " + dateAsString + "  $.inArray( dateAsString, availableDates) = " + $.inArray( dateAsString, availableDates) + "  availableDates[0] = " + availableDates[0]);
		} ---> 
				
		
		var result = (availableDates.length && $.inArray( dateAsString, availableDates) > -1) ? [true] : [false];
		return result;		
	}




	// Function to find the index in an array of the first entry with a specific value. 
	//it is used to get the index of a column in the column list. 
	Array.prototype.findIdx = function(value){ 
		for (var i=0; i < this.length; i++) { 
			if (this[i] == value) { 
				return i; 
			} 
		} 
	}
	</script>
    
</head>

<body>

<form action="appointments.cfm" method="post">
	XXXXXXXXXXXXXXXXXXXXXXXX
    <label for="selService">Select Service</label>
	<select name="selService" id="selService" style="width:200px;">
    	<option value="0">Select Service</option>
		<cfoutput query="Session.objServices.qryData" group="Service_Type_Name">
            <optgroup label="#Service_Type_Name#">
			<cfoutput>
            	<option value="#Service_ID#">#Service_Name#</option>
            </cfoutput>
        	</optgroup>
        </cfoutput>
     </select>
     <br />
    <label for="selProfessional">Select Professional</label>
	<select name="selProfessional" id="selProfessional" style="width:200px;">
	<cfif IsDefined("Form.btnSubmit")>
        <cfquery name="variables.qryProfessionals" datasource="#request.dsn#">
            SELECT    Professionals.Professional_ID, Professionals.Title_ID, Professionals.Last_Name, Professionals.First_Name
                        FROM         Professionals INNER JOIN
                                              Professionals_Services ON Professionals.Professional_ID = Professionals_Services.Professional_ID
                        WHERE   Professionals.Active_Flag = 1 AND 
                                Professionals.Location_ID = 
                                <cfqueryparam value="#Session.Location_ID#" cfsqltype="cf_sql_integer" /> AND 
                                Professionals_Services.Service_ID = <cfqueryparam value="#Form.selService#" cfsqltype="cf_sql_integer" />
                        ORDER BY Professionals.Last_Name, Professionals.First_Name
        </cfquery>     
    
    	<cfoutput query="variables.qryProfessionals">
			<option value="#variables.qryProfessionals.Professional_ID#">#variables.qryProfessionals.Last_Name#, #variables.qryProfessionals.First_Name#</option>
		</cfoutput>
    </cfif>    
    </select>
     <br />
     <label for="datepicker">Date: </label>
     <input type="text" id="datepicker" name="datepicker" />   
     <input type="submit" id="btnSubmit" name="btnSubmit" value="Search"  />
</form>

<cfif IsDefined("Form.btnSubmit")>
    <cfset variables.appointmentsBean = createObject("component","admin.appointmentsCalendarBean") /> 
    <cfset variables.objQualifiedService = variables.appointmentsBean.getQualifiedServiceInfo(Form.selProfessional, Form.selService, Form.DATEPICKER, Session.objServices.arrData) />

	<cfdump var="#variables.objQualifiedService#" label="Final" />
    
    <cfoutput>
	<div>#DateFormat(Form.DATEPICKER,"full")#</div>
    <div><form>
    	
        <cfif Not ArrayLen(variables.objQualifiedService.AppointmentTimeSlots)>
			<div>There were no available appointments on this day.</div>
		</cfif>
    	
    	<cfloop array="#variables.objQualifiedService.AppointmentTimeSlots#" index="variables.timeSlots">
        	<cfset variables.EndTime = TimeFormat(DateAdd('n', variables.objQualifiedService.ServiceTime, variables.timeSlots), "hh:mm tt") />
			<cfoutput><input type="button" value="#variables.timeSlots#" onclick="addAppointmentSlot(#Session.CustomerID#, #Form.selProfessional#, #Form.selService#, '#Form.DATEPICKER#', '#variables.timeSlots#', '#variables.EndTime#');return false;" alt="#variables.timeSlots#"> &nbsp; </cfoutput>
            

	

        </cfloop>
        </form>
    </div>
	
	</cfoutput>
    
</cfif>

<script>
	function addAppointmentSlot(CustomerID, Professional_ID, ServiceID, AppointmentDate, StartTime, EndTime){
		
	alert(AppointmentDate);
	
	}
</script>
</body>
</html>
