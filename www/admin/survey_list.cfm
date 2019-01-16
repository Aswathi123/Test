<cfif structKeyExists(form,"active_button")>
	<cfset statusValue=1>
	<cfset surveyID=form.active_button>
	<cfset variables.objSurvey 	= CreateObject("component","survey")>
	<cfset variables.qUpdSurvey	= variables.objSurvey.changeStatus(statusValue,surveyID)>
<cfelseif structKeyExists(form,"inactive_button")>
	<cfset statusValue=0>
	<cfset surveyID=form.inactive_button>
	<cfset variables.objSurvey 	= CreateObject("component","survey")>
	<cfset variables.qUpdSurvey	= variables.objSurvey.changeStatus(statusValue,surveyID)>
</cfif>

<cfset variables.objSurvey 	= CreateObject("component","survey")>
<cfset variables.qGetSurvey	= variables.objSurvey.getSurvey()>
<cfset local.count=1>
<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_surveys td {
		vertical-align:middle;
	}
	#table_surveys td img {
		width:250px !important;
	}
	#table_surveys{

	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
	.form-group {
		margin-bottom:0px;
	}
</style>
<cfinclude template="header.cfm">
<form method="post" action="">
	<div class="row">
		<div class="table-responsive col-sm-10">
			<table id="table_surveys" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="col-sm-2">Survey Name</th>
						<th class="col-sm-6 center">Action</th>
					</tr>
				</thead>
				<tbody>
					<cfif variables.qGetSurvey.recordcount>
						<cfoutput query="variables.qGetSurvey">
							<tr>
								<td>#variables.qGetSurvey.SurveyName#</td>
								<td style="text-align: center">
										<cfif #variables.qGetSurvey.IsActive# eq 1>
											<button class="btn btn-info btn-sm" type="submit" id="active_button" name="active_button" value="#variables.qGetSurvey.SurveyID#">Active</button>
										<cfelseif #variables.qGetSurvey.IsActive# eq 0>
											<button class="btn btn-info btn-sm" type="submit" id="inactive_button" name="inactive_button" value="#variables.qGetSurvey.SurveyID#">Inactive</button>
										</cfif>
										&nbsp;&nbsp;
										<a href="survey_question.cfm?Survey_ID=#variables.qGetSurvey.SurveyID#" name="addQuestion" style="color: white;">
											<button type="button" id="add_question" class="btn btn-info btn-sm" >
												Add Questions
											</button>
										</a>
										&nbsp;&nbsp;
										<a href="view_survey.cfm?Survey_ID=#variables.qGetSurvey.SurveyID#" name="viewQuestion" style="color: white;">
											<button type="button" id="view_question" class="btn btn-info btn-sm">
												View
											</button>
										</a>
										&nbsp;&nbsp;
										<a href="edit_survey.cfm?Survey_ID=#variables.qGetSurvey.SurveyID#" name="editQuestion" style="color: white;">
											<button type="button" id="edit_question" class="btn btn-info btn-sm">
												Edit
											</button>
										</a>
										&nbsp;&nbsp;
										<a href="survey_report.cfm?Survey_ID=#variables.qGetSurvey.SurveyID#" name="viewReport" style="color: white;">
											<button type="button" id="view_report" class="btn btn-info btn-sm">
												View Report
											</button>
										</a>
										&nbsp;&nbsp;
										<input type="text" name="link#local.count#" id="link#local.count#" value="http://13.58.245.95:8500/survey_form.cfm?surveyID=#variables.qGetSurvey.SurveyID#" style="position:absolute;left:-999em">
										
										<button type="button" id="copy_to_clipboard#local.count#" class="btn btn-info btn-sm" value="" onclick="copyToClipboard(#local.count#)">
												Copy Link
											</button>
								</td>
							</tr>
							<cfset local.count=local.count+1>
						</cfoutput>
						<input type="hidden" name="link" id="link" value="">
					<cfelse>
						<tr>
							<td align="center" colspan="4">No Surveys Found</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
	</div>	
</form>	
<cfinclude template="footer.cfm">
<script type="text/javascript">

	// $("#copy_to_clipboard1").click(function(){
	// 	$(this).focus();
 //     	$(this).select();
 //    	document.execCommand('copy');
	// })
	function copyToClipboard(count){
		var copyText = document.getElementById("link"+count);
		copyText.select();
		document.execCommand("copy");
	  	alert("Copied the text: " + copyText.value);

	}
</script>