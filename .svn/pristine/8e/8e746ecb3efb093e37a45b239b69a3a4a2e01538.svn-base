<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.project.NonProjectDTO"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	
	String fileName ="";
	Map model = (Map)request.getAttribute("MODEL");
	String listType = (String)model.get("listType");
	String curDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());														
	
	if ("P".equals(listType)) {
		response.setHeader("Content-Disposition", "attachment; filename=projectExcel_Non.xls");	
	} else {
		response.setHeader("Content-Disposition", "attachment; filename=projectExcel_Non_ALL.xls");
	}
		
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
.xl65
	{mso-style-parent:style0;
	mso-number-format:"\@";}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>점검 사이트 정보 리스트</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div >
			<strong>
			<font size=6>
			<%
      			if (listType == "P") {
      		%>
			유지보수 비정기점검 내역
			<%
      			} else {
      		%>
      		유지보수 비정기점검(종합) 내역
      		<%
      			}
      		%> 
			</font>
			</strong>
			<div align="right"><%=curDate %></div>
		</div>
							
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <td align="center"><strong>No.</strong></td>
                 <td align="center"><strong>고객사</strong></td>
                 <td align="center"><strong>사유</strong></td>
                 <td align="center"><strong>시작일자</strong></td>
                 <td align="center"><strong>시작시간</strong></td>
                 <td align="center"><strong>종료일자</strong></td>
                 <td align="center"><strong>종료시간</strong></td>
                 <td align="center"><strong>소요시간<br>(Hour)</br></strong></td>
                 <td align="center"><strong>담당자</strong></td>
                 <td align="center"><strong>요청자</strong></td>
                 <td align="center"><strong>수행장소</strong></td>
                 <td align="center"><strong>수행내용</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
   			int j = 1;
			while (ds.next()) {
		%>

			<tr bgcolor="#FFFFFF" height="23">
		  <td align="center"><%=j %></td>
		  <td align="center"><%=ds.getString("CompanyName") %></td>
		  <td align="center"><%=ds.getString("CheckReasonNm") %></td>
		  <td align="center"><%=ds.getString("StartDate") %></td>
          <td align="center"><%=ds.getString("StartTime") %></td>
          <td align="center"><%=ds.getString("EndDate") %></td>
          <td align="center"><%=ds.getString("EndTime") %></td>  
          <td align="center"><%=ds.getString("WorkTime") %></td>
          <td align="center"><%=ds.getString("ChargeName") %></td>
          <td align="center"><%=ds.getString("RequestNm") %></td>
          <td align="center"><%=ds.getString("WorkSite") %></td>
          <td align="center"><%=ds.getString("WorkContents") %></td>
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
			j++;	
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="11" align="center" class="td5">게시물이 없습니다.</td>
			</tr>
		<%
			}
		%>
		</table>
		</td>
	</tr>
</table>									
</body>
</html>
