<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet"%>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import="com.huation.common.user.UserDAO"%>
<%@ page import="com.huation.common.user.UserDTO"%>
<%@ page import="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	UserDTO userDto = (UserDTO)model.get("userDto");
	CommonDAO comDao=new CommonDAO();
	
	String position_select = userDto.getPosition();
	String acheckd="";
	String bcheckd="";
	String ccheckd="";
	String dcheckd="";
	String echeckd="";
	String fcheckd="";
	String gcheckd="";
	String hcheckd="";
	
		if(position_select.equals("A")){
			acheckd="selected='selected'";
		} else if(position_select.equals("B")){
			bcheckd="selected='selected'";
		} else if(position_select.equals("C")){
			ccheckd="selected='selected'";
		} else if(position_select.equals("D")){
			dcheckd="selected='selected'";
		} else if(position_select.equals("E")){
			echeckd="selected='selected'";
		} else if(position_select.equals("F")){
			fcheckd="selected='selected'";
		} else if(position_select.equals("G")){
			gcheckd="selected='selected'";
		} else if(position_select.equals("6")){
			hcheckd="selected='selected'";
		} else if(position_select.isEmpty()){
			hcheckd="selected='selected'";
		}
		
	String EmployeeNum_EnEc = "";
	if(userDto.getEmployeeNum().isEmpty()){
		EmployeeNum_EnEc = "-";
	}else{
		EmployeeNum_EnEc = userDto.getEmployeeNum().substring(0,2);
	}
	String EN="";
	String EC="";
	
	if(EmployeeNum_EnEc.equals("EN")){
		EN="checked";
	}else{
		EC="checked";
	}
		
	String HireDateTime = "";
	HireDateTime = userDto.getHireDateTime();
	if(HireDateTime.isEmpty()){
		HireDateTime = userDto.getHireDateTime();
	}else{
		HireDateTime = HireDateTime.substring(0,10);
	}
		
	String FireDateTime = "";
	FireDateTime = userDto.getFireDateTime();
	if(FireDateTime.isEmpty()){
		FireDateTime = userDto.getFireDateTime();
		System.out.println("================================비어 있는 경우========================================"+FireDateTime);
	}else{
		FireDateTime = FireDateTime.substring(0,10);
		System.out.println("================================들어가 있는 경우========================================"+FireDateTime);
	}
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사용자 정보수정</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
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
	    changeYear: true
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
	var jumin2 = "<%=userDto.getJumin2()%>";
	var frm = document.UserModify;
	frm.jumin2.value = jumin2;
}
//저장
function goSave(){

	var frm = document.UserModify; 
	if(frm.GroupID.value.length == 0){
		alert("소속을 입력하세요");
		return;
	}
	
	if(frm.OfficeTellNoFormat.value.length == 0){
		alert("핸드폰 번호를 입력하세요");
		return;
	}
	
	/* if(frm.OfficeTellNoFormat2.value.length == 0){
		alert("사내 직통번호를 입력하세요");
		return;
	} */
	

	if(!isNumber(frm.OfficeTellNoFormat.value) && frm.OfficeTellNoFormat.value != 0) {
		alert("휴대폰번호는 숫자만 입력가능합니다.");
		return;
	}
	
	if(frm.OfficeTellNoFormat.value != 0 && ( frm.OfficeTellNoFormat.value < 11 || frm.OfficeTellNoFormat.value > 14) ) {
		alert("유효하지 않은 휴대폰번호입니다.");
		return;
	}
	
	if(!isNumber(frm.OfficeTellNoFormat2.value) && frm.OfficeTellNoFormat2.value != 0) {
		alert("사내직통번호는 숫자만 입력가능합니다.");
		return;
	}
	
	if(frm.OfficeTellNoFormat2.value != 0 && ( frm.OfficeTellNoFormat2.value < 9 || frm.OfficeTellNoFormat2.value > 14) ) {
		alert("유효하지 않은 사내직통번호입니다.");
		return;
	}
	
	var invalid = ' ';	//공백 체크
	
	if(frm.Password.value.indexOf(invalid) > -1 || frm.RePassword.value.indexOf(invalid) > -1){
		alert("비밀번호에 공백을 넣을 수 없습니다.");
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
	
	
	if(confirm("수정 하시겠습니까?")){
		
		if(frm.initPW.value!=frm.Password.value){
			frm.PasswordModifyYN.value='Y';
			
		}else{
			frm.PasswordModifyYN.value='N';
		}
		
		
		if (strFileName!=''){
			frm.BoardFileNm.value = strFileName;
		}
		
		frm.action='<%=request.getContextPath()%>/B_User.do?cmd=userModify';
		//frm.FaxNo.value=onlyNum(frm.FaxNo.value);
		frm.OfficeTellNo.value=onlyNum(frm.OfficeTellNoFormat.value);
		frm.OfficeTellNo2.value=onlyNum(frm.OfficeTellNoFormat2.value);
		frm.submit();
	}
}
//그룹 아이디와 그룹명 세팅함수.
function groupSet(groupid,groupnm){
	//사용자 필드에 맞게 수정함
	var frm = document.UserModify; 
	frm.GroupID.value=groupid;
	frm.GroupName.value=groupnm;
}
//그룹권한 아이디와 그룹 권한명 세팅함수.
function authSet(authid,authnm){
	//사용자 필드에 맞게 수정함
	var frm = document.UserModify; 
	frm.AuthID.value=authid;
	frm.AuthName.value=authnm;
}
//팩스번호 세팅함수.
function faxNoSet(faxno){
	//사용자 필드에 맞게 수정함
	var frm = document.UserModify; 
	frm.FaxNo.value=faxno;
}
//그룹 및  팩스조회 권한 팝업창
function goPopup(url){

   var top, left,scroll;
   var width='350';
   var height='550';
   var loc='center';
   
	if(scroll == null || scroll == '')	scroll='0';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}

	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	if(openWin != 0) {
		  openWin.close();
	}
	openWin = window.open(url, 'POP', option);
}	
</script>
</head>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
  <table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=293 height=148 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/main/ing.gif" >
          <tr>
            <td align=center><img src="<%=request.getContextPath()%>/images/main/spacer.gif" width="1" height="50" /><img src="<%=request.getContextPath()%>/images/main/wait2.gif" width="242" height="16" /></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- 처리중 종료 -->
<body onload="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>사용자 정보수정</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 필수입력사항텍스트 -->
			<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 등록 -->
		<div class="userRegistForm">
<form method="post" name="UserModify" action="<%=request.getContextPath()%>/B_User.do?cmd=userModify" enctype="multipart/form-data">
	<input type="hidden" name="photo">
  <fieldset>
	<legend>사용자 정보수정</legend>
	<table class="tbl_type" summary="사용자 정보수정(사용자ID, 사용자명, 소속, 전화번호, 사용여부, 비밀번호, 비밀번호재입력)">
        <caption>사용자 정보수정</caption>
		<colgroup>
			<col width="331px" />
			<col width="138px" />
			<col width="*" />
		</colgroup>
		<tbody>
		  <tr>
          <td rowspan="14"><iframe class="pic_area" src="<%= request.getContextPath()%>/B_User.do?cmd=photoForm&photo=<%= StringUtil.nvl(userDto.getPhoto(),"")%>&Flag=M"  frameborder="0" height="406" width="300" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></td>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용자ID</label></th>
          <td><input name="ID" type="text" class="text" value="<%=StringUtil.nvl(userDto.getID(), "") %>" title="사용자ID" style="width:200px;" readOnly /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용자명</label></th>
          <td><input name="Name" type="text" class="text" value="<%=StringUtil.nvl(userDto.getName(), "") %>" title="사용자명" style="width:200px;" readOnly /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>채용구분</label></th>
          <td><input name="section" type="radio" class="radio md0" title="정규직" id="" <%=EN %> value="EN" /><label for="">정규직</label><input name="section" type="radio" class="radio" id="" title="파견직(외주)" <%=EC %> value="EC" /><label for="">파견직(외주)</label></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사번</label></th>
          <td>
          <input name="getEmployeeNum" type="text" class="text dis" title="사번" style="width:80px;" readOnly value="<%= userDto.getEmployeeNum() %>" />
        </tr>  
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>주민번호</label></th>
		  <td>          
          <input name="jumin1" type="text" class="text dis" title="주번앞" style="width:50px;"  value="<%= userDto.getJumin1() %>" maxlength="6" />-
          
<%--           <input name="jumin2" type="password"  title="주번뒤" style="width:80px;"  value="<%=userDto.getJumin2()%>" maxlength="7" /> --%>
          <input type="password" name="jumin2"  class="text" style="width:80px;"  maxlength="7" value="<%=StringUtil.nvl(userDto.getJumin2(), "") %>" />
          <input type="hidden" name="jumin3"  class="text" style="width:80px;"  maxlength="7" value="<%=StringUtil.nvl(userDto.getJumin2(), "") %>" />
          </td>
        </tr>
        
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>소속</label></th>
          <td><input name="GroupName" type="text" class="text" value="<%=StringUtil.nvl(userDto.getGroupName(), "")%>" title="소속" style="width:200px;" readOnly onclick="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');"/><a href="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');" class="btn_type03"><span>조회</span></a><input name="GroupID" type="hidden"  value="<%=StringUtil.nvl(userDto.getGroupID(), "") %>" /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>직급</label></th>
          <td>
	          <select name="Position">
<%-- 	          <option <%=acheckd %> value="A">대표이사</option> --%>
<%-- 	          <option <%=bcheckd %> value="B">이사</option> --%>
<%-- 	          <option <%=ccheckd %> value="C">부장</option> --%>
<%-- 	          <option <%=dcheckd %> value="D">차장</option> --%>
<%-- 	          <option <%=echeckd %> value="E">과장</option> --%>
<%-- 	          <option <%=fcheckd %> value="F">대리</option> --%>
<%-- 	          <option <%=gcheckd %> value="G">사원</option> --%>
<%-- 	          <option <%=hcheckd %> value="6">-</option> --%>
	          <option <%=acheckd %> value="A">대표이사</option>
	          <option <%=bcheckd %> value="B">이사</option>
	          <option <%=ccheckd %> value="C">그룹리더</option>
	          <option <%=dcheckd %> value="D">팀리더</option>
	          <option <%=echeckd %> value="E">매니저</option>
	          <option <%=fcheckd %> value="F">사원</option>
	          <option <%=gcheckd %> value="G">인턴</option>
	          <option <%=hcheckd %> value="6">기타</option>
	          </select>
          </td>
        </tr>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입사일</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="HireDateTime" value="<%=HireDateTime%>"/></span>
			</td>
        </tr>
        <tr>
        	<th><label for="">퇴사일</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="FireDateTime" value="<%=FireDateTime%>"/></span>
			</td>
        </tr>
        <tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴대폰번호</label></th>
          <input type="hidden" name="OfficeTellNo" value="<%=StringUtil.nvl(userDto.getOfficeTellNo(),"") %>">
          <td><input type="text" name="OfficeTellNoFormat"  class="text" value="<%=StringUtil.nvl(userDto.getOfficeTellNoFormat(),"") %>" title="휴대폰번호" style="width:200px;" dispName="전화번호" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
         <tr>
          <th><label for=""></span>사내직통번호</label></th>
          <input type="hidden" name="OfficeTellNo2" value="<%=StringUtil.nvl(userDto.getOfficeTellNo2(),"") %>">
          <td><input type="text" name="OfficeTellNoFormat2"  class="text" value="<%=StringUtil.nvl(userDto.getOfficeTellNoFormat2(),"") %>" title="사내직통번호" style="width:200px;" dispName="전화번호" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사용여부</label></th>
          <td>
          <% 
		  if ((StringUtil.nvl(userDto.getUseYN(), "")).equals("Y")) { 
		  %>
          <input name="UseYN" type="radio" id="radio" value="Y" title="사용" class="radio md0" checked /><label for="">사용</label><input type="radio" name="UseYN" id="radio2" value="N" title="미사용" class="radio"/><label for="">미사용</label>
          <%
		  } else if ((StringUtil.nvl(userDto.getUseYN(), "")).equals("N")) {
		  %>
          <input name="UseYN" type="radio" id="radio" value="Y" title="사용" class="radio md0"/><label for="">사용</label><input type="radio" name="UseYN" id="radio2" value="N" checked title="미사용" class="radio"/><label for="">미사용</label>
          <%
		  }
		  %>
		  </td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>비밀번호</label></th>
          <td><input type="password" name="Password"  class="text" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>" title="비밀번호" style="width:279px;" size="30"/>
            <input type="hidden" name="initPW" class="in_txt" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>">
            <input type="hidden" name="PasswordModifyYN" value="N" class="in_txt" ></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>비밀번호재입력</label></th>
          <td><input name="RePassword" type="password" size="30" class="text" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>" title="비밀번호재입력" style="width:279px;" /></td>
        </tr>
         <tr>
        	<th><label for="">주소</label></th>
       		<td colspan="2">
				<span class="ico_calendar"><input id="zip" class="text" style="width:420px;" name="zip" value="<%=StringUtil.nvl(userDto.getZip(),"")%>"/></span>
			</td>
        </tr>
        <tr>
		  <th><label for="">투입인력프로파일</label></th>
		  <td colspan="2"><div class="fileUp"><input type="text" class="text" id="file1" title="투입인력프로파일" style="width:212px;" value="<%=userDto.getBoardFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BoardFile" id="upload1" /><input type="hidden" name="p_BoardFile" value="<%=userDto.getBoardFile()%>"></input><input type="hidden" name="BoardFileNm" value="<%=userDto.getBoardFileNm()%>"></input></div><br /><span class="guide_txt br">* 투입인력 프로파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
     	</tr>
        </tbody>
      </table>
      </fieldset>
      </form>
    </div>
	<!-- //등록 -->
    <!-- //button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave()" class="btn_type02"><span>확인</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
</body>
</html>
<script type="text/javascript">fn_fileUpload();</script>