<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.huebooklist.HueBookListDTO" %>
<%@ page import="com.huation.common.user.UserBroker"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	HueBookListDTO hlDto = (HueBookListDTO)model.get("hlDto");
	String a="";
	String b="";
	if(hlDto.getUseYN().equals("Y")){
		a = "Selected='Selected'";
	}else if(hlDto.getUseYN().equals("N")){
		b = "Selected='Selected'";
	}	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>HueBook ���� �󼼺���</title>
<script language="JavaScript">
<!--

function goSave(){
	var frm = document.hueBookView; 
	
	if(confirm("�����Ͻðڽ��ϱ�?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookList.do?cmd=hueBookListEdit'	
	
	if(frm.bookName.value == ""){
		alert("�������� �Է��ϼ���.");
		return;
	}
	if(frm.writer.value == ""){
		alert("���ڸ� �Է��ϼ���.");
		return;
	}
	if(frm.branchCode.value == ""){
		alert("�о߸� �����ϼ���.");
		return;
	}
	if(frm.publisher.value == ""){
		alert("���ǻ縦 �Է��ϼ���.");
		return;
	}
	frm.requestUser.value = frm.user_id.value;
	frm.submit();
	}
}
   //���
	function goList(){
		
		var frm = document.hueBookView;
		frm.action='<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList';
		frm.submit();
   }
	//����
	function goDelete(){
		
		var frm = document.hueBookView;
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			frm.action='<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookDelete';
			frm.submit();
		}

	}

//-->
</script>
</head>
<body>
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEBook &gt; �޺ϸ��</div>
			<h3><span>��</span>�ϸ�ϻ�����</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con" id="excelBody">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ��� -->
				<form name="hueBookView" method="post">
				<input type = "hidden" name = "curPage" value="<%=curPage%>">
				<input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
				<input type = "hidden" name = "requestUser" value=""><!-- UserID�� ������� -->
				<!-- Update�� �Ѱ��� ����(pk��) -->
				<input type="hidden" name="hueBookCode" value="<%=hlDto.getHueBookCode()%>"></input>
				<fieldset>
					<legend>�޺ϸ�ϻ�����</legend>
					<table class="tbl_type" summary="�޺ϸ�ϻ�����(������ȣ, ������, ���ǻ�, ����, �о�, ����ó, ��û��, ��û����, ������, ��������, ���Ű���, ��������)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for="">������ȣ</label></th>
							<td><input type="text" id="" class="text dis" title="������ȣ" style="width:200px;" name="" value="<%=hlDto.getHueBookCode()%>" readonly="readonly" /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
							<td><input type="text" id="" class="text" title="������" style="ime-mode:active;width:916px;" name="bookName" value="<%=hlDto.getBookName() %>" maxlength="50" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ǻ�</label></th>
							<td><input type="text" id="" class="text" title="���ǻ�" style="ime-mode:active;width:300px;" name="publisher" value="<%=hlDto.getPublisher() %>" maxlength="25" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
							<td><input type="text" id="" class="text" title="����" style="ime-mode:active;width:300px;" name="writer" value="<%=hlDto.getWriter() %>" maxlength="50" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�о�</label></th>
							<td><%
								CodeParam codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("td3");
								//codeParam.setFirst("��ü");
								codeParam.setName("branchCode");
								codeParam.setSelected(hlDto.getBranchCode()); 
								//codeParam.setEvent("javascript:poductSet();"); 
								out.print(CommonUtil.getCodeList(codeParam,"A08")); 
							%></td>
						</tr>
						<tr>
							<th><label for="">����ó</label></th>
							<td><input type="text" id="" class="text dis" title="����ó" style="ime-mode:active;width:300px;" name="" value="<%=hlDto.getPurchasingOffice() %>" maxlength="50" readonly="readonly" /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">��û��</label></th>
							<td><input type="text" id="" class="text dis" title="��û��" style="width:200px;" name="" value="<%=hlDto.getRequestName()%>" readOnly /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">��û����</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getRequestDate()%>" readonly="readonly" /><input type="hidden" name="" value="<%=hlDto.getRequestDate()%>" /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">������</label></th>
							<td><input type="text" id="" class="text dis" title="������" style="width:200px;" name="" value="<%=hlDto.getApprovalName()%>" readOnly /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">��������</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getClearDate()%>" readonly="readonly" /><input type="hidden" name="" class="text" value="<%=hlDto.getClearDate()%>" /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">���Ű���</label></th>
							<td><input type="hidden" name="" class="text" style="width:80px" value="<%=hlDto.getBuyPrice() %>" maxlength="9"><input type="text" id="" class="text text_r dis" title="���Ű���" style="ime-mode:active;width:200px;" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hlDto.getBuyPrice()) %>" maxlength="9" readonly="readonly" /> ��</td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">��������</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getBuyDate()%>" readonly="readonly" /><input type="hidden" name="" class="text" value="<%=hlDto.getBuyDate()%>" /></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">�������</label></th>
							<td>
								<select id="" name = "useYN">
									<option value="Y" <%=a%> >���</option>
									<option value="N" <%=b%> >���</option>
									
								</select>
							</td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
				<!-- //Bottom ��ư���� -->
			</div>
		</div>
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"52")%>