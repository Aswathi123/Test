<cfinclude template="header.cfm" />
<cfif Not IsDefined("Session.Professional_ID")>
		<cflocation url="login.cfm" />
</cfif>
<cfset variables.companyCFC = createObject("component","company") /> 

<cfset variables.blnShowSaveMsg = false />
<cfif structKeyExists(form, 'socialIdList')>
	
	<cfset variables.companyCFC.saveSocialMediaForm(session.company_id, Form) />
	<cfset variables.blnShowSaveMsg = true />
</cfif>

<cfset variables.qryCompanySocialMedia = variables.companyCFC.getCompanySocialMedia(session.company_id) />
<cfset variables.qrySocialMedia = variables.companyCFC.getSocialMedia() />

<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="calendar/interface/libs/jquery-ui-1.8.11.custom.min.js"></script>
<!--- <script type="text/javascript" src="js/jquery.validate.js"></script> --->
<link rel="stylesheet" type="text/css" href="calendar/interface/libs/css/smoothness/jquery-ui-1.8.11.custom.css"/>
<link rel="stylesheet" type="text/css" href="/css/forms.css" />

<style type="text/css">
	button{width: 100px;}
</style>
<script type="text/javascript">
	var socialIdArray = [];
	
	$(document).ready(function(){
		//$("#frmDataForm").validate();
		
		 $(".clsRemove").button({
				icons: { primary: "ui-icon-trash"},
				text: true
		});
		 $("#btnAdd").button({
				icons: { primary: "ui-icon-plusthick"},
				text: true
		});
		 $("#btnSubmit").button({
				icons: { primary: "ui-icon-disk"},
				text: true
		});
		
		
		<cfoutput>
		<cfloop query="variables.qryCompanySocialMedia">
			socialIdArray[socialIdArray.length] = #Social_Media_ID#;
		</cfloop>
		</cfoutput>
		$('#socialIdList').val(socialIdArray.join());
		
	});

	fnRemove = function(id){
		var arrayRemovePos = socialIdArray.indexOf(parseInt(id));
		socialIdArray.splice(arrayRemovePos, 1);
		$('#socialIdList').val(socialIdArray.join());
		$('#socialId_' + id).remove();
	}
	
	fnAdd = function(){
		var id = $('#selSocialMedia').val();
		var siteName = $("#selSocialMedia option:selected").text();

		if(socialIdArray.indexOf(parseInt(id)) == -1){
			var logoFile = $("#selSocialMedia option:selected").attr("logoFile");
			var rowHtml = '<tr id="socialId_' + id + '"><td><img src="../images/' + logoFile + '"  /></td><td>' + siteName + '</td><td><strong>URL: </strong><input type="text" id="url_' + id + '" name="url_' + id + '" class="required" style="width: 300px;" /></td><td><button type="button" id="btnRemove" name="btnRemove" class="clsRemove" onclick="fnRemove(' + id + ')">Remove</button></td></tr>';
			
			$('#tblSocialMedia tr:first').before(rowHtml);
			
			<!--- if($('#tblSocialMedia tr').length){
				$('#tblSocialMedia tr:last').after(rowHtml);
			}
			else{
				$('#tblSocialMedia tbody').append(rowHtml);
			} --->
			
			socialIdArray[socialIdArray.length] = parseInt(id);
			$('#socialIdList').val(socialIdArray.join());
		 	$(".clsRemove").button({
				icons: { primary: "ui-icon-trash"},
				text: true
			});			
		
		}
		else{
			alert(siteName + ' has already been added.');
		}
	}
</script>




<cfoutput>
<br />
<cfif variables.blnShowSaveMsg><div align="center">Social Media Form has been saved</div></cfif>
<div id="form-main" style="padding-left: 10px;">
	
    <form class="cmxform" id="frmDataForm" name="frmDataForm" method="post" action="socialMedia.cfm">  
     <input type="hidden" id="socialIdList" name="socialIdList" />

	<select id="selSocialMedia">
		<cfloop query="qrySocialMedia">
			<option id="selRowId_#Social_Media_ID#" logoFile="#Logo_File#" siteName="#Site_Name#" value="#Social_Media_ID#">#Site_Name#</option>
		</cfloop>
		
	</select> <button type="button" id="btnAdd" onclick="fnAdd()">Add</button>
	<br />
	
	<table id="tblSocialMedia" border="0" style="width:600px">
	<tbody>
	<cfloop query="variables.qryCompanySocialMedia">
	<tr id="socialId_#Social_Media_ID#">
		<td><img src="../images/#Logo_File#"  /></td>
		<td>#Site_Name#</td>
		<td><strong>URL: </strong><input type="text" id="url_#Social_Media_ID#" name="url_#Social_Media_ID#" class="required" value="#url#" style="width: 300px;" /></td>
		<td><button type="button" id="btnRemove" name="btnRemove" class="clsRemove" onclick="fnRemove(#Social_Media_ID#)">Remove</button></td>
	</tr>
	</cfloop>
	<tr><td colspan="4" align="right"><button type="submit" id="btnSubmit" name="btnSubmit">Save</button></td></tr>
	</tbody>
	</table>
	

    </form>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">