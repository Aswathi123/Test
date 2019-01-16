<cfquery datasource="salonworks">
	UPDATE 
		Company_Prices
	SET 
		Company_Service_Plan_ID = 1 
	WHERE
		Company_ID IN (
		SELECT 
			Company_ID 
		FROM
			Companies
		WHERE Trial_Expiration < '#Dateformat(Now(),'yyyy-mm-dd')#'
		AND Next_Billing_Date is NULL 
		OR Next_Billing_Date < '#Dateformat(Now(),'yyyy-mm-dd')#'
		)
</cfquery>