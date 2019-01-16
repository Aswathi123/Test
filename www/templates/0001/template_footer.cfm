<cfoutput>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</div><!-- /.wrapper -->
		<cfinclude template="footer.cfm">
		<cfinclude template="/customer_sites/login_dialog.cfm">
		<cfinclude template="/customer_sites/register_dialog.cfm">		
		<div class="legal">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<p class="pull-right">&copy; Powered by SalonWorks.com, #year(now())#.</p>
					</div>
				</div>
			</div>
		</div>			
	<script src="#templatePath#js/app.js"></script>
	</body>
	</html>
</cfoutput>