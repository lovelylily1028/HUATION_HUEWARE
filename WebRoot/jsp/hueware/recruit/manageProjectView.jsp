<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.ProjectDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<ProjectDTO> arrlist = (ArrayList)model.get("historyList");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP11. ������Ʈ������</title>
<script>
    document.onkeydown = function() {
		if (event.keyCode == 116) {
			event.keyCode = 505;
		}
		if (event.keyCode == 505) {
			return false;
		}
	}
	/*
	*	���̺� row �߰�
	*/
	function doAddRowData(history_code,start_ymd,end_ymd,project_nm,order_org,proc_org,role,project_detail){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="17%" /><col width="*" /><col width="20%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><th><label for="">������Ʈ�Ⱓ(�����)</label></th><th><label for="">������Ʈ��</label></th><th><label for="">����ó</label></th><th><label for="">����üҼӱ����</label></th><th><label for="">����</label></th></tr><tr><td><input type="text" name="start_ymd" value="'+addDateFormatDefault(start_ymd)+'" maxlength="8" readOnly class="text" title="������Ʈ������" style="width:67px;" /> ~ <input type="text" name="end_ymd" value="'+addDateFormatDefault(end_ymd)+'" maxlength="8" readOnly class="text" title="������Ʈ������" style="width:67px;" /></td><td><input type="text" name="project_nm" readOnly value="'+project_nm+'" class="text" title="������Ʈ��" style="ime-mode:active;width:233px;" maxlength="50" tabindex="8" /></td><td><input type="text" name="order_org" readOnly value="'+order_org+'" class="text" title="����ó" style="ime-mode:active;width:196px;" maxlength="20" tabindex="8" /></td><td><input type="text" name="proc_org" readOnly value="'+proc_org+'" class="text" title="����üҼӱ����" style="ime-mode:active;width:197px;" maxlength="20" tabindex="8" /></td><td><input type="text" name="role" readOnly value="'+role+'" class="text" title="����" style="ime-mode:active;width:197px;" maxlength="10" tabindex="8" /></td></tr><tr><th colspan="5"><label for="">������Ʈ����󼼳���</label></th></tr><tr><td colspan="5"><textarea name="project_detail" readOnly id="textarea" title="������Ʈ����󼼳���" style="ime-mode:active;width:1156px;height:192px;">'+project_detail.split("<br>").join("\r\n")+'</textarea></td></tr></tbody></table>';

	}
	/*
	*	���̺� row �߰�
	*/
	function doAddRow(){
		
		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="17%" /><col width="*" /><col width="20%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><th><label for="">������Ʈ�Ⱓ(�����)</label></th><th><label for="">������Ʈ��</label></th><th><label for="">����ó</label></th><th><label for="">����üҼӱ����</label></th><th><label for="">����</label></th></tr><tr><td><input type="text" name="start_ymd" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" class="text" title="������Ʈ������" style="width:67px;" /> ~ <input name="end_ymd" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" class="text" title="������Ʈ������" style="width:67px;" /></td><td><input name="project_nm" maxlength="50" tabindex="8" class="text" title="������Ʈ��" style="ime-mode:active;width:233px;" /></td><td><input name="order_org" style="ime-mode:active" maxlength="20" tabindex="8" class="text" title="����ó" style="ime-mode:active;width:196px;" /></td><td><input name="proc_org"  style="ime-mode:active" maxlength="20" tabindex="8" class="text" title="����üҼӱ����" style="ime-mode:active;width:197px;" /></td><td><input name="role" style="ime-mode:active" maxlength="10" tabindex="8" class="text" title="����" style="ime-mode:active;width:197px;" /></td></tr><tr><th colspan="5"><label for="">������Ʈ����󼼳���</label></th></tr><tr><td colspan="5"><textarea name="project_detail" id="textarea" title="������Ʈ����󼼳���" style="ime-mode:active;width:1156px;height:192px;"></textarea></td></tr></tbody></table>';

	}


	/*
	*	���̺� row ����
	*/
	function doDeleteRow(){
		
		if(confirm('�ο� ������ ������� ���� ������ �Ұ��� �մϴ�.\n�����Ͻðڽ��ϱ�?') == false) {
				return;
		}
		var rowCnt = contentId.rows.length;
		contentId.deleteRow(rowCnt-1);

		if(rowCnt==2){
			defaultText.style.display='block';
		}
	}
	function fillSpace(val){

		if(val.length==0){
			return ' ';
		}
	    return val;
	}
	function tempSave(){
		
		var frm=document.historyFrm;
		var rowCnt = contentId.rows.length;

		if(rowCnt<2){
			
			alert('�� �߰� ��ư�� ���� �Ѱ� �̻� ����ϼž� �մϴ�.\n ����Ͻ� ������ ���°�� �߰��� ���»��·� ���� �Ͻñ� �ٶ��ϴ�.');
			return;
	
		}

		if(confirm('�ӽ÷� �����Ͻðڽ��ϱ�?') == false) {
				return;
		}

		if(frm.seqs.length>1){
			for(i=0;i<frm.seqs.length;i++){

					frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.project_nm[i].value)+'|'+fillSpace(onlyNum(frm.start_ymd[i].value))+'|'+fillSpace(onlyNum(frm.end_ymd[i].value))+'|'+fillSpace(frm.order_org[i].value)+'|'+fillSpace(frm.proc_org[i].value)+'|'+fillSpace(frm.role[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.project_nm.value)+'|'+fillSpace(onlyNum(frm.start_ymd.value))+'|'+fillSpace(onlyNum(frm.end_ymd.value))+'|'+fillSpace(frm.order_org.value)+'|'+fillSpace(frm.proc_org.value)+'|'+fillSpace(frm.role.value);

		}

		frm.cmd.value="projectTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="trainInfoView";
		frm.submit();

	}
	function nextStep(){
	   
	    var frm=document.historyFrm;
		var rowCnt = contentId.rows.length;

		if(rowCnt<2){
			
			alert('�� �߰� ��ư�� ���� �Ѱ� �̻� ����ϼž� �մϴ�.\n ����Ͻ� ������ ���°�� �߰��� ���»��·� ���� �Ͻñ� �ٶ��ϴ�.');
			return;
	
		}

		if(confirm('���� �� �����ܰ�� ����˴ϴ�. \n����Ͻðڽ��ϱ�?') == false) {
				return;
		}

		if(frm.seqs.length>1){
			for(i=0;i<frm.seqs.length;i++){

					frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.project_nm[i].value)+'|'+fillSpace(onlyNum(frm.start_ymd[i].value))+'|'+fillSpace(onlyNum(frm.end_ymd[i].value))+'|'+fillSpace(frm.order_org[i].value)+'|'+fillSpace(frm.proc_org[i].value)+'|'+fillSpace(frm.role[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.project_nm.value)+'|'+fillSpace(onlyNum(frm.start_ymd.value))+'|'+fillSpace(onlyNum(frm.end_ymd.value))+'|'+fillSpace(frm.order_org.value)+'|'+fillSpace(frm.proc_org.value)+'|'+fillSpace(frm.role.value);

		}

		frm.cmd.value="projectSaveNext";
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
				<!-- ��(step1 ~ step13) -->
				<ol class="stepTab step11on"><!-- STEP�� ���� class���� (ex : step1on) -->
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
					<li class="step11 on"><a href="javascript:goManageProjectView();">STEP11. ������Ʈ������</a></li><!-- STEP�� ���� class="on" �߰� -->
					<li class="step12"><a href="javascript:goManageItroView();">STEP12. �ڱ�Ұ�</a></li>
					<li class="step13"><a href="javascript:goManageLastView();">STEP13. �Ի��������ۼ��Ϸ�</a></li>
				</ol>
				<!-- //�� -->
				<!-- //�� -->
				<!-- ��� -->
				<div class="info">
					<form name="historyFrm" method="post" action="<%= request.getContextPath()%>/F_Recruit.do">
					<input type="hidden" name="cmd">
					<input type="hidden" name="procKey" value="U">
					<input type="hidden" name="apply_code" value="<%=apply_code%>">
					<input type = "hidden" name = "curPage" value="<%=curPage%>">
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
					<fieldset>
						<legend>STEP11. ������Ʈ������</legend>
						<table class="tbl_type tbl_type_list" summary="STEP11. ������Ʈ������">
							<thead>
							<tr>
								<th class="title">STEP11. ������Ʈ������</th>
							</tr>
							</thead>
						</table>
						<!-- Ÿ��Ʋ :: START -->
						<table class="tbl_type tbl_type_list" id="defaultText">
							<tr>
								<td class="text_l"><span class="guide_txt">* �߰� ��ư�� ���� �Ѱ� �̻� ����ϼž� �մϴ�. ����Ͻ� ������ ���°�� �߰��� ���»��·� ���� �Ͻñ� �ٶ��ϴ�.</span></td>
							</tr>
						</table>
						<!-- //Ÿ��Ʋ :: END -->
						<!-- �߰�ROW :: START -->
						<table id="contentId">
						</table>
						<!-- //�߰�ROW :: END -->
					</fieldset>
					</form>
				</div>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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
<!--�Է�ROW :: START-->
<%	

	if(arrlist.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist.size(); j++ ){	
			ProjectDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getProject_nm().trim()%>','<%=dto.getOrder_org().trim()%>','<%=dto.getProc_org().trim()%>','<%=dto.getRole().trim()%>','<%=dto.getProject_detail().replace("\r\n","<br>")%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END-->
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>