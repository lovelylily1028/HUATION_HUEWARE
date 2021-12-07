<%@ page contentType="text/xml; charset=euc-kr"  %><%@ page import ="java.util.Map"%><%
	Map model = (Map)request.getAttribute("MODEL"); 
	response.setHeader("Cache-Control","no-cache");
	String encpwd = (String)  model.get("encPasswd");
%><?xml version="1.0" encoding="euc-kr"?>
<encpwd-result>
<encpwd><%=encpwd%></encpwd>
</encpwd-result>