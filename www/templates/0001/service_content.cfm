	<cfoutput>
	<div class="col-md-8" id="page-content">
		<div class="block-header">
			<h2>
				<span class="title">Our team test</span>
			</h2>
		</div>
		<div class="content">
			<cfloop query="qProfessional">
				<cfset variables.FilePathC = variables.pathC & qProfessional.Professional_ID & ".jpg" />
				<div class="col-md-12">
					<cfif fileExists(variables.FilePathC)>
						<img class="img-about img-responsive" src="/images/staff/#qProfessional.Professional_ID#.jpg" border="0" />
					</cfif>
					<p class="text-muted">#qProfessional.First_Name# #qProfessional.Last_Name#</p>
					<hr />
					<p>#qProfessional.Bio#</p>
					<cfif len(qProfessional.Accredidations)>
						<div class="info info-danger">
							<h4>Accreditations</h4>
							<p>#qProfessional.Accredidations#</p>
						</div>
					</cfif>
				</div>
				<cfif qServices.recordcount>
					<div class="col-md-12">
						<h4>
							<span class="title">Services offered:</span>
						</h4>
						<cfloop query="qServices">
							
							<div class="col-md-12">
							  <div class="thumbnail">
								<!--- <img src="img/ladyphone.gif" class="img-responsive" alt="..."> --->
								<div class="visit"><a href="##"><i class="fa fa-question-circle"></i> More details...</a></div>
								<div class="caption">
								  <h4>#qServices.service_name#</h4>
					                <div class="rating">
									  <i class="fa fa-star"></i> 
									  <i class="fa fa-star"></i> 
									  <i class="fa fa-star"></i> 
									  <i class="fa fa-star"></i> 
									  <i class="fa fa-star"></i>
									</div> 
									<p>
									<div>$#qServices.price#</div>
									<!--- #qServices.service_description# ---></p>
									<!--- <p>Time: #qServices.service_time#</p> --->
								</div>
							  </div>
							</div>
							
						</cfloop>
					</div>
				</cfif>
				<!--- <div class="team">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
					
					<td width="37%" rowspan="3" valign="top">
					<cfif FileExists(variables.FilePathC)>
					<img src="/images/staff/#qProfessional.Professional_ID#.jpg" border="0" />
					</cfif>
					</td>
					<td width="63%" class="head">#qProfessional.First_Name# #qProfessional.Last_Name#</td>
					</tr>
					<tr>
					<td>
					<div>#qProfessional.Bio# </div>
					<div>#qProfessional.Services_Offered# </div>
					<div>#qProfessional.Accredidations#</div>
					</td>
					</tr>
					</table>
				</div><!-- team --> --->
			</cfloop>
		</div>  <!-- content -->
	</div>
	<div class="col-md-4">
		<div class="block-header">
			<h2>
			<span class="title">INFO</span>
			</h2>
		</div>
		<cfinclude template="#templatePath#info_sidebar.cfm">					
	</div>
</cfoutput>