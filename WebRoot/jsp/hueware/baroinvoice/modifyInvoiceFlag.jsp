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
<title>������������</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/imagefax.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.9.2.custom.js"/></script>
<script>
//�ǽð��ݿ�

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
 	
<!-- ���̾ƿ� ���� -->

<div id="wrap">
	<!-- title -->
	<div class="title">
		<h1 class="title_lft"><span class="title_rgt">�������� ����</span></h1>
	</div>
	<!-- //title -->
	<!-- ���������� ���� -->
	<div id="contents">
		<dl class="modiInvoice">
			<dt class="first">������� ��������</dt>
			<dd>�ʿ��� ������� ���� ���� �Ǵ� ���� ���� ������ �߸� �߱��� ���, ������ �߸� �����Ͽ� �߱��� ���</dd>
			<dd>���� ��Һ� 1��(�ڵ��߱�), ������ 1��(�����Է�) �� 2�� �߱�</dd>
			<dd class="btn"><a href="javascript:invoiceModify1();"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="����" /></a></dd>
			<dt>������ ���� ���� ����</dt>
			<dd>������ ���� �߱��� ���, �鼼 �� �߱޴���� �ƴ� �ŷ� � ���Ͽ� �߱��� ���</dd>
			<dd>���ʿ� �߱��� ���ݰ�꼭�� ������ ��(-)�� �������ݰ�꼭 1�� �߱�</dd>
			<dd class="btn"><a href="javascript:invoiceModify2();"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="����" /></a></dd>
			<%-- <dt>���ް��� ����</dt>
			<dd>���ް��׿� �߰� �Ǵ� �����Ǵ� �ݾ��� �߻��� ���</dd>
			<dd>������ų �ݾ׿� ���� ��(+) �Ǵ� ��(-)�� �������ݰ�꼭 1�� �߱�</dd>
			<dd class="btn"><a href="javascript:invoiceModify3()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif" title="����" /></a></dd> --%>
			<dt>����� ����</dt>
			<dd>����� ������ ��ȭ �Ǵ� �뿪�� ���޵��� ���� ���</dd>
			<dd>���� �߱��� ���ݰ�꼭�� ������ ��(-)�� �������ݰ�꼭 1�� �߱�</dd>
			<dd class="btn"><a href="javascript:invoiceModify4()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif"  title="����" /></a></dd>
			<dt>ȯ��</dt>
			<dd>���� ������ ��ȭ�� ȯ��(��ǰ)�� ���</dd>
			<dd class="last">ȯ��(��ǰ)�� �ݾ׸�ŭ�� ��(-)�� �������ݰ�꼭 1�� �߱�</dd>
			<dd class="btnlast"><a href="javascript:invoiceModify5()"><img src="<%=request.getContextPath()%>/images/popup/btn_select.gif"  title="����" /></a></dd>
		</dl>
	</div>
	<!-- ���������� �� -->
	<!-- bottom ���� -->
	<div id="button">
		<a href="javascript:window.close()"><img src="<%= request.getContextPath()%>/images/btn_close.gif" width="40" height="23" title="�ݱ�"/></a>
	</div>
	<!-- bottom �� -->
</div>
<!-- ���̾ƿ� �� -->
</form>
</body>
</html>
