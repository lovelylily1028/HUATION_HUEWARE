<%@ page contentType="text/html; charset=euc-kr"%>	
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String fileNm = (String)model.get("fileNm");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사진불러오기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
</head>
<form name="phothFrm"  method="post" action="<%= request.getContextPath()%>/B_User.do?cmd=photoModifyUpload"   enctype="multipart/form-data">
		<%
			if(fileNm.equals("")){
		%>
			<div style="width:70px;height:88px;border-left:1px solid #ddd;border-right:1px solid #ddd;background:#fafafa url(<%= request.getContextPath() %>/images/layout/gnb_pic_none.gif) no-repeat 50% 50%;text-align:center;"><span class="hidden_obj">사진없음</span></div>
        <%
			}else{
		%>
			<div style="padding-top:3px;width:72px;height:85px;background:#fff;"><img src="<%= request.getContextPath() %>/data/<%=fileNm%>" width="72" height="85" /></div>
		<%
			}
		%>
</form>