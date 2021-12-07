<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.LangDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<LangDTO> arrlist = (ArrayList)model.get("historyList");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP5. ���л���</title>
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
	function doAddRowData(history_code,language,exam_type,grade,take_ymd,issue_org){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<table class="tbl_type tbl_type_list" summary="STEP5. ���л���"><colgroup><col width="20%" /><col width="*" /><col width="12%" /><col width="12%" /><col width="25%" /></colgroup><thead><tr><td><input type="hidden" name="seqs"><input name="language" readOnly  class="text"  value="'+language+'" title="���" style="width:197px;"  maxlength="15" size="13" />	</td><td><input name="exam_type" readOnly  class="text"  value="'+exam_type+'" title="��������" style="width:328px;" maxlength="50" size="29" /></td><td><input name="grade" readOnly  class="text"  value="'+grade+'" title="���(����)" style="width:101px;"  maxlength="5" size="9" /></td><td><input name="take_ymd" value="'+addDateFormatDefault(take_ymd)+'"  maxlength="8"  readOnly  class="text"  size="9" title="���ó����" style="width:101px;" /></td><td width="210" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="issue_org" readOnly  class="text"  value="'+issue_org+'" title="�߱ޱ��" style="width:257px;" maxlength="25" size="29" /></td></tr></table>';
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
		newCell.innerHTML = '<table width="704" border="0" cellpadding="0" cellspacing="0"><tr><td width="110 height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input type="hidden" name="seqs"><input name="language" style="ime-mode:active" maxlength="15" size="13" height="20" /></td><td width="1" height="35" bgcolor="f3f8eb"></td><td width="210" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="exam_type" style="ime-mode:active" maxlength="50" size="29" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="85" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="grade" style="ime-mode:active" maxlength="5" size="9" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="85" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="take_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" size="9" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="210" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="issue_org" style="ime-mode:active" maxlength="25" size="29" height="20" /></td></tr></table>';

	}


	/*
	*	���̺� row ����
	*/
	function doDeleteRow(){
		
		if(confirm('�ο� ������ ������� ���� ����Ÿ�� ������ �Ұ��� �մϴ�.\n�����Ͻðڽ��ϱ�?') == false) {
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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.language[i].value)+'|'+fillSpace(frm.exam_type[i].value)+'|'+fillSpace(frm.grade[i].value)+'|'+fillSpace(onlyNum(frm.take_ymd[i].value))+'|'+fillSpace(frm.issue_org[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.language.value)+'|'+fillSpace(frm.exam_type.value)+'|'+fillSpace(frm.grade.value)+'|'+fillSpace(onlyNum(frm.take_ymd.value))+'|'+fillSpace(frm.issue_org.value);


		}

		frm.cmd.value="langTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="awardInfoView";
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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.language[i].value)+'|'+fillSpace(frm.exam_type[i].value)+'|'+fillSpace(frm.grade[i].value)+'|'+fillSpace(onlyNum(frm.take_ymd[i].value))+'|'+fillSpace(frm.issue_org[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.language.value)+'|'+fillSpace(frm.exam_type.value)+'|'+fillSpace(frm.grade.value)+'|'+fillSpace(onlyNum(frm.take_ymd.value))+'|'+fillSpace(frm.issue_org.value);


		}

		frm.cmd.value="langSaveNext";
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
<!-- content -->
<div id="content">
<div class="content_navi">HUEHome���� &gt; ä�����</div>
<h3><span>ä</span>�����������</h3>
<div class="con recruitManage">
	<!-- ��(step1 ~ step13) -->
	<ol class="stepTab step5on"><!-- STEP�� ���� class���� (ex : step1on) -->
		<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. �Ϲ���������/�⺻��������</a></li>
		<li><a href="javascript:goManageHistory();">STEP2. �з»���</a></li>
		<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. �ڰ�/�������</a></li>
		<li><a href="javascript:goManageAwardView();">STEP4. �������</a></li>
		<li class="on"><a href="javascript:goManageLangView();">STEP5. ���л���</a></li><!-- STEP�� ���� class="on" �߰� -->
		<li><a href="javascript:goManageFamilyView();">STEP6. ��������</a></li>
		<li><a href="javascript:goManageCareerView();">STEP7. ��»���</a></li>
		<li><a href="javascript:goManageEduView();">STEP8. ��������</a></li>
		<li class="step9"><a href="javascript:goManageActiveView();">STEP9. ��ȸ����ױ⿩</a></li>
		<li class="step10"><a href="javascript:goManageTrainView();">STEP10. �ؿܿ���׿���</a></li>
		<li class="step11"><a href="javascript:goManageProjectView();">STEP11. ������Ʈ������</a></li>
		<li class="step12"><a href="javascript:goManageItroView();">STEP12. �ڱ�Ұ�</a></li>
		<li class="step13"><a href="javascript:goManageLastView();">STEP13. �Ի��������ۼ��Ϸ�</a></li>
	</ol>
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
		<legend>STEP5. ���л���</legend>
		<table class="tbl_type tbl_type_list" summary="STEP5. ���л���">
			<colgroup>
				<col width="20%" />
				<col width="*" />
				<col width="12%" />
				<col width="12%" />
				<col width="25%" />
			</colgroup>
			<thead>
			<tr>
				<th colspan="5" class="title">STEP5. ���л���</th>
			</tr>
			<tr>
				<th><label for="">���</label></th>
				<th><label for="">��������</label></th>
				<th><label for="">���(����)</label></th>
				<th><label for="">���ó����</label></th>
				<th><label for="">�߱ޱ��</label></th>
			</tr>
			</thead>

				<table id="defaultText">
				</table>
				<table id="contentId">
				</table>

				                          
</table>
</fieldset>
</form>
</div>
<!-- Bottom ��ư���� -->
<div class="Bbtn_areaC">
<a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
<!-- //Bottom ��ư���� -->
</div>

</div>
</div>
<!-- //contents -->
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>

</div>
</body>
</html>
<!--�Է�ROW :: START-->
<%	

	if(arrlist.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist.size(); j++ ){	
			LangDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getLanguage().trim()%>','<%=dto.getExam_type().trim()%>','<%=dto.getGrade().trim()%>','<%=dto.getTake_ymd().trim()%>','<%=dto.getIssue_org().trim()%>');
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