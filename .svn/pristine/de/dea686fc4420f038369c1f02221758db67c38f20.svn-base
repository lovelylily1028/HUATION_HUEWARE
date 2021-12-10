<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import ="com.huation.common.config.AuthDAO"%>
<%@ page import ="com.huation.common.config.MenuDTO"%>
<%@ page import ="com.huation.common.config.AuthDTO"%>
<%@ page import="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.waf.*"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
	<%
	
	String userid = "";
	String name = "";
	String passwd ="";
	String groupnm ="";
	
	boolean bLogin = BaseAction.isSession(request);	
	UserMemDTO dtoUser = new UserMemDTO();			
	
	if(bLogin == true) {
		dtoUser = BaseAction.getSession(request); 
	}else{
	
	%>

	<script>
	location.href='<%= request.getContextPath()%>/B_Login.do?cmd=loginForm';
	</script>
	
	<%	
	}
	userid=dtoUser.getUserId();
	name=dtoUser.getUserNm();
	passwd=dtoUser.getPasswd();
	groupnm=dtoUser.getGroupnm();
	
	AuthDAO authDao = new AuthDAO();
	AuthDTO authDto = new AuthDTO();
	
	authDto.setUserID(userid);
	
	ArrayList<MenuDTO> menulist  =  authDao.userAuthMenuTree(authDto);
	CommonDAO comDao=new CommonDAO();
	
	
	String userGrade = "";

	if(bLogin == true){
		dtoUser = BaseAction.getSession(request); 
		userGrade="M01";

	}
	%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Untitled Document</title>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script src="<%= request.getContextPath()%>/js/hueware.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.3.custom.min.js"/></script>
<script language="JavaScript">
	
	//메뉴링크
	function goMenu(menu){

		var theUrl = '';
		
		if (menu=='HOME') {//HOME
			theUrl= '<%= request.getContextPath()%>/B_Common.do?cmd=mainPage';
		}else if (menu=='01') {//업체관리
			theUrl= '<%= request.getContextPath() %>/S_Sms.do?cmd=smsSend';
		}else if (menu=='02') {//업체관리
			theUrl= '<%= request.getContextPath() %>/S_Sms.do?cmd=smsSendPageList';
		}else if (menu=='03') {//업체관리
			theUrl= '<%= request.getContextPath() %>/S_Sms.do?cmd=smsReservePageList';
		}
		
		openWaiting(); //처리중 메세지 활성화

		location.href = theUrl;

	}
	
		function init(){
			var li;
			var span;
	
			if(SelectMenu=='smsSend'){
		       $('#smsSend').addClass("on");
			
				
			}else if(SelectMenu=='smsSendPageList'){
	
				 $('#smsSendPageList').addClass("on");
	
			} 
			
			//li.style='background:url(../images/layout/bg_lnb_over.gif) repeat-x;color:#0033CC;'
			//span.style='color:#f15a22;padding-right:11px;background:url(../images/layout/ico_lnbsnb.gif) no-repeat 100% 50% !important;'
			
			
		}

	
	
	//2013-03-13 기존달력에서 jQuery 달력으로 변경
	$(document).ready(function(){
		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
			//maxDate:0,
			showOn: 'both',
			buttonImageOnly: true,
			prevText: "이전",
			nextText: "다음",
			dateFormat: "yy-mm-dd",
			dayNamesMin:["일","월","화","수","목","금","토"],
			monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			changeMonth: true,
		    changeYear: true
		});
	});
			
</script>
</head>
<body onload = "javascript:init();">
		<!-- header -->
		<div id="headerWp">
		<h1 class="hidden_obj">SMS전송메뉴</h1>
		<ul class="tabTi">
			<li><a id="smsSend" href="javascript:goMenu('01');">SMS전송</a></li><!-- 메뉴 활성화 : class="on" 추가 -->
			<li><a id="smsSendPageList" href="javascript:goMenu('02');">SMS전송내역</a></li>
			<!-- <li><a href="javascript:goMenu('03');">SMS예약내역</a></li> -->
		</ul>
	</div>
</body>
</html>
