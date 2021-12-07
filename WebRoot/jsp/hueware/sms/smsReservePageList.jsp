<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SMS ���� ����</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
</head>
<body>
<!-- �˾������� : width:834px / height:574px; -->
<div id="wrapWp" class="smsSendPageList">
	<!-- header -->
	<div id="headerWp">
	<%@ include file="/jsp/hueware/common/include/smsTop.jsp" %>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="smsSendPageList_area">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- ��ȸ -->
			<form method="post" action="" class="search">
			<fieldset>
				<legend>�˻�</legend>
				<ul>
					<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
					<li><span class="ico_calendar"><input type="text" class="text textdate" title="�˻�������" id="" /></span> ~ <span class="ico_calendar"><input type="text" class="text textdate" title="�˻�������" id="" /></span></li>
					<li><a href="#none" class="btn_type01 md0"><span>�˻�</span></a></li>
				</ul>
			</fieldset>
			</form>
			<!-- //��ȸ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ����Ʈ -->
		<table class="tbl_type tbl_type_list" summary="SMS���೻��(����, ����, �߽���, ������, �����Ͻ�, ��)">
			<colgroup>
				<col width="35px" />
				<col width="15%" />
				<col width="20%" />
				<col width="*" />
				<col width="17%" />
				<col width="9%" />
			</colgroup>
			<thead>
			<tr>
				<th><input type="checkbox" id="" class="check md0" title="��ü����" /></th>
				<th>����</th>
				<th>�߽���</th>
				<th>������</th>
				<th>�����Ͻ�</th>
				<th>��</th>
			</tr>
			</thead>
			<tfoot>
			<tr>
				<td colspan="6"><strong>�˻���� : <span>52</span>��</strong></td>
			</tr>
			</tfoot>
			<tbody>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="����" /></td>
				<td>�ΰ�����</td>
				<td>�����<br />010-1234-5678</td>
				<td>�����<br />010-1234-5678 �� 3��</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>������</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="����" /></td>
				<td>�ΰ�����</td>
				<td>�����<br />010-1234-5678</td>
				<td>�����<br />010-1234-5678 �� 3��</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>������</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="����" /></td>
				<td>�ΰ�����</td>
				<td>�����<br />010-1234-5678</td>
				<td>�����<br />010-1234-5678 �� 3��</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>������</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="����" /></td>
				<td>�ΰ�����</td>
				<td>�����<br />010-1234-5678</td>
				<td>�����<br />010-1234-5678 �� 3��</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>������</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="����" /></td>
				<td>�ΰ�����</td>
				<td>�����<br />010-1234-5678</td>
				<td>�����<br />010-1234-5678 �� 3��</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>������</span></a></td>
			</tr>
			</tbody>
		</table>
		<!-- //����Ʈ -->
		<!-- ����¡ -->
		<div class="paging">
			<a href="#none" class="btn btn_first"><span class="hidden_obj">ó��������</span></a><a href="#none" class="btn btn_prev"><span class="hidden_obj">����������</span></a>
			<strong>1</strong>
			<a href="#none">2</a>
			<a href="#none">3</a>
			<a href="#none">4</a>
			<a href="#none">5</a>
			<a href="#none">6</a>
			<a href="#none">7</a>
			<a href="#none">8</a>
			<a href="#none">9</a>
			<a href="#none">10</a>
			<a href="#none" class="btn btn_next"><span class="hidden_obj">����������</span></a><a href="#none" class="btn btn_last"><span class="hidden_obj">������������</span></a>
		</div>
		<!-- //����¡ -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaR"><a href="companyRegistForm.html" class="btn_type01 md0"><span>�������</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</div>
</body>
</html>