<%@ page contentType="text/html; charset=euc-kr"%>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	
	function MM_jumpMenu(targ,selObj,restore){ //v3.0
		  window.open(selObj.options[selObj.selectedIndex].value,"_Blank"); 
		  //eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'"); 
		  //if (restore) selObj.selectedIndex=0; 
	}
	//$document()
	</script>

	<div id="footer">
		<div class="footer_area">
			<p class="logo"><img src="<%= request.getContextPath() %>/images/layout/footer_logo.gif" alt="HUATION" /></p>
			<p class="copyright"><img src="<%= request.getContextPath() %>/images/layout/footer_copyright.gif" alt="Copyright &copy; HUATION Corp. All rights reserved." /></p>
			<!-- <ul class="sitelink">
				
				<li><select name="jumpMenu" id="jumpMenu" onchange="MM_jumpMenu('parent',this,0)">
      					<option>운영계</option>
      					<option value="http://www.huation.com">HUEHome</option>
      					<option value="http://www.huation.com:8089">HUEWare</option>
    				    </select></li>
				
				<li><select name="jumpMenu" id="jumpMenu" onchange="MM_jumpMenu('parent',this,0)">
      					<option>검증계</option>
      					<option value="http://dev.huation.com">HUEHome</option>
      					<option value="http://dev.huation.com:8080/hueware">HUEWare</option>
      					<option value="http://dev.huation.com:8080/hueware2">HUEWare2</option>
      					<option value="http://dev.huation.com:8080/huefax/index.jsp">HUEFax</option>
      					<option value="http://dev.huation.com:8090/index.jsp">HUERes</option>
      					<option value="http://dev.huation.com:8090/huesta/index.jsp">HUESta</option>
				    </select></li>
				
				<li><select name="jumpMenu" id="jumpMenu" onchange="MM_jumpMenu('parent',this,0)">
      					<option>개발사이트</option>
      					<option value="http://dev.huation.com:8080/neowiz_fax/index.jsp">네오위즈(fax)</option>
      					<option value="http://dev.huation.com:81">현대해상(weblogic)</option>
      					<option value="http://dev.huation.com:8080/korealife">대한생명</option>
      					<option value="http://dev.huation.com:8080/neowizrec/index.jsp">네오위즈(rec)</option>
      					<option value="http://dev.huation.com:8080/policefax">경찰청</option>
				    </select></li>
			</ul> -->
		</div>
	</div>

