<cfoutput>
	<cfinclude template="header.cfm">
		<cfset variables.webpathC = "/images/company/" />
		<cfset variables.pathC = expandPath(variables.webpathC) />
		<cfset variables.FilePathC = variables.pathC & variables.company_id & ".jpg" />
		
	<div class="topContent">			
		<cfif FileExists(variables.FilePathC)>
		<div class="leftbar">
			<DIV<!---  id="wowslider-container1" --->>
				<DIV<!---  class="ws_images" --->>
					<UL>
					  	<LI>						
							<IMG src="/images/company/#qCompany.Company_ID#.jpg">
						</LI>
					</UL>
				</DIV> <!-- ws_images -->
			<!--- 	<DIV class="ws_thumbs">
					<DIV>
						<A href="##"><IMG src="/templates/0001/images/thumb1.jpg"></A> 
						<A href="##"><IMG src="/templates/0001/images/thumb2.jpg"></A> 
						<A href="##"><IMG src="/templates/0001/images/thumb3.jpg"></A> 
						<A href="##"><IMG src="/templates/0001/images/thumb4.jpg"></A> 
						<A href="##"><IMG src="/templates/0001/images/thumb5.jpg"></A>
						<A href="##"><IMG src="/templates/0001/images/thumb2.jpg"></A> 
						<A href="##"><IMG src="/templates/0001/images/thumb3.jpg"></A>		
					</DIV>
				</div> <!-- ws_thumbs -->	 --->
			</div><!-- wowslider-container1 -->
		</div> <!-- leftbar -->
			</cfif>
		<div class="rightbar" style="width:990px">
			<div class="head">Welcome!</div>
			<div class="note">
				#qCompany.Company_Description# 
			</div>
	<!--- 		
			<div class="tab"><a href="##" class="button">More</a></div>
			<div class="certifAdv">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td width="10%" align="left"><img src="images/gift_icon.png" border="0" /></td>
				    <td align="right"><div>Gifts for all our membeship
				holding clients</div>
				<div><a href="##">Learn more</a></div>
				</td>
				  </tr>
				</table>		
			</div> 
			--->
		</div> <!-- rightbar -->
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
					<iframe width="550" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#+#qLocation.LOCATION_POSTAL#&amp;aq=&amp;sll=31.168934,-100.076842&amp;hnear=#Replace(qLocation.LOCATION_ADDRESS," ","+","all")#,+#Replace(qLocation.LOCATION_CITY," ","+","all")#,+#qLocation.LOCATION_STATE#+#qLocation.LOCATION_POSTAL#&amp;output=embed"></iframe><br /><small><a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=1810+Connors+Cove+78613&amp;aq=&amp;sll=31.168934,-100.076842&amp;sspn=14.806536,19.753418&amp;t=h&amp;ie=UTF8&amp;hq=&amp;hnear=1810+Connors+Cove,+Cedar+Park,+Texas+78613&amp;z=14&amp;ll=30.524347,-97.863141" style="color:##0000FF;text-align:left">View Larger Map</a></small> 
				</div>
			</div> <!-- heading -->
		</div> <!-- section3 -->
	<cfinclude template="footer.cfm">
</cfoutput>