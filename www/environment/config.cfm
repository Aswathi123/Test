<cfparam name="attributes.globalvars" default="#StructNew()#" type="struct">

<cfset globalvars.wwwroot = "http://"&cgi.server_name&":"&cgi.server_port&"/" />
<cfset globalvars.assets = globalvars.wwwroot & "assets" />
<cfset globalvars.css = globalvars.assets & "/css/" />
<cfset globalvars.js = globalvars.assets & "/js/" />

<cfset caller.attributes.globalvars = globalvars />