<!--- VARIABLE DECLARATION --->
<cfset local.survey=structNew()>

<!--- CONTROL FLOW --->
<cfif isDefined("submit_survey")>
	<cfset local.survey.surveyName=form.survey_name>
	<cfset local.survey.surveyTitle=form.survey_title>
	<cfset local.survey.surveyActive=form.survey_active>
	<cfset variables.objSurvey 	= CreateObject("component","survey")>
	<cfset variables.qGetSurvey	= variables.objSurvey.insertSurvey(local.survey)>
</cfif>


<!--- HTML --->
<cfinclude template="header.cfm">
</style>
	<div class="row">
		<div class="col-sm-9" >
			<form method="POST" action="">
				<div class="row">
					<div class="form-group">
						<div class="col-sm-10">
							<label>Type Survey Name:</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-5 form-group">
						<input type="text" name="survey_name" class="form-control" id="survey_name" maxlength="50" value="" placeholder="Type survey name"> 
					</div>
				</div>
				<div class="row">
					<div class="col-md-5 form-group">
						<label>Type Survey Title/Description:</label>
						<textarea name="survey_title" class="form-control" id="survey_title" maxlength="100" value="" placeholder="Type survey title/description"></textarea> 
					</div>
				</div>
				<div class="row">
					<div class="col-md-5 form-group" >
						<label>Active:</label><br>
						<input type="radio" name="survey_active" id="survey_active" value="1" checked="checked">Active
						<input type="radio" name="survey_active" id="survey_inactive" value="0">Inactive
					</div>
				</div>

				<div class="row">
					<div class="col-md-10 form-group" style="padding-left: 145px;">
						<button type="submit" name="submit_survey" id="submit_survey" class="btn btn-info btn-md">Add</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<cfinclude template="footer.cfm">

<script type="text/javascript">
	$(document).ready(function() {

		$('#submit_survey').click(function(){
			if($('#survey_name').val()==""){
				alert("please enter the survey name");
				return false;
			}
			if($('#survey_title').val()==""){
				alert("please enter the survey title");
				return false;
			}



		})

	});

</script>