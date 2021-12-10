<%@ page contentType="text/html; charset=euc-kr" isErrorPage="true" %>
<%
	request.setCharacterEncoding("euc-kr");

	String msgcode ="[0000]";// request.getAttribute("msgcode")==null?"":(String)request.getAttribute("msgcode");
	String msg = request.getAttribute("msg")==null?"":(String)request.getAttribute("msg");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>로그인에러</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="wrapLogin">
	<!-- 로고/타이틀/copyright -->
	<div class="headerLogin">
		<h1><a href="#none"><img src="<%= request.getContextPath() %>/images/layout/login_logo.jpg" alt="Hueware" /></a></h1>
		<h2>휴웨어 사용자 로그인</h2>
		<p class="copyright"><img src="<%= request.getContextPath() %>/images/layout/logo_copyright.jpg" alt="Copyright &copy; HUATION Corp. All rights reserved." /></p>
	</div>
	<!-- //로고/타이틀/copyright -->
	<!-- 컨텐츠 -->
	<div class="contentLoginError">
		<p><%= "message code : <span class='code'>" + msgcode + "</span>"%><br /><%= "message : <span class='message'>" + msg + "</span>"%></p>
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:history.go(-1)"class="btn_type02"><span>재시도</span></a><a href="javascript:window.close()"class="btn_type02 btn_type02_gray"><span>종료</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //컨텐츠 -->
</div>
</body>
</html>