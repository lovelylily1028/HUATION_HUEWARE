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
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<title>SMS 전송내역</title>
<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- 트리구조 -->
<script type="text/javascript">
</script>
<!-- //트리구조 -->
</head>
<body>
<!-- 팝업사이즈 : width:624px / height:567px; -->

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
		<!-- 전송정보 -->
		<%-- <div class="sendInfo_area">
			<form method="post" action="">
			<!-- 전송가본정보 -->
			<fieldset class="sendInfo">
				<legend>전송가본정보</legend>
				<dl>
					<dt>발신번호</dt>
					<dd><input type="text" id="" readOnly value="<%=result[0].getSenderNum().replaceAll(regEx, "$1-$2-$3")%>" class="text num" title="발신번호" /></dd>
					<dt>전송일시</dt>
					<dd><input type="text" id="" readOnly value="<%=sendDT%>" class="text" title="전송일시" /></dd>
				</dl>
			</fieldset>
			<!-- //전송가본정보 -->
			<!-- 문자내용 -->
			<fieldset class="sendMessages">
				<legend>문자보내기</legend>
				<div class="messageCont_area">
					<div class="messageCont"><textarea id="" readOnly title="내용입력" style="width:178px;"><%=result[0].getMessage()%></textarea></div>
				</div>
			</fieldset>
			<!-- //문자내용 -->
			</form>
		</div> --%>
		<!-- //전송정보 -->
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list sendList_area" summary="SMS전송내역(수신자, 수신번호, 결과일시, 상태)">
			<colgroup>
				<col width="160px" />
				<col width="160px" />
				<col width="180px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th>수신자</th>
				<th>수신번호</th>
				<th>결과일시</th>
				<th>상태</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="4" class="tbl_type_scrollY">
					<div class="scrollY">
						<table class="tbl_type tbl_type_list">
							<colgroup>
								<col width="159px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
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
								<td style="color:#3389e9;">전송완료</td>
							<%}else if(result[i].getSendState()==0){%>
								<td>대기중</td>
							<%}else{ %>
								<td style="color:#e93380;">전송실패</td>
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
		<!-- //리스트 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:goClose($('#smsSendView'))" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</div>
</body>
</html>