<cfoutput>
	<cfinclude template="/customer_sites/include_blog.cfm">
	<cfif isDefined("url.blogId")>
		<cfinclude template="#templatePath#blog-details.cfm">
	<cfelse>
		<cfinclude template="#templatePath#header.cfm">
		<cfif qGetBlogPost.recordcount gt 0>							
			<section class="blog-body-content">
				<div class="container outer-container-layout">
					<div class="row blog-title" id="blogDiv">
						<div class="col-md-8 col-12 blog-layout-left">
							<h1>BLOG</h1>					
						</div>	
					</div>
					<cfset variables.records_per_page = 6>
					<cfset variables.total_pages = ceiling(qGetBlogPost.recordcount / records_per_page)>
					<cfset variables.page_links_shown = variables.total_pages>					
					<cfset variables.start_record = url.page * variables.records_per_page - variables.records_per_page + 1>
					<cfset variables.endrecord=variables.start_record+variables.records_per_page-1>
					<div class="row blog-details-section">
						<div class="col-lg-8 col-md-6 col-12 blog-layout-left">
							<div class="row">							
								<cfloop query="qGetBlogPost" startrow="#variables.start_record#" endrow="#variables.endrecord#">
									<cfset variables.dates = #CREATED_DATE#>	
									<cfset variables.day = DateTimeFormat(dates, "dd")>						
									<cfset variables.month = DateTimeFormat(dates, "MMM")>
									<cfset variables.year = DateTimeFormat(dates, "yyyy")>					
									<div class="col-lg-6 col-md-12 col-sm-6 col-12 blog-child-block">
										<div class="blog-details-holder">
											<div class="blog-text blog-img">
												<div class="blog-date">
													<div class="mnth-yr">
														<p>#variables.month#</p>
														<p>#variables.year#</p>
													</div>
													<div class="day">
														<p>#variables.day#</p>
													</div>
												</div>
												<div class="blog-sub-title leftAlign">
													<h3>#TITLE#</h3>
													<p class="name">By #First_Name# #Last_Name#</p>
												</div>
												<div class="blog-p leftAlign">
													<cfset variables.DescriptionHtml = #DESCRIPTION#>										
													<cfset variables.DescriptionString = REReplace(variables.DescriptionHtml,"<[^>]*>","","All")>
													<cfset variables.ShortDescription = Mid(variables.DescriptionString,1,101)>
													<p>#variables.ShortDescription#...</p>
													<p><a href="blog.cfm?blogId=#BLOG_ID###blogDiv">Read More</a></p>
												</div>
											</div>
										</div>
									</div>											
								</cfloop>
							</div>				
							<!-- Pagination -->
							<cfparam name="start_page" default="1">
							<cfparam name="show_pages" default="#min(page_links_shown,total_pages)#">
							<cfif url.page + int(show_pages / 2) - 1 GTE total_pages>
							<cfset start_page = total_pages - show_pages + 1>
							<cfelseif url.page + 1 GT show_pages>
							<cfset start_page = url.page - int(show_pages / 2)>
							</cfif>
							<cfset end_page = start_page + show_pages - 1>									

							<div class="row blog-pagination">
								<nav aria-label="Page navigation">
									<ul class="pagination">
										<li class="page-item">								
											<cfif url.page EQ 1>
												<a class="contoller-btn page-link" href="blog.cfm?page=1" aria-label="Previous">
													<i class="fa fa-angle-left" aria-hidden="true"></i>
													<span class="sr-only">Previous</span>
												</a>
												<cfelse>
												<a class="contoller-btn page-link" href="blog.cfm?page=#url.page-1#" aria-label="Previous">
													<i class="fa fa-angle-left" aria-hidden="true"></i>											
													<span class="sr-only">Previous</span>
												</a>
											</cfif>								
										</li>

										<cfloop from="#start_page#" to="#end_page#" index="i">
											<cfif url.page EQ i>
												<li class="page-item"><a class="page-link active" href="##">#i#</a></li>
												<cfelse>
												<li class="page-item"><a class="page-link active" href="blog.cfm?page=#i#">#i#</a></li>
											</cfif>
										</cfloop>
										
										<li class="page-item">									
											<cfif url.page * variables.records_per_page LT qGetBlogPost.recordcount>
												<a class="contoller-btn page-link" href="blog.cfm?page=#url.page+1#" aria-label="Next">
													<i class="fa fa-angle-right" aria-hidden="true"></i>
													<span class="sr-only">Next</span>
												</a>
												<cfelse>
												<a class="contoller-btn page-link" href="##" aria-label="Next">
												<i class="fa fa-angle-right" aria-hidden="true"></i>
													<span class="sr-only">Next</span>
												</a>
											</cfif>									
										</li>
									</ul>
								</nav>
							</div>
						</div>					
						<aside class="col-lg-4 col-md-6 col-12 blog-sidebar-right">
							<div class="row blog-sidebar-inner-layout">
								<div class="sidebar-blocks">
									<h3 class="blog-sidebar-title">Recent Blogs</h3>
									<ul class="sidebar-date-ul">
										<cfloop query="qGetBlogPost">
											<cfset dates = #CREATED_DATE#>
											<cfset day = DateTimeFormat(dates, "dd")>
											<cfset month = DateTimeFormat(dates, "MMM")>
											<cfset year = DateTimeFormat(dates, "yyyy")>							
											<li>
												<div class="sidebar-blog-date">
													<h4>#day#</h4>
													<p>#month#</p>
													<p>#year#</p>										
												</div>
												<div class="sidebar-blog-text">
													<p>#TITLE#</p>
												</div>
											</li>
										</cfloop>
									</ul>
								</div>
							</div>
						</aside>
					</div>
				</div>
			</section>
		<cfelse>
			No blogs available
		</cfif>
	</cfif>
</cfoutput>	