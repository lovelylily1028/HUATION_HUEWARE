<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import = "com.huation.framework.persist.ListDTO"%>
<%@ page import = "com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String sForm = (String)model.get("sForm");
	String big_cd = (String)model.get("big_cd");
	String sml_cd = (String)model.get("sml_cd");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>코드 조회</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch(gubun) {

		if(eval('document.searchform.'+gubun+'.value')==''){
			alert('조회할 코드를 입력해 주세요');
			return;
		}
	
		document.searchform.submit();

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

	function goBigCode(){

		var bigCd=eval('opener.document.<%=sForm%>.big_cd');
		
		bigCd.value=document.searchform.big_cd.value;
		
		self.close();

	}

	function goSmlCode(){

		var smlCd=eval('opener.document.<%=sForm%>.sml_cd');
		
		smlCd.value=document.searchform.sml_cd.value;
		
		self.close();

	}
	
//-->
</SCRIPT>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
  <table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
          <tr>
            <td align=center height=middle><img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5"></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- 처리중 종료 -->
<%

%>
<body>
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>코드 조회</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 코드 조회 -->
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Code.do?cmd=existCode">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
   <fieldset>
	<legend>코드 조회</legend>
	<dl class="search_area">
      <%
						if(big_cd.equals("*")){		
				%>
      <input type = "hidden" name="big_cd"  value="<%=big_cd%>">
      <dt><label for="">코드분류</label>&nbsp;&nbsp;<input type="text" name="sml_cd" title="코드분류" style="width:200px;" value="<%=sml_cd%>"  class="text" ><a href="javascript:goSearch('sml_cd');" class="btn_type03"><span>조회</span></a></dt>
      <%
						}else{
				%>
      <input type = "hidden" name="sml_cd"  value="<%=sml_cd%>">
      <dt><label for="">코드분류</label>&nbsp;&nbsp;<input type="text" name="big_cd" title="코드분류" style="width:200px;" value="<%=big_cd%>"  class="text" ><a href="javascript:goSearch('big_cd');" class="btn_type03"><span>조회</span></a></dt>
      <%
						}
				%>
          <%	
String message="";
String existyn= (String)model.get("existyn");

if(big_cd.equals("*")){	
	if(sml_cd.equals("")){	
		message="코드분류를 조회하세요.";
	}else if(existyn.equals("1")){	
		message="<strong>"+sml_cd+"</strong>는 이미 등록된 코드 입니다.";
	}else{
		message="<strong>"+sml_cd+"</strong> 는 사용가능한 코드 입니다.";
	}
}else{
	if(big_cd.equals("")){	
		message="코드번호를 조회하세요.";
	}else if(existyn.equals("1")){	
		message="<strong>"+big_cd+"</strong> 는 이미 등록된 코드 입니다.";
	}else{
		message="<strong>"+big_cd+"</strong> 는 사용가능한 코드 입니다.";
	}

}
%>
            <dd><%=message%></dd>
          </dl>
          </fieldset>
          </form>
		<!-- //코드 조회 -->
    <!-- //button -->
    <div class="Bbtn_areaC">
      <%
			if(big_cd.equals("*") &&  !sml_cd.equals("") &&  existyn.equals("0")){	
		%><a href="javascript:goSmlCode();" class="btn_type02"><span>확인</span></a><%
			}else if(!big_cd.equals("*") &&  !big_cd.equals("") &&  existyn.equals("0")){	
		%><a href="javascript:goBigCode();" class="btn_type02"><span>확인</span></a><%
			}
		%><a href="javascript:window.close();" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
    </div>
    <!-- //button -->
    	</div>
	<!-- //content -->
  </div>
</form>
</body>
</html>
