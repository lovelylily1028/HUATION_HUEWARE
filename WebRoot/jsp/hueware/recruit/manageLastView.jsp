<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.recruit.DefaultDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	DefaultDTO defaultDto = (DefaultDTO)model.get("defaultDto");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>STEP13. �Ի��������ۼ��Ϸ�</title>
<script>
    document.onkeydown = function() {
		if (event.keyCode == 116) {
			event.keyCode = 505;
		}
		if (event.keyCode == 505) {
			return false;
		}
	}
	
	function applySave(){
		
		var frm=document.historyFrm;

		var result;

		if(frm.result_state.value=='F'){
			result='(���հ�)';
		}else if (frm.result_state.value=='S'){
			result='(�հ�)';
		}else{
			result='(���)';
		}
		
		if(confirm('�Ի����� �����'+result+'���� ���� �Ͻðڽ��ϱ�?\n�����Ͻø� ���� �Ի������� ���� ����� �ݿ��˴ϴ�.') == false) {
				return;
		}

		frm.cmd.value="recruitUpdate";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="introInfoView";
		frm.submit();

	}
    function goTab(url){

		var frm=document.historyFrm;
		frm.action=url;
		frm.submit();

   }
   function goCancel(){
	
	var frm = document.historyFrm;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitManageList';
	frm.submit();

   }


   function goManageDefaultView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageDefaultView';
	   frm.submit();
   }
  
   function goManageHistory(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageHistoryView';
	   frm.submit();
   }
   
   function goManageLicenseView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageLicenseView';
	   frm.submit();
   }
   
   function goManageAwardView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageAwardView';
	   frm.submit();
   }
   
   function goManageLangView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageLangView';
	   frm.submit();
   }
   
   function goManageFamilyView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageFamilyView';
	   frm.submit();
   }
   
   function goManageCareerView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageCareerView';
	   frm.submit();
   }
   
   function goManageEduView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageEduView';
	   frm.submit();
   }
   
   function goManageActiveView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageActiveView';
	   frm.submit();
   }
   
   function goManageTrainView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageTrainView';
	   frm.submit();
   }
   
   function goManageProjectView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageProjectView';
	   frm.submit();
   }
   
   function goManageItroView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageItroView';
	   frm.submit();
   }
   
   function goManageLastView(){
	   var frm = document.historyFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageLastView';
	   frm.submit();
   }
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
			<div class="content_navi">HUEHome���� &gt; ä�����</div>
			<h3><span>ä</span>�����������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con recruitManage">
				<!-- ��(step1 ~ step13) -->
				<ol class="stepTab step13on"><!-- STEP�� ���� class���� (ex : step1on) -->
					<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. �Ϲ���������/�⺻��������</a></li>
					<li><a href="javascript:goManageHistory();">STEP2. �з»���</a></li>
					<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. �ڰ�/�������</a></li>
					<li><a href="javascript:goManageAwardView();">STEP4. �������</a></li>
					<li><a href="javascript:goManageLangView();">STEP5. ���л���</a></li>
					<li><a href="javascript:goManageFamilyView();">STEP6. ��������</a></li>
					<li><a href="javascript:goManageCareerView();">STEP7. ��»���</a></li>
					<li><a href="javascript:goManageEduView();">STEP8. ��������</a></li>
					<li class="step9"><a href="javascript:goManageActiveView();">STEP9. ��ȸ����ױ⿩</a></li>
					<li class="step10"><a href="javascript:goManageTrainView();">STEP10. �ؿܿ���׿���</a></li>
					<li class="step11"><a href="javascript:goManageProjectView();">STEP11. ������Ʈ������</a></li>
					<li class="step12"><a href="javascript:goManageItroView();">STEP12. �ڱ�Ұ�</a></li>
					<li class="step13 on"><a href="javascript:goManageLastView();">STEP13. �Ի��������ۼ��Ϸ�</a></li><!-- STEP�� ���� class="on" �߰� -->
				</ol>
				<!-- //�� -->
				<!-- ��� -->
				<div class="info">
					<form name="historyFrm" method="post" action="<%= request.getContextPath()%>/B_Recruit.do">
					<input type="hidden" name="cmd">
					<input type="hidden" name="apply_code" value="<%=apply_code%>">
					<input type = "hidden" name = "curPage" value="<%=curPage%>">
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
					<fieldset>
						<legend>STEP13. �Ի��������ۼ��Ϸ�</legend>
						<table class="tbl_type tbl_type_list" summary="STEP13. �Ի��������ۼ��Ϸ�">
							<thead>
							<tr>
								<th class="title">STEP13. �Ի��������ۼ��Ϸ�</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td class="step13_area"><strong class="guide_txt">�Ի� ������ �ۼ��� �Ϸ�Ǿ����ϴ�.<br />�ۼ��� ���뿡 ���� ��������� �����Ͻø� �հݿ��ΰ� �ݿ��˴ϴ�.</strong><br /><label for=""><strong>�հݿ���</strong></label>&nbsp;&nbsp;<%
									CodeParam codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("style2");
									//codeParam.setFirst("����");
									codeParam.setName("result_state");
									codeParam.setSelected(StringUtil.nvl(defaultDto.getResult_state(),"")); 
									out.print(CommonUtil.getCodeList(codeParam,"H12")); 
								%></td>
							</tr>
							</tbody>
						</table>
					</fieldset>
					</form>
				</div>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:applySave();" class="btn_type02"><span>����</span></a><a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
		this.close();
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>