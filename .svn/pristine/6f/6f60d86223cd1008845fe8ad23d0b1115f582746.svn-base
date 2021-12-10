<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String sForm =  (String)model.get("sForm");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>

<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>

<title>업체 등록</title>
<script>

<!--
function goSave(){
	var frm = document.companyRegist; 

    frm.comp_no.value=frm.comp_no1.value+'-'+frm.comp_no2.value;
	
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.comp_file.value;
	var strFile2 = frm.account_copy1.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);

	var lastIndex2 = strFile2.lastIndexOf('\\');
	var strFileName2 = strFile2.substring(lastIndex+1);
	
	if(fileCheckNm(strFileName)> 200){
		alert('[사업자등록증]의 (파일명)은/는 200자(byte)이상의 글자를  등록 할 수 없습니다.');
		return;
	}
	if(fileCheckNm(strFileName2)> 200){
		alert('[파일-사본1]의 (파일명)은/는  200자(byte)이상의 글자를 등록 할 수 없습니다.');
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
	
  
	if(frm.permit_no.value.length == 0){
		alert("사업자 등록번호를 입력하세요!");
		return;
	}

	if(frm.comp_nm.value.length == 0){
		alert("상호(법인명)을 입력하세요!");
		return;
	}
	if(frm.comp_no1.value.length == 0 || frm.comp_no2.value.length == 0){
		alert("법인등록번호(주민등록번호)를  입력하세요!");
		return;
	}
	if(frm.owner_nm.value.length == 0){
		alert("대표자명을  입력하세요!");
		return;
	}
	if(frm.business.value.length == 0){
		alert("업태를  입력하세요!");
		return;business
	}
	if(frm.b_item.value.length == 0){
		alert("종목을  입력하세요!");
		return;business
	}
		if(frm.post.value.length == 0){
		alert("본점 소재지를  입력하세요!");
		return;business
	}
	
	if(frm.comp_file.value != "" && !isImageFile(frm.comp_file.value)){
			alert("사업자 등록증의  첨부 가능한 파일 유형은 \n PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
	if(frm.account_copy1.value != "" && !isImageFile(frm.account_copy1.value)){
			alert(" 통장사본1의 첨부 가능한 파일 유형은 PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
	if(frm.account_copy2.value != "" && !isImageFile(frm.account_copy2.value)){
			alert(" 통장사본2의 첨부 가능한 파일 유형은 PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
	if(frm.account_copy3.value != "" && !isImageFile(frm.account_copy3.value)){
			alert(" 통장사본3의 첨부 가능한 파일 유형은 PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
	if(frm.account_copy4.value != "" && !isImageFile(frm.account_copy4.value)){
			alert(" 통장사본4의 첨부 가능한 파일 유형은 PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
	if(frm.account_copy5.value != "" && !isImageFile(frm.account_copy5.value)){
			alert(" 통장사본5의 첨부 가능한 파일 유형은 PDF, GIF, JPG, TIF, BMP, PNG 이상 6종 입니다.");
			return; 				
	}
	
		frm.open_dt.value = $("#calendarData1").val().replace(/-/g,'');//frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		
		var dates = frm.open_dt.value;

		frm.pYear1.value = dates.substr(0,4);
		frm.pMonth1.value = dates.substr(4,2);
		frm.pDay1.value = dates.substr(6,2);
		
		
		var Y = frm.pYear1.value;
		var M = frm.pMonth1.value;
		var D = frm.pDay1.value;
		
		if(Y.length>0){
			if (!isNumber(trim(Y))) {
				alert("년도는 숫자만 입력이 가능합니다.");
					Y=onlyNum(Y);
				frm.pYear1.value ="";
				return;
				
			}else{
					Y=onlyNum(Y)
				} 
			}
		if(Y.length<4){
			alert('년도는 4자리수 미만사용불가능합니다.');
			Y=onlyNum(Y);
			frm.pYear1.value ="";
			return;
		}else{
			Y=onlyNum(Y)
		}
		
		
		if(M.length>0){
			if (!isNumber(trim(M))) {
				alert("월자는 숫자만 입력이 가능합니다.");
					Y=onlyNum(M);
				frm.pMonth1.value ="";
				return;
				
			}else{
					Y=onlyNum(M);
					
				} 
			}
		if(M.length<2){
			alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
			M=onlyNum(M);
			frm.pMonth1.value ="";
			return;
		}else{
			M=onlyNum(M)
		}
		if(D.length>0){
			if (!isNumber(trim(D))) {
				alert("일자는 숫자만 입력이 가능합니다.");
					Y=onlyNum(D);
				frm.pDay1.value ="";
				return;
			
			}else{
				Y=onlyNum(D);	
				}
			}
		if(D.length<2){
			alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
			D=onlyNum(D);
			frm.pDay1.value ="";
			return;
		}else{
			D=onlyNum(D)
		}
		if(Y.length==0){
			alert('년도 입력하세요.');
			return;
		}
		if(M.length==0){
			alert('월자를 입력하세요.');
			return;
		}
		if(M > 12){
			alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

			frm.pMonth1.value ="";
			return;
		}else{
			Y=onlyNum(M);
		}
			
		if(D.length==0){
			alert('일자를 입력하세요.');
			return;
		}
		if(D > 31){
			alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
			frm.pDay1.value ="";
			return;
		}else{
			Y=onlyNum(D);
		}
		frm.COMPANY_FILENM.value = strFileName;
		frm.ACCOUNT_COPYNM1.value = strFileName2;
		frm.submit();
	}

	function cancle(){
		
		var frm = document.companyRegist;
	
		if(frm.sForm.value=='N'){
			frm.action='<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
		}
		frm.submit();
	
	}
	
	//도로명 검색.
	function searchZipCode() {
			var name = "우편번호검색";
			var features = "width=450,height=445,scrollbars=yes,top=100,left=100,status";
			var popupWin = window.open("", name, features);
			document.postForm.target=name;
			document.postForm.submit();
			centerSubWindow(popupWin, 450, 445);
			popupWin.focus();
	}
	
	//기존 주소로 검색.
	function searchZipCode2() {
		var name = "우편번호검색";
		var features = "width=450,height=445,scrollbars=yes,top=100,left=100,status";
		var popupWin = window.open("", name, features);
		document.postForm2.target=name;
		document.postForm2.submit();
		centerSubWindow(popupWin, 450, 445);
		popupWin.focus();
	}
	
	function centerSubWindow(winName, ww, wh){
	        if (document.layers) {
	            sw = screen.availWidth;
	            sh = screen.availHeight;
	        }
	        if (document.all) {
	            sw = screen.width;
	            sh = screen.height;
	        }
	
	        w = (sw - ww)/2;
	        h = (sh - wh)/2;
	        winName.moveTo(w,h);
	}   
	function popCompNo(){
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo&sForm=companyRegist","","width=400,height=500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	function compNocheck(form){
		   
		   var frm=document.companyRegist;
		   var obj=eval("document."+form);
		   var comp1=frm.comp_no1;
		   var comp2=frm.comp_no2;
		   var comp=frm.comp_no.value;
		   if(obj.value.length>0){
				if (!isNumber(trim(obj.value))) {
					alert("숫자만 입력해 주세요.");
					obj.value=onlyNum(obj.value);
				} 
		   }
	        
			
			if(comp1.value.length==6){
				comp2.focus();
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
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp" || ext == "png") {
				return true;
			} else {
				return false;
			}
		}
	}
	
	/*
	// submit시  엔터키 이벤트
	 document.onkeypress = keyPress ;
	 function keyPress(){
	 	var ieKey = window.event.keyCode ;
	 	if( ieKey == 13 ){
	 		goSave();
	 	}
	 }
	 */
	
	
	 
	 //주소 검색조건 설정.
	 function addressWhereCheck(){
		 var chk = $("#adrChk_tr input:checked").val();
		 //alert(chk);
		 
		 if(chk == "1"){
			 $('#NewAddress').show();		//도로명 우편번호 검색 Show
			 $('#OriAddress').hide();		//기존 주소 우편번호 검색 hide
		 }else{
			 $('#NewAddress').hide();		//도로명 우편번호 검색 hide
			 $('#OriAddress').show();		//기존 주소 우편번호 검색 Show
		 }
	 }
	 
	 //페이지 초기 로드 시 호출.
	 $(function(){
			//기존 우편번호 검색 a태그 hide
			$('#OriAddress').hide();
	});
	 

	 function openCal(){
		 $('#calendarData1').datepicker("show");
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
    <div class="content_navi">총무지원 &gt; 업체관리</div>
	<h3><span>업</span>체등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
<!-- title -->

	<!--도로명 우편번호 폼-->
		<form name="postForm" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
			<input type = "hidden" name = "pForm" value="companyRegist"/>
			<!--세팅될 폼명-->
			<input type = "hidden" name = "pZip" value="post"/>
			<!--세팅될 우편번호-->
			<input type = "hidden" name = "pAddr" value="address"/>
			<!--세팅될 주소-->
		</form>
	<!--도로명 우편번호 폼-->
				  
	<!--기존 주소 우편번호 폼-->
		<form name="postForm2" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost2">
			<input type = "hidden" name = "pForm" value="companyRegist"/>
			<!--세팅될 폼명-->
			<input type = "hidden" name = "pZip" value="post"/>
			<!--세팅될 우편번호-->
			<input type = "hidden" name = "pAddr" value="address"/>
			<!--세팅될 주소-->
		</form>
	<!--기존 주소 우편번호 폼-->
  
	<div class="con">
	
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
	
	</div>  
	<!-- //컨텐츠 상단 영역 -->
				
	<!-- 등록 -->	
    <form name="companyRegist" method="post" action="<%= request.getContextPath()%>/B_Company.do?cmd=companyRegist"   enctype="multipart/form-data">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "sForm" value="<%=sForm%>"/>
      				  <input type = "hidden" name = "pYear1" value=""/>
    			 <input type = "hidden" name = "pMonth1" value=""/>
  				   <input type = "hidden" name = "pDay1" value=""/>

	<fieldset>
		<legend>업체등록</legend>
	<table class="tbl_type" summary="업체등록(사업자등록번호, 상호(법인명), 법인등록번호(주민등록번호), 대표자명, 업태, 종목, 주소검색조건설정, 본점소재지, 개업일, 사업자등록증, 통장사본, 업체평가)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
    
    <tbody>    
		
		<tr>
			<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
			<th><label for="permit_no"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사업자등록번호</label></th>
			<td><input type="text" id="permit_no" name="permit_no" class="text" title="사업자등록번호" style="width:200px;" readOnly onClick="javascript:popCompNo();"/><a href="javascript:popCompNo();" class="btn_type03"><span>조회</span></a></td>
		</tr>        
        
		<tr>
			<th><label for="comp_nm"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>상호(법인명)</label></th>
			<td><input type="text" id="comp_nm" name="comp_nm" class="text" title="상호(법인명)" style="width:300px;" /></td>
		</tr>
        
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>법인등록번호(주민등록번호)</label></th>
			<td><input type="text" id="" name="comp_no1" class="text" title="앞번호" style="width:80px;" maxlength="6"  />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="" name="comp_no2" class="text" title="뒷번호" style="width:80px;" maxlength="7" /><input type ="hidden" name ="comp_no" value=""  maxlength="14" ></td>
		</tr>
        
		<tr>
			<th><label for="owner_nm"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>대표자명</label></th>
			<td><input type="text" id="owner_nm" name="owner_nm" class="text" title="대표자명" style="width:300px;"  maxlength="100" /></td>
		</tr>
        
		<tr>
			<th><label for="business"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>업태</label></th>
			<td><input type="text" id="business" name="business" class="text" title="업태" style="width:917px;" maxlength="250"/></td>
		</tr>
        
		<tr>
			<th><label for="b_item"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>종목</label></th>
			<td><input type="text" id="b_item" name="b_item" class="text" title="종목" style="width:917px;" maxlength="250" /></td>
		</tr>
        
        <tr id="adrChk_tr">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>주소검색조건설정</label></th>
			<td><input type="radio" id="adrChk" name="adrChk" class="radio md0" value="1" checked="checked" onclick="javascript:addressWhereCheck();" title="도로명으로 찾기" /><label for="">도로명으로 찾기</label><input type="radio" id="adrChk" name="adrChk" class="radio" title="기존 주소로 찾기" value="2" onclick="javascript:addressWhereCheck();"/><label for="">기존 주소로 찾기</label></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>본점소재지</label></th>
			<td>
				
				<ul class="listD">
					<li class="first"><input type="text" id="" name="post" readOnly class="text" title="우편번호" style="width:80px;" /><a id="NewAddress" value="우편번호" href="javascript:searchZipCode();" class="btn_type03"><span>우편번호</span></a><a id="OriAddress" value="우편번호" href="javascript:searchZipCode2();" class="btn_type03"><span>우편번호</span></a></li>
					<li><input type="text" id=""  name="address" class="text" title="기본주소" style="width:917px;" maxlength="100"/></li>
					<li><input type="text" id="" name="addr_detail" class="text" title="상세주소" style="width:917px;" maxlength="100"/></li>
				</ul>
			
			</td>
		</tr>
        
 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>개업일</label></th>
			<td>
				<!-- 
				<input type="text" id="" class="text" title="년" style="width:40px;" /> 년&nbsp;&nbsp;
				<input type="text" id="" class="text" title="월" style="width:40px;" /> 월&nbsp;&nbsp;
				<input type="text" id="" class="text" title="일" style="width:40px;" /> 일&nbsp;&nbsp; 
				<img onclick="openCal();" src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" />
				 -->
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;"/></span>
				<input type="hidden" name="open_dt" class="in_txt"  style="width:80px" value="" />
			</td>
		</tr>
        
        
        <!--tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>담당자명</td>
				<td><input type="text" name="charge_nm" class="in_txt" style="width:200px" maxlength="20"></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>담당자 이메일</td>
				<td><input type="text" name="charge_email" class="in_txt" style="width:200px" maxlength="50"></td>
			</tr-->
       
       <tr>
			<th><input type="hidden" name="COMPANY_FILENM" value=""></input>
			<input type="hidden" name="ACCOUNT_COPYNM1" value=""></input>
			<label for="">사업자등록증</label></th>
			<td><div class="fileUp"><input type="text" class="text" id="file1" title="사업자등록증" style="width:852px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="comp_file" id="upload1" onKeyUp = "compFileNmCheck('companyRegist.comp_file')" /></div></td>
	   </tr>
      
	   <tr>
		   <th><label for="">통장사본</label></th>
			<td>
				<ul class="listD">
					<li class="first"><div class="fileUp">사본1&nbsp;&nbsp;<input type="text" class="text" id="file2" title="통장사본1" style="width:816px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="account_copy1" id="upload2" /></div></li>
					<li><div class="fileUp">사본2&nbsp;&nbsp;<input type="text" class="text" id="file3" title="통장사본2" style="width:816px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="account_copy2" id="upload3" /></div></li>
					<li><div class="fileUp">사본3&nbsp;&nbsp;<input type="text" class="text" id="file4" title="통장사본3" style="width:816px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="account_copy3" id="upload4" /></div></li>
					<li><div class="fileUp">사본4&nbsp;&nbsp;<input type="text" class="text" id="file5" title="통장사본4" style="width:816px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="account_copy4" id="upload5" /></div></li>
					<li><div class="fileUp">사본5&nbsp;&nbsp;<input type="text" class="text" id="file6" title="통장사본5" style="width:816px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="account_copy5" id="upload6" /></div></li>
					<li class="guide_txt">* 첨부가능 파일유형 : PDF, GIF, JPG, TIF, BMP, PNG / 첨부가능 용량 : 최대 10M</li>
				</ul>
			</td>
		</tr> 
       
		<tr>
			<th><label for="">업체평가</label></th>
			<td>
				<ul class="listD">
					<li class="first"><textarea id="" name="COMPANYEVALUATION" title="업체평가" onKeyUp="js_Str_ChkSub('500', this)" style="width:917px;height:45px;"></textarea></li>
				</ul>
			</td>
		</tr>
	   
	   </tbody>
      </table>
     </fieldset>
    </form>
    
    <!-- button -->
    <div class="Bbtn_areaC">
    	<a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a>
    </div>
    <!-- //button -->
  </div>
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
<%= comDao.getMenuAuth(menulist,"00") %>
<script type="text/javascript">fn_fileUpload();</script>