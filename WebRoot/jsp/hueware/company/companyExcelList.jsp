<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
    ArrayList<CompanyDTO> arrlist = (ArrayList) model.get("listInfo");

	response.setHeader("Content-Disposition", "attachment; filename=companyExcel.xls");
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
<title>업체정보</title>
</head>

<body>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>업체정보 </font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >		
                 <td align="center"><strong>사업자등록번호</strong></td>
                 <td align="center"><strong>구분</strong></td>
                 <td align="center"><strong>상태</strong></td>
                 <td align="center"><strong>상호(법인명)</strong></td>
                 <td align="center"><strong>법인등록번호(주민등록번호)</strong></td>
                 <td align="center"><strong>대표자명</strong></td>
                 <td align="center"><strong>개업일</strong></td>
                 <td align="center"><strong>업태</strong></td>
                 <td align="center"><strong>종목</strong></td>
			</tr> 
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if(arrlist.size() > 0){	
			int i = 0;

				for(int j=0; j < arrlist.size(); j++ ){	
					CompanyDTO dto = arrlist.get(j);
		%>

			<tr bgcolor="#FFFFFF" height="23">
				<td>&nbsp;<%=StringUtil.nvl(dto.getComp_code(),"") %></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getComp_taxType(),"") %></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getComp_state(),"") %></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getComp_nm(),"")%></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getComp_no(),"")%></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getOwner_nm(),"")%></td>
				<td>&nbsp;<%=DateTimeUtil.getDateType(1,dto.getOpen_dt(),"/")%></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getBusiness(),"")%></td>
				<td>&nbsp;<%=StringUtil.nvl(dto.getB_item(),"")%></td>
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="10" align="center" class="td5">게시물이 없습니다.</td>
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
