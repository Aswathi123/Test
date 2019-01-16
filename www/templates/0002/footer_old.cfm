</div>
<cfif variables.Company_ID gt 0>
				<div id="sidebar">
					<div class="widget clearfloat">
						<h3 class="widgettitle">Hours of Operation</h3>	
						<cfoutput>
						<table>
						<cfloop from="1" to="7" index="d">										
						<tr <cfif d mod 2 eq 1>bgcolor="##CCCCCC"</cfif>>
							<td><strong>#DayofWeekAsString(d)#</strong></td>
							<td>#Evaluate('qLocation.#DayofWeekAsString(d)#_Hours')#</td></tr>
						</cfloop>
						</table>
						</cfoutput>
					</div>
					
					<cfquery name="getPaymentMethods" datasource="#request.dsn#">
						SELECT Payment_Method_ID, Payment_Method 
						FROM Payment_Methods WHERE Payment_Method_ID IN (<cfif qLocation.PAYMENT_METHODS_LIST gt ''>#qLocation.PAYMENT_METHODS_LIST#<cfelse>0</cfif>)
					</cfquery>
					<div class="widget clearfloat">
						<h3 class="widgettitle">Payment Methods</h3>
						<ul>
						<cfoutput query="getPaymentMethods">
							<li>#Payment_Method#</li>
						</cfoutput>
						</ul>
					</div>
					
					<div class="widget clearfloat">
						<h3 class="widgettitle">Cancellation Policy</h3>
						<cfoutput>#qLocation.Cancellation_Policy#</cfoutput>
					</div>
					
					<div class="widget clearfloat">
						<h3 class="widgettitle">Notes</h3>
						<cfoutput>
						<strong>Parking Fees</strong> #qLocation.Parking_Fees#
						
						</cfoutput>
					</div>
				</div><!--END SIDEBAR-->
				</cfif>
			</div><!--END WRAPPER-->
			
			<div id="footer" class="clearfloat">
			<div id="copyright"><cfoutput>#Year(Now())# #qCompany.Company_Name#</cfoutput>
			</div>
			
			<div id="rss">
				<!--- <a href="">Contact Us</a> ---> 
				<cfoutput>#qLocation.Location_Fax#</cfoutput>
			</div>
			</div><!--END FOOTER-->
		</div><!--END PAGE-->
		
<cfdump var="#qLocation#">
	<!--- 	<cfdump var="#qCompany#">
<cfdump var="#qProfessional#">  --->
	</body>
</html>
