<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.bankmanage.BankManageDTO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	String SessionUserID ="";//사용자 ID
	String SessionUserName = "";//사용자명
	String fileName ="";

	 String curDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());	
	//현재날짜 불러오기 SimpleDateFormat
	Map model = (Map)request.getAttribute("MODEL");
	//String curPage = (String)model.get("curPage");
	response.setHeader("Content-Disposition", "attachment; fileName=bankmanage.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	BankManageDTO bmDto = (BankManageDTO)model.get("bmDto");
	
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
<title>법인통장 정보 리스트</title>
</head>
<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	String a = "'";
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div ><strong><font size=6>법인통장관리  내역 </font></strong><div align="right"><%=curDate %></div></div>
		
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <td align="center"><strong>No.</strong></td>
                 <td align="center"><strong>은행명</strong></td>
                 <td align="center"><strong>은행코드</strong></td>
                 <td align="center"><strong>계좌번호</strong></td>
                 <td align="center"><strong>신규일<br>(개설일)</br></strong></td>
                 <td align="center"><strong>발행일</strong></td>
                 <td align="center"><strong>계좌관리점<br>(신규점)</br></strong></td>
                 <td align="center"><strong>통장발행점</strong></td>
                 <td align="center"><strong>고객번호</strong></td>
                 <td align="center"><strong>등록일</strong></td>
                 <td align="center"><strong>등록자</strong></td>
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
		  <td align="center"><%=ds.getString("BankName") %></td>
		  <td align="center" style='mso-number-format:"\@";'><%=ds.getString("BankCode") %></td>
          <td align="center" style='mso-number-format:"\@";'><%=ds.getString("AccountNumber") %></td>
          <td align="center"><%=ds.getString("NewDate") %></td>
          <td align="center"><%=ds.getString("ReturnDate") %></td>  
          <td align="center"><%=ds.getString("BankBook") %></td>
          <td align="center"><%=ds.getString("AccountManage") %></td>
          <td align="center" style='mso-number-format:"\@";'><%=ds.getString("CustomerNum") %></td>
          <td align="center"><%=ds.getString("RegistrationDate") %></td>
          <td align="center"><%=ds.getString("RegistrationName") %></td>
			</tr>
		<!-- :: loop :: -->
		<%	
			j++;
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="12" align="center" class="td5">게시물이 없습니다.</td>
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
