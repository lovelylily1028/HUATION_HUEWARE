<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<script type="text/javascript">
//등록
function GroupDupCheck(){
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=smsGroupDupCheck",
           data : {
        	   
        	   "NewGroupName" :  encodeURIComponent($('#NewGroupName').val())
        	 
   		},
           success: function(data) {
                if(data>0){
            	   alert("그룹 명 이 중복되었습니다. 다시 입력해 주세요.");
               }else{
            	   GroupRegist();
               } 
              }
    });
}

/* 
function fncCheckEng() {

    var objEvent = document.GroupRegForm;
    

    var numPattern =/^[A-Za-z]*$/;

    numPattern = objEvent.NewGroupID.value.match(numPattern);

 

    if (numPattern == null) {

        alert("영문자만 입력할 수 있습니다.");

        //objEvent.value = "";

        objEvent.NewGroupID.value = objEvent.NewGroupID.value.substr(0, objEvent.NewGroupID.value.length - 1);

        objEvent.NewGroupID.focus();

        return false;

    }

}  */

//Input text onKeyPress 이벤트 한글만 입력

function fncInputKorean() {

    if ((event.keyCode < 12592) || (event.keyCode > 12687)) {

        alert("한글만 입력할 수 있습니다.");

        Event.returnValue = false;

    }

}


</script>
<title>그룹별 상세현황</title>
</head>
<body>
<!-- 레이어팝업 -->
			<div class="groupReg">
				<!-- content -->
				<div id="contentLp">
					<!-- 그룹추가 -->
					<form method="post" name="GroupRegForm" action="<%=request.getContextPath()%>/S_Sms.do?cmd=smsGroupRegist">
					<fieldset>
						<legend>그룹추가</legend>
						<div class="con">
						<!-- <label for="">그룹ID</label>&nbsp;&nbsp;
						<input type="text" onkeyup = "javascript:fncCheckEng()" id="NewGroupID" maxlength="10" name="NewGroupID" class="text" title="소속명" style="width:150px;" />
						<br /><br /> -->
						<label for="">그룹명</label>&nbsp;&nbsp;<input type="text" id="NewGroupName" maxlength="15" name="NewGroupName" class="text" title="소속명" position="left" style="width:200px;" />
						<!-- <span class="guide_txt">선택된<strong>조직</strong>의 <strong>하위그룹</strong>으로 추가됩니다.</span></div> -->
						</div>						
					</fieldset>
					<!-- //그룹추가 -->
					<!-- Bottom 버튼영역 -->
					<div class="Bbtn_areaC"><a  href="javascript:GroupDupCheck()" class="btn_type02"><span>저장</span></a><a href="javascript:goClose($('#GroupReg'))" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
					<!-- //Bottom 버튼영역 -->
					</form>
				</div>
				<!-- //content -->
			</div>
					<!-- //레이어팝업 -->
</body>
</html>