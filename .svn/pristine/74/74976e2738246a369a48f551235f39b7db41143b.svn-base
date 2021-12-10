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

	String curPage = (String)model.get("curPage");
	ContractManageDTO cmDto = (ContractManageDTO)model.get("cmDto"); 
	
	
	//계약일자 초기 셋팅 값.
	String ContractDate = "";
	String strDate = (String)model.get("strDate");
	if(cmDto.getContractDate().equals("")){
		ContractDate = cmDto.getContractDate();
		ContractDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}else{
		ContractDate = cmDto.getContractDate();
	}
	
	//발주일자 초기 셋팅 값.
	String PurchaseDate = "";
	
	if(cmDto.getPurchaseDate().equals("")){
		PurchaseDate = cmDto.getPurchaseDate();
		PurchaseDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}else{
		PurchaseDate = cmDto.getPurchaseDate();
	}
	
	
	//종료일자 초기 셋팅 값.
	String ContractEndDate = "";
	
	if(cmDto.getContractStatus().equals("1")){	
		//Date 포맷(2013-11-29) type 마춰주기.
		ContractEndDate = cmDto.getContractEndDate();
		ContractEndDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		//진행중일때 금일 날짜로 넘겨주지만 실제 데이터는 sp에서 Null값으로 셋팅하여 Update함.
		//(java date util로 금일 날짜 가져와 표현해주기 위해.)
	}else{
		ContractEndDate = cmDto.getContractEndDate();
	}
	
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>계약관리상세정보</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.ContractManageViewForm; 
	
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
if(confirm("수정 하시겠습니까?")){
	frm.action='<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgEdit'
	if(frm.ContractName.value == ""){
		alert("계약명을 입력하세요.");
		return;
	}
	
	//날짜 입력 벨류데이션 체크 시작.(계약일자)
	  var chk = $('input:checkbox[id="ConChk"]').is(":checked");	//계약일자 체크박스 체크유무

	  if(chk == true){
	  var frm = document.ContractManageViewForm; 	 //폼셋팅
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
	
	  var frm = document.ContractManageViewForm; 	 //폼셋팅
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
		
		//날짜 입력 벨류데이션 체크 시작.
		  var frm = document.ContractManageViewForm; //폼셋팅
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
	
	if(strFileName != ''){
		frm.ContractFileNm.value = strFileName;
	}
	if(strFileName2 != ''){
		frm.PurchaseOrderFileNm.value = strFileName2;
	}
	
	 frm.submit();
   }
}


	/**
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
		var frm = document.ContractManageViewForm;
		frm.action='<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList2';
		frm.submit();
	}
	
	/*
	2013_11_27(수) shbyeon.
	계약 종료여부에 대한 (조기종료/계약여부) 
	선택으로 인한 칼럼 hide&show
	*/
	function noneContractColum(){		
		var frm = document.ContractManageViewForm;
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
			//$('#CmDate_td').attr('colspan','5');		//상태 값 2이면 종료일자 영역(td) colspan=5
			$('[name=ContractStatus]').val('2'); 		//상태 값 2이면 value 조기종료 값 셋팅
			$('[name=ContractReason]').val(frm.ContractReason_Ori.value); //상태 값 2이면 다른 버튼 선택 후 다시 원래 버튼을 눌렀을때 초기값 셋팅.
			//$('#CmDate_td').show();
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
		var frm = document.ContractManageViewForm;
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
		var frm = document.ContractManageViewForm;
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

	//2013_11_27(수) shbyeon.
	//조기종료 사유 대한 초기 화면 셋팅.
	//계약종료 여부 ContractStatus 값으로 판단.
	$(function(){
		var cmStatus = $('[name=ContractStatus]').val();	//계약종료 여부 플래그 Value
		var cmDateVal = $('[name=ContractDate]').val(); 	//계약일자 Value
		var purDateVal = $('[name=PurchaseDate]').val();	//발주일자 Value

		//계약종료 여부에 대한 체크로 초기 화면 셋팅.
		if(cmStatus == "1"){
			$("#CmReason_tr").hide();					//상태 값 1이면 조기종료 사유 영역 hide
			$('#CmDate_tr').hide();						//상태 값	1이면 종료일자 영역 hide
			//$('#CmStChk_td').attr('colspan','6'); 		//상태 값 1이면 계약 종료여부 영역(td) colspan=6
			//$('#CmDate_td').hide();						//상태 값 1이면 달력생성 영역 hide
			//$('#CmDate_td').attr('colspan','0');		//상태 값 1이면 종료일자 영역(td) colspan=0
		}else if(cmStatus == "2"){
			$("#CmReason_tr").show();					//상태 값 2이면 종료일자 사유 영역 show
			$('#CmDate_tr').show();						//상태 값 2이면 조기종료 영역 show
			//$('#CmStChk_td').attr('colspan','1'); 		//상태 값 2이면 계약 종료여부 영역(td) colspan=1
			//$('#CmDate_td').show();						//상태 값 2이면 달력생성 영역 show
			//$('#CmDate_td').attr('colspan','5');		//상태 값 2이면 종료일자 영역(td) colspan=5
		}else if(cmStatus == "3"){
			$("#CmReason_tr").hide();					//상태 값 3이면 종료일자 사유 영역 hide
			$('#CmDate_tr').show();						//상태 값 3이면 종료일자 영역 show
			//$('#CmStChk_td').attr('colspan','1'); 		//상태 값 3이면 계약 종료여부 영역(td) colspan=1
			//$('#CmDate_td').show();						//상태 값 3이면 달력생성 영역 show
			//$('#CmDate_td').attr('colspan','5');		//상태 값 3이면 종료일자 영역(td) colspan=5
		}

		//계약일자&발주일자 여부에 대한 체크로 초기 화면 셋팅.
		if(cmDateVal != ""){
			$('#ContractDate_P_tag').show();						//계약일자 칼럼 Show
			$("input:checkbox[id='ConChk']").attr("checked", true); //checkbox checked 처리.
			$('#ConChk').val('Y');									//계약일자 사용여부 checkbox Value = 'Y'
		}else{
			$('#ContractDate_P_tag').hide();						 //계약일자 칼럼 Hide
			$("input:checkbox[id='ConChk']").attr("checked", false); //checkbox unchecked 처리.
			$('#ConChk').val('N');									 //계약일자 사용여부 checkbox Value = 'N'	
		}
		if(purDateVal != ""){
			$('#PurchaseDate_P_tag').show();						//발주일자 디폴트 hide
			$("input:checkbox[id='PurChk']").attr("checked", true); //checkbox checked 처리.
			$('#PurChk').val('Y');									//발주일자 사용여부 checkbox Value = 'Y'
		}else{
			$('#PurchaseDate_P_tag').hide();						 //발주일자 디폴트 hide
			$("input:checkbox[id='PurChk']").attr("checked", false); //checkbox unchecked 처리.
			$('#PurChk').val('N');									 //발주일자 사용여부 checkbox Value = 'N'	
		}
		
	})

	
	
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
		  var frm = document.ContractManageViewForm;	//폼생성
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
		  var frm = document.ContractManageViewForm;	//폼생성
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
		  var frm = document.ContractManageViewForm;	//폼생성
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
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_Cm&sForm=ContractManageViewForm&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
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
		<div id="content">
			<div class="content_navi">영업지원 &gt; 계약관리</div>
			<h3><span>계</span>약관리상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con" id="excelBody">
				<!-- 계약관리상세보기 -->
				<div class="con_sub">
					<h4>계약관리상세보기</h4>
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area">
						<!-- 필수입력사항텍스트 -->
						<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
						<!-- //필수입력사항텍스트 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
					<!-- 등록 -->
					<form name="ContractManageViewForm" method="post" action="<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgEdit" enctype="multipart/form-data">
					<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
					<fieldset>
						<legend>계약관리상세정보</legend>
						<table class="tbl_type" summary="계약관리상세정보(견적번호, 계약명, 계약일자, 계약서, 발주일자, 발주서, 계약종료여부, 발주사(업체명), 업체담당자, 업체담당자연락처, 업체담당자핸드폰번호)">
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약번호</label></th>
								<td><input type="text" name="ContractCode" class="text dis" title="계약번호" style="width:200px;" readonly="readonly" value="<%=cmDto.getContractCode()%>" /><!-- input 비활성화 class="dis" 추가 -->
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적번호</label></th>
								<td><input type="text" name="Public_No" class="text dis" title="견적번호" style="width:200px;" readonly="readonly" value="<%=cmDto.getPublic_No() %>" onClick="javascript:popPublicNo();" /><a href="javascript:popPublicNo();" class="btn_type03"><span>발행번호조회</span></a></td><!-- input 비활성화 class="dis" 추가 -->
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약명</label></th>
								<td><input type="text" name="ContractName" class="text" title="계약명" style="width:500px;" maxlength="250" value="<%=cmDto.getContractName()%>" /></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약일자</label></th>
								<td>
									<ul class="listD">
										<li class="first" id="ContractDate_P_None"><label for="ConChk">계약일자를 입력하시려면 체크 하세요.</label> <input type="checkbox" id="ConChk" name="ConChk" value="" onclick="javascript:noneDateChk_Cm();" class="check md0" title="계약일자입력선택" /></li>
										<!-- 체크박스 선택 -->
										<li id="ContractDate_P_tag">Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" size="10" name="ContractDate" id="calendarData1" maxlength="8" value="<%=cmDto.getContractDate()%>" class="text" title="계약일자입력" style="width:100px;" onkeyup="javascript:datepickerInputText_1();" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></li>
										<!-- //체크박스 선택 -->
									</ul>
								</td>
							</tr>
							<tr>
								<th><label for="">계약서</label></th>
								<td><input type="hidden" name="ContractFileNm" value="<%=cmDto.getContractFileNm()%>" /><div class="fileUp"><input type="text" class="text" id="file1" title="계약서" style="width:566px;" value="<%=cmDto.getContractFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="ContractFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 제한 없음 / 첨부가능 용량 : 최대 20M</span></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주일자</label></th>
								<td>
									<ul class="listD">
										<li class="first" id="PurchaseDate_P_None"><label for="PurChk">발주일자를 입력하시려면 체크 하세요.</label> <input type="checkbox" id="PurChk" name="PurChk" value="" class="check md0" title="발주일자입력선택" onclick="javascript:noneDateChk_Pur();" /></li>
										<!-- 체크박스 선택 -->
										<li id="PurchaseDate_P_tag">Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" size="10" name="PurchaseDate" id="calendarData2" maxlength="8" value="<%=cmDto.getPurchaseDate()%>" onkeyup="javascript:datepickerInputText_2();" class="text" title="발주일자입력" style="width:100px;" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span></li>
										<!-- //체크박스 선택 -->
									</ul>
								</td>
							</tr>
							<tr>
								<th><label for="">발주서</label></th>
								<td><input type="hidden" name="PurchaseOrderFileNm" value="<%=cmDto.getPurchaseOrderFileNm()%>" /><input type="hidden" name="p_PurchaseOrderFile" value="<%=cmDto.getPurchaseOrderFile()%>" /><div class="fileUp"><input type="text" class="text" id="file2" title="발주서" style="width:566px;" value="<%=cmDto.getPurchaseOrderFile()%>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="PurchaseOrderFile" id="upload2" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 제한 없음 / 첨부가능 용량 : 최대 20M</span></td>
							</tr>
							<%
								String achecked = "";
								String bchecked = "";
								String cchecked = "";
								String ContractStatus = cmDto.getContractStatus();

								if(ContractStatus.equals("1")){
								achecked = "checked";
								}else if(ContractStatus.equals("2")){
								bchecked = "checked";
								}else if(ContractStatus.equals("3")){
								cchecked = "checked";
								}
							%>
							<tr id="cmStChk">
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약종료여부</label></th>
								<td> <input type="radio" name="cmChk" id="cmChk2" class="radio md0" title="조기종료" value="2" <%=bchecked %> onclick="javascirpt:noneContractColum();"></input><label for="cmChk2">조기종료</label><input type="radio" name="cmChk" id="cmChk3" class="radio" title="계약종료" value="3" <%=cchecked %> onclick="javascirpt:noneContractColum();"></input><label for="cmChk3">계약종료</label><input type="radio" name="cmChk" id="cmChk1" class="radio" title="진행중" value="1" <%=achecked %> onclick="javascirpt:noneContractColum();"></input><label for="cmChk1">진행중</label><input type="hidden" name="ContractStatus" value="<%=cmDto.getContractStatus() %>" /></td>
							</tr>
							<tr id="CmDate_tr"><!-- 계약종료여부에서 조기종료, 계약종료 선택 시 노출 -->
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>종료일자</label></th>
								<td>Date&nbsp;&nbsp;<span class="ico_calendar"><input type="text" size="10" name="ContractEndDate" id="calendarData3" maxlength="8" value="<%=ContractEndDate%>" onkeyup="javascript:datepickerInputText_3();" class="text" title="종료일자입력" style="width:100px;" /></span><span class="guide_txt">&nbsp;&nbsp;* 텍스트 상자에 직접 일자 입력 할 경우 (예 : 2013-01-01) </span>
								<%--
								<input type="hidden" name="ContractEndDate" class="in_txt" value="<%=cmDto.getContractEndDate()%>" />
								--%></td>
							</tr>
							<tr id="CmReason_tr"><!-- 계약종료여부에서 조기종료 선택 시 노출 -->
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>조기종료사유</label></th>
								<td><textarea name="ContractReason" title="조기종료사유" style="ime-mode:active;width:917px;height:41px;" dispName="조기종료사유 " onKeyUp="js_Str_ChkSub('500', this)"><%=cmDto.getContractReason() %></textarea><input type="hidden" name="ContractReason_Ori" value="<%=cmDto.getContractReason()%>" /></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발주사(업체명)</label></th>
								<td><input type="text" name="Ordering_Organization"  maxlength="100" class="text dis" title="발주사(업체명)" style="width:300px;" readonly="readonly" value="<%=cmDto.getOrdering_Organization()%>" /></td><!-- input 비활성화 class="dis" 추가 -->
							</tr>
							<tr>
								<th><label for="">업체담당자</label></th>
								<td><input type="text" name="CustomerName" maxlength="10" class="text" title="업체담당자" style="width:200px;" value="<%=cmDto.getCustomerName()%>" /></td>
							</tr>
							<tr>
								<th><label for="">업체담당자연락처</label></th>
								<td><input type="text" name="CustomerTel" class="text" title="업체담당자연락처" style="width:200px;" value="<%=cmDto.getCustomerTel() %>" maxlength="13" onkeyup="format_phone(this);" /></td>
							</tr>
							<tr>
								<th><label for="">업체담당자핸드폰번호</label></th>
								<td><input type="text" name="CustomerMobile" class="text" title="업체담당자핸드폰번호" style="width:200px;" value="<%=cmDto.getCustomerMobile() %>" maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"></td>
							</tr>
							</tbody>
						</table>
					</fieldset>
					</form>
					<!-- //등록 -->
				</div>
				<!-- //계약관리상세보기 -->
				<!-- 계산서발행금액 -->
				<%
					//리스트 객체 셋팅
					ListDTO ld = (ListDTO) model.get("listInfo");
					DataSet ds = (DataSet) ld.getItemList();

					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();

				%>
				<div class="con_sub">
					<h4>계산서발행금액</h4>
					<!-- 리스트 -->
					<table class="tbl_type tbl_type_list" summary="계산서발행금액리스트(No., 발행일자, 발행금액, 누적발행금액, 미발행금액)">
						<colgroup>
							<col width="5%" />
							<col width="*" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<thead>
						<tr>
							<th>No.</th>
							<th>발행일자</th>
							<th>발행금액</th>
							<th>누적발행금액</th>
							<th>미발행금액</th>
						</tr>
						</thead>
						<tbody>
						<!-- :: loop :: -->
						<!--리스트---------------->
						<%
							long esti_amt=0;				//총견적금액(공급가+부가세) 견적서발행금액.
							long sup=0;						//공급가 = 발행금액
							long vat=0;						//부가세
							long supply_sum_vat=0; 			//발행금액(공급가+부가세) 세금계산서발행금액.
							long sum_price_total=0; 		//누적발행금액
							long min_price_total=0; 		//미발행금액
							long deposit_amt=0;				//입금액
							long deposit_amt_total=0;		//누적 입금액
							long no_collect_total=0;		//미회수금액
							long exceed_total=0;			//초과금액

							String tcl="";			//status로 인한 칼럼색상
							String dipositYN="";	//status로 인한 입금여부(미수/완료)
							int no = 1;				//순차 넘버링.
							
							if (ld.getItemCount() > 0) {
								int i = 0;
								while (ds.next()) {
				%>

<% 
									if(ds.getString("STATE").equals("01")){
										tcl="txt_green"; //현재 색깔안바뀜...
										dipositYN="미수";
									}else{
										tcl="td3";
										dipositYN="완료";
									}


									//구분
									sup = Long.parseLong(ds.getString("I_SUPPLY_PRICE")); //세금계산서 발행금액
									vat = Long.parseLong(ds.getString("I_VAT"));			//세금계산서 발행 부가세
									esti_amt = Long.parseLong(ds.getString("Esti_AMT")); 	//견적서 발행 총견적금액
									supply_sum_vat = sup+vat; 		   			 //발행금액(공급가+부가세)
									sum_price_total += sup+vat; 	   			 //누적발행금액(발행금액++)
									min_price_total = esti_amt - sum_price_total; //미발행금액(총견적금액-누적발행금액)
									
									//수금현황
									deposit_amt = Long.parseLong(ds.getString("DEPOSIT_AMT"));			//입금액
									deposit_amt_total += deposit_amt; 									//누적 입금액(입금액++)
									no_collect_total = esti_amt-deposit_amt_total;						//미회수금액(총견적금액-누적입금액)

						%>
						<tr>
							<td><%=no++ %></td>
							<td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(supply_sum_vat) %></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(sum_price_total) %></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(min_price_total) %></td>
						</tr>
						<!-- :: loop :: -->
						<%
							i++;
								}
							} else {
						%>
						<tr>
							<td colspan="5">게시물이 없습니다.</td>
						</tr>
						<%
							}
						%>
						</tbody>
					</table>
					<!-- //리스트 -->
				</div>
				<!-- //계산서발행금액 -->
				<!-- 수금현황 -->
				<%
					//리스트 객체 셋팅
					ListDTO ld2 = (ListDTO) model.get("listInfo2");
					DataSet ds2 = (DataSet) ld2.getItemList();

					int iTotCnt2 = ld2.getTotalItemCount();
					int iCurPage2 = ld2.getCurrentPage();
					int iDispLine2 = ld2.getListScale();
					int startNum2 = ld2.getStartPageNum();

				%>
				<div class="con_sub last">
					<h4>수금현황</h4>
					<!-- 리스트 -->
					<table class="tbl_type tbl_type_list" summary="수금현황(No., 발행일자, 발행금액, 입금액, 미회수금액)">
						<colgroup>
							<col width="5%" />
							<col width="*" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<thead>
						<tr>
							<th>No.</th>
							<th>발행일자</th>
							<th>발행금액</th>
							<th>입금액</th>
							<th>미회수금액</th>
						</tr>
						</thead>
						<tbody>
						<!-- :: loop :: -->
						<!--리스트---------------->
						<%
							esti_amt=0;					//총견적금액(공급가+부가세) 견적서발행금액.
							sup=0;						//공급가 = 발행금액
							vat=0;						//부가세
							supply_sum_vat=0; 			//발행금액(공급가+부가세) 세금계산서발행금액.
							sum_price_total=0; 			//누적발행금액
							min_price_total=0; 			//미발행금액
							deposit_amt=0;				//입금액
							deposit_amt_total=0;		//누적 입금액
							no_collect_total=0;			//미회수금액
							exceed_total=0;				//초과금액

							tcl="";						//status로 인한 칼럼색상
							dipositYN="";				//status로 인한 입금여부(미수/완료)
							no = 1;						//순차 넘버링.

							if (ld2.getItemCount() > 0) {
								int j = 0;
								while (ds2.next()) {
									
									if(ds2.getString("STATE").equals("01")){
										tcl="txt_green"; //현재 색깔안바뀜...
										dipositYN="미수";
									}else{
										tcl="td3";
										dipositYN="완료";
									}

									//구분
									sup = Long.parseLong(ds2.getString("I_SUPPLY_PRICE")); 	//세금계산서 발행금액
									vat = Long.parseLong(ds2.getString("I_VAT"));			//세금계산서 발행 부가세
									esti_amt = Long.parseLong(ds2.getString("Esti_AMT")); 	//견적서 발행 총견적금액
									supply_sum_vat = sup+vat; 		   			 			//발행금액(공급가+부가세)
									sum_price_total += sup+vat; 	   			 			//누적발행금액(발행금액++)
									min_price_total = esti_amt - sum_price_total; 			//미발행금액(총견적금액-누적발행금액)
									
									//수금현황
									deposit_amt = Long.parseLong(ds2.getString("DEPOSIT_AMT"));			//입금액
									deposit_amt_total += deposit_amt; 									//누적 입금액(입금액++)
									no_collect_total = esti_amt-deposit_amt_total;						//미회수금액(총견적금액-누적입금액)

						%>
						<tr>
							<td><%=no++ %></td>
							<td><%=DateTimeUtil.getDateType(1,ds2.getString("PUBLIC_DT"),"/")%></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(supply_sum_vat) %></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(deposit_amt) %></td>
							<td class="text_r"><%=NumberUtil.getPriceFormat(no_collect_total) %></td>
						</tr>
						<!-- :: loop :: -->
						<%
							j++;
								}
							} else {
						%>
						<tr>
							<td colspan="5">게시물이 없습니다.</td>
						</tr>
						<%
							}
						%>
						</tbody>
					</table>
					<!-- //리스트 -->
				</div>
				<!-- //수금현황 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
				<!-- //Bottom 버튼영역 -->
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
<%= comDao.getMenuAuth(menulist,"14") %>
<script type="text/javascript">fn_fileUpload();</script>