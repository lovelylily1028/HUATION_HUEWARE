<%@ page contentType="text/html; charset=euc-kr"%>	
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String fileNm = (String)model.get("fileNm");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>전자팩스 솔루션 리더 휴에이션</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<style type="text/css">
#divinputfile{
 background:url(upload_file.gif) no-repeat 100% 1px;
 height:28px;
 width:385px;
 margin:0px;
}

#divinputfile #filepc{
 opacity: 0.0;
 -moz-opacity: 0.0;
 filter: alpha(opacity=00);
 font-size:18px;
}

#fakeinputfile{
 margin-top:-28px;
}

#fakeinputfile #fakefilepc{
 width:265px;
 height:22px;
 font-size:18px;
 font-family:Arial;
}
</style>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script>
	function uploadFile(){
		var frm=document.phothFrm;

		if(frm.photo_file.value != "" && !isImageFile(frm.photo_file.value)){
			alert("첨부 가능한 파일 유형은 \n JPG, GIF  입니다.");
			return; 				
		}

		frm.submit();
	}
	
	function mouseOver(){

		document.getElementById("ubtn").style.fontWeight="bold";
		document.getElementById("ubtn").style.color="blue";

	}
	function mouseOut(){
		document.getElementById("ubtn").style.fontWeight="";
		document.getElementById("ubtn").style.color="white";
	}
/**
	 * 이미지  파일 확장자명 체크
	 *
	 **/
	function isImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "gif" || ext == "jpg" ) {
				return true;
			} else {
				return false;
			}
		}
	}
</script>
</head>
<form name="phothFrm"  method="post" action="<%= request.getContextPath()%>/F_Recruit.do?cmd=photoUpload"   enctype="multipart/form-data">
		<%
			if(fileNm.equals("")){
		%>
		  <div style="padding-top:30px;width:110px;height:90px;text-align:center;">사진<br />최근 6개월 이내<br /> 촬영 (<span style="color:red;">jpg,gif</span>)</div>
         <%
			}else{
		%>
			<div><img src="/data/<%=fileNm %>" style="width:110px;height:120px;" /></div>
		<%
			}
		%>
</form>
<script>
 parent.defaultFrm.photo.value='<%=fileNm%>';
</script>
