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
//Date 포맷(2013-12-27) 오늘 날짜로 type 마춰주기.
	String ProjectStartDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String ProjectEndDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

	
	String ProjectCode = "(ex:PJA1000001)";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>프로젝트코드 등록화면</title>
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.ProjectCodeManageRegistForm; 
	
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.ProjectProgressFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');

	var strFileName = strFile.substring(lastIndex+1);

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

	if(frm.ProjectCode.value == "PJ--"){
		alert("프로젝트를 조합하세요.");
		return;
	}
	
	if(frm.ProjectDivision.value == "-"){
		alert("프로젝트 구분을 선택하세요.");
		return;
	}
	
	if(frm.PurchaseDivision.value == "-"){
		alert("발주사 구분을 선택하세요.");
		return;
	}

	//프로젝트 구분 증설인 경우 시작.
	var selected_val = $("#SelectBox1 option:selected").val();	 //jquery select Value Read(프로젝트 구분)
	
	if(selected_val == "B"){
		if(frm.MoreCode.value == ""){
			alert("프로젝트 구분이 증설인 경우 모프로젝트를 선택하여 증설코드를 입력하셔야 합니다.");
			return;
		}	
	}
	var chkCost = $("#PjDivision_td input:checked").val();	//프로젝트 구분 유상,무상 체크여부.
	
	if(chkCost == "Y"){	
		if(frm.Public_No.value == ""){
			alert("견적서 찾기 버튼 선택 후 해당 견적서를 선택하세요.");
			return;
		}
	}
	
	var chk = $("#CtcYN input:checked").val();	//계약코드 사용 미사용 체크여부.

	//계약코드 사용 일 경우 체크.
	if(chk == "Y"){
		var ctcd_val_chk = $('#paramCtCd_'+paramCnt).val(); //계약코드 추가된 행(ContractCode) 갯수만큼의 아이디의 벨류값을 가져온다.
		
		//초기 디폴트 계약코드 벨류 값 체크
		if(frm.ContractCode.value == ""){
			alert("계약서 찾기 버튼 선택 후 해당 견적서를 선택하세요.");
			return;
		}
		//증가된 행의 계약코드 벨류 값 체크.
		if(ctcd_val_chk == ""){
			alert("계약서 찾기 버튼 선택 후 해당 견적서를 선택하세요.");
			return;
		}
	}
	
	if(frm.ProjectName.value == ""){
		alert("프로젝트 명을 입력하세요.");
		return;
	}
	
	if(frm.CustomerName.value == ""){
		alert("고객사 명을 입력하세요.");
		return;
	}
	
	if(frm.PurchaseName.value == ""){
		alert("발주사 명을 입력하세요.");
		return;
	}
	
	//날짜 입력 벨류데이션 체크 시작.
	  var frm = document.ProjectCodeManageRegistForm;   //폼셋팅
	  var inputDate;							 		//시작일자 입력 값 가져오기
	  var strY;									 		//시작일자 입력 값 (-)잘라서 년도만 담기
	  var strM;									 		//시작일자 입력 값 (-)잘라서 월자만 담기
	  var strD;									 		//시작일자 입력 값 (-)잘라서 일자만 담기
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
			frm.ProjectProgressDate.value=0;
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
		frm.ProjectProgressDate.value=0;
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
			frm.ProjectProgressDate.value=0;
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
		frm.ProjectProgressDate.value=0;
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
		frm.ProjectProgressDate.value=0;
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
		frm.ProjectProgressDate.value=0;
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
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strD_Val=onlyNum(strD_Val);
	}
	
	//날짜 입력 벨류데이션 체크 시작.
	  var inputDate1;							 			//종료일자 입력 값 가져오기
	  var strY1;									 		//종료일자 입력 값 (-)잘라서 년도만 담기
	  var strM1;									 		//종료일자 입력 값 (-)잘라서 월자만 담기
	  var strD1;									 		//종료일자 입력 값 (-)잘라서 일자만 담기
	  var strY_Val1;										//년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strM_Val1;										//월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strD_Val1;								 		//일자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  
	  inputDate1 = frm.ProjectEndDate.value; //종료일자에 입력되는 년/월/일
	
	  
	  strY1 = inputDate1.substring(0,4).split('-'); //입력 년도만 나눠서 변수에 담기.
	  strY_Val1 = String(strY1);//String형변환
	  strM1 = inputDate1.substring(5,7).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strM_Val1 = String(strM1);//String형변환
	  strD1 = inputDate1.substring(8,10).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strD_Val1 = String(strD1);//String형변환	
	  
	
	//숫자가 아닌 String 으로 입력 하였을때.
	if(inputDate1.length>0){
		if (!isNumber(trim(inputDate))) {
			alert("종료일자 텍스트 입력 시 (-)제외한숫자만 입력 하세요.");
			inputDate1=onlyNum(inputDate1);
			frm.ProjectEndDate.value ="";
			frm.ProjectProgressDate.value=0;
			return;
			
		}else{
			inputDate1=onlyNum(inputDate1)
			} 
		}
	//년도 4자리수 미만했을때.
	if(strY_Val1.length<4){
		alert('년도는 4자리수 미만 사용 불가능합니다.');
		strY_Val1=onlyNum(strY_Val1);
		frm.ProjectEndDate.value ="";
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strY_Val1=onlyNum(strY_Val1);
	}
	//월자 숫자입력으로 안했을때.
	if(strM_Val1.length>0){
		if (!isNumber(trim(strM_Val1))) {
			alert("월자는 숫자만 입력이 가능합니다.");
			strM_Val1=onlyNum(strM_Val1);
			frm.ProjectEndDate.value ="";
			frm.ProjectProgressDate.value=0;
			return;
			
		}else{
			strM_Val1=onlyNum(strM_Val1);
				
			} 
		}
	//월자 2자리수 미만 입력했을때.
	if(strM_Val1.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		strM_Val1=onlyNum(strM_Val1);
		frm.ProjectEndDate.value ="";
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strM_Val1=onlyNum(strM_Val1);
	}
	//일자 숫자입력으로 안했을때.
	if(strD_Val1.length>0){
		if (!isNumber(trim(strD_Val1))) {
			alert("일자는 숫자만 입력이 가능합니다.");
			strD_Val1=onlyNum(strD_Val1);
			frm.strD_Val1.value ="";
			return;
		
		}else{
			strD_Val1=onlyNum(strD_Val1);	
			}
		}
	//일자 2자리수 미만 입력했을때.
	if(strD_Val1.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		strD_Val1=onlyNum(strD_Val1);
		frm.ProjectEndDate.value ="";
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strD_Val1=onlyNum(strD_Val1);
	}
	if(strY_Val1.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(strM_Val1.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(strM_Val1 > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.ProjectEndDate.value ="";
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strM_Val1=onlyNum(strM_Val1);
	}
		
	if(strD_Val1.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(strD_Val1 > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.ProjectEndDate.value ="";
		frm.ProjectProgressDate.value=0;
		return;
	}else{
		strD_Val1=onlyNum(strD_Val1);
	}
	
	/*
	if(frm.ProjectProgressFile.value == ""){
		alert("프로젝트 진행문서를 첨부하세요.");
		return;
	}
	*/
	
	frm.ProjectProgressFileNm.value = strFileName;
	frm.ChargeID.value=frm.user_id.value;
	frm.ChargeProjectManager.value=frm.user_id2.value;
	
	frm.submit();

}	   
		   
	//견적서 발행번호 조회(계약=Y 건만)
	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_Pj&sForm=ProjectCodeManageRegistForm&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}
	//계약서 코드번호 조회(진행중인 건만)
	function popContractNo(paramCtCd,paramPjNm){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchContractNoConN_Pj&sForm=ProjectCodeManageRegistForm&CtCd_tr_Cnt="+paramCtCd+"&PjNm_tr_Cnt="+paramPjNm+"","","width=1400,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}
	
	//취소 Button
	function cancle(){
		
		var frm = document.ProjectCodeManageRegistForm;
		frm.action='<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit';
		frm.submit();

	}	
	
	function ProjectDivision_Selected(){
		var frm = document.ProjectCodeManageRegistForm;
		var selected_val;
		var ProjectCode = "";
		selected_val = $("#SelectBox1 option:selected").val();	 //jquery select Value Read(프로젝트 구분)
		selected_val1 = $("#SelectBox2 option:selected").val();	 //jquery select Value Read(발주사 구분)
		
		frm.ProjectDivision.value = selected_val;				 //select option(프로젝트 구분)으로 선택 한 해당 Value값 Action으로 넘겨줄 Hidden Name에 Value에 셋팅.
		frm.PurchaseDivision.value = selected_val1;				 //select option(발주사 구분)으로 선택 한 해당 Value값 Action으로 넘겨줄 Hidden Name에 Value에 셋팅.
		
		//프로젝트 코드 <= 프로젝트 구분 값 조합 부분.
		frm.ProjectCode.value = "PJ"+selected_val+'-';			 //프로젝트 코드 초기 값에서 프로젝트 구분으로 선택 된 값 조합해서 Name Value 셋팅.
		
		//프로젝트 코드 <= 발주사 구분 값 조합 부분.
		frm.ProjectCode.value = "PJ"+selected_val+selected_val1; //프로젝트 코드 초기 값에서 프로젝트 구분+발주사 구분으로 선택 된 값 조합해서 Name Value 셋팅.
		ProjectCode = "PJ"+selected_val+selected_val1;
		$.ajax({
			url : "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeCreate",
			type : "post",
			dataType : "text",
			async : false,
			data : {
				 "ProjectCode" : ProjectCode,
				
			}, 
		 	success : function(ProjectCode, textStatus, XMLHttpRequest){
						$('#ProjectCode').val(ProjectCode);
			},
			error : function(ProjectCode, status, error){
				alert("오류!");
			} 
		});
		
		//프로젝트 구분이 증설인 경우
		if(selected_val == "B"){
/* 			$('#PjDivision_td').attr('colspan','1');	//프로젝트 구분 증설 선택 시  colspan = '2' */
			$('#PjDivision_CD_th').show();				//프로젝트 구분 증설 선택 시 증설코드 th show
			$('#PjDivision_CD_td').show();				//프로젝트 구분 증설 선택 시 증설코드 td show
			$('#MoreCode').show();						//프로젝트 구분 증설 선택 시 증설코드 name show
			$('#P_ProjectCode').show();					//프로젝트 구분 증설 선택 시 모프로젝트 코드 name show
/* 			$('#PjDivision_td2').attr('colspan','1');	//프로젝트 구분 증설 선택 시  colspan = '2' */
			$('#PjDivision_NM_th').show();				//프로젝트 구분 증설 선택 시 모 프로젝트 명 th show
			$('#PjDivision_NM_td').show();				//프로젝트 구분 증설 선택 시 모프로젝트 명 td show
			$('#P_ProjectName').show();					//프로젝트 구분 증설 선택 시 모프로젝트 명 name show
		}else{
/* 			$('#PjDivision_td').attr('colspan','4');	//프로젝트 구분 증설 선택(x)  colspan = '4' */
			$('#PjDivision_CD_th').hide();				//프로젝트 구분 증설 선택(x) 증설코드 th hide
			$('#PjDivision_CD_td').hide();				//프로젝트 구분 증설 선택(x) 증설코드 td hide
			$('#MoreCode').hide();						//프로젝트 구분 증설 선택(x) 증설코드 name hide
			$('#MoreCode').val('');						//프로젝트 구분 증설 선택(x) 증설코드 name value = '' 초기화
			$('#P_ProjectCode').hide();					//프로젝트 구분 증설 선택(x) 모프로젝트 코드 name hide
			$('#P_ProjectCode').val('');				//프로젝트 구분 증설 선택(x) 모프로젝트 코드 name  value = '' 초기화
/* 			$('#PjDivision_td2').attr('colspan','4');	//프로젝트 구분 증설 선택(x)  colspan = '4' */
			$('#PjDivision_NM_th').hide();				//프로젝트 구분 증설 선택 시   모 프로젝트 명 th hide
			$('#PjDivision_NM_td').hide();				//프로젝트 구분 증설 선택 시   모프로젝트 명 td show
			$('#P_ProjectName').hide();					//프로젝트 구분 증설 선택(x) 모프로젝트 명 name hide	
			$('#P_ProjectName').val('');				//프로젝트 구분 증설 선택(x) 모프로젝트 명 name  value = '' 초기화
		}
	}
	
	//초기 페이지 셋팅 값.
	$(function(){
		//프로젝트 구분 관련.
		$('#PjDivision_CD_th').hide();				//프로젝트 구분 증설 선택 시 증설코드 th hide
		$('#PjDivision_CD_td').hide();				//프로젝트 구분 증설 선택 시 증설코드 td hide
/* 		$('#PjDivision_td').attr('colspan','4');	//프로젝트 구분 초기 colspan = '4' */
		$('#MoreCode').hide();						//프로젝트 구분 증설 선택 시 증설코드 name hide
		$('#P_ProjectCode').hide();					//프로젝트 구분 증설 선택 시 모프로젝트 코드 name hide
/* 		$('#PjDivision_td2').attr('colspan','4');	//프로젝트 구분 초기 colspan = '4' */
		$('#PjDivision_NM_th').hide();				//프로젝트 구분 증설 선택 시 모 프로젝트 명 th hide
		$('#PjDivision_NM_td').hide();				//프로젝트 구분 증설 선택 시 모프로젝트명 td hide
		
		//계약코드 관련.
		//$('#CtcMainTable').hide();					//계약코드 메인 테이블 Hide
		
	});
		
	//발주사 == 고객사 동일선택 버튼 2013_12_27(금)shbyeon.
	function chkCustomerNameAdd(){
		var frm = document.ProjectCodeManageRegistForm; 

		if(frm.CustomerName.value==""){
			alert('고객사 명을 입력하셔야 사용 가능합니다.');
			frm.chkYN.checked=false; //checkbox 풀어주기.
			return;
			
		}else{
			//체크박스 선택 시 셋팅.
			if(frm.chkYN.checked==true){
		   	frm.PurchaseName.value = frm.CustomerName.value;		
			//체크박스 해제 시 초기화.
			}else{
			frm.chkYN.checked==false;
			frm.PurchaseName.value = '';
			}
		}
	}
	
	   //달력 생성 첫번째.
	   $(function(){
	   	$('#ProjectStartDate').datepicker({
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
	   
	  //달력 텍스트 입력창 첫번째.
	  function datepickerInputText1(){
		  var frm = document.ProjectCodeManageRegistForm;	//폼생성
		  var inputDate1;									//프로젝트 시작 예정일 입력 값 가져오기
		  var strY1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 일자만 담기
		  
		  inputDate1 = frm.ProjectStartDate.value; //프로젝트 시작 예정일에 입력되는 년/월/일
		  
		  if(inputDate1.length == 8){
			  inputDate = $('#calendarData1').val();	//프로젝트 시작 예정일 input에 입력된 값 불러오기.

			  strY1 = inputDate1.substr(0,4); //입력 년도만 나눠서 변수에 담기.
			  strM1 = inputDate1.substr(4,2); //입력 월자만 나눠서 변수에 담기.
			  strD1 = inputDate1.substr(6,2); //입력 일자만 나눠서 변수에 담기.
			 
			  frm.ProjectStartDate.value = strY1+'-'+strM1+'-'+strD1; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
		  }else if(event.keyCode == 8){
			  //alert('프로젝트 시작 예정일을 정확히 입력해주세요.(ex1900-01-01)');
			  frm.ProjectStartDate.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  //달력 텍스트 입력창 두번째.
	  function datepickerInputText2(){
		  var frm = document.ProjectCodeManageRegistForm;	//폼생성
		  var inputDate2;									//프로젝트 종료 예정일 입력 값 가져오기
		  var strY2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD2;										//프로젝트 종료 예정일 입력 값 (-)잘라서 일자만 담기

		 inputDate2 = frm.ProjectEndDate.value; //프로젝트 종료 예정일에 입력되는 년/월/일
		  
		  if(inputDate2.length == 8){
			  inputDate2 = $('#calendarData2').val();	//프로젝트 종료 예정일 input에 입력된 값 불러오기.

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
			  $('[name="ProjectName"]').css('background','#edf5ef');		//프로젝트명 readOnly 체크박스 체크 시 input box background 변경
			  $('[name="readOnly"]').val('Y');								//프로젝트명 readOnly 체크박스 체크 시 input value = 'Y'
		  }else{
			  $('[name="ProjectName"]').attr("readOnly", false); 			//프로젝트명 readOnly 체크박스 체크 시 input text readOnly
			  $('[name="ProjectName"]').css('background','');				//프로젝트명 readOnly 체크박스 체크 시 input box background 초기값.
			  $('[name="readOnly"]').val('N');								//프로젝트명 readOnly 체크박스 체크 시 input value = 'N'
		  }
	  }
	  
	  <%-- IE버전 10만 사용가능.javascript Date 타입 이상함.
	//*프로젝트 시작 예정일 종료예정일 계산하여 진행기간 나타내기.
	  function dateProgressStatus(){
		
		var frm = document.ProjectCodeManageRegistForm;
		//var startDate = new Date($('#ProjectStartDate').val());		//프로젝트 시작예정 일
		var startDate = frm.ProjectStartDate.value;		//프로젝트 시작예정 일
		var gg = startDate.getTime();
		//var endDate = new Date($('#ProjectEndDate').val());			//프로젝트 종료예정 일
		//var dateGap = endDate.getTime()-startDate.getTime(); 		//시작일자 종료일자 차이 구하기.(종료일자 - 시작일자 = 프로젝트 진행기간)
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
	--%>

	function dateProgressStatus()
	    {
		var frm = document.ProjectCodeManageRegistForm;		//form
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

	        var progressDate = (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24; //진행기간(일수)구하기(종료일자 - 시작일자 = 프로젝트 진행기간.)
	        
	        if(to_dt.getTime() < from_dt.getTime()){
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


	
	  //사원조회 첫 번째	
	  function popSales(){
	  	window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=ProjectCodeManageRegistForm","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	  }
	  //사원조회 두 번째
	  function popSales_Second(){
	  	window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=ProjectCodeManageRegistForm","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	  }
	  
	  //모 프로젝트 코드 조회
	  function popProjectCode(){
		 window.open("<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=p_projectCodeSearch&sForm=ProjectCodeManageRegistForm","","width=1400,height=631,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no"); 
	  }
	  
	  var ctc_Cnt=0; //계약코드 사용여부 (1.사용,2.미사용)
	  //계약코드 사용여부
	  function noneContractColum(){
		  var chk = $("#CtcYN input:checked").val();	//계약코드 사용 미사용 체크여부.
		  var chkY_Cnt = $('#ctc_Cnt_Y').val(); 		//계약코드 스크립트 중복 호출 방지.
		  var chkN_Cnt = $('#ctc_Cnt_N').val(); 		//계약코드 스크립트 중복 호출 방지.
		  var appendString = "";	//html append 변수
		 
		  if(chkY_Cnt == 1){
		  //사용
		  	if(chk == "Y"){
		  		chkY_Cnt = $('#ctc_Cnt_Y').val(2);		//중복호출 방지를 위한 Value 값 2셋팅.
		  		chkN_Cnt = $('#ctc_Cnt_N').val(1);		//중복호출 방지를 위한 Value 값 1셋팅.
		  		$('[name=ContractCodeYN]').val('Y');	//계약코드 사용 값 Y셋팅
		  		$('[name=SortID]').remove();			//사용 미사용 일 플래그 변경 시 초기에 삭제시킴.
		  		$('#CtcMainTable').show();				//계약코드 메인 테이블 Show
				
				//초기 디폴트 계약코드 입력 창 생성.
				appendString += "<tr id='param_tr_"+paramCnt+"'>";
				appendString += "<td id='param_2td_"+paramCnt+"'>";
				appendString += "<input class='text dis' type='text' id='paramCtCd_"+paramCnt+"' name='ContractCode' value='' style='width:122px;' readonly />";
				appendString += "<a id='pop_ct_a_"+paramCnt+"' href=\"javascript:popContractNo('paramCtCd_"+paramCnt+"','paramPjNm_"+paramCnt+"');\" class='btn_type03'>";
				appendString += "<span>계약서조회</span>";
				appendString += "</a>";
				appendString += "</td>";
				appendString += "<td id='param_3td_"+paramCnt+"'>";
				appendString += "<input class='text' type='text' id='paramPjNm_"+paramCnt+"' name='Con_ProjectName' value='' style='width:98%;border:0;background-color:transparent;' readonly />";
				appendString += "</td>";
				appendString += "<td id='param_4td_"+paramCnt+"' class='last text_c'>";
				appendString += "<input type='hidden' name='SortID' value='1'/>";
				appendString += "</td>";
				appendString += "</tr>";
				
				//행 추가
				$("#CtCd_Main_tbody").append(appendString);
		  	}	
		  }
		  if(chkN_Cnt == 1){
		  	//미사용
		    if(chk == "N"){
		  		chkY_Cnt = $('#ctc_Cnt_Y').val(1); 		//중복호출 방지를 위한 Value 값 1셋팅.
		  		chkN_Cnt = $('#ctc_Cnt_N').val(2); 		//중복호출 방지를 위한 Value 값 2셋팅.
		  		$('[name=ContractCodeYN]').val('N');	//계약코드 사용 값 N셋팅
		  		$('#CtcMainTable').hide();				//계약코드 메인 테이블 Hide
		  		$('[name=ContractCodeName]').val('');	//계약코드 전체 name value='' 셋팅.
		  		$('#CtCd_Main_tbody tr').remove();		//계약코드 전체  tr 삭제.
		  		$('#CtCd_Main_tbody td').remove();		//계약코드 전체  td 삭제.
		  		$('#pop_ct_a').remove();				//계약서 찾기 전체 a 링크 삭제.
		  		$('#delete_a').remove();				//삭제 전체 a 링크 삭제.
		  		$('[name=SortID]').remove();			//정렬 순서 전체 input 삭제.
		  	}
	  	}
	  }
		  
		
	    //계약코드 메인 테이블 tr삭제
		function delete_tr(tr_id,cmct,pjnm,pop_ct_a){
	    	
			$('#'+tr_id).remove();								//해당 계약코드 메인 테이블 해당 tr 삭제.
			$('#'+cmct).remove();								//해당 계약코드 input 삭제.
			$('#'+pjnm).remove();								//해당 프로젝트명 input 삭제.
			$('#'+pop_ct_a).remove();							//해당 계약서 찾기 a태그 삭제.
			
			$('[name=ProjectName]').val('');					//해당 프로젝트 삭제 시 상위 프로젝트명으로 셋팅.(우선초기화.)
			$('[name="ProjectName"]').attr("readOnly", false); 	//프로젝트명 readOnly 체크박스 체크 시 input text readOnly
			$('[name="ProjectName"]').css('background','');		//프로젝트명 readOnly 체크박스 체크 시 input box background 초기값.
			$('[name="readOnly"]').val('N');					//프로젝트명 readOnly 체크박스 체크 시 input value = 'N'
			$("input:checkbox[name='readOnly']").attr("checked",false); //체크박스해제
			
			
			//정렬 순서 삭제.
			$('#CtCd_Main_tbody [name=SortID]').remove();		//계약코드 삭제 시 재정렬을 위해 SortID input 전체 삭제.
			var now_tr_Select = $('#CtCd_Main_tbody tr').length;
			var sort_Retry = 0; 		//계약코드 삭제 시 정렬순서도 삭제하여 초기화된 정렬값을 다시 넣어줄 변수. 
			//현재의 계약코드 만큼 순서 SortID 값을 채워준다.		
			for(var i=0; i<now_tr_Select; i++){
			sort_Retry = i+1;
			$('#CtCd_Main_tbody').append("<input type='hidden' name='SortID' value="+sort_Retry+"></input>");
			
			}
		}
		
		//행 추가
		var paramCnt = 1;	//파라미터 갯수(tr 칼럼 갯수)
		function add_tr(){
			var frm = document.ProjectCodeManageRegistForm; 
			var ctcd_val_chk = $('#paramCtCd_'+paramCnt).val();				//추가된 해당 계약코드 name value 가져오기.
			var ctcd_name_count = $('[name=ContractCode]').length;			//추가된 해당 계약코드 name Count 가져오기.
			var sortid = Number(ctcd_name_count+1);							//추가된 해당 계약코드(0) +1 하여 정렬순서 가져오기. 
			var chk = $("#CtcYN input:checked").val();						//계약코드 사용,미사용 여부.
			
			//계약코드 최대 5개까지 입력 가능.
			if(sortid>5){
				alert("계약코드 행 추가는 최대 5개까지 가능합니다.");
				return;
			}
			//행 추가 시 해당 계약코드 입력 후 추가 가능.
			if(ctcd_val_chk == ""){
				alert("행 추가를 하시려면 해당 번호에 계약코드를 입력하세요.");
				return;
			}else{
				paramCnt++;
				var appendString = "";	//html append 변수
				
				appendString += "<tr id='param_tr_"+paramCnt+"'>";
				appendString += "<td id='param_2td_"+paramCnt+"'>";
				appendString += "<input class='text dis' type='text' id='paramCtCd_"+paramCnt+"' name='ContractCode' value='' style='width:122px;' readonly />";
				appendString += "<a id='pop_ct_a_"+paramCnt+"' href=\"javascript:popContractNo('paramCtCd_"+paramCnt+"','paramPjNm_"+paramCnt+"');\" class='btn_type03'>";
				appendString += "<span>계약서조회</span>";
				appendString += "</a>";
				appendString += "</td>";
				appendString += "<td id='param_3td_"+paramCnt+"'>";
				appendString += "<input class='text' type='text' id='paramPjNm_"+paramCnt+"' name='Con_ProjectName' value='' style='width:98%;border:0;background-color:transparent;' readonly />";
				appendString += "</td>";
				appendString += "<td id='param_4td_"+paramCnt+"' class='last text_c'>";
				appendString += "<a id='delete_a' href=\"javascript:delete_tr('param_tr_"+paramCnt+"','paramCtCd_"+paramCnt+"','paramPjNm_"+paramCnt+"','pop_ct_a_"+paramCnt+"')\" class='btn_type03'>";
				appendString += "<span>삭제</span>";
				appendString += "</a>";
				appendString += "<input type='hidden' name='SortID' value='"+sortid+"'/>";
				appendString += "</td>";
				appendString += "</tr>";
				
				//행 추가
				$("#CtCd_Main_tbody").append(appendString);
			}
		}
		
		//유상,무상 사용여부.
		function freeCostCheckYN(){
			var frm = document.ProjectCodeManageRegistForm;
			var chk = $("#PjDivision_td input:checked").val();	//프로젝트 구분 유상,무상 체크여부.
			
			if(chk == "Y"){
				 frm.FreeCostYN.value = "Y";
				 $("input:radio[name='CtcdYN']:radio[value='Y']").attr("checked",true);
				 $("input:radio[name='CtcdYN']:radio[value='N']").attr("disabled",true);
			  	 noneContractColum();
			 }else{
				 frm.FreeCostYN.value = "N";
				 $("input:radio[name='CtcdYN']:radio[value='N']").attr("disabled",false);
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

<!-- content -->
<div id="content" class="projectCodeMgRegistForm">
  <!-- title -->
<div class="content_navi">프로젝트지원 &gt; 프로젝트코드(등록/수정)</div>
			<h3><span>프</span>로젝트코드등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
		<!-- 필수입력사항텍스트 -->
		<p class="must_txt"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
		<!-- //필수입력사항텍스트 -->
	</div>

	<form name="ProjectCodeManageRegistForm" method="post" action="<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgRegist" enctype="multipart/form-data">
		<!-- Radio 버튼 스크립트 중복 방지. -->
		<input type="hidden" name="ctc_Cnt_Y" id="ctc_Cnt_Y" value="1"></input>
		<input type="hidden" name="ctc_Cnt_N" id="ctc_Cnt_N" value="1"></input>
		<!-- 담당영업 -->
		<input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"></input>
		<input class="in_txt" type="hidden" name="ChargeID" value=""></input>
		<!-- 담당PM -->
		<input type = "hidden" name = "user_id2" value="<%=dtoUser.getUserId()%>"></input>
		<input class="in_txt" type="hidden" name="ChargeProjectManager" value=""></input>











		<fieldset>
			<legend>프로젝트코드등록</legend>
			<table class="tbl_type" summary="프로젝트코드등록(프로젝트코드, 프로젝트구분, 발주사구분, 견적번호, 선택된견적서프로젝트명, 계약코드, 프로젝트명, 고객사명(End User), 발주사명, 프로젝트시작예정일, 프로젝트종료예정일, 프로젝트진행기간, 프로젝트진행요청서, 담당영업, 담당PM, 영업Comments)">
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tbody>
				<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트코드</label></th>
				<td><input type="text" name="ProjectCode" id="ProjectCode"  maxlength="10" class="text dis" style="width:100px;" readonly="readonly" value="PJ--"/> <br /><span class="guide_txt br">* <strong>프로젝트 코드 조합</strong> : (ex:PJA1) <strong>프로젝트 구분</strong> 및 <strong>발주사 구분</strong>을 반드시 선택하여 조합을 하셔야 합니다.<br />* 조합 후 등록 시 <strong>뒷6자리 코드번호는 자동증가</strong> 생성됩니다.</span></td>
			</tr> 
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트구분</label></th>
				<td id="PjDivision_td">
					<select name="ProjectDivision_Select" id="SelectBox1" onchange="ProjectDivision_Selected();">
						<option value="-">선택하세요</option>
						<option value="A">A-신규</option>
						<option value="B">B-증설</option>
						<option value="C">C-유지보수</option>
					</select>
					<input type="hidden" name="ProjectDivision" value="-"></input><input class="radio" type="radio" id="FreeCostChk_Y" name="FreeCostChk" value="Y" onclick="javascript:freeCostCheckYN();" /><label for="FreeCostChk_Y">유상</label><input class="radio" type="radio" id="FreeCostChk_N" name="FreeCostChk" value="N" checked="checked" onclick="javascript:freeCostCheckYN();" /><label for="FreeCostChk_N">무상</label><input type="hidden" name="FreeCostYN" value="N"></input>
				</td>
			</tr>
			<tr>
				<th id="PjDivision_CD_th"><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="증설코드" /></span>증설코드</span></label></th>
				<td id="PjDivision_CD_td"><input class="text dis" type="text" id="MoreCode" name="MoreCode" style="width:200px;" value=""></input><input type="hidden" id="P_ProjectCode" name="P_ProjectCode" class="in_txt" value="" style="width:100px;" readonly="readonly" onclick="javascript:popProjectCode();"></input><a href="javascript:popProjectCode();" class="btn_type03"><span>모프로젝트코드선택</span></a></td>
			</tr>
			
			<tr>
				<th id="PjDivision_NM_th">선택된모프로젝트명</th>
				<td id="PjDivision_NM_td"><input type="text" id="P_ProjectName" name="P_ProjectName" value="" style="border:0;background-color:transparent;" readonly="readonly"></input></td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사구분</label></th>
				<td id="PjDivision_td2">
					<select name="PurchaseDivision_Select" id="SelectBox2" onchange="ProjectDivision_Selected();">
						<option value="-">선택</option>
						<option value="1">1. (End User)</option>
						<option value="2">2. (하도급)</option>
					</select>
					<input type="hidden" name="PurchaseDivision" value="-"></input>
				</td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적번호</label></th>
				<td><input class="text dis" type="text" name="Public_No" value="" style="width:200px;" readonly="readonly"></input><a href="javascript:popPublicNo();" class="btn_type03"><span>견적서조회</span></a></td>
			</tr>
			<tr>
				<th><label for="">선택된견적서프로젝트명</label></th>
				<td><input class="text dis_none" type="text" name="Pub_ProjectName" value="" readonly="readonly" style="width:917px;" /></td>
			</tr>
			<tr>
				<th><label for="">계약코드</label></th>
				<td id="CtcYN" class="listT01">
					<dl>					
						<!--
						<input class="in_txt_off" type="text" name="ContractCode" value="" style="width:70px" readonly="readonly"></input>
	     				<a href="javascript:popContractNo();" ><img src="<%= request.getContextPath()%>/images/btn_srch_contract.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_contract_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_contract.gif'" width="70" height="19" title="계약서 찾기" /></a>
						-->
						<dt><input class="radio md0" type="radio" id="CtcdYN" name="CtcdYN" value="Y" onclick="javascript:noneContractColum();" /><label for="">사용</label><input class="radio" type="radio" id="CtcdYN" name="CtcdYN" value="N" onclick="javascript:noneContractColum();" checked /><label for="">미사용</label><input type="hidden" name="ContractCodeYN" value="N" /></dt>
						<!-- 계약코드 사용 시 추가 되는 테이블 -->
						<dd id="CtcMainTable" style="display: none">
							<span class="btn_add"><a href="javascript:add_tr();" class="btn_type03"><span>추가</span></a><span class="guide_txt">&nbsp;&nbsp;* 계약코드를 조회 후 등록, 삭제 할 수 있습니다.</span></span>
							<table class="tbl_type" summary="계약코드(계약코드, 선택된견적서프로젝트명, 삭제)">
								<colgroup>
									<col width="25%" />
									<col width="*" />
									<col width="8%" />
								</colgroup>
								<thead>
								<tr>
								<th>계약코드</th>
								<th>선택된견적서프로젝트명</th>
								<th class="last">삭제</th>
								</tr>
								</thead>
								<tbody id="CtCd_Main_tbody">
								</tbody>
							</table>
						</dd>					
					</dl>
				</td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트명</label></th>
				<td><input class="text" type="text" name="ProjectName" maxlength="250" style="width:830px;" value="" /><input class="check" type="checkbox" id="readOnly" name="readOnly" value="N" onclick="projectNameReadOnly();"><label for="readOnly">ReadOnly</label></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사명(End User)</label></th>
				<td><input class="text" type="text" name="CustomerName" style="width:200px;" maxlength="50" value=""></input></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사명</label></th>
				<td><input class="text" type="text" name="PurchaseName" style="width:300px;" maxlength="50" value="" /><!-- 2013_12_27 고객사 동일선택 버튼추가.--><input type="checkbox" name="chkYN" value="N" class="check" onclick="javascript:chkCustomerNameAdd();" /><label for="">고객사와 동일선택</label></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트시작예정일</label></th>
				<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" id="calendarData1" size="10" name="ProjectStartDate" maxlength="10" class="text" title="프로젝트시작예정일입력" value="<%=ProjectStartDate%>" style="width:100px;" onkeyup="javascript:datepickerInputText1();  dateProgressStatus();" onchange="javascript:dateProgressStatus();" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01)</span></td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트종료예정일</label></th>
				<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" size="10" name="ProjectEndDate" id="calendarData2" maxlength="10" class="text" value="<%=ProjectEndDate%>" title="프로젝트종료예정일입력" style="width:100px;" onkeyup="javascript:datepickerInputText2(); dateProgressStatus();" onchange="javascript:dateProgressStatus();" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01)</span></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>프로젝트진행기간</label></th>
				<td><input type="text" id="" name="ProjectProgressDate" class="text dis" title="프로젝트진행기간" readonly="readonly" value="0" style="width:50px;" /> 일</td>
			</tr>
			<tr>
				<th><label for="">프로젝트진행요청서</label></th>
				<td><div class="fileUp"><input type="text" class="text" id="file1" title="프로젝트진행요청서" style="width:561px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="ProjectProgressFile" id="upload1" /></div><input type="hidden" name="ProjectProgressFileNm" value="" /><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
				<td><input type="text" id="" name="user_nm" class="text" title="담당영업" readOnly style="width:200px;" value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();" /><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
			</tr>
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당PM</label></th>
				<td><input type="text" id="" name="user_nm2" class="text" title="담당PM" style="width:200px;" style="width:100px" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales_Second();" /><a href="javascript:popSales_Second();" class="btn_type03"><span>사원조회</span></a></td>
			</tr>
			<tr>
				<th><label for="">영업Comments</label></th>
				<td><textarea id="" name="ChargeComent" title="영업Comments" style="width:917px;height:96px;" dispName="영업 Comments " onKeyUp="js_Str_ChkSub('5000', this)"></textarea></td>
			</tr>
			</tbody>
		</table>
		</fieldset>
		<!-- button -->
		<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
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

<%= comDao.getMenuAuth(menulist,"21") %>
<script type="text/javascript">fn_fileUpload();</script>