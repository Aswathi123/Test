<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.cfm">
				<cfoutput>#qCompany.company_name#</cfoutput>
			</a>
		</div>
		<div class="collapse navbar-collapse">
			<cfinclude template="menu.cfm">
		</div>
	</div>
</div>