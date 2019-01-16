<cfset local.Survey_ID = 0>
<cfif isDefined("url.Survey_ID")>
	<cfset local.Survey_ID = url.Survey_ID>
</cfif>
<cfset local.count=1>
<cfset variables.objSurvey        = CreateObject("component","survey")>
<cfset variables.qGetSurveyReport= variables.objSurvey.getSurveyReport(local.Survey_ID)>

<!---  --->
<cfinclude template="header.cfm">
<div class="container">
    <h2 class="text-center"></h2>
    <div class="row justify-content-center">
        <div class="col-md-12">
            <!--Form with header-->
            <cfoutput>
            <form action="" method="post">
                <div class="card border-primary rounded-0" style="color:black;">
                    <div class="card-header p-0">
                        <div class="bg-info text-white text-center py-2">
                            <h3><i class=""></i> #variables.qGetSurveyReport.SurveyName# Report </h3>
                            <p class="m-0"></p>
                        </div>
                    </div>
                    <div class="card-body p-3">
                        <!--Body-->
                        <div class="panel-body two-col">
                            <cfloop query="variables.qGetSurveyReport" group="SurveyQuestion">
                           	<div class="row">
                                <div class="col-md-12" style="background-color: rgba(247, 246, 246, 1);">
                                    <div>
                                        <div>
                                            <label># local.count#).</label>
                                          	#variables.qGetSurveyReport.SurveyQuestion#
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <cfloop>
                                <div class="col-md-12">
                                    <div>
                                        <div class="row">
	                          		 		<div class="col-sm-4">#variables.qGetSurveyReport.SurveyOption#</div>
	                          		 		<div class="col-sm-4">............................</div>
	                          		 		<div class="col-sm-4">#variables.qGetSurveyReport.numbers# Customers selected this option</div>
                                    	</div>
                                     </div>
                                </div>
                            </cfloop>
                          	<hr />
                            <cfset  local.count= local.count+1>
                            </cfloop> 
                    </div>
                </div>
            </form>
            </cfoutput>
            <!--Form with header-->
        </div>
    </div>
</div>
<cfinclude template="footer.cfm">

 