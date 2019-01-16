<cfquery name="getTemplates" datasource="#request.dsn#">
	SELECT Template_ID,Template_Name
	FROM Templates
</cfquery>

<cfinclude template="header.cfm">

<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_blogs td {
		vertical-align:middle;
	}
	#table_blogs td img {
		width:250px !important;
	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
</style>

<cfoutput>
<div class="row">
	<div class="table-responsive col-sm-12">
		<table id="table_blogs" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					
					<th class="col-sm-2">Template</th>
					
					<th class="col-sm-2">Preview</th>
					<th class="col-sm-1">Choose Template</th>
				</tr>
			</thead>
			<tbody>
				<cfif getTemplates.recordcount>
					<cfloop query="getTemplates">
						<tr>
							<td>#getTemplates.Template_Name#</td>
							<td><button id="#getTemplates.Template_ID#" onclick="openWindow(#getTemplates.Template_ID#)">Preview</button>
							</td>
							<td><input type="radio" name="template" id="template_#getTemplates.Template_ID#" value="#getTemplates.Template_ID#" class="template_radio"<cfif qCompany.Template_ID eq getTemplates.Template_ID>checked="checked"</cfif>></td>
						</tr>
					</cfloop>
					<tr>
						<td colspan="4"><button type="button" name="savetemplate"  id="savetemplate" style="float:right;" class="btn btn-info btn-sm">Save</button></td>
					</tr>
				<cfelse>
					<tr>
						<td align="center" colspan="4">No Templates Found</td>
					</tr>
				</cfif>
			</tbody>
		</table>
	</div>
</div>	


<!--- <iframe src="" height="500" width="1000" style="display:none" id="previewiframe"></iframe> --->
<div id="info" style="display: none;" class="alert alert-block alert-success">
 Template Selected and Saved Successfully !
</div>	
</cfoutput>
<cfinclude template="footer.cfm">
<script type="text/javascript">
	$('#savetemplate').click(function() {

		var Template_ID = $("input[name='template']:checked").val();
		
		$.ajax({
		type: "post",
		url: "company.cfc?method=updateCompanyTemplate",
		data: { 
				Template_ID: Template_ID,
				Company_ID:<cfoutput>#qCompany.Company_ID#</cfoutput>
			},

		success: function(data){
			
			$("#info").show();
			$("#info").delay(5000).fadeOut();
			
		}
		});
		
	});
	function openWindow(template_id){
		window.open("http://demo.salonlocal.com?template_id="+template_id);
		
	}
	
</script>

<!--- <cfquery name="getTemplates" datasource="#request.dsn#">
	SELECT Template_ID,Template_Name
	FROM Templates
</cfquery>

<cfinclude template="header.cfm">

<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_blogs td {
		vertical-align:middle;
	}
	#table_blogs td img {
		width:250px !important;
	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
</style>

<cfoutput>
<div class="row">
	<div class="table-responsive col-sm-12">
		<table id="table_blogs" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					
					<th class="col-sm-2">Template</th>
					
					<th class="col-sm-2">Preview</th>
					<th class="col-sm-1">Choose Template</th>
				</tr>
			</thead>
			<tbody>
				<cfif getTemplates.recordcount>
					<cfloop query="getTemplates">
						<tr>
							<td>#getTemplates.Template_Name#</td>
							<td><button id="#getTemplates.Template_ID#" class="preview">Preview</button></td>
							<td><input type="radio" name="template" id="template_#getTemplates.Template_ID#" value="#getTemplates.Template_ID#" class="template_radio"<cfif qCompany.Template_ID eq getTemplates.Template_ID>checked="checked"</cfif>></td>
						</tr>
					</cfloop>
					<tr>
						<td colspan="4"><button type="button" name="savetemplate"  id="savetemplate" style="float:right;" class="btn btn-info btn-sm">Save</button></td>
					</tr>
				<cfelse>
					<tr>
						<td align="center" colspan="4">No Templates Found</td>
					</tr>
				</cfif>
			</tbody>
		</table>
	</div>
</div>	


<iframe src="" height="500" width="1000" style="display:none" id="previewiframe"></iframe>
<div id="info" style="display: none;">
 Template Selected Successfully !
</div>	
</cfoutput>
<cfinclude template="footer.cfm">
<script type="text/javascript">
	$('#savetemplate').click(function() {

		var Template_ID = $("input[name='template']:checked").val();
		alert(Template_ID);
		$.ajax({
		type: "post",
		url: "company.cfc?method=updateCompanyTemplate",
		data: { 
				Template_ID: Template_ID,
				Company_ID:<cfoutput>#qCompany.Company_ID#</cfoutput>
			},

		success: function(data){
			
			$("#info").show();
			$("#info").delay(5000).fadeOut();
			
		}
		});
		
	});
	$(".preview").click(function(){
		var template_id=$(this).attr('id');
		
		$('#previewiframe').attr("src","http://demo.salonlocal.com?template_id="+template_id);
		$('#previewiframe').css("display","block");
	})
</script>
 --->

 <!--- <cfquery name="getTemplates" datasource="#request.dsn#">
	SELECT Template_ID,Template_Name
	FROM Templates
</cfquery>

<cfinclude template="header.cfm">

<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
<style>
	#table_blogs td {
		vertical-align:middle;
	}
	#table_blogs td img {
		width:250px !important;
	}
	.loaderImage {
		display:none;
		position: absolute;
		z-index: 1055;
		left: 438px;
		top: 157px;
	}
</style>

<cfparam name="URL.PageId" default="0">
<cfset RecordsPerPage = 3>
<cfset TotalPages =round(getTemplates.recordcount/RecordsPerPage)-1>
<cfset StartRow = (URL.PageId*RecordsPerPage)+1>
<cfset EndRow = StartRow+RecordsPerPage-1>
<cfoutput>
<div class="row">
	<div class="table-responsive col-sm-12">
		<table id="table_blogs" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					
					<th class="col-sm-2">Template</th>
					
					<th class="col-sm-2">Preview</th>
					<th class="col-sm-1">Choose Template</th>
				</tr>
			</thead>
			<tbody>
				<cfif getTemplates.recordcount>
					<cfloop query="getTemplates">
						<cfif CurrentRow gte StartRow >
						<tr>
							<td>#getTemplates.Template_Name#</td>
							<td><a href="##previewiframe"><button id="#getTemplates.Template_ID#" class="preview">Preview</button><a></td>
							<td><input type="radio" name="template" id="template_#getTemplates.Template_ID#" value="#getTemplates.Template_ID#" class="template_radio"<cfif qCompany.Template_ID eq getTemplates.Template_ID>checked="checked"</cfif>></td>
						</tr>
						</cfif>
						<cfif CurrentRow eq EndRow>
					       <cfbreak>
					    </cfif>
					</cfloop>
					<tr>
						<td colspan="4">
							<div class="templatePagination" style="float:left;" >
								<cfif URL.PageId neq 0>
									<a href="?PageId=#URL.PageId-1#"><button class="btn btn-info btn-sm" style="border-radius: 8px;"> &laquo; Previous </button></a>
								</cfif>
								<cfif URL.PageId lt TotalPages>
									<a href="?PageId=#URL.PageId+1#"><button class="btn btn-info btn-sm" style="border-radius: 8px;">Next &raquo;</button></a>
								</cfif>
							</div>
							<button type="button" name="savetemplate"  id="savetemplate" style="float:right;" class="btn btn-info btn-sm">Save</button></td>
					</tr>
				<cfelse>
					<tr>
						<td align="center" colspan="4">No Templates Found</td>
					</tr>
				</cfif>
			</tbody>
		</table>
		
	</div>
</div>	

<div id="info" style="display: none;" class="alert alert-block alert-success">
 Template Selected and Saved Successfully !
</div>	
<iframe src="" height="500" width="1000" style="display:none" id="previewiframe"></iframe>

</cfoutput>
<cfinclude template="footer.cfm">
<script type="text/javascript">
	$('#savetemplate').click(function() {

		var Template_ID = $("input[name='template']:checked").val();
		
		$.ajax({
		type: "post",
		url: "company.cfc?method=updateCompanyTemplate",
		data: { 
				Template_ID: Template_ID,
				Company_ID:<cfoutput>#qCompany.Company_ID#</cfoutput>
			},

		success: function(data){
			
			$("#info").show();
			$("#info").delay(5000).fadeOut();
			
		}
		});
		
	});
	$(".preview").click(function(){
		var template_id=$(this).attr('id');
		
		$('#previewiframe').attr("src","http://demo.salonlocal.com?template_id="+template_id);
		$('#previewiframe').css("display","block");
	})
</script> --->