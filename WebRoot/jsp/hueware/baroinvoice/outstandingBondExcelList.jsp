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
	String todayDate = new SimpleDateFormat("yyyy��MMMMdd��").format(new java.util.Date());
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
<title>�̼�ä����Ȳ</title>
</head>
<body>
 <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
 %>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>�̼�ä����Ȳ</font></strong><div align="right"><%=todayDate %></div></div>
			<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA">
						<th>No.</th>
						<th>����ȣ</th>
						<th>��������</th>
						<th>������ȣ</th>
						<th>���ֻ�</th>
						<th>ǰ��</th>
						<th>���ݾ�<br />(VAT����)</th>
						<th>����ݾ�<br />(VAT����)</th>
						<th>�̼��ݾ�</th>
						<th>ȸ���ݾ�</th>
						<th>��翵��</th>
						<th>���PM</th>
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
													<td><%=ds.getString("ContractCode") %></td>	<!-- ����ȣ -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- ������� -->
													<td><%=ds.getString("PUBLIC_NO") %></td>	<!-- ������ȣ -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- ���ֻ� -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- ���� -->
											        <td><%=NumberUtil.getPriceFormat(ds.getString("EPRice")) %></td>	<!-- ���� -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("IPRice")) %></td>	<!-- �����ݾ� -->
											      <%--   <%if(!ds.getString("no_collect_total").equals("")){ %> --%>	<!-- �̼��ݾ�  -->
											        <td><%=NumberUtil.getPriceFormat(nocollect)%></td>
											    <%--     <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("DEPOSIT_AMT").equals("")){%>	<!-- ȸ���ݾ� -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("DEPOSIT_AMT"))%></td>
											        <%}else{%>
											        <td>-</td>
											        <%}%>
											        <td><%=comDao.getUserNm(ds.getString("SALES_CHARGE")) %></td>	<!-- ��翵�� -->
											        <%if(!ds.getString("ChargePmNm").equals("")){%>
											        <td><%=ds.getString("ChargePmNm") %></td>	<!-- ���PM -->
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
											<td colspan="12">�Խù��� �����ϴ�.</td>
										</tr>
							        	<%
							                }
							            %> 
				</table>

</body>
</html>