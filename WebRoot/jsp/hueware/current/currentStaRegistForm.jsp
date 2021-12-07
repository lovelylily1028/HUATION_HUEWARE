<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.ComCodeDTO"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserBroker"%>
<%@ page import="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>

<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	//상품코드 Arr 모델로 객체로 꺼낸다 codeList로.
	ArrayList codeList = (ArrayList)model.get("codeList"); //자사 상품코드
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //비자사(내수)상품코드
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //비자사(외수)상품코드

	//금일 년/월/일 가져오기.
	String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>영업진행현황 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="javascript">
<!--
/*
 * jQuery Test Sample
 
$(function(){
	alert($('[name=currentStaRegist]').attr('action'));
});
 */




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




 
	function goSave(){
		 
		var frm = document.currentStaRegist; 
		
		//상품코드 체크
		var ProductCode = $('#ProductCode').length;
	
		if(frm.checkyn.checked!=true){
			if(frm.comp_code.value.length == 0){
				alert("영업주관사를 선택하세요.");
				return;
			}
		}else{
			if(frm.e_comp_nm.value.length == 0){
				alert("영업주관사를 입력하세요.");
				return;e_comp_nm
			}
		}	
		
	//NoCode < jQuery 함수
	if(ProductCode == 0){
		alert("상품코드를 넣어주세요.")	;
		return;
	}
	
	if(frm.OperatingCompany.value == ""){
		alert("고객사를 입력하세요."); 
		return;
	}
	if(frm.ProjectName.value == ""){
		alert("예상 프로젝트명을 입력하세요."); 
		return;
	}
	if(frm.Orderble.value == ""){
		alert("수주가능성을 선택하세요."); 
		return;
	}
	if(frm.AssignPerson.value == ""){
		alert("기술분야 배정인력을 입력하세요."); 
		return;
	}

	//분기 체크후 분기별 데이터 셋팅
    if(frm.target_month.value == "01" || frm.target_month.value == "02" || frm.target_month.value == "03"){
    	frm.Quarter.value = "1";
    }
    if(frm.target_month.value == "04" || frm.target_month.value == "05" || frm.target_month.value == "06"){
    	frm.Quarter.value = "2";
    }
    if(frm.target_month.value == "07" || frm.target_month.value == "08" || frm.target_month.value == "09"){
    	frm.Quarter.value = "3";
    }
    if(frm.target_month.value == "10" || frm.target_month.value == "11" || frm.target_month.value == "12"){
    	frm.Quarter.value = "4";
    }
    
    //업체코드가  있다면 업체코드명을 셋팅.
    if(frm.comp_code.value.length != 0){
		frm.e_comp_nm.value=frm.comp_nm.value
	}
   
	
	frm.DateProjections.value=frm.target_year.value+'.'+frm.target_month.value;
	frm.ChargeID.value=frm.user_id.value;
	frm.ChargeSecondID.value=frm.user_id2.value;
	
   if(frm.SalesMan_co.value != "" && frm.Contents.value == ""){
    	alert('이슈코멘트 입력시 이슈 재기자 및 내용은 반드시 입력하셔야 합니다.');
    	return;
    }else if(frm.SalesMan_co.value == "" && frm.Contents.value != ""){
    	alert('이슈코멘트 입력시 이슈 재기자 및 내용은 반드시 입력하셔야 합니다.');
    	return;
    }else if(frm.SalesMan_co.value == "" && frm.Contents.value == "" && frm.SalesFile.value != ""){
    	alert('이슈코멘트 파일만 첨부 할 수 없습니다. 상위 이슈 재기자 및 내용을 입력하세요.');
    	return;
    }else if(frm.SalesMan_co.value != "" && frm.Contents.value == "" && frm.SalesFile.value != ""){
    	alert('이슈코멘트 파일 첨부를 할 수 없습니다. 상위 이슈 재기자 및 내용을 입력하세요.');
    	return;
    }else if(frm.SalesMan_co.value == "" && frm.Contents.value != "" && frm.SalesFile.value != ""){
    	alert('이슈코멘트 파일 첨부를 할 수 없습니다. 상위 이슈 재기자 및 내용을 입력하세요.');
    	return;
    }else{ 
       	frm.submit();
     } 
	
}
	
	function cancle(){
		
		var frm = document.currentStaRegist;
		frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList';
		frm.submit();

	}
	
	/*
	상위 카테고리 체크박스 현재사용안함(2013_03_11)
function insert_ProductGb(paramGb){
		//체크 박스의 갯수를 변수에 담는다.
		var chklen = document.currentStaRegist.PcCode.length;
	if(paramGb=='Pc0'){
		for(i=0; i<chklen; i++){
			if(document.currentStaRegist.PcCode.button == true){
				document.currentStaRegist.ProductCode.value += document.currentStaRegist.PcCode[i].value
		}
	}
}
	if(paramGb=='Pc1'){
		for(i=1; i<chklen; i++){
			if(document.currentStaRegist.PcCode.checked == true){
				document.currentStaRegist.ProductCode.value += document.currentStaRegist.PcCode[i].value
		}
	}
}	
}
	*/
	
	/*
	상위 자사상품 내수 코드조합 카테고리
	라디오 버튼 일시 사용.
	function insert_code0(){
		var chk = document.getElementById("Pc0").value;
		document.currentStaRegist.ProductCode.value += chk
	}
	function insert_code1(){
		var chk = document.getElementById("Pc1").value;
		document.currentStaRegist.ProductCode.value += chk
	}
	*/
	
	/*
 * int 가격 체크 000, 계산하여 끊어준뒤 콤마 표시
 */
 function saleCntCal(form){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+'_view');
		var frm=eval("document."+form);
		var costobj=document.currentStaRegist;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
	
		}
	
		if (!isNumber(trim(v_obj.value))) {
			alert("0~9 정수(숫자)만 입력해 주세요.");
		} 
		
		
		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;
		
		if(form=='currentStaRegist.SalesProjections'){	
			var price=parseInt(onlyNum(costobj.SalesProjections.value)*1,10);
			costobj.SalesProjections.value=addCommaStr(''+SalesProjections);
		    costobj.SalesProjections.value=SalesProjections;	    
		    
		}
		v_obj.focus();
	}
	
	function popComp(){

		var obj=document.currentStaRegist;
		
		if(obj.checkyn.checked==true){
				alert('수동입력 선택을 해제후 업체조회 하시기 바랍니다.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=currentStaRegist","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
	}
	
	//수동입력 체크 판단 후 입력창 활성화여부.
	 function directInput(){

		    var obj=document.currentStaRegist;
 			if(obj.checkyn.checked==true){
				
				if(confirm("수동입력으로 변경하시겠습니까?")){
					obj.e_comp_nm.style.display='inline'
					//obj.e_comp_nm_se.style.display='inline' 중복체크버튼 활성화 유무 현재사용안함 2013_05_02
					obj.comp_nm.style.display="none";
					obj.comp_nm.value='';
					obj.comp_code.value='';
				}else{
					obj.checkyn.checked=false;
				}
			}else{

				if(confirm("선택입력으로 변경하시겠습니까?")){
					obj.e_comp_nm.style.display='none'
					//obj.e_comp_nm_se.style.display='none' 중복체크버튼 활성화 유무 현재사용안함 2013_05_02
					obj.comp_nm.style.display="inline";
					obj.e_comp_nm.value='';
				}else{
					obj.checkyn.checked=true;
				}


			}

		}
	
	/*수동입력 체크 판단 후 입력창 활성화여부.
	
	 function directInput(){

		    var obj=document.currentStaRegist;
			if(obj.checkyn.checked==true){
				obj.e_comp_nm.style.display='inline'
				obj.e_comp_nm_se.style.display='inline'
				obj.comp_nm.style.display="none";
				obj.comp_nm.value='';
				obj.comp_code.value='';
			}else{
				obj.e_comp_nm.style.display='none'
				obj.e_comp_nm_se.style.display='none'
				obj.comp_nm.style.display="inline";

			}

		}
	*/
	
	 <%-- 
	    중복체크(공통)
	  2013_05_02(목)현재사용안함.
	 function doCheck(e_comp_nm){
	 	
	 	var requestUrl='<%= request.getContextPath() %>/B_Common.do?cmd=CompNameCheck&e_comp_nm='+e_comp_nm;
	 	var result=0;
	 	
	 	var xmlhttp = null;
	 	var xmlObject = null;
	 	var resultText = null;


	 	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	 	xmlhttp.open("GET", requestUrl, false);
	 	xmlhttp.send(requestUrl);

	 	resultText = xmlhttp.responseText;

	 	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	 	xmlObject.loadXML(resultText);
	 	
	 	result=xmlObject.documentElement.childNodes.item(0).text;

	 	return result;
	 	
	 }
	 --%>
	
	/*업체중복확인 check 2013_03_26(화)shbyeon.
	  2013_05_02(목) 현재 사용안함.
	 function fnDuplicateCheck() {
		
	 	var frm = document.currentStaRegist; 
	 	
	 	
	 	if(frm.e_comp_nm.value.length == 0){
	 		alert("원청사를 입력하세요.");
	 		return;
	 	}
	 	
	 	var result= doCheck(frm.e_comp_nm.value);
	 	
	 	if(result==1){
	 		alert("이미 등록된 업체명입니다. 업체조회로 조회 후 해당 업체확인 후 다시 입력해주세요.");
	 		
	 		if(alert){
	 			
	 		frm.e_comp_nm.focus();
	 		}
	 		
	 		return;
	 	}else {
	 		if( confirm("사용 가능한 업체명 입니다. 사용하시겠습니까?") ) {
	 			frm.trueflag.value  =  frm.e_comp_nm.value ;	
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	*/
	
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
	
	
	//JQuery - 상품코드 마우스로 데이터 넘겨주기.
	$(function() {
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){ //더블클릭 function 시작..
			
			  $('#NoCode').remove(); //상품코드 추가 시 Cart<li>에 있는  상품코드를 넣어주세요. text 지우기.
		      $(this).hide(); //상품코드 선택시 해당 상품코드 hide 숨기기.
		      //console.log($(this).attr("id")); 해당 상품코드 id값 콘솔로 보기.
		    
		    //상품코드 더블클릭시 해당 속성 id값으로 value에 셋팅해주고. ondbclick=delCode로 cart안에 상품코드가 없을 시엔 상품코드를 넣어주세요. 
		    //상품코드 추가시 delCode function 으로 cart ol 목록 remove 숨기기. cart ol 목록 없으면서 products  
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+"<a>"+$(this).html()+"</a>"+" <input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
		     
		  });
		  
		  /* $('#cart ol li').on("dblclick", , function() {
			  alert('Success'); 사용안함.
			});
			
		  $("#cart ol li").dblclick(function(){
			    //$(this).remove(); 사용안함.
			    $('#products ol li').append("<li>"+$(this).html()+"</li>");
		  });
		  */
	});	
	
	//상품코드 지우기(remove) 및 보여주기(show) 2013_05_06(월)shbyeon.
	function delCode(chk){
		//console.log($( "#cart ol li" ).length);
		if( $( "#cart ol li" ).length == 1){
			$("#cart ol").append("<li id='NoCode' class='placeholder' style='color: red;'>상품코드를 넣어주세요.</li>");
		}
		//alert($('#cart ol #'+chk).html()); hidden 데이터읽어 오는지 찍어본 alert
		$('#cart ol #'+chk).remove();
		$('#products #'+chk).show();
	}
	
	//영업주관사 == 고객사 동일선택 버튼 2013_05_06(월)shbyeon.
	function chkSaOperatingAdd(){
		var frm = document.currentStaRegist; 

		if(frm.comp_nm.value=='' && frm.e_comp_nm.value==''){
			alert('영업주관사를 입력하셔야 사용 가능합니다.');
			return ;
		}else{
			//수동입력 일때.
			if(frm.checkyn.checked==true){
				if(frm.chktest.checked==true){
		   		frm.OperatingCompany.value = frm.e_comp_nm.value;		
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
			//업체조회 일때.
			if(frm.checkyn.checked==false){
				if(frm.chktest.checked==true){
				frm.OperatingCompany.value = frm.comp_nm.value;	
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
		}
}
	
	//사원조회 첫 번째	
	function popSales(){
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=currentStaRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	
	//사원조회 두 번째
	function popSales_Second(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=currentStaRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	
	
//-->
</script>

</head>
<body >
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
  
  <!-- title -->
  	<div class="content_navi">영업지원 &gt; 영업진행현황</div>
	<h3><span>영</span>업진행현황등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
  <!-- title -->
			
	<div class="con currentStaRegistForm">
	<!-- 영업진행현황등록 -->
	<div>
	<h4 class="hidden_obj">영업진행현황등록</h4>
	
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
						
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
					
	</div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 등록 -->

  <!-- con -->
  <div id="excelBody">
    <form name="currentStaRegist" method="post" action="<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaRegist" enctype="multipart/form-data">
     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
	  <!-- 업체조회팝업 창에서 넘겨서 받아올 값. -->
	  <input type = "hidden" name = "comp_code" value=""/>
      <input type = "hidden" name = "owner_nm" value=""/>
      <input type = "hidden" name = "business" value=""/>
      <input type = "hidden" name = "b_item" value=""/>
      <input type = "hidden" name = "post" value=""/>
      <input type = "hidden" name = "address" value=""/>
      <input type = "hidden" name = "addr_detail" value=""/>
      <input type = "hidden" name = "permit_no" value=""/>
	  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
      <input type = "hidden" name = "user_id2" value="<%=dtoUser.getUserId()%>"/>
      <!-- 담당영업 (정) -->
      <input type = "hidden" name = "ChargeID" value = ""></input>
      <!-- 담당영업 (부) -->
      <input type = "hidden" name = "ChargeSecondID" value = ""></input>
      <!-- 중복체크 플래그 -->
      <input type="hidden" name="trueflag" value="true"></input>
      <input type="hidden" name="falseflag" value="false"></input>
 
 
	<fieldset>
			<legend>영업진행현황등록</legend>
	<table class="tbl_type" summary="영업진행현황등록(영업주관사, 영업주관사담당자, 영업주관사담당자연락처, 상품코드(자사/내자), 고객사, 예상프로젝트명, 예상수주액(VAT별도), 수주가능성, 담당영업, 기술분야배정인력, 예상시기)">
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
	<tbody>     
		
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>영업주관사</label></th>
			<td><input type="checkbox" id=""  name="checkyn" onClick="javascript:directInput();" class="check md0" title="수동입력" /><label for="">수동입력</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" maxlength="50" name="comp_nm" class="text" title="영업주관사" style="display:inline;width:300px;" readOnly /><input type="text" maxlength="50" name="e_comp_nm" class="text" title="영업주관사" style="display:none;ime-mode:active;width:300px;" /><!-- 2013_05_02 업체 중복체크 사용안함. <a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="중복확인" width="52" height="18" /></a> --><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a></td>
		</tr>
		
		<tr>
			<th><label for="">영업주관사담당자</label></th>
			<td><input type="text" name="SalesMan" id="" class="text" title="영업주관사담당자" style="width:200px;" maxlength="15"/></td>
		</tr>
							
		<tr>
			<th><label for="">영업주관사담당자연락처</label></th>
			<td><input type="text" id="" class="text" title="영업주관사담당자연락처" style="width:200px;"  name="SalesManTel" maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);"/></td>
		</tr>
          

  		
  		<tr>	
  			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>상품코드(자사/내자)</label></th>        
			<td class="prodCode">
				<div id="products" class="codeList">
				<h5>상품코드(자사/내자)</h5>
				<div id="catalog">
					<h6><a href="#">자사(내자)</a></h6>

					<ul>
							<%
	       						for(int x=0; x<codeList.size(); x++){
	       							ComCodeDTO codeDto = new ComCodeDTO();
	       							codeDto = (ComCodeDTO)codeList.get(x);
	       					%>
	       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
	       							</li>
	       					<%
	       						}
	       					%>
					</ul>

					<h6><a href="#">비자사(내자)</a></h6>
					<ul>
							<%
	       						for(int x=0; x<codeList2.size(); x++){
	       							ComCodeDTO codeDto = new ComCodeDTO();
	       							codeDto = (ComCodeDTO)codeList2.get(x);
	       					%>
	       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
	       							</li>
	       					<%
	       						}
	       					%>
					</ul>
					<h6><a href="#">비자사(외자)</a></h6>
					<ul>
							<%
	       						for(int x=0; x<codeList3.size(); x++){
	       							ComCodeDTO codeDto = new ComCodeDTO();
	       							codeDto = (ComCodeDTO)codeList3.get(x);
	       					%>
	       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
	       							</li>
	       					<%
	       						}
	       					%>
					</ul>
				</div>
			</div>
			<div id="cart">
				<h5>상품코드</h5>
				<ol>
					<li class="placeholder" style="color: #ff6600;" id="NoCode">상품코드를 넣어주세요.</li>
				</ol>
			</div>

			
			<div class="guide">
				<span class="guide_txt"><strong>* 자사상품코드 또는 내자상품코드 둘중 하나는 선택해주세요.</strong><br />
				* 상품코드 등록 방법은 <strong>더블클릭</strong>을 하여 좌측에 해당 상품코드 박스로 추가 등록 및 수정이 가능합니다.</span>
			</div>
			</td>
		</tr>
			
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사</label></th>
			<td><input type="text" id="" name="OperatingCompany" class="text" title="고객사" style="width:300px;" maxlength="100"/><input type="checkbox" id="" name="chktest" value="N" class="check" onclick="javascript:chkSaOperatingAdd();" title="영업주관사명 동일선택 " /><label for="">영업주관사명 동일선택 </label></td>
		</tr>
         
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상프로젝트명</label></th>
			<td><input type="text" name="ProjectName" id="" class="text" title="예상프로젝트명" style="width:300px;" maxlength="50"/></td>
		</tr>
							
		<tr>
			<th><label for="">예상수주액(VAT별도)</label></th>
			<td><input type="hidden" name="SalesProjections"  style="width:80px" value="" maxlength="18"/><input type="text" name="SalesProjections_view" maxlength="18" value="0" id="" class="text text_r" title="예상수주액(VAT별도)" style="width:200px;" onKeyUp = "saleCntCal('currentStaRegist.SalesProjections')"/> 원</td>
		</tr>
 
 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수주가능성</label></th>
								
          <td><%  
					  CodeParam codeParam = new CodeParam();
          			  codeParam.setType("select"); 
          			  codeParam.setStyleClass("td3");
					  codeParam.setFirst("전체");
					  codeParam.setName("Orderble");
					  codeParam.setSelected(""); 
					  //codeParam.setEvent("javascript:poductSet();"); 
					  out.print(CommonUtil.getCodeList(codeParam,"A03")); 
			  %>
		 	</td>
		
		</tr>       
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
			<td>정&nbsp;&nbsp;<!-- 담당영업 (정) --><input type="text" id="" name="user_nm" class="text" title="담당영업 정" style="width:100px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a>&nbsp;&nbsp;/&nbsp;&nbsp;부&nbsp;&nbsp;<!-- 담당영업 (부) --><input type="text" name="user_nm2" id="" class="text" title="담당영업 부" style="width:100px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales_Second();"/><a href="javascript:popSales_Second();" class="btn_type03"><span>사원조회</span></a></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>기술분야배정인력</label></th>
			<td><input type="text" name="AssignPerson" id="" class="text" title="기술분야배정인력" style="width:300px;" maxlength="25"/></td>
		</tr>


		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상시기</label></th>
         <td>
         <input type="hidden" name="DateProjections" value=""></input>
          	<input type="hidden" name="Quarter" value=""></input>
         <script>
         document.write("<select name='target_year' id='target_year' title='년도 선택' style='width:70px'>");
          var now = new Date();  
          var now_year = now.getFullYear() +5; //+1은 올해년도에서 +1년 한것. 
          for (var i=now_year;i>=2010;i--) 
          {   
         document.write("<option value='"+i+"'>"+i+"</option>"); 
         }  
          document.write(" </select>"); 
         </script> 년&nbsp;&nbsp;<select name="target_month" id="target_month" title="월 선택">
				    <option value='01'>1</option>
				    <option value='02'>2</option>
				    <option value='03'>3</option>
				    <option value='04'>4</option>
				    <option value='05'>5</option>
				    <option value='06'>6</option>
				    <option value='07'>7</option>
				    <option value='08'>8</option>
				    <option value='09'>9</option>
				    <option value='10'>10</option>
				    <option value='11'>11</option>
				    <option value='12'>12</option>
					</select> 월</td>
      		</table>
      	</fieldset>
     
    
   <!-- button -->
   <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
   <!-- //button -->
 
  </div>
  </div> 
  <!-- //영업진행현황등록 -->
   
   <div class="issueComm" id="comentYN">
   <%
		String ID = UserBroker.getUserId(request); //로그인 한 세션 ID
		String NAME = UserBroker.getUserNm(request); //로그인 한 세션 이름
   %>
		
	<!-- 이슈 코멘트 등록 폼 시작. -->	
		<h4>Issue Comment</h4>
		<fieldset>
			<legend>Issue Comment</legend>
			<div class="issueCon_area">
			
			<ul class="info">	
				<li><label for="">이슈 재기자 :</label> 
				<input type="text" name="SalesMan_co" id="" class="text" title="이슈 재기자" style="width:100px;" maxlength="10" onkeyup="javascript:test();"/><!-- 로그인 세션 ID 담당영업 파라미터 넘겨줘서 등록시 데이터 도 DB등록. -->
				<input type="hidden" name="ChargeID_co" value="<%=ID %>"></input></li>
				<li><span>담당영업 : <%=NAME %></span></li>
				<li><span>등록일 : <%=todayDate %></span></li>
			</ul>					
			
			<ul class="issueCon">
				<li><textarea id="" name="Contents" title="이슈내용" style="width:1078px;height:50px;" onKeyUp="js_Str_ChkSub('3000', this)"></textarea></li>
				<li><div class="fileUp"><input type="text" class="text" id="file1" title="첨부파일" style="width:1015px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="SalesFile" id="upload1" /></div><input type="hidden" name="SalesFileNm" value=""></input></li>
				<!-- <li class="btn_regist"><a href="#none">등록</a></li> -->
				<li><span class="guide_txt">* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 200M</span></li>
			</ul>
						
			
			</div>
		<!-- //이슈등록폼 -->
		</fieldset>
			<!-- 등록/수정/삭제 버튼
			<p class="btn_saveComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg_save_curr.gif" onclick="javascript:goSaveRep();" title="등록버튼" /></a></p>
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goSaveRep();" title="수정버튼" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goSaveRep();" title="삭제버튼" /></a></p>
			 -->
	<!-- 해당 이슈 코멘트 없을때 초기 화면 끝 -->
   </div>
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

<%= comDao.getMenuAuth(menulist,"10") %>
<script type="text/javascript">fn_fileUpload();</script>