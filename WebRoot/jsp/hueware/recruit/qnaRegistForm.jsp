<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%
	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����ϴ� ���� ���������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){
	var frm = document.qnaRegist; 

	if(frm.question.value.length == 0){
		alert("������ �Է��ϼ���");
		return;
	}
	if(frm.answer.value.length == 0){
		alert("�亯�� �Է��ϼ���");
		return;
	}

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.submit();
}

function cancle(){
	
	var frm = document.qnaRegist;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList';
	frm.submit();

}
//-->
</SCRIPT>
</head>

<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome���� &gt; ���ֹ�������</div>
			<h3><span>��</span>�ֹ����������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ��� -->
				<form name="qnaRegist" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=qnaRegist">
					<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
					<input type = "hidden" name = "qna_gb" value="01"/>
     
				<fieldset>
					<legend>���ֹ����������</legend>
					<table class="tbl_type" summary="���ֹ����������(����, �亯)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
							<td><input type="text" id="" name="question" class="text" title="����" style="width:916px;" /></td>
						</tr>     
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�亯</label></th>
							<td><textarea id="" name="answer" title="�亯" style="width:916px;height:248px;"></textarea></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->			
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"44") %>