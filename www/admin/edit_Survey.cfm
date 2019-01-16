<cfset local.Survey_ID=0>
<cfif structKeyExists(url,"Survey_ID")>
    <cfset local.Survey_ID=url.Survey_ID>
</cfif>
<cfset variables.objSurvey        = CreateObject("component","survey")>
<cfset variables.qGetSurveyDetails= variables.objSurvey.getSurveyDetailsById(local.Survey_ID)>
<cfset local.count=1>
<cfset local.innercount=1>
<cfif structKeyExists(form,"edit_question")>
    <cfset local.value=form.edit_question>
    <cfset local.options=#evaluate("form.surveyquestionoption_#local.value#")#>
    <cfset local.question=#evaluate("form.surveyquestion_#local.value#")#>
    <cfset local.questionStatus=#evaluate("form.question_active_#local.value#")#>
    <cfset local.allQuestionId=form.questionid>
    <cfset local.questionId=listGetAt(local.allQuestionId, local.value)>
    <cfset variables.objSurvey  = CreateObject("component","survey")>
    <cfset variables.qEditSurvey = variables.objSurvey.editSurveyDetails(local.questionId,local.question,local.options,local.questionStatus)>
    <cfset variables.objSurvey        = CreateObject("component","survey")>
    <cfset variables.qGetSurveyDetails= variables.objSurvey.getSurveyDetailsById(local.Survey_ID)>
<cfelseif structKeyExists(form,"delete_option")>
    <cfset local.opionId=form.delete_option>
    <cfset variables.objSurvey  = CreateObject("component","survey")>
    <cfset variables.qDeleteSurvey = variables.objSurvey.deleteOption(local.opionId)>
    <cfset variables.objSurvey        = CreateObject("component","survey")>
    <cfset variables.qGetSurveyDetails= variables.objSurvey.getSurveyDetailsById(local.Survey_ID)>
</cfif>

<style>
#cnt1 {
    background-color: rgba(215, 212, 212, 0.88);
    margin-bottom: 70px;
}

#panel1 {
    padding:20px;
}

.panel-body:not(.two-col) {
    padding: 0px;
}

.panel-body .radio, .panel-body .checkbox {
    margin-top: 0px;
    margin-bottom: 0px;
}

.panel-body .list-group {
    margin-bottom: 0;
}

.margin-bottom-none {
    margin-bottom: 0;
}
</style>
<cfinclude template="header.cfm">
<div class="container" id="cnt1">
    <div class="col-md-2">
    </div>
    <form method="POST" action="" >
        <cfoutput>
            <div class="col-md-8" id="panel1">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <span class="fa fa-question-circle"></span>#variables.qGetSurveyDetails.SurveyName#</h3>
                    </div>
                    <div class="panel-body two-col">
                        <cfloop query="variables.qGetSurveyDetails" group="SurveyQuestion">
                        <div class="row">
                            <div class="col-md-8">
                                <input type="hidden" name="questionid" id="questionid" value="#variables.qGetSurveyDetails.SurveyQuesID#">
                                <label>Question #local.count#</label>
                                <div class="">
                                    <div class="checkbox">
                                        <textarea id="surveyquestion_#local.count#" name="surveyquestion_#local.count#" rows="3" cols="53" maxlength="100">#variables.qGetSurveyDetails.SurveyQuestion#</textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4" style="padding-top: 42px;">
                                <label>Active:</label><br>
                                <cfif variables.qGetSurveyDetails.QuesStatus eq 1>
                                    <input type="radio" name="question_active_#local.count#" id="question_active_#local.count#" value="1" checked="checked">Active
                                    <input type="radio" name="question_active_#local.count#" id="question_inactive_#local.count#" value="0">Inactive
                                <cfelse>
                                    <input type="radio" name="question_active_#local.count#" id="question_active_#local.count#" value="1">Active
                                    <input type="radio" name="question_active_#local.count#" id="question_inactive_#local.count#" value="0" checked="checked">Inactive
                                </cfif>
                            </div>
                        </div>
                        <label>Options</label>
                        <div class="addOptionDiv_#local.count#">
                            <cfloop>
                                <div class="row" id="optionDiv_#local.innercount#">
                                        <div class="col-md-8" style="padding-top: 8px;">
                                            <div class="checkbox">
                                                <div>
                                                   <input type="text" id="surveyquestionoption_#local.count#" name="surveyquestionoption_#local.count#" value="#variables.qGetSurveyDetails.SurveyOption#" maxlength="100" style="width: 400px;">
                                                </div>
                                            </div>
                                        </div>
                                        <cfset local.innercount=local.innercount+1>
                                        <div class="col-md-2" style="padding-top: 10px;">
                                            <button type="submit" name="delete_option" id="delete_option"  value="#variables.qGetSurveyDetails.SurveyQuesOpID#">Delete</button>
                                        </div>
                                </div>
                            </cfloop>
                         </div>
                         <br>
                        <div class="row">
                            <div class="col-sm-4" style="padding-left: 198px">
                                   <button type="button" name="add_option_#local.count#" id="add_option_#local.count#" value="#variables.qGetSurveyDetails.SurveyQuesID#" onclick="addOption(#variables.qGetSurveyDetails.SurveyQuesID#,#local.count#,#local.innercount#)"><span class="icon-plus-sign">Add Option</span></button> 
                            </div>
                        </div>
                        <br>
                        <div class="col-sm-4" style="padding-left: 298px;">
                                <button type="submit" name="edit_question" id="edit_question" class="btn btn-info btn-md" value="#local.count#">Edit</button>
                        </div>
                        <br><br>
                        <hr />
                        <cfset local.count=local.count+1>
                        </cfloop> 
                    </div>
                </div>
            </div>
        </cfoutput>
    </form>
</div>
<cfinclude template="footer.cfm">
<script type="text/javascript">
    function addOption(questionId,count,innercount){
        
        $(".addOptionDiv_"+count).append('<div class="row" id="optionDiv_'+innercount+'"><div class="col-md-8" style="padding-top: 8px;"><div><div class="checkbox"><input type="text" id="surveyquestionoption_'+count+'" name="surveyquestionoption_'+count+'" value="" maxlength="100" style="width: 400px;"></div></div></div><div class="col-md-2" style="padding-top: 10px;"><button type="submit" name="remove_option" id="remove_option" value="" onclick="deleteOption(#local.innercount#)">Delete</button></div></div>')
    }

    
    // $('#edit_question').click(function(){
    //     alert($('#edit_question').val());
    //     var count=$('#edit_question').val();

    //     if($('#surveyquestion_'+count).val() == ""){
    //         alert("please enter the question");
    //         return false;
    //     }
    //     // else{
    //     //     for(i=1;i<=count;i++){
            
    //     //         if($('#option_'+i+'').val()==""){
    //     //         alert("please fill the option fields");
    //     //         return false;
    //     //         }

    //     //     }
    //     // }
            
    // });


</script>

