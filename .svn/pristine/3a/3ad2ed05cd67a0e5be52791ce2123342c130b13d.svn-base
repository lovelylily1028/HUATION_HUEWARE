/*********************************************************************
 * This software was developed and owned by Locus
 * Illeger use of this software will violate the Copy Right Law
 *********************************************************************
 * Program Name : HueValidation.js
 * Function description :
 * Programmer Name : Cheol(Ethan) Park (chpark@locus.com)
 * Creation Date : 2003.07.10
 * Method List :
 * HueValidation.errorMessage()
 * HueValidation.isNumber()
 * HueValidation.getOnlyNumber()
 * HueValidation.catchDelimeter()
 * HueValidation.terminateDelimiter()
 * HueValidation.checkCalendarValidate()
 * HueValidation.isValidYMD()
 * HueValidation.changeCalendarType()
 * HueValidation.changeMoneyType()
 * HueValidation.checkMoneyValidate()
 * HueValidation.fucusTransfer()
 *********************************************************************
 *              PROGRAM HISTORY
 *********************************************************************
 * DATE :           PROGRAMMER :                       REASON :
 */
 function HueValidation(){}

 var HueValidation_ERROR_LEN           = "Data Length is Wrong!! Check your Data!!";
 var HueValidation_ERROR_TYPE_MONEY    = "금액이 잘못 입력되었습니다. 다시 입력해 주세요!";
 var HueValidation_ERROR_TYPE_CALENDAR = "Check your input Date Type!!\nUsage: only Number or ";
 var HueValidation_ERROR_MASK_CALENDAR = "Web Page Mask Setting Error!! please, Contact Web Master!!";
 var HueValidation_ERROR_REQUIRED      = "This Field is required Field!!";
 var HueValidation_ERROR_YEAR	   = "연도가 잘못 입력되었습니다. 다시 입력해 주세요!";
 var HueValidation_ERROR_MONTH         = "달이 잘못 입력되었습니다. 다시 입력해 주세요!";
 var HueValidation_ERROR_DAY           = "일자가 잘못 입력되었습니다. 다시 입력해 주세요!";
 var HueValidation_ERROR_DATE_TERM     = "Date Term Error!! Check your From Date!!";
 var HueValidation_ERROR_DATA_TERM_SETTING = "Date Term Setting Error!! please, Contact Web Master!!";
 var HueValidation_ERROR_NUMBER        = "숫자만 입력 가능합니다.!";
 var HueValidation_SUCCESS             = "성공";

HueValidation.prototype = new HueValidation();
HueValidation.prototype.constructor = HueValidation;
/** 이경민 입력 길이 체크해서 다음으로 fucus 넘기기 (2003.12.7) */
function HueValidation.checkLengthByObject(target, destination, length){
 	var str = target.value.length;
    if (str == length) 
	{
        destination.focus();
    }
}

 //This Function is Error Message Collection
 function HueValidation.errorMessage(errMessage){
 	if(errMessage == HueValidation_SUCCESS){
 		return;
 	} else {
	 	alert("Error: "+errMessage);
	}
 }

 //empty Termination Function
 function trim(targetStr){
	var eliminateStr = /\s+/g;
	return targetStr.replace(eliminateStr,"");
 }

// 이경민추가 : 숫자가 아니면 해당 컴포넌트로 지속적인 포커스 설정
 function HueValidation.isNumberCheck(objValue){	 		
 	var eliminateNum = "1234567890";
 	var numCheck = true;
	
 	for(i=0;i<trim(objValue.value).length;i++){
 		if(eliminateNum.indexOf(trim(objValue.value).charAt(i)) == -1){//There is something which is not number
 			numCheck = false;
			alert(HueValidation_ERROR_NUMBER);
			objValue.select();
 			break;
 		}
 	}

 	return numCheck;
 }

 // This Function identify Number
 function HueValidation.isNumber(objValue){
 	var eliminateNum = "1234567890";
 	var numCheck = true;
	
 	for(i=0;i<trim(objValue).length;i++){
 		if(eliminateNum.indexOf(trim(objValue).charAt(i)) == -1){//There is something which is not number
 			numCheck = false;
 			break;
 		}
 	}

 	return numCheck;
 }

 // This Function get The Number
 function HueValidation.getOnlyNumber(objValue){
	var eliminateNum = "1234567890";
	var tempNumber = "";
	
	for(i=0;i<trim(objValue).length;i++){
		if(eliminateNum.indexOf(trim(objValue).charAt(i)) != -1){//There is something which is not number
			tempNumber += trim(objValue).charAt(i);
		}
	}

	return tempNumber;
 }

 // This Function catching delimeter
 // Example : HueValidation.catchDelimeter('ymd','yyyy/mm/dd')
 function HueValidation.catchDelimeter(typeValue,newDelimeterValue){
 	var delimiter = "";
	var noDelimiterValue = "";
	var typeArray = new Array(2);

	for(i=0;i<trim(newDelimeterValue).length;i++){
		if(typeValue.indexOf(trim(newDelimeterValue).charAt(i)) == -1){
			delimiter = trim(newDelimeterValue).charAt(i);
		} else {
			noDelimiterValue += trim(newDelimeterValue).charAt(i);
		}
	}
	typeArray[0] = delimiter;
	typeArray[1] = noDelimiterValue;

	return typeArray;
 }

 // This Function deleting delimiter
 // Example : HueValidation.terminateDelimiter('/','2003/07/11')
 function HueValidation.terminateDelimiter(newDelimiter, targetValue){
 	var terminatedValue = "";

	for(i=0;i<trim(targetValue).length;i++){
		if(newDelimiter.indexOf(trim(targetValue).charAt(i)) == -1){
			terminatedValue += trim(targetValue).charAt(i);
		}
	}

	return terminatedValue;
 }

 // This Fucntion deviding Calendar Number according to be input Calendar Type
 // Example : HueValidation.addDelimiter('yyyy/mm/dd','/','20030711')
 function HueValidation.checkCalendarValidate(changingType,newDelimiter,changingValue){
	var YearCnt  = 0;		//Count of First Character
	var FY       = 0;		//Start Number of Character length
	var MonthCnt = 0;		//Count of Second Character
	var FM       = 0;
	var DayCnt   = 0;		//Count of Third Character
	var FD       = 0;
	var DivCnt   = 0;
	var YData    = "";
	var MData    = "";
	var DData    = "";
	var resultReplace = "";
	var dateDivision = "";		//Division of Date
	var targetValue = "";
	var changedValue = new Array(4);

	targetValue = HueValidation.terminateDelimiter(newDelimiter,changingValue);
	if(HueValidation.isNumber(targetValue)){
		resultReplace = trim(changingType);
		for(f=0;f<trim(changingType).length;f++){
			switch(trim(changingType).charAt(f)){
				case "y" : YearCnt++;
					   if(YearCnt == 1){
					   	(DivCnt != 0)? FY = (f-DivCnt):FY = f;
					   } else {
					   	FY += 1;	
					   }
					   resultReplace = resultReplace.replace("y",targetValue.charAt(FY));
					   YData += targetValue.charAt(FY);
					   break;
				case "m" : MonthCnt++;
					   if(MonthCnt == 1){
					   	(DivCnt != 0)? FM = (f-DivCnt):FM = f;
					   } else {
					   	FM += 1;	
					   }
					   resultReplace = resultReplace.replace("m",targetValue.charAt(FM));
					   MData += targetValue.charAt(FM);
					   break;
				case "d" : DayCnt++;
					   if(DayCnt == 1){
					   	(DivCnt != 0)? FD = (f-DivCnt):FD = f;
					   } else {
					   	FD += 1;	
					   }
					   resultReplace = resultReplace.replace("d",targetValue.charAt(FD));
					   DData += targetValue.charAt(FD);
					   break;
				default  : DivCnt++;
					   dateDivision = trim(changingType).charAt(f);
					   break;
			}
		}
		changedValue[0] = YData;
		changedValue[1] = MData;
		changedValue[2] = DData;
		changedValue[3] = resultReplace;
	} else {
		for(j=0;j<4;j++){
			changedValue[j] = "Error";
		}
		HueValidation.errorMessage(HueValidation_ERROR_NUMBER);
	}
	
	return changedValue;
 }

 // This Function validate Year,Month,Date
 // Example : HueValidation.isValidYMD() <- Array Parameter
 function HueValidation.isValidYMD(data){
	var YMDResult = "";

	if(parseInt(data[0],10) < 1000 || parseInt(data[1],10) > 9999){
		HueValidation.errorMessage(HueValidation_ERROR_YEAR);
		YMDResult = false;
	} else {
		if(parseInt(data[1],10) < 0 || parseInt(data[1],10) > 12){
			HueValidation.errorMessage(HueValidation_ERROR_MONTH);
			YMDResult = false;
		} else {
			var endofMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
			if ((parseInt(data[0],10) % 4 == 0 && parseInt(data[0],10) % 100 != 0) || parseInt(data[0],10) % 400 == 0) {
				endofMonth[1] = 29;
			}
		
			if(parseInt(data[2],10) >= 1 && parseInt(data[2],10) <= endofMonth[(parseInt(data[1],10) - 1)]){
				HueValidation.errorMessage(HueValidation_SUCCESS);
				YMDResult = true;
			} else {
				HueValidation.errorMessage(HueValidation_ERROR_DAY);
				YMDResult = false;
			}
		}
	}
	return YMDResult;
 }

 // This Function is Calendar Validation
 // Example : HueValidation.changeCalendarType('yyyy/mm/dd',20030710)
 function HueValidation.changeCalendarType(type,newDateObj){
 	var arrCalendarType = new Array(2);
 	var arrCalendarValue = new Array(4);
 	var resultCalendarValue = "";

	if(newDateObj.value != null && trim(newDateObj.value).length != 0){
	 	arrCalendarType = HueValidation.catchDelimeter('ymd',type);
		arrCalendarValue = HueValidation.checkCalendarValidate(type,arrCalendarType[0],newDateObj.value);
		if(arrCalendarValue[0] != "Error"){
			if(HueValidation.isValidYMD(arrCalendarValue)){
				newDateObj.value = arrCalendarValue[3];
			} else {
				newDateObj.select();
			}
		} else {
			newDateObj.select();
		}
	}
 }
 
 // This Function is Money Validation
 // Example : HueValidation.changeMoneyType(123456);
 function HueValidation.changeMoneyType(newMoneyObject){
 	var tempMoneyValue = "";
 	var tempResultValue = new Array(2);

 	tempMoneyValue = HueValidation.terminateDelimiter(',',newMoneyObject.value);
 	tempResultValue = HueValidation.checkMoneyValidate(tempMoneyValue);
	if(tempResultValue[0] == "SUCCESS"){
		newMoneyObject.value = tempResultValue[1];
	} else {
		newMoneyObject.select();
	}
 }
 
 // This Function changing Money Type
 function HueValidation.checkMoneyValidate(newMoneyValue){
	var underPoint = "";	//location of "."
	var countDivision = 0;	//count of ","
	var restofDivision = 0;	//rest after dividing value
	var quotient = 0;	//quotient after dividing value
	var tempMoneyValue = "";
	var tempRep = "";
	var resultFinal = new Array(2);	//final retrun value
	var tempLength = 0;
	var iNext = 0;
	var iStart = 0;
	var comma = ",";

	underPoint = trim(newMoneyValue).indexOf(".");
		if(underPoint == -1){
			if(trim(newMoneyValue).length != 0){
				newMoneyValue = newMoneyValue+".00";
				underPoint = trim(newMoneyValue).indexOf(".");
			}
		}
	tempMoneyValue = trim(newMoneyValue).substring(0,underPoint);
	tempLength = trim(tempMoneyValue).length;
	quotient = parseInt((tempLength/3),10);
	restofDivision = parseInt((tempLength%3),10);
	
	if(HueValidation.isNumber(tempMoneyValue) && HueValidation.isNumber(trim(newMoneyValue).substring((underPoint+1),trim(newMoneyValue).length))){
		if(restofDivision == 0){	//when result after dividing value is '0'
			iNext = tempLength;
			iStart = 0;
			for(i=0;i<quotient;i++){
				iStart = iNext - 3;
				if(iStart == 0)	comma = "";
				tempRep = comma+tempMoneyValue.substring(iStart,iNext)+trim(tempRep);
				iNext = iStart;
			}
		} else {
			iNext = tempLength;
			iStart = 0;
			for(j=0;j<(quotient+1);j++){
				iStart = iNext - 3;
				if(iStart < 0){
					comma = "";
					iStart = 0;
				}
				tempRep = comma+tempMoneyValue.substring(iStart,iNext)+trim(tempRep);
				iNext = iStart;
			}
		}
		if(tempRep == null || trim(tempRep).length == 0)	tempRep = tempMoneyValue;
		resultFinal[0] = "SUCCESS";
		resultFinal[1] = trim(tempRep)+trim(newMoneyValue).substring(underPoint,trim(newMoneyValue).length);
	} else {
		resultFinal[0] = "ERROR_TYPE_MONEY";
		resultFinal[1] = "";
		HueValidation.errorMessage(HueValidation_ERROR_TYPE_MONEY);
	}
	
	return resultFinal;
 }
 //This Function is dividing Number type
 //HueValidation.checkNumberType(delimeter,dividing type,object)
 //Example: HueValidation.checkNumberType("-","6:7",this)
 function HueValidation.checkNumberType(delimeter,delType,obj){
 	var typeResult = "";
 	
 	var originalValue = HueValidation.terminateDelimiter(delimeter,obj.value);
 	if(originalValue != null && trim(originalValue).length !=0){
	 	if(HueValidation.isNumber(originalValue)){
	 		typeResult = HueValidation.catchNumberType(delimeter,delType,originalValue);
	 		obj.value = typeResult;
	 	} else {
	 		HueValidation.errorMessage(HueValidation_ERROR_NUMBER);
	 	}
	} else {
		obj.value = "";
	}
 }
 function HueValidation.catchNumberType(newDelimiter,newType,newValue){
 	var newTypeResult = "";
 	var delCount = 0;
 	var catchPoint = new Array();
 	var tempStartPoint = 0;
 	var tempEndPoint = 0;
 	var tempCounter = 0;
 	var tempTotLength = 0;

 	for(i=0;i<trim(newType).length;i++){
 		if(trim(newType).charAt(i) == ":"){
 			catchPoint[delCount] = i;
 			delCount++;
 		} else {
 			tempTotLength += parseInt(trim(newType).charAt(i),10);
 		}
 	}

 	for(j=0;j<(catchPoint.length+1);j++){
 		tempStartPoint = parseInt(tempEndPoint,10);
 		tempEndPoint = parseInt(tempStartPoint,10) + parseInt(trim(newType).substring(tempCounter,catchPoint[j]),10);
 		tempCounter = catchPoint[j]+1;
 		newTypeResult += trim(newValue).substring(tempStartPoint,tempEndPoint);
 		if(j < catchPoint.length){
 			newTypeResult += newDelimiter;
 		}
 	}

 	return newTypeResult;
 }


//뒤로 가기 막기 (20040408 : 조현선추가)
 function document.onkeydown(){
	 //alert(event.keyCode);
	if(event.keyCode == 8){
		if(event.srcElement.type != "text" 
		   && event.srcElement.type != "password"
		   && event.srcElement.type != "textarea"){
			event.returnValue = false;
			event.cancelBub
		}		
	}else if(event.keyCode == 37){
		if(event.altKey == true){
			event.returnValue = false;
		}
	}else if(event.keyCode == 116){
		alert("F5 키는 사용할 수 없습니다.");
		event.returnValue = false;
		event.keyCode = 37;
	}
}
/*
function document.oncontextmenu(){
	return false;
}*/
    /**
     * 오직 숫자로만 이루어져 있는지 체크 한다.
     *
     * @param   num
     * @return  boolean
     */
    function isNumber(num) {
        re = /[0-9]*[0-9]$/;

        if (re.test(num)) {
            return  true;
        }

        return  false;
    }

	function onlyNum(val)
		{
		 var num = val;
		 var tmp = "";

		 for (var i = 0; i < num.length; i ++)
		 {
		  if (num.charAt(i) >= 0 && num.charAt(i) <= 9)
		   tmp = tmp + num.charAt(i);
		  else
		   continue;
		 }
		 return tmp;
	}
	/**
     * 숫자에 comma를 붙인다.
     *
     * @param   obj
     */
    function addComma(obj) {
        obj.value = trim(obj.value);
        var value = obj.value;

        if (value == "") {
            return;
        }

        value = deleteCommaStr(value);

        if (!isFloat(value)) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.value = "0";
            obj.focus();
            if (window.event) {
                window.event.returnValue = false;
            }
            return;
        }

        obj.value = addCommaStr(value);
    }

    /**
     * 숫자에 comma를 붙인다.
     */
    function addComma2() {
        var obj = window.event.srcElement;
        addComma(obj);
    }

    /**
     * 숫자에 comma를 붙인다.
     *
     * @param   str
     */
    function addCommaStr(str) {
        var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
        var arrNumber = str.split('.');
        arrNumber[0] += '.';
        do {
            arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
        } while (rxSplit.test(arrNumber[0]));

        if (arrNumber.length > 1) {
            replaceStr = arrNumber.join("");
        } else {
            replaceStr = arrNumber[0].split(".")[0];
        }
        return replaceStr;
    }

    /**
     * 숫자에서 comma를 없앤다.
     *
     * @param   obj
     */
    function deleteComma(obj) {
        obj.value = deleteCommaStr(obj.value);
    }

    /**
     * 숫자에서 comma를 없앤다.
     */
    function deleteComma2() {
        var obj = window.event.srcElement;
        deleteComma(obj);
        obj.select();
    }

    /**
     * 숫자에서 comma를 없앤다.
     *
     * @param   str
     */
    function deleteCommaStr(str) {
        var temp = '';

        for (var i = 0; i < str.length; i++) {
            if (str.charAt(i) == ',') {
                continue;
            } else {
                temp += str.charAt(i);
            }
        }

        return  temp;
    }

    /**
     * 날짜에 "/"를 붙인다.
     *
     * @param   obj
     */
    function addDateFormat(obj) {
        var value = obj.value;

        if (trim(value) == "") {
            return;
        }

        value = deleteDateFormatStr(value);

        if (!isDate(value)) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.focus();

            return;
        }

        obj.value = addDateFormatStr(value);
    }

    /**
     * 날짜(년월)에 "/"를 붙인다.
     *
     * @param   obj
     */
    function addYmFormat(obj) {
        var value = obj.value;

        if (trim(value) == "") {
            return;
        }

        value = deleteDateFormatStr(value);

        if (!isDate(value + "01")) {
            dispName = obj.getAttribute("dispName");

            if (dispName == null) {
                dispName = "";
            }

            alert(dispName + " 형식이 올바르지 않습니다.");
            obj.focus();

            return;
        }

        obj.value = addYmFormatStr(value);
    }
    
    /**
     * 날짜에 "/"를 붙인다.
     */
    function addDateFormat2() {
        var obj = window.event.srcElement;
        addDateFormat(obj);
    }

    /**
     * 날짜에 "/"를 붙인다.
     */
    function addYmFormat2() {
        var obj = window.event.srcElement;
        addYmFormat(obj);
    }

    /**
     * 날짜에 "/"를 붙인다.
     *
     * @param   str
     */
    function addDateFormatStr(str) {
        return  str.substring(0, 4) + "/" + str.substring(4, 6) + "/" + str.substring(6, 8);
    }

    /**
     * 날짜(년월)에 "/"를 붙인다.
     *
     * @param   str
     */
    function addYmFormatStr(str) {
        return  str.substring(0, 4) + "/" + str.substring(4, 6);
    }

    /**
     * 날짜에서 "/"를 없앤다.
     *
     * @param   obj
     */
    function deleteDateFormat(obj) {
        obj.value = deleteDateFormatStr(obj.value);
    }

    /**
     * 날짜에서 "/"를 없앤다.
     */
    function deleteDateFormat2() {
        var obj = window.event.srcElement;
        deleteDateFormat(obj);
        obj.select();
    }

    /**
     * 날짜에서 "/"를 없앤다.
     *
     * @param   str
     */
    function deleteDateFormatStr(str) {
        var temp = '';

        for (var i = 0; i < str.length; i++) {
            if (str.charAt(i) == '/') {
                continue;
            } else {
                temp += str.charAt(i);
            }
        }

        return  temp;
    }

    /**
     * trim
     *
     * @param   text
     * @return  string
     */
    function trim(text) {
    	if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(st) <= ' ')) {
            st++;
        }

        while ((st < len) && (text.charAt(len - 1) <= ' ')) {
            len--;
        }

        return  ((st > 0) || (len < text.length)) ? text.substring(st, len) : text;
    }

    /**
     * ltrim
     *
     * @param   text
     * @return  string
     */
    function ltrim(text) {
        if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(st) <= ' ')) {
            st++;
        }

        return  (st > 0) ? text.substring(st, len) : text;
    }

    /**
     * rtrim
     *
     * @param   text
     * @return  string
     */
    function rtrim(text) {
        if (text == "") {
            return  text;
        }

        var len = text.length;
        var st = 0;

        while ((st < len) && (text.charAt(len - 1) <= ' ')) {
            len--;
        }

        return  (len < text.length) ? text.substring(st, len) : text;
    }

    /**
     * 이벤트 핸들러를 등록한다.
     */
    function setEventHandler() {
        for (i = 0; i < document.forms.length; i++) {

            var elements = document.forms(i).elements;

            for (j = 0; j < elements.length; j++) {
                // INPUT 객체의 onblur 이벤트에 핸들러를 등록한다.
                if (elements(j).tagName == "INPUT") {

                    dataType = elements(j).getAttribute("dataType");

                    if (dataType == "date") {
                        elements(j).onblur = addDateFormat2;
                        elements(j).onfocus = deleteDateFormat2;
                        addDateFormat(elements(j));
                    } else if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                        if (elements(j).getAttribute("comma") != null) {
                            elements(j).onblur = addComma2;
                            elements(j).onfocus = deleteComma2;
                            addComma(elements(j));
                        }
                    } else if (dataType == "yyyymm") {
                        elements(j).onblur = addYmFormat2;
                        elements(j).onfocus = deleteDateFormat2;
                        addYmFormat(elements(j));
                    }
                }
            }
        }
    }

    /**
     * 자리수의 최소값, 최대값
     *
     * 최소값만 체크 : jsRange(2, -1)
     * 최대값만 체크 : jsRange(-1, 10)
     * 최소값, 최대값 모두 체크 : jsRange(2, 10)
     * 최소값, 최대값 둘다 체크 안함 : jsRange(-1, -1)
     * 
     */
    function jsRange(minValue, maxValue)
    {
        jsMinLength(minValue);
        jsMaxLength(maxValue);
    }
	function js_Str_ChkSub(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 최대 "+ max +"자(Byte)까지 가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)는 삭제됩니다.");

			for (var inx = 0; inx < Object.value.length; inx++) {
				var oneChar1 = Object.value.charAt(inx)
				var oneChar = escape(oneChar1);
				if ( oneChar.length == 1 )
					byteLength ++;
				else if (oneChar.indexOf("%u") != -1)
					byteLength += 2;
				else if (oneChar.indexOf("%") != -1)
					byteLength += oneChar.length/3;
	
				rtnStr+=oneChar1;
	
				if(byteLength >= max) break;
				else if((byteLength+1) >= max)
					if (escape(Object.value.charAt(inx+1)).indexOf("%u") != -1) break;
			
		    }//end for
		    
			Object.value = rtnStr;
	
		}else {
		}
	
	}
	// 문구 수정.. (dispName은 한글 기준으로 30자(영문 60자)까지 입력가능합니다.)
	function js_Str_ChkSub_edit(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 한글 기준으로  "+ max/2 +"자(영문 "+max+"자)까지 입력가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)는 삭제됩니다.");

			for (var inx = 0; inx < Object.value.length; inx++) {
				var oneChar1 = Object.value.charAt(inx)
				var oneChar = escape(oneChar1);
				if ( oneChar.length == 1 )
					byteLength ++;
				else if (oneChar.indexOf("%u") != -1)
					byteLength += 2;
				else if (oneChar.indexOf("%") != -1)
					byteLength += oneChar.length/3;
	
				rtnStr+=oneChar1;
	
				if(byteLength >= max) break;
				else if((byteLength+1) >= max)
					if (escape(Object.value.charAt(inx+1)).indexOf("%u") != -1) break;
			
		    }//end for
		    
			Object.value = rtnStr;
	
		}else {
	
		}
	
	}
	
	// 다른 페이지에 iframe 형식으로 만들어 놓은 것이기 때문에. 
	function js_Str_ChkSub_edit_content(max,Object){
		var byteLength = 0;
        var dispName    = Object.getAttribute("dispName");
		var rtnStr = "";	// 문자열을 잘라 입력필드에 넣는다
		var Len = jsByteLength(Object.value);
		if(Len > max){
            alert(dispName +"는(은) 한글 기준으로  "+ max/2 +"자(영문 "+max+"자)까지 입력가능합니다.\n\n마지막 "+(Len-max)+"자(Byte)를 삭제하셔야 합니다.");
			return false;
	
		}else {
			return true;
		}
	
	}
	
	
	
    /**
     * 최대값
     */
    function jsMaxLength(maxValue)
    {
        var obj         = window.event.srcElement;
        var dispName    = obj.getAttribute("dispName");
        //var maxValue    = obj.getAttribute("maxValue");
        var val         = jsByteLength(obj.value);
        if(maxValue != -1 && val > maxValue)
        {
            alert(dispName +" 값이 최대값("+ maxValue +")을 초과합니다.\n초과 길이 :"+ (val - maxValue));
        	var objValue    = obj.value;
        	obj.value = objValue.substring(0, maxValue-2);
            obj.focus();
            if(window.event)
            {
                window.event.returnValue = false;
            }
            return;
        }
    }

    /**
     * 최소값
     */
    function jsMinLength(minValue)
    {
        var obj         = window.event.srcElement;
        var dispName    = obj.getAttribute("dispName");
        //var minValue    = obj.getAttribute("minValue");
        var val         = jsByteLength(obj.value);
        if(minValue != -1 && val < minValue)
        {
            alert(dispName +" 값이 최소값(" + minValue + ") 미만입니다.\n부족 길이 :"+ (minValue - val));
            //obj.value = "0";
            obj.focus();
            if(window.event)
            {
                window.event.returnValue = false;
            }
            return;
        }
    }

    /**
     * 숫자이면 숫자, 숫자가 아니면 0
     */
    function nvlNumber(val)
    {
        if(val == "" || isNaN(val) || val == "undefined")
            return 0;

        return Number(val);
    }

    /**
     * 숫자형식에서 comma를 없애고, 날짜형식에서 "/" 를 없앤다.
     *
     * @param   form
     */
    function makeValue(form) {
        for (i = 0; i < form.elements.length; i++) {
            obj = form.elements(i);

            if (obj.tagName == "INPUT") {
                dataType = obj.getAttribute("dataType");

                if (dataType == "date") {
                    deleteDateFormat(obj);
                } else if (dataType == "number" || dataType == "integer" || dataType == "float" || dataType == "double") {
                    if (obj.getAttribute("comma") != null) {
                        deleteComma(obj);
                    }
                } else if (dataType == "yyyymm") {
                    deleteDateFormat(obj);
                }
                /// notHyphen 이라고 선언했다면 하이픈을 모두 제거한다.
                if(obj.getAttribute("notHyphen") != null) {
                    deleteHyphenObj(obj);
                }
            }
        }
    }
	function clearSelectOptions(object)
		{
			if(object.tagName != "SELECT") return;
			
			for(var i = object.options.length - 1 ; i >= 0 ; i--) 
			{
				object.options.remove(i);
			}
		}

	function addSelectOption(object, value, text)
	{
		option = document.createElement("OPTION");
		option.text = text;
		option.value = value;
		
		object.options.add(option);
	}
	function selectValue(object, isValue)
	{

		for(var i = 0 ; i < object.options.length ; i++)
		{
			if(object.options[i].value==isValue){
				object.options[i].selected=true;
			}
		}

	}

	function searchOption(yobj,mobj,isValue){

		 if(yobj.value=='2009'){
			clearSelectOptions(mobj);
			addSelectOption(mobj, '06', '~6월(누적)');
			addSelectOption(mobj, '07', '7월');
			addSelectOption(mobj, '08', '8월');
			addSelectOption(mobj, '09', '9월');
			addSelectOption(mobj, '10', '10월');
			addSelectOption(mobj, '11', '11월');
			addSelectOption(mobj, '12', '12월');
		}else{
			clearSelectOptions(mobj);
			addSelectOption(mobj, '01', '1월');
			addSelectOption(mobj, '02', '2월');
			addSelectOption(mobj, '03', '3월');
			addSelectOption(mobj, '04', '4월');
			addSelectOption(mobj, '05', '5월');
			addSelectOption(mobj, '06', '6월');
			addSelectOption(mobj, '07', '7월');
			addSelectOption(mobj, '08', '8월');
			addSelectOption(mobj, '09', '9월');
			addSelectOption(mobj, '10', '10월');
			addSelectOption(mobj, '11', '11월');
			addSelectOption(mobj, '12', '12월');
		}

		selectValue(mobj, isValue)

	}


