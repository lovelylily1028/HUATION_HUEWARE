/*********************************************************************
 * This software was developed and owned by Locus
 * Illeger use of this software will violate the Copy Right Law
 *********************************************************************
 * Program Name : HueCalendar.js
 * Function description :
 * Programmer Name : Daniel Shim (jbshim@locus.com)
 * Creation Date : 2004.02.18
 * Method List :
 *********************************************************************
 *              PROGRAM HISTORY
 *********************************************************************
 * DATE :           PROGRAMMER :                       REASON :
 */
var todayYear = "";
var todayMonth = "";
var todayDate = "";
var todayDay = "";
var inYear = "";
var inMonth = "";
var inDate = "";
var iStart = 0;
var iEnd = 0;
var iDate = 1;
var iLimit = 0;
var arrDate = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
var arrMonth = new Array('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월');
var arrDay = new Array('일','월','화','수','목','금','토');
var arrHoliday;
var nowDate = new Date();
var setDateType = "";

function HueCalendar(){}

function HueCalendar.setType(type){
	setDateType = type;
}
//year setting part
function HueCalendar.setYear(sYear){
	if(sYear != 'now'){
		todayYear = sYear;
	} else {
		todayYear = nowDate.getYear();
	}
}
function HueCalendar.getYear(){
	return todayYear;
}
//month setting part
function HueCalendar.setMonth(sMonth){
	if ((parseInt(HueCalendar.getYear(),10) % 4 == 0 && parseInt(HueCalendar.getYear(),10) % 100 != 0) || parseInt(HueCalendar.getYear(),10) % 400 == 0) {
		arrDate[1] = 29;
	}
	if(sMonth != 'now'){
		todayMonth = sMonth;
	} else {
		todayMonth = nowDate.getMonth();
	}
}
function HueCalendar.getMonth(){
	return todayMonth;
}
//date setting part
function HueCalendar.setDate(sDate){
	if(sDate != 'now'){
		todayDate = sDate;
	} else {
		todayDate = nowDate.getDate();
	}
}
function HueCalendar.getDate(){
	return todayDate;
}
//day setting part
function HueCalendar.setDay(sDay){
	if(sDay != 'now'){
		todayDay = sDay;
	} else {
		todayDay = nowDate.getDay();
	}
}
function HueCalendar.getDay(){
	return todayDay;	
}
//Decision of Start Date
function HueCalendar.setStNum(){
	iEnd = arrDate[parseInt(HueCalendar.getMonth(),10)];
	tempDate = new Date(HueCalendar.getYear(),HueCalendar.getMonth(),1);
        iStart = tempDate.getDay();
        if((iStart > 4 && iEnd > 30) || (iStart > 5 && iEnd > 29)){
        	iLimit = 7;
        } else {
        	iLimit = 6;
        }
}
//holiday setting part
function HueCalendar.setHoliday(hCount){//Setting the Banking Holiday
	//arrHoliday = new Array()
}
function HueCalendar.getHoliday(){
	
}
//tultip message part(about holiday or another message)
function HueCalendar.setTultip(){

}
function HueCalendar.getTultip(){
	
}
//Calendar Display part
function HueCalendar.initialize(){
	HueCalendar.setYear("now");
	HueCalendar.setMonth("now");
	HueCalendar.setDate("now");
	HueCalendar.setDay("now");
	HueCalendar.setStNum();
	inYear = HueCalendar.getYear();
	inMonth = HueCalendar.getMonth();
	inDate = HueCalendar.getDate();
}
//Indicate today's date
function HueCalendar.indicateToday(){
	var todayColor = "";
	tempYear = HueCalendar.getYear();
	tempMonth = HueCalendar.getMonth();
	//tempDate = getDate();

	if((inYear == tempYear) && (inMonth == tempMonth) && (inDate == iDate)){
		todayColor = "bgcolor='#99FF44'";
	} else {
		todayColor = "bgcolor='#e6e6e6'";
	}
	return todayColor;
}
//Changing Date
function HueCalendar.changeInitialize(mm){
	var tempMonth = 0;

	tempMonth = parseInt(HueCalendar.getMonth(),10)+parseInt(mm,10);
	if(tempMonth > 11){
		tempMonth = 0;
		HueCalendar.setYear(parseInt(HueCalendar.getYear(),10)+1);
	} else if(tempMonth < 0){
		tempMonth = 11;
		HueCalendar.setYear(parseInt(HueCalendar.getYear(),10)-1);
	} else {
		HueCalendar.setYear(parseInt(HueCalendar.getYear(),10));	
	}

	HueCalendar.setMonth(tempMonth);
	HueCalendar.setDate("now");
	HueCalendar.setDay("now");
	HueCalendar.setStNum();
}
//selected date return part
function HueCalendar.getSelectedDate(selectedDate,indexI,indexJ){
	var vMonth = "";
	var seqValue = ((indexI-1)*7)+(indexJ+1);
	if((parseInt(iStart,10) < parseInt(seqValue,10)) && (parseInt(iEnd,10) >= parseInt(selectedDate,10))){
		if(selectedDate.toString().length < 2)	selectedDate = "0"+selectedDate;
		vMonth = (parseInt(HueCalendar.getMonth(),10)+1);
		if(vMonth.toString().length < 2)		vMonth = "0"+vMonth;
		var checkResult = changeDateValueOrder();
		var sDate = "";
		for(t=0;t<checkResult.length;t++){
			if(trim(checkResult).charAt(t) == "y"){
				sDate += HueCalendar.getYear();
			} else if(trim(checkResult).charAt(t) == "m"){
				sDate += vMonth;
			} else {
				sDate += selectedDate;
			}
		}
		HueCalendar.changeCalendarType(setDateType,sDate);
		HueCalendar.closeCal();
	}
}

function changeDateValueOrder(){
	var compareValue = "ymd";
	var tempResultCompare = "";
	var bridgeTemp = "";
 	for(i=0;i<trim(setDateType).length;i++){
 		if(compareValue.indexOf(trim(setDateType).charAt(i)) != -1){//There is something which is not number
 			if(tempResultCompare.length == 0){
 				bridgeTemp = trim(setDateType).charAt(i);
 				tempResultCompare += trim(setDateType).charAt(i);
 			} else {
 				if(bridgeTemp != trim(setDateType).charAt(i)){
 					tempResultCompare += trim(setDateType).charAt(i);
 					bridgeTemp = trim(setDateType).charAt(i);
 				}
 			}
 		}
 	}
 	return tempResultCompare;
}

function HueCalendar.changeCalendarType(type,newDateValue){
	var arrCalendarType = new Array(2);
	var arrCalendarValue = new Array(4);
	var resultCalendarValue = "";

	arrCalendarType = HueCalendar.catchDelimeter('ymd',type);
	arrCalendarValue = HueCalendar.checkCalendarValidate(type,arrCalendarType[0],newDateValue);

	if(arrCalendarValue[0] != "Error"){
		if(HueCalendar.isValidYMD(arrCalendarValue)){
			insertTargetField(arrCalendarValue[3]);
		}
	} else {
		insertTargetField(arrCalendarValue[0]);
	}
}

function HueCalendar.isValidYMD(data){
	var YMDResult = "";

	if(parseInt(data[0],10) < 1000 || parseInt(data[1],10) > 9999){
		YMDResult = false;
	} else {
		if(parseInt(data[1],10) < 0 || parseInt(data[1],10) > 12){
			YMDResult = false;
		} else {
			var endofMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
			if ((parseInt(data[0],10) % 4 == 0 && parseInt(data[0],10) % 100 != 0) || parseInt(data[0],10) % 400 == 0) {
				endofMonth[1] = 29;
			}
		
			if(parseInt(data[2],10) >= 1 && parseInt(data[2],10) <= endofMonth[(parseInt(data[1],10) - 1)]){
				YMDResult = true;
			} else {
				YMDResult = false;
			}
		}
	}
	return YMDResult;
}

function HueCalendar.terminateDelimiter(newDelimiter, targetValue){
 	var terminatedValue = "";

	for(i=0;i<trim(targetValue).length;i++){
		if(newDelimiter.indexOf(trim(targetValue).charAt(i)) == -1){
			terminatedValue += trim(targetValue).charAt(i);
		}
	}

	return terminatedValue;
}

function HueCalendar.isNumber(objValue){
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

function HueCalendar.catchDelimeter(typeValue,newDelimeterValue){
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

 function HueCalendar.checkCalendarValidate(changingType,newDelimiter,changingValue){
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

	targetValue = HueCalendar.terminateDelimiter(newDelimiter,changingValue);
	if(HueCalendar.isNumber(targetValue)){
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
	}
	
	return changedValue;
 }

function HueCalendar.closeCal(){
	window.close();
}

//Error or Advice Message
function HueCalendar.showMessage(){
	
}

function trim(targetStr){
	var eliminateStr = /\s+/g;
	return targetStr.replace(eliminateStr,"");
}

//Back Ground Color Setting
function HueCalendar.changeBGColor(divColor){
	var bgCol = "";
	if(divColor == '일'){
		bgCol = "#FF0000";
	} else if(divColor == '토'){
		bgCol = "#0000FF";
	} else {
		bgCol = "#32638B";
	}
	return bgCol;
}
//Character Color Setting
function HueCalendar.changeFontColor(divColor){
	var ftCol = "";
	if(divColor == 0){
		ftCol = "#FF0000";
	} else if(divColor == 6){
		ftCol = "#0000FF'";
	} else {
		ftCol = "";
	}
	return ftCol;
}
//Setting the Date Number
function HueCalendar.writeDate(iFor,jFor){
	var returnValue = 0;
	var seqValue = 0;

	seqValue = ((iFor-1)*7)+(jFor+1);
	if(seqValue > iStart){
		returnValue = iDate;
		iDate++;
		if(iDate > (iEnd+1)){
			returnValue = "&nbsp;";
		}
	} else {
		returnValue = "&nbsp;";
	}

	return returnValue;
}
// This Function get The Number
 function HueCalendar.getOnlyNumber(objValue){
	var eliminateNum = "1234567890";
	var tempNumber = "";
	
	for(i=0;i<trim(objValue).length;i++){
		if(eliminateNum.indexOf(trim(objValue).charAt(i)) != -1){//There is something which is not number
			tempNumber += trim(objValue).charAt(i);
		}
	}

	return tempNumber;
 }

/**
* 2004-08-28 : 전종성수정(년도,월 선택조회 가능하도록 수정시작)
**/

//clear option
function HueCalendar.clearSelectOptions(object)
{
	
	for(var i = object.options.length - 1 ; i >= 0 ; i--) 
	{
		object.options.remove(i);
	}
}
//add option
function HueCalendar.addSelectOption(object, value, text)
{
	option = document.createElement("OPTION");
	option.text = text;
	option.value = value;
	
	object.options.add(option);
}
//select year option setting
function HueCalendar.selectYear(obj){

			for(var i = 1995 ; i < nowDate.getYear()+4 ; i++)//년도는 1995년부터 현재년도 보다 3년후까지 SELECT BOX에 보이게 한다.
				{
					HueCalendar.addSelectOption(obj,i,i+'년');
										
				}	

			for(var i= 0 ; i < obj.options.length ; i++){	

				if(obj.options[i].value==HueCalendar.getYear())
					{
						obj[i].selected=true;
					}
			}
}
//select date option setting
function HueCalendar.selectMonth(obj){

            for(var i = 0 ; i < 12 ; i++)
				{
					HueCalendar.addSelectOption(obj,HueCalendar.getOnlyNumber(arrMonth[i]),arrMonth[i]);

					if(obj.options[i].text==arrMonth[parseInt(HueCalendar.getMonth(),10)])
					{
						obj[i].selected=true;
					}
				}			
}
//change year
function HueCalendar.changeYear(obj){
		
		HueCalendar.setYear(obj.options.value);
		HueCalendar.changeDateHTML(0);
}
//change date
function HueCalendar.changeDate(obj){
	    var selectmonth=obj.options.value;
		var presentmonth=HueCalendar.getOnlyNumber(arrMonth[parseInt(HueCalendar.getMonth(),10)]);
		HueCalendar.changeDateHTML(selectmonth-presentmonth);
}
//changing calednar's date part
function HueCalendar.changeDateHTML(mv){
	var dateContents = "";
	HueCalendar.changeInitialize(mv);
	changeYear.innerHTML ='<div style="position:relative;width:80px;height:16px;" class=input1><div style="position:absolute;left:-2px;top:-3px;width:80px;height:16px;clip:rect(3,800,16,2);"> <select name="year_option2" class="pulld1" style=width:80; onChange="HueCalendar.changeYear(document.Frm.year_option2)"><option value="1">&nbsp;&nbsp;'+HueCalendar.getYear()+'년</option></select></div></div>';
	changeYearMonth.innerHTML = '<div style="position:relative;width:55px;height:16px;" class=input1><div style="position:absolute;left:-2px;top:-3px;width:55px;height:16px;clip:rect(3,800,16,2);"><select name="month_option2" class="pulld1" style=width:55; onChange="HueCalendar.changeDate(document.Frm.month_option2)"></select></div></div>';
    HueCalendar.clearSelectOptions(document.Frm.year_option2);
	HueCalendar.selectYear(document.Frm.year_option2);
	HueCalendar.selectMonth(document.Frm.month_option2);
	dateContents = '<table border="0" cellpadding="1" cellspacing="1" class="bd">';
	for(i=0;i<iLimit;i++){
		dateContents += '<tr align="center">';
		for(j=0;j<7;j++){
			if(i == 0){
				dateContents += '<td width="26" bgcolor="'+HueCalendar.changeBGColor(arrDay[j])+'" class="day">';
				dateContents += '<strong><font color="#FFFFFF">'+arrDay[j]+'</font></strong></td>';
			} else {
				dateContents += '<td '+HueCalendar.indicateToday()+' onClick="HueCalendar.getSelectedDate('+iDate+','+i+','+j+')" style="cursor:hand">';
				dateContents += '<font color="'+HueCalendar.changeFontColor(j)+'">'+HueCalendar.writeDate(i,j)+'</font>';
				dateContents += '</td>';
			}
		}
		dateContents += '</tr>';
	}
	dateContents += '</table>';
	changeDate.innerHTML = dateContents;
	iDate = 1;
}
//Date Setting when calendar is loaded first
function HueCalendar.dateDisplay(){
		document.clear();
		document.write('<form name="Frm">');
        document.write('<table width="206" border="0" cellspacing="1" cellpadding="1"><tr>');
        document.write('<td align="right"><a href="javascript:HueCalendar.changeDateHTML('+"'-1'"+')"><img src="/images/btn_cpr.gif" width="23" height="18" border="0" align="absmiddle"></a>&nbsp;</td>');
        document.write('<td width="80" align="center"><span id="changeYear"><div style="position:relative;width:80px;height:16px;" class=input1><div style="position:absolute;left:-2px;top:-3px;width:80px;height:16px;clip:rect(3,800,16,2);"> <select name="year_option" class="pulld1" style=width:80; onChange="HueCalendar.changeYear(document.Frm.year_option)"></select></div></div></span></td>');
        document.write('<td width="55" align="center"><span id="changeYearMonth"><div style="position:relative;width:55px;height:16px;" class=input1><div style="position:absolute;left:-2px;top:-3px;width:55px;height:16px;clip:rect(3,800,16,2);"> <select name="month_option" class="pulld1" style=width:55; onChange="HueCalendar.changeDate(document.Frm.month_option)"></select></div></div></span></td>');
		document.write('<td>&nbsp;<a href="javascript:HueCalendar.changeDateHTML('+"'1'"+')"><img src="/images/btn_cnx.gif" width="23" height="18" border="0" align="absmiddle"></a></td>');
        document.write('</tr>');
        document.write('<tr>');
        document.write('<td align="right" height=5></td>');
        document.write('<td align="center"></td>');
        document.write('<td></td>');
        document.write('</tr>');
        document.write('</table>');
        
		HueCalendar.selectYear(document.Frm.year_option);
        HueCalendar.selectMonth(document.Frm.month_option);

	document.write('<span id="changeDate"><table border="0" cellpadding="1" cellspacing="1" class="bd">');
	for(i=0;i<iLimit;i++){		
		document.write('<tr align="center">')
		for(j=0;j<7;j++){
			if(i == 0){
				document.write('<td width="26" bgcolor="'+HueCalendar.changeBGColor(arrDay[j])+'" class="day">');
				document.write('<strong><font color="#FFFFFF">'+arrDay[j]+'</font></strong></td>');
			} else {
				document.write('<td '+HueCalendar.indicateToday()+' onClick="HueCalendar.getSelectedDate('+iDate+','+i+','+j+')" style="cursor:hand">');
				document.write('<font color="'+HueCalendar.changeFontColor(j)+'">'+HueCalendar.writeDate(i,j)+'</font>');
				document.write('</td>');
			}
		}
		document.write('</tr>');
	}
	    document.write('</table></span>');
  	    document.write('<table width="206" border="0" cellspacing="0" cellpadding="0">');
    	document.write('<tr><td height=10></td></tr>');
    	document.write('<tr><td ><div align="center">');
    	document.write('<img src="/images/btn_close.gif" width="70" height="18" border="0" style="cursor:hand" onClick="HueCalendar.closeCal()"></div></td>');
    	document.write('</tr></table>');

		document.write('</form>');
	    document.close();
	iDate = 1;
}

/**
* 2004-08-28 : 전종성수정(년도,월 선택조회 가능하도록 수정끝)
**/

HueCalendar.initialize();
HueCalendar.dateDisplay();