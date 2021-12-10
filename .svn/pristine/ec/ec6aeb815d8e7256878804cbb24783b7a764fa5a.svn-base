<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="com.huation.common.PostCodeDTO" %>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	ArrayList postList = (ArrayList)model.get("postList");

    String pForm = (String)model.get("pForm");
    String pZip =(String)model.get("pZip");
    String pAddr =(String)model.get("pAddr");
    String pDong = (String)model.get("pDong");
    String LineBgColor = "#40B389";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>우편번호검색</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script language="javascript">
<!--

	function ClickZipCode(zip, addr)
	{
		var f = opener.document.<%=pForm%>;
		f.<%=pZip%>.value = zip;
		f.<%=pAddr%>.value = addr;
		f.<%=pAddr%>.focus();
		self.close();
	}
	function formCheck(){
		var form = document.ZipSearch;
		form.submit();
	}
	
//-->
</script>
<body>
<div id="wrapWp">
<!-- header -->
<div id="headerWp">
	<h1>우편번호 조회</h1>
</div>
<!-- //header -->
<!-- content -->
<div id="contentWp">
	<!-- 우편번호 조회 -->
<form name="ZipSearch" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost2">
	<fieldset>
    <legend>우편번호 조회</legend>
    <!-- search -->
	<dl class="search_area">
	<input type=hidden name=pForm value="<%=pForm%>">
    <input type=hidden name=pZip value="<%=pZip%>">
    <input type=hidden name=pAddr value="<%=pAddr%>">
	<dt><span class="guide_txt">아래 입력 란에 찾으실 주소를 입력하세요<br />(예) 서울시 강남구 도곡동 → 도곡동</span><br /><input type="text" class="text" name=pDong value="<%=pDong%>" title="검색주소" style="width:200px;" /><a href="javascript:formCheck();"class="btn_type03"><span>조회</span></a></dt>
      <dd class="listPost">
       <ul class="listPost_area">
      <!-- //search -->
          <% 
		PostCodeDTO postCode = null;
		if(postList.size() > 0 ){ 
		for(int i =0; i < postList.size(); i++){
		postCode = (PostCodeDTO)postList.get(i);
		%>
            <li><a href="javascript:ClickZipCode('<%=postCode.getPostCode()%>','<%=postCode.getAddr()%>')" ><strong>[<%= postCode.getPostCode()%>]</strong> <%=postCode.getFullAddr()%></a></li>
          <%
		}  
		}else{  
		%>
          <li class="none">검색된 우편번호가 없습니다.</li>
          <% } %>
          </ul>
          </dd>
          </dl>
          </fieldset>
          </form>
    <!-- //button -->
    <div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    <!-- //button -->
          
          
          
    </div>
    <!-- contents -->

  </div>

</body>
</html>
