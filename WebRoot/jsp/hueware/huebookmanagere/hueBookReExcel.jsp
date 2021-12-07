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
	//���糯¥ �ҷ����� SimpleDateFormat
	  String curDate = new SimpleDateFormat("yyyy��MMMMdd��").format(new java.util.Date());														
				
	

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
<title>HueBook������û ����Ʈ</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div ><strong><font size=6>HUEBOOK ������û ���� </font></strong><div align="right"><%=curDate %></div></div>
							
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <td align="center"><strong>�������</strong></td>
                 <td align="center"><strong>��ȣ</strong></td>
                 <td align="center"><strong>������</strong></td>
                 <td align="center"><strong>���ǻ�</strong></td>
                 <td align="center"><strong>����</strong></td>
                 <td align="center"><strong>��û��</strong></td>
                 <td align="center"><strong>��û����</strong></td>
                 <td align="center"><strong>��������</strong></td>
                 <td align="center"><strong>���Ű���</strong></td>
                 <td align="center"><strong>��������</strong></td>
                 <td align="center"><strong>����ó</strong></td>
                 <td align="center"><strong>����/�ݷ�����</strong></td>
                 <td align="center"><strong>�ۼ��Ͻ�</strong></td>
			</tr>
		<!-- :: loop :: -->
		<!--����Ʈ---------------->
		<%
		if (ld.getItemCount() > 0) {
			int i = 0;
			while (ds.next()) {
				
			//������°� ����(1.��û��.2����Ϸ�3.���ſϷ�)
			String status = "";
			
			status=ds.getString("status");
			if(status.equals("1")){
				status="��û��";
			}else if(status.equals("2")){
				status="����Ϸ�";
			}else if(status.equals("3")){
				status="���ſϷ�";
			}else{
				status="�ݷ�";
			}
		%>

			<tr bgcolor="#FFFFFF" height="23">
		  <td align="center"><%=status%></td>
		  <td align="center"><%=ds.getString("indexno") %></td>
		  <td align="center"><%=ds.getString("bookName") %></td>
          <td align="center"><%=ds.getString("publisher") %></td>
          <td align="center"><%=ds.getString("writer") %></td>
          <td align="center"><%=ds.getString("requestName") %></td>  
          <td align="right"><%=NumberUtil.getPriceFormat(ds.getString("price")) %>��</td>
          <td align="center"><%=ds.getString("clearDate") %></td>  
          <td align="right"><%=NumberUtil.getPriceFormat(StringUtil.nvl(ds.getString("buyPrice"),0)) %>��</td>
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
