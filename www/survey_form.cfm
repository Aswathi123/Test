<cfset local.Survey_ID = 0>
<cfif isDefined("url.surveyID")>
    <cfset local.Survey_ID = url.surveyID>
</cfif>
<cfif structKeyExists(form, "submit_survey_form")>
    <cfset variables.objSurvey        = CreateObject("component","admin.survey")>
    <cfset variables.qInsSurveyDetails= variables.objSurvey.insSurveyDetails(form)>
</cfif>
<cfset variables.objSurvey        = CreateObject("component","admin.survey")>
<cfset variables.qGetSurveyDetails= variables.objSurvey.getSurveyDetailsByStatus(local.Survey_ID)>
<cfset count=1>
<cfset innercount=1>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
<div class="container">
    <h2 class="text-center"></h2>
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6 pb-5">
            <!--Form with header-->
            <cfoutput>
            <form action="" method="post">
                <input type="hidden" name="surveyid" id="surveyid" value="#local.Survey_ID#">
                <div class="card border-primary rounded-0" style="color:black;">
                    <div class="card-header p-0">
                        <div class="bg-info text-white text-center py-2">
                            <h3><i class=""></i>#variables.qGetSurveyDetails.SurveyName# </h3>
                            <p class="m-0"></p>
                        </div>
                    </div>
                    <div class="card-body p-3">
                        <!--Body-->
                        <div class="panel-body two-col">
                            <cfloop query="variables.qGetSurveyDetails" group="SurveyQuestion">
                            <input type="hidden" name="question_#count#" id="question_#count#" value="#variables.qGetSurveyDetails.SurveyQuesID#">
                            <cfif #variables.qGetSurveyDetails.QuesStatus# eq 1>
                            <div class="row">
                                <div class="col-md-12" style="background-color: rgba(247, 246, 246, 1);">
                                    
                                    <div class="well well-sm">
                                        
                                        <div class="row">
                                            <label>#count#).</label>
                                            <label class="col-md-11">
                                              #variables.qGetSurveyDetails.SurveyQuestion# 
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <cfloop>
                                <div class="col-md-8">
                                    <div>
                                        <div>
                                            
                                                <cfif #variables.qGetSurveyDetails.OpStatus# eq 1>
                                                <input type="radio" name="option_#innercount#" id="option_#innercount#" value="#variables.qGetSurveyDetails.SurveyQuesOpID#" onclick="getValue(#variables.qGetSurveyDetails.IsOther#,#innercount#)">
                                             
                                                #variables.qGetSurveyDetails.SurveyOption#
                                               
                                                </cfif>
                                            
                                        </div>
                                    </div>
                                </div>
                            </cfloop>
                            </cfif>
                            <div style="display: none;padding-left: 34px;" id="textboxOther_#innercount#" class="textboxOther_#innercount#">
                                <input type="text" name="textboxOther_#innercount#" >
                            </div>
                            <cfset innercount=innercount+1>
                            <cfset count=count+1>
                            </cfloop> 
                    </div>
                    <cfset count=count-1>
                    <input type="hidden" name="count" id="count" value="#count#">
                </div>
                <diV style="text-align: center;padding-bottom: 10px">
                    <button name="submit_survey_form" id="submit_survey_form" class="btn btn-info btn-md">Submit</button>
                </diV>
            </form>
            </cfoutput>
            <!--Form with header-->
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('#submit_survey_form').click(function(){
            var count=$('#count').val();
            for(i=1;i<=count;i++){

               if ($('input[name="option_'+i+'"]:checked').length == 0){
                    alert("Please choose the option");
                    return false;
                }
                else{
                  $("form").submit(); 
                }
            }

        });

    });

    function getValue(IsOther,InnerCount){
       
        if(IsOther == 1){
           $('#textboxOther_'+InnerCount).show();
        }
        else{
            $('#textboxOther_'+InnerCount).hide();
        }
        
    }

</script>