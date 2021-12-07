<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	CompanyDTO compDto = (CompanyDTO)model.get("compDto");

	//CompanyMasterDTO dto=(CompanyMasterDTO)request.getAttribute("dto");
	//CodeParam codeParam = null;	// �ڵ����

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>���޹޴��� ������</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
</head>

<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>���޹޴��� ������</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- ��� -->
<form  method="post" name=UserRegist action="<%= request.getContextPath()%>/H_User.do?cmd=userRegist">
	<fieldset>
		<legend>���޹޴��� ������</legend>
		<table class="tbl_type" summary="���޹޴��� ������(����ڵ�Ϲ�ȣ, ���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ), ��ȣ(���θ�), ��ǥ�ڸ�, ����, ����, ����������)">
        <caption>������ �޴��� ������</caption>
        	<colgroup>
				<col width="30%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr>
				<th><label for="">����ڵ�Ϲ�ȣ</label></th>
				<!-- COMP_CODE = > PERMIT_NO�� ������. ������ڵ尡�ƴ� ����ڹ�ȣ�� ���� -->
				<td><input type="text" name="permit_no" class="text"  title="����ڵ�Ϲ�ȣ" style="width:200px;" value="<%=compDto.getPermit_no()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)</label></th>
				<td><input type="text" name="comp_no" class="text"  title="���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)" style="width:200px;" value="<%=compDto.getComp_no()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">��ȣ(���θ�)</label></th>
				<td><input type="text" name="comp_nm" class="text"  title="��ȣ(���θ�)" style="width:300px;" value="<%=compDto.getComp_nm()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">��ǥ�ڸ�</label></th>
				<td><input type="text" name="owner_nm" class="text" title="��ǥ�ڸ�" style="width:200px;" value="<%=compDto.getOwner_nm()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">����</label></th>
				<td><input type="text" name="business" class="text" title="����" style="width:300px;" value="<%=compDto.getBusiness()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">����</label></th>
				<td><input type="text" name="b_item" class="text" title="����" style="width:300px;" value="<%=compDto.getB_item()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">����������</label></th>
				<td>
				<ul class="listD">
				<li class="first"><input type="text" name="post" readOnly class="text" title="�����ȣ" style="width:80px;" value="<%=compDto.getPost()%>" ></li>
				<li><input type="text" readOnly name="address" class="text" title="�⺻�ּ�" style="width:300px;" value="<%=compDto.getAddress()%>"></li>
				<li><input type="text" name="addr_detail" class="text" title="���ּ�" style="width:300px;" readOnly value="<%=compDto.getAddr_detail()%>"></li>
				</ul>
				</td>
			</tr>
			</tbody>
		</table>
		</fieldset>
		</form>
    <!-- //��� -->
    <!-- button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
    </div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
  </form>
</body>
</html>