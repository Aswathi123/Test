<cfset local.Survey_ID=0>
<cfif structKeyExists(url,"Survey_ID")>
	<cfset local.Survey_ID=url.Survey_ID>
</cfif>
<cfif structKeyExists(form,"submit_quest")>
	 <cfinvoke component="survey" method="insertQuestionsDetails" returnvariable="questionId">
		<cfinvokeargument name="form" value="#form#">
		<cfinvokeargument name="surveyId" value="#local.Survey_ID#">
	</cfinvoke>
	<cfif questionId gt 0>
		<cfinvoke component="survey" method="insertQuestionOptionDetails">
			<cfinvokeargument name="form" value="#form#">
			<cfinvokeargument name="questionId" value="#questionId#">
		</cfinvoke>
	</cfif>
</cfif>

<cfinclude template="header.cfm">
	<div class="row">
		<div class="col-sm-9" style="margin-left: 250px;">
			<form method="POST" action="" >
				<input type="hidden" value="1" name="optcount" id="optcount">
				<div class="row">
					<div class="form-group">
						<div class="col-sm-10">
							<input type="hidden" id="surveyquestion" name="surveyquestion" />
							<label>Type a question</label>
							<div>
								<textarea name="question" id="question" cols="94" rows="5"></textarea>
							</div>
							<div class="row">
								<div class="col-md-5 form-group">
									<label>Active:</label><br>
									<input type="radio" name="question_active" id="question_active" value="1" checked="checked">Active
									<input type="radio" name="question_active" id="question_active" value="0">Inactive
								</div>
							</div>
						</div>
					</div>
				</div><br><br>
				<div class="row" id="options">
					<div class="col-md-6 form-group">
						<input type="text" name="option_1" class="form-control" id="option_1" maxlength="50" value="" placeholder="Type option 1">
					</div>
					<div class="col-md-2 form-group">
						<input type="checkbox" name="other_op1" id="other_op1"><label>Other</label>
					</div>
					<div class="col-md-2 form-group">
						<label>Active:</label><br>
						<input type="radio" name="option_active_1" id="option_active_1" value="1" checked="checked">Active
						<input type="radio" name="option_active_1" id="option_active_1" value="0">Inactive
					</div>
					<div class="col-md-2 form-group">
						<button name="add_option" id="add_option"><span class="icon-plus-sign">Add Option</span></button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10 form-group">
						<button  name="submit_quest" id="submit_quest" class="btn btn-info btn-md" style="margin-left: 300px;" >Submit</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<cfinclude template="footer.cfm">
<script type="text/javascript">
	$(document).ready(function() {
		var max_fields      = 10;
		var wrapper         = $("#options");
		var add_button      = $("#add_option"); //Add button ID
        var option          = 1;
        var x = 1; //initlal text box count
        $(add_button).click(function(e){ //on add input button click
            e.preventDefault();
            if(x < max_fields){ //max input box allowed
                x++; //text box increment
                option++;
                $(wrapper).append('<div class="col-md-6 form-group option_'+option+'"><input type="text" name="option_'+option+'" class="form-control" id="option_'+option+'" maxlength="50" value="" placeholder="Type option '+option+'"></div><div class="col-md-2 form-group option_'+option+'"><input type="checkbox" name="other_op'+option+'" id="other_op'+option+'"><label>Other</label></div><div class="col-md-2 form-group option_'+option+'"><label>Active:</label><br><input type="radio" name="option_active_'+option+'" id="option_active_'+option+'" value="1" checked="checked">Active<input type="radio" name="option_active_'+option+'" id="option_active_'+option+'" value="0">Inactive</div><div class="col-md-2 form-group option_'+option+'"><button class="btn btn-danger btn-sm remove_field option_'+option+'" data-option = "'+option+'">Remove</button></div>'); //add input box
                $("#optcount").val(option);
            }
        });
        
        $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
            e.preventDefault();
            console.log($(this).attr('data-option'));
            var optionitem = $(this).attr('data-option');
            if(optionitem) {
            	$('.option_'+optionitem+'').remove();
            	 x--;
            	 option--;
            }
          
        })

        $('#submit_quest').click(function(){
        	var count=$('#optcount').val();

        	if($('#question').val() == ""){
        		alert("please enter the question");
        		return false;
        	}
        	else{
        		for(i=1;i<=count;i++){
        		
					if($('#option_'+i+'').val()==""){
        			alert("please fill the option fields");
        			return false;
        			}

        		}
        	}
        		
        });

    });
</script>

