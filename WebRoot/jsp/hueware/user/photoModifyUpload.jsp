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
<form name="phothFrm"  method="post" action="<%= request.getContextPath()%>/B_User.do?cmd=photoModifyUpload"   enctype="multipart/form-data">
		<%
			if(fileNm.equals("")){
		%>
			<div style="padding-top:165px;width:300px;height:213px;background:#fff;text-align:center;">사진 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /><br /><span style="font-size:11px;letter-spacing:-1px;">(최근 6개월 이내 촬영 /<br />첨부가능 파일유형 : <strong style="color:#ff6600;letter-spacing:0;">jpg, gif</strong>)</span></div>
        <%
			}else{
		%>
			<div style="width:300px;height:378px;background:#fff;"><img src="<%= request.getContextPath() %>/data/<%=fileNm%>" width="300" height="378" /></div>
		<%
			}
		%>
		<div style="position:relative;padding-top:5px;width:300px;text-align:center;"><a href="#link" class="btn_type03" style="margin:0;" value="찾아보기"><span>upload</span></a><input type="file" name="photo_file" onChange="javascript:uploadFile();" style="position:absolute;top:5px;left:124px;width:54px;height:23px;cursor:pointer;opacity:0.0;" /></div>
</form>
<script>
 parent.UserModify.photo.value='<%=fileNm%>';
</script>