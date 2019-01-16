	var BUTTON_CLASS_OVER = "buttn-over";
	var BUTTON_CLASS_OUT = "buttn-out";
				
	var winSpawn = null;
	var reDash = /-/g;
	//var reBrack = //(/)/g;
	var reInteger = /^\d+$/;
	var reFloat = /^((\d+(\.\d*)?)|((\d*\.)?\d+))$/;
	var rePhone = /^\d{3}-\d{3}-\d{4}$/;
	var rePhoneShort = /\d{3}-\d{4}/;
	var reSSN = /\d{3}-d{2}-\d{4}/;
	var reZip=/^\d{5}([\-]\d{4})?$/;	
	var reEmail =  /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum|jobs|travel|mobi))$/;
	var reState = /^(AK|AL|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NB|NC|ND|NH|NJ|NM|NV|NY|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY)$/i;
	var DaysInMonth = [0,31,29,31,30,31,30,31,31,30,31,30,31];
	

	function isEmpty(strEvaluate){   
		return ((strEvaluate == null) || (strEvaluate.length == 0))
	}
	
	function isEmptyReturn(strEvaluate, strReturn){
		if(isEmpty(strEvaluate))
			return strReturn
		else
			return strEvaluate
	}

	function isState(sState){
		if(isEmpty(sState)) return !bolRequired;
		if(!reState.test(sState)) return false;
		return true;	
	}
	
	function isFloat(sFloat,bolNullOK){
		if(isEmpty(sFloat)) return !bolNullOK;
		if(!reFloat.test(sFloat)) return false;
		return true;
	}
		
	function isInteger(sInt,bolNullOK){
		if(isEmpty(sInt)) return !bolNullOK;
		if(!reInteger.test(sInt)) return false;
		return true;
	}	


	function isEmail(sEmail,bolNullOK){
		if(isEmpty(sEmail)) return !bolNullOK;
		if(!reEmail.test(sEmail)) return false;
		return true;
	}	
	
	function isZip(sZip, bolRequired){
		if(isEmpty(sZip)) return !bolRequired;
		if(!reZip.test(sZip)) return false;
		return true;
	}	
	
		
	function isZipShort(sZip,bolRequired){
		if(isEmpty(sZip)){
			if(bolRequired)
				return false;
			else
				return true;
		}
		if(!(sZip.length == 5)) return false;
		if(!reInteger.test(sZip)) return false;
		return true;
	}

	function isUSPhone(sPhone,bolRequired){
		if(isEmpty(sPhone)) return !bolRequired;
		if(!rePhone.test(sPhone)) return false;
		return true;
	}
	


	function isPhone(sInt, bolRequired){   
		if(isEmpty(sInt)) return !bolRequired;
		sInt = sInt.replace(reDash,"");
		if(sInt.length == 10 &&  reInteger.test(sInt)) 
			return true;
		else
			return false;
	}

	function isPhoneShort(sPhone,bolRequired){
		if(isEmpty(sPhone)) return !bolRequired;
		if(!rePhoneShort.test(sPhone)) return false;
		return true;
	}	
	
	function isSSN(sSSN,bolRequired){
		if(isEmpty(sSSN)) return !bolRequired;
		if(!reSSN.test(sSSN)) return false;
		return true;
	}	

	function isDate(sDate,bolRequired){ //DATE FORMAT mm/dd/yy
		//Check for NUll or string not long enough for a date format of mm/dd/yy
		if (isEmpty(sDate)) return !bolRequired;
		if (sDate.length < 8) return false;
		//Make sure the Date sybmols are in the correct place
		if ((sDate.slice(2,3) != "/") && (sDate.slice(5,6) != "/")) return false;
		//Seperate date components.  See if they are all integer
		var mm = sDate.slice(0,2);
		var dd = sDate.slice(3,5);
		var yy = sDate.slice(6,8);
		if (!(reInteger.test(mm)  && reInteger.test(dd) && reInteger.test(yy))) return false;
		//Parse to integer.  Parse 2nd char if its a 0.  ParseInt doesn't like leading 0's
		var intMonth = ((mm.slice(0,1) == 0) ? parseInt(mm.slice(1,2)): parseInt(mm));
		var intDay = ((dd.slice(0,1) == 0) ? parseInt(dd.slice(1,2)): parseInt(dd));
		var intYear = ((yy.slice(0,1) == 0) ? parseInt(yy.slice(1,2)): parseInt(yy)); 
		
		//Month range 1-12
		if ((intMonth < 1) ||(intMonth > 12)) return false; 
		//Days no more than usual days in month
		
		if ((intDay < 1) || (intDay > DaysInMonth[intMonth])) return false; 
		//February is special case
		var intDaysInFeb = (((intYear % 4 == 0) && ((!(intYear % 100 == 0)) || (intYear % 400 == 0)) ) ? 29 : 28);
		if ((intMonth == 2) && (intDay > intDaysInFeb)) return false;
		
		return true;
	}


	function isTime(sTime,bolRequired){
	// Time Format hh:mm AM/PM
		if(isEmpty(sTime)) return !bolRequired;
		if (sTime.length < 8) return false;
		
		var sHour 			= sTime.slice(0,2);	// 'hh
		var cTimeSeparator 	= sTime.slice(2,3);	// ':'
		var sMin 			= sTime.slice(3,5);	// 'mm'
		var cSpace 			= sTime.slice(5,6);	// ' '
		var sClockCycle		= sTime.slice(6,8);	// 'AM/PM'
		
		if (!(reInteger.test(sHour)  && cTimeSeparator == ":" && reInteger.test(sMin) && cSpace == " " && (sClockCycle == "PM" || sClockCycle == "AM"))) return false;
		
		var intHour = ((sHour.slice(0,1) == 0) ? parseInt(sHour.slice(1,2)): parseInt(sHour));
		var intMin = ((sMin.slice(0,1) == 0) ? parseInt(sMin.slice(1,2)): parseInt(sMin));
		
		if(intHour < 1 || intHour > 12)	return false;
		if(intMin > 59)	return false;
	
		return true;
	}	
	
	function getTime12(){
		var myDate = new Date();
		var tHours = myDate.getHours();
		var tMinutes = myDate.getMinutes();
		var tAMPM = "AM";
		if(tHours >= 12){	
			tHours = tHours - 12;
			if(tHours == 0) tHours = 12;
			tAMPM = "PM";
		}
		if(tHours == 0){ 
			tHours = 12;
			tAMPM = "AM";
		}	
		if(tHours < 10) tHours = "0" + tHours;
		if(tMinutes < 10) tMinutes = "0" + tMinutes;		
		return(tHours + ":" + tMinutes + " " + tAMPM);
	}	

	function selectOption(ctrlOption, strValue){
		var ctrlLength = ctrlOption.length;

		if(ctrlLength == undefined){
			ctrlOption.selected = true;
		}	
		else if(strValue == ""){
				ctrlOption.options[0].selected = true;
			}
			else{
				for (var i = 0; i < ctrlLength; i++)
					if (ctrlOption.options[i].value == strValue){
						ctrlOption.options[i].selected = true;
						break;
					}
			}
	 }
	 
	function selectRadio(ctrlRadio, strValue){
		var ctrlLength = ctrlRadio.length;

		if(ctrlLength == undefined){
			ctrlRadio.checked = true;
		}
		else if(strValue == ""){
				ctrlRadio[0].checked = true;
			}
			else{
					
				for (var i = 0; i < ctrlLength; i++){
					if (ctrlRadio[i].value == strValue){ 
						ctrlRadio[i].checked = true;
						break;
					}
				}
			}
	 }	
	 
	 
	 
	function getRadioValue(radioObject) {
		var strValue = null;
		for (var i=0; i<radioObject.length; i++) {
		   if (radioObject[i].checked) {
				strValue = radioObject[i].value;
				break ;
		   }
		}
		return strValue;
	}
	 


	function isRadioGroupChecked(cntrlRadio){
		var RadioLength = cntrlRadio.length;

		if(RadioLength == undefined && cntrlRadio.checked){
			return true;
		}else{
			for (var i = 0; i < RadioLength; i++)
				if(cntrlRadio[i].checked) return true;			
		}

		return false;
	}	
	
	function isRadioGroupCheckedByName(strControlName){
		var eCntrl = document.getElementsByName(strControlName);
		
        for(var k=0;k < eCntrl.length; k++)
          if(eCntrl[k].checked) return true;

		return false;
	}	 
	 
	 function handleTextAreaLimit(ctrlTextArea, intLimit, errMessage){
		if(ctrlTextArea.value.length > intLimit){
			alert(errMessage);
			ctrlTextArea.value = ctrlTextArea.value.slice(0,intLimit);
		}
	 } 	 
	 
	function Left(str, n){
		if (n <= 0)
			return "";
		else if (n > String(str).length)
			return str;
		else
			return String(str).substring(0,n);
	}
	
	function Right(str, n){
		if (n <= 0)
		   return "";
		else if (n > String(str).length)
		   return str;
		else {
		   var iLen = String(str).length;
		   return String(str).substring(iLen, iLen - n);
		}
	}	 
	
	
	function isStartTimeLess(tStart, tEnd){
	//Return true is tStart time is greater than tEnd time, else return false if equal or less than.
		//N:NN AM/PM
		//Parse Start Time string
		var colonPos = tStart.indexOf(":", 0);
		var tStartHour = parseInt(tStart.slice(0,colonPos));
		var tStartMin = parseInt(tStart.slice(colonPos + 1, colonPos + 3));
		var tStartAMPM = Right(tStart, 2);
		
		//Parse End Time string
		colonPos = tEnd.indexOf(":", 0);

		var tEndHour = parseInt(tEnd.slice(0,colonPos));
		var tEndMin = parseInt(tEnd.slice(colonPos + 1, colonPos + 3));
		var tEndAMPM = Right(tEnd, 2);	
		
		if(tStartAMPM == "PM" && tEndAMPM == "AM") return false;
		if(tStartAMPM == "AM" && tEndAMPM == "PM") return true;
		
		//At this point start and end will have same AM/PM values.
		if(tStartHour < tEndHour) return true;
		if(tStartHour > tEndHour) return false;
		//At this point start and end hours are the same.  Compare minutes.
		if(tStartMin < tEndMin) return true;
		if(tStartMin > tEndMin) return false;
		
		return false;				
	}	
	

	function trim(stringToTrim) {
		return stringToTrim.replace(/^\s+|\s+$/g,"");
	}
	function ltrim(stringToTrim) {
		return stringToTrim.replace(/^\s+/,"");
	}
	function rtrim(stringToTrim) {
		return stringToTrim.replace(/\s+$/,"");
	}	