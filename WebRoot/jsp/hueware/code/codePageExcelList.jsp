<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="java.text.SimpleDateFormat" %>

<%
String fileName ="";

Map model = (Map)request.getAttribute("MODEL");
String todayDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());
response.setHeader("Content-Disposition", "attachment; fileName=codePageExcelList.xls");
response.setHeader("Content-Description", "JSP Generated Data");

String searchGb =(String)model.get("searchGb");
String searchtxt = (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.xl65
	{mso-style-parent:style0;
	mso-number-format:"\@";}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>
  <%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>

  <table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
      <tr>
		<td width="100%">
		<div><strong><font size=6>코드북관리 리스트</font></strong><div align="right"><%=todayDate %></div></div>
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA">
			<th>코드분류</th>
			<th>코드명</th>
			<th>코드설명</th>
			</tr>
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			while(ds.next()){
		%>
          <tr>
            <td><%=ds.getString("SML_CD")%></td>
            <td><%=ds.getString("CD_NM")%></td>
            <td><%=ds.getString("CD_DESC")%></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="3">게시물이 없습니다.</td>
          </tr>
          <% 
}
%>
      </table>

</body>
</html>