<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.user.UserDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    	UserDTO userDto = (UserDTO)model.get("userDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<title>사용자 수정페이지</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function passWdConfirm(){

		var requestUrl='<%= request.getContextPath() %>/B_User.do?cmd=pwdEnc&cpawd='+document.userView.passwd.value;

		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
		var result='N';

		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);

		resultText = xmlhttp.responseText;

		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
		
		result=xmlObject.documentElement.childNodes.item(0).text;

		return result;
	}

function goSave(){

	var frm = document.userView; 

	if(frm.encpasswd.value != frm.passwd.value){
		 frm.passwd.value=passWdConfirm();
	}

	if(frm.user_id.value.length == 0){
		alert("ID를 입력하세요");
		return;
	}
	if(frm.passwd.value.length == 0){
		alert("패스워드를 입력하세요");
		return;
	}
		if(frm.user_nm.value.length == 0){
		alert("사용자명을 입력하세요");
		return;
	}

	if(confirm("수정 하시겠습니까?")){

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		frm.submit();
	}
}

function goDelete(){
	
	var frm = document.userView;
	if(confirm("삭제 하시겠습니까?")){
		frm.action='<%= request.getContextPath()%>/B_User.do?cmd=userDelete';
		frm.submit();
	}

}

function goList(){
	
	var frm = document.userView;
	frm.action='<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
	frm.submit();

}
//-->
</SCRIPT>
</head>

<body>
<div id="wrap">
  <div id="header">
  </div>
  <!-- container -->
  <div id="container">
  <div class="clear"></div>
  <!-- lnb -->
   <div class="lnb">
  </div>
  <!-- //lnb -->
  <!-- contents -->
  <div class="contents">
    <!-- title -->
    <div class="title"><img src="<%= request.getContextPath()%>/images/p_enterprise.gif" width="59" height="20" alt="사용자 수정" /></div>
    <!-- //title -->
    <!-- con -->
    <div id="excelBody" class="con">
<form name="userView" method="post" action="<%= request.getContextPath()%>/B_User.do?cmd=userEdit">
<input type = "hidden" name = "curPage" value="<%=curPage%>">
<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
  	<!-- span class="tbl_line_top">&nbsp;</span -->
      <table cellspacing="0" border="1" summary="사용자수정" class="tbl_type2">
  <tr>
    <td class="td_search" style="padding:15 30 15 30">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100" style="padding:5 0 5 0">ID</td>
				<td style="padding:5 0 5 0"><input type="text" name="user_id" class="td3" readOnly style="width:100px" value="" ></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
			<tr>
				<td width="100" style="padding:5 0 5 0">패스워드</td>
				<td style="padding:5 0 5 0"><input type="password" name="passwd" class="input1" style="width:100px"  value="" ></td>
				<input type="hidden" name="encpasswd" class="input1" style="width:100px"  value="" >
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
			<tr>
				<td width="100" style="padding:5 0 5 0">사용자명</td>
				<td style="padding:5 0 5 0"><input type="text" name="user_nm" class="input1" style="width:150px"  value="" ></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
			<tr>
				<td width="100" style="padding:5 0 5 0">사용등급</td>
				<td style="padding:5 0 5 0"> <%  
													        CodeParam codeParam = new CodeParam();
															codeParam.setType("select"); 
															codeParam.setStyleClass("style2");
															codeParam.setName("user_grade");
															codeParam.setSelected(""); 
															out.print(CommonUtil.getCodeList(codeParam,"A01")); 
														%></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
			<tr>
				<td width="100" style="padding:5 0 5 0">연락처</td>
				<td style="padding:5 0 5 0"><input type="text" name="phone" class="input1" style="width:150px" value="" ></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
			<tr>
				<td width="100" style="padding:5 0 5 0">이메일</td>
				<td style="padding:5 0 5 0"><input type="text" name="email" class="input1" style="width:200px" value="<%=userDto.getEmail()%>"></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td height="5"  colspan="2"></td>
			</tr>
		</table>
		<table width="650" border="0" cellspacing="0" cellpadding="0">
			<tr>
					<td height="35" align="center">
					<input type=button value="수정" onClick="javascript:goSave();" class="input_button_red"/>&nbsp;<input type=button value="삭제" onClick="javascript:goDelete();" class="input_button_red"/>&nbsp;<input type=button value="목록" onClick="javascript:goList();" class="input_button_red"/></td>
					</tr>
		</table>
	</td>
  </tr>
  </form>
</table>
</body>
</html>