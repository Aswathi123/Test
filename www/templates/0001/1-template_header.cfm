<cfoutput>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="shortcut icon" href="img/favicon.ico">
	
	<title>#qCompany.company_name#</title>
	
	<!-- Bootstrap core CSS -->
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap-datetimepicker.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href='http://fonts.googleapis.com/css?family=Lato:100,300,400' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="#templatePath#css/app.css" />
	<link rel="stylesheet" type="text/css" href="#templatePath#css/appcustom.css" />
	<link href="fonts/font-awesome-4.0.3/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="jquery-ui-1.8.21/css/smoothness/jquery-ui-1.8.21.custom.css"/>
	<link rel="stylesheet" type="text/css" href="css/jquery.ui.datepicker.css"/>
	<link rel="stylesheet" type="text/css" href="#templatePath#css/gallery.css"/>
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="jquery-ui-1.8.21/ui/jquery-ui-1.8.21.custom.js"></script>
	<script src="js/jquery-migrate-1.2.1.min.js"></script> <!--Legacy jQuery support for quicksand plugin--> 
	<script src="js/bootstrap.min.js"></script>

	<!---  <script src="js/custom.js"></script>
	<script src="js/scrolltopcontrol.js"></script><!-- Scroll to top javascript --> --->	
	<script src="js/jquery.validate.js"></script>
</head>

<body>
	<cfinclude template="header.cfm">
	<input type="hidden" id="qCompanyId" value="#company_id#"/>
	<div class="wrapper">
		<div class="container">
			<div class="row">
</cfoutput>