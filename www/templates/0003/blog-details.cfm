<cfoutput>
	<cfset variables.staffImagePath = ExpandPath("/images/staff/")> 
	<cfset variables.staffImageFilepath = staffImagePath & "#qProfessional.Professional_ID#.jpg">
	<!-- Banner -->
	<cfinclude template="#templatePath#header.cfm">
	<cfset dates = #qGetBlogPost.CREATED_DATE#>	
	<cfset day = DateTimeFormat(dates, "dd")>						
	<cfset month = DateTimeFormat(dates, "MMM")>
	<cfset year = DateTimeFormat(dates, "yyyy")>
	<section class="blog-details-body-content-single">
		<div class="container blog-outer-container-layout">
			<div class="row blog-content-inner-row">
				<div class="row-fluid blog-inner-img">
					<div class="blog-inner-img-holder topPadding">						
						<div class="blog-date">
							<div class="mnth-yr">
								<p>#month#</p>
								<p>#year#</p>
							</div>
							<div class="day">
								<p>#day#</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid blog-text-content blogTitle">
					<h1 class="blog-title">#qGetBlogPost.TITLE#</h1>
					<p>#qGetBlogPost.DESCRIPTION#</p>					
				</div>
			</div>
		</div>
		<div class="row-fluid blog-quotes-section">
			<div class="container blog-outer-container-layout">
				<div class="blog-quotes-inner">
					<div class="blog-thumbnail">
						<cfif fileExists(variables.staffImageFilepath)>
							<img src="/images/staff/#qProfessional.Professional_ID#.jpg" alt="">
						</cfif>
					</div>
					<h2 class="bloger-name">#qGetBlogPost.First_Name# #qGetBlogPost.Last_Name#</h2>
					<p>#qProfessional.Bio#</p>
				</div>
			</div>
		</div>
	</section>
</cfoutput>
