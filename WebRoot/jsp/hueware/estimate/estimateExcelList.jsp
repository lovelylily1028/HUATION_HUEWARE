<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%

	CommonDAO comDao=new CommonDAO();

	Map model = (Map)request.getAttribute("MODEL");
    ArrayList<EstimateDTO> arrlist = (ArrayList) model.get("listInfo");

	response.setHeader("Content-Disposition", "attachment; filename=estimateExcel.xls");
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
<title>견적서 리스트</title>
</head>

<body>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>견적서 리스트</font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA">
				<td colspan="3"align="center"><strong>구분</strong></td>
				<td rowspan="2" align="center"><strong>견적일자</strong></td>
				<td colspan="3" align="center"><strong>고객정보</strong></td>   
				<td colspan="3" align="center"><strong>견적금액</strong></td>
				<td rowspan="2" align="center"><strong>작성자</strong></td>
				<td rowspan="2" align="center"><strong>담당영업</strong></td>
			  </tr>
			   <tr height="25" bgcolor="#F8F9FA">
				<td align="center"><strong>NO</strong></td>
				<td align="center"><strong>발행번호</strong></td>
				<td align="center"><strong>모 발행번호</strong></td>
				<td align="center"><strong>수신</strong></td>
				<td align="center"><strong>업체명</strong>></td>
				<td align="center"><strong>제목</strong></td>
				<td align="center"><strong>공급가</strong></td>
				<td align="center"><strong>부가세</strong></td>
				<td align="center"><strong>합계</strong></td>
			  </tr>			 
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if(arrlist.size() > 0){	
			int i = 0;

				for(int j=0; j < arrlist.size(); j++ ){	
					EstimateDTO dto = arrlist.get(j);
		%>

			<tr bgcolor="#FFFFFF" height="23">
			<td align="center" class=xl65><%=j+1%></td>
			<td align="center">&nbsp;<%=StringUtil.nvl(dto.getPublic_no(),"") %></td>
			<td align="center">&nbsp;<%=StringUtil.nvl(dto.getP_public_no(),"") %></td>
			<td align="center">&nbsp;<%=DateTimeUtil.getDateType(1,dto.getEstimate_dt(),"/") %></td>
			<td align="center">&nbsp;<%=StringUtil.nvl(dto.getReceiver(),"") %></td>
			<td align="center">&nbsp;<%=StringUtil.nvl(dto.getE_comp_nm(),"") %></td>
			<td align="center">&nbsp;<%=StringUtil.nvl(dto.getTitle(),"") %></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getSupply_price())%></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getVat())%></td>
			<%
					long supval=Long.parseLong(dto.getSupply_price());
					long vatval=Long.parseLong(dto.getVat());
					long total=supval+vatval;
			%>
			<td align="center"><%=NumberUtil.getPriceFormat(total)%></td>
			<td align="center">&nbsp;<%=comDao.getUserNm(dto.getReg_id()) %></td>
			<td align="center">&nbsp;<%=comDao.getUserNm(dto.getSales_charge())%></td>
				
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
