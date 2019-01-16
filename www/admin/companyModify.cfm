<cfif Not IsDefined("Session.Professional_ID")>
		<cflocation url="login.cfm" />
</cfif>

<cfinclude template="header.cfm" />
<link rel="stylesheet" href="/css/forms.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script>
<script language="javascript" type="text/javascript">

	$(document).ready(function(){
		initializePage();
		$("#frmDataForm").validate();
	
	  });
	  
	function initializePage(){

	}
</script>

<cfoutput>
<br />
<div id="form-main">
    <form id="frmDataForm" name="frmDataForm" method="post" action="companyModifyProcess.cfm">  
        <div id="form-controls">
            <div class="control-row">
               <label for="WebAddress">Web Address &nbsp;&nbsp;</label>
                    <input type="text" name="WebAddress" id="WebAddress" value="#Session.Form.WebAddress#" class="txt-med required" maxlength="50" />.salonworks.com
            </div>
            <div class="control-row">
               <label for="CompanyName">Company Name  &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyName" id="CompanyName" value="#Session.Form.CompanyName#" class="txt-med" maxlength="50" />
            </div>            
            
            <div class="control-row">
               <label for="CompanyAddress">Company Address &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyAddress" id="CompanyAddress" value="#Session.Form.CompanyAddress#" class="txt-med" maxlength="50" />
                    <input type="text" name="CompanyAddress2" id="CompanyAddress2" value="#Session.Form.CompanyAddress2#" class="txt-med" maxlength="50" />
            </div>  
            
            <div class="control-row">
               <label for="CompanyCity">Company City &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyCity" id="CompanyCity" value="#Session.Form.CompanyCity#" class="txt-med" maxlength="50" />
            </div>             

			<div class="control-row">
               <label for="CompanyState">Company State &nbsp;&nbsp;</label>
                <cfinvoke component="admin.states" method="getStates">
                    <cfinvokeargument name="Select_Name" value="CompanyState">
                    <cfinvokeargument name="Selected_State" value="#Session.Form.CompanyState#">
                </cfinvoke>
            </div>   
                       
            <div class="control-row">
               <label for="CompanyPostal">Company Postal &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyPostal" id="CompanyPostal" value="#Session.Form.CompanyPostal#" class="txt-sm" maxlength="50" />
            </div>   
            
            <div class="control-row">
               <label for="CompanyPhone">Company Phone &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyPhone" id="CompanyPhone" value="#Session.Form.CompanyPhone#" class="txt-med" maxlength="50" />
            </div> 
            
            <div class="control-row">
               <label for="CompanyEmail">Company Email &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyEmail" id="CompanyEmail" value="#Session.Form.CompanyEmail#" class="txt-med email" maxlength="50" />
            </div>                         
          
            
            <div class="control-row">
               <label for="CompanyFax">Company Fax &nbsp;&nbsp;</label>
                    <input type="text" name="CompanyFax" id="CompanyFax" value="#Session.Form.CompanyFax#" class="txt-med" maxlength="50" />
            </div>  
            
			<div class="control-row" style="height:100%">
               <label for="CompanyDescription">Company Description &nbsp;&nbsp;</label>
                    <textarea id="CompanyDescription" name="CompanyDescription" maxlength="4000" cols="50" rows="5">#Session.Form.CompanyDescription#</textarea>
            </div> 
			<br clear="all" />
            <div style="margin-left: 50px;"><input type="submit" id="btnSave" name="btnSave" 
            		value="Save" style="width: 100px" /></div>            
        	
        </div>
    </form>  
</div>
</cfoutput>

<cfinclude template="footer.cfm">