<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.huebookmanage.HueBookManageDTO"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	
	  String fileName ="";
	  Map model = (Map)request.getAttribute("MODEL");
	//현재날짜 불러오기 SimpleDateFormat
	  String curDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());														
				
	

	response.setHeader("Content-Disposition", "attachment; filename=hueBookRequestList.xls");
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
<title>HueBook도서신청 리스트</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div ><strong><font size=6>HUEBOOK 도서신청 내역 </font></strong><div align="right"><%=curDate %></div></div>
							
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <td align="center"><strong>진행상태</strong></td>
                 <td align="center"><strong>번호</strong></td>
                 <td align="center"><strong>도서명</strong></td>
                 <td align="center"><strong>출판사</strong></td>
                 <td align="center"><strong>저자</strong></td>
                 <td align="center"><strong>신청자</strong></td>
                 <td align="center"><strong>신청가격</strong></td>
                 <td align="center"><strong>결재일자</strong></td>
                 <td align="center"><strong>구매가격</strong></td>
                 <td align="center"><strong>구매일자</strong></td>
                 <td align="center"><strong>구매처</strong></td>
                 <td align="center"><strong>승인/반려사유</strong></td>
                 <td align="center"><strong>작성일시</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {
				
			//진행상태값 셋팅(1.신청중.2결재완료3.구매완료)
			String status = "";
			
			status=ds.getString("status");
			if(status.equals("1")){
				status="신청중";
			}else if(status.equals("2")){
				status="결재완료";
			}else if(status.equals("3")){
				status="구매완료";
			}else{
				status="반려";
			}
		%>

			<tr bgcolor="#FFFFFF" height="23">
		  <td align="center"><%=status%></td>
		  <td align="center"><%=ds.getString("indexno") %></td>
		  <td align="center"><%=ds.getString("bookName") %></td>
          <td align="center"><%=ds.getString("publisher") %></td>
          <td align="center"><%=ds.getString("writer") %></td>
          <td align="center"><%=ds.getString("requestName") %></td>  
          <td align="right"><%=NumberUtil.getPriceFormat(ds.getString("price")) %>원</td>
          <td align="center"><%=ds.getString("clearDate") %></td>  
          <td align="right"><%=NumberUtil.getPriceFormat(StringUtil.nvl(ds.getString("buyPrice"),0)) %>원</td>
          <td align="center"><%=ds.getString("buyDate") %></td>
          <td align="center"><%=ds.getString("purchasingOffice") %></td>
          <td align="center"><%=ds.getString("approvalAndReturn") %></td>
          <td align="center"><%=ds.getString("createDateTime") %></td>
			</tr>
		<!-- :: loop :: -->
		<%
			i++;

				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="13" align="center" class="td5">게시물이 없습니다.</td>
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
