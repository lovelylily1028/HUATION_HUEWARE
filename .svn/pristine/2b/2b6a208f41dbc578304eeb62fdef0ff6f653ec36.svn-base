/*********************************************************************
 * This software was developed and owned by Locus
 * Illeger use of this software will violate the Copy Right Law
 *********************************************************************
 * Program Name : HueCommon.js
 * Programmer Name : mira Jin (nettj@locus.com)
 * Function description :Validation/Filter/Format(money, dollar, date, mask)기능처리/공통기능 함수 포함
 * Method List :
 * f_disable()
 * f_enable()
 * f_validate()
 * f_validate_display()
 * f_remove_format()
 * f_format_mask()
 * f_onkeypress()
 * f_onfocus()
 * f_onblur()
 * HueCommon.main()




* ************************* 유틸성 스크립트 *************************
* ****************************************************************
* HueCommon.f_oncheck()
* HueCommon.isNumber()
* HueCommon.openBrWindow()
* ****************************************************************
* 내  용 : 1. html문서 하단에 아래처럼 스크립트화일을 지정한다.
*             예: <SCRIPT src="HueCommon.js" language="JScript"></SCRIPT>
*          2. <input> 태그내 사용하고자 하는 기능을 삽입한다.
*             예: <INPUT type="text" name="kkkk" size="20" 
*                  maxlength="10" money required>
*          3. 기능
*             - readOnly
*               필드를 읽기전용으로 만든다.
*
*             - required
*               필드를 필수입력으로 만든다.
*               입력이 되지않았을 시 메세지와 함께 노란바탕으로 변한다.
*
*             - right
*               필드내 text-alignment를 오른쪽으로 정리한다.
*               물론 디폴트는 왼쪽정렬이다.
*
*             - filter="[abcde-y]"
*               나열된 내용만 입력가능하도록 filtering을 한다.
*               예: "[abc]" -> a, b, c만 입력가능하다.
*               예: "[acf]" -> a, c, f만 입력가능하다.
*               예: "[a-z123]" -> a에서 z까지와 1, 2, 3 이 입력가능하다.
*               예: "[a4*#$%]" -> a, 4, *, #, $, % 가 입력가능하다.
*
*             - mask="999-999"
*               우편번호를 입력하고자 할때 위와같이 세팅하고
*               maxlength="6"으로 지정한다. 즉 숫자갯수만큼만 지정한다.
*               "600112" 입력시 "600-112"으로 리포맷된다.
*
*             - money
*               금액 입력후 필드를 벗어나게 되면 세자리마다 콤마(,)가 생성된다.
*               "1234567890" 입력시 "1,234,567,890"으로 리포맷된다.
*
*             - date
*               날자를 입력하는 필드의 경우 사용한다.
*               date와 mask를 함께 사용한다.
*               예: <INPUT type="text" name="8" size="20" maxlength="8"
*                   date required>
*               여기서도 maxlength는 숫자갯수인 8이다.
*               "20000914" 입력시 "2000/09/14"으로 리포맷된다.
*
*             - date2
*               날자를 입력하는 필드의 경우 사용한다.
*               date와 mask를 함께 사용한다.
*               예: <INPUT type="text" name="6" size="20" maxlength="6"
*                   date2 required>
*               여기서도 maxlength는 숫자갯수인 6이다.
*               "200009" 입력시 "2000/09"으로 리포맷된다.
*
*             - dollar
*               "123456" 입력시 "1234.56"으로 리포맷된다.
*			   - upper
*				 대문자로 변환
*			   - msg
*			    예:<input type="text" name="9" required msg="형식(123)">
*				에러메시지창: 에러메시지+ [형식(123)]으로 표현된다.
*			   - length
*				 입력값의 길이를 체크한다.
*				 예:<input type="text" name="10" required maxlength="4" length=4>
*				 length의 값은 반드시 숫자여야 한다.
*				 maxlength속성도 같은 길이로 맞춰준다.
*			   - onlynum
*			     정해진 데이타 타입 외에 숫자만 입력되야 할 경우
*				 예:<input type="text" name="10" required maxlength="4" onlynum>
*			   - phone
*				 폰타입
*			   - compaccnt
*				 계좌번호
***********************************************************************************
*              PROGRAM HISTORY
***********************************************************************************
* DATE :           PROGRAMMER :                       REASON :
* 04.02.19        Daniel Shim                              1.계좌번호 포맷팅 및 달력 추가
***********************************************************************************/




//*******************************************************************************//
//****************************** 전역변수와 상수를 정의  *****************************//
//*******************************************************************************//

var SUCCESS = 0;
var ERR_REQUIRED = 1;
var ERR_FORMAT = 2;
var ERR_LENGTH = 3;
var ERR_ONLYNUM = 4;
var ERR_DATE = 10;
var ERR_YY = 11;
var ERR_MM = 12;
var ERR_DD = 13;
var ERR_PHONE = 14;
var ERR_DATE2 = 15;

var MSG_ERR010 = "필수입력입니다";
var MSG_ERR020 = "잘못된입력입니다.";
var MSG_ERR030 = "날짜입력이 잘못되었습니다.[YYYY/MM/DD]";
var MSG_ERR031 = "날짜입력이 잘못되었습니다.[YYYY/MM]";
var MSG_ERR040 = "자리수가 맞지 않습니다."
var MSG_ERR050 = "숫자만 입력합니다.";
var MSG_ERR060 = "형식에 맞지 않는 번호입니다..";


var MSG_ERR100 = "지정되지 않은 에러입니다.";

var TYPE_NONE = 0;
var TYPE_MONEY = 1 ;
var TYPE_DOLLAR = 2;
var TYPE_DATE = 3;
var TYPE_MASK = 4;
var TYPE_JUMIN = 5;
var TYPE_POST = 6;
var TYPE_ACCNT = 7;
var TYPE_COMPACCNT = 8;
var TYPE_PHONE = 9;
var TYPE_TIME = 10;
var TYPE_ACCNTCOMBO = 11;
var TYPE_USER = 12;
var TYPE_DATE2 = 13;

var OPEN_OBJECT=new Array();


//*******************************************************************************//
//******************************* UTILTITY FUNCTIONS  *****************************//
//*******************************************************************************//
function HueCommon(){}

//////////////////////////////////////////////////////////////////////////////
// 함수명 :  isNum (v)
// 내  용 : 입력이 숫자임을 검사한다.
///////////////////////////////////////////////////////////////////////////////
  function isNum (v){
    return (v.toString() && !/\D/.test(v));  
  }  

///////////////////////////////////////////////////////////////////////////////
// 함수명 : trim(string)
// 내  용 : 문자열에서 공백을 제거하고 반환한다.
///////////////////////////////////////////////////////////////////////////////
 function trim(targetStr){
	if(targetStr){
		var eliminateStr = /\s+/g;
		return targetStr.replace(eliminateStr,"");
	}else return targetStr;
 }

///////////////////////////////////////////////////////////////////////////////
// 함수명 : ltrim(string)
// 내  용 : 문자열에서 좌측 공백만을 제거하고 반환한다.
///////////////////////////////////////////////////////////////////////////////
 function ltrim(targetStr){
	while(targetStr.substring(0,1)==" ") {
		targetStr = targetStr.substring(1);
	}
	return targetStr;
 }

///////////////////////////////////////////////////////////////////////////////
// 함수명 : rtrim(string)
// 내  용 : 문자열에서 우측 공백을 제거하고 반환한다.
///////////////////////////////////////////////////////////////////////////////
 function rtrim(targetStr){
	 len = targetStr.length;
	while(targetStr.substring(len-1,len)==" ") {
		targetStr = targetStr.substring(0,len-1);
		len = targetStr.length;
	}
	return targetStr;
 }

///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.openBrWindow()
// 내  용 : 새창을 팝업하는 키(위치 지정하는 Parameter를 받았을때)
// Event  : onClick()
// Object : elements
///////////////////////////////////////////////////////////////////////////////
function HueCommon.openBrWindow(url,target,width,height,windX,winY) {

	var x = windX;
	var y = winY;

	if(windX==null){
	
		x= (1024 -width) /2;
	}

	if(winY==null){
	
		y=(768 - height) /2; 
	}

	var winopts = "width="+width+",height="+height
					+  ",toolbar=0,location=0,directories=0,status=1,"
					+  "menubar=0,scrollbars=0,resizable=0,left="	+ x + ",top=" + y ;
    var openobj=window.open(url,target,winopts);

	OPEN_OBJECT.push(openobj);

}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.openBrWindowClose()
// 내  용 : 새창을 팝업하는 키
// Event  : onClick()
// Object : elements
///////////////////////////////////////////////////////////////////////////////
function HueCommon.openBrWindowClose() {

	for(i=0;i<OPEN_OBJECT.length;i++){

		var obj=OPEN_OBJECT[i];
		obj.close();

	}
	OPEN_OBJECT.length=0;

}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.getSplitStr()
// 내  용 : 특정문자열에서 지정된 특정 문자를 벗겨내어 반환한다.
// Event  : onClick()
// Object : elements
///////////////////////////////////////////////////////////////////////////////
function HueCommon.getSplitStr(sourceStr, splitStr) {
	var newStr = "";
	var i;

	for (i = 0; i < sourceStr.length; i++) {
		if (sourceStr.charAt(i) != splitStr) {
			newStr = newStr + sourceStr.charAt(i);
		}
	}
	return newStr;
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.isNumber()
// 내  용 : 각 element의 숫자만 허용하는 이벤트
// Event  : onKeypress()
// Object : elements
///////////////////////////////////////////////////////////////////////////////
function HueCommon.isNumber(objValue){	 		
 	var eliminateNum = "1234567890";
 	var numCheck = true;
	
 	for (i = 0; i < trim(objValue.value).length ;i++){

		//If there is something which is not number_______________
 		if (eliminateNum.indexOf(trim(objValue.value).charAt(i)) == -1){
 			numCheck = false;
			window.status = MSG_ERR050;
			objValue.select();
 			break;
 		}
 	}

 	return numCheck;
}
function formatAstSocialId(strId){
	strId = strId.substring(0,6);
	return strId+"*******";
}


//*********************************************************************************//
//****************************** VALIDATION FUNCTIONS  *****************************//
//*********************************************************************************//

///////////////////////////////////////////////////////////////////////////////
// 함수명 : f_validate()
// 내  용 : 각 입력 값에 대한 입력 체크
//          Select는 필수입력여부만을 검사한다.
///////////////////////////////////////////////////////////////////////////////
function f_validate()
{

  if ( !this.value ) this.value = "";

  
  switch (this.iType){
  case TYPE_MONEY : 
                   if (this.getAttribute("required") != null && this.value =="" ) return ERR_REQUIRED;
				   
				   return SUCCESS;
                   break;
  case TYPE_DATE : 
                   var sDate=this.value.replace(/(\,|\.|\-|\/)/g,"");  
                   var sFormat="YYYYMMDD";
                   var aDaysInMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);  

                   if (this.getAttribute("required") != null && !this.value ) 
                       return ERR_REQUIRED;
                   if (this.getAttribute("required")==null && !this.value ) 
                       return SUCCESS;
      
                       //완전한 날짜의 입력이 들어온 경우이다. 

                   if ( sDate.length != 8 ) return ERR_DATE;

                   if ( !isNum(sDate.substr(0,4)) 
                        ||!isNum(sDate.substr(4,2)) 
                        ||!isNum(sDate.substr(6,2)))  return ERR_DATE;  


                    iYear=eval(sDate.substr(0,4));
                    iMonth=eval(sDate.substr(4,2));
                    iDay=eval(sDate.substr(6,2));

                         // Check for leap year
                     var iDaysInMonth=(iMonth!=2)?aDaysInMonth[iMonth-1]:((iYear%4==0 && iYear%100!=0 || iYear % 400==0)?29:28);  
  
                     if ( (iDay!=null && iMonth!=null && iYear!=null  && iMonth<13 && iMonth>0 && iDay>0 && iDay<=iDaysInMonth) == false )  return ERR_DATE;  
    
                     return SUCCESS; 
                     break;
   case TYPE_DATE2 : 
                   var sDate=this.value.replace(/(\,|\.|\-|\/)/g,"");  
                   var sFormat="YYYYMM";
                   var aDaysInMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);  

                   if (this.getAttribute("required") != null && !this.value ) 
                       return ERR_REQUIRED;
                   if (this.getAttribute("required")==null && !this.value ) 
                       return SUCCESS;
      
                       //완전한 날짜의 입력이 들어온 경우이다. 

                   if ( sDate.length != 6 ) return ERR_DATE2;

                   if ( !isNum(sDate.substr(0,4)) 
                        ||!isNum(sDate.substr(4,2))) return ERR_DATE2;  


                    iYear=eval(sDate.substr(0,4));
                    iMonth=eval(sDate.substr(4,2));

                     // Check for leap year
                     //var iDaysInMonth=(iMonth!=2)?aDaysInMonth[iMonth-1]:((iYear%4==0 && iYear%100!=0 || iYear % 400==0)?29:28);  
  
                     if ( (iMonth!=null && iYear!=null  && iMonth<13 && iMonth>0) == false )  return ERR_DATE2;  
    
                     return SUCCESS; 
                     break;
  case TYPE_DOLLAR : 
                     if (this.getAttribute("required") != null && this.value =="" ) return ERR_REQUIRED;
					 return SUCCESS;
                   break;
  case TYPE_MASK :                    
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
                     this.format();
                   
                     //마스크에 대한 입력을 검사한다.
                     var sMask=this.getAttribute("mask");    
                     //마스크가 없으면 입력검사를 하지 않는다.
                     if (!sMask) return SUCCESS;
                     
                     if (sMask && this.value){    
                       var sPattern=sMask.replace(/(\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\]|\/)/g,"\\$1");    
                       sPattern=sPattern.replace(/9/g ,"\\d");    
                       sPattern=sPattern.replace(/x/ig,".");    
                       sPattern=sPattern.replace(/z/ig,"\\d?");    
                       sPattern=sPattern.replace(/a/ig,"[A-Za-z]");    
                       var re=new RegExp("^"+sPattern+"$");    
                       if (!re.test(this.value))  return ERR_FORMAT;
                   
                     }    
                               
                     return SUCCESS;
                     break; 
 case TYPE_JUMIN:
					 var sJumin=this.value.replace(/(\,|\.|\-)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 if ( sJumin.length != 13 && sJumin.length !=0 ) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;			 

 case TYPE_POST:
					 var sPost=this.value.replace(/(\,|\.|\-)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 if ( sPost.length != 6 ) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;

 case TYPE_COMPACCNT:
					 var sCompaccnt=this.value.replace(/(\,|\.|\-)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 if ( sCompaccnt.length != 10 && sCompaccnt.length != 8 && sCompaccnt.length !=0) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;		

 case TYPE_ACCNT:
					 var sAccnt=this.value.replace(/(\,|\.|\-)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 if ( sAccnt.length != 10 && sAccnt.length != 8 && sAccnt.length !=0) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;		

 case TYPE_PHONE:   
					 var sPhone=this.value.replace(/(\,|\.|\-)/g,"");
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 
					 for (i = 0; i < this.value.length; i++) {
						if (this.value.indexOf("-") < 0) {
							return  ERR_PHONE;
							break;
						}
						
					 }
					
					 //if ( sAccnt.length != 8 ) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;		
 case TYPE_TIME:
					 var sTime=this.value.replace(/(\,|\.|\-|\:)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;
					 if (sTime.length !=6 && sTime.length !=4 && sTime.length != 0 ) return ERR_LENGTH;					 
					 return SUCCESS;
					 break;		

 case TYPE_NONE : 
                     if (this.getAttribute("required") != null && this.value =="" ) return ERR_REQUIRED;
					 if (this.getAttribute("length") != null && this.value.length !=this.getAttribute("length")) return ERR_LENGTH;
					 
                     return SUCCESS;
                     break;
    
 case TYPE_ACCNTCOMBO:
					 var sCompaccnt=this.value.replace(/(\,|\.|\-)/g,"");  
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;					 
					 if ( sCompaccnt.length != 10 && sCompaccnt.length != 8 && sCompaccnt.length != 0 ) return ERR_LENGTH;					 					 
					 return SUCCESS;
					 break;	
 case TYPE_USER:
					 var sCompUser=this.value.replace(/(\,|\.|\-)/g,"");  
					alert(this.getAttribute("required"));
					 if (this.getAttribute("required") != null && !this.value )  return ERR_REQUIRED;					 
					 return SUCCESS;
					 break;	
  
 
	
	}
                 
            
  return SUCCESS;
}
 

function f_validate_display() {
  
  var ret = this.validate();


   switch (ret){
    case SUCCESS :
          window.status = "";
          return true;
          break;
    case ERR_REQUIRED :
		  if (this.getAttribute("msg"))
			window.status = MSG_ERR010+"["+this.getAttribute("msg")+"]";
		  else
			window.status = MSG_ERR010;
          break;

    case ERR_DATE:
            window.status = MSG_ERR030;
          break;

	case ERR_DATE2:
            window.status = MSG_ERR031;
          break;
 
    case ERR_FORMAT :
          if (this.getAttribute("msg"))
            window.status = this.getAttribute("msg")+"[" + this.getAttribute("mask")+"]";
          else
            window.status = MSG_ERR020 + "["+this.getAttribute("mask")+"]";
          break;
	case ERR_LENGTH :		  
		  if (this.getAttribute("length"))
		    window.status = MSG_ERR040+"["+this.getAttribute("length")+"]자리";
		  else
			window.status = MSG_ERR040;
		  break;		
	case ERR_PHONE:
		  window.status = MSG_ERR060;
		  break;
   // case ERR_ONLYNUM :
	//	 alert(MSG_ERR050);
	//	  break;
    default :
          window.status = "";
          break;
	}   
 
  // this.style.backgroundColor = "#CCFFCC";
	this.focus(); 
	this.select();

	return  false;
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 :f_all_format_remove()
// 내  용 : 모든 입력 포멧을 없앤다.
// Event : OnFocus시 호출되는 함수이다.
// Object : Input
///////////////////////////////////////////////////////////////////////////////
function f_remove_format()
{
	this.value = this.value.replace(/(\,|\.|\-|\/|\:)/g,""); 
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 :f_format()
// 내 용  : 모든 타입의 포맷을 맞춘다.
///////////////////////////////////////////////////////////////////////////////
function f_format() {

	switch (this.iType) {
		case TYPE_MONEY :			
			this.value = moneyComma(this.value);
			break;
		
		case TYPE_DOLLAR :
			var sMoney = this.value.replace(/(\,|\.)/g, "");
			if (sMoney.length <= 2) return sMoney;
				
			var fir_sMoney = sMoney.substr(0, sMoney.length - 2);
			var sec_sMoney = sMoney.substr(sMoney.length - 2, 2);
			var tMoney = "";
			var i;
			var j = 0;
			var tLen = fir_sMoney.length;
			
			if (fir_sMoney.length <= 3) return fir_sMoney + "." + sec_sMoney;
			for (i = 0; i < tLen; i++) {
				if (i != 0 && (i % 3 == tLen % 3)) tMoney += ",";
				if (i < fir_sMoney.length) tMoney += fir_sMoney.charAt(i);
			}
			this.value = tMoney + "." + sec_sMoney; 
			break;

		case TYPE_DATE :
			this.value = f_format_mask(this.value, "9999/99/99");
			break;
		case TYPE_DATE2 :
			this.value = f_format_mask(this.value, "9999/99");
			break;
		case TYPE_JUMIN :
			this.value = f_format_mask(this.value, "999999-9999999");
			break;
		case TYPE_POST :
			this.value = f_format_mask(this.value, "999-999");
			break;
		case TYPE_COMPACCNT :
			this.value = f_format_mask(this.value, "9999-9999");
			break;
		case TYPE_ACCNT :
			this.value = f_format_mask(this.value, "9999-9999-99");
			break;
		case TYPE_PHONE :
			this.value = f_format_phone(this.value);
			break;
		case TYPE_TIME :
			this.value = f_format_mask(this.value,"99:99:99");
			break;
		case TYPE_MASK :
			this.value = f_format_mask(this.value, this.getAttribute("mask"));
			break;
		case TYPE_ACCNTCOMBO :
			this.value = f_format_mask(this.value, "9999-9999-99");
			break;
	}
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 :f_format_mask()
// 내  용 : 입력 포멧을 자동변경한다.
// Event : KeyPress
// Object : Input
///////////////////////////////////////////////////////////////////////////////
function f_format_mask(str, mask) {

	var sStr = str.replace( /(\$|\^|\*|\(|\)|\+|\.|\?|\\|\{|\}|\||\[|\]|\-|\/|\:)/g,"");
	var tStr="";
	var i;
	var j = 0; 

	for (i=0; i< sStr.length; i++) {
		tStr += sStr.charAt(i);
		j++;
		if (j<sStr.length && j < mask.length && mask.charAt(j) != "9") {
			tStr += mask.charAt(j++);
		}
	}
	return tStr;
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 :f_format_phone()
// 내  용 : 전화번호 포멧을 자동변경한다.
// Event : 
// Object : Input
///////////////////////////////////////////////////////////////////////////////
function f_format_phone(str) {
	rgnNo = new Array;
	rgnNo[0] = "02";
	rgnNo[1] = "031";
	rgnNo[2] = "032";
	rgnNo[3] = "033";
	rgnNo[4] = "041";
	rgnNo[5] = "042";
	rgnNo[6] = "043";
	rgnNo[7] = "051";
	rgnNo[8] = "052";
	rgnNo[9] = "053";
	rgnNo[10] = "054";
	rgnNo[11] = "055";
	rgnNo[12] = "061";
	rgnNo[13] = "062";
	rgnNo[14] = "063";
	rgnNo[15] = "064";
	rgnNo[16] = "010";
	rgnNo[17] = "011";
	rgnNo[18] = "016";
	rgnNo[19] = "017";
	rgnNo[20] = "018";
	rgnNo[21] = "019";
    
	for (i = 0; i < rgnNo.length; i++) {
		if (str.indexOf(rgnNo[i]) == 0) {
			len_rgn = rgnNo[i].length;
			formattedNo = getFormattedPhone(str.substring(len_rgn));
			return rgnNo[i] + "-" + formattedNo;
		}
		
	}
	if (str.length > 8)
		return str;
	return getFormattedPhone(str);
}

function getFormattedPhone(str) {
	if (str.length<=4) {
		return str;
	}
	else {
		len_no1 = str.length - 4;
		no1 = str.substring(0, len_no1);
		no2 = str.substring(len_no1);
		return no1 + "-" + no2;
	}
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : f_onkeypress()
// 내  용 : 키입력을 처리하기위한 핸들러
// Event  : KeyPress
// Object : text
///////////////////////////////////////////////////////////////////////////////
function f_onkeypress() {
	var sFilter;
	
	switch (this.iType) {
		case TYPE_MONEY :
		case TYPE_DOLLAR :
		case TYPE_DATE :
		case TYPE_DATE2 :
		case TYPE_JUMIN :
		case TYPE_ACCNT :
		case TYPE_COMPACCNT :
			sFilter="[0-9]";
			break;
		case TYPE_PHONE :
		case TYPE_POST :
		case TYPE_MASK :
		case TYPE_TIME :
			sFilter="[0-9]";
			break;
		case TYPE_NONE :
			if (this.getAttribute("onlynum") != null)
				sFilter="[0-9]";
			else
				sFilter= this.getAttribute("filter");
			break;
		case TYPE_ACCNTCOMBO :
			sFilter="[0-9]";
			break;
		case TYPE_USER :
			selectbox = eval("document.forms[0]."+this.selectbox);
			HueCommon.searchUserList(selectbox);
		default :
			break;
	}

	//필터가 지정된 경우만 검사한다.
	if (sFilter) {
		var sKey = String.fromCharCode(event.keyCode);
		var re = new RegExp(sFilter);
		
		// Enter는 키검사를 하지 않는다.
		if (sKey!="\r" && !re.test(sKey)) {
			event.returnValue = false;
		}else {
			var customFunc = this.func;
			if(this.iType == TYPE_ACCNTCOMBO && this.value.length==7) {
				this.value = this.value+sKey;
				if(this.selectbox==null || this.selectbox=="") {
					selectbox="_NONE"
				}else{
					selectbox = eval("document.forms[0]."+this.selectbox);
					//selectbox.setAttribute("accntinputbox", this);
				}
				if(customFunc!=null){
					HueCommon.seachAccntList(this.value, this, selectbox, customFunc);
				}else {
					HueCommon.seachAccntList(this.value, this, selectbox);
				}
				event.returnValue = false;
				if (this.getAttribute("pwdvalue") !=null) eval('document.all.' + this.getAttribute("pwdvalue") + '.focus()');						
			}else if(this.iType == TYPE_COMPACCNT && this.value.length==7) {
				this.value = this.value+sKey;
				if(customFunc!=null){
					HueCommon.seachAccnt(this.value, customFunc);
				}else {
					HueCommon.seachAccnt(this.value);
				}
				event.returnValue = false;
				if (this.getAttribute("pwdvalue") !=null) eval('document.all.' + this.getAttribute("pwdvalue") + '.focus()');
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : f_onfocus()
// 내  용 : 각 element의 focus를 위한 이벤트핸들러 
// Event  : onFocus()
// Object : elements
///////////////////////////////////////////////////////////////////////////////
function f_onfocus()
{
	this.remove_format();
	if (this.select)
		this.select();
}
function f_select()
{
 this.select();
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : f_onblur()
// 내   용 : 각 컨트롤의 포커싱이 사라질때 유효성 검사
///////////////////////////////////////////////////////////////////////////////
function f_onblur()
{  
	//숫자체크
	switch (this.iType) {
		case TYPE_MONEY :
		case TYPE_DOLLAR :
		case TYPE_DATE :
		case TYPE_DATE2 :
		case TYPE_JUMIN :
		case TYPE_ACCNT :
		case TYPE_COMPACCNT :
		case TYPE_PHONE :
		case TYPE_POST :
		case TYPE_TIME :
		case TYPE_MASK :
			if (this.getAttribute("onlynum") != null)
			HueCommon.isNumber(this);
			break;
		case TYPE_NONE :
			if (this.getAttribute("onlynum") != null)
				HueCommon.isNumber(this);
			break;
		case TYPE_USER :
		default :
			break;
	}
	
	// UPPERCASE
	if (this.getAttribute("upper") != null)
		this.value=this.value.toUpperCase();
		
	//Formatting... 
	this.format();
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : f_oncheck()
// 내  용 : Form에서 입력값 Submit시 에러체크를 위한 함수 
//            실제로 submit 버튼을 클릭할때 사용하는 스크립트함수
// Event : click()
// Object : Form
///////////////////////////////////////////////////////////////////////////////
function HueCommon.f_oncheck()
{
	var i;
	
	for (i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].validate) {
			if (document.forms[0].elements[i].validate_display() == false) {
				event.returnValue = false;
				return false;
			}
		} 
	}
   
	//Formatting을 모두 삭제한다.
	for (i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].remove_format)
			document.forms[0].elements[i].remove_format();
	}
   
	//데이타를 서버로 전송한다.
	document.forms[0].submit();

	//다시 Formatting한다.
	for (i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].format)
		document.forms[0].elements[i].format();
	}
	
	event.returnValue = false;
	return true;
}

function HueCommon.f_oncheckWithoutRemove_format()
{
	var i;
	
	for (i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].validate) {
			if (document.forms[0].elements[i].validate_display() == false) {
				event.returnValue = false;
				return false;
			}
		} 
	}
   
	//데이타를 서버로 전송한다.
	document.forms[0].submit();

	//다시 Formatting한다.
	for (i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].format)
		document.forms[0].elements[i].format();
	}
	
	event.returnValue = false;
	return true;
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.f_clear()
// 내  용 : 화면 필드 초기화 (부분적으로)
// Event  : onclick()
///////////////////////////////////////////////////////////////////////////////
function HueCommon.f_clear(){
	var mForm = document.forms[0]; 
	var iElements = mForm.elements.length;

	for (i = 0; i < iElements; i++){

		if (mForm.elements[i].getAttribute("cleared") != null){
			mForm.elements[i].value="";
			if(mForm.elements[i].getAttribute("onlynum") != null)mForm.elements[i].value="0";
		}
	}
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.keyDown()
// 내  용 : 탭키이동
// Event  : onKeydown()
///////////////////////////////////////////////////////////////////////////////

function HueCommon.keyDown() { 
			var k = window.event.keyCode;
			
			
			if ( k ==9) { 
					event.keyCode=null; 	
					eval('document.all.'+index1+'.focus()');
					return false;
			}else if(k==13 ){
					event.keyCode=null;
					eval('document.all.'+nextfield+'.onclick()');
					return;
			}
		
				
}
///////////////////////////////////////////////////////////////////////////////
// 함수명 : HueCommon.main()
// 내  용 : 화면이 로딩된 이후 HueCommon.js 초기화
// Event  : body.onload()
///////////////////////////////////////////////////////////////////////////////
function HueCommon.init(){

	var mForm = document.forms[0]; 
	var iElements = mForm.elements.length;

	for (i = 0; i < iElements; i++){

		//required or not rignt or left 지정(css이용)
		if (mForm.elements[i].getAttribute("required") != null ) {
			if (mForm.elements[i].getAttribute("right") != null ) {
				mForm.elements[i].className = "required_right";          
            }
            else mForm.elements[i].className = "required";
		}
		else {
			if (mForm.elements[i].getAttribute("right") != null ) {
				mForm.elements[i].className = "right";
			}
		}

		//각각의 elements에 해당되는 이벤트를 핸들링할 함수를 지정한다.
		switch ( mForm.elements[i].type ) {
      
			case "password" :
				
			case "text"     :							
				if (mForm.elements[i].getAttribute("money") != null)
					mForm.elements[i].iType = TYPE_MONEY;
				else if (mForm.elements[i].getAttribute("dollar") != null)
					mForm.elements[i].iType = TYPE_DOLLAR;
				else if (mForm.elements[i].getAttribute("date") != null)
					mForm.elements[i].iType = TYPE_DATE;
				else if (mForm.elements[i].getAttribute("date2") != null)
					mForm.elements[i].iType = TYPE_DATE2;
				else if (mForm.elements[i].getAttribute("jumin") != null)
					mForm.elements[i].iType = TYPE_JUMIN;
				else if (mForm.elements[i].getAttribute("post") != null)
					mForm.elements[i].iType = TYPE_POST;
				else if (mForm.elements[i].getAttribute("accnt") != null)
					mForm.elements[i].iType = TYPE_ACCNT;
				else if (mForm.elements[i].getAttribute("compaccnt") != null)
					mForm.elements[i].iType = TYPE_COMPACCNT;
				else if (mForm.elements[i].getAttribute("phone") != null)
					mForm.elements[i].iType = TYPE_PHONE;
				else if (mForm.elements[i].getAttribute("time") != null)
					mForm.elements[i].iType = TYPE_TIME;
				else if (mForm.elements[i].getAttribute("mask") != null)
					mForm.elements[i].iType = TYPE_MASK;
				else if (mForm.elements[i].getAttribute("accntcombo") != null)
					mForm.elements[i].iType = TYPE_ACCNTCOMBO;
				else
					mForm.elements[i].iType = TYPE_NONE;
					
				mForm.elements[i].onkeypress = f_onkeypress;
				mForm.elements[i].onblur = f_onblur;
				mForm.elements[i].format = f_format;
				mForm.elements[i].validate = f_validate;
				mForm.elements[i].validate_display = f_validate_display;
				mForm.elements[i].onfocus =f_select;

				if (mForm.elements[i].iType != TYPE_NONE) {
					mForm.elements[i].onfocus = f_onfocus;
					mForm.elements[i].remove_format = f_remove_format;					
				}

                break;   

			case "select-one" :
				if (mForm.elements[i].getAttribute("user") != null) { 
					mForm.elements[i].iType = TYPE_USER;
					searchUserList( mForm.elements[i] ); 	
				}

				break;	

			default:
				break;            

		} //end of switch
	} // end of for loop
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 :splitAcctNo(var, obj, obj)
// 내  용 : 단일계좌번호를 둘로 분리해서 해당 오브젝트이 밸류로 넣음
// Object : Input
///////////////////////////////////////////////////////////////////////////////
function splitAcctNo(num, obj1, obj2) {
	var acc_no = num.replace(/(\-|\ )/g,'');
	if(acc_no.length==10) {
		obj1.value = acc_no.substring(0,8);
		obj2.value = acc_no.substring(8,10);
	}
}


//테이블의 로우 코드메틱 관련
var selectedRow;
var selectedRow2;
var selectedRow_bg;
var selectedRow_bg2;
var mouseOverRow_bg;
///////////////////////////////////////////////////////////////////////////////
// 함수명 :mouseOver(var)
// 내  용 : 마우스 오버 효과를 줌
// Event : OnMouseOver시 호출할 수 있는 함수이다.
///////////////////////////////////////////////////////////////////////////////
function mouseOver(obj, obj2,obj3,obj4,obj5) {
	mouseOverRow_bg=obj.style.backgroundColor;
	obj.style.backgroundColor='#DBECFF';
	if(obj2!=null) {
		mouseOverRow_bg=obj2.style.backgroundColor;
		obj2.style.backgroundColor='#DBECFF';
	}
	if(obj3!=null) {
		mouseOverRow_bg=obj3.style.backgroundColor;
		obj3.style.backgroundColor='#DBECFF';
	}
	if(obj4!=null) {
		mouseOverRow_bg=obj4.style.backgroundColor;
		obj4.style.backgroundColor='#DBECFF';
	}
	if(obj5!=null) {
		mouseOverRow_bg=obj5.style.backgroundColor;
		obj5.style.backgroundColor='#DBECFF';
	}
}
///////////////////////////////////////////////////////////////////////////////
// 함수명 :mouseOut(var)
// 내  용 : 마우스 아웃 효과를 줌
// Event : OnMouseOut시 호출할 수 있는 함수이다.
///////////////////////////////////////////////////////////////////////////////
function mouseOut(obj, obj2,obj3,obj4,obj5) {
	if (selectedRow==obj) return;
	obj.style.backgroundColor= mouseOverRow_bg;
	if(obj2!=null) {
		obj2.style.backgroundColor= mouseOverRow_bg;
	}
	if(obj3!=null) {
		obj3.style.backgroundColor= mouseOverRow_bg;
	}
	if(obj4!=null) {
		obj4.style.backgroundColor= mouseOverRow_bg;
	}
	if(obj5!=null) {
		obj5.style.backgroundColor=mouseOverRow_bg;
	}
}
///////////////////////////////////////////////////////////////////////////////
// 함수명 :remember(var)
// 내  용 : 클릭한 행을 기억함
// Event : onclick시 호출할 수 있는 함수이다.
// Object : Input
///////////////////////////////////////////////////////////////////////////////
function remember(obj, obj2) {
	if(selectedRow!=null) {
		selectedRow.style.backgroundColor=selectedRow_bg;
	}
	selectedRow = obj;
	selectedRow_bg = obj.getAttribute("bgcolor");
	obj.style.backgroundColor="#DBECFF";
	obj.getAttribute("bgcolor", "#DBECFF");

	if(obj2!=null) {
		if(selectedRow2!=null) {
			selectedRow2.style.backgroundColor=selectedRow_bg;
		}
		selectedRow2 = obj;
		selectedRow_bg2 = obj.getAttribute("bgcolor");
		obj2.style.backgroundColor="#DBECFF";
		obj2.getAttribute("bgcolor", "#DBECFF");

	}
}


/*-------------------페이징 모듈시 쓰인다.(다음,이전)--------------------------------------*/
///////////////////////////////////////////////////////////////////////////////
// 함수명 : preCondition() 
// 내  용 : 이전버튼 누를시 키값 세팅
// Event  : 각함수에서 호출됨
// Object : 
//////////////////////////////////////////////////////////////////////////////

function HueCommon.preCondition(key,submitFormName,depth){		
	var idx = !depth?top.opener.getIndex(submitFormName.screenID.value):top.opener.top.opener.getIndex(submitFormName.screenID.value);	
	submitFormName.searchYN.value = 'P';	
	if(!depth){//오프너에오프너일때
		--top.opener.screenIndex[idx].nextButtonIndex;    
	}else{
		--top.opener.top.opener.screenIndex[idx].nextButtonIndex;    
	}	
	key.value = !depth?top.opener.getNextValue(top.opener.screenIndex[idx].nextValue,top.opener.screenIndex[idx].nextButtonIndex)
		               :top.opener.top.opener.getNextValue(top.opener.top.opener.screenIndex[idx].nextValue,top.opener.top.opener.screenIndex[idx].nextButtonIndex);    
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : nextCondition() 
// 내  용 : 다음버튼 누를시 키값 세팅
// Event  : 각함수에서 호출됨
// Object : 
//////////////////////////////////////////////////////////////////////////////
function HueCommon.nextCondition(key,nextData,submitFormName,depth){  	
	var idx = !depth?top.opener.getIndex(submitFormName.screenID.value):top.opener.top.opener.getIndex(submitFormName.screenID.value);	
	submitFormName.searchYN.value = 'N';	
	if(!depth){//오프너에오프너일때
		++top.opener.screenIndex[idx].nextButtonIndex;	
	}else{
		++top.opener.top.opener.screenIndex[idx].nextButtonIndex;	
	}
	key.value = nextData.value;		
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : setScreeID() 
// 내  용 : 스크린 아이디 생성
// Event  : 각함수에서 호출됨
// Object : 
//////////////////////////////////////////////////////////////////////////////

function HueCommon.setScreeID(screenID,submitFormName){		
	submitFormName.screenID.value= screenID;	
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : getNextValue() 
// 내  용 : 다음값을 가지고 온다.
// Event  : 각함수에서 호출됨
// Object : 
/////////////////////////////////////////////////////////////////////////////

function initialNextData(f,nextDataName,nextData){ //프레임으로 나누어 주었을때는 반드시 써준다.		
	nextDataName.value = nextData;
	f.searchYN.value = 'Y';
}



/*-------------------페이징 모듈시 쓰인다.(다음,이전)--------------------------------------*/



///////////////////////////////////////////////////////////////////////////////
// 내  용 : 계좌번호 콤보리스트를 표시하는 공통 컨트럴러와 제공 함수들
// 작  성 : Daniel Shim, 2004.03.18
///////////////////////////////////////////////////////////////////////////////
//종합계좌 정보조회
function HueCommon.seachAccnt(accnt, customFunc) {
	if (accnt.length == 8) {
		pwd="000";
		accnt_type = document.all.accnt_type.value;
		//여기서 xmlHttp 사용하기
		var xmlhttp = null;
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		requestUrl="/jedi/common.account.info.do?TranNames=CCF104Q_SER2&init=true"
					+ "&p_a01="+accnt.substring(0,8)
					+ "&p_a02="+pwd
					+ "&p_a30=0&p_pgm_id=acct"
					+ "&comp_accnt="+accnt
					+ "&accnt_type="+accnt_type;
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);
	
		//받기
		var resultText = null;
		resultText = xmlhttp.responseText;
		//alert(resultText);
		var xmlObject = null;
		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
	
		var res_code="";
		var res_msg="";
		var name="";
		var socialId="";
		var socialId1="";
		var socialId2="";
		var branchId="";
		var branchName="";
		var contactpoint="";
	
		try{
			res_code		= xmlObject.documentElement.childNodes.item(0).text;
			res_msg			= xmlObject.documentElement.childNodes.item(1).text;
			name				= xmlObject.documentElement.childNodes.item(2).text;
			socialId			= xmlObject.documentElement.childNodes.item(3).text;
			socialId1	 		= xmlObject.documentElement.childNodes.item(4).text;
			socialId2 		= xmlObject.documentElement.childNodes.item(5).text;
			branchId		= xmlObject.documentElement.childNodes.item(6).text;
			branchName	= xmlObject.documentElement.childNodes.item(7).text;
			contactpoint	= xmlObject.documentElement.childNodes.item(8).text;
		}catch(e){
			res_code="";
			res_msg="";
			name="";
			socialId="";
			socialId1="";
			socialId2="";
			branchId="";
			branchName="";
			contactpoint="";

		}
		
		xmlhttp = null;
		xmlObject = null;
		//setting
		//window.status = res_msg;
		if(res_code=="0") {		
			try{
				if(customFunc!=null) {
					eval(customFunc+"("+res_code+", "+res_msg+", "+name+", "+socialId+", "+socialId1+", "+socialId2+", "+branchId+", "+branchName+", "+contactpoint+")");
				}else {
					setAccntInfo(res_code, res_msg, name, socialId, socialId1, socialId2, branchId, branchName, contactpoint);
				}
			}catch(e){}
		}else{
			try{
				if(customFunc!=null) {
					eval(customFunc+"('', '', '', '', '', '', '', '', '')");
				}else {
					setAccntInfo('', '', '', '', '', '', '', '', '');
				}
			}catch(e){}
		}
	}
}

//계좌목록 조회
function HueCommon.seachAccntList(accnt, inputbox, selectbox, customFunc) {
	if (accnt.length >= 8) {
		pwd="000";
		accnt_type = document.all.accnt_type.value;
		if(accnt.length==10) {
			prod_no = accnt.substring(8,10);
		}else {
			prod_no="";
		}
		//여기서 xmlHttp 사용하기
		var xmlhttp = null;
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		requestUrl="/jedi/common.account.list.do?TranNames=CCF104Q_SER2&init=true"
					+ "&p_a01="+accnt.substring(0,8)
					+ "&p_a02="+pwd
					+ "&p_a30=0&p_pgm_id=acct"
					+ "&comp_accnt="+accnt
					+ "&prod_no="+prod_no
					+ "&accnt_type="+accnt_type;
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);
	
		//받기
		var resultText = null;
		resultText = xmlhttp.responseText;
		//alert(resultText);

		var xmlObject = null;
		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
	
		//
		var res_code="";
		var res_msg="";
		var name="";
		var socialId="";
		var socialId1="";
		var socialId2="";
		var branchId="";
		var branchName="";
		var contactpoint="";
		var repeat="";
		var productArray = new Array();
		var selIdx=-1;

		try{
					
			res_code		= xmlObject.documentElement.childNodes.item(0).text;
			res_msg			= xmlObject.documentElement.childNodes.item(1).text;
			name				= xmlObject.documentElement.childNodes.item(2).text;
			socialId			= xmlObject.documentElement.childNodes.item(3).text;
			socialId1	 		= xmlObject.documentElement.childNodes.item(4).text;
			socialId2 		= xmlObject.documentElement.childNodes.item(5).text;
			branchId		= xmlObject.documentElement.childNodes.item(6).text;
			branchName	= xmlObject.documentElement.childNodes.item(7).text;
			contactpoint	= xmlObject.documentElement.childNodes.item(8).text;
			repeat			= xmlObject.documentElement.childNodes.item(9).text;
		}catch(e) {
			res_code="";
			res_msg="";
			name="";
			socialId="";
			socialId1="";
			socialId2="";
			branchId="";
			branchName="";
			contactpoint="";
			repeat="";
		}
		var index=10;
		var selcount=0;
		for(i=0;i<repeat;i++) {
			var product = new Array();
			for(j=0; j<5; j++) {
				product.push(xmlObject.documentElement.childNodes.item(index++).text);
			}
			if(accnt.length==10 && product[0]==accnt.substring(8,10)) {
				selIdx=selcount;
			}
			if(accnt_type.indexOf(product[0])!=-1) {
				productArray.push(product);
				selcount++;//추가한 경우만 갯수증가
			}
		}
		//99상품 추가..
		if(accnt_type.indexOf("99")!=-1) {
			var product = new Array();
			for(i=0;i<5;i++){product.push("99");}
			productArray.push(product);
		}
		inputbox.setAttribute("accnt_no", accnt.substring(0,8));
		if(selIdx==-1) {
			inputbox.value = accnt.substring(0,8);
			selIdx=0;
		}
		inputbox.value = accnt.substring(0,4) + '-' + accnt.substring(4,8);
	
		xmlhttp = null;
		xmlObject = null;
	
		//window.status = res_msg;
		if(res_code=="0") {	
			try{
				if(selectbox!="_NONE"){
					var sel = composeCombo(selectbox, productArray, selIdx);
					if(customFunc!=null) {
						//alert("______________"+customFunc+"('"+name+"','"+socialId+"','"+socialId1+"','"+socialId2+"','"+branchId+"','"+branchName+"','"+sel.value+"','"+sel.name+"','"+sel.opendate+"','"+sel.moddate+"','"+sel.avail+"')");
						eval(customFunc+"('"+name+"','"+socialId+"','"+socialId1+"','"+socialId2+"','"+branchId+"','"+branchName+"','"+sel.value+"','"+sel.name+"','"+sel.opendate+"','"+sel.moddate+"','"+sel.avail+"')");
					}else{
						setProdInfo(name, socialId, socialId1, socialId2, branchId, branchName, sel.value, sel.name, sel.opendate, sel.moddate, sel.avail);
					}
				}else {
					if(customFunc!=null) {
						eval(customFunc+"('"+name+"','"+socialId+"','"+socialId1+"','"+socialId2+"','"+branchId+"','"+branchName+", '', '', '', '', '')");
					}else{
						setProdInfo(name, socialId, socialId1, socialId2, branchId, branchName, '', '', '', '', '');
					}
					selectbox.length=0;
				}
			}catch(e){
				try{selectbox.length=0;}catch(e2){}
			}
			HueCommon.init();
			inputbox.blur();

			//main.jsp 찾기
			_main = top;
			var endless = 0;//무한루프 방지
			while(_main.setCurrentCustomer==null && endless<5) {				
				_main = _main.top.opener;
				endless+=1;
			}
			_main.setCurrentCustomer(null, null, productArray[0][0], null, null);

		}else {
			//window.status = "[계좌목록조회]오류가 발생했습니다.";
			if(customFunc!=null) {
				eval(customFunc+"('', '', '', '', '', '', '', '', '', '', '')");
			}else{
				setProdInfo('', '', '', '', '', '', '', '', '', '', '');
			}
			composeCombo(selectbox, new Array, 0);
		}
	}
}


function composeCombo(selectbox, productArray, selIdx) {
	selectbox.length=0;
	for(i=0; i<productArray.length; i++){
		var prod = productArray[i];
		var obj_opt = document.createElement("option");
		obj_opt.setAttribute("value", prod[0]);
		obj_opt.setAttribute("name", prod[1]);
		obj_opt.setAttribute("opendate", prod[2]);
		obj_opt.setAttribute("moddate", prod[3]);
		obj_opt.setAttribute("avail", prod[4]);
		obj_opt.innerHTML = prod[0];
		selectbox.appendChild(obj_opt);
	}
	try{selectbox.options[selIdx].selected = true;}catch(e){}
	if(selectbox.options.length==0) {
		var prod = productArray[i];
		var obj_opt = document.createElement("option");
		obj_opt.setAttribute("value", "");
		obj_opt.setAttribute("name", "");
		obj_opt.setAttribute("opendate", "");
		obj_opt.setAttribute("moddate", "");
		obj_opt.setAttribute("avail", "");
		obj_opt.innerHTML = "";
		selectbox.appendChild(obj_opt);
	}
	return selectbox.options[selIdx];
}
//선택시 사용되는 함수
function HueCommon.accntSelOnChange(obj_sel) {
	var obj_opt = obj_sel.options[obj_sel.selectedIndex];
	var value = obj_opt.value;
	var name = obj_opt.name;
	var opendate = obj_opt.opendate;
	var moddate = obj_opt.moddate;
	var avail = obj_opt.avail;

	//현재 상품명 main.jsp 에 세팅하기
	//main.jsp 찾기
	_main = top;
	var endless = 0;//무한루프 방지
	while(_main.setCurrentCustomer==null && endless<5) {				
		_main = top.opener;
		endless+=1;
	}
	_main.setCurrentCustomer(null, null, value, null, null);
	try{onChangeFunction(value, name, opendate, moddate, avail);}catch(e){}//각 화면에 정의해두어야 함.
}


//
//
///////////////////////////////////////////////////////////////////////////////
// 함수명 : showTab(index) 
// 내  용 :  선택된 텝의 내용을 보여준다
// Event  : 이미지를 클릭할때 div의 style을 바꿔준다
// Object : 
/////////////////////////////////////////////////////////////////////////////

function HueCommon.showTab(index,tabDiv) { //선택된 텝의 index를 넣어준다.
    if(!tabDiv){
		divs = document.all("tabDiv");	
	}else{ 
		divs = document.all(tabDiv);
	}
	  
	for(var i = 0 ; i < divs.length ; i++)
	{	 	
		if(i == index) {
			divs[i].style.display = "block";
			continue;
		}
		
		divs[i].style.display = "none";
		
	}
}

//
//
///////////////////////////////////////////////////////////////////////////////
// 함수명 : searchUserId() 
// 내  용 : 상담원 정보를 채워준다
// Event  : 
// Object : 
/////////////////////////////////////////////////////////////////////////////
function searchUserList( selectbox ) {
	
	//여기서 xmlHttp 사용하기
	var queryNames = "searchUserInfo";
	//var param = "&user_id="+ userId;
	var xmlhttp = null;
	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	requestUrl = "/jedi/common.user.userList.do?QueryNames="+queryNames;
	xmlhttp.open("GET", requestUrl, false);
	xmlhttp.send(requestUrl);

	//받기
	var resultText = null;
	resultText = xmlhttp.responseText;
	//alert(resultText);
	var xmlObject = null;
	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	xmlObject.loadXML(resultText);

	//결과 가져오기
	var repeat		= "";
	var res_code	= "";
	var user_id		= "";
	var user_name	= "";
	var userArray	= new Array();
	var selIdx		= 0;

	repeat		= xmlObject.documentElement.childNodes.item(0).text;
	res_code	= xmlObject.documentElement.childNodes.item(1).text;
	res_msg		= xmlObject.documentElement.childNodes.item(2).text;

	var index=3;
	for(i=0; i<repeat; i++) {
		var user = new Array();
		for(j=0; j<2; j++) {
			user.push(xmlObject.documentElement.childNodes.item(index++).text);
		}
		userArray.push(user);
	}

//alert(userArray);
	xmlhttp = null;
	xmlObject = null;

	if(res_code == "0") {
		try	{
			if(selectbox != "_NONE") {
				var sel = composeUserList(selectbox, userArray ,selIdx);
			}			
		}catch (e){}
	}else {
		window.status =  res_msg;
	}
}

function composeUserList(selectbox, userArray ,selIdx) {
	selectbox.length = 0;
	var obj_opt = document.createElement("option");
	obj_opt.setAttribute("value", "");
	obj_opt.setAttribute("name", "전체");
	obj_opt.innerHTML = "전체";
	selectbox.appendChild(obj_opt);
	for(i=0; i<userArray.length; i++){
		var user = userArray[i];
		obj_opt = document.createElement("option");
		obj_opt.setAttribute("value", user[0]);
		obj_opt.setAttribute("name", user[1]);
		obj_opt.innerHTML = user[1];
		selectbox.appendChild(obj_opt);
	}
	try{selectbox.options[selIdx].selected = true;}catch(e){}
	return selectbox.options[selIdx];
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : copyCombo(obj, obj)
// 내  용 : 문자열에서 공백을 제거하고 반환한다.
///////////////////////////////////////////////////////////////////////////////
function copyCombo(a, b){
	if(a==null || b==null) return;
	b.length=0;
	for(i=0; i<a.length; i++) {
		var obj_opt = b.document.createElement("option");
		obj_opt.setAttribute("value", a.options[i].value);
		obj_opt.innerHTML = a.options[i].innerHTML;
		b.appendChild(obj_opt);

	}
	try{b.options[a.options.selectedIndex].selected = true;}catch(e){}
}

//***************************************************************************
//*************************  업무 관련 스크립트 함수  ****************************
//***************************************************************************

///////////////////////////////////////////////////////////////////////////////
// 함수명 : openOptionCode() 
// 내  용 : 옵션코드 조회 팝업창 호출
//////////////////////////////////////////////////////////////////////////////
function openOptionCode(target, x, y) {
	var width=10;
	var height=10;
	var url = "/jedi/common.datafile.pmaster.init.do"
				+	"?targetObject="+target
				+	"&x="+x
				+	"&y="+y;

	var winopts = "width="+width+",height="+height
					+  ",toolbar=0,location=0,directories=0,status=1,"
					+  "menubar=0,scrollbars=0,status=0,resizable=0,left=2000,top=2000";//"	+ x + ",top=" + y ;
    var openobj=window.open(url,target,winopts);

	OPEN_OBJECT.push(openobj);
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : openFutureCode() 
// 내  용 : 선물코드 조회 팝업창 호출
//////////////////////////////////////////////////////////////////////////////
function openFutureCode(target, x, y) {
	var width=10;
	var height=10;
	var url = "/jedi/common.datafile.fmaster.init.do"
				+	"?targetObject="+target
				+	"&x="+x
				+	"&y="+y;

	var winopts = "width="+width+",height="+height
					+  ",toolbar=0,location=0,directories=0,status=1,"
					+  "menubar=0,scrollbars=0,status=0,resizable=0,left=2000,top=2000";//"	+ x + ",top=" + y ;
    var openobj=window.open(url,target,winopts);

	OPEN_OBJECT.push(openobj);
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : openKFutureCode() 
// 내  용 : 코스닥 선물코드 조회 팝업창 호출
//////////////////////////////////////////////////////////////////////////////
function openKFutureCode(target, x, y) {
	var width=10;
	var height=10;
	var url = "/jedi/common.datafile.kfmaster.init.do"
				+	"?targetObject="+target
				+	"&x="+x
				+	"&y="+y;

	var winopts = "width="+width+",height="+height
					+  ",toolbar=0,location=0,directories=0,status=1,"
					+  "menubar=0,scrollbars=0,status=0,resizable=0,left=2000,top=2000";//"	+ x + ",top=" + y ;
    var openobj=window.open(url,target,winopts);

	OPEN_OBJECT.push(openobj);
}


///////////////////////////////////////////////////////////////////////////////
// 함수명 : getPwsFromCust() 
// 내  용 : 고객으로부터 비밀번호 받음
//////////////////////////////////////////////////////////////////////////////

function getPwsFromCust(target, accntNo) {
	//메세지창 띄우기
	accntNo = trim(accntNo).replace(/(\,|\.|\-)/g,"");
	if(accntNo.length !=8) {
		window.status="계좌번호 자릿수가 맞지 않습니다(8자리)";
		return;
	}
	
	var width=240;
	var height=160;
	var _top = (screen.height - height) / 2;
	var left = (screen.width - width) / 2;
	var url = "/jedi/teleproIC.requestPassword.init.do";
	var winopts = "width="+width+",height="+height
					+	",top="+_top+", left="+left
					+  ",toolbar=0,location=0,directories=0,status=1,"
					+  "menubar=0,scrollbars=0,status=0,resizable=0";

    var openobj=window.open(url, "", winopts);
	/*
	var url = "/jedi/teleproIC.requestPassword.init.do";
	var winopts = "dialogWidth:240px;dialogHeight:160px; center:yes; help:no; status:no; scroll:yes; resizable:yes";
	var openobj = window.showModalDialog(url, "비밀번호", winopts);
	*/

	//비밀번호 받기
	try{
		top.opener.top.requestPassword(target, openobj, accntNo);
	}catch(e){
		//opener에서 다시 새창을 띄운 경우
		top.opener.top.opener.top.requestPassword(target, openobj, accntNo);
	}
}

function makeExcel(obj) {//alert(obj);
	//make target frame
	if (document.all._ExcelFrame==null) {
		document.body.insertAdjacentHTML("beforeEnd", "<iframe name='_ExcelFrame' style='width:0;height=0';></iframe>");
	}

	document.all.objExcel.value = obj;

	document.forms[0].action = "common.xls.makeExcel.do";
	document.forms[0].method="POST";
	document.forms[0].target = "_ExcelFrame";
	document.forms[0].submit();
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : moneyComma() 
// 내  용 : 금액 콤마 집어넣기
//////////////////////////////////////////////////////////////////////////////
function moneyComma(mValue,chstr,rValue){
	if(!mValue && chstr) return chstr;
	else if(!mValue && !chstr) return '';	
	var sMoney = mValue.replace(/,/g, "");	
	var sMoney2="";
	var mMoney = "";	
	var midxD = sMoney.indexOf('-');	
	if(midxD >=0 ) {
		sMoney = sMoney.replace("-","");		
		mMoney = "-";
	}		
	var idxD = sMoney.indexOf('.');	
	if(idxD >= 0) {		
		sMoney2 = "."+sMoney.substring(idxD+1);
		sMoney = sMoney.substring(0, idxD);	
		sMoney = (sMoney-0)+"";	
	}		
	var tMoney = "";
	var i;
	var j = 0;
	var tLen = sMoney.length;	
	if (sMoney.length > 3){
		for (i = 0; i < tLen; i++) {
			if (i != 0 && (i % 3 == tLen % 3)) tMoney += ",";
			if (i < sMoney.length) tMoney += sMoney.charAt(i);
		}
	}else tMoney = sMoney;	
	mValue = mMoney+tMoney+sMoney2;	
	if(rValue){ 
		rValue.value = mValue;
		return;
	}
	return mValue;
}

///////////////////////////////////////////////////////////////////////////////
// 함수명 : cFormat() 
// 내  용 : 소숫점 집어넣기
//////////////////////////////////////////////////////////////////////////////
function cFormat(mValue,cnt,chstr){
	var ck = true;
	if(!mValue && chstr) return chstr;
	else if(!mValue && !chstr) return '';
	var sMoney = mValue.replace(/,/g, "");
	sMoney = (sMoney-0)+"";	
	var mMoney = "";
	var tMoney = "";
	var i;
	var j = 0;
	var midxD = sMoney.indexOf('-');
	if(midxD >= 0){
		mMoney = "-";
		sMoney = sMoney.replace("-","");
	}	
	var tLen = sMoney.length;	
	var zMoney = "";
	for (i = 0; i <= tLen; i++) {
		if(cnt <= tLen){
			if (ck && tLen-i == cnt){
				tMoney += ".";
				ck = false;
			}
			if (i < sMoney.length) tMoney += sMoney.charAt(i);		
		}else{
			if(i == 0){
				zMoney += "0.";
			}else zMoney += "0";
			if(i == tLen){
				tMoney = zMoney+sMoney;
			}			
		}
	}
	
	mValue = mMoney+tMoney;
	return moneyComma(mValue,chstr);
}

//프린트
function makePrint(obj,titlename) {
	//make target frame
	if (document.all._PrintFrame==null) {
		document.body.insertAdjacentHTML("beforeEnd", "<iframe name='_PrintFrame' style='width:0;height=0';></iframe>");
	}

	if(titlename!=null){
		if (document.all.title==null) {
			document.body.insertAdjacentHTML("beforeEnd", "<div id='title' ><table width='970' border='0' align='center' cellpadding='0' cellspacing='0'><tr><td height=22 align=center style=padding-top:5><strong><font color=#000066>"+titlename+"</font></strong></td></tr></table><br></div>");
			}

		var obj=document.all.title.innerHTML+obj;
	}
	document.all.objExcel.value = obj;
	document.forms[0].action = "common.prt.makePrint.do";
	document.forms[0].method="POST";
	//document.forms[0].target = "_PrintFrame";
	document.forms[0].target = "_blank";
	top._PrintFrame.focus();
	document.forms[0].submit();
	
}

//div scroll 
function moveLeft(th){
	document.all.subTitle.scrollLeft = th.scrollLeft;
}

function movePage(pageNum, buttonFlag, formName ){
	switch(buttonFlag) {
		case 'F' : //처음
					document.all.firstPageNum.value = 1;
					document.all.lastPageNum.value = 0;
					document.all.page.value = 1;
					break;
		case 'P' : //이전
					document.all.firstPageNum.value = pageNum-10;
					document.all.lastPageNum.value = pageNum-1;
					document.all.page.value = document.all.firstPageNum.value;
					break;
		case 'N' : //다음
					document.all.firstPageNum.value = parseInt(pageNum)+1;
					document.all.lastPageNum.value = ((document.all.pageCnt.value - pageNum) > 10) ? parseInt(pageNum)+10 : document.all.pageCnt.value;
					document.all.page.value = document.all.firstPageNum.value;
					break;
		case 'E' : //끝
					var pageCnt = parseInt(document.all.pageCnt.value);
					document.all.firstPageNum.value = pageCnt - 9; //마지막에서 10을 뺀 페이지
					document.all.lastPageNum.value = pageCnt;
					document.all.page.value = document.all.lastPageNum.value;
					break;
		case 'M' :
					if(pageNum > 0) {
						document.all.page.value = pageNum;
					}
					break;
	}

	
	//이동할 페이지에 대한 정보 
	movePageDetail(formName);
	
}

