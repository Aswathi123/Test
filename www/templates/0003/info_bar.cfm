<!-- Payment -->
<cfoutput>
	<section class="payment-section">
		<div class="container outer-container-layout payment-container">
			<div class="row">
				<div class="payment-inner-child payment-img-left">
					<img src="<cfoutput>#templatePath#img/chair.png</cfoutput>" class="img-fluid" alt="">
				</div>
				<div class="payment-inner-child payment-method-right">
					<h2>Payment methods</h2>							
					<cfinclude template="/customer_sites/include_payment_methods.cfm" >
					<ul class="payment-ul">
						<cfloop query="getPaymentMethods">
							<li>
								<img src="images/#getPaymentMethods.Logo_File#" alt="getPaymentMethods.PAYMENT_METHOD">
							</li>
						</cfloop>
						<div id="infoDiv"></div>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!-- operations -->
	<section class="welcome-section operations-section">
		<div class="container outer-container-layout welcome-container">
			<div class="row">
				<div class="col-lg-5 col-md-12 col-12 welcome-text-content">
					<h2>Hours of Operation</h2>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
				</div>
				<div class="col-lg-7 col-md-12 col-12 timing-table-content">
					<div class="row">
						<div class="col-md-6 col-sm-12 col-12">
							<table class="timing-table">
								<tbody>
									<tr class="header">
										<td>Sunday</td>
										<td>: #qLocation.SUNDAY_HOURS#</td>
									</tr>
									<tr>
										<td>Monday</td>
										<td>: #qLocation.MONDAY_HOURS#</td>
									</tr>
									<tr>
										<td>Tuesday</td>
										<td>: #qLocation.TUESDAY_HOURS#</td>
									</tr>
									<tr class="bottom">
										<td>Wednesday</td>
										<td>: #qLocation.WEDNESDAY_HOURS#</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-md-6 col-sm-12 col-12">
							<table class="timing-table">
								<tbody>
									<tr>
										<td>Thursday</td>
										<td>: #qLocation.THURSDAY_HOURS#</td>
									</tr>
									<tr>
										<td>Friday</td>
										<td>: #qLocation.FRIDAY_HOURS#</td>
									</tr>
									<tr>
										<td>Saturday</td>
										<td>: #qLocation.SATURDAY_HOURS#</td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</cfoutput>