<cfset local.Survey_ID=0>
<cfif structKeyExists(url,"Survey_ID")>
    <cfset local.Survey_ID=url.Survey_ID>
</cfif>
<cfset variables.objSurvey        = CreateObject("component","survey")>
<cfset variables.qGetSurveyDetails= variables.objSurvey.getSurveyDetailsById(local.Survey_ID)>
<cfset local.count=1>
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
    <div class="col-md-1">
    </div>
    <cfoutput>
    <div class="col-md-11" id="panel1">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <span class="fa fa-question-circle"></span>#variables.qGetSurveyDetails.SurveyName#</h3>
            </div>
            <div class="panel-body two-col">
                <cfloop query="variables.qGetSurveyDetails" group="SurveyQuestion">
                <div class="row">
                    <div class="col-md-12">
                        
                        <div class="well well-sm">
                            
                            <div class="checkbox">
                                <label>#local.count#).</label>
                                <label>
                                  #variables.qGetSurveyDetails.SurveyQuestion# 
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <cfloop>
                    <div class="col-md-3" style="padding-left: 50px;">
                        <div class="">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="">
                                    #variables.qGetSurveyDetails.SurveyOption#
                                </label>
                            </div>
                        </div>
                    </div>
                </cfloop>
               <hr/>
                <cfset local.count=local.count+1>
                </cfloop> 
            </div>
        </div>
    </div>
 </cfoutput>
</div>
<cfinclude template="footer.cfm">

