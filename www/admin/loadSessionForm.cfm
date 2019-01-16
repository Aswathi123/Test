
	<cfinvoke component="login" method="getCompany" returnvariable="qryCompany">
		<cfinvokeargument name="company_id" value="#session.company_id#">
	</cfinvoke>    

	<cfset Session.Form.WebAddress = Trim(qryCompany.Web_Address)  />
    <cfset Session.Form.CompanyName = Trim(qryCompany.Company_Name)  />
    <cfset Session.Form.CompanyAddress = Trim(qryCompany.Company_Address)  />
    <cfset Session.Form.CompanyAddress2 = Trim(qryCompany.Company_Address2)  />
    <cfset Session.Form.CompanyCity = Trim(qryCompany.Company_City)  />
    <cfset Session.Form.CompanyState = Trim(qryCompany.Company_State)  />
    <cfset Session.Form.CompanyPostal = Trim(qryCompany.Company_Postal)  />
    <cfset Session.Form.CompanyPhone = Trim(qryCompany.Company_Phone)  />
    <cfset Session.Form.CompanyEmail = Trim(qryCompany.Company_Email)  />
    <cfset Session.Form.CompanyFax = Trim(qryCompany.Company_Fax)  />
    <cfset Session.Form.CompanyDescription = Trim(qryCompany.Company_Description)  />    
    
    
	<cfinvoke component="login" method="getLocation" returnvariable="qryLocation">
		<cfinvokeargument name="Location_ID" value="#session.Location_ID#">
	</cfinvoke>   
    
	<cfset Session.Form.LocationName = Trim(qryLocation.Location_Name)  />
	<cfset Session.Form.ContactName = Trim(qryLocation.Contact_Name)  />
	<cfset Session.Form.ContactPhone = Trim(qryLocation.Contact_Phone)  />
	<cfset Session.Form.LocationAddress = Trim(qryLocation.Location_Address)  />
    <cfset Session.Form.LocationAddress2 = Trim(qryLocation.Location_Address2)  />
    <cfset Session.Form.LocationCity = Trim(qryLocation.Location_City)  />
    <cfset Session.Form.LocationState = Trim(qryLocation.Location_State)  />
    <cfset Session.Form.LocationPostal = Trim(qryLocation.Location_Postal)  />
    <cfset Session.Form.LocationPhone = Trim(qryLocation.Location_Phone)  />
    <cfset Session.Form.LocationFax = Trim(qryLocation.Location_Fax)  />
    <cfset Session.Form.Description = Trim(qryLocation.Description)  />
    <cfset Session.Form.PaymentMethodsList = Trim(qryLocation.Payment_Methods_List)  />
    <cfset Session.Form.ServicesList = Trim(qryLocation.Services_List)  />
    <cfset Session.Form.ParkingFees = Trim(qryLocation.Parking_Fees)  />
    <cfset Session.Form.CancellationPolicy = Trim(qryLocation.Cancellation_Policy)  />
    <cfset Session.Form.Languages = Trim(qryLocation.Languages)  />
    <cfset Session.Form.Directions = Trim(qryLocation.Directions)  />
    <cfset Session.Form.ServicesList = Trim(qryLocation.Services_List)  />
    
    
    <cfset variables.Sunday_Hours = Trim(qryLocation.Sunday_Hours) />
	<cfif variables.Sunday_Hours neq 'Closed' and Len(variables.Sunday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Sunday_Hours," to ") />
    	<cfset Session.Form.SundayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.SundayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.SundayHoursFrom = "Closed" />
      	<cfset Session.Form.SundayHoursTo = "Closed" />
    </cfif>
  
    <cfset variables.Monday_Hours = Trim(qryLocation.Monday_Hours) />
	<cfif variables.Monday_Hours neq 'Closed' and Len(variables.Monday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Monday_Hours," to ") />
    	<cfset Session.Form.MondayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.MondayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.MondayHoursFrom = "Closed" />
      	<cfset Session.Form.MondayHoursTo = "Closed" />
    </cfif>

    <cfset variables.Tuesday_Hours = Trim(qryLocation.Tuesday_Hours) />
	<cfif variables.Tuesday_Hours neq 'Closed' and Len(variables.Tuesday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Tuesday_Hours," to ") />
    	<cfset Session.Form.TuesdayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.TuesdayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.TuesdayHoursFrom = "Closed" />
      	<cfset Session.Form.TuesdayHoursTo = "Closed" />
    </cfif>
    
    <cfset variables.Wednesday_Hours = Trim(qryLocation.Wednesday_Hours) />
	<cfif variables.Wednesday_Hours neq 'Closed' and  Len(variables.Wednesday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Wednesday_Hours," to ") />
    	<cfset Session.Form.WednesdayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.WednesdayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.WednesdayHoursFrom = "Closed" />
      	<cfset Session.Form.WednesdayHoursTo = "Closed" />
    </cfif>

    <cfset variables.Thursday_Hours = Trim(qryLocation.Thursday_Hours) />
	<cfif Len(variables.Thursday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Thursday_Hours," to ") />
    	<cfset Session.Form.ThursdayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.ThursdayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.ThursdayHoursFrom = "Closed" />
      	<cfset Session.Form.ThursdayHoursTo = "Closed" />
    </cfif>

    <cfset variables.Friday_Hours = Trim(qryLocation.Friday_Hours) />
	<cfif Len(variables.Friday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Friday_Hours," to ") />
    	<cfset Session.Form.FridayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.FridayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.FridayHoursFrom = "Closed" />
      	<cfset Session.Form.FridayHoursTo = "Closed" />
    </cfif>

    <cfset variables.Saturday_Hours = Trim(qryLocation.Saturday_Hours) />
	<cfif variables.Saturday_Hours neq 'Closed' and Len(variables.Saturday_Hours) GT 0>
    	<cfset tempHoursArray = listToArray(variables.Saturday_Hours," to ") />
    	<cfset Session.Form.SaturdayHoursFrom = tempHoursArray[1] />
    	<cfset Session.Form.SaturdayHoursTo = tempHoursArray[2] />
    <cfelse>
        <cfset Session.Form.SaturdayHoursFrom = "Closed" />
      	<cfset Session.Form.SaturdayHoursTo = "Closed" />
    </cfif> 
    
	<cfinvoke component="login" method="getProfessional" returnvariable="qryProfessional">
		<cfinvokeargument name="Professional_ID" value="#session.Professional_ID#">
	</cfinvoke>           
    
    <cfset Session.Form.FirstName = Trim(qryProfessional.First_Name)  />
    <cfset Session.Form.LastName = Trim(qryProfessional.Last_Name)  />
    <cfset Session.Form.LicenseNumber = Trim(qryProfessional.License_No)  />
    <cfset Session.Form.LicenseExpirationMonth = Trim(qryProfessional.License_Expiration_Month)  />
    <cfset Session.Form.LicenseExpirationYear = Trim(qryProfessional.License_Expiration_Year)  />
    <cfset Session.Form.LicenseState = Trim(qryProfessional.License_State)  />
    <cfset Session.Form.HomePhone = Trim(qryProfessional.Home_Phone)  />
    <cfset Session.Form.MobilePhone = Trim(qryProfessional.Mobile_Phone)  />
    <cfset Session.Form.HomeAddress = Trim(qryProfessional.Home_Address)  />
    <cfset Session.Form.HomeAddress2 = Trim(qryProfessional.Home_Address2)  />
    <cfset Session.Form.HomeCity = Trim(qryProfessional.Home_City)  />
    <cfset Session.Form.HomePostal = Trim(qryProfessional.Home_Postal)  />
    <cfset Session.Form.HomeState = Trim(qryProfessional.Home_State)  />
    <cfset Session.Form.EmailAddress = Trim(qryProfessional.Email_Address)  />
    <cfset Session.Form.Password = Trim(qryProfessional.Password)  />
    <cfset Session.Form.ServicesOffered = Trim(qryProfessional.Services_Offered)  />
    <cfset Session.Form.Accredidations = Trim(qryProfessional.Accredidations)  />
    <cfset Session.Form.Bio = Trim(qryProfessional.Bio)  />   