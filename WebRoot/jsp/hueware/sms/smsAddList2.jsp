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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>그룹별 상세현황</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/jquery-ui-1.9.2.custom.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/ui.dynatree.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dynatree-1.2.4.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
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
function goSearch(){
	$.ajax({
	        type: "POST",
	           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=ajaxSmsAddList2",
	           data : {
	        	   "GroupID" : "G00001"
	   		},
	           success: function(result) {
	               $("#lists").html(result);
	               
	              }
	    });
} 
function goGroupList(){
	$.ajax({
	        type: "POST",
	           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=ajaxSmsGroupList2",
	          success: function(result) {
	               $("#GroupList").html(result);
	               
	              }
	    });
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

</script>
<!-- //트리구조 -->
</head>
<body onload="javascript:inits();">
<!-- 팝업사이즈 : width:1014px / height:578px; -->
<div id="wrapWp" class="smsAddList">
	<!-- header -->
	<div id="headerWp">
		<h1>휴에이션 임직원 주소록</h1>
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
					<dt>그룹선택</dt>
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
								<col width="200px" />
								<col width="160px" />
								<col width="160px" />
								<col width="*" />
							</colgroup>
							<thead>
							<tr>
								<th><input type="checkbox" id="checkboxAll"  name="checkboxAll" onclick="fnCheckAll(this)" class="check md0" title="전체선택" /></th>
								<th>그룹</th>
								<th>이름</th>
								<th>휴대폰번호</th>
								<th>사내직통번호</th>
							</tr>
							</thead>
							<tbody>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<%-- <tr>
								<td colspan="2">
								
								<select id="smsGroupID" title="그룹선택" style="width:100%;">
								<%
									int i;
											for(i=1;i<grouplist.size() ;i++){
												SmsGroupDTO dto = grouplist.get(i);
										%>
										<option value="<%=dto.getSmsGroupID()%>"><%=dto.getSmsGroupName()%></option>
										<%		
											}
								%>
							  </select>
							  
								</td>

								<td><input type="text" maxlength="10" id="userName" name="userName" class="text" value="" title="이름" style="width:97px;" /></td>
								<td><input type="text" maxlength="12" numberOnly="true" id="phoneNo" name="phoneNo" class="text" value="" title="휴대폰번호" style="width:97px;" /></td>
								<td><input type="text" maxlength="20" id="Memo" name="Memo" class="text" value="" title="메모" style="width:157px;" /></td>

								<td class="last"><a onclick="javascript:DupCheck();"  class="btn_type03"><span>추가</span></a></td>
							</tr> --%>
							
							<tr>
								<td colspan="5" class="last tbl_type_scrollY">
									<div id="lists"  class="scrollY scrollYHu"></div>
								</td>
							</tr>
							</tbody>
						</table>
					</dd>
				</dl>
				<!-- Bottom 버튼영역 -->
			 <div class="Bbtn_areaR"><a href="javascript:goSmsSubmit()" class="btn_type01 md0">
			 <span>선택목록SMS전송</span></a>
			</div> 
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
<!-- //레이어팝업 -->
</body>
</html>