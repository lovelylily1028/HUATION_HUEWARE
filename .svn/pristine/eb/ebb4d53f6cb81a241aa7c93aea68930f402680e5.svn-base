<%@ page contentType="text/xml; charset=euc-kr"  %>
<%@ page import ="java.util.Map"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	response.setHeader("Cache-Control","no-cache");
	String ComentPk = (String)  model.get("ComentPk");
	String msg = (String)  model.get("msg");
%>
<?xml version="1.0" encoding="euc-kr"?>

<xml-result>
		<result><%=ComentPk %></result>
		<result><%=msg %></result>
</xml-result>
