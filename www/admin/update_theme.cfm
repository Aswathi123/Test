
<!--- <cfparam name="variables.company_id" default="#session.company_id#"> --->
<cfinvoke component="themes" method="UpdateTheme"> 
	<cfinvokeargument name="Company_ID" value="#form.Company_ID#">
	<cfinvokeargument name="Theme_ID" value="#form.Theme_ID#"> 
	<cfinvokeargument name="Background_Image" value="#form.Background_Image#"> 
	<cfinvokeargument name="Background_Color" value="#form.Background_Color#"> 
	<cfinvokeargument name="Text_Color" value="#form.Text_Color#"> 
	<cfinvokeargument name="Link_Color" value="#form.Link_Color#"> 
	<cfinvokeargument name="Link_Visited" value="#form.Link_Visited#"> 
	<cfinvokeargument name="Text_Font_ID" value="#form.Text_Font_ID#"> 
	<cfinvokeargument name="Menu_Font_ID" value="#form.Menu_Font_ID#"> 
	<cfinvokeargument name="Menu_Color" value="#form.Menu_Color#"> 
	<cfinvokeargument name="Header_Font_ID" value="#form.Header_Font_ID#"> 
	<cfinvokeargument name="Header_Color" value="#form.Header_Color#"> 
</cfinvoke>