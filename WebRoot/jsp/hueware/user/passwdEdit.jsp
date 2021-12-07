<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String Page="";
	String msg="";
	String user_id="";
	String passwd="";

	if(model != null) {
		msg = StringUtil.nvl((String)model.get("msg"),"");
		Page = StringUtil.nvl((String)model.get("page"),"");
		user_id = StringUtil.nvl((String)model.get("user_id"),"");
		passwd =  StringUtil.nvl((String)model.get("passwd"),"");
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>비밀번호변경</title>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/JavaScript" language="JavaScript" src="<%= request.getContextPath() %>/dwr/engine.js" xml:space="preserve"></script>
<script type="text/JavaScript" language="JavaScript" src="<%= request.getContextPath() %>/dwr/util.js" xml:space="preserve"></script>
<script>
<!--

function passWdConfirm(){
																								
		var requestUrl='<%= request.getContextPath() %>/B_User.do?cmd=pwdEnc&cpawd='+document.passwdFrm.passwd.value+'&dpawd='+document.passwdFrm.opasswd.value;

		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
		var result="";
		//var test="";
		
		//jQuery Ajax
		$.ajax({
			//contentType : "application/xml", //contentType 지정(지정안해도 상관없음)
			url : requestUrl,	//Ajax로 요청할 url 지정
			type : "get", //get방식 또는 post 방식 지정
			dataType : "xml", //읽을 dataType 지정   예)xml 방식인지 html 방식인지
			//cashe : false,
			async : false,
			
			//ajax가 해당 url로 요청시 성공했을 경우 실행할 메소드 지정
			success : function(xml, status, request){
					//xml의 해당 부분을 읽을 메소드
					$(xml).find("encpwd-result").each(
					function(){
						//alert('encpwd-result xml추가한 jsp페이지 위치 찾음');
						result = $(this).find("encpwd").text();
						//alert('encpwd 값은 : ' + result);
						
					}		
				)
			},
			//해당 url 요청시 실패할경우 출력
			error : function(request, status, error){
				alert("code :"+request.status + "\r\message :" + request.responseText);
			}
			
		});
		//alert("1:"+result);
		return result;
	}

function goModify(){

	var obj=document.passwdFrm;

	if(obj.passwd.value==''){
		alert('현재 비밀번호를 입력하세요!');
		obj.passwd.focus();
		return;
	}
	
	 var result=passWdConfirm();
	//alert('result:'+result); 암호화된 비밀번호값.

	if(obj.opasswd.value!=result){
		alert('현재 비밀번호가 다릅니다. 비밀번호를 확인하세요!');
		obj.passwd.focus();
		return;
	}
	if(obj.mpasswd.value==''){
		alert('변경할 비밀번호를 입력하세요!');
		obj.mpasswd.focus();
		return;
	}

	if(obj.rpasswd.value==''){
		alert('변경할 비밀번호를  재입력하세요!');
		obj.rpasswd.focus();
		return;
	}
	if(obj.passwd.value==obj.mpasswd.value){
		alert('변경할 비밀번호가 같습니다. 다른 비밀번호를 입력하세요!');
		obj.mpasswd.focus();
		return;
	}

	if(obj.mpasswd.value!=obj.rpasswd.value){
		alert('변경할 비밀번호를 다시한번 입력하세요!');
		obj.rpasswd.focus();
		return;
	}

	obj.passwd.value = obj.opasswd.value;
	obj.password.value=obj.mpasswd.value;
	obj.submit();

}

//레이아웃 팝업 닫기 버튼 함수
function goClosePop(){
	//$('[name='+formName+"]").dialog('close');
	$('#password_pop').dialog('close');
}


//-->
</script>
</head>
<body>
<!-- 레이어팝업 -->
<div class="passwordLp">
	<!-- content -->
	<div id="contentLp">
		<!-- 비밀번호변경 -->
	    <form name="passwdFrm" method="post" action="<%= request.getContextPath()%>/B_User.do?cmd=passModify">
		 <input type="hidden" name="password" value=""/>
	     <input type="hidden" name="userid" value="<%=user_id%>"/>
	     <input type="hidden" name="opasswd" value="<%=passwd%>"/>
	     <fieldset>
			<legend>비밀번호변경</legend>
			<table class="tbl_type" summary="비밀번호변경(현재비밀번호, 새비밀번호, 새비밀번호확인)">
				<colgroup>
					<col width="40%" />
					<col width="*" />
				</colgroup>
				<tbody>
				<tr>
					<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
					<th><label for="">현재비밀번호</label></th>
					<td><input type="password" name="passwd" value="" class="text" title="현재비밀번호" style="width:148px;" /></td>
				</tr>
				<tr>
					<th><label for="">새비밀번호</label></th>
					<td><input type="password" name="mpasswd" value="" class="text" title="새비밀번호" style="width:148px;" /></td>
				</tr>
				<tr>
					<th><label for="">새비밀번호확인</label></th>
					<td><input type="password" name="rpasswd" value="" class="text" title="새비밀번호확인" style="width:148px;" /></td>
				</tr>
				</tbody>
			</table>
	     </fieldset>
		</form>
		<!-- //비밀번호변경 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:goModify()" class="btn_type02"><span>확인</span></a><a href="javascript:goClosePop()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</div>
<!-- //레이어팝업 -->
</body>
</html>
<script>

 if("" != '<%=msg%>'){
	 alert('<%=msg%>');
 }
</script>