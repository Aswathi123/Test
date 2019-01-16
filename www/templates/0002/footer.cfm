<cfoutput>
		<div class="footer">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  	<tr>
			    	<td width="40%"><img src="/templates/0001/images/footer_pic.jpg" border="0" /></td>
			    	<td width="30%">
						<div>#qCompany.Company_Name#</div>
						<div>#qLocation.LOCATION_ADDRESS#</div>
						<div>#qLocation.LOCATION_ADDRESS2#</div>
						<div>#qLocation.LOCATION_CITY#, #qLocation.LOCATION_STATE# #qLocation.LOCATION_POSTAL#</div></div></td>
			    	<td width="30%">
						<div>Voice: #qLocation.LOCATION_PHONE#</div>
						<div>Fax: #qLocation.LOCATION_FAX#</div>
						<!--- 
						<div> &nbsp;</div>
						<div>Email: consultant@spasalon.salonworks.com</div> 
						--->
					</td>
			  	</tr>
			</table> 		
		</div> <!-- footer -->
	</div>  <!-- midContent -->
	<div class="initials">  Powered by SalonWorks.com<!---  | <a href="##">PRIVATE POLICY</a> ---></div>
	</div> <!-- wrap -->
</center>
<!--- <SCRIPT src="/templates/0001/images/wowslider.js" type="text/javascript"></SCRIPT>
<SCRIPT src="/templates/0001/images/script.js" type="text/javascript"></SCRIPT> --->
<!--- <cfdump var="#qLocation#"> --->
</body>
</html>
</cfoutput>