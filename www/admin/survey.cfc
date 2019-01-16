<cfcomponent displayname="Survey" hint="">
	<cffunction name="insertQuestionsDetails" access="public" output="false" returntype="any" hint="insert question in to the table">
		<cfargument name="form" type="any">
		<cfargument name="surveyId" type="any">
		<cfquery name="qInsertQuestion" datasource="#request.dsn#" result="queryResult">
			INSERT INTO SurveyQuestions(
				SurveyID
				,SurveyQuestion
				,IsActive
				)
			 VALUES(
			 	<cfqueryparam value="#arguments.surveyId#" cfsqltype="cf_sql_integer">
			 	,<cfqueryparam value="#arguments.form.question#" cfsqltype="cf_sql_nvarchar">
			 	,<cfqueryparam value="#arguments.form.question_active#" cfsqltype="cf_sql_nvarchar">
			 	)
		</cfquery>
		<cfif len(#queryResult.generatedKey#)>
			<cfset local.questionID=#queryResult.generatedKey#>
			<cfreturn local.questionID>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>

	<cffunction name="insertSurvey" access="public" displayName = "Insert details">
		<cfargument name="survey" default="" type="struct">
		<cfquery name="local.qryInsSurvey" datasource="#request.dsn#">
			INSERT INTO Surveys
			(
				SurveyName,
				SurveyTitle,
				IsActive,
				UniqueKey
			) 
			VALUES
			(
				<cfqueryparam value="#arguments.survey.surveyName#" cfsqltype="cf_sql_varchar"/>,
				<cfqueryparam value="#arguments.survey.surveyTitle#" cfsqltype="cf_sql_varchar"/>,
				<cfqueryparam value="#arguments.survey.surveyActive#" cfsqltype="cf_sql_varchar"/>,
				<cfqueryparam value="#createUUID()#" cfsqltype="cf_sql_varchar"/>
			)
		</cfquery>
	</cffunction>

	<cffunction name="insSurveyDetails" access="public" displayName = "Insert details">
		<cfargument name="survey" default="" type="struct">
		<cfquery name="qryInsSurveyData" datasource="#request.dsn#">
			<cfloop from="1" to="#count#" index="i">
				INSERT INTO SurveyData
				(
					SurveyID,
					SurveyQuesID,
					OptionID,
					Other
					
				)
				VALUES
				(	
					<cfqueryparam value="#arguments.survey.surveyid#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#evaluate("arguments.survey.question_#i#")#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#evaluate("arguments.survey.option_#i#")#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#evaluate("arguments.survey.textboxother_#i#")#" cfsqltype="cf_sql_nvarchar">
				)
			</cfloop>
		</cfquery>
	</cffunction>


	<cffunction name="insertQuestionOptionDetails" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="form" type="any">
		<cfargument name="questionId" type="any">
		<cfset count=arguments.form.OPTCOUNT>
		<cfquery name="qInsertQuestion" datasource="#request.dsn#">
			<cfloop from="1" to="#count#" index="i">
				<cfif structKeyExists(arguments.form, "other_op#i#")>
					<cfset other_op=1>
				<cfelse>
					<cfset other_op=0>
				</cfif>
				INSERT INTO SurveyQuestionOptions(
					SurveyQuesID
					,SurveyOption
					,IsOther
					,IsActive
					)
				 VALUES(
				 	<cfqueryparam value="#arguments.questionId#" cfsqltype="cf_sql_integer">
				 	,<cfqueryparam value="#evaluate("arguments.form.option_#i#")#" cfsqltype="cf_sql_nvarchar">
				 	<cfif other_op eq 1>
				 		,<cfqueryparam value="1" cfsqltype="cf_sql_bit">
				 	<cfelse>
				 		,<cfqueryparam value="0" cfsqltype="cf_sql_bit">	
				 	</cfif>
				 	,<cfqueryparam value="#evaluate("arguments.form.option_active_#i#")#" cfsqltype="cf_sql_nvarchar">
				 	)

			</cfloop>
		</cfquery>
	</cffunction>

	<cffunction name="changeStatus" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="statusValue" type="any">
		<cfargument name="surveyID" type="any">
		<cfquery name="qUpdSurveyStatus" datasource="#request.dsn#">
			<cfif arguments.statusValue eq 1>
				update Surveys
				set IsActive=0 
				where SurveyID=<cfqueryparam value="#arguments.surveyID#" cfsqltype="cf_sql_integer">
			<cfelseif arguments.statusValue eq 0>
				update Surveys
				set IsActive=1 
				where SurveyID=<cfqueryparam value="#arguments.surveyID#" cfsqltype="cf_sql_integer">
			</cfif>
		</cfquery>
	</cffunction>

	<cffunction name="deleteOption" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="optionId" type="any">
		<cfquery name="qUpdSurveyStatus" datasource="#request.dsn#">
			delete from SurveyQuestionOptions
			where SurveyQuesOpID=<cfqueryparam value="#arguments.optionId#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="getSurveyDetailsById" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="surveyid" type="any">
		<cfquery name="qgetSurveyDetails" datasource="#request.dsn#">
		    select s.SurveyName,sq.SurveyQuestion,sq.IsActive as QuesStatus,sqo.SurveyOption,sqo.IsActive as OpStatus,sq.SurveyQuesID,s.SurveyID,sqo.SurveyQuesOpID,sqo.IsOther
		    from Surveys s  
		    inner join SurveyQuestions sq on s.SurveyID=sq.SurveyID 
		    inner join SurveyQuestionOptions sqo on sq.SurveyQuesID=sqo.SurveyQuesID 
		    where s.SurveyID=<cfqueryparam value=#arguments.surveyid# cfsqltype="cf_sql_integer"> order by sq.SurveyQuestion asc
		</cfquery>
		<cfreturn qgetSurveyDetails>
	</cffunction>

	<cffunction name="getSurveyDetailsByStatus" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="surveyid" type="any">
		<cfquery name="qgetSurveyDetails" datasource="#request.dsn#">
		    select s.SurveyName,sq.SurveyQuestion,sq.IsActive as QuesStatus,sqo.SurveyOption,sqo.IsActive as OpStatus,sq.SurveyQuesID,s.SurveyID,sqo.SurveyQuesOpID,sqo.IsOther
		    from Surveys s  
		    inner join SurveyQuestions sq on s.SurveyID=sq.SurveyID 
		    inner join SurveyQuestionOptions sqo on sq.SurveyQuesID=sqo.SurveyQuesID 
		    where s.SurveyID=<cfqueryparam value=#arguments.surveyid# cfsqltype="cf_sql_integer"> and sq.IsActive=1 order by sq.SurveyQuestion asc
		</cfquery>
		<cfreturn qgetSurveyDetails>
	</cffunction>

	<cffunction name="getSurvey" access="public" output="false" returntype="any" hint="insert question options">
		
		<cfquery name="qgetSurvey" datasource="#request.dsn#">
		   SELECT 
		   *
		   FROM
		   Surveys
		</cfquery>
		<cfreturn qgetSurvey>
	</cffunction>

	<cffunction name="editSurveyDetails" access="public" output="false" returntype="any" hint="insert question options">
		<cfargument name="questionid" type="any" default="0">
		<cfargument name="question" type="any" default="">
		<cfargument name="options" type="any" default="">
		<cfargument name="questionstatus" type="any" default="">
		<cfset length=listLen(arguments.options)>
		<cfquery name="qUpdSurveyDetails" datasource="#request.dsn#">
		    update SurveyQuestions 
		    set SurveyQuestion=<cfqueryparam value="#arguments.question#" cfsqltype="cf_sql_nvarchar">,
		    	IsActive=<cfqueryparam value="#arguments.questionstatus#" cfsqltype="cf_sql_integer">
		    where SurveyQuesID=<cfqueryparam value="#arguments.questionId#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfquery name="qDeleteSurveyDetails" datasource="#request.dsn#">
		    delete from SurveyQuestionOptions 
		    where SurveyQuesID=<cfqueryparam value="#arguments.questionId#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfquery name="qInsertSurveyDetails" datasource="#request.dsn#">
		  	<cfloop from="1" to="#length#" index="i">
				INSERT INTO SurveyQuestionOptions(
					SurveyQuesID
					,SurveyOption
					,IsOther
					,IsActive
					)
				 VALUES(
				 	<cfqueryparam value="#arguments.questionId#" cfsqltype="cf_sql_integer">
				 	,<cfqueryparam value="#trim(listGetAt(arguments.options,i))#" cfsqltype="cf_sql_nvarchar">
				 	<cfif listGetAt(arguments.options,i) eq "Other">
				 		,<cfqueryparam value="1" cfsqltype="cf_sql_bit">
				 	<cfelse>
				 		,<cfqueryparam value="0" cfsqltype="cf_sql_bit">	
				 	</cfif>
				 	,1
				 	)
			</cfloop>
		</cfquery>
	</cffunction>

	<cffunction name="getSurveyReport" access="public" returntype="any" hint="get survey report">
		<cfargument name="surveyID" default="0">
		<cfquery name="getSurveyData" datasource="#request.dsn#">
			select count(sd.OptionID) as numbers, sq.SurveyQuestion,sqo.SurveyOption,sq.SurveyQuesID,sqo.SurveyQuesOpID,s.SurveyName
			from SurveyQuestions as sq 
			inner join SurveyQuestionOptions as sqo on sq.SurveyQuesID=sqo.SurveyQuesID
			inner join Surveys as s on s.SurveyID=sq.SurveyID
			left join SurveyData as sd on sd.OptionID=sqo.SurveyQuesOpID
			where sq.SurveyID=<cfqueryparam value="#arguments.surveyID#" cfsqltype="cf_sql_integer">
			group by sq.SurveyQuestion,sqo.SurveyOption,sq.SurveyQuesID,sqo.SurveyQuesOpID,s.SurveyName
			order by sq.SurveyQuesID,sqo.SurveyQuesOpID
		</cfquery>
		<cfreturn getSurveyData>
	</cffunction>
</cfcomponent>