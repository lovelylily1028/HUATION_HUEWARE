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
	
	response.setHeader("Content-Disposition", "attachment; fileName=contractCodeUnissuedExcel.xls");
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
<title>계약코드미발행현황</title>
</head>
<body>
	<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	%>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>계약코드미발행현황</font></strong><div align="right"><%=todayDate %></div></div>
			<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA">
						<th>No.</th>
						<th>견적서발행번호</th>
						<th>견적일자</th>
						<th>발주사</th>
						<th>프로제젝트명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>미발행금액</th>
						<th>기발행금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
								<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											while(ds.next()){
												//long sprice = ds.getLong("SUPPLY_PRICE");
												//long vat = ds.getLong("VAT");
												//long total = sprice+vat;
												long unissued = ds.getLong("EPRice") - ds.getLong("IPRice");
												
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("PUBLICNO") %></td>	<!-- 견적서 발행 번호 -->
													<td><%=ds.getString("ESTIMATE_DT") %></td>	<!-- 견적일자 -->
											        <td><%=ds.getString("E_COMP_NM") %></td>	<!-- 발주사(업체명) -->
											        <td class="text_l"><%=ds.getString("TITLE") %></td>	<!-- 프로젝트명 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("EPRice"))%></td>	<!-- 계약금 -->
											       <%--  <%if(!ds.getString("min_price_total").equals("")){ %>	<!-- 미발행금액  --> --%>
											        <td><%=NumberUtil.getPriceFormat(unissued)%></td>
											       <%--  <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("IPRice").equals("")){%>	<!-- 기발행금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("IPRice"))%></td>
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
											<td colspan="10">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
				</table>

</body>
</html>
