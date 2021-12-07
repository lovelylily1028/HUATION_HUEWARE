<%@ page language="java" pageEncoding="euc-kr" %>
<%@ page import="com.huation.framework.logging.Log" %>
<%@ page import="com.huation.framework.logging.LogFactory" %>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	Log log = LogFactory.getLog(this.getClass());
	log.debug("�޿��� �α��� ������ ȣ��");
	
	if(bLogin == true) {
%>
	
	<script>
	//URL �ּ�â �� ���� �������� �̵�.
	location.href = "<%= request.getContextPath()%>/B_Common.do?cmd=mainPage";
	</script>
<%	
	}
%>

<%!

public  String getClientIP(HttpServletRequest request) {
    String ip = request.getHeader("X-Forwarded-For");


    if (ip == null) {
        ip = request.getHeader("Proxy-Client-IP");
 
    }
    if (ip == null) {
        ip = request.getHeader("WL-Proxy-Client-IP");
 
    }
    if (ip == null) {
        ip = request.getHeader("HTTP_CLIENT_IP");
      
    }
    if (ip == null) {
        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
     
    }
    if (ip == null) {
        ip = request.getRemoteAddr();
   
    }
 

    return ip;
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>

<script type="text/javascript" src="https://api.ipify.org/?format=json"></script>

<!-- GOOGLE APP��ɻ�� -->
<!-- <script>alert(ip());</script> -->

<script language="JavaScript">
<!--

	var clientIP = "";
	try {
			clientIP = ip();
	}catch (e) {
	
	}
	console.log("[clientIP]" , clientIP);



	function login(){
	
		var frm=document.loginForm;
		var sPath = window.location.pathname;
		var sSearch=window.location.search;
		var url='<%= request.getContextPath()%>'+sPath+sSearch;
		
		if( frm.saveId.checked == true ){
			setCookie("Hueware_UserId", frm.userId.value);
		} else {
			setCookie("Hueware_UserId", "");
		}
	
		if(frm.userId.value.length==0){
			alert('ID �� �Է��ϼ���');
			return;
		}
		if(frm.passWd.value.length==0){
			alert('Password �� �Է��ϼ���');
			return;
		}

		frm.action='<%= request.getContextPath()%>/B_Login.do';
		frm.cmd.value = 'setLogin';
		frm.rtnUrl.value=url;//escape(url);
		frm.submit();

	}

	document.onkeypress = keyPress ;
	function keyPress(){
		var ieKey = window.event.keyCode ;
		if( ieKey == 13 ){
			login();
		}
	}

	function init_login(){
		
		var frm=document.loginForm;
		var cUserId = getCookie("Hueware_UserId");

		if( cUserId != null && trim(cUserId) != '' && cUserId != 'null' ){
			frm.userId.value = getCookie("Hueware_UserId");
			frm.saveId.checked = true;
		}
		
		if(frm.userId.value == "" ) {
			frm.userId.focus();
		} else {
			frm.passWd.focus();
		}
	}
//-->
</script>
</head>
<body onLoad="init_login();" >

<div id="wrapLogin">
	<!-- �ΰ�/Ÿ��Ʋ/copyright -->
	<div class="headerLogin">
		<h1><a href="#none"><img src="<%= request.getContextPath() %>/images/layout/login_logo.jpg" alt="Hueware" /></a></h1>
		<h2>�޿��� ����� �α���</h2>
		<p class="copyright"><img src="<%= request.getContextPath() %>/images/layout/logo_copyright.jpg" alt="Copyright &copy; HUATION Corp. All rights reserved." /></p>
	</div>
	<!-- //�ΰ�/Ÿ��Ʋ/copyright -->
	
	<!-- ������ -->
	<div class="contentLogin">
		<form name = "loginForm" method = "post">
		  <input type="hidden" name="cmd" />
		  <input type="hidden" name="rtnUrl"/>

		<fieldset>
			<legend>Login</legend>
			<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
			<dl class="con">
				<dt><label for="loginId">���̵�</label></dt>
				<dd><input type="text" id="loginId" name="userId" class="text" title="���̵�" /></dd>
				<dt><label for="loginPwd">�����ȣ</label></dt>
				<dd><input type="password" id="loginPwd" name="passWd" class="text" title="�����ȣ" /></dd>
			</dl>
			<p class="idCheck"><input type="checkbox" class="check" id="loginId_check" name="saveId" title="���̵�����" /><label for="loginId_check">���̵� ����</label></p>
			<p class="loginBtn"><a href="javascript:login()"><img src="<%= request.getContextPath() %>/images/layout/login_btn.jpg" alt="login" /></a></p>
		</fieldset>
		</form>
	</div>
	<!-- //������ --> 
  </div>
</body>
</html>
  
  
