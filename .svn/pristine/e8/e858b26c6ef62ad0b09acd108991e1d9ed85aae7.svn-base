<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import = "com.huation.framework.persist.ListDTO"%>
<%@ page import = "com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사용자 조회</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch() {
		var obj=document.searchform;

		if(obj.searchtxt.value==''){
			alert('조회할 ID를 입력해 주세요');
			return;
		}
	
		obj.submit();

    }

	// 여기서 부터는 처리중 표현하는 function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//보이기
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function init() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}

	function goUseID(){

		var userId=eval('opener.document.<%=sForm%>.user_id');
		
		userId.value=document.searchform.selectId.value;
		
		self.close();

	}
	
//-->
</SCRIPT>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
<table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
	<tr>
		<td align=center height=middle style="margin-top: 10px;">
			<table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
				<tr>
					<td align=center height=middle>
						<img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- 처리중 종료 -->
<%
	ListDTO ld = (ListDTO)model.get("listInfo");
%>
<body>
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_User.do?cmd=searchUserId">
<input type = "hidden" name="curPage"  value="<%=curPage%>"> 
<input type = "hidden" name="sForm"  value="<%=sForm%>"> 
<input type = "hidden" name="searchGb"  value="A"> 
<!-- 타이틀 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="17"><img src="<%= request.getContextPath() %>/image/back/title_left.gif" width="17" height="40"></td>
    <td background="<%= request.getContextPath() %>/image/back/title_bg.gif" class="title1"><img src="<%= request.getContextPath()%>/image/back/ico_title.gif" width="8" height="18" style="margin:0 10 0 0" align="absmiddle">사용자 조회</td>
    <td width="17"><img src="<%= request.getContextPath()%>/image/back/title_right.gif" width="17" height="40"></td>
  </tr>
</table>
<!-- 타이틀 종료 -->
<!-- 검색 테이블 시작 -->
<table width='100%' cellpadding='0' cellspacing='0' style="margin-top:10px">
  <tr>
    <td class="td_search" style="padding:15 30 15 30">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td  style="padding:5 0 5 0">사용자 ID&nbsp;<input type="text" name="searchtxt" class="input1" style="width:100px" value="<%=searchtxt%>" >&nbsp;<a href="javascript:goSearch();"><img src="<%= request.getContextPath()%>/image/back/btn_search.gif" width="35" height="18" hspace="2" border="0" align="absmiddle"></a>
				</tr> 
			</table>
			</td>
  </tr>
</table>
<!-- 검색 테이블 끝 -->
<!-- 엑셀 바디 시작 -->
<div id='excelBody' >
<table width="100%" cellpadding="3" cellspacing="0" class="table">
	
<%			
if(searchtxt.equals("")){	
%>
		 <tr>
		 	<td colspan="660" align="center">사용자 ID를 조회하세요</td>
		  </tr>
</table>
</div>
<!-- 엑셀 바디 종료 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" align="right"><input type=button value="닫기" onClick="javascript:window.close();" class="input_button_red"/></td>
	</tr>
</table>
<%		
}else if(ld.getItemCount() > 0 ){
%>
		 <tr>
		 	<td colspan="660" align="center"><font color="blue"><%=searchtxt%></font> 는 이미 등록 하셨던 사용자 ID 입니다.</td>
		  </tr>
		 </table>
</div>
<!-- 엑셀 바디 종료 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" align="right"><input type=button value="닫기" onClick="javascript:window.close();" class="input_button_red"/></td>
	</tr>
</table>
<% 
}else if(searchtxt.equals("--")){
%>
<tr>
		 	<td colspan="660" align="center">사용자 ID를 조회하세요.</td>
		  </tr>
		 </table>
</div>
<!-- 엑셀 바디 종료 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" align="right"><input type=button value="닫기" onClick="javascript:window.close();" class="input_button_red"/></td>
	</tr>
</table>
<%
}else{
%>
		 <tr>
		 	<td colspan="660" align="center"><font color="blue"><%=searchtxt%></font> 는 사용가능한 사용자 ID를 입니다.</td>
			<input type = "hidden" name="selectId"  value="<%=searchtxt%>"> 
		  </tr>
		 </table>
</div>
<!-- 엑셀 바디 종료 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" align="right"><input type=button value="사용하기" onClick="javascript:goUseID();" class="input_button_red"/>&nbsp;<input type=button value="닫기" onClick="javascript:window.close();" class="input_button_red"/></td>
	</tr>
</table>
<%
}
%>
</form>
</body>
</html>

