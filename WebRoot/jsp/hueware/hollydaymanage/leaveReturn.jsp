<%@page import="java.util.Map"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ް��ݷ�</title>
<%

Map model = (Map)request.getAttribute("MODEL"); 
HollyDTO hollyDto = (HollyDTO)model.get("hollyDto");
String Seq = (String)model.get("Seq");
String State = (String)model.get("State");
String Sign = (String)model.get("Sign");

%>
</head>
<body>
<!-- �˾������� : width:350px -->
	<!-- content -->
	<div id="contentLp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- �ʼ��Է»����ؽ�Ʈ -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ��� -->
		<div class="leaveReturn">
			<form method="post" name ="LeaveReturnForm" action="">
			<fieldset>
				<legend>�ް��ݷ�</legend>
				<table class="tbl_type" summary="�ް��ݷ�(����)">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
						<td><textarea id="ReturnReason" name="ReturnReason" title="����" style="width:219px;height:45px;"><%=hollyDto.getReturnReason()%></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //��� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:Sign('<%=Seq%>','<%=State%>','<%=Sign%>');" class="btn_type02"><span>�ݷ�</span></a><a href="javascript:goClose($('#ReturnForm'));" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</body>
</html>