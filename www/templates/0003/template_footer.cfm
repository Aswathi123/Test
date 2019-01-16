<Footer>
	<div class="container outer-container-layout footer-container">
		<div class="row footer-inner-row">
			<cfoutput>
				<div class="col-md-6 col-sm-8 col-12 footer-child">
					<p class="pull-right">&copy; Powered by SalonWorks.com, #year(now())#.</p>
				</div>
				<cfinclude template="/customer_sites/include_social_media.cfm" >			
				<cfif variables.bolHasSocialMedia>
					<div class="col-md-6 col-sm-4 col-12 footer-child">
						<ul class="footer-social-icons">
							<cfloop query="variables.QRYSOCIALMEDIA">
								<li><a href="#variables.QRYSOCIALMEDIA.WEB_SITE##variables.QRYSOCIALMEDIA.URL#"><img src="/images/#variables.QRYSOCIALMEDIA.LOGO_FILE#" border="0" width="35" height="35" alt="#variables.QRYSOCIALMEDIA.SITE_NAME#" /></a></li>
							</cfloop>						
						</ul>
					</div>				
				</cfif>
			</cfoutput>	
		</div>
	</div>
</Footer>
<!-- Scripts -->
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script> -->
		<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script> -->
		<script src="<cfoutput>#templatePath#js/vendor/owl.carousel.min.js</cfoutput>"></script>
		<script src="<cfoutput>#templatePath#js/vendor/owl.carousel.js</cfoutput>"></script>
		<script src="<cfoutput>#templatePath#js/script.js</cfoutput>"></script>
		<script src="<cfoutput>#templatePath#js/app.js</cfoutput>"></script>
