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
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9�� ������ -->
<script type="text/javascript">


</script>
<title>�׷캰 ����Ȳ</title>
</head>
<body>
<!-- ���̾��˾� -->
			<div id="wrapLp" class="groupReg">
				<!-- header -->
				<div id="headerLp">
				</div>
				<!-- //header -->
				<!-- content -->
				<div id="contentLp">
					<!-- �׷��߰� -->
					<form method="post" name="smsModifyForm" action="<%=request.getContextPath()%>/S_Sms.do?cmd=smsGroupRegist">
					<input type="hidden" id="oldPhoneNo" name="oldPhoneNo" value="<%=smsgroupDto.getPhoneNumber()%>" />
					<fieldset>
						<legend>�׷��߰�</legend>
						<div class="con">
						<input type="hidden" id="index" name="index" value="<%=smsgroupDto.getIndex()%>" />
						<label for="">��   ȣ</label>&nbsp;&nbsp;
						<input type="text" numberOnly="true" maxlength="12" id="NewPhoneNo" name="NewPhoneNo" value="<%=smsgroupDto.getPhoneNumber()%>" class="text" title="�ҼӸ�" style="width:150px;" />
						<br /><br />
						<label for="">�׷��</label>&nbsp;&nbsp;
						<select id="newSmsGroupID" title="�׷켱��" style="width:168px;">
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
						<label for="">��   ��</label>&nbsp;&nbsp;
						<input type="text" id="NewName" maxlength="10" name="NewName" value="<%=smsgroupDto.getUserName()%>" class="text" title="�ҼӸ�" style="width:150px;" />
						<br /><br />
						<label for="">��   ��</label>&nbsp;&nbsp;
						<input type="text" id="NewMemo" maxlength="20" name="NewMemo" value="<%=smsgroupDto.getMemo() %>" class="text" title="�ҼӸ�" position="left" style="width:150px;" />
						<br />
						<!-- <span class="guide_txt">���õ�<strong>����</strong>�� <strong>�����׷�</strong>���� �߰��˴ϴ�.</span></div> -->
						
					</fieldset>
					</form>
					<!-- //�׷��߰� -->
					<!-- Bottom ��ư���� -->
					<div class="Bbtn_areaC"><a  href="javascript:modifyDupCheck();" class="btn_type02"><span>����</span></a><a href="javascript:goClose($('#ModifyForm'))" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
					<!-- //Bottom ��ư���� -->
				</div>
				<!-- //content -->
			</div>
					<!-- //���̾��˾� -->
</body>
</html>