<cfoutput>
	<cfinclude template="header.cfm">
	<cfset variables.webpathC = "/images/company/" />
	<cfset variables.pathC = expandPath(variables.webpathC) />
	<cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
		
	<div class="topContent">
		<div class="menu" style="background-color: white;border: 1px solid ##94866B; min-height: 350px;">
			<cfif FileExists(variables.FilePathC)>
				<img src="/images/company/#qCompany.Company_ID#.jpg" align="left" vspace="5" hspace="5"> 
			</cfif> 
			#qCompany.Company_Description# 
			
		</div>
		<!--- <div class="note" align="justify">	
			<cfif FileExists(variables.FilePathC)>
				<img src="/images/company/#qCompany.Company_ID#.jpg" align="left" vspace="5" hspace="5"> 
			</cfif> 
			#qCompany.Company_Description# 
		</div>  --->
	</div>  <!-- topContent -->
	<div class="midContent">
		<cfset variables.info_bar_float="left">
		<cfinclude template="/templates/0001/info_bar.cfm">
				
			<!--- 		
			<div class="section2">
			<div class="heading">Our Services</div>
			<div class="services">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%"><img src="/templates/0001/images/service1.jpg" class="format" /></td>
					    <td>SKIN CARE</td>
					 </tr>
				</table>
			</div>
			<div class="services">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				 	<tr>
				    	<td width="50%"><img src="/templates/0001/images/service2.jpg" class="format" /></td>
				    	<td>MASSAGE</td>
				  	</tr>
				</table>
			</div>
			<div class="services">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  		<tr>
			    	<td width="50%"><img src="/templates/0001/images/service3.jpg" class="format" /></td>
			    	<td>BODY REST</td>
			  	</tr>
				</table>
			</div>
			<div class="more"><a href="##" class="button">More</a></div>
		</div>  <!-- section2 --> 
		--->
		<div class="section3">
			<div class="heading">Locate Us</div>
				<div>
					<iframe width="550" height="400" frameborder="0" scrolling="no" 
							marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;output=embed"></iframe><br /><small><a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;z=14&amp;ll=30.524347,-97.863141" style="color:##0000FF;text-align:left" target="_blank">View Larger Map</a></small> 
				</div>
			</div> <!-- heading -->
		</div> <!-- section3 -->
	<cfinclude template="footer.cfm">
</cfoutput>