<cfparam name="variables.page_title" default="">
<cfoutput>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>#variables.page_title# - SalonWorks Employee</title>

		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!-- basic styles -->

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
		<link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.full.min.css" />
		<!-- page specific plugin styles -->
		
		<!-- fonts -->

		<link rel="stylesheet" href="assets/css/ace-fonts.css" />

		<!-- ace styles -->

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- summernote editor -->
		<link rel="stylesheet" href="assets/css/summernote.css" />
		<link rel="stylesheet" href="assets/css/summernote-bs3.css" />

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->
		<script src="assets/js/jquery-1.10.2.min.js"></script>
		<script src="assets/js/jquery.mask.min.js" type="text/javascript"></script>
		<script src="http://code.jquery.com/jquery-migrate-1.1.1.js"></script>

		<script src="assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
		
		
		<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
		<script type="text/javascript" src="assets/js/jquery.validate.additional-methods.min.js"></script> 
		<!--- <link rel="stylesheet" href="/css/new_style.cfm?company_id=#Session.Location_ID#" type="text/css" media="screen,projection" />  --->
	    <style type="text/css">
		##navbar {height:45px;}
		##nav-cat{ font-size:12px;}
		body {font-size:12px;}
		textarea.error, input.error {
			border: 1px solid ##FF0000;
		}
		##professional_form label.error {
			color: ##FF0000;
			margin-left: 10px;
			width: auto;
			display: inline;	
		}
		.address, .city  {
			text-transform:capitalize;
		}
		</style>
	
		<script>
		isAllowedNavigationKeys = function(code) {
			//backspace 	delete 			tab 		escape  	 enter			l-arrow			u-arrow		r-arrow		d-arrow
			if (code == 46 || code == 8 || code == 9 || code == 27 || code == 13 || code == 37 || code == 38 || code == 39 || code == 40) {
				return true;
			} else {
				return false;
			}
		}
		
		
		keydownAcceptFilterInteger = function(e) {
			e = e || event;
			var code = e.which || event.keyCode;
			//alert(code);
			if (isAllowedNavigationKeys(code)) {
				//Allow Navigation Keys
			} else if (e.shiftKey || (code < 48 || code > 57 ) && (code < 96 || code > 105 )) {
				//Allow only numbers from keyboard and pad
		
				(e.preventDefault) ? e.preventDefault() : e.returnValue = false;
				return false;
			}
		}
		</script>
   
	</head>

	<body>
		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="##" class="navbar-brand">
						<small>
							<i class="icon-leaf"></i>
							SalonWorks Employee Interface
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header --> 
				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="light-blue">
							<a data-toggle="dropdown" href="##" class="dropdown-toggle">
							<!--- Commented out until photo available --->
								<!--- <img class="nav-user-photo" src="assets/avatars/user.jpg" alt="#session.first_name#'s Photo" /> --->
								<span class="user-info">
									<small>Welcome, #session.first_name#</small>
									
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<!--- <li>
									<a href="##">
										<i class="icon-cog"></i>
										Settings
									</a>
								</li> --->

								<li>
									<a href="professionals_form.cfm">
										<i class="icon-user"></i>
										Profile
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="logout.cfm">
										<i class="icon-off"></i>
										Logout
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div>
			</div><!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="##">
					<span class="menu-text"></span>
				</a>

				<div class="sidebar" id="sidebar">
					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
					</script>

					<div class="sidebar-shortcuts" id="sidebar-shortcuts"> 
						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div><!-- ##sidebar-shortcuts -->

					<ul class="nav nav-list">
						<li class="active">
							<a href="/">
								<i class="icon-dashboard"></i>
								<span class="menu-text"> Dashboard </span>
							</a>
						</li> 

						<li>
							<a href="##" class="dropdown-toggle" id="profileSection">
								<i class="icon-desktop"></i>
								<span class="menu-text"> Profile </span>
							</a>
						</li>
						
						<li>
							<a href="company_report.cfm" class="dropdown-toggle" id="companyReportSection">
								<i class="icon-group"></i>
								<span class="menu-text"> Company Report </span>
							</a>
						</li>
					</ul><!-- /.nav-list -->

					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="##">Home</a>
							</li>
							<li class="active">#variables.page_title#</li>
							
						</ul><!-- .breadcrumb -->
 						
						<ul class="breadcrumb pull-right">
							<li class="active pull-right">
								<a href="##" class="admin-support">
									<span class="label label-warning arrowed-in"> <i class="icon-envelope"></i>
									Support
									</span>
								</a>
							</li>
						</ul>
	
					</div>
					
					<div class="page-content" id="page-content">
						<div class="page-header">
							<h1>#variables.page_title#</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

							<!--- 	<div class="alert alert-block alert-success">
									<button type="button" class="close" data-dismiss="alert">
										<i class="icon-remove"></i>
									</button>

									<i class="icon-ok green"></i>
										Notices go here
								</div> --->
</cfoutput>