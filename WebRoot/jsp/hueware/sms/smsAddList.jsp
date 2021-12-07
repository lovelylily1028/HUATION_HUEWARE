<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
Map model = (Map)request.getAttribute("MODEL"); 

ArrayList<SmsGroupDTO> grouplist = (ArrayList)model.get("smsgrouplist");
String GroupID = (String)model.get("GroupID");
%>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<title>그룹별 상세현황</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/jquery-ui-1.9.2.custom.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/ui.dynatree.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dynatree-1.2.4.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- 트리구조 -->
<script type="text/javascript">

function inits(){
	goSearch();
	goGroupList();
}

//체크박스 전체 선택
function fnCheckAll(objCheck) {
	  var arrCheck = document.getElementsByName('checkbox');
	  
	  for(var i=0; i<arrCheck.length; i++){
	  	if(objCheck.checked) {
	    	arrCheck[i].checked = true;
	    } else {
	    	arrCheck[i].checked = false;
	    }
	 }
}
//체크 박스 선택 삭제(다건/단건) 
function goDelete(){
	var formObj=document.smsManageForm;
	var checkYN;
	//var checks=0;

	if( formObj.seqs.length>1){
		for(i=0;i< formObj.seqs.length;i++){
			if( formObj.checkbox[i].checked==true){
				checkYN='Y';
				//checks++;
			}else{
				checkYN='N';
			}
			 formObj.seqs[i].value=fillSpace( formObj.checkbox[i].value)+'|'+fillSpace(checkYN);
		}
	}else{
		if( formObj.checkbox.checked==true){
			checkYN='Y';
			//checks++;
		}else{
			checkYN='N';
		}
		 formObj.seqs.value=fillSpace( formObj.checkbox.value)+'|'+fillSpace(checkYN);
		
	}
	
	var checks = document.getElementsByName("checkbox");
	var devices = new Array();
	
	for(var i = 0; i < checks.length; i++) {	
		if (checks[i].checked ){
			devices.push(checks[i].ID);	//devices에 push를 이용해 체크된 값을 담는다.
		}
	}
	if (devices.length == 0){
		alert("삭제할 사용자를 선택해 주세요!")
	} else {
		if(!confirm("선택된 사용자가 삭제됩니다. 삭제하시겠습니까?"))
			return;
		
		 formObj.action = "<%=request.getContextPath()%>/S_Sms.do?cmd=userDelete";
		 formObj.submit();
	}
}
function goSearch(){
	$.ajax({
	        type: "POST",
	           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=ajaxSmsAddList",
	           data : {
	        	   "GroupID" : "S00001"
	   		},
	           success: function(result) {
	               $("#lists").html(result);
	               
	              }
	    });
} 
function goGroupList(){
	$.ajax({
	        type: "POST",
	           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=ajaxSmsGroupList",
	          success: function(result) {
	               $("#GroupList").html(result);
	               
	              }
	    });
} 


//레이어팝업 : 그룹 등록 폼
function GroupReg(){
    $('#GroupReg').dialog({
        resizable : false, //사이즈 변경 불가능
        draggable : true, //드래그 불가능
        closeOnEscape : true, //ESC 버튼 눌렀을때 종료

        width : 350,
        height : 193,
        modal : true, //주위를 어둡게

        open:function(){
            //팝업 가져올 url
            $(this).load('<%= request.getContextPath() %>/S_Sms.do?cmd=GroupReg');

            $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
                $("#GroupReg").dialog('close');
                });
        }
    });
};

function goRegist(){
	
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=smsUserRegist",
           data : {
        	   "phoneNo" : $('#phoneNo').val(),
        	   "userName" : encodeURIComponent($('#userName').val()),
        	   "faxNo" : $('#faxNo').val(),
        	   "Memo" : encodeURIComponent($('#Memo').val()),
        	   "smsGroupID" : $('#smsGroupID').val(),
        	   "GroupID" : setGroupID
   		},
           success: function(result) {
               $("#lists").html(result);
               $('#phoneNo').val("");
               $('#userName').val("");
               $('#Memo').val("");
               
              }
    });
	
}

//레이어팝업 : 유저 수정 폼
function goModifyForm(index){
    $('#ModifyForm').dialog({
        resizable : false, //사이즈 변경 불가능
        draggable : true, //드래그 불가능
        closeOnEscape : true, //ESC 버튼 눌렀을때 종료
        width : 367,
        height : 350,
        modal : true, //주위를 어둡게

        open:function(){
            //팝업 가져올 url
            $(this).load('<%= request.getContextPath() %>/S_Sms.do?cmd=goModifyForm',
            		{'index' : index});

            $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
                $("#ModifyForm").dialog('close');
                });
        }
    });
};
function DupCheck(){
	if($('#userName').val()==""){
		alert("이름을 입력하세요.");
		
		return;
	}
	if($('#phoneNo').val()==""){
		alert("핸드폰 번호를 입력하세요.");
		return;
	}
	
	
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=DupCheck",
           data : {
        	   "phoneNo" : $('#phoneNo').val(),
        	 
   		},
           success: function(data) {
               if(data=="0"){
            	   goRegist();
               }else{
            	   alert("핸드폰 번호가 중복되었습니다. 다시 입력해 주세요.");
            	   $('#phoneNo').val("");
               }
              }
    });
}
function modifyDupCheck(){
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=modifyDupCheck",
           data : {
        	   "phoneNo" : $('#NewPhoneNo').val(),
        	   "oldPhoneNo" : $('#oldPhoneNo').val()
        	 
   		},
           success: function(data) {
        	     if(data==0){
        	       goModify();
               }else{
            	   alert("핸드폰 번호가 중복되었습니다. 다시 입력해 주세요.");
               } 
               
              }
    });
}

function goModify(){
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=smsUserModify",
           data : {
        	   "phoneNo" : $('#NewPhoneNo').val(),
        	   "userName" : encodeURIComponent($('#NewName').val()),
        	   "Memo" : encodeURIComponent($('#NewMemo').val()),
        	   "smsGroupID" : $('#newSmsGroupID').val(),
        	   "index" : $('#index').val(),
        	   "GroupID" : setGroupID
   		},
           success: function(result) {
               $("#lists").html(result);
               goClose($('#ModifyForm'));
              }
    });
	
}

function GroupRegist(){
	var frm = document.GroupRegForm; 
	 	
	frm.submit();

}
function goClose(PopName){
	
	PopName.dialog('close');
}

function goSmsSubmit(){
	
	
	if($('input:checkbox[id="checkbox"]:checked').length == 0){
		
		
		alert("SMS전송할 인원을 1명 이상 선택해 주세요.");
		
		return;
	}
	
	 var phone = "";  
	 $('input:checkbox[id="checkbox"]:checked').each(function (index) {  
		 phone += $(this).val() + ",";  
	 });  
	 var phone2 = phone.slice(0,-1);
	 window.opener.addrow2(phone2);  
	 self.close();
	 
	}
$(function()
		{
		 $(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
		 $(document).on("keyup", "input:text[datetimeOnly]", function() {$(this).val( $(this).val().replace(/[^0-9:\-]/gi,"") );});
		});
		
		
function GroupDelete(){
	if(setGroupID == "S00001" || setGroupID =="" ||  setGroupID==undefined){
		alert("삭제할 그룹을 선택해 주세요");
		return;
	}
	
		
		if(!confirm(""+setGroupName+" 그룹을 삭제하시겠습니까?"))
		return;
		location.href="<%= request.getContextPath()%>/S_Sms.do?cmd=SmsGroupDelete&GroupID="+setGroupID+"";
	
} 


</script>
<!-- //트리구조 -->
</head>
<body onload="javascript:inits();">
<!-- 팝업사이즈 : width:1014px / height:578px; -->
<div id="wrapWp" class="smsAddList">
	<!-- header -->
	<div id="headerWp">
		<h1>업체 주소록</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- SMS주소록컨텐츠 -->
		<div id="smsAddList_area" class="smsAddList_area">
			<form method="post" name="smsManageForm" action="">
			<!-- 그룹선택 -->
			<fieldset class="groupTree">
				<legend>그룹선택</legend>
				<dl class="groupTree_area">
					<dt>그룹선택<a onclick="javascript:GroupReg();" class="btn_type03"><span>그룹추가</span></a> <a onclick="javascript:GroupDelete();" class="btn_type03"><span>선택그룹삭제</span></a></dt>
					<dd id ="GroupList"></dd>
				</dl>
				<!-- Bottom 버튼영역 -->
				<!-- <div class="Bbtn_areaR"><a href="#none" class="btn_type01"><span>선택그룹SMS전송</span></a></div> -->
				<!-- //Bottom 버튼영역 -->
			</fieldset>
			<!-- //그룹선택 -->
			<!-- 그룹관리 -->
			<fieldset class="groupList">
				<legend>그룹관리</legend>
				<dl class="groupList_area">
					<dt>그룹관리</dt>
					<dd >
										<!-- 팝업사이즈 : width:1014px / height:578px; -->
					<table class="tbl_type tbl_type_list" summary="그룹관리(그룹, 이름, 휴대폰번호, 팩스번호, 메모, 관리)">
							<colgroup>
								<col width="35px" />
								<col width="150px" />
								<col width="120px" />
								<col width="120px" />
								<col width="180px" />
								<col width="*" />
							</colgroup>
							<thead>
							<tr>
								<th><input type="checkbox" id="checkboxAll"  name="checkboxAll" onclick="fnCheckAll(this)" class="check md0" title="전체선택" /></th>
								<th>그룹</th>
								<th>이름</th>
								<th>휴대폰번호</th>
								<th>메모</th>
								<th class="last">관리</th>
							</tr>
							</thead>
							<tbody>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<tr>
								<td colspan="2">
								
								<select id="smsGroupID" title="그룹선택" style="width:100%;">
								<%
									int i;
											for(i=1;i<grouplist.size() ;i++){
												SmsGroupDTO dto = grouplist.get(i);
										%>
										<option value="<%=dto.getSmsGroupID()%>">
										<%=dto.getSmsGroupName()%></option>
										<%		
											}
								%>
							  </select>
							  
								</td>

								<td><input type="text" maxlength="10" id="userName" name="userName" class="text" value="" title="이름" style="width:97px;" /></td>
								<td><input type="text" maxlength="12" numberOnly="true" id="phoneNo" name="phoneNo" class="text" value="" title="휴대폰번호" style="width:97px;" /></td>
								<td><input type="text" maxlength="20" id="Memo" name="Memo" class="text" value="" title="메모" style="width:157px;" /></td>

								<td class="last"><a onclick="javascript:DupCheck();"  class="btn_type03"><span>추가</span></a></td>
							</tr>
							
							<tr>
								<td colspan="6" class="last tbl_type_scrollY">
									<div id="lists"  class="scrollY"></div>
								</td>
							</tr>
							</tbody>
						</table>
					</dd>
				</dl>
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaR"><a href="javascript:goSmsSubmit()" class="btn_type01"><span>선택목록SMS전송</span></a><a href="javascript:goDelete()" class="btn_type01 btn_type01_gray md0"><span>선택목록삭제</span></a></div>
				<!-- //Bottom 버튼영역 -->
			</fieldset>
			<!-- //그룹관리 -->
			</form>
		</div>
		<!-- //SMS주소록컨텐츠 -->
	</div>
	<!-- //content -->
</div>
<!-- 레이어팝업 -->
<div id="GroupReg" title="그룹 추가"></div>
<div id="ModifyForm" title="상세 보기"></div>
<!-- //레이어팝업 -->
</body>
</html>