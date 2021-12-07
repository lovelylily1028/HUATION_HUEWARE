<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	Map model = (Map)request.getAttribute("MODEL");
	String fileName ="";
	String todayDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());
	CommonDAO comDao = new CommonDAO();
	
	response.setHeader("Content-Disposition", "attachment; fileName=outstandingBondExcelList.xls");
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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>미수채권현황</title>
</head>
<body>
 <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
 %>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>미수채권현황</font></strong><div align="right"><%=todayDate %></div></div>
			<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA">
						<th>No.</th>
						<th>계약번호</th>
						<th>발행일자</th>
						<th>견적번호</th>
						<th>발주사</th>
						<th>품명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>발행금액<br />(VAT포함)</th>
						<th>미수금액</th>
						<th>회수금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
									<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											while(ds.next()){
												
												/* long sprice = ds.getLong("SUPPLY_PRICE");
												long vat = ds.getLong("VAT");
												long total = sprice+vat; */
												long nocollect = ds.getLong("IPRice") - ds.getLong("DEPOSIT_AMT");
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("ContractCode") %></td>	<!-- 계약번호 -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- 계약일자 -->
													<td><%=ds.getString("PUBLIC_NO") %></td>	<!-- 견적번호 -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- 발주사 -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- 계약명 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getString("EPRice")) %></td>	<!-- 계약금 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("IPRice")) %></td>	<!-- 기발행금액 -->
											      <%--   <%if(!ds.getString("no_collect_total").equals("")){ %> --%>	<!-- 미수금액  -->
											        <td><%=NumberUtil.getPriceFormat(nocollect)%></td>
											    <%--     <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("DEPOSIT_AMT").equals("")){%>	<!-- 회수금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("DEPOSIT_AMT"))%></td>
											        <%}else{%>
											        <td>-</td>
											        <%}%>
											        <td><%=comDao.getUserNm(ds.getString("SALES_CHARGE")) %></td>	<!-- 담당영업 -->
											        <%if(!ds.getString("ChargePmNm").equals("")){%>
											        <td><%=ds.getString("ChargePmNm") %></td>	<!-- 담당PM -->
											        <%}else{%>
          											<td>-</td>
          											<%} %>
										          </tr>
										          <% 
										          i++;
												}
											}
										 	else {
										%>
										<tr>
											<td colspan="12">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
				</table>

</body>
</html>