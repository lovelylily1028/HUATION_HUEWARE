<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.baroservice.ws.BaroService_TISoapProxy"%>
<%@ page import="com.baroservice.ws.TaxInvoiceState"%>
<%

	CommonDAO comDao=new CommonDAO();

	Map model = (Map)request.getAttribute("MODEL");
    ArrayList<InvoiceDTO> arrlist = (ArrayList) model.get("listInfo");

	response.setHeader("Content-Disposition", "attachment; filename=invoiceExcel.xls");
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
<title>���ݰ�꼭 ����Ʈ</title>
</head>

<body>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>���ݰ�꼭 ����Ʈ</font></strong></div>
		

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			  <tr height="25" bgcolor="#F8F9FA">
				<td rowspan="2" align="center"><strong>��������</strong></td>
				<td rowspan="2" align="center"><strong>����</strong></td>
				<td rowspan="2" align="center"><strong>ǰ��</strong></td>
				<td rowspan="2" align="center"><strong>��������</strong></td>   
				<td colspan="2" align="center"><strong>���޹޴���</strong></td>
				<td colspan="3" align="center"><strong>���޾�</strong></td>
				<td rowspan="2" align="center"><strong>�Աݿ�������</strong></td>
				<td rowspan="2" align="center"><strong>�Աݾ�</strong></td>
				<td rowspan="2" align="center"><strong>�Ա�����</strong></td>
				<td rowspan="2" align="center"><strong>����</strong></td>
						  
			  </tr>
			   <tr height="25" bgcolor="#F8F9FA">
			   
				<td align="center"><strong>����ڵ�Ϲ�ȣ</strong></td>
				<td align="center"><strong>��ȣ</strong></td>
				<td align="center"><strong>���ް�</strong></td>
				<td align="center"><strong>�ΰ���</strong></td>
				<td align="center"><strong>�հ�</strong></td>
			</tr>		 
		<!-- :: loop :: -->
		<!--����Ʈ---------------->
		<%
		if(arrlist.size() > 0){	
			int i = 0;
			String state="";
			String dipositYN="";
			String issuetype="";
			String issuetypeNo="";
			
				for(int j=0; j < arrlist.size(); j++ ){	
					InvoiceDTO dto = arrlist.get(j);
					
					  state=dto.getState();
					  issuetype=dto.getIssuetype();
					  System.out.println("-------------"+issuetype);
					  
						if(state.equals("03")){
							dipositYN="�ԱݿϷ�";
						}else if(state.equals("02")){
							dipositYN="�������";
						}else{
							dipositYN="�Աݴ��";
						}
						
						
						  if(issuetype.equals("01")){
								
							issuetypeNo ="������";
						}else if(issuetype.equals("02")){
								 
						issuetypeNo="��������";
						} else if(issuetype.equals("03")){
									 
							issuetypeNo="������";
							} 
						 
		%>

			<tr bgcolor="#FFFFFF" height="23">
			
			<td align="center" class=xl65><%=issuetypeNo%></td>
			
			<td align="center"><%=dipositYN%></td>
			
			
			<%--
			<td align="center"><%=dto.getTITLE() %></td>
			 --%>
			<td align="center"><%=dto.getITEM_NAME() %></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getPublic_dt(),"/")%></td>
			
			<td align="center"><%=dto.getPermit_no()%></td>
			<td align="center"><%=dto.getComp_nm()%></td>
			
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getSupply_price())%></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getVat())%></td>
			
			<%
					long supval=Long.parseLong(dto.getSupply_price());
					long vatval=Long.parseLong(dto.getVat());
					long total=supval+vatval;
			%>  
			<td align="center"><%=NumberUtil.getPriceFormat(total)%></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getPre_deposit_dt(),"/")%></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getDeposit_amt())%></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getDeposit_dt(),"/")%></td>
		    <td align="center">
          
          <%
          if(issuetype.equals("03")){
        	  out.println("O");
          }else if(issuetype.equals("01")||issuetype.equals("02")){
        	  
        	  //String CERTKEY = "FDB60D89-8AE8-4BBB-A1AA-A708EFCD83D7";				//�׽�Ʈ��������Ű
  			String CERTKEY = "ED59C6A5-C0C8-4A6C-9C65-0B8E254D3640";				//�Ǽ��� ����Ű
			String CorpNum = "1088193762";				//�������� ����ڹ�ȣ ('-' ����, 10�ڸ�)	
			String MgtKey = dto.getMGTKEY();					//��ü����������ȣ	
			
			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			
			TaxInvoiceState Result = BST.getTaxInvoiceState(CERTKEY, CorpNum, MgtKey);
			
			int Open1 = Result.getIsOpened();
			
			if (Result.getBarobillState() < 0){	
				out.println("����");
			}else if(Open1 ==1){	
				out.println("O");
			}else if(Open1 ==0){
				out.println("X");
			}
			
			
          }
			
          
		%>	
          
          </td>
			
				
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="13" align="center" class="td5">�Խù��� �����ϴ�.</td>
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
