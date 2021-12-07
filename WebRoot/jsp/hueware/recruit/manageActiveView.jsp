<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.ActiveDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<ActiveDTO> arrlist = (ArrayList)model.get("historyList");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP9. ��ȸ����ױ⿩</title>
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
	function doAddRowData(history_code,start_ymd,end_ymd,activety_org,major_activety){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list" summary="STEP9. ��ȸ����ױ⿩"><colgroup><col width="17%" /><col width="30%" /><col width="*" /></colgroup><tr><td><input name="start_ymd" value="'+addDateFormatDefault(start_ymd)+'" maxlength="8" readOnly  class="text" size="9" title="Ȱ��������" style="width:67px;" /> ~ <input name="end_ymd" value="'+addDateFormatDefault(end_ymd)+'" maxlength="8" readOnly  class="text" size="9" title="Ȱ��������" style="width:67px;" /></td><td><input name="activety_org" title="Ȱ�������" style="width:317px;" readOnly  class="text"  value="'+activety_org+'" maxlength="25" size="18"  /></td><td><input name="major_activety" readOnly  class="text" title="�ֿ�Ȱ��" style="width:592px;"  value="'+major_activety+'" maxlength="500" size="62" /></td></tr></table>';
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
		newCell.innerHTML = '<table width="704" border="0" cellpadding="0" cellspacing="0"><tr><td width="160 height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input type="hidden" name="seqs"><input name="start_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"  size="9" height="20" /> ~ <input name="end_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"  size="9" height="20" /></td><td width="1" height="35" bgcolor="f3f8eb"></td><td width="140" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="activety_org" style="ime-mode:active" maxlength="25" size="18" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="400" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="major_activety" maxlength="500" style="ime-mode:active" size="62" height="20" /></td></tr></table>';

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

					frm.seqs[i].value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ymd[i].value))+'|'+fillSpace(onlyNum(frm.end_ymd[i].value))+'|'+fillSpace(frm.activety_org[i].value)+'|'+fillSpace(frm.major_activety[i].value);
			}

		}else{

				frm.seqs.value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ymd.value))+'|'+fillSpace(onlyNum(frm.end_ymd.value))+'|'+fillSpace(frm.activety_org.value)+'|'+fillSpace(frm.major_activety.value);


		}

		frm.cmd.value="activeTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="eduInfoView";
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

					frm.seqs[i].value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ymd[i].value))+'|'+fillSpace(onlyNum(frm.end_ymd[i].value))+'|'+fillSpace(frm.activety_org[i].value)+'|'+fillSpace(frm.major_activety[i].value);
			}

		}else{

				frm.seqs.value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ymd.value))+'|'+fillSpace(onlyNum(frm.end_ymd.value))+'|'+fillSpace(frm.activety_org.value)+'|'+fillSpace(frm.major_activety.value);


		}

		frm.cmd.value="activeSaveNext";
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
<div id="header">
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
</div>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
<div class="content_navi">HUEHome���� &gt; ä�����</div>
<h3><span>ä</span>�����������</h3>
<div class="con recruitManage">
	<!-- ��(step1 ~ step13) -->
	<ol class="stepTab step9on"><!-- STEP�� ���� class���� (ex : step1on) -->
		<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. �Ϲ���������/�⺻��������</a></li>
		<li><a href="javascript:goManageHistory();">STEP2. �з»���</a></li>
		<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. �ڰ�/�������</a></li>
		<li><a href="javascript:goManageAwardView();">STEP4. �������</a></li>
		<li><a href="javascript:goManageLangView();">STEP5. ���л���</a></li>
		<li><a href="javascript:goManageFamilyView();">STEP6. ��������</a></li>
		<li><a href="javascript:goManageCareerView();">STEP7. ��»���</a></li>
		<li><a href=javascript:goManageEduView();>STEP8. ��������</a></li>
		<li class="step9 on"><a href="javascript:goManageActiveView();">STEP9. ��ȸ����ױ⿩</a></li><!-- STEP�� ���� class="on" �߰� -->
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
	<legend>STEP9. ��ȸ����ױ⿩</legend>
	<table class="tbl_type tbl_type_list" summary="STEP9. ��ȸ����ױ⿩">
		<colgroup>
			<col width="17%" />
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<thead>
		<tr>
			<th colspan="3" class="title">STEP9. ��ȸ����ױ⿩</th>
		</tr>
		<tr>
			<th><label for="">Ȱ���Ⱓ(��/��/��)</label></th>
			<th><label for="">Ȱ�������</label></th>
			<th><label for="">�ֿ�Ȱ��</label></th>
		</tr>
		</thead>
		</table>
		<table id="defaultText">
		</table>
		<table id="contentId">
        </table>
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
<!-- //contents -->
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
			ActiveDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getActivety_org().trim()%>','<%=dto.getMajor_activety().trim()%>');
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