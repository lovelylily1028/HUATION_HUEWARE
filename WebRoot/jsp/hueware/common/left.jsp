<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.waf.*"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%

	String userGrade = "";

	boolean bLogin = BaseAction.isSession(request);			//로그인 여부.
	UserMemDTO dtoUser = new UserMemDTO();					//로그인 사용자 세션 정보.
	if(bLogin == true){
		dtoUser = BaseAction.getSession(request); 
		userGrade="M01";

	}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>left menu</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css">
<%-- <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" />
 --%>
<script language="JavaScript" type="text/JavaScript">

	function menuOption(index){//선택메뉴 열고닫기

		var menu=document.all.menu;
		var subm=null;
		
		for(i=0;i<menu.length;i++){

			subm=eval("document.all.subm_"+i);
			
			if(i==index){
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
							subm[j].style.display='block';
					}
				}else{
							subm.style.display='block';
				}
			}else{
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
							subm[j].style.display='none';
					}
				}else {
							subm.style.display='none';
				}
			}
		}
	}
	function selectMenu(m_index,s_index){//선택메뉴 표기

		var menu=document.all.menu;
		var subm=null;
		var subtext=null;
		
		for(i=0;i<menu.length;i++){

			subm=eval("document.all.subm_"+i);
			
			if(i==m_index){
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
						subtext=eval("document.all.M"+i+j);
						if(j==s_index){
							subtext.style.color='black';
							subtext.style.fontWeight ="bold";
						}else{
							subtext.style.color='';
							subtext.style.fontWeight ='';
						}
					}
				}else{
					subtext=eval("document.all.M"+i+"0");
					subtext.style.color='black';
					subtext.style.fontWeight ='bold';

				}
			}else{
				for(j=0;j<subm.length;j++){
						subtext=eval("document.all.M"+i+j);
						subtext.style.color='';
						subtext.style.fontWeight ='';
				}
			}
		}
		
	}

	function goPage(menu){

		var theUrl = '';
		var m_index=menu.substring(0,1);
		var s_index=menu.substring(1,2);

		menuOption(m_index); //메뉴 열고닫기
		selectMenu(m_index,s_index);//선택 서브메뉴 표기

		if(m_index=='0'){  // 총무지원
			if (menu=='00') {
				theUrl= '<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
			}
		}else if (m_index=='1'){  //영업지원
			if (menu=='10') {
				theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
			}else if (menu=='11') {
				theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
			}  
		}else if (m_index=='2'){  //기타관리
			if (menu=='20') {
				theUrl= '<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
			}else if (menu=='21') {
				theUrl= '<%= request.getContextPath()%>/H_Group.do?cmd=groupManage';
			}else if (menu=='22') {
				theUrl= '<%= request.getContextPath()%>/H_Auth.do?cmd=authManage';
			}else if (menu=='23') {
				theUrl= '<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
			}
		}
		try {
			parent.mainFrame.openWaiting();
		} catch (e) {}

		parent.mainFrame.location.href = theUrl;

	}
	function init(){

		var objs=document.all.menu;

		if('<%=userGrade%>'=='M01'){

			goPage('00');

		}else if('<%=userGrade%>'=='M03'){

			goPage('10');
			objs[0].style.display='none';
			objs[2].style.display='none';

		}else if('<%=userGrade%>'=='M04'){

			goPage('00');
			objs[1].style.display='none';
			objs[2].style.display='none';

		}else{

			objs[0].style.display='none';
			objs[1].style.display='none';
			objs[2].style.display='none';
		}
	}
	

//-->
</script>
</head>

<body topmargin="0" leftmargin="0" align="center" background="<%= request.getContextPath() %>/image/back/left_bg.gif"  onload="javascript:init();">
<!--관리시스템 left 메뉴시작-->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td style="padding-top:10px" bgcolor="#ffffff"><img src="<%= request.getContextPath() %>/image/back/left_bg_top.gif" width="223" height="42" /></td>
    </tr>
  </table>
  <table width="192" border="0" cellpadding="2" cellspacing="2">
     <!--1depth menu 1 start-->
	 <tr >
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="menu">
				<tr>
				  <td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_left.gif" width="8" height="28"></td>
				  <td bgcolor="#f0f0f0" class="lmenu1"><img src="<%= request.getContextPath() %>/image/back/ico_menu_title.gif" width="10" height="10" style="margin:2 8 2 0" align="absmiddle"><a href="javascript:;" onClick="goPage('00')" class="lmenu1">총무지원</a></td>
				  <td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_right.gif" width="8" height="28"></td>
				</tr>
			</table>
		</td>
    </tr>
	<!--1depth menu end-->
		<!--2depth sub_menu start-->
		<tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_0" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('00')" class="lmenu2" ><font id="M00">업체관리</font></a>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
	<!--1depth menu 1 start-->
    <tr >
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="menu">
				<tr>
				  <td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_left.gif" width="8" height="28"></td>
				  <td bgcolor="#f0f0f0" class="lmenu1"><img src="<%= request.getContextPath() %>/image/back/ico_menu_title.gif" width="10" height="10" style="margin:2 8 2 0" align="absmiddle"><a href="javascript:;" onClick="goPage('10');" class="lmenu1">영업 지원</a></td>
				  <td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_right.gif" width="8" height="28"></td>
				</tr>
			</table>
		</td>
    </tr>
	<!--1depth menu end-->
		<!--2depth sub_menu start-->
		<tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_1" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('10')" class="lmenu2"  ><font id="M10">견적서(매출) 발행</font></a><br>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
		<!--2depth sub_menu start-->
		 <tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_1" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('11')" class="lmenu2"  ><font id="M11">세금계산서 발행</font></a><br>
		  </td>
		<!--2depth sub_menu end-->
	<!--1depth menu 1 start-->
	<tr>
      <td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="menu">
				<tr>
					<td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_left.gif" width="8" height="28"></td>
					<td bgcolor="#f0f0f0" class="lmenu1"><img src="<%= request.getContextPath() %>/image/back/ico_menu_title.gif" width="10" height="10" style="margin:2 8 2 0" align="absmiddle"><a href="javascript:;" onClick="goPage('20')" class="lmenu1">기타 관리</a></td>
					<td width="8"><img src="<%= request.getContextPath() %>/image/back/lmenu_bg_right.gif" width="8" height="28"></td>
				</tr>
			</table>
		</td>
    </tr>
	<!--1depth menu end-->
		<!--2depth sub_menu start-->
		<tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_2" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('20')" class="lmenu2" ><font id="M20">계정 관리</font></a><br>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
		<!--2depth sub_menu start-->
		 <tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_2" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('21')" class="lmenu2"  ><font id="M21">그룹 관리</font></a><br>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
		<!--2depth sub_menu start-->
		 <tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_2" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('22')" class="lmenu2"  ><font id="M22">메뉴권한 관리</font></a><br>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
		<!--2depth sub_menu start-->
		 <tr>
		  <td style="display:none; ;padding-left:20px; padding-bottom:10px" id="subm_2" class="lmenu2">
			<img src="<%= request.getContextPath() %>/image/back/ico_list.gif" width="3" height="3" style="margin:10 5 10 0" align="absmiddle"><a href="javascript:goPage('23')" class="lmenu2"  ><font id="M23">코드북 관리</font></a><br>
		  </td>
		</tr>
		<!--2depth sub_menu end-->
	</table>
<!--관리시스템 left 메뉴종료-->
</body>
</html>

