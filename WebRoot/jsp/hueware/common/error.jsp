<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page isErrorPage="true" %>
<%
String strErrorCode = "";
String strErrorMsg  = "";
if(exception != null){

	exception.printStackTrace();
	strErrorMsg = exception.toString();
}
else
	strErrorMsg = "알 수 없는 오류";
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>huation :: 휴에이션</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script>
		var isPopup = false;
		function resize(){
			if(typeof(window.opener.top)=='object'){
				window.resizeTo(700, 500);
				isPopup = true;
			}
		}
		
		function go(){
			if(isPopup){
				window.close();
			}else{
				location.href='<%= request.getContextPath()%>/B_Common.do?cmd=mainPage';
			}
		}
	</script>
</head>
<body onLoad="resize()">
<p class="error">요청하신 화면을 찾을 수 없습니다.<br />서비스 이용에 불편을 드려 대단히 죄송합니다.<br />정확한 주소인지 확 인하시고 다시 접속해주시기 바랍니다.<br />동일한 문제가 지속적으로 발생하실 경우에<br />서비스 이용 문의 부탁드립니다.<br /><strong><a href="javascript:go()">go home</a></strong></p>
</body>
</html>