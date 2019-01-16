<footer>
	<div class="container">
		<div class="row">
		
			<!--- <div class="col-sm-4">
				<div class="headline"><h3>Subscribe</h3></div>
				<div class="content">
					<p>Enter your e-mail below to subscribe to our free newsletter.<br />We promise not to bother you often!</p>
					<form class="form" role="form">
					<div class="row">
					<div class="col-sm-8">
					<div class="input-group">
					<label class="sr-only" for="subscribe-email">Email address</label>
					<input type="email" class="form-control" id="subscribe-email" placeholder="Enter email">
					<span class="input-group-btn">
					<button type="submit" class="btn btn-default">OK</button>
					</span>
					</div>
					</div>
					</div>
					</form>
				</div>
			</div> --->
			
			<div class="col-sm-6">
				<div class="headline"><h3>Contact us</h3></div>
				<div class="content" style="margin-left: 16px;">
					<cfinclude template="/customer_sites/include_contact_info.cfm">
					<div class="clearfix"></div>
				</div>
			</div>

			<div class="col-sm-6">
				<div class="headline"><h3>Go Social</h3></div>
				<div class="content social">
					<cfinclude template="/customer_sites/include_social_media.cfm">
					<cfoutput>
						<cfif variables.bolHasSocialMedia>
							<p>Follow us on</p>
							<div class="row">	
								<cfloop query="variables.qrySocialMedia">
									<cfif variables.qrySocialMedia.URL gt 0>
										<div class="col-xs-1">
											<a href="#variables.qrySocialMedia.WEB_SITE&Replace(variables.qrySocialMedia.URL,'http://','')#" target="_blank">
											<img src="/images/#variables.qrySocialMedia.Logo_File#" border="0" width="35" height="35" alt="#variables.qrySocialMedia.Site_Name#" /></a>
										</div>
									</cfif>
								</cfloop>
							</div>
						</cfif>
					</cfoutput>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
</footer>