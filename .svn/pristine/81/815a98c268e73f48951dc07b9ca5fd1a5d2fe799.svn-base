<%@page import="com.huation.common.formfile.FormFileDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.contractmanage.ContractManageDTO" %>
<%@ page import ="com.huation.common.user.UserBroker" %>
<%@ page import ="java.text.SimpleDateFormat" %>

<%
	Map model = (Map)request.getAttribute("MODEL");
	//Date 포맷(2013-12-17) 오늘 날짜로 type 마춰주기.(계약일자,발주일자,종료일자 공통 디폴트로 사용함.)
	String ContractEndDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String strDate = (String)model.get("strDate");

%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계약관리 등록 화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<%-- <link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"></script> --%>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">
<!--

	function goSave(){
		var frm = document.ContractManageRegistForm; 
		
		//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
		var strFile = frm.ContractFile.value;
		var strFile2 = frm.PurchaseOrderFile.value;
		
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
	
	if(frm.Public_No.value == ""){
		alert("견적번호를 선택해주세요.");
		return;
	}
	
	if(frm.ContractName.value == ""){
		alert("계약명을 입력하세요.");
		return;
	}
	
	//날짜 입력 벨류데이션 체크 시작.(계약일자)
	  var chk = $('input:checkbox[id="ConChk"]').is(":checked");	//계약일자 체크박스 체크유무
if(chk == true){
		
	  var frm = document.ContractManageRegistForm; 	 //폼셋팅
	  var inputDate1;								 //계약일자 입력 값 가져오기
	  var strY1;									 //계약일자 입력 값 (-)잘라서 년도만 담기
	  var strM1;									 //계약일자 입력 값 (-)잘라서 월자만 담기
	  var strD1;									 //계약일자 입력 값 (-)잘라서 일자만 담기
	  var strY_Val1;								 //년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strM_Val1;								 //월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strD_Val1;								 //일자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  
	  inputDate1 = frm.ContractDate.value; //계약일자에 입력되는 년/월/일
	
	  strY1 = inputDate1.substring(0,4).split('-'); //입력 년도만 나눠서 변수에 담기.
	  strY_Val1 = String(strY1);//String형변환
	  strM1 = inputDate1.substring(5,7).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strM_Val1 = String(strM1);//String형변환
	  strD1 = inputDate1.substring(8,10).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strD_Val1 = String(strD1);//String형변환	
	  
	
	//숫자가 아닌 String 으로 입력 하였을때.
	if(inputDate1.length>0){
		if (!isNumber(trim(inputDate1))) {
			alert("계약일자 텍스트 입력 시 (-)제외한숫자만 입력 하세요.");
			inputDate1=onlyNum(inputDate1);
			frm.ContractDate.value ="";
			return;
			
		}else{
			inputDate1=onlyNum(inputDate1);
			} 
		}
	//년도 4자리수 미만했을때.
	if(strY_Val1.length<4){
		alert('년도는 4자리수 미만 사용 불가능합니다.');
		strY_Val1=onlyNum(strY_Val1);
		frm.ContractDate.value ="";
		return;
	}else{
		strY_Val1=onlyNum(strY_Val1);
	}
	//월자 숫자입력으로 안했을때.
	if(strM_Val1.length>0){
		if (!isNumber(trim(strM_Val1))) {
			alert("월자는 숫자만 입력이 가능합니다.");
			strM_Val1=onlyNum(strM_Val1);
			frm.ContractDate.value ="";
			return;
			
		}else{
			strM_Val1=onlyNum(strM_Val1);
				
			} 
		}
	//월자 2자리수 미만 입력했을때.
	if(strM_Val1.length<1){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		strM_Val1=onlyNum(strM_Val1);
		frm.ContractDate.value ="";
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
		frm.ContractDate.value ="";
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

		frm.ContractDate.value ="";
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
		frm.ContractDate.value ="";
		return;
	}else{
		strD_Val1=onlyNum(strD_Val1);
	}
}
	

	var chk = $('input:checkbox[id="PurChk"]').is(":checked");	//발주일자 체크박스 체크유무
	//날짜 입력 벨류데이션 체크 시작.(발주일자)
if(chk == true){
	
	  var frm = document.ContractManageRegistForm; 	 //폼셋팅
	  var inputDate2;								 //발주일자 입력 값 가져오기
	  var strY2;									 //발주일자 입력 값 (-)잘라서 년도만 담기
	  var strM2;									 //발주일자 입력 값 (-)잘라서 월자만 담기
	  var strD2;									 //발주일자 입력 값 (-)잘라서 일자만 담기
	  var strY_Val2;								 //년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strM_Val2;								 //월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  var strD_Val2;								 //일자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
	  
	  inputDate2 = frm.PurchaseDate.value; //발주일자에 입력되는 년/월/일
	
	  strY2 = inputDate2.substring(0,4).split('-'); //입력 년도만 나눠서 변수에 담기.
	  strY_Val2 = String(strY2);//String형변환
	  strM2 = inputDate2.substring(5,7).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strM_Val2 = String(strM2);//String형변환
	  strD2 = inputDate2.substring(8,10).split('-'); //입력 달(월)만 나눠서 변수에 담기.
	  strD_Val2 = String(strD2);//String형변환	
	  
	
	//숫자가 아닌 String 으로 입력 하였을때.
	if(inputDate2.length>0){
		if (!isNumber(trim(inputDate2))) {
			alert("계약일자 텍스트 입력 시 (-)제외한숫자만 입력 하세요.");
			inputDate2=onlyNum(inputDate2);
			frm.PurchaseDate.value ="";
			return;
			
		}else{
			inputDate2=onlyNum(inputDate2);
			} 
		}
	//년도 4자리수 미만했을때.
	if(strY_Val2.length<4){
		alert('년도는 4자리수 미만 사용 불가능합니다.');
		strY_Val2=onlyNum(strY_Val2);
		frm.PurchaseDate.value ="";
		return;
	}else{
		strY_Val2=onlyNum(strY_Val2);
	}
	//월자 숫자입력으로 안했을때.
	if(strM_Val2.length>0){
		if (!isNumber(trim(strM_Val2))) {
			alert("월자는 숫자만 입력이 가능합니다.");
			strM_Val2=onlyNum(strM_Val2);
			frm.PurchaseDate.value ="";
			return;
			
		}else{
			strM_Val2=onlyNum(strM_Val2);
				
			} 
		}
	//월자 2자리수 미만 입력했을때.
	if(strM_Val2.length<1){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		strM_Val2=onlyNum(strM_Val2);
		frm.PurchaseDate.value ="";
		return;
	}else{
		strM_Val2=onlyNum(strM_Val2);
	}
	//일자 숫자입력으로 안했을때.
	if(strD_Val2.length>0){
		if (!isNumber(trim(strD_Val2))) {
			alert("일자는 숫자만 입력이 가능합니다.");
			strD_Val2=onlyNum(strD_Val2);
			frm.strD_Val2.value ="";
			return;
		
		}else{
			strD_Val2=onlyNum(strD_Val2);	
			}
		}
	//일자 2자리수 미만 입력했을때.
	if(strD_Val2.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		strD_Val2=onlyNum(strD_Val2);
		frm.PurchaseDate.value ="";
		return;
	}else{
		strD_Val2=onlyNum(strD_Val2);
	}
	if(strY_Val2.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(strM_Val2.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(strM_Val2 > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.PurchaseDate.value ="";
		return;
	}else{
		strM_Val2=onlyNum(strM_Val2);
	}
		
	if(strD_Val2.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(strD_Val2 > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.PurchaseDate.value ="";
		return;
	}else{
		strD_Val2=onlyNum(strD_Val2);
	}
}	
/* 	
	if(frm.ContractStatus.value == ""){
		alert("계약종료 여부를 선택하세요.");
		return;
	}
	
	var chk = $("#cmStChk input:checked").val();
	if(chk == "2"){
		if(frm.ContractReason.value == ""){
		alert("조기종료 선택 후 조기종료 사유는 필수 입력 항목입니다.");
		return;
		}
	}
	if(chk == "2" || chk == "3"){
		if(frm.ContractEndDate.value == ""){
		alert("조기종료 또는 계약종료 선택 후 종료일자는 필수 입력 항목입니다.");
		return;
		}
		
		//날짜 입력 벨류데이션 체크 시작.(종료일자)
		  var frm = document.ContractManageRegistForm; //폼셋팅
		  var inputDate;							 //종료일자 입력 값 가져오기
		  var strY;									 //종료일자 입력 값 (-)잘라서 년도만 담기
		  var strM;									 //종료일자 입력 값 (-)잘라서 월자만 담기
		  var strD;									 //종료일자 입력 값 (-)잘라서 일자만 담기
		  var strY_Val;								 //년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
		  var strM_Val;								 //월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
		  var strD_Val;								 //일자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
		  
		  inputDate = frm.ContractEndDate.value; //종료일자에 입력되는 년/월/일
		
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
				frm.ContractEndDate.value ="";
				return;
				
			}else{
				inputDate=onlyNum(inputDate)
				} 
			}
		//년도 4자리수 미만했을때.
		if(strY_Val.length<4){
			alert('년도는 4자리수 미만 사용 불가능합니다.');
			strY_Val=onlyNum(strY_Val);
			frm.ContractEndDate.value ="";
			return;
		}else{
			strY_Val=onlyNum(strY_Val);
		}
		//월자 숫자입력으로 안했을때.
		if(strM_Val.length>0){
			if (!isNumber(trim(strM_Val))) {
				alert("월자는 숫자만 입력이 가능합니다.");
				strM_Val=onlyNum(strM_Val);
				frm.ContractEndDate.value ="";
				return;
				
			}else{
				strM_Val=onlyNum(strM_Val);
					
				} 
			}
		//월자 2자리수 미만 입력했을때.
		if(strM_Val.length<1){
			alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
			strM_Val=onlyNum(strM_Val);
			frm.ContractEndDate.value ="";
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
			frm.ContractEndDate.value ="";
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

			frm.ContractEndDate.value ="";
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
			frm.ContractEndDate.value ="";
			return;
		}else{
			strD_Val=onlyNum(strD_Val);
		}
		
	}	
	
 */									// 계약등록시 진행중인 건만 등록하고 조기종료나 계약종료의 경우 종료된 건에 한에서 수정에서 바꿈(2014-10-21)
 /*
	if(frm.ContractFile.value != "" && !isFile(frm.ContractFile.value)){
			alert("첨부 가능한 파일 유형은 \n HWP, DOC, DOCX, PPT, PPTX, XLS, XLSX, PDF, JPG 이상 7종 입니다.");
			return; 				
	}
	
	if(frm.PurchaseOrderFile.value != "" && !isFile(frm.PurchaseOrderFile.value)){
		alert("첨부 가능한 파일 유형은 \n HWP, DOC, DOCX, PPT, PPTX, XLS, XLSX, PDF, JPG 이상 7종 입니다.");
		return; 				
	}
	*/
	  
	if(frm.Ordering_Organization.value == ""){
		alert("발주사(업체명)을 입력해주세요.");
		return;
	}
	
	frm.ContractFileNm.value = strFileName;
	frm.PurchaseOrderFileNm.value = strFileName2;
	
	frm.submit();
}


	/** 2013_12_13 shbyeon. 사용안함.
	 * 파일 확장자명 체크
	 *
	function isFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "hwp" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "xls" || ext == "xlsx" || ext == "pdf" || ext == "jpg") {
				return true;
			} else {
				return false;
			}
		}
	}
	 **/
	
	//목록
	function goList(){
		var frm = document.ContractManageRegistForm;
		location.href='<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList';
	}
	
	
	 /*
	2013_11_27(수) shbyeon.
	계약 종료여부에 대한 (조기종료/계약여부) 
	선택으로 인한 칼럼 hide&show
	*/
	function noneContractColum(){		
		var frm = document.ContractManageRegistForm;
		var chk = $("#cmStChk input:checked").val();
		if(chk == "1"){
			$('#CmReason_tr').hide();					//상태 값	1이면 조기종료 사유 영역 hide
			$('#CmDate_tr').hide();						//상태 값	1이면 종료일자 영역 hide
			//$('#CmStChk_td').attr('colspan','6'); 		//상태 값 1이면 계약 종료여부 영역(td) colspan=6
			//$('#CmDate_td').hide();						//상태 값 1이면 달력생성 영역 hide
			//$('#CmDate_td').attr('colspan','0');		//상태 값 1이면 종료일자 영역(td) colspan=0
			$('[name=ContractStatus]').val('1'); 		//상태 값 1이면 value 초기 값 셋팅
			$('[name=ContractReason]').val('');  		//상태 값 1이면 value 값 초기화 (공백)
			return;
		}else if(chk == "2"){
			$('#CmReason_tr').show();					//상태 값	2이면 조기종료 사유 영역 show
			$('#CmDate_tr').show();						//상태 값 2이면 조기종료 영역 show
			//$('#CmStChk_td').attr('colspan','1'); 		//상태 값 2이면 계약 종료여부 영역(td) colspan=1
			//$('#CmDate_td').show();						//상태 값 2이면 달력생성 영역 show
			//$('#CmDate_td').attr('colspan','0');		//상태 값 2이면 종료일자 영역(td) colspan=5
			$('[name=ContractStatus]').val('2'); 		//상태 값 2이면 value 조기종료 값 셋팅
			$('[name=ContractReason]').val(frm.ContractReason_Ori.value); //상태 값 2이면 다른 버튼 선택 후 다시 원래 버튼을 눌렀을때 초기값 셋팅.
			$('#CmDate_tr').show();
			return;
		}else if(chk == "3"){
			$('#CmReason_tr').hide();					//상태 값	1이면 조기종료 사유 영역 hide
			$('#CmDate_tr').show();						//상태 값 3이면 종료일자 영역 show
			//$('#CmStChk_td').attr('colspan','1'); 		//상태 값 3이면 계약 종료여부 영역(td) colspan=1
			//$('#CmDate_td').show();						//상태 값 3이면 달력생성 영역 show
			//$('#CmDate_td').attr('colspan','5');		//상태 값 3이면 종료일자 영역(td) colspan=5
			$('[name=ContractStatus]').val('3'); 		//상태 값 3이면 value 계약종료 값 셋팅
			$('[name=ContractReason]').val('');	 		//상태 값 3이면 value 값 초기화 (공백)

			return;
		}
	}
	
	//계약일자 사용유무.
	function noneDateChk_Cm(){
		var frm = document.ContractManageRegistForm;
		var chk = $('input:checkbox[id="ConChk"]').is(":checked");	//계약일자 체크박스 체크유무
		
		if(chk == true){
			$('#ContractDate_P_tag').show();					//계약일자 입력 화면 Show
			//계약일자 value 값 금일 날짜로 셋팅.
			$('#calendarData1').val('<%=strDate%>');	
			$('#ConChk').val('Y');								//계약일자 Value = 'Y' 셋팅
		}else{
			$('#ContractDate_P_tag').hide();					//계약일자 입력화면 hide
			$('#ContractDate').val('');							//계약일자 name value =''초기화
			$('#ConChk').val('N');								//계약일자 Value = 'N' 셋팅
		}
		
	}
	
	//발주일자 사용유무.
	function noneDateChk_Pur(){
		var frm = document.ContractManageRegistForm;
		var chk = $('input:checkbox[id="PurChk"]').is(":checked");	//발주일자 체크박스 체크유무
		
		if(chk == true){
			$('#PurchaseDate_P_tag').show();					//발주일자 입력 화면 Show
			//발주일자 value 값 금일 날짜로 셋팅.
			$('#calendarData2').val('<%=strDate%>');
			$('#PurChk').val('Y');								//발주일자 Value = 'Y' 셋팅
		}else{
			$('#PurchaseDate_P_tag').hide();					//발주일자 입력화면 hide
			$('#PurchaseDate').val('');							//발주일자 name value =''초기화
			$('#PurChk').val('N');								//발주일자 Value = 'N' 셋팅
		}
	}
	
	
	//2013_12_13(금) shbyeon.
	//조기종료 사유 대한 초기 화면 셋팅.
	//계약종료 여부 초기 값= 1(진행중 선택됨.)
	$(function(){
			$('#CmReason_tr').hide();					//상태 값 1이면 조기종료 사유 영역 hide
			$('#CmDate_tr').hide();						//상태 값	1이면 종료일자 영역 hide
			//$('#CmStChk_td').attr('colspan','6'); 		//상태 값 1이면 계약 종료여부 영역(td) colspan=6
			//$('#CmDate_td').hide();						//상태 값 1이면 달력생성 영역 hide
			//$('#CmDate_td').attr('colspan','0');		//상태 값 1이면 종료일자 영역(td) colspan=0
			$('#ContractDate_P_tag').hide();			//계약일자 디폴트 hide
			$('#PurchaseDate_P_tag').hide();			//발주일자 디폴트 hide
			$('#ConChk').val('N');						//계약일자 디폴트 Value = 'N'
			$('#PurChk').val('N');						//발주일자 디폴트 Value = 'N'
	});


	
	//전화번호 숫자 입력시 체크 후 - 생성
	 function MaskPhon( obj ) { 

	 	 obj.value =  PhonNumStr( obj.value ); //벨류값 있을시 PhonNumStr function 실행.

	 } 


	//전화번호 숫자 입력시 체크 후 - 생성
	 function PhonNumStr( str ){ 

	 	 var RegNotNum  = /[^0-9]/g; 

	 	 var RegPhonNum = ""; 

	 	 var DataForm   = ""; 

	 	 // return blank     

	 	 if( str == "" || str == null ) return ""; 

	 	 // delete not number

	 	 str = str.replace(RegNotNum,'');    

	 	 if( str.length < 4 ) return str; 


	 	 if( str.length > 3 && str.length < 7 ) { 

	 	   	DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 7 ) {

	 		 DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})/; 

	 	 } else if(str.length == 9 ) {

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 10){ 

	 		 if(str.substring(0,2)=="02"){

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 

	 		 }else{

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;

	 		 }

	 	 } else if(str.length > 10){ 

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 

	 	 } 


	 	 while( RegPhonNum.test(str) ) {  

	 		 str = str.replace(RegPhonNum, DataForm);  

	 	 } 

	 	 return str; 

	 } 
		   
	
	//달력 생성-1(계약일자)
		   $(function(){
		   	$('#ContractDate').datepicker({
		   		showAnim:'slideDown', 		//애니메이션 효과 옵션 =>( show(default),slideDown,fadeIn,blind,bounce,clip,drop,fold,slide,"")
		   		//altField: '#ContractEndDate',
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
	
		 //달력 생성-2(발주일자)
		   $(function(){
		   	$('#PurchaseDate').datepicker({
		   		showAnim:'slideDown', 		//애니메이션 효과 옵션 =>( show(default),slideDown,fadeIn,blind,bounce,clip,drop,fold,slide,"")
		   		//altField: '#ContractEndDate',
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
		 
		 //달력 생성-3(종료일자)
		   $(function(){
		   	$('#ContractEndDate').datepicker({
		   		showAnim:'slideDown', 		//애니메이션 효과 옵션 =>( show(default),slideDown,fadeIn,blind,bounce,clip,drop,fold,slide,"")
		   		//altField: '#ContractEndDate',
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
		   
		//달력 텍스트입력창-1(계약일자)
		  function datepickerInputText_1(){
			  var frm = document.ContractManageRegistForm;	//폼생성
			  var inputDate;								//계약일자 입력 값 가져오기
			  var strY;										//계약일자 입력 값 (-)잘라서 년도만 담기
			  var strM;										//계약일자 입력 값 (-)잘라서 월자만 담기
			  var strD;										//계약일자 입력 값 (-)잘라서 일자만 담기

			  inputDate = frm.ContractDate.value; //계약일자에 입력되는 년/월/일
			  
			  if(inputDate.length == 8){
				  inputDate = $('#ContractDate').val();	//계약일자 input에 입력된 값 불러오기.

				  strY = inputDate.substr(0,4); //입력 년도만 나눠서 변수에 담기.
				  strM = inputDate.substr(4,2); //입력 월자만 나눠서 변수에 담기.
				  strD = inputDate.substr(6,2); //입력 일자만 나눠서 변수에 담기.
				 
				  frm.ContractDate.value = strY+'-'+strM+'-'+strD; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
				  
			  }else if(event.keyCode == 8){
				  //alert('계약일자를 정확히 입력해주세요.(ex1900-01-01)');
				  frm.ContractDate.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
				  //alert(event.keyCode);
				  return;
			  }
		  }
	
		//달력 텍스트입력창-2(발주일자)
		  function datepickerInputText_2(){
			  var frm = document.ContractManageRegistForm;	//폼생성
			  var inputDate;								//발주일자 입력 값 가져오기
			  var strY;										//발주일자 입력 값 (-)잘라서 년도만 담기
			  var strM;										//발주일자 입력 값 (-)잘라서 월자만 담기
			  var strD;										//발주일자 입력 값 (-)잘라서 일자만 담기

			  inputDate = frm.PurchaseDate.value; //발주일자에 입력되는 년/월/일
			  
			  if(inputDate.length == 8){
				  inputDate = $('#PurchaseDate').val();	//발주일자 input에 입력된 값 불러오기.

				  strY = inputDate.substr(0,4); //입력 년도만 나눠서 변수에 담기.
				  strM = inputDate.substr(4,2); //입력 월자만 나눠서 변수에 담기.
				  strD = inputDate.substr(6,2); //입력 일자만 나눠서 변수에 담기.
				 
				  frm.PurchaseDate.value = strY+'-'+strM+'-'+strD; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
				  
			  }else if(event.keyCode == 8){
				  //alert('발주일자를 정확히 입력해주세요.(ex1900-01-01)');
				  frm.PurchaseDate.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
				  //alert(event.keyCode);
				  return;
			  }
		  }
		
		//달력 텍스트입력창-3(종료일자)
		  function datepickerInputText_3(){
			  var frm = document.ContractManageRegistForm;	//폼생성
			  var inputDate;								//종료일자 입력 값 가져오기
			  var strY;										//종료일자 입력 값 (-)잘라서 년도만 담기
			  var strM;										//종료일자 입력 값 (-)잘라서 월자만 담기
			  var strD;										//종료일자 입력 값 (-)잘라서 일자만 담기

			  inputDate = frm.ContractEndDate.value; //종료일자에 입력되는 년/월/일
			  
			  if(inputDate.length == 8){
				  inputDate = $('#ContractEndDate').val();	//종료일자 input에 입력된 값 불러오기.

				  strY = inputDate.substr(0,4); //입력 년도만 나눠서 변수에 담기.
				  strM = inputDate.substr(4,2); //입력 월자만 나눠서 변수에 담기.
				  strD = inputDate.substr(6,2); //입력 일자만 나눠서 변수에 담기.
				 
				  frm.ContractEndDate.value = strY+'-'+strM+'-'+strD; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
				  
			  }else if(event.keyCode == 8){
				  //alert('종료일자를 정확히 입력해주세요.(ex1900-01-01)');
				  frm.ContractEndDate.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
				  //alert(event.keyCode);
				  return;
			  }
		  }
	
	//견적서 발행번호 조회(계약=Y 건만)
	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_Cm&sForm=ContractManageRegistForm&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}
	
	
	//취소 Button
	function cancle(){
		
		var frm = document.ContractManageRegistForm;
		frm.action='<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegistList2';
		frm.submit();

	}
	
//-->
</script>
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
	<div class="content_navi">영업지원 &gt; 계약등록</div>
	<h3><span>계</span>약등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
 <!-- title -->			
	
	<div class="con" id="excelBody">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
	
	</div>
	<!-- //컨텐츠 상단 영역 -->
	
	<!-- 등록 --> 
    <form name="ContractManageRegistForm" method="post" action="<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegist" enctype="multipart/form-data">

	<fieldset>
		<legend>계약관리등록</legend>
			<table class="tbl_type" summary="계약관리등록(견적번호, 계약명, 계약일자, 계약서, 발주일자, 발주서, 계약종료여부, 발주사(업체명), 업체담당자, 업체담당자연락처, 업체담당자핸드폰번호)">
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
		
		<tbody>	  
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적번호</label></th>
				<td><input type="text" id="" name="Public_No" class="text dis" title="견적번호" style="width:200px;" readonly="readonly" value="" onClick="javascript:popPublicNo();"/><a href="javascript:popPublicNo();" class="btn_type03"><span>발행번호조회</span></a></td><!-- input 비활성화 class="dis" 추가 -->
			</tr>
						
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약명</label></th>
				<td><input type="text" id="" name="ContractName"  maxlength="250" class="text" title="계약명" style="width:500px;" /></td>
			</tr>      

			<tr>
				<th><label for="">계약일자</label></th>
				<td>
					<ul class="listD">
						<li class="first" id="ContractDate_P_None"><label for="ConChk">계약일자를 입력하시려면 체크 하세요.</label> <input type="checkbox" id="ConChk" name="ConChk" class="check md0" title="계약일자입력선택" onclick="javascript:noneDateChk_Cm();"/></li>
						<!-- 체크박스 선택 -->
						<li id="ContractDate_P_tag">Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" name="ContractDate" id="calendarData1" maxlength="8" class="text" title="계약일자입력" style="width:100px;" onkeyup="javascript:datepickerInputText_1();"/></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></li>
						<!-- //체크박스 선택 -->
					</ul>
				</td>
			</tr>

			<tr>
				<th><label for="">계약서</label></th>
					<td><input type="hidden" name="ContractFileNm" value=""></input><div class="fileUp"><input type="text" class="text" id="file1" title="계약서" style="width:566px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="ContractFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 제한 없음 / 첨부가능 용량 : 최대 20M</span></td>
			</tr>

			<tr>
				<th><label for="">발주일자</label></th>
					<td>
						<ul class="listD">
							<li class="first" id="PurchaseDate_P_None"><label for="PurChk">발주일자를 입력하시려면 체크 하세요.</label> <input type="checkbox" id="PurChk" name="PurChk" class="check md0" title="발주일자입력선택" onclick="javascript:noneDateChk_Pur();"/></li>
							<!-- 체크박스 선택 -->
							<li id="PurchaseDate_P_tag">Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text"  name="PurchaseDate" id="calendarData2" maxlength="8" class="text" title="발주일자입력" style="width:100px;" onkeyup="javascript:datepickerInputText_2();"/></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></li>
							<!-- //체크박스 선택 -->
						</ul>
					</td>
			</tr>
        
			<tr>
				<th><label for="">발주서</label></th>
					<td><input type="hidden" name="PurchaseOrderFileNm" value=""></input><div class="fileUp"><input type="text" class="text" id="file2" title="발주서" style="width:566px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="PurchaseOrderFile" id="upload2" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 제한 없음 / 첨부가능 용량 : 최대 20M</span></td>
			</tr>

 			<%-- <tr id="cmStChk">
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약종료여부</label></th>
					<td>
					<input type="radio" id="" name="cmChk" value="2" class="radio md0" title="조기종료" onclick="javascirpt:noneContractColum();"/>
					<label for="">조기종료</label>
					<input type="radio" id="" name="cmChk" value="3" class="radio" title="계약종료" onclick="javascirpt:noneContractColum();"/>
					<label for="">계약종료</label>
					<input type="radio" id="" name="cmChk" value="1" class="radio" checked="checked" title="진행중" onclick="javascirpt:noneContractColum();"/>
					<label for="">진행중</label>
					<input type="hidden" name="ContractStatus" value="1">
					</input><!-- value="1"<<초기값  --></td>
			</tr>     --%>

 			<tr id="CmDate_tr"><!-- 계약종료여부에서 조기종료, 계약종료 선택 시 노출 -->
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>종료일자</label></th>
					<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" name="ContractEndDate" id="calendarData3" maxlength="8" value="<%=ContractEndDate%>" onkeyup="javascript:datepickerInputText_3();" class="text" title="종료일자" style="width:100px;" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></td>
			</tr>       
 						
 			<tr id="CmReason_tr"><!-- 계약종료여부에서 조기종료 선택 시 노출 -->
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" onKeyUp="js_Str_ChkSub('500', this)"/></span>조기종료사유</label></th>
				<td><textarea id="" name="ContractReason" title="조기종료사유" style="width:917px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
			</tr>
						
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사(업체명)</label></th>
				<td><input type="text" id="" name="Ordering_Organization"  maxlength="100" class="text dis" title="발주사(업체명)" style="width:300px;" readonly="readonly"/></td><!-- input 비활성화 class="dis" 추가 -->
			</tr>        
         
			<tr>
				<th><label for="">업체담당자</label></th>
				<td><input type="text" id="" name="CustomerName" maxlength="10" class="text" title="업체담당자" style="width:200px;" /></td>
			</tr>
						
			<tr>
				<th><label for="">업체담당자연락처</label></th>
				<td><input type="text" id="" name="CustomerTel" maxlength="13" class="text" title="업체담당자연락처" style="width:200px;" onkeyup="format_phone(this);"/></td>
			</tr>
						
			<tr>
				<th><label for="">업체담당자핸드폰번호</label></th>
				<td><input type="text" id="" name="CustomerMobile" class="text" title="업체담당자핸드폰번호" style="width:200px;" maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
			</tr>
		</tbody>
	</table>
	</fieldset>
	</form>
	<!-- //등록 -->
				
	<!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
    <!-- button -->
			</div>
		</div>
	</div>
	<!-- //container -->
	

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>

<%= comDao.getMenuAuth(menulist,"13") %>
<script type="text/javascript">fn_fileUpload();</script>