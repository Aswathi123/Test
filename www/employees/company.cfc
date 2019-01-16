<cfcomponent displayname="Company" hint="">

	<cffunction name="getCompanyReport" access="public" output="true" returntype="query">
		<cfargument name="employee_id" default="">
		<cfquery name="qGetCompanyReport" datasource="#request.dsn#">
			SELECT C.company_name, C.company_email, C.trial_expiration, C.order_date
			FROM companies C
			<!--- LEFT JOIN employees E on E.referral_code = C.promo_code --->
			where 
				C.employee_id = <cfqueryparam value="#arguments.employee_id#" cfsqltype="cf_sql_integer" /> AND
				(C.order_date >= dateadd (day , -30 ,getdate()) OR C.order_date IS NULL )
			order by C.company_id desc
		</cfquery>
		<cfreturn qGetCompanyReport>
	</cffunction>
	
</cfcomponent>