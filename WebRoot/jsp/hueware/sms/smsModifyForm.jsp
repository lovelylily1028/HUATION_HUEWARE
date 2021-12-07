<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
Map model = (Map)request.getAttribute("MODEL"); 
SmsGroupDTO smsgroupDto = (SmsGroupDTO)model.get("smsgroupDto");
ArrayList<SmsGroupDTO> grouplist = (ArrayList)model.get("smsgrouplist");
%>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<script type="text/javascript">


</script>
<title>그룹별 상세현황</title>
</head>
<body>
<!-- 레이어팝업 -->
			<div id="wrapLp" class="groupReg">
				<!-- header -->
				<div id="headerLp">
				</div>
				<!-- //header -->
				<!-- content -->
				<div id="contentLp">
					<!-- 그룹추가 -->
					<form method="post" name="smsModifyForm" action="<%=request.getContextPath()%>/S_Sms.do?cmd=smsGroupRegist">
					<input type="hidden" id="oldPhoneNo" name="oldPhoneNo" value="<%=smsgroupDto.getPhoneNumber()%>" />
					<fieldset>
						<legend>그룹추가</legend>
						<div class="con">
						<input type="hidden" id="index" name="index" value="<%=smsgroupDto.getIndex()%>" />
						<label for="">번   호</label>&nbsp;&nbsp;
						<input type="text" numberOnly="true" maxlength="12" id="NewPhoneNo" name="NewPhoneNo" value="<%=smsgroupDto.getPhoneNumber()%>" class="text" title="소속명" style="width:150px;" />
						<br /><br />
						<label for="">그룹명</label>&nbsp;&nbsp;
						<select id="newSmsGroupID" title="그룹선택" style="width:168px;">
								<%
									int i;
											for(i=1;i<grouplist.size() ;i++){
												SmsGroupDTO dto = grouplist.get(i);
										%>
										<option value="<%=dto.getSmsGroupID()%>" 
										<%if(dto.getSmsGroupID().equals(smsgroupDto.getSmsGroupID())){%>selected="selected"<%} %>
										><%=dto.getSmsGroupName()%></option>
										<%		
											}
								%>
							  </select>
						<br /><br />
						<label for="">이   름</label>&nbsp;&nbsp;
						<input type="text" id="NewName" maxlength="10" name="NewName" value="<%=smsgroupDto.getUserName()%>" class="text" title="소속명" style="width:150px;" />
						<br /><br />
						<label for="">메   모</label>&nbsp;&nbsp;
						<input type="text" id="NewMemo" maxlength="20" name="NewMemo" value="<%=smsgroupDto.getMemo() %>" class="text" title="소속명" position="left" style="width:150px;" />
						<br />
						<!-- <span class="guide_txt">선택된<strong>조직</strong>의 <strong>하위그룹</strong>으로 추가됩니다.</span></div> -->
						
					</fieldset>
					</form>
					<!-- //그룹추가 -->
					<!-- Bottom 버튼영역 -->
					<div class="Bbtn_areaC"><a  href="javascript:modifyDupCheck();" class="btn_type02"><span>저장</span></a><a href="javascript:goClose($('#ModifyForm'))" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
					<!-- //Bottom 버튼영역 -->
				</div>
				<!-- //content -->
			</div>
					<!-- //레이어팝업 -->
</body>
</html>