<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%@page import="java.util.Map"%>
<%@ page import="com.huation.common.user.UserDTO"%>
<%@ page import="com.huation.common.user.UserDAO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
String EmployeeNumber = (String)model.get("EmployeeNumber");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사용자 등록</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/huefax.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/hueware.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script>

//2013-03-13 기존달력에서 jQuery 달력으로 변경
$(document).ready(function(){
	$('#calendarData1, #calendarData2, #calendarData3').datepicker({
		buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
		//maxDate:0,
		showOn: 'both',
		buttonImageOnly: true,
		prevText: "이전",
		nextText: "다음",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["일","월","화","수","목","금","토"],
		monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		changeMonth: true,
	    changeYear: true,
	});
});



var openWin=0;//팝업객체
var observer;//처리중
//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
}
/*
 * 중복체크
 */
function doCheck(userid){
	
	var requestUrl='<%= request.getContextPath() %>/B_User.do?cmd=userDupCheck&userid='+userid;
	var result=0;
	
	var xmlhttp = null;
	var xmlObject = null;
	var resultText = null;


	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlhttp.open("GET", requestUrl, false);
	xmlhttp.send(requestUrl);

	resultText = xmlhttp.responseText;

	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	xmlObject.loadXML(resultText);
	
	result=xmlObject.documentElement.childNodes.item(0).text;

	return result;
	
}
//ID check 
function fnDuplicateCheck() {
	var frm = document.UserRegist; 
	
	if(frm.ID.value.length == 0){
		alert("사용자ID를 입력하세요");
		return;
	}
	/*
	if(! /^[a-zA-Z0-9]{6,20}$/.test(frm.ID.value)) {
	    alert('사용자ID는 영문/숫자 혼용 6~20자리까지 사용가능합니다');
	    return;
    }	
	*/
	var result=doCheck(frm.ID.value);
	
	if(result==1){
		alert("이미 등록된 아이디 입니다");
		return;
	}else if(result==2){
		alert("삭제 이력이 있는 아이디 입니다");
		return;
	}else {
		if( confirm("사용 가능한 아이디 입니다. 사용하시겠습니까?") ) {
			frm.ID.readOnly = true;	
		} else {
			frm.ID.readOnly = false;	
		}
	}
}
// 등록
function goSave(){
	var frm = document.UserRegist; 
	 
	if(frm.ID.value.length == 0){
		alert("사용자ID를 입력하세요");
		return;
	}
	/*
	if(! /^[a-zA-Z0-9]{6,20}$/.test(frm.ID.value)) {
	    alert('사용자ID는 영문/숫자 혼용 6~20자리까지 사용가능합니다');
	    return;
   }	
	*/
	if(!frm.ID.readOnly) {
		alert("아이디 중복확인을 하세요");
		return;
	}
	
	if(frm.Name.value.length == 0){
		alert("사용자명을 입력하세요");
		return;
	}
/*	
	if(!isNumber(frm.FaxNo.value)) {
		alert("팩스번호는 숫자만 입력가능합니다.");
		return;
	}
	
	if(onlyNum(frm.FaxNo.value).length < 9 || onlyNum(frm.FaxNo.value).length > 11) {
		alert("팩스번호는 9-11자리 입니다.");
		return;
	}
*/	
	if(frm.GroupID.value.length == 0){
		alert("소속을 입력하세요");
		return;
	}
	
	if(frm.OfficeTellNo.value.length == 0){
		alert("핸드폰 번호를 입력하세요");
		return;
	}
	
	/* if(frm.OfficeTellNo2.value.length == 0){
		alert("사내 직통번호를 입력하세요");
		return;
	} */
	

	if(!isNumber(frm.OfficeTellNo.value) && frm.OfficeTellNo.value != 0) {
		alert("휴대폰번호는 숫자만 입력가능합니다.");
		return;
	}
	
	if(frm.OfficeTellNo.value != 0 && ( frm.OfficeTellNo.value < 11 || frm.OfficeTellNo.value > 14) ) {
		alert("유효하지 않은 휴대폰번호입니다.");
		return;
	}
	
	if(!isNumber(frm.OfficeTellNo2.value) && frm.OfficeTellNo2.value != 0) {
		alert("사내직통번호는 숫자만 입력가능합니다.");
		return;
	}
	
	if(frm.OfficeTellNo2.value != 0 && ( frm.OfficeTellNo2.value < 9 || frm.OfficeTellNo2.value > 14) ) {
		alert("유효하지 않은 사내직통번호입니다.");
		return;
	}

	var invalid = ' ';	//공백 체크
	
	if(frm.Password.value.length == 0){
		alert("비밀번호를 입력하세요");
		return;
	}
	
	if(frm.Password.value.indexOf(invalid) > -1){
		alert("비밀번호에 공백을 넣을 수 없습니다.");
		return;
	}
	
	if(frm.Password.value.indexOf(invalid) > -1 || frm.RePassword.value.indexOf(invalid) > -1){
		alert("비밀번호에 공백을 넣을 수 없습니다.");
		return;
	}
	
	if(frm.RePassword.value.length == 0){
		alert("비밀번호를 한번더 입력하세요");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value) {
		alert("입력하신 비밀번호가 재입력하신 비밀번호와 일치하지 않습니다.");
		return;
	}
	
	if(frm.HireDateTime.value.length == 0){
		alert("입사일을 입력해 주십시오");
		return;
	}
	
	/* var fsize = $('#BoardFile')[0].files[0].size;  //파일사이즈 */
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.BoardFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	//alert(lastIndex);
	var strFileName= strFile.substring(lastIndex+1);
	//alert(strFileName);
	if(fileCheckNm(strFileName)> 200){
		alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
		return;
	}

		
	//파일명 글자수(byte) 체크		
	function fileCheckNm(szValue){
		var tcount=0;
		var tmpStr = new String(szValue);
		var temp = tmpStr.length;
		var onechar;
		for(k=0; k<temp; k++){
			onechar = tmpStr.charAt(k);
			if(escape(onechar).length>4){
				tcount +=2;
				
			}else{
				tcount +=1; 
			}
		}
		return tcount;
	}	

	frm.BoardFileNm.value = strFileName;
	//frm.FaxNo.value=onlyNum(frm.FaxNo.value);
	frm.OfficeTellNo.value=onlyNum(frm.OfficeTellNo.value);
	frm.OfficeTellNo2.value=onlyNum(frm.OfficeTellNo2.value);
	
	frm.submit();

}
//그룹 아이디와 그룹명 세팅함수.
function groupSet(groupid,groupnm){
	alert("groupid : " + groupid + "<>groupnm : " + groupnm);
	//사용자 필드에 맞게 수정함
	var frm = document.UserRegist;
	frm.GroupID.value=groupid;
	frm.GroupName.value=groupnm;
}
//그룹권한 아이디와 그룹 권한명 세팅함수.
function authSet(authid,authnm){
	//사용자 필드에 맞게 수정함
	var frm = document.UserRegist; 
	frm.AuthID.value=authid;
	frm.AuthName.value=authnm;
}
//팩스번호 세팅함수.
function faxNoSet(faxno){
	//사용자 필드에 맞게 수정함
	var frm = document.UserRegist; 
	frm.FaxNo.value=faxno;
}
//그룹 및  팩스조회 권한 팝업창
function goPopup(url){

   var top, left, scroll;
   var width='350';
   var height='550';
   
	if(scroll == null || scroll == '')	scroll='0';
		top	 = 150;
		left = 1000;

	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	if(openWin != 0) {
		  openWin.close();
	}
	openWin = window.open(url, 'POP', option);
}

</script>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
  <table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
          <tr>
            <td align=center height=middle><img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5"></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- 처리중 종료 -->
<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>사용자 등록</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 필수입력사항텍스트 -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 등록 -->
		<div class="userRegistForm">
<form  method="post" name="UserRegist" action="<%= request.getContextPath()%>/B_User.do?cmd=userRegist" enctype="multipart/form-data">
	<input type="hidden" name="photo">
  <fieldset>
	<legend>사용자 등록</legend>
	<table class="tbl_type" summary="사용자 등록(사용자ID, 사용자명, 소속, 전화번호, 사용여부, 비밀번호, 비밀번호재입력)">
        <caption>사용자 등록</caption>
        <colgroup>
			<col width="331px" />
			<col width="138px" />
			<col width="*" />
		</colgroup>
		<tbody>
		 <tr>
          <td rowspan="12"><iframe src="<%= request.getContextPath()%>/B_User.do?cmd=photoForm&photo=&Flag=R"  frameborder="0" height="406" width="300" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></td>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용자ID</label></th>
          <td><input name="ID" type="text" class="text" maxlength="20" size="15" value="" title="사용자ID" style="width:200px;" tabindex="1"/><a href="javascript:fnDuplicateCheck();" class="btn_type03"><span>중복확인</span></a></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용자명</label></th>
          <td><input name="Name" type="text" class="text" maxlength="30" value="" title="사용자명" style="width:200px;" tabindex="2"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>채용구분</label></th>
          <td><input name="EmployeeNum" type="radio" class="radio md0" value="EN" title="정규직" id="EmployeeNumN" checked /><label for="">정규직</label><input name="EmployeeNum" type="radio" class="radio" value="EC" id="EmployeeNumC" title="파견직(외주)" /><label for="">파견직(외주)</label></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>주민번호</label></th>
		  <td>          
          <input name="jumin1" type="text" class="text dis" title="주번앞" style="width:50px;"  value="" maxlength="6" /> -
          <input type="password" name="jumin2"  class="text" style="width:80px;"  maxlength="7" value="" />
          
          </td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>소속</label></th>
          <td><input name="GroupName" type="text" class="text" value="" title="소속" style="width:200px;" readOnly onclick="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');" /><a href="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');" class="btn_type03"><span>조회</span></a><input name="GroupID" type="hidden"  value="" /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>직급</label></th>
          <td>
	          <select name="Position">
	          <option value="A">대표이사</option>
	          <option value="B">이사</option>
	          <option value="C">그룹리더</option>
	          <option value="D">팀리더</option>
	          <option value="E">매니저</option>
	          <option value="F">사원</option>
	          <option value="G">인턴</option>
	          <option selected="selected" value="6">기타</option>
	          </select>
          </td>
        </tr>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입사일</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="HireDateTime" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"/></span>
			</td>
        </tr>
       <!--  <tr>
        	<th><label for="">퇴사일</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="FireDateTime" value=""/></span>
			</td>
        </tr> -->
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>핸드폰번호</label></th>
          <td><input type="text" name="OfficeTellNo" class="text" maxlength="14" onclick="this.value=''" title="핸드폰번호" style="width:200px;" tabindex="4" dispName="핸드폰번호" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
          <tr>
          <th><label for="">사내직통번호</label></th>
          <td><input type="text" name="OfficeTellNo2" class="text" maxlength="14" onclick="this.value=''" title="사내직통번호" style="width:200px;" tabindex="4" dispName="사내직통번호" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용여부</label></th>
          <td><input name="UseYN" type="radio" class="radio md0" title="사용" id="radio" value="Y" checked /><label for="radio">사용</label><input name="UseYN" type="radio" class="radio" id="radio2" value="N" title="미사용" /><label for="radio2">미사용</label></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>비밀번호</label></th>
          <td><input name="Password" type="password" class="text" size="30" maxlength="50" value="" title="비밀번호" style="width:279px;" tabindex="5"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>비밀번호재입력</label></th>
          <td><input name="RePassword" type="password" class="text" size="30" maxlength="50" value="" title="비밀번호재입력" style="width:279px;" tabindex="6"/></td>
        </tr>
        <input type="hidden" name="BoardFileNm" value=""></input>
         <tr>
        	<th><label for="">주소</label></th>
       		<td colspan="2">
				<span class="ico_calendar"><input id="zip" class="text" style="width:420px;" name="zip" value=""/></span>
			</td>
        </tr>
        <tr>
		  <th><label for="">투입인력프로파일</label></th>
		  <td colspan="2"><div class="fileUp"><input type="text" class="text" id="file1" title="투입인력프로파일" style="width:212px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BoardFile" id="upload1" /></div><br /><span class="guide_txt br">* 투입인력 프로파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
     	</tr>      
        </tbody>
      </table>
      </fieldset>
      </form>
    </div>
	<!-- //등록 -->
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave()" class="btn_type02"><span>확인</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
    <!-- //button -->
	</div>
	<!-- //content -->
</div>
</body>
</html>
<script type="text/javascript">fn_fileUpload();</script>