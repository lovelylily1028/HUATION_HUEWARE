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
	CurrentStatusDTO csDto = (CurrentStatusDTO)model.get("csDto");

	String msg = (String)model.get("msg");
	String ID = UserBroker.getUserId(request); //�α��� �� ���� ID
	String NAME = UserBroker.getUserNm(request); //�α��� �� ���� �̸�
	
	//���� ��/��/�� ��������.
	String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

	String ResultVeiw="";
	
	ResultVeiw+="<form name=\"currentCommentIframe_"+csDto.getComentPk()+"\"  method=\"post\"  enctype=\"multipart/form-data\">"+
				"<fieldset><input type=\"hidden\" name=\"ComentPk\" value=\""+csDto.getComentPk()+"\"></input>"+
				"<div class=\"issueCon_area\" id=\""+csDto.getComentPk()+"\">"+
				/* "<h3>Issue Comment</h3>"+ */
	            "<ul class=\"info\">"+
	            "<li><label for=\"\">�̽� ����� :</label><input class=\"text\" type=\"text\" name=\"SalesMan_co\" value=\""+csDto.getSalesMan_co()+"\" style=\"width:100px\" maxlength=\"10\" readonly/></li>"+
			    "<input type=\"hidden\" name=\"ChargeID_co\" value=\""+csDto.getChargeID_co()+"\"></input>"+
			    "<li><span>��翵�� :"+NAME+"</span></li>"+
			    "<li class=\"last\"><span>����� : "+todayDate+"</span></li>";
			  
		      String SalesFile=csDto.getSalesFile(); //�������ϰ��
		          
// 		      String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
		      String serverUrl = "" + request.getContextPath();

	          int c_index=SalesFile.lastIndexOf("/"); // /�������� ����ڸ���.
	        	
	          String salesfilename=SalesFile.substring(c_index+1); // /�������� �ڸ� ���ڿ�1���� ��ġ��
	    
	          String salespath=""; //���ϰ�� �о����
         
          	  if(!SalesFile.equals("")){
		        
          		salespath=SalesFile.substring(0,c_index); //���ϰ�� �о����	
			
	ResultVeiw+="<a href=\""+serverUrl+"/fileDownServlet?rFileName="+csDto.getSalesFileNm()+"&sFileName="+salesfilename+"&filePath="+salespath+"\" class=\"btn_type03\"><span><font color=\"black\">÷������ �ٿ�ε�</font></span></a>";
        	  
          	  } 

	ResultVeiw+="</ul><ul class=\"issueCon\">"+
				"<li><textarea name=\"Contents\" style=\"width:1078px;height:48px;\"  title=\"�̽�����\" dispName=\"����\" onkeyup=\"js_Str_ChkSub(	500, this)\" readonly>"+csDto.getContents()+"</textarea></li>"+
				"<input type=\"hidden\" name=\"p_SalesFile\" value=\""+csDto.getSalesFile()+"\"></input>"+
				"<input type=\"hidden\" name=\"SalesFileNm\" value=\""+csDto.getSalesFileNm()+"\"></input>"+
				"<li><span class=\"guide_txt\">÷�ΰ��� �������� : ��� ����  ÷�ΰ��� �뷮 : �ִ� 200M�̳�.</span></li></ul></fieldset></form>";
				/*
				����/���� ��ư ���� ������.
				"<p class=\"btn_editComm\"><a href=\"#\"><img src=\""+request.getContextPath()+"/images/btn_edit_curr.gif\" onclick=\"javascript:goUpdateRep("+""+csDto.getComentPk()+");\" title=\"������ư\" /></a></p>"+
				"<p class=\"btn_deleteComm\"><a href=\"#\"><img src=\""+request.getContextPath()+"/images/btn_delete_curr.gif\" onclick=\"javascript:goDeleteRep("+""+csDto.getComentPk()+");\" title=\"������ư\" /></a></p>";
				*/
%>

<script>parent.AddView('<%=ResultVeiw%>');
		parent.alert('<%=msg%>');
		
</script>


