<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.CareerDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<CareerDTO> arrlist = (ArrayList)model.get("historyList");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP7. 경력사항</title>
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
	*	테이블 row 추가
	*/
	function doAddRowData(history_code,start_ym,end_ym,work_org,work_dep,last_position,charge_work,retire_reason){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list" summary="STEP7. 경력사항"><colgroup><col width="17%" /><col width="16%" /><col width="16%" /><col width="10%" /><col width="16%" /><col width="9%" /><col width="16%" /></colgroup><thead><tr><td><input name="start_ym" value="'+addDateFormatDefault(start_ym)+'" maxlength="8"  readOnly  class="text"  size="9" title="근무시작일" style="width:67px;" /> ~ <input name="end_ym"  value="'+addDateFormatDefault(end_ym)+'" maxlength="8"  readOnly  class="text"  size="9" title="근무종료일" style="width:67px;" /></td><td><input name="work_org"readOnly  class="text"   value="'+work_org+'" title="근무기관명" style="width:149px;" maxlength="25" size="10" /></td><td><input name="work_dep" readOnly  class="text"  value="'+work_dep+'" title="근무부서" style="width:149px;" maxlength="25" size="10" /></td><td><input name="last_position" readOnly  class="text"  value="'+last_position+'" title="최종직위" style="width:76px;" maxlength="15" size="10" /></td><td><input name="charge_work" value="'+charge_work+'" readOnly  class="text" title="담당업무" style="width:149px;" maxlength="15" size="10" /></td><td><select name="employ_type" disabled  class="style2" id="select2"><option selected="selected" value="01">정규직</option><option value="02">계약직</option><option value="03">프리렌서</option><option value="04">인턴</option></td><td><input name="retire_reason" readOnly  class="text"   value="'+retire_reason+'" title="퇴직사유" style="width:149px;" maxlength="100" size="10" /></td></tr></table>';
	}
	/*
	*	테이블 row 추가
	*/
	function doAddRow(){
		
		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<table width="704" border="0" cellpadding="0" cellspacing="0"><tr><td width="160 height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input type="hidden" name="seqs"><input name="start_ym" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" size="9" height="20" /> ~ <input name="end_ym" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" size="9" height="20" /></td><td width="1" height="35" bgcolor="f3f8eb"></td><td width="90" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="work_org" style="ime-mode:active" maxlength="25"  size="10" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="90" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="work_dep" maxlength="25" style="ime-mode:active"  size="10" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="90" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="last_position" style="ime-mode:active" maxlength="15"  size="10" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="90" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="charge_work" style="ime-mode:active" maxlength="15"  size="10" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="88" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><select name="employ_type" class="style2" id="select2"><option selected="selected" value="01">정규직</option><option value="02">계약직</option><option value="03">프리렌서</option><option value="04">인턴</option></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="90" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="retire_reason" style="ime-mode:active" maxlength="100"  size="10" height="20" /></td></tr></table>';

	}


	/*
	*	테이블 row 삭제
	*/
	function doDeleteRow(){
		
		if(confirm('로우 삭제시 저장되지 않은 데이타는 복구가 불가능 합니다.\n삭제하시겠습니까?') == false) {
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
			
			alert('※ 추가 버튼을 통해 한건 이상 등록하셔야 합니다.\n 등록하실 내용이 없는경우 추가후 없는상태로 저장 하시기 바랍니다.');
			return;
	
		}

		if(confirm('임시로 저장하시겠습니까?') == false) {
				return;
		}

		if(frm.seqs.length>1){
			for(i=0;i<frm.seqs.length;i++){

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ym[i].value))+'|'+fillSpace(onlyNum(frm.end_ym[i].value))+'|'+fillSpace(frm.work_org[i].value)+'|'+fillSpace(frm.work_dep[i].value)+'|'+fillSpace(frm.last_position[i].value)+'|'+fillSpace(frm.charge_work[i].value)+'|'+fillSpace(frm.employ_type[i].value)+'|'+fillSpace(frm.retire_reason[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ym.value))+'|'+fillSpace(onlyNum(frm.end_ym.value))+'|'+fillSpace(frm.work_org.value)+'|'+fillSpace(frm.work_dep.value)+'|'+fillSpace(frm.last_position.value)+'|'+fillSpace(frm.charge_work.value)+'|'+fillSpace(frm.employ_type.value)+'|'+fillSpace(frm.retire_reason.value);

		}

		frm.cmd.value="careerTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="familyInfoView";
		frm.submit();

	}
	function nextStep(){
	   
	    var frm=document.historyFrm;
		var rowCnt = contentId.rows.length;

		if(rowCnt<2){
			
			alert('※ 추가 버튼을 통해 한건 이상 등록하셔야 합니다.\n 등록하실 내용이 없는경우 추가후 없는상태로 저장 하시기 바랍니다.');
			return;
	
		}

		if(confirm('저장 후 다음단계로 진행됩니다. \n계속하시겠습니까?') == false) {
				return;
		}

		if(frm.seqs.length>1){
			for(i=0;i<frm.seqs.length;i++){

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ym[i].value))+'|'+fillSpace(onlyNum(frm.end_ym[i].value))+'|'+fillSpace(frm.work_org[i].value)+'|'+fillSpace(frm.work_dep[i].value)+'|'+fillSpace(frm.last_position[i].value)+'|'+fillSpace(frm.charge_work[i].value)+'|'+fillSpace(frm.employ_type[i].value)+'|'+fillSpace(frm.retire_reason[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(onlyNum(frm.start_ym.value))+'|'+fillSpace(onlyNum(frm.end_ym.value))+'|'+fillSpace(frm.work_org.value)+'|'+fillSpace(frm.work_dep.value)+'|'+fillSpace(frm.last_position.value)+'|'+fillSpace(frm.charge_work.value)+'|'+fillSpace(frm.employ_type.value)+'|'+fillSpace(frm.retire_reason.value);

		}

		frm.cmd.value="careerSaveNext";
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
<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
<h3><span>채</span>용관리상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
<div class="con recruitManage">
	<!-- 탭(step1 ~ step13) -->
	<ol class="stepTab step7on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
		<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li>
		<li><a href="javascript:goManageHistory();">STEP2. 학력사항</a></li>
		<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. 자격/면허사항</a></li>
		<li><a href="javascript:goManageAwardView();">STEP4. 수상사항</a></li>
		<li><a href="javascript:goManageLangView();">STEP5. 어학사항</a></li>
		<li><a href="javascript:goManageFamilyView();">STEP6. 가족사항</a></li>
		<li class="on"><a href="javascript:goManageCareerView();">STEP7. 경력사항</a></li><!-- STEP에 맞춰 class="on" 추가 -->
		<li><a href="javascript:goManageEduView();">STEP8. 교육사항</a></li>
		<li class="step9"><a href="javascript:goManageActiveView();">STEP9. 사회공헌및기여</a></li>
		<li class="step10"><a href="javascript:goManageTrainView();">STEP10. 해외여행및연수</a></li>
		<li class="step11"><a href="javascript:goManageProjectView();">STEP11. 프로젝트수행경력</a></li>
		<li class="step12"><a href="javascript:goManageItroView();">STEP12. 자기소개</a></li>
		<li class="step13"><a href="javascript:goManageLastView();">STEP13. 입사지원서작성완료</a></li>
	</ol>
	<!-- //탭 -->
	<!-- 등록 -->
	<div class="info">
<form name="historyFrm" method="post" action="<%= request.getContextPath()%>/F_Recruit.do">
<input type="hidden" name="cmd">
<input type="hidden" name="procKey" value="U">
<input type="hidden" name="apply_code" value="<%=apply_code%>">
<input type = "hidden" name = "curPage" value="<%=curPage%>">
<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
<fieldset>
	<legend>STEP7. 경력사항</legend>
	<table class="tbl_type tbl_type_list" summary="STEP7. 경력사항">
		<colgroup>
			<col width="17%" />
			<col width="16%" />
			<col width="16%" />
			<col width="10%" />
			<col width="16%" />
			<col width="9%" />
			<col width="16%" />
		</colgroup>
		<thead>
		<tr>
			<th colspan="7" class="title">STEP7. 경력사항</th>
		</tr>
		<tr>
			<th><label for="">근무기간(년/월)</label></th>
			<th><label for="">근무기관명</label></th>
			<th><label for="">근무부서</label></th>
			<th><label for="">최종직위</label></th>
			<th><label for="">담당업무</label></th>
			<th><label for="">고용형태</label></th>
			<th><label for="">퇴직사유</label></th>
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
<!-- //등록 -->
<!-- Bottom 버튼영역 -->
<div class="Bbtn_areaC"><a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
<!-- //Bottom 버튼영역 -->
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
<!--입력ROW :: START-->
<%	

	if(arrlist.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist.size(); j++ ){	
			CareerDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ym().trim()%>','<%=dto.getEnd_ym().trim()%>','<%=dto.getWork_org().trim()%>','<%=dto.getWork_dep().trim()%>','<%=dto.getLast_position().trim()%>','<%=dto.getCharge_work().trim()%>','<%=dto.getRetire_reason().trim()%>');

	if('<%=arrlist.size()%>'>1){ 
		 document.historyFrm.employ_type['<%=i%>'].value='<%=dto.getEmploy_type()%>';
	}else{
		 document.historyFrm.employ_type.value='<%=dto.getEmploy_type()%>';
	}

</script>

<%
					i++;
		}
	}
%>
<!--입력ROW :: END-->
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
	}
</script>
<map name="Map" id="Map"><area shape="rect" coords="3,2,286,37" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageDefaultView');" /><area shape="rect" coords="304,3,420,36" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageHistoryView');" /><area shape="rect" coords="437,4,566,37" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageLicenseView');" /><area shape="rect" coords="583,4,716,37" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageAwardView');" /><area shape="rect" coords="4,41,134,74" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageLangView')" /><area shape="rect" coords="150,43,286,75" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageFamilyView')" /><area shape="rect" coords="307,42,420,76" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageCareerView')" /><area shape="rect" coords="440,42,566,75" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageEduView')" /><area shape="rect" coords="584,41,715,73" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageActiveView')" /><area shape="rect" coords="2,80,135,111" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageTrainView')" /><area shape="rect" coords="153,80,286,114" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageProjectView')" /><area shape="rect" coords="308,78,419,113" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageItroView')" /><area shape="rect" coords="442,77,716,117" href="javascript:goTab('<%= request.getContextPath() %>/B_Recruit.do?cmd=manageLastView')" /></map>
<%= comDao.getMenuAuth(menulist,"43") %>