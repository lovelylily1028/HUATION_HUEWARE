<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.Map"%>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import="com.huation.framework.data.DataSet"%>
<%@ page import="com.huation.common.currentstatus.CurrentStatusDTO" %>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserBroker"%>
<%@ page import="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");
	String msg = (String)model.get("msg");
	String SalesFile = (String)model.get("SalesFile");
	String SalesFileNm = (String)model.get("SalesFileNm");
	String ComentPk = (String)model.get("ComentPk");
	String ModifyFlag = (String)model.get("ModifyFlag");
	
// 	String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
    //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
	String serverUrl = "" + request.getContextPath();
     int c_index=SalesFile.lastIndexOf("/"); // /기준으로 경로자르기.
   	
     String salesfilename=SalesFile.substring(c_index+1); // /기준으로 자른 문자열1개씩 합치기

     String salespath=""; //파일경로 읽어오기
    
     if(!SalesFile.equals("")){
   	  salespath=SalesFile.substring(0,c_index); //파일경로 읽어오기
     }
	
%>

<script>parent.alert('<%=msg%>')
		if('<%=ModifyFlag%>' == 'Y'){			
		parent.document.all('SfilePath_<%=ComentPk%>').href = '<%=serverUrl %>/fileDownServlet?rFileName=<%=SalesFileNm%>&sFileName=<%=salesfilename%>&filePath=<%=salespath%>';
		}
</script>


              	
    
   


