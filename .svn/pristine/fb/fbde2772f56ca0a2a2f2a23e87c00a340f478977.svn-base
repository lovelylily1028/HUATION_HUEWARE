<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.contractmanage.ContractManageDTO"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	//사용자    사용x  IDString SessionUserID ="";
	//사용자명 사용x  String SessionUserName = "";
	
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");
	String date = new SimpleDateFormat("_ss").format(new java.util.Date());
	response.setHeader("Content-Disposition", "attachment; fileName=UnissuedNoCollectList2"+date+".xls");
	String todayDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());
	response.setHeader("Content-Description", "JSP Generated Data");
	ContractManageDTO cmDto = (ContractManageDTO)model.get("cmDto");
	CommonDAO comDao = (CommonDAO)model.get("comDao");
	
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
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div><strong><font size=6>미수채권현황</font></strong><div align="right"><%=todayDate %></div></div>
				<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
					<tr height="25" bgcolor="#F8F9FA">
						<th>계약번호</th>
						<th>계약일자</th>
						<th>견적번호</th>
						<th>발주사</th>
						<th>계약명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>미수금액</th>
						<th>회수금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
					<tbody>
									<%
										if(ld.getItemCount()>0){
											int i = 0;
											ds.first();
											while(ds.next()){
												
												long sprice = ds.getLong("SUPPLY_PRICE");
												long vat = ds.getLong("VAT");
												long total = sprice+vat;
												
												if(ds.getString("no_collect_total").equals("0") || ds.getString("no_collect_total").equals("")){
													i++;
													continue;
												}
									%>
									<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
												<tr>
													<td><%=ds.getString("ContractCode") %></td>	<!-- 계약번호 -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- 계약일자 -->
													<td><%=ds.getString("Public_No") %></td>	<!-- 견적번호 -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- 발주사 -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- 계약명 -->
											        <td><%=NumberUtil.getPriceFormat(total) %></td>	<!-- 계약금 -->
											        <%-- <%if(!ds.getString("no_collect_total").equals("")){ %>	<!-- 미수금액  --> --%>
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
											        <%-- <%}else{%>
          											<td align="center">-</td>
          											<%} %> --%>
          											<%if(!ds.getString("deposit_amt_total").equals("")){%>	<!-- 회수금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
											        <%}else{%>
											        <td align="center">-</td>
											        <%}%>
											        <td><%=comDao.getUserNm(ds.getString("SALES_CHARGE")) %></td>	<!-- 담당영업 -->
											        <%if(!ds.getString("ChargePmNm").equals("")){%>
											        <td><%=ds.getString("ChargePmNm") %></td>	<!-- 담당PM -->
											        <%}else{%>
          											<td align="center">-</td>
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
					</tbody>
				</table>
</body>
</html>