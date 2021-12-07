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
	//�����    ���x  IDString SessionUserID ="";
	//����ڸ� ���x  String SessionUserName = "";
	
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");
	response.setHeader("Content-Disposition", "attachment; fileName=UnissuedNoCollectList.xls");
	String todayDate = new SimpleDateFormat("yyyy��MMMMdd��").format(new java.util.Date());
	response.setHeader("Content-Description", "JSP Generated Data");
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
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
				%>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div><strong><font size=6>�ް��̷�</font></strong><div align="right"><%=todayDate %></div></div>
			<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
					<tr height="25" bgcolor="#F8F9FA">
						<th>��û��</th>
						<th>�������</th>
						<th>�ް�����</th>
						<th>�ϼ�</th>
						<th>������</th>
						<th>������</th>
						<th>�����</th>
						<th>����</th>
						<th>�ݷ�����</th>
						<th>������(TL)</th>
						<th>������(CEO)</th>
					</tr>
					<tbody>
					
							<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
           				 %>
						<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
							<tr>
								<td><%=ds.getString("UserName")%></td>
								<%if(ds.getString("State1").equals("N") || ds.getString("State2").equals("N")){%>
								<td>�ݷ�</td>
								<%}else if(ds.getString("State1").equals("Y") && ds.getString("State2").equals("Y")){ %>
								<td>����</td>
								<%}else{ %>
								<td>��û��</td>
								<%}%>
								<td><%=ds.getString("HollyFlagName") %></td>
								<td><%=ds.getString("Day") %></td>
								<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
								<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
								<td><%=ds.getString("RegDateTime").substring(0,10) %></td>
								<td class="text_l"><%=ds.getString("Reason") %></td>
								<td class="text_l"><%=ds.getString("ReturnReason") %></td>
								<td><%=ds.getString("SignName1") %></td>
								<td><%=ds.getString("SignName2") %></td>
							</tr>
					<%
			                i++;
			                    }
			                } else {
			         %>
			            <tr>
          <td colspan="11">�ް� ��û ��Ȳ�� �����ϴ�.</td>
        </tr>
        	
        	<%
                }
            %>
					
					
					
				</tbody>
				</table>
</body>
</html>