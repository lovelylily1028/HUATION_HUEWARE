<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String strDate = (String)model.get("strDate");
	String listType = (String)model.get("listType");
	
	//Date 포맷(2013-12-27) 오늘 날짜로 type 마춰주기.
		String StartDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String EndDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>정기점검 사이트등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


/*시작시간 선택시 종료시간(+3)자동선택
 * 2013_05_08(수)shbyeon.
 */
 
function func_Select(){

	var selStart = document.getElementById('Start_Hour');
	var selEnd = document.getElementById('End_Hour');
	var StartIndex = selStart.selectedIndex;

	
	    /* StartHour 선택시 +3 EndHour 셋팅 계산 시작.
	       Start 시간은 현재 23시 즉(index로 23)까지 있다. 24시는 없기때문.
	   	      그러므로 21시 와 틀린 00시~20시 까지의 시간을 EndHour 에 + 3시간 이지만
	       21시 에서의 +3시간이라면 24시 즉 00 시 로 초기화 시켜줘야 하므로 + 0이 됨.
	  	   22시와 23시 도 21시와 마찬가지.
		*/
		if(StartIndex != 21){
		  selEnd.selectedIndex = StartIndex+3; 	
		}
		if(StartIndex == 21){
		  selEnd.selectedIndex = 0;
		}
		if(StartIndex == 22){
			  selEnd.selectedIndex = 1;
		}
		if(StartIndex == 23){
			  selEnd.selectedIndex = 2;
		}
}



function goSave(){
	var frm = document.projectRegist; 
	
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.ReportFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);
	
	if(fileCheckNm(strFileName)> 200){
		alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
		return;
	}

		
//파일명 글자수(byte) 체크		
function fileCheckNm(szValue){
		var tcount=0;
		var tmpStr = new String(szValue);
		var temp = tmpStr.length;
		var onechar;
		for(k=0; k<temp; k++){
			onechar = tmpStr.charAt(k);
			if(escape(onechar).length>4){
				tcount +=2;
				
			}else{
				tcount +=1;
			}
		}
		return tcount;
	}	
	
	if(frm.CompanyCode.value == ""){
		alert("정기점검 대상 사이트를 선택하세요");
		return;
	}
	if(frm.Start_Hour.value == ""){
		alert("점검 시작시간을 선택하세요");
		return;
	}
	if(frm.Start_Minute.value == ""){
		alert("점검 시작시간(분)을 선택하세요");
		return;
	}
	if(frm.End_Hour.value == ""){
		alert("점검 종료시간을 선택하세요");
		return;
	}
	if(frm.End_Minute.value == ""){
		alert("점검 종료시간(분)을 선택하세요");
		return;
	}
	
	var dates = frm.StartDateTime.value;
	var StartDateTimes = dates.replace(/-/g,'');
	frm.pYear1.value = StartDateTimes.substr(0,4);
	frm.pMonth1.value = StartDateTimes.substr(4,2);
	frm.pDay1.value = StartDateTimes.substr(6,2);
	
	frm.StartDateTime.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	var dates = frm.EndDateTime.value;
	var EndDateTimes = dates.replace(/-/g,'');
	frm.pYear5.value = EndDateTimes.substr(0,4);
	frm.pMonth5.value = EndDateTimes.substr(4,2);
	frm.pDay5.value = EndDateTimes.substr(6,2);
	
	frm.EndDateTime.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;
	
	
	var sdate=frm.pYear1.value+frm.pMonth1.value+frm.pDay1.value+frm.Start_Hour.value+frm.Start_Minute.value;
	var edate= frm.pYear5.value+frm.pMonth5.value+frm.pDay5.value+frm.End_Hour.value+frm.End_Minute.value;

	if(sdate>edate){
		alert('시작일이 종료일보다 큽니다.');
		return false;
	}

	
	if(frm.target_year.value == ""){
		alert("대상일자 (년도)를선택하세요");
		return;
	}
	if(frm.target_month.value == ""){
		alert("대상일자 (월)를선택하세요");
		return;
	}
	if(frm.user_nm.value == ""){
		alert("담당자를 선택하세요");
		return;
	}
	if(frm.CustChargeNm.value == ""){
		alert("고객사 담당자를 입력하세요");
		return;
	}
	if(frm.WorkSite.value == ""){
		alert("수행장소를 입력하세요.");
		return;
	}
	if(frm.WorkContents.value == ""){
		alert("수행내용을 입력하세요.");
		return;
	}
	if(frm.ReportFile.value != "" && !isImageFile(frm.ReportFile.value)){
			alert("수행 보고서의  첨부 가능한 파일 유형은 \n PDF, GIF, JPG, TIF, BMP 이상 5종 입니다.");
			return; 				
	}
	frm.StartDateTime.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value+' '+frm.Start_Hour.value+':'+frm.Start_Minute.value;
	frm.EndDateTime.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value+' '+frm.End_Hour.value+':'+frm.End_Minute.value;
	
	frm.TargetMonth.value=frm.target_year.value+frm.target_month.value;
	frm.ChargeID.value = frm.user_id.value;
	frm.FileNm.value = strFileName;
	
	frm.submit();
}



 //대상월 금년/금월 대상으로 자동선택.
window.onload = function(){
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth()+1;
    if(month<10) month = "0" + month;

    var target_year = document.getElementById('target_year');
    var target_month = document.getElementById("target_month");
    
    for(var i=0; i<target_year.options.length; i++){
        if(target_year.options[i].value==year){
            target_year.options[i].selected = true;
            break;
        }
    }
    
    for(var j=0; j<target_month.options.length; j++){
        if(target_month.options[j].value==month){
            target_month.options[j].selected = true;
            break;
        }
    }
}


//특수문자 불가check
function inputCheckSpecial(){
	var strobj = document.projectRegist.CustChargeNm;
	re =/[.,~!@\#$%^&*\()\-=+_{}]/;
	if(re.test(strobj.value)){
		alert("이름에는 한글, 영문 대소문자, 숫자를 이용해 주세요.");
		strobj.value=strobj.value.replace(re,"");
	}
	
}


	/**
	 * 이미지  파일 확장자명 체크
	 *
	 **/
	function isImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp"|| ext == "doc") {
				return true;
			} else {
				return false;
			}
		}
	}
	
	
	  //달력 텍스트 입력창 첫번째.
	  function datepickerInputText1(){
		  var frm = document.projectRegist;	//폼생성
		  var inputDate1;									//프로젝트 시작 예정일 입력 값 가져오기
		  var strY1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 일자만 담기
		  
		  inputDate1 = frm.StartDateTime.value; //프로젝트 시작 예정일에 입력되는 년/월/일
		  
		  if(inputDate1.length == 8){
			  inputDate = $('#calendarData1').val();	//프로젝트 시작 예정일 input에 입력된 값 불러오기.

			  strY1 = inputDate1.substr(0,4); //입력 년도만 나눠서 변수에 담기.
			  strM1 = inputDate1.substr(4,2); //입력 월자만 나눠서 변수에 담기.
			  strD1 = inputDate1.substr(6,2); //입력 일자만 나눠서 변수에 담기.
			  
			 
			  frm.StartDateTime.value = strY1+'-'+strM1+'-'+strD1; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
		  }else if(event.keyCode == 8){
			  //alert('프로젝트 시작 예정일을 정확히 입력해주세요.(ex1900-01-01)');
			  frm.StartDateTime.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  //달력 텍스트 입력창 두번째.
	  function datepickerInputText2(){
		  var frm = document.projectRegist;	//폼생성
		  var inputDate2;									//프로젝트 종료 예정일 입력 값 가져오기
		  var strY2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 일자만 담기

		 inputDate2 = frm.EndDateTime.value; //프로젝트 종료 예정일에 입력되는 년/월/일
		  
		  if(inputDate2.length == 8){
			  inputDate2 = $('#calendarData2').val();	//프로젝트 종료 예정일 input에 입력된 값 불러오기.

			  strY2 = inputDate2.substr(0,4); //입력 년도만 나눠서 변수에 담기.
			  strM2 = inputDate2.substr(4,2); //입력 월자만 나눠서 변수에 담기.
			  strD2 = inputDate2.substr(6,2); //입력 일자만 나눠서 변수에 담기.
			 
			  frm.EndDateTime.value = strY2+'-'+strM2+'-'+strD2; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
			  
		  }else if(event.keyCode == 8){
			  //alert('프로젝트 종료 예정일을 정확히 입력해주세요.(ex1900-01-01)');
			  frm.EndDateTime.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  function dateProgressStatus()
	    {
		var frm = document.projectRegist;		//form
		var startDate = $('#calendarData1').val();		//프로젝트 시작예정 일
		var endDate = $('#calendarData2').val();			//프로젝트 종료예정 일
	        
		/*
		    // FORMAT("-")을 포함한 길이 체크
	        if (startDate.length != 10 || endDate.length != 10){
	        	
	            return null;
	        }

	        // FORMAT("-")이 있는지 체크
	        if (startDate.indexOf("-") < 0 || endDate.indexOf("-") < 0){
	        	
	            return null;
	        }
		*/
	        // 년도, 월, 일로 분리
	        var start_dt = startDate.split("-");
	        var end_dt = endDate.split("-");

	        // 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
	        // Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
	        start_dt[1] = (Number(start_dt[1]) - 1) + "";
	        end_dt[1] = (Number(end_dt[1]) - 1) + "";
		
	        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]); //시작 예정일.(년,월,일)
	        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);		   //종료 예정일.(년,월,일)

	        if(to_dt.getTime() < from_dt.getTime()){
				alert('종료일자보다 시작일자가 큽니다.');
				//시작예정일이 더 클 시 전날 날짜로 초기 날짜 셋팅.
				frm.EndDateTime.value='<%=strDate%>';	
				frm.StartDateTime.value='<%=strDate%>';
				return;
			}
	    }
	
	
	
	
	
	
	
	
	
	
	
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=projectRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}

	function cancle(){
		
		var frm = document.projectRegist;
		if ("P" == frm.listType.value) {
			frm.action='<%= request.getContextPath()%>/B_Project.do?cmd=projectPageList';	
		} else {
			frm.action='<%= request.getContextPath()%>/B_Project.do?cmd=projectPageListAll';
		}		
		frm.submit();

	}
	
//-->
</SCRIPT>
</head>
<body >
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <!-- title -->
  <div class="content_navi">프로젝트지원 &gt; 정기점검</div>
<h3><span>정</span>기점검등록</h3>
  <!-- //title -->

  <!-- con -->
  <div class="con">
  <div class="conTop_area">
 <!-- 필수입력사항텍스트 -->
<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
 <!-- //필수입력사항텍스트 -->
</div>
  
    <form name="projectRegist" method="post" action="<%= request.getContextPath()%>/B_Project.do?cmd=projectRegist" enctype="multipart/form-data">
     <input type = "hidden" name = "curPage" value="<%=curPage%>">
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>">
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
      <input type="hidden" name="TargetMonth">
	  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
	  <input type = "hidden" name = "ChargeID" value="">
	  	  
	 <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>

     <input type = "hidden" name = "pYear5" value=""/>
     <input type = "hidden" name = "pMonth5" value=""/>
     <input type = "hidden" name = "pDay5" value=""/>
     <input type = "hidden" id = "listType" name = "listType" value="<%=listType%>"/>
      
      <fieldset>
		<legend>정기점검등록</legend>
      
      <table class="tbl_type" summary="정기점검등록(고객사, 시작일자, 종료일자, 대상월, 작성자, 담당자, 고객사담당자, 수행장소, 수행내용, 특이사항, 정기점검보고서)">
						
        <caption>점검사이트 상세정보</caption>
        <colgroup>
		<col width="20%" />
		<col width="*" />
		</colgroup>
		<tbody>
         		<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사</label></th>
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							//codeParam.setFirst("전체");
							codeParam.setName("CompanyCode");
							codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A06")); 
						%></td>
			

         		</tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>시작일자</label></th>
          <td><span class="ico_calendar"><input id="calendarData1" name="StartDateTime" class="text" style="width:100px;" value="<%=strDate%>"onkeyup="javascript:datepickerInputText1();  dateProgressStatus();" onchange="javascript:dateProgressStatus();"/></span>&nbsp;&nbsp;시작시간&nbsp;&nbsp;<select name="Start_Hour" id="Start_Hour" title="시간 선택" onchange="javascript:func_Select()">
							<option value='00'>00시</option>
							<option value='01'>01시</option>
							<option value='02'>02시</option>
							<option value='03'>03시</option>
							<option value='04'>04시</option>
							<option value='05'>05시</option>
							<option value='06'>06시</option>
							<option value='07'>07시</option>
							<option value='08'>08시</option>
							<option value='09'>09시</option>
							<option value='10'>10시</option>
							<option value='11'>11시</option>
							<option value='12' selected="selected">12시</option>
							<option value='13'>13시</option>
							<option value='14'>14시</option>
							<option value='15'>15시</option>
							<option value='16'>16시</option>
							<option value='17'>17시</option>
							<option value='18'>18시</option>
							<option value='19'>19시</option>
							<option value='20'>20시</option>
							<option value='21'>21시</option>
							<option value='22'>22시</option>
							<option value='23'>23시</option>
						</select> <select name="Start_Minute" id="Start_Minute" title="분 선택">
							<option value='00'>00분</option>
							<option value='10'>10분</option>
							<option value='20'>20분</option>
							<option value='30'>30분</option>
							<option value='40'>40분</option>
							<option value='50'>50분</option>
						</select>
          </td>
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>종료일자</label></th>
          <td ><span class="ico_calendar"><input id="calendarData2" name="EndDateTime" class="text" style="width:100px;" value="<%=strDate%>"onkeyup="javascript:datepickerInputText2(); dateProgressStatus();" onchange="javascript:dateProgressStatus();"/></span>&nbsp;&nbsp;종료시간&nbsp;&nbsp;<select name="End_Hour" id="End_Hour" title="시간 선택" selected>
							<option value='00'>00시</option>
							<option value='01'>01시</option>
							<option value='02'>02시</option>
							<option value='03'>03시</option>
							<option value='04'>04시</option>
							<option value='05'>05시</option>
							<option value='06'>06시</option>
							<option value='07'>07시</option>
							<option value='08'>08시</option>
							<option value='09'>09시</option>
							<option value='10'>10시</option>
							<option value='11'>11시</option>
							<option value='12' selected="selected">12시</option>
							<option value='13'>13시</option>
							<option value='14'>14시</option>
							<option value='15'>15시</option>
							<option value='16'>16시</option>
							<option value='17'>17시</option>
							<option value='18'>18시</option>
							<option value='19'>19시</option>
							<option value='20'>20시</option>
							<option value='21'>21시</option>
							<option value='22'>22시</option>
							<option value='23'>23시</option>
						</select>
						<select name="End_Minute" id="End_Minute" title="분 선택">
							<option value='00'>00분</option>
							<option value='10'>10분</option>
							<option value='20'>20분</option>
							<option value='30'>30분</option>
							<option value='40'>40분</option>
							<option value='50'>50분</option>
						</select>
            </td>
        </tr>
  
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>대상월</label></th>
         <td>
         <script>
         document.write("<select name='target_year' id='target_year' title='년도 선택'>");
          var now = new Date();  
          var now_year = now.getFullYear(); 
          for (var i=now_year;i>=2002;i--) 
          {   
         document.write("<option value='"+i+"'>"+i+"년</option>"); 
         }  
          document.write(" </select>"); 
         </script> <select name="target_month" id="target_month" title="월 선택">
				    <option value='01'>1월</option>
				    <option value='02'>2월</option>
				    <option value='03'>3월</option>
				    <option value='04'>4월</option>
				    <option value='05'>5월</option>
				    <option value='06'>6월</option>
				    <option value='07'>7월</option>
				    <option value='08'>8월</option>
				    <option value='09'>9월</option>
				    <option value='10'>10월</option>
				    <option value='11'>11월</option>
				    <option value='12'>12월</option>
				</select>

   

	</td>
	</tr>
        <tr>
          <th><label for="">작성자</label></th>
          <td><input type="text" name="" class="text dis" title="작성자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당자</label></th>
          <td><input type="text" name="user_nm" class="text" style="width:200px" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사담당자</label></th>
          <td><input type="text" name="CustChargeNm" value="" onkeyup="inputCheckSpecial()" class="text" style="width:200px;" maxlength="10"  /></td>
        </tr>
         <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>수행장소</label></th>
          <td><input type="text" name="WorkSite" value="" class="text" title="수행장소" style="width:916px;" maxlength="50"  /></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>수행내용</label></th>
          <td><input type="text" name="WorkContents" value="" class="text" title="수행내용" style="width:916px;" maxlength="50"  /></td>
        </tr>
         <tr>
          <th><label for="">특이사항</label></th>
          <td><textarea name="IssueReport" value=""class="text" title="특이사항" style="width:916px;height:41px;" dispName="특이사항 " onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
        </tr>
     		<input type="hidden" name="FileNm" value=""></input>
     	<tr>
          <th><label for="">정기점검보고서</label></th>
          <td>
          <div class="fileUp"><input type="text" class="text" id="file1" title="정기점검보고서" style="width:494px;" />
          	<a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a>
          	<input type="file" name="ReportFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : PDF, GIF, JPG, TIF, BMP / 첨부가능 용량 : 최대 10M</span></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle()" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
   <!-- //button -->
  </div>
  <!-- //con -->
</div>
<!-- //contents -->
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>

<%= comDao.getMenuAuth(menulist,"23") %>
<script type="text/javascript">fn_fileUpload();</script>