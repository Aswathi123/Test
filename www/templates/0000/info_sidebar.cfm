<h4>Hours of Operation</h4>
<!--- <cfinclude template="/templates/0001/info_bar.cfm"> --->
<cfinclude template="/customer_sites/include_hours.cfm">
<h4>Payment methods</h4>
<cfinclude template="/customer_sites/include_payment_methods.cfm">
<cfif Len(qLocation.Cancellation_Policy)>
 <h4>Cancellation Policy</h4>
<cfinclude template="/customer_sites/include_cancellation_policy.cfm">
</cfif>

<cfif Len(qLocation.Parking_Fees)>
<h4>Parking Fees</h4>
<cfinclude template="/customer_sites/include_parking_fees.cfm">
</cfif> <!------>