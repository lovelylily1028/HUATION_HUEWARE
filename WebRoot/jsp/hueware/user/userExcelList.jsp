<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%
	String SessionUserID ="";//����� ID
	String SessionUserName = "";//����ڸ�
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");

	response.setHeader("Content-Disposition", "attachment; filename=userExcel.xls");
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
<title>����� ���� ����Ʈ</title>
</head>

<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	String position = "-";

%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6> ����� ����  ����Ʈ  </font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <th>����ڸ�</th>
				<th>ID</th>
				<th>���</th>
				<th>�ֹι�ȣ</th>
				<th>����(��)</th>
				<th>�Ҽ�</th>
				<th>����</th>
				<th>�޴�����ȣ</th>
				<th>�系�����ȣ</th>
				<th>��뿩��</th>
				<th>�Ի���</th>
				<th>�����</th>
				<th>�����η���������</th>
			</tr>
		<!-- :: loop :: -->
		<!--����Ʈ---------------->
		<!--����Ʈ---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String HireDate ="";
                    	
                    	if(ds.getString("HireDateTime").equals("")){
                    		HireDate ="";
                    	}else{
                    		HireDate = ds.getString("HireDateTime").substring(0,10);
                    	}
            %>
        <tr>
          <input type="hidden" name="seqs" >
          
          <td><%=ds.getString("UserName")%></td>
          <td><%=ds.getString("UserID")%></td>
          <td><%=ds.getString("EmployeeNum")%></td>
          <td><%=ds.getString("jumin1").equals("-")?ds.getString("jumin1"):ds.getString("jumin1")+"******"%></td>
          <td><%=ds.getString("jumin2")%></td>
          <td><%=ds.getString("GroupName")%></td>
          <td>
          <%
         		if(ds.getString("Position").equals("A")) {
          			position = "��ǥ�̻�";
          		} else if(ds.getString("Position").equals("B")) {
          			position = "�̻�";
          		} else if(ds.getString("Position").equals("C")) {
          			position = "�׷츮��";
          		} else if(ds.getString("Position").equals("D")) {
          			position = "������";
          		} else if(ds.getString("Position").equals("E")) {
          			position = "�Ŵ���";
          		} else if(ds.getString("Position").equals("F")) {
          			position = "���";
          		} else if(ds.getString("Position").equals("G")) {
          			position = "����";
          		} else if(ds.getString("Position").equals("6")) {
          			position = "��Ÿ";
          		}
          %>
          <%=position %>
          </td>
          <td><%=ds.getString("OfficeTellNoFormat")%></td>
          <td><%=ds.getString("OfficeTellNoFormat2")%></td>
          <td><%=ds.getString("UseYN")%></td>
          <td><%=HireDate%></td>
          <td><%=ds.getString("FireDateTime") %></td>
                    <td><%
                   String BoardFile=ds.getString("BoardFile");
          		   String BoardFileNm=ds.getString("BoardFileNm");
                   String serverUrl = "";// + request.getServerName() + request.getContextPath();
                    int c_index=BoardFile.lastIndexOf("/");
                    String boardfilename=BoardFile.substring(c_index+1);
                    String boardpath=""; //���ϰ�� �о����
                    if(!BoardFile.equals("")){
                    	
                 %>
           
            ���� ����
            	<%
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
       	 <%
                }
            %>
		</table>
		</td>
	</tr>
</table>									
</body>
</html>
