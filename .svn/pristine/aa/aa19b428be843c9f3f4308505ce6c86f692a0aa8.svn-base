<%@page import="jsx3.app.Model"%>
<%@page import="com.huation.common.formfile.FormFileDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.projectcodemanage.ProjectCodeManageDTO" %>
<%@ page import ="com.huation.common.user.UserBroker" %>
<%@ page import ="java.text.SimpleDateFormat" %>

<%
	//map 객체 생성. 
	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	ProjectCodeManageDTO pjMgDto = (ProjectCodeManageDTO)model.get("pjMgDto");
	ProjectCodeManageDTO pjMgDto_Cm = (ProjectCodeManageDTO)model.get("pjMgDto_Cm");
	ArrayList arrDataList = (ArrayList)model.get("arrDataList"); 
	
	//프로젝트 시작예정일 초기 셋팅 값.
	String ProjectStartDate = "";
	
	if(pjMgDto.getProjectStartDate().equals("")){
		ProjectStartDate = pjMgDto.getProjectStartDate();
		ProjectStartDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}else{
		ProjectStartDate = pjMgDto.getProjectStartDate();
	}
	
	//프로젝트 종료예정일 초기 셋팅 값.
	String ProjectEndDate = "";
	
	if(pjMgDto.getProjectEndDate().equals("")){
		ProjectEndDate = pjMgDto.getProjectEndDate();
		ProjectEndDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}else{
		ProjectEndDate = pjMgDto.getProjectEndDate();
	}


	 
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>프로젝트코드 상세화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css"></link>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.ProjectCodeManageProgressForm; 
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.CheckDocumentFile.value;
	var strFile2 = frm.ProjectEndDocumentFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var lastIndex2 = strFile2.lastIndexOf('\\');

	var strFileName = strFile.substring(lastIndex+1);
	var strFileName2 = strFile2.substring(lastIndex+1);

	if(fileCheckNm(strFileName)> 200){
		alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
		return;
	}
	if(fileCheckNm(strFileName2)> 200){
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
	
	if(confirm("수정 하시겠습니까?")){	
	//날짜 입력 벨류데이션 체크 시작.
	  var frm = document.ProjectCodeManageProgressForm;   //폼셋팅
	  var inputDate;							 		//종료일자 입력 값 가져오기
	  var strY;									 		//종료일자 입력 값 (-)잘라서 년도만 담기
	  var strM;									 		//종료일자 입력 값 (-)잘라서 월자만 담기
	  var strD;									 		//종료일자 입력 값 (-)잘라서 일자만 담기
	  var strY_Val;										//년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strM_Val;										//월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strD_Val;								 		//일자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  
	  inputDate = frm.ProjectStartDate.value; //종료일자에 입력되는 년/월/일
	
	  strY = inputDate.substring(0,4).split('-'); //입력 년도만 나눠서 변수에 담기.
	  strY_Val = String(strY);//String형변환
	  strM = inputDate.substring(5,7).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strM_Val = String(strM);//String형변환
	  strD = inputDate.substring(8,10).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strD_Val = String(strD);//String형변환	
	  
	
	//숫자가 아닌 String 으로 입력 하였을때.
	if(inputDate.length>0){
		if (!isNumber(trim(inputDate))) {
			alert("종료일자 텍스트 입력 시 (-)제외한숫자만 입력 하세요.");
			inputDate=onlyNum(inputDate);
			frm.ProjectStartDate.value ="";
			return;
			
		}else{
			inputDate=onlyNum(inputDate)
			} 
		}
	//년도 4자리수 미만했을때.
	if(strY_Val.length<4){
		alert('년도는 4자리수 미만 사용 불가능합니다.');
		strY_Val=onlyNum(strY_Val);
		frm.ProjectStartDate.value ="";
		return;
	}else{
		strY_Val=onlyNum(strY_Val);
	}
	//월자 숫자입력으로 안했을때.
	if(strM_Val.length>0){
		if (!isNumber(trim(strM_Val))) {
			alert("월자는 숫자만 입력이 가능합니다.");
			strM_Val=onlyNum(strM_Val);
			frm.ProjectStartDate.value ="";
			return;
			
		}else{
			strM_Val=onlyNum(strM_Val);
				
			} 
		}
	//월자 2자리수 미만 입력했을때.
	if(strM_Val.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		strM_Val=onlyNum(strM_Val);
		frm.ProjectStartDate.value ="";
		return;
	}else{
		strM_Val=onlyNum(strM_Val);
	}
	//일자 숫자입력으로 안했을때.
	if(strD_Val.length>0){
		if (!isNumber(trim(strD_Val))) {
			alert("일자는 숫자만 입력이 가능합니다.");
			strD_Val=onlyNum(strD_Val);
			frm.strD_Val.value ="";
			return;
		
		}else{
			strD_Val=onlyNum(strD_Val);	
			}
		}
	//일자 2자리수 미만 입력했을때.
	if(strD_Val.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		strD_Val=onlyNum(strD_Val);
		frm.ProjectStartDate.value ="";
		return;
	}else{
		strD_Val=onlyNum(strD_Val);
	}
	if(strY_Val.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(strM_Val.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(strM_Val > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.ProjectStartDate.value ="";
		return;
	}else{
		strM_Val=onlyNum(strM_Val);
	}
		
	if(strD_Val.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(strD_Val > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.ProjectStartDate.value ="";
		return;
	}else{
		strD_Val=onlyNum(strD_Val);
	}
	
	frm.ChargeID.value=frm.user_id.value;
	frm.ChargeProjectManager.value=frm.user_id2.value;
	
	if(strFileName != ''){
		frm.CheckDocumentFileNm.value = strFileName;
	}
	if(strFileName2 != ''){
		frm.ProjectEndDocumentFileNm.value = strFileName2;
	}
	
	frm.action='<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgProgressUpdate'
	frm.submit();
	}
}	   
		   
	//취소(목록으로) Button
	function goList(){
		
		var frm = document.ProjectCodeManageProgressForm;
		frm.action='<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Search2';
		frm.submit();
	}	
	
	//초기 페이지 셋팅 값.
	$(function(){
		
		//초기 화면 호출 시 아래 벨류 값 셋팅.
		document.ProjectCodeManageProgressForm.ProgressSelect.value='<%=pjMgDto.getProgressPercent()%>';
		
		//프로젝트 구분 관련.
		var PjDivisionChk = $('[name=ProjectDivision]').val(); //현재 가지고 있는 프로젝트 구분 값 가져오기.
		
		//초기값 증설인 경우.
		if(PjDivisionChk == "B"){
			//$('#PjDivision_td').attr('colspan','1');	//프로젝트 구분 증설 선택 시  colspan = '2'
			$('#PjDivision_CD_th').show();				//프로젝트 구분 증설 선택 시 증설코드 th show
			$('#PjDivision_CD_td').show();				//프로젝트 구분 증설 선택 시 증설코드 td show
			$('#MoreCode').show();						//프로젝트 구분 증설 선택 시 증설코드 name show
			$('#P_ProjectCode').show();					//프로젝트 구분 증설 선택 시 모프로젝트 코드 name show
			//$('#PjDivision_td2').attr('colspan','1');	//프로젝트 구분 증설 선택 시  colspan = '2'
			$('#PjDivision_NM_th').show();				//프로젝트 구분 증설 선택 시 모 프로젝트 명 th show
			$('#PjDivision_NM_td').show();				//프로젝트 구분 증설 선택 시 모프로젝트 명 td show
			$('#P_ProjectName').show();					//프로젝트 구분 증설 선택 시 모프로젝트 명 name show
		
			//초기값 증설 아닌 경우.
		}else{	
			$('#PjDivision_CD_th').hide();				//프로젝트 구분 증설 선택 시 증설코드 th hide
			$('#PjDivision_CD_td').hide();				//프로젝트 구분 증설 선택 시 증설코드 td hide
			//$('#PjDivision_td').attr('colspan','4');	//프로젝트 구분 초기 colspan = '4'
			$('#MoreCode').hide();						//프로젝트 구분 증설 선택 시 증설코드 name hide
			$('#P_ProjectCode').hide();					//프로젝트 구분 증설 선택 시 모프로젝트 코드 name hide
			//$('#PjDivision_td2').attr('colspan','4');	//프로젝트 구분 초기 colspan = '4'
			$('#PjDivision_NM_th').hide();				//프로젝트 구분 증설 선택 시 모 프로젝트 명 th hide
			$('#PjDivision_NM_td').hide();				//프로젝트 구분 증설 선택 시 모프로젝트명 td hide
		}
		
		//프로젝트구분(유상,무상) 관련.
		var ctcVal1 = $('[name=FreeCostYN]').val();
		
		if(ctcVal1 == "Y"){
			$('#FreeCostChk_Y').attr("checked",true);
		}else{
			$('#FreeCostChk_N').attr("checked",true);
		}
		
		//계약코드 관련.
		var ctcVal2 = $('[name=ContractCodeYN]').val();
		
		if(ctcVal2 == "Y"){
			$('#ctc_Cnt_Y').val(2);						//계약코드 사용이면 value 값 2셋팅.(radio버튼 사용 클릭 시 스크립트 중복호출 방지.)
			$('#CtcMainTable').show();					//계약코드 메인 테이블 Show
		}else{
			$('#CtcMainTable').hide();					//계약코드 메인 테이블 Hide
		}
		
		disableCheckYN();		//검수완료 여부 스크립트 호출.	
	});
	
	   //달력 생성 두번째.
	   $(function(){
	   	$('#ProjectEndDate').datepicker({
	   		showAnim:'slideDown', 		//애니메이션 효과 옵션 =>( show(default),slideDown,fadeIn,blind,bounce,clip,drop,fold,slide,"")
	   		//altField: '#ProjectStartDate',
	   		//altFormat: "yyyy-mm-dd",
	   		showOn:"button",
	   		buttonImage:'images/sub/icon_calendar.gif',
	   		buttonImageOnly:false,
	   		showOtherMonths: true,		//지난달 일자보기
	   		selectOtherMonths: true,	//지난달 일자 선택하기
	   		showButtonPanel : true,		//하위 버튼 Today,취소
	   		changeMonth: true,			//월 선택하기 활성화
	   		changeYear:	true,			//년 선택하기 활성화
	   		dateFormat : "yy-mm-dd",		//년-월-일 포맷.
	   		currentText: 'Today' , // 오늘 날짜로 이동하는 버튼 패널
	   		closeText: 'Close',  // 닫기 버튼 패널
	   		nextText: '다음 달', // next 아이콘의 툴팁.
	     	prevText: '이전 달', // prev 아이콘의 툴팁.
	   		showMonthAfterYear: true , 	// 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	   	  	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식.
	   		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
	   	 	//yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.		   	
			
	   	});
	   });

	  
	  //달력 텍스트 입력창 두번째.
	  function datepickerInputText2(){
		  var frm = document.ProjectCodeManageProgressForm;	//폼생성
		  var inputDate2;									//프로젝트 종료 예정일 입력 값 가져오기
		  var strY2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 일자만 담기

		 inputDate2 = frm.ProjectEndDate.value; //프로젝트 종료 예정일에 입력되는 년/월/일
		  
		  if(inputDate2.length == 8){
			  inputDate2 = $('#ProjectEndDate').val();	//프로젝트 종료 예정일 input에 입력된 값 불러오기.

			  strY2 = inputDate2.substr(0,4); //입력 년도만 나눠서 변수에 담기.
			  strM2 = inputDate2.substr(4,2); //입력 월자만 나눠서 변수에 담기.
			  strD2 = inputDate2.substr(6,2); //입력 일자만 나눠서 변수에 담기.
			 
			  frm.ProjectEndDate.value = strY2+'-'+strM2+'-'+strD2; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
			  
		  }else if(event.keyCode == 8){
			  //alert('프로젝트 종료 예정일을 정확히 입력해주세요.(ex1900-01-01)');
			  frm.ProjectEndDate.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  function projectNameReadOnly(){
		  var checkYN = $('input[name="readOnly"]').is(":checked");
		  
		  if(checkYN == true){
			  $('[name="ProjectName"]').attr("readOnly", true);				//프로젝트명 readOnly 체크박스 체크 시 input text readOnly
			  $('[name="ProjectName"]').css('background','#EEEECC');		//프로젝트명 readOnly 체크박스 체크 시 input box background 변경
			  $('[name="readOnly"]').val('Y');								//프로젝트명 readOnly 체크박스 체크 시 input value = 'Y'
		  }else{
			  $('[name="ProjectName"]').attr("readOnly", false); 			//프로젝트명 readOnly 체크박스 체크 시 input text readOnly
			  $('[name="ProjectName"]').css('background','');				//프로젝트명 readOnly 체크박스 체크 시 input box background 초기값.
			  $('[name="readOnly"]').val('N');								//프로젝트명 readOnly 체크박스 체크 시 input value = 'N'
		  }
	  }
	  
	//프로젝트 시작 예정일 종료예정일 계산하여 진행기간 나타내기.
	  function dateProgressStatus(){
		var frm = document.ProjectCodeManageProgressForm;
		var startDate = new Date($('#ProjectStartDate').val());		//프로젝트 시작예정 일
		var endDate = new Date($('#ProjectEndDate').val());			//프로젝트 종료예정 일
		var dateGap = endDate.getTime()-startDate.getTime(); 		//시작일자 종료일자 차이 구하기.(종료일자 - 시작일자 = 프로젝트 진행기간)
		var progressDate = Math.floor(dateGap / (1000*60*60*24));	//진행기간(일수)구하기.
	
		
		
		if(endDate.getTime() < startDate.getTime()){
			alert('프로젝트 종료예정일보다 시작예정일이 큽니다.');
			//프로젝트 시작예정일이 더 클 시 금일 날짜로 초기 날짜 셋팅.
			frm.ProjectEndDate.value='<%=ProjectEndDate%>';	
			frm.ProjectStartDate.value='<%=ProjectStartDate%>';
			//프로젝트 진행 기간 초기화 = 0;
			frm.ProjectProgressDate.value=0;
			return;
		}else{		
		frm.ProjectProgressDate.value = progressDate;
		}
	  }
	
	  //사원조회 두 번째
	  function popSales_Second(){
	  	window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=ProjectCodeManageProgressForm","","width=600,height=450,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	  }
	
	  function ProgressSetter(){
		  var selected_val = $("#ProgressSelect option:selected").val();	 //jquery select Value Read(프로젝트 구분)
		  $('[name=ProgressPercent]').val(selected_val);
	  }
	  
	  //검수 완료 여부 체크.
	  function disableCheckYN(){
		  var frm =document.ProjectCodeManageProgressForm;
		  var chk = frm.CheckSuccessChkYN.checked;	//검수완료 여부.
		  
		  if(chk == true){
			  $('[name=CheckSuccessYN]').val('Y'); //검수완료 name Value 셋팅. ="Y"
			  $('[name=CheckDocumentFile]').attr("disabled",false);			//검수완료 체크 시 파일 첨부가능.
			  $('[name=ProjectEndChkYN]').attr("disabled",false);				//검수완료 체크 시 프로젝트 종료 여부 체크 가능.
		  }else{	
			  $('[name=CheckSuccessYN]').val('N');	//검수완료 name Value 셋팅. ="N"
			  $('[name=CheckDocumentFile]').attr("disabled",true);			//검수완료 체크 안할 시 파일 첨부 불가.
			  $('[name=ProjectEndChkYN]').attr("disabled",true);					//검수완료 체크 안할 시 프로젝트 종료 여부 체크 불가.
			  $('[name=ProjectEndDocumentFile]').attr("disabled",true);		//검수완료 체크 안할 시 프로젝트 종료 파일 첨부 불가.
			  $('[name=ProjectEndYN]').val('N');
			  $("input:checkbox[name='ProjectEndChkYN']").attr("checked",false);	//검수완료 체크 해제 시 프로젝트 종료 체크 해제.
			   //input file <<파일 객체는 value 초기화를 할수 없다. html상 readonly값으로 되있기 때문.
			   //초기화 방법은 select();객체를 사용하여 해당 selection.clear()로 초기화가능.
			   document.ProjectCodeManageProgressForm.CheckDocumentFile.select();
			   document.selection.clear();  						//검수완료 체크 안할 시 기존에 셋팅되었던 파일 경로 값 초기화.

		  }
	  }
	  
	  //프로젝트 공식 종료 여부 체크.
	  function disableCheckYN_Pj(){
		  var frm =document.ProjectCodeManageProgressForm;
		  var chk = frm.ProjectEndChkYN.checked;	//검수완료 여부.
		  
		  if(chk == true){
			  $('[name=ProjectEndYN]').val('Y');	//프로젝트 종료 여부 name Value 셋팅. ="Y"
			  $('[name=ProjectEndChkYN]').attr("disabled",false);				//검수완료 체크 시 프로젝트 종료 여부 체크 가능.
			  $('[name=ProjectEndDocumentFile]').attr("disabled",false);	//검수완료 체크 안할 시 프로젝트 종료 파일 첨부 가능.
			  alert("프로젝트를 공식 종료하여 수정하면 더 이상 본 프로젝트에 대하여 편집이 불가합니다.");
			  return;
		  }else{	
			  $('[name=ProjectEndYN]').val('N');	//프로젝트 종료 여부 name Value 셋팅. ="N"
			  $('[name=ProjectEndDocumentFile]').attr("disabled",true);		//검수완료 체크 안할 시 프로젝트 종료 파일 첨부 불가.
			   //input file <<파일 객체는 value 초기화를 할수 없다. html상 readonly값으로 되있기 때문.
			   //초기화 방법은 select();객체를 사용하여 해당 selection.clear()로 초기화가능.
			   document.ProjectCodeManageProgressForm.ProjectEndDocumentFile.select();
			   document.selection.clear();  								//검수완료 체크 안할 시 기존에 셋팅되었던 파일 경로 값 초기화.

		  }
	  }
	  
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
<!-- container -->
<div id="container">

<!-- contents -->
<div id="content">
  <!-- title -->
  <div class="content_navi">프로젝트지원 &gt; 프로젝트조회</div>
  <h3><span>프</span>로젝트코드진행관리</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
  <!-- //title -->
  <!-- con -->
  <div class="con">
  	<div class="conTop_area">
		<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	</div>
	<form name="ProjectCodeManageProgressForm" method="post" action="" enctype="multipart/form-data">
		<input type="hidden" name="curPage" value="<%=curPage%>"/>
		<!-- 수정 시 넘겨줄 프로젝트 시퀀스 PK -->
		<input type="hidden" name="PjSeq" value="<%=pjMgDto.getPjSeq() %>"></input>
		<!-- 담당영업 -->
		<input type = "hidden" name = "user_id" value="<%=pjMgDto.getChargeID()%>"></input>
		<input  type="hidden" name="ChargeID" value="<%=pjMgDto.getChargeID()%>"></input>
		<!-- 담당PM -->
		<input type = "hidden" name = "user_id2" value="<%=pjMgDto.getChargeProjectManager()%>"></input>
		<input  type="hidden" name="ChargeProjectManager" value="<%=pjMgDto.getChargeProjectManager()%>"></input>
	
		<table class="tbl_type" summary="프로젝트코드진행관리(프로젝트코드, 프로젝트구분, 증설코드, 발주사구분, 선택된모프로젝트명, 견적번호, 선택된견적서프로젝트명, 계약코드, 프로젝트명, 고객사명(End User), 발주사명, 프로젝트시작예정일, 프로젝트종료예정일, 프로젝트진행기간, 담당영업, 담당PM, 영업Comments, 진행률, 검수완료여부, 검수증빙문서, 프로젝트공식종료, 프로젝트최종산출물첨부)">
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트코드</label></th>
				<td><input type="text" name="ProjectCode" id="" maxlength="10" class="text dis" title="프로젝트코드" style="width:200px;" readonly="readonly" value="<%=pjMgDto.getProjectCode() %>"/></td>
			</tr> 
			<tr>
				<%
					//프로젝트 구분 셋팅.
					String ProjectDivision = pjMgDto.getProjectDivision();	//객체셋팅.
					String Division_Pj_View = "";
				%>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트구분</label></th>
				
				
				<td>
				<input type="hidden" id="PjDivision_td" title="프로젝트구분" name="ProjectDivision" value="<%=pjMgDto.getProjectDivision()%>" /> 
					<%
					if(ProjectDivision.equals("A")){
						Division_Pj_View = "A-신규";
					%>
					<!-- 프로젝트 구분 뷰잉 -->
					<input class="text dis" type="text" name="ProjectDivision_View" value="<%=Division_Pj_View%>" style="width:200px;" readonly="readonly" /><%
					}else if(ProjectDivision.equals("B")){
						Division_Pj_View = "B-증설";
					%>
					<!-- 프로젝트 구분 뷰잉 -->
					<input class="text dis" type="text" name="ProjectDivision_View" value="<%=Division_Pj_View%>" style="width:200px;" readonly="readonly" /><%
					}else if(ProjectDivision.equals("C")){
						Division_Pj_View = "C-유지보수";
					%>
					<!-- 프로젝트 구분 뷰잉 -->
					<input class="text dis" type="text" name="ProjectDivision_View" value="<%=Division_Pj_View%>" style="width:200px;" readonly="readonly" />
					<%} %><%
					//프로젝트 구분(유상,무상)여부
						String fcYN = pjMgDto.getFreeCostYN();
						String Checked_Y_Fc = "";
						String Checked_N_Fc = "";
						
						if(fcYN.equals("Y")){
							Checked_Y_Fc = "checked";
						}else if(fcYN.equals("N")){
							Checked_N_Fc = "checked";
						}
					%><input type="radio" id="FreeCostChk_Y" class="radio" title="유상" name="FreeCostChk" value="Y" <%=Checked_Y_Fc %> disabled="disabled" onclick="javascript:freeCostCheckYN();" /><label for="FreeCostChk_Y">유상</label><input type="radio" id="FreeCostChk_N" class="radio" title="무상" name="FreeCostChk" value="N" <%=Checked_N_Fc %> disabled="disabled" onclick="javascript:freeCostCheckYN();" /><label for="FreeCostChk_N">무상</label><input type="hidden" name="FreeCostYN" value="<%=pjMgDto.getFreeCostYN()%>"></input>
				</td>
				
				
			</tr>
			
			<tr>
				<th id="PjDivision_CD_th"><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>증설코드</label></th>
				<td id="PjDivision_CD_td">				
					<input class="text dis" title="증설코드" type="text" id="MoreCode" name="MoreCode" style="width:200px;" readOnly value="<%=pjMgDto.getMoreCode()%>"></input>
					<input type="hidden" id="P_ProjectCode" name="P_ProjectCode" class="in_txt" value="<%=pjMgDto.getP_ProjectCode() %>" style="width:100px;" readonly="readonly"></input>
				</td>
			</tr>
			
			<tr>
				<%
					//발주사 구분 셋팅.
					String PurchaseDivision = pjMgDto.getPurchaseDivision();	//객체셋팅.							
					String Division_Pc_View = "";
				%>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사구분</label></th>
				<td id="PjDivision_td2">
				<input type="hidden" title="발주사구분" name="PurchaseDivision" value="<%=pjMgDto.getPurchaseDivision()%>"></input>
				<%
				if(PurchaseDivision.equals("1")){
					Division_Pc_View = "1(End User)";
				%>
				<input type="text" class="text dis" name="PurchaseDivision_View" value="<%=Division_Pc_View%>" style="width:200px;" readonly="readonly"></input>
				<%
				}else if(PurchaseDivision.equals("2")){
					Division_Pc_View = "2(하도급)";
				%>
				<input type="text" class="text dis" name="PurchaseDivision_View" value="<%=Division_Pc_View%>" style="width:200px;" readonly="readonly"></input>
				<%
				}
				%>
				</td>
			</tr>
			<tr>	
				<th id="PjDivision_NM_th"><label for="">선택된모프로젝트명</label></th>
				<td id="PjDivision_NM_td"><input type="text" class="text dis_none" title="선택된모프로젝트명" id="P_ProjectName" name="P_ProjectName" value="<%=pjMgDto.getP_ProjectName() %>" style="width:917px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적번호</label></th>
				<td><input type="text" id="" class="text dis" title="견적번호" style="width:200px;" value="<%=pjMgDto.getPublic_No() %>" readonly="readonly" /></td>
			</tr>
			<tr>
				<th><label for="">선택된견적서프로젝트명</label></th>
				<td><input type="text" class="text dis_none" title="선택된견적서프로젝트명" name="Pub_ProjectName" value="<%=pjMgDto.getPub_ProjectName() %>" style="width:917px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<th><label for="">계약코드</label></th>
				<td class="listT01" id="CtcYN">
					<dl>						
						<dt>
						<!--
						<input class="in_txt_off" type="text" name="ContractCode" value="" style="width:70px" readonly="readonly"></input>
	     				<a href="javascript:popContractNo();" ><img src="<%= request.getContextPath()%>/images/btn_srch_contract.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_contract_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_contract.gif'" width="70" height="19" title="계약서 찾기" /></a>
						-->
						<%
							String CtcdYN = pjMgDto.getContractCodeYN();
							String Checked_Y = "";
							String Checked_N = "";
							
							if(CtcdYN.equals("Y")){
								Checked_Y = "checked";
							}else if(CtcdYN.equals("N")){
								Checked_N = "checked";
							}
						%>
						<input class="radio md0" type="radio" id="CtcdYN" name="CtcdYN" value="Y" <%=Checked_Y %> disabled="disabled" onclick="javascript:noneContractColum();" /><label for="">사용</label><input class="radio" type="radio" id="CtcdYN" name="CtcdYN" value="N" <%=Checked_N %> disabled="disabled" onclick="javascript:noneContractColum();" /><label for="">미사용</label><input type="hidden" name="ContractCodeYN" value="<%=pjMgDto.getContractCodeYN() %>"></input>
						</dt>
						<!-- 계약코드 사용 시 추가 되는 테이블 -->		
						<dd id="CtcMainTable">		
							<table class="tbl_type" summary="계약코드(계약코드, 선택된견적서프로젝트명)">
								<caption>계약코드</caption>								
								<colgroup>
									<col width="25%" />
									<col width="*" />
								</colgroup>
								<thead>
									<tr>
										<th>계약코드</th>
										<th class="last">선택된견적서프로젝트명</th>
									</tr>
								</thead>
								<!-- 계약코드 미사용 일 경우. -->
								<%if(CtcdYN.equals("N")){ %>
								<tbody id="CtCd_Main_tbody">
								</tbody>
								<!-- 계약코드 사용 일 경우. -->
								<%}else{ %>
								<tbody id="CtCd_Main_tbody">
								<%
	       						for(int x=0; x<arrDataList.size(); x++){
	       							pjMgDto_Cm = new ProjectCodeManageDTO();
	       							pjMgDto_Cm = (ProjectCodeManageDTO)arrDataList.get(x);
								%>
								<tr id="param_tr_<%=pjMgDto_Cm.getSortID() %>">
									<td><input class="text dis" type="text" id="paramCtCd_<%=pjMgDto_Cm.getSortID() %>" name="ContractCode" value="<%=pjMgDto_Cm.getContractCode() %>" style="width:197px;"  readonly="readonly" /></td>
									<td class="last"><input type="text" class="text dis_none" id="paramPjNm_<%=pjMgDto_Cm.getSortID() %>" name="Con_ProjectName" value="<%=pjMgDto_Cm.getCon_ProjectName() %>" style="width:677px;" readonly="readonly" /></td>
									<!-- 넘겨줄 정렬순서 -->
									<input type="hidden" name="SortID" value="<%=pjMgDto_Cm.getSortID()%>"></input>
								</tr>
									<%} %>
								</tbody>
								<%} %>
							</table>
						</dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트명</label></th>
				<td><input type="text" id="" class="text dis" title="프로젝트명" style="width:917px;" name="ProjectName" value="<%=pjMgDto.getProjectName()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사명(End User)</label></th>
				<td><input type="text" id="" class="text dis" title="고객사명(End User)" style="width:200px;" name="CustomerName" value="<%=pjMgDto.getCustomerName()%>" readonly="readonly"/></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사명</label></th>
				<td><input type="text" id="" class="text dis" title="발주사명" style="width:300px;" name="PurchaseName" value="<%=pjMgDto.getPurchaseName()%>" readonly="readonly"/></td>
			</tr>
			<tr>
			
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트시작예정일</label></th>
				<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" style="width:100px;" class="text dis" title="프로젝트시작예정일입력"  name="ProjectStartDate" id="calendarData1" maxlength="8" value="<%=ProjectStartDate%>" readonly="readonly" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01)</span></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트종료예정일</label></th>
				<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" style="width:100px;" class="text dis" title="프로젝트종료예정일입력" name="ProjectEndDate" id="calendarData2" maxlength="8" value="<%=ProjectEndDate%>" readonly="readonly" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트진행기간</label></th>
				<td><input type="text" id="" class="text dis" title="프로젝트진행기간" name="ProjectProgressDate" style="width:50px;" readonly="readonly" value="<%=pjMgDto.getProjectProgressDate()%>" /> 일</td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
				<td><input type="text" id="" class="text dis" title="담당영업" style="width:200px;" name="user_nm" readonly="readonly" value="<%=pjMgDto.getChargeNm()%>" /></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당PM</label></th>
				<td><input type="text" id="" class="text dis" title="담당PM" style="width:200px;" name="user_nm2" readonly="readonly" value="<%=pjMgDto.getChargePmNm()%>" /></td>
			</tr>
			<tr>
				<th><label for="">영업Comments</label></th>
				<td><textarea id="" title="영업Comments" class="dis" style="width:917px;height:96px;" name="ChargeComent" dispName="영업 Comments " onKeyUp="js_Str_ChkSub('5000', this)" readonly="readonly"><%=pjMgDto.getChargeComent() %></textarea></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>진행률</label></th>
				<td>
						 <script>
				         document.write("<select name='ProgressSelect' id='ProgressSelect' onchange='ProgressSetter();' disabled='disabled' class='dis'>");
				         var progress_Cnt = 101;
				          for (var i=0;i<progress_Cnt;i++) 
				          {   
				         document.write("<option value='"+i+"'>"+i+"%</option>"); 
				         }  
				          document.write(" </select>"); 
         				</script><span class="guide_txt">&nbsp;&nbsp;* 본 프로젝트의 완료된 진행률</span>
         				<!-- 프로젝트 진행률 DB에 넘겨줄 name. -->
         				<input type="hidden" name="ProgressPercent" value="<%=pjMgDto.getProgressPercent()%>"></input>
				</td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>검수완료여부</label></th>
				<td>
				<%
					String checked = "";
					String disabled = "";
					if(pjMgDto.getCheckSuccessYN().equals("Y")){
						checked = "checked";
					}else{
						checked = "";
					}
				%>
				<input class="check md0" type="checkbox" name="CheckSuccessYN_View" value="<%=pjMgDto.getCheckSuccessYN() %>" <%=checked %> disabled="disabled"/><label for="">검수 완료</label></td>
			</tr>
			<tr>
				<th><label for="">검수증빙문서</label></th>
				<td><div class="fileUp"><input type="text" class="text dis" id="file1" title="검수증빙문서" style="width:848px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="CheckDocumentFile_View" id="upload1" disabled="disabled" /></div><input type="hidden" name="CheckDocumentFileNm" value="" style="width:929px;" ></input></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트공식종료</label></th>
				<td>
				<%
					if(pjMgDto.getProjectEndYN().equals("Y")){
						checked = "checked";
						disabled="";
					}else{
						checked = "";
						disabled="disabled='disabled'";
					}
				%>
				<input class="check md0" type="checkbox" name="ProjectEndYN_View" value="<%=pjMgDto.getProjectEndYN() %>" <%=checked %> disabled="disabled"/><label for="">종료 확인</label></td>
				</tr>
				<tr>
				<th><label for="">프로젝트최종산출물첨부</label></th>
				<td><div class="fileUp"><input type="text" class="text dis" id="file2" title="프로젝트최종산출물첨부" style="width:849px;" disabled="disabled" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="ProjectEndDocumentFile_View" id="upload2" disabled="disabled" /></div><input type="hidden" name="ProjectEndDocumentFileNm" value="" style="width:929px;" ></input></td>	
			</tr>
			</tbody>
		</table>
		<!-- button -->
		<div class="Bbtn_areaC"><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
		<!-- //button -->
	</form>
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
<%= comDao.getMenuAuth(menulist,"20") %>
<script type="text/javascript">fn_fileUpload();</script>