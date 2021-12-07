<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.CodeParam" %>
<%@ page import ="com.huation.common.bankmanage.BankManageDTO" %>

<%
	Map model = (Map)request.getAttribute("MODEL");

	BankManageDTO bmDto = (BankManageDTO)model.get("bmDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String AccountNumber = (String)model.get("AccountNumber");
	String strDate = (String)model.get("strDate");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>세금계산서 발행</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
<!--
function goSave(){
	var frm = document.invoiceRegist; 
	
	
	var dates = frm.public_dt.value;
	var public_dts = dates.replace(/-/g,'');
	frm.pYear1.value = public_dts.substr(0,4);
	frm.pMonth1.value = public_dts.substr(4,2);
	frm.pDay1.value = public_dts.substr(6,2);
	
	frm.public_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	frm.pre_deposit_dt.value = $("#calendarData2").val().replace(/-/g,'');
	var dates = frm.pre_deposit_dt.value;
	/* var pre_deposit_dts = dates.replace(/-/g,''); */
	frm.pYear5.value = dates.substr(0,4);
	frm.pMonth5.value = dates.substr(4,2);
	frm.pDay5.value = dates.substr(6,2);

	
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;
	
	frm.deposit_dt.value = $("#calendarData3").val().replace(/-/g,'');
	var dates = frm.deposit_dt.value;
/* 	var deposit_dts = dates.replace(/-/g,''); */
	frm.pYear3.value = dates.substr(0,4);
	frm.pMonth3.value = dates.substr(4,2);
	frm.pDay3.value = dates.substr(6,2);
	
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;
	
	
/* 	

	frm.public_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //입금일자
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //입금예상일자
	 */
	/*
	2013_05_13(월)shbyeon. 사용자 요청으로 인해 사용안함.
	description:세금계산서 발행의 경우 기존에 발행번호로 productno 제품코드를 가져와 DB에 넣었으나.
	사용자 요청으로인해 필요없는 부분이라 주석으로 막아 버리고 null값으로 처리함.
	if(frm.productno.value.length == 0){
		alert("선택된 견적서의 제품번호가 없습니다. \n 해당 견적서의 제품번호를 관리자를 통해 확인하세요");
		return;

	}
	*/

	if(frm.deposit_dt.value.length != 0){
		if(frm.deposit_amt.value== 0){
			alert("입금일을 입력하신경우 입금금액을 필수로 입력하셔야 합니다.");
			return;
		}
	}

	if(frm.deposit_amt.value!= 0){
		if(frm.deposit_dt.value.length == 0){
			alert("입금금액 입력시 입금일을 필수로 입력하셔야 합니다.");
			return;
		}
	}

	if(frm.p_public_no.value.length == 0){
		alert("견적서 발행번호를 입력하세요!");
		return;
	}

	if(frm.approve_no.value.length == 0){
		alert("승인번호를 입력하세요!");
		return;
	}
		
	if(frm.receiver.value.length == 0){
		alert("수신(수령)인을 입력하세요!");
		return;
	}

	if(frm.public_dt.value.length == 0){
		alert("발행일자를 입력하세요!");
		return;
	}

	if(frm.comp_code.value.length == 0){
		alert("업체정보 입력하세요!");
		return;
	}
	if(frm.pre_deposit_dt.value.length == 0){
		alert("입금예상일자를 선택하세요.");
		return;
	}
	
	if(frm.public_dt.value > frm.pre_deposit_dt.value){
		alert('입금예상일자보다 발행일자가 큽니다.');
		return;
	}
	
	//달력input(텍스트창입력시) 벨류데이션체크 2012.12.03(월) bsh.(입금예상일자)
	var Y = frm.pYear5.value;
	var M = frm.pMonth5.value;
	var D = frm.pDay5.value;
	
	if(Y.length>0){
		if (!isNumber(trim(Y))) {
			alert("년도는 숫자만 입력이 가능합니다.");
				Y=onlyNum(Y);
			frm.pYear5.value ="";
			return;
			
		}else{
				Y=onlyNum(Y)
			} 
		}
	if(Y.length<4){
		alert('년도는 4자리수 미만사용불가능합니다.');
		Y=onlyNum(Y);
		frm.pYear5.value ="";
		return;
	}else{
		Y=onlyNum(Y)
	}
	
	
	if(M.length>0){
		if (!isNumber(trim(M))) {
			alert("월자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(M);
			frm.pMonth5.value ="";
			return;
			
		}else{
				Y=onlyNum(M);
				
			} 
		}
	if(M.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		M=onlyNum(M);
		frm.pMonth5.value ="";
		return;
	}else{
		M=onlyNum(M)
	}
	if(D.length>0){
		if (!isNumber(trim(D))) {
			alert("일자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(D);
			frm.pDay5.value ="";
			return;
		
		}else{
			Y=onlyNum(D);	
			}
		}
	if(D.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		D=onlyNum(D);
		frm.pDay5.value ="";
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

		frm.pMonth5.value ="";
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
		frm.pDay5.value ="";
		return;
	}else{
		Y=onlyNum(D);
	}

	
	if(frm.pre_deposit_an.value == ""){
		alert("입금예정계좌를 선택하세요.");
		return;
	}
	
	//달력input(텍스트창입력시) 벨류데이션체크 2012.12.03(월) bsh.(입금일자)
	//입금일자가 text input 창에 입력될 시에 시작되는 벨류데이션체크
	if(frm.deposit_dt.value != ''){
		
	var Y1 = frm.pYear3.value;
	var M1 = frm.pMonth3.value;
	var D1 = frm.pDay3.value;
	
	if(Y1.length>0){
		if (!isNumber(trim(Y1))) {
			alert("년도는 숫자만 입력이 가능합니다.");
				Y1=onlyNum(Y1);
			frm.pYear3.value ="";
			return;
			
		}else{
				Y1=onlyNum(Y1)
			} 
		}
	if(Y1.length<4){
		alert('년도는 4자리수 미만사용불가능합니다.');
		Y1=onlyNum(Y1);
		frm.pYear3.value ="";
		return;
	}else{
		Y1=onlyNum(Y1)
	}
	
	
	if(M1.length>0){
		if (!isNumber(trim(M1))) {
			alert("월자는 숫자만 입력이 가능합니다.");
				Y1=onlyNum(M1);
			frm.pMonth3.value ="";
			return;
			
		}else{
				Y1=onlyNum(M1);
				
			} 
		}
	if(M1.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		M1=onlyNum(M1);
		frm.pMonth3.value ="";
		return;
	}else{
		M1=onlyNum(M1)
	}
	if(D1.length>0){
		if (!isNumber(trim(D1))) {
			alert("일자는 숫자만 입력이 가능합니다.");
				Y1=onlyNum(D1);
			frm.pDay3.value ="";
			return;
		
		}else{
			Y1=onlyNum(D1);	
			}
		}
	if(D1.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		D1=onlyNum(D1);
		frm.pDay3.value ="";
		return;
	}else{
		D1=onlyNum(D1)
	}
	if(Y1.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(M1.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(M1 > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.pMonth3.value ="";
		return;
	}else{
		Y1=onlyNum(M1);
	}
		
	if(D1.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(D1 > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.pDay3.value ="";
		return;
	}else{
		Y1=onlyNum(D1);
	}
	if(frm.public_dt.value > frm.deposit_dt.value){
		alert('입금일자보다 발행일자가 큽니다.');
		return;
	}
}

	if(frm.deposit_amt.value!= 0 && frm.deposit_dt.value.length != 0){
		frm.state.value='03';
	}else{
		frm.state.value='01';
	}
		
	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.public_no.value=frm.p_public_no.value;


	frm.submit();
}

	function cancle(){
		
		var frm = document.invoiceRegist;
		frm.action='<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
		frm.submit();
	
	}

	
	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY&sForm=invoiceRegist&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}

	function popComp(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_Ic&sForm=invoiceRegist","","width=850,height=626,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}

	function saleCntCal(form){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.invoiceRegist;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}

		if (!isNumber(trim(v_obj.value))) {
			alert("숫자만 입력해 주세요.");
		} 

		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;

		if(form=='invoiceRegist.supply_price'){	
			var vat=parseInt(parseInt(costobj.supply_price.value,10)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		}

		var tcost=parseInt(costobj.supply_price.value,10)+parseInt(costobj.vat.value,10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		v_obj.focus();

	}
	
	function poductSet(){
	  alert(document.invoiceRegist.productno[0].value);
		
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
	<div class="content_navi">영업지원 &gt; (구)세금계산서등록</div>
	<h3><span>(구)</span>세금계산서등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
	<!-- //title -->	
			
	<div class="con">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area" id="excelBody">
					
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
				
	</div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 등록 -->  
  
  <!-- calendar -->
  <div id="CalendarLayer" style="display:none; width:172px; height:176px; ">
    <iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
  </div>
  <!-- //calendar -->
  
    <form name="invoiceRegist" method="post" action="<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceRegist">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "comp_code" value=""/>
      <input type = "hidden" name = "permit_no" value=""></input>
      <input type = "hidden" name = "public_no" value=""/>
      <input type = "hidden" name = "user_id" value=""/>
      <input type = "hidden" name = "user_nm" value=""/>
      <input type = "hidden" name = "sales_charge" value=""/>
      <input type = "hidden" name = "e_comp_nm" value=""/>
      <input type = "hidden" name = "state" value=""/>
      
     <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>

      <input type = "hidden" name = "pYear5" value=""/>
     <input type = "hidden" name = "pMonth5" value=""/>
     <input type = "hidden" name = "pDay5" value=""/>

      <input type = "hidden" name = "pYear3" value=""/>
     <input type = "hidden" name = "pMonth3" value=""/>
     <input type = "hidden" name = "pDay3" value=""/>
      
      
      
      <!-- span class="tbl_line_top">&nbsp;</span -->
      
	<fieldset>
		<legend>(구)세금계산서등록</legend>
		<table class="tbl_type" summary="(구)세금계산서등록(견적서발행번호(발행번호, 제목), 계산서금액(공급가, 부가세, 합계), 구분(승인번호, 수신(수령)인), 발행일자, 전자세금계산서발행기관, 공급받는자(상호(법인명), 업태, 종목, 대표자명, 본점소재지), 입금예상일자, 입금예상계좌, 입금금액, 입금일자, 참고사항)">
			
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
        
        <tbody>
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적서발행번호</label></th>
				<td class="listT">
					<table class="tbl_type" summary="견적서발행번호(발행번호, 제목)">
						
						<colgroup>
							<col width="33%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
					<tbody>
						<tr class="last">
							<td><input type="text" id="" name="p_public_no" class="text" title="발행번호" style="width:188px;" readOnly onClick="javascript:popPublicNo();"/><a href="javascript:popPublicNo();" class="btn_type03"><span>발행번호조회</span></a></td>
							<th><label for="">제목</label></th>
							<td class="last"><input type="text" name="title" id="" class="text dis" title="제목" style="width:494px;" readOnly/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
					</tbody>
					</table>
				</td>
		</tr>        
        
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계산서금액</label></th>
				<td class="listT">
					
					<table class="tbl_type" summary="계산서금액(공급가, 부가세, 합계)">
						<colgroup>
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
					<tbody>
						<tr class="last">
							<th><label for="">공급가</label></th>
							<td><input type="hidden" name="supply_price" class="text"  style="width:80px" value="" /><input type="hidden" name="vat" class="text"  style="width:80px" value="" /><input type="hidden" name="total_amt" class="text"  style="width:80px" value="" /><input type="text" id="" name="supply_price_view" class="text text_r" title="공급가" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('invoiceRegist.supply_price')" value="0"/> 원</td>
							
							<th><label for="">부가세</label></th>
							<td><input type="text" id="" name="vat_view" class="text text_r" title="부가세" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('invoiceRegist.vat')" value="0"/> 원</td>
							
							<th><label for="">합계</label></th>
							<td class="last"><input type="text" id="" name="total_amt_view" class="text text_r" title="합계" style="width:163px;" readOnly value="0"/> 원</td>
						</tr>
					</tbody>
					</table>
				</td>
		</tr>

        <input type = "hidden" name = "productno" value="" />
        <!--tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>제품명</td>
				<td><%
							//CodeParam codeParam = new CodeParam();
							//codeParam.setType("select"); 
							//codeParam.setStyleClass("td3");
							//codeParam.setFirst("전체");
							//codeParam.setName("productno");
							//codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							//out.print(CommonUtil.getCodeList(codeParam,"A02")); 
						%></td>
		</tr-->

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구분</label></th>
				<td class="listT">
					
					<table class="tbl_type" summary="구분(권, 호, 관리번호, 승인번호, 수신(수령)인)">
						<colgroup>
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
					<tbody>
						<tr class="last">
							<th><label for="">승인번호</label></th>
							<td><input type="text" id=""  name="approve_no" class="text" title="승인번호" style="width:168px;" maxlength="50"/></td>
							<th><label for="">수신(수령)인</label></th>
							<td class="last"><input type="text" id="" name="receiver" class="text" title="수신(수령)인" style="width:200px;"  maxlength="10"/></td>
						</tr>
					</tbody>
					</table>
				</td>
			</tr>
  
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발행일자</label></th>
				<td><span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" value="<%=strDate%>"/></span><input type="hidden" name="public_dt" class="text"  style="width:100px" value="<%=strDate%>"/></td>
			</tr>

			<tr>
				<th><label for="">전자세금계산서발행기관</label></th>
				<td><input type="text" id="" name="public_org" class="text" title="전자세금계산서발행기관" style="width:300px;" maxlength="25"/></td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>공급받는자</label></th>
					<td class="listT">
						<table class="tbl_type" summary="공급받는자(상호(법인명), 업태, 종목, 대표자명, 본점소재지)">
							
							<colgroup>
								<col width="11%" />
								<col width="22%" />
								<col width="11%" />
								<col width="22%" />
								<col width="11%" />
								<col width="*" />
							</colgroup>
									
					<tbody>
						<tr>
							<th><label for="">상호(법인명)</label></th>
								<td><input type="text" id="" name="comp_nm" class="text" title="상호(법인명)" style="width:103px;" readOnly onClick="javascript:popComp();"/><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a></td>
										
							<th><label for="">업태</label></th>
								<td><input type="text" id="" name="business" class="text" title="업태" style="width:168px;" readOnly/></td>
										
							<th><label for="">종목</label></th>
								<td class="last"><input type="text" id="" name="b_item" class="text" title="종목" style="width:178px;" readOnly/></td>
						</tr>
        
 						<tr class="last">
							<th><label for="">대표자명</label></th>
								<td><input type="text" id="" name="owner_nm" class="text" title="대표자명" style="width:168px;" readOnly/></td>
										
							<th><label for="">본점소재지</label></th>
								<td colspan="3" class="last">
									<ul class="listD">
										<li class="first"><input type="text" id="" name="post" class="text" title="우편번호" style="width:80px;" readOnly/></li>
												
										<li>
											<input type="text" id="" name="address" class="text" title="기본주소" style="width:239px;" readOnly/> 
											<input type="text" id="" name="addr_detail" class="text" title="상세주소" style="width:239px;" readOnly/>
										</li>
									</ul>
								</td>
							</tr>       
          
						</tbody>
						</table>
					</td>
				</tr>
				
				<tr>
					<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입금예상일자</label></th>
						<td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;"/></span><input type="hidden" name="pre_deposit_dt" class="text"  style="width:100px" value=""/></td>
				</tr>				

				<tr>
					<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입금예상계좌</label></th>
						<td>	
							<%
								CodeParam codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("td3");
								codeParam.setFirst("전체");
								codeParam.setName("pre_deposit_an");
								codeParam.setSelected(""); 
								//codeParam.setEvent("javascript:poductSet();"); 
								out.print(CommonUtil.getCodeListHanSeqq(codeParam,"BankAC")); 
							%>
						</td>
				</tr>

				<tr>
					<th><label for="">입금금액</label></th>
						<td><input type="hidden" name="deposit_amt" class="in_txt"  style="width:80px" value="0" /><input type="text" id="" name="deposit_amt_view" class="text" title="입금금액" style="width:200px;" maxlength="18"  onKeyUp = "saleCntCal('invoiceRegist.deposit_amt')" value="0"/> 원<span class="guide_txt">&nbsp;&nbsp;* 입금금액 입력 시 입금일자는 필수 입력 항목입니다.</span></td>
				</tr>

				<tr>
					<th><label for="">입금일자</label></th>
						<td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;"/></span><input type="hidden" name="deposit_dt" class="text"  style="width:100px" value=""/></td>
				</tr>
   
				<tr>
					<th><label for="">참고사항</label></th>
					<td><textarea id="" name="reference" title="참고사항" style="width:916px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	</form>
 	<!-- //등록 -->
				
	<!-- 가이드텍스트 -->
	<p class="guide_txt">업체 등록이 되어 있지 않으면 세금계산서를 발행 할 수 없습니다. 사업자등록증 및 통장사본 수령 후 업체를 등록하십시오.</p>
	<!-- //가이드텍스트 -->
                 
	<!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"16") %>