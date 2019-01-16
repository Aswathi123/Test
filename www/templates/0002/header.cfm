<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<cfparam name="variables.PageTitle" default="">
<cfoutput>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META 
content="IE=10.000" http-equiv="X-UA-Compatible">

<title>#qCompany.Company_Name# <cfif Len(variables.PageTitle)> - #variables.PageTitle#</cfif></title>
<link href="/templates/0001/style.css" rel="stylesheet" type="text/css" />
<link href="/templates/0001/slider.css" rel="stylesheet" type="text/css" /><!--- 
<link href="/templates/0001/inner.css" rel="stylesheet" type="text/css" /> --->

</head>

<center>
	<div id="wrap">
		<div class="header">#qCompany.Company_Name#</div>
		<cfinclude template="menu.cfm">
</cfoutput>