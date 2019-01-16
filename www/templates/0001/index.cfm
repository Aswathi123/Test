<cfparam name="templatePath" type="string" default="/templates/0001/">
<cfoutput>
	<cfinclude template="#templatePath#template_header.cfm">
		<div class="col-md-8" id="page-content">
			<div class="block-header">
				<h2>
					<span class="title">Welcome To #qCompany.Company_Name#</span>
				</h2>
			</div>					
			<cfset variables.webpathC = "/images/company/" />
			<cfset variables.pathC = expandPath(variables.webpathC) />
			<cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
			<cfif FileExists(variables.FilePathC)>
				<IMG class="img-about img-responsive" src="/images/company/#qCompany.Company_ID#.jpg" align="left" vspace="5" hspace="5"> 
			</cfif> 
			<!--- <img src="templates/0001/images/bg_pic6.jpg" alt="About" class="img-about img-responsive"> --->
			<!--- <img src="img/about.jpg" class="img-about img-responsive" alt="About"> --->
			<p>
			#qCompany.Company_Description# 
			</p>
			<p>
				<iframe height="200" width="100%" frameborder="0" scrolling="no" 
					marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;output=embed"></iframe><br /><small><a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;z=14&amp;ll=30.524347,-97.863141" style="color:##0000FF;text-align:left" target="_blank">View Larger Map</a></small> 
			</p>
		</div>

		<div class="col-md-4">
			<div class="block-header">
				<h2>
				<span class="title">INFO</span>
				</h2>
			</div>
			<h4>Hours of Operation</h4>
			<!--- <cfinclude template="/templates/0001/info_bar.cfm"> --->
			<cfinclude template="/customer_sites/include_hours.cfm">
			<h4>Payment methods</h4>
			<cfinclude template="/customer_sites/include_payment_methods.cfm">
			<cfloop query="getPaymentMethods">
				<img src="/images/#getPaymentMethods.Logo_File#" Alt="#getPaymentMethods.Payment_Method#" width="32" style="padding:3px;"><!--- &nbsp;&nbsp;#getPaymentMethods.Payment_Method# ---> 
			</cfloop>
			<cfif Len(qLocation.Cancellation_Policy)>
			 <h4>Cancellation Policy</h4>
			<cfinclude template="/customer_sites/include_cancellation_policy.cfm">
			</cfif>
			
			<cfif Len(qLocation.Parking_Fees)>
			<h4>Parking Fees</h4>
			<cfinclude template="/customer_sites/include_parking_fees.cfm">
			</cfif> <!------>
			
			
		</div>
		<!--- 
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-header">
						<h2>
							<span class="title">Welcome Message</span>
						</h2>
					</div>
					<img src="img/about.jpg" class="img-about img-responsive" alt="About">
					<p>
					Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
					Nullam id ipsum varius, tincidunt odio nec, placerat enim. 
					Sed sit amet auctor augue, nec dignissim ligula. 
					Nullam euismod quis odio eu commodo. Duis vitae dignissim eros.
					<br /><br />
					Nunc in neque nec arcu vulputate ullamcorper. Ut id orci ac arcu consectetur fringilla. 
					Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. 
					Duis hendrerit enim id arcu lacinia, id commodo ante semper. 
					Sed vel ante nec nisi vestibulum congue. Pellentesque non lacus in tortor rutrum tristique. 
					</p>
					<div class="info info-danger">
						<h4>Important info</h4>
						<p>Nunc in neque nec arcu vulputate ullamcorper. Ut id orci ac arcu consectetur fringilla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</p>
					</div>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
 		--->
	<cfinclude template="#templatePath#template_footer.cfm">
</cfoutput> 