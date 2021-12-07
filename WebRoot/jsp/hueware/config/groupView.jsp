<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
GroupDTO groupDto = (GroupDTO)model.get("groupDto");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>그룹 관리</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
</head>
<form name="groupVeiwFrm">
<input name="GroupID" type="hidden"   value="<%=StringUtil.nvl(groupDto.getGroupID(),"") %>"   />
<input name="GroupName" type="hidden"   value="<%=StringUtil.nvl(groupDto.getGroupName(),"") %>"   />
</form>
</html>
<script>
var gTitle = parent.document.getElementsByName("groupTitle");
gTitle[0].innerText='[<%=StringUtil.nvl(groupDto.getGroupName(),"") %>] 그룹관리';
gTitle[1].innerText='<%=StringUtil.nvl(groupDto.getGroupName(),"") %>';
</script>