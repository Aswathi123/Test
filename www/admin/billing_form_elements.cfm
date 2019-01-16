<cfparam name="variables.Billing_First_Name" default="">
<cfparam name="variables.Billing_Last_Name" default="">
<cfparam name="variables.Billing_Address1" default="">
<cfparam name="variables.Billing_City" default="">
<cfparam name="variables.Billing_State" default="">
<cfparam name="variables.Billing_Zip" default="">
<cfparam name="variables.Credit_Card" default=""> 
<cfparam name="variables.cardCode" default=""> 
<cfparam name="variables.expirationDate" default=""> 
<cfoutput>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">First&nbsp;Name*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_First_Name" class="form-control"  value="#variables.Billing_First_Name#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Last&nbsp;Name*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_Last_Name" class="form-control"  value="#variables.Billing_Last_Name#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Billing&nbsp;Address*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_Address1" class="form-control" value="#variables.Billing_Address1#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Billing&nbsp;City*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_City" class="form-control"  value="#variables.Billing_City#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Billing&nbsp;State*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_State" class="form-control"  value="#variables.Billing_State#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Billing&nbsp;Zip*</label>
		<div class="col-sm-6">
			<input type="text" name="Billing_Zip" class="form-control"  value="#variables.Billing_Zip#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Credit Card Number*</label>
		<div class="col-sm-6">
			<input type="text" name="Credit_Card" class="form-control"  value="#variables.Credit_Card#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">CVV*</label>
		<div class="col-sm-6">
			<input type="password" name="cardCode" class="form-control"  value="#variables.cardCode#" maxlength="50" required>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-sm-12 form-group">
		<label for="x" class="col-sm-4 control-label">Expiration</label>
		<div class="col-sm-6">
			<select name="expmonth">
				<cfloop from="1" to="12" index="expmonth">
				<option value="#NumberFormat(expmonth,00)#" <cfif Left(variables.expirationDate,2) eq expmonth>selected</cfif>>#NumberFormat(expmonth,00)#</option>
				</cfloop>
			</select>
			<select name="expyear">
				<cfloop from="#Year(Now())#" to="#Evaluate(Year(Now())+5)#" index="expyear">
				<option value="#expyear#" <cfif Right(variables.expirationDate,2) eq expyear>selected</cfif>>#expyear#</option>
				</cfloop>
			</select>
		</div>
	</div>
</div>
</cfoutput>