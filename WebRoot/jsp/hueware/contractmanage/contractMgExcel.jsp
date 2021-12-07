<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.contractmanage.ContractManageDTO"%>
<%
	String SessionUserID ="";//사용자 ID
	String SessionUserName = "";//사용자명
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");

	response.setHeader("Content-Disposition", "attachment; fileName=ContractManage.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	ContractManageDTO cmDTO = (ContractManageDTO)model.get("cmDTO");
	
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
<title>계약관리 정보 리스트</title>
</head>
<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div ><strong><font size=6>Huation 계약관리 내역 </font></strong><div align="right"></div></div>
		
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
	          <td align="center" rowspan="2"><strong>계약번호</strong></td>
	          <td align="center" rowspan="2"><strong>견적번호</strong></td>
	          <td align="center" rowspan="2"><strong>발주사</strong></td>
	          <td align="center" rowspan="2"><strong>계약명</strong></td>
	          <td align="center" colspan="3"><strong>계약금액</strong></td>
	          <td align="center" colspan="2"><strong>계산서 발행금액</strong></td>
	          <td align="center" colspan="2"><strong>수금액</strong></td>
	          <td align="center" rowspan="2"><strong>계약종결</strong></td>   
			</tr>
	        <tr height="25" bgcolor="#F8F9FA" >
	          <td align="center">공급가</td>
	          <td align="center">부가세</td>
	          <td align="center">합계</td>
	          
	          <td align="center">누적 발행금액</td>
	          <td align="center">미 발행금액</td>
	  
	   		  <td align="center">총 수금액</td>
	          <td align="center">미 수금액</td>
	        </tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
   			int j = 1;	
			while (ds.next()) {
				
			String Status = ds.getString("ContractStatus"); //계약종결 여부 플래그 값
	        String StatusStr = "";							//계약종결 여부 플래그 뷰잉 값
	        String StatusColor = "";						//계약종결 여부 플래그 뷰잉 컬러 값
	          if(Status.equals("1")){
	                	StatusStr = "진행중";
	                }else if(Status.equals("2")){
	                	StatusStr = "조기종료";
	                	StatusColor = "#F29661";
	                }else if(Status.equals("3")){
	                	StatusStr = "계약종결";
	                	StatusColor = "#2F9D27";
	                }
		%>

			<tr bgcolor="#FFFFFF" height="23">
			  <td><%=ds.getString("ContractCode")%></td>
	       	  <td><%=ds.getString("Public_No")%></td>
	          <td><%=ds.getString("Ordering_Organization") %></td>
	          <td><%=ds.getString("ContractName") %></td>
	          <td><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
	          <td><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
	      <%
			long sprice=ds.getLong("SUPPLY_PRICE");
			long vat=ds.getLong("VAT");
			long total=sprice+vat;
		  %>
          <td align="right"><%=NumberUtil.getPriceFormat(total)%></td>
          <%if(!ds.getString("sum_price_total").equals("")){%>
          <td><%=NumberUtil.getPriceFormat(ds.getLong("sum_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%}%>
          <%if(!ds.getString("min_price_total").equals("")){ %>
          <td><%=NumberUtil.getPriceFormat(ds.getLong("min_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%} %>
         <%if(!ds.getString("deposit_amt_total").equals("")){ %>
          <td><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <%if(!ds.getString("no_collect_total").equals("")){ %>
          <td><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <td><%=StatusStr%></td>
	          
			</tr>
		<!-- :: loop :: -->
		<%	
			j++;
			i++;
				}
			} else {
		%>
			<tr align="center" valign="top">
				<td colspan="14" align="center" class="td5">게시물이 없습니다.</td>
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
