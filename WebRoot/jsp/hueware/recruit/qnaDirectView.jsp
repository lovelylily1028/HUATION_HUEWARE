<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.recruit.QnaDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    QnaDTO qnaDto = (QnaDTO)model.get("compDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ä�빮�� ����Ʈ(1:1 ����)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goAnswer(){
	var frm = document.qnaView; 

	if(frm.answer.value.length == 0){
		alert("�亯�� �Է��ϼ���");
		return;
	}

	if(confirm("�����ǿ� �亯 �Ͻðڽ��ϱ�?\n�亯�� �� �̸��� �ּҷ� ������ ���޵˴ϴ�.")){

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		openWaiting();
		frm.submit();
	}
}

function goList(){
	
	var frm = document.qnaView;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList';
	frm.submit();

}
		// ���⼭ ���ʹ� ó���� ǥ���ϴ� function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//���̱�
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function waitStart() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("waitStart()", 100);  // 0.1�ʸ��� Ȯ��
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
			<div class="content_navi">HUEHome���� &gt; ä�빮��(1:1����)</div>
			<h3><span>ä</span>�빮�ǻ�����(1:1����)</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ��� -->
			    <form name="qnaView" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=qnaEdit">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
			      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
			      <input type = "hidden" name = "qna_no"  value="<%=qnaDto.getQna_no()%>"/>
			      <input type = "hidden" name = "qna_gb" value="02"/>
			      <input type = "hidden" name = "question"  value="<%=qnaDto.getQuestion()%>"/>

				<fieldset>
					<legend>ä�빮�ǻ�����(1:1����)</legend>
					<table class="tbl_type" summary="ä�빮�ǻ�����(1:1����)(����, �������, ÷������, ����, �亯)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
							<td><input type="text" id="" name="subject" class="text dis" title="����" style="width:916px;" readOnly value="<%=qnaDto.getSubject()%>"/></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>      
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�������</label></th>
							<td><input type="text" id="" name="email" class="text dis" title="�������" style="width:916px;" readOnly value="<%=qnaDto.getEmail()%>"/></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>÷������</label></th>
							<td><% if(!qnaDto.getQna_file().equals("")){ %><a href="<%= request.getContextPath()%>/data/<%=qnaDto.getQna_file()%>" target="new"><span id="p_account_copy1_t">÷������ [click]</span></a><% } %></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
							<td><textarea id="" name="question" title="����" class="dis" style="width:916px;height:124px;" readOnly><%=qnaDto.getQuestion()%></textarea></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�亯</label></th>
							<td><%
								 String answer=qnaDto.getAnswer();
									
									if(answer.equals("")){
								%>
							<textarea id="" name="answer" title="�亯" style="width:916px;height:124px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
						        <%
									}else{
								%>
							<textarea id="" name="answer" title="�亯" class="dis" style="width:916px;height:124px;" readOnly><%=qnaDto.getAnswer()%></textarea></td>
						        <%
									}
								%>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC">
					<%
		                if(answer.equals("")){
		            %><a href="javascript:goAnswer();" class="btn_type02"><span>���</span></a><%
					}else{}
					%><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"45") %>