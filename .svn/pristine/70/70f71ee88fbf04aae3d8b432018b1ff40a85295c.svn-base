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
	String ID = UserBroker.getUserId(request); //로그인 한 세션 ID
	String NAME = UserBroker.getUserNm(request); //로그인 한 세션 이름
	
	//금일 년/월/일 가져오기.
	String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

	String ResultVeiw="";
	
	ResultVeiw+="<form name=\"currentCommentIframe_"+csDto.getComentPk()+"\"  method=\"post\"  enctype=\"multipart/form-data\">"+
				"<fieldset><input type=\"hidden\" name=\"ComentPk\" value=\""+csDto.getComentPk()+"\"></input>"+
				"<div class=\"issueCon_area\" id=\""+csDto.getComentPk()+"\">"+
				/* "<h3>Issue Comment</h3>"+ */
	            "<ul class=\"info\">"+
	            "<li><label for=\"\">이슈 재기자 :</label><input class=\"text\" type=\"text\" name=\"SalesMan_co\" value=\""+csDto.getSalesMan_co()+"\" style=\"width:100px\" maxlength=\"10\" readonly/></li>"+
			    "<input type=\"hidden\" name=\"ChargeID_co\" value=\""+csDto.getChargeID_co()+"\"></input>"+
			    "<li><span>담당영업 :"+NAME+"</span></li>"+
			    "<li class=\"last\"><span>등록일 : "+todayDate+"</span></li>";
			  
		      String SalesFile=csDto.getSalesFile(); //실제파일경로
		          
// 		      String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
		      String serverUrl = "" + request.getContextPath();

	          int c_index=SalesFile.lastIndexOf("/"); // /기준으로 경로자르기.
	        	
	          String salesfilename=SalesFile.substring(c_index+1); // /기준으로 자른 문자열1개씩 합치기
	    
	          String salespath=""; //파일경로 읽어오기
         
          	  if(!SalesFile.equals("")){
		        
          		salespath=SalesFile.substring(0,c_index); //파일경로 읽어오기	
			
	ResultVeiw+="<a href=\""+serverUrl+"/fileDownServlet?rFileName="+csDto.getSalesFileNm()+"&sFileName="+salesfilename+"&filePath="+salespath+"\" class=\"btn_type03\"><span><font color=\"black\">첨부파일 다운로드</font></span></a>";
        	  
          	  } 

	ResultVeiw+="</ul><ul class=\"issueCon\">"+
				"<li><textarea name=\"Contents\" style=\"width:1078px;height:48px;\"  title=\"이슈내용\" dispName=\"내용\" onkeyup=\"js_Str_ChkSub(	500, this)\" readonly>"+csDto.getContents()+"</textarea></li>"+
				"<input type=\"hidden\" name=\"p_SalesFile\" value=\""+csDto.getSalesFile()+"\"></input>"+
				"<input type=\"hidden\" name=\"SalesFileNm\" value=\""+csDto.getSalesFileNm()+"\"></input>"+
				"<li><span class=\"guide_txt\">첨부가능 파일유형 : 모든 파일  첨부가능 용량 : 최대 200M이내.</span></li></ul></fieldset></form>";
				/*
				수정/삭제 버튼 현재 사용안함.
				"<p class=\"btn_editComm\"><a href=\"#\"><img src=\""+request.getContextPath()+"/images/btn_edit_curr.gif\" onclick=\"javascript:goUpdateRep("+""+csDto.getComentPk()+");\" title=\"수정버튼\" /></a></p>"+
				"<p class=\"btn_deleteComm\"><a href=\"#\"><img src=\""+request.getContextPath()+"/images/btn_delete_curr.gif\" onclick=\"javascript:goDeleteRep("+""+csDto.getComentPk()+");\" title=\"삭제버튼\" /></a></p>";
				*/
%>

<script>parent.AddView('<%=ResultVeiw%>');
		parent.alert('<%=msg%>');
		
</script>


