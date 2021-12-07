<%@page import="com.huation.common.estimate.EstimateDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO" %>
<%@ include file="/jsp/hueware/common/base.jsp" %>

<%

	

	InvoiceDTO invoiceDto = (InvoiceDTO)model.get("invoiceDto");
	EstimateDTO esDto = new EstimateDTO();
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>수정사유선택</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/imagefax.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"/></script>
<script>
//실시간반영

function invoiceModify1(){
	
	self.close();
	opener.invoiceModify_1(); 
}

function invoiceModify2(){
	
	self.close();
	opener.invoiceModify_2(); 
	
}
function invoiceModify3(){
	
	self.close();
	opener.invoiceModify_3(); 
	
}
function invoiceModify4(){
	
	self.close();
	opener.invoiceModify_4(); 
	
}
function invoiceModify5(){
	
	self.close();
	opener.invoiceModify_5(); 
	
}
</script>
</head>

<body id="popup" <%=BODYEVENT %> class="pop_body_bgAll">
<form name="invoiceModifyForm" method="post" action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=invoiceModifyForm" enctype="multipart/form-data">
 	 <input type = "hidden" name = "gun1" value="">
 	 <input type = "hidden" name = "ho1" value="">
 	 <input type = "hidden" name = "manage_no1" value="">
 	  <input type = "hidden" name = "modifyFlag" value="">
      <input type = "hidden" name = "comp_code" value="<%=invoiceDto.getComp_code()%>">
      <input type = "hidden" name = "permit_no" value="<%=invoiceDto.getPermit_no() %>"></input>
      <input type = "hidden" name = "TELL" value="<%=invoiceDto.getTELL()%>">
      <input type = "hidden" name = "E_MAIL" value="<%=invoiceDto.getE_MAIL()%>">
      <input type = "hidden" name = "public_no" value="<%=invoiceDto.getPublic_no()%>">
      <input type = "hidden" name = "mgtkey" value="<%=invoiceDto.getMGTKEY()%>">
      <input type = "hidden" name = "address" value="<%=invoiceDto.getAddress()%>">
      <input type = "hidden" name = "addrdetail " value="<%=invoiceDto.getAddr_detail()%>">
      <input type = "hidden" name = "business" value="<%=invoiceDto.getBusiness()%>">
      <input type = "hidden" name = "b_item" value="<%=invoiceDto.getB_item()%>">
      <input type = "hidden" name = "owner_nm" value="<%=invoiceDto.getOwner_nm()%>">
      <input type = "hidden" name = "receiver" value="<%=invoiceDto.getReceiver()%>">
      <input type = "hidden" name = "comp_nm" value="<%=invoiceDto.getComp_nm()%>">
      <input type = "hidden" name = "e_comp_nm" value="<%=invoiceDto.getComp_nm()%>">
      <input type = "hidden" name = "productno" value="<%=invoiceDto.getProductno()%>">
      <input type = "hidden" name = "state" value="<%=invoiceDto.getState()%>">
      <input type = "hidden" name = "supply_price" value="<%=invoiceDto.getSupply_price()%>">
      <input type = "hidden" name = "vat" value="<%=invoiceDto.getVat()%>">
      <input type = "hidden" name = "approve" value="<%=invoiceDto.getApprove_no()%>">
	  <input type = "hidden" name = "contract" value="<%=invoiceDto.getCONTRACT_CODE()%>">	   
 	
<!-- 레이아웃 시작 -->

<div id="wrap">
	<!-- title -->
	<div class="title">
		<h1 class="title_lft"><span class="title_rgt">수정사유 선택</span></h1>
	</div>
	<!-- //title -->
	<!-- 메인컨텐츠 시작 -->
	<div id="contents">
		<dl class="modiInvoice">
			<dt class="first">기재사항 착오정정</dt>
			<dd>필요적 기재사항 등을 착오 또는 착오 외의 사유로 잘못 발급한 경우, 세율을 잘못 적용하여 발급한 경우</dd>
			<dd>당초 취소분 1장(자동발급), 수정분 1장(직접입력) 총 2장 발급</dd>
			<dd class="btn"><a href="javascript:invoiceModify1();"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="선택" /></a></dd>
			<dt>착오에 의한 이중 발행</dt>
			<dd>착오로 이중 발급한 경우, 면세 등 발급대상이 아닌 거래 등에 대하여 발급한 경우</dd>
			<dd>당초에 발급한 세금계산서의 내용대로 부(-)의 수정세금계산서 1장 발급</dd>
			<dd class="btn"><a href="javascript:invoiceModify2();"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="선택" /></a></dd>
			<%-- <dt>공급가액 변동</dt>
			<dd>공급가액에 추가 또는 차감되는 금액이 발생한 경우</dd>
			<dd>증감시킬 금액에 대해 정(+) 또는 부(-)의 수정세금계산서 1장 발급</dd>
			<dd class="btn"><a href="javascript:invoiceModify3()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="선택" /></a></dd> --%>
			<dt>계약의 해제</dt>
			<dd>계약의 해제로 재화 또는 용역이 공급되지 않은 경우</dd>
			<dd>당초 발급한 세금계산서의 내용대로 부(-)의 수정세금계산서 1장 발급</dd>
			<dd class="btn"><a href="javascript:invoiceModify4()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif"  title="선택" /></a></dd>
			<dt>환입</dt>
			<dd>당초 공급한 재화가 환입(반품)된 경우</dd>
			<dd class="last">환입(반품)된 금액만큼만 부(-)의 수정세금계산서 1장 발급</dd>
			<dd class="btnlast"><a href="javascript:invoiceModify5()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif"  title="선택" /></a></dd>
		</dl>
	</div>
	<!-- 메인컨텐츠 끝 -->
	<!-- bottom 시작 -->
	<div id="button">
		<a href="javascript:window.close()"><img src="<%= request.getContextPath()%>/images/btn_close.gif" width="40" height="23" title="닫기"/></a>
	</div>
	<!-- bottom 끝 -->
</div>
<!-- 레이아웃 끝 -->
</form>
</body>
</html>
