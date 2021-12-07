<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%
	String SessionUserID ="";//사용자 ID
	String SessionUserName = "";//사용자명
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
<title>사용자 정보 리스트</title>
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
		<div align=center><strong><font size=6> 사용자 정보  리스트  </font></strong></div>

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			<tr height="25" bgcolor="#F8F9FA" >
                 <th>사용자명</th>
				<th>ID</th>
				<th>사번</th>
				<th>주민번호</th>
				<th>나이(만)</th>
				<th>소속</th>
				<th>직급</th>
				<th>휴대폰번호</th>
				<th>사내직통번호</th>
				<th>사용여부</th>
				<th>입사일</th>
				<th>퇴사일</th>
				<th>투입인력프로파일</th>
			</tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<!--리스트---------------->
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
          			position = "대표이사";
          		} else if(ds.getString("Position").equals("B")) {
          			position = "이사";
          		} else if(ds.getString("Position").equals("C")) {
          			position = "그룹리더";
          		} else if(ds.getString("Position").equals("D")) {
          			position = "팀리더";
          		} else if(ds.getString("Position").equals("E")) {
          			position = "매니저";
          		} else if(ds.getString("Position").equals("F")) {
          			position = "사원";
          		} else if(ds.getString("Position").equals("G")) {
          			position = "인턴";
          		} else if(ds.getString("Position").equals("6")) {
          			position = "기타";
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
                    String boardpath=""; //파일경로 읽어오기
                    if(!BoardFile.equals("")){
                    	
                 %>
           
            파일 존재
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
