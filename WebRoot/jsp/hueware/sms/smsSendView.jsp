<%@page import="com.baroservice.ws.CERTKEY"%>
<%@page import="com.baroservice.ws.BaroService_SMSSoapProxy"%>
<%@page import="com.baroservice.ws.SMSMessage"%>
<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Map model = (Map)request.getAttribute("MODEL"); 
String SendKey = (String)model.get("SendKey");
String sendDT = (String)model.get("sendDT");
%>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9�� ������ -->
<title>SMS ���۳���</title>
<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- Ʈ������ -->
<script type="text/javascript">
</script>
<!-- //Ʈ������ -->
</head>
<body>
<!-- �˾������� : width:624px / height:567px; -->

		<%
			 String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
		     String getCERTKEY;
		    SMSMessage[] result;
			BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
			CERTKEY certkey = new CERTKEY();
			
			getCERTKEY = certkey.getCERTKEY();
			
			result = proxy.getMessagesByReceiptNum(getCERTKEY,"1088193762",SendKey);
			
		%>
<div class="smsSendView">
	<!-- content -->
	<div id="contentLp" class="smsSendView_area">
		<!-- �������� -->
		<%-- <div class="sendInfo_area">
			<form method="post" action="">
			<!-- ���۰������� -->
			<fieldset class="sendInfo">
				<legend>���۰�������</legend>
				<dl>
					<dt>�߽Ź�ȣ</dt>
					<dd><input type="text" id="" readOnly value="<%=result[0].getSenderNum().replaceAll(regEx, "$1-$2-$3")%>" class="text num" title="�߽Ź�ȣ" /></dd>
					<dt>�����Ͻ�</dt>
					<dd><input type="text" id="" readOnly value="<%=sendDT%>" class="text" title="�����Ͻ�" /></dd>
				</dl>
			</fieldset>
			<!-- //���۰������� -->
			<!-- ���ڳ��� -->
			<fieldset class="sendMessages">
				<legend>���ں�����</legend>
				<div class="messageCont_area">
					<div class="messageCont"><textarea id="" readOnly title="�����Է�" style="width:178px;"><%=result[0].getMessage()%></textarea></div>
				</div>
			</fieldset>
			<!-- //���ڳ��� -->
			</form>
		</div> --%>
		<!-- //�������� -->
		<!-- ����Ʈ -->
		<table class="tbl_type tbl_type_list sendList_area" summary="SMS���۳���(������, ���Ź�ȣ, ����Ͻ�, ����)">
			<colgroup>
				<col width="160px" />
				<col width="160px" />
				<col width="180px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th>������</th>
				<th>���Ź�ȣ</th>
				<th>����Ͻ�</th>
				<th>����</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="4" class="tbl_type_scrollY">
					<div class="scrollY">
						<table class="tbl_type tbl_type_list">
							<colgroup>
								<col width="159px" class="scrollY_FF" /><!-- tbody�� �߰��Ǵ� ���̺��� ���� ���� ������ ���� width����� -1px��. -->
								<col width="160px" />
								<col width="180px" />
								<col width="*" />
							</colgroup>
							<tbody>
							<% for(int i=0; i<result.length; i++){ %>
							<tr>
								<td><%=result[i].getReceiverName()%></td>
								<td><%=result[i].getReceiverNum().replaceAll(regEx, "$1-$2-$3")%></td>
								<td><%=result[i].getSendDT().substring(0,4)+"-"+result[i].getSendDT().substring(4,6)+"-"+result[i].getSendDT().substring(6,8)+" "+result[i].getSendDT().substring(8,10)+":"+result[i].getSendDT().substring(10,12)+":"+result[i].getSendDT().substring(12,14)%></td>
							<%if(result[i].getSendState()==1){ %>
								<td style="color:#3389e9;">���ۿϷ�</td>
							<%}else if(result[i].getSendState()==0){%>
								<td>�����</td>
							<%}else{ %>
								<td style="color:#e93380;">���۽���</td>
							<%} %>
							</tr>
							
							<%} %>
							
							</tbody>
						</table>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<!-- //����Ʈ -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:goClose($('#smsSendView'))" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</div>
</body>
</html>