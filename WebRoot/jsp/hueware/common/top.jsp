<%-- <%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%
	
	String userid = "";
	String name = "";
	String passwd ="";

	boolean bLogin = BaseAction.isSession(request);			//로그인 여부.
	UserMemDTO dtoUser = new UserMemDTO();					//로그인 사용자 세션 정보.
	if(bLogin == true)
		dtoUser = BaseAction.getSession(request); 

	userid=dtoUser.getUserId();
	name=dtoUser.getUserNm();
	passwd=dtoUser.getPasswd();

	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<title>Untitled Document</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	
	//로그아웃
	function logout() {
		parent.location.href = "<%= request.getContextPath()%>/B_Login.do?cmd=loginOff";
	}

	function reflesh(){
        parent.location.href = "<%= request.getContextPath()%>/B_Login.do?cmd=adminMain";

	}

	function initup(){

		parent.downFrame.cols='224,*';

		if(parent.mainFrame.document.all.subTitle!=null){
			parent.mainFrame.document.all.subTitle.style.width=screen.width-220;
		}
		if(parent.mainFrame.document.all.bbb!=null){
			parent.mainFrame.document.all.bbb.style.width=screen.width-220;
		}
	}
	
	//비밀번호 변경
	function passwdEdit() {

		var userid=document.topfrm.userid.value;
		var passwd=document.topfrm.passwd.value;
		var pop = window.open("<%= request.getContextPath()%>/B_User.do?cmd=passwdEdit&user_id="+userid+"&passwd="+passwd+"&page=E","passwdEdit","width=300,height=250,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");

	}

</script>
	<form name="topfrm">
		<input type="hidden" name="userid" value="<%= userid %>">
		<input type="hidden" name="passwd" value="<%= passwd %>">
		<h1><a href="javascript:reflesh()"><img src="<%= request.getContextPath()%>/images/layout/header_logo.gif" alt="Hueware" /></a></h1>
		<ul class="gnb">
			<li>User ID : <%= userid %></li>
			<li><span class="user_name">Name : <%= name %></span>님</li>
			<li class="pwmodify"><a href="javascript:passwdEdit();">비밀번호변경</a></li>
			<li class="last"><a href="javascript:logout();">로그아웃</a></li>
		</ul>
</form> 
 --%>