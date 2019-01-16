<cfinclude template="header2.cfm" />

<script type="text/javascript" src="/jscolor/jscolor.js"></script>

<cfparam name="variables.company_id" default="#session.company_id#">
<cfinvoke component="themes" method="getFonts" returnvariable="qFonts"> 
</cfinvoke>

<cfparam name="variables.company_id" default="#session.company_id#">
<cfinvoke component="themes" method="getCompany_Themes" returnvariable="qTheme"> 
</cfinvoke>

<cfoutput>
<cfform action="update_theme.cfm" method="post">
	 
    Background_Image <input type="text" name="Background_Image" value="#qTheme.Background_Image#" class="color"><br>
    Background_Color <input type="text" name="Background_Color" value="#qTheme.Background_Color#" class="color"><br>
    Text_Color <input type="text" name="Text_Color" value="#qTheme.Text_Color#" class="color"><br>
    Link_Color <input type="text" name="Link_Color" value="#qTheme.Link_Color#" class="color"><br>
    Link_Visited <input type="text" name="Link_Visited" value="#qTheme.Link_Visited#" class="color"><br>
    Text_Font 
	<select name="Text_Font_ID">
	<cfloop query="qFonts">
		<option value="#qFonts.Font_ID#" <cfif qTheme.Text_Font_ID eq qFonts.Font_ID>selected</cfif>>#Font#
	</cfloop>
	</select> <br>
    Menu_Font
	<select name="Menu_Font_ID">
	<cfloop query="qFonts">
		<option value="#qFonts.Font_ID#" <cfif qTheme.Menu_Font_ID eq qFonts.Font_ID>selected</cfif>>#Font#
	</cfloop>
	</select>  <br>
    Menu_Color <input type="text" name="Menu_Color" value="#qTheme.Menu_Color#" class="color"><br>
    Header_Font 
	<select name="Header_Font_ID">
	<cfloop query="qFonts">
		<option value="#qFonts.Font_ID#" <cfif qTheme.Header_Font_ID eq qFonts.Font_ID>selected</cfif>>#Font#
	</cfloop>
	</select> <br>
    Header_Color <input type="text" name="Header_Color" value="#qTheme.Header_Color#" class="color"><br>
	<input type="hidden" name="Theme_ID" value="#qTheme.Theme_ID#">
	<input type="hidden" name="Company_ID" value="#variables.Company_ID#">
	<input type="submit" value="Submit">
</cfform>
</cfoutput>