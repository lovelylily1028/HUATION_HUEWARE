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
<title>STEP11. 프로젝트수행경력</title>
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
	function doAddRowData(history_code,start_ymd,end_ymd,project_nm,order_org,proc_org,role,project_detail){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="17%" /><col width="*" /><col width="20%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><th><label for="">프로젝트기간(년월일)</label></th><th><label for="">프로젝트명</label></th><th><label for="">발주처</label></th><th><label for="">수행시소속기관명</label></th><th><label for="">역할</label></th></tr><tr><td><input type="text" name="start_ymd" value="'+addDateFormatDefault(start_ymd)+'" maxlength="8" readOnly class="text" title="프로젝트시작일" style="width:67px;" /> ~ <input type="text" name="end_ymd" value="'+addDateFormatDefault(end_ymd)+'" maxlength="8" readOnly class="text" title="프로젝트종료일" style="width:67px;" /></td><td><input type="text" name="project_nm" readOnly value="'+project_nm+'" class="text" title="프로젝트명" style="ime-mode:active;width:233px;" maxlength="50" tabindex="8" /></td><td><input type="text" name="order_org" readOnly value="'+order_org+'" class="text" title="발주처" style="ime-mode:active;width:196px;" maxlength="20" tabindex="8" /></td><td><input type="text" name="proc_org" readOnly value="'+proc_org+'" class="text" title="수행시소속기관명" style="ime-mode:active;width:197px;" maxlength="20" tabindex="8" /></td><td><input type="text" name="role" readOnly value="'+role+'" class="text" title="역할" style="ime-mode:active;width:197px;" maxlength="10" tabindex="8" /></td></tr><tr><th colspan="5"><label for="">프로젝트수행상세내용</label></th></tr><tr><td colspan="5"><textarea name="project_detail" readOnly id="textarea" title="프로젝트수행상세내용" style="ime-mode:active;width:1156px;height:192px;">'+project_detail.split("<br>").join("\r\n")+'</textarea></td></tr></tbody></table>';

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
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="17%" /><col width="*" /><col width="20%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><th><label for="">프로젝트기간(년월일)</label></th><th><label for="">프로젝트명</label></th><th><label for="">발주처</label></th><th><label for="">수행시소속기관명</label></th><th><label for="">역할</label></th></tr><tr><td><input type="text" name="start_ymd" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" class="text" title="프로젝트시작일" style="width:67px;" /> ~ <input name="end_ymd" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" class="text" title="프로젝트종료일" style="width:67px;" /></td><td><input name="project_nm" maxlength="50" tabindex="8" class="text" title="프로젝트명" style="ime-mode:active;width:233px;" /></td><td><input name="order_org" style="ime-mode:active" maxlength="20" tabindex="8" class="text" title="발주처" style="ime-mode:active;width:196px;" /></td><td><input name="proc_org"  style="ime-mode:active" maxlength="20" tabindex="8" class="text" title="수행시소속기관명" style="ime-mode:active;width:197px;" /></td><td><input name="role" style="ime-mode:active" maxlength="10" tabindex="8" class="text" title="역할" style="ime-mode:active;width:197px;" /></td></tr><tr><th colspan="5"><label for="">프로젝트수행상세내용</label></th></tr><tr><td colspan="5"><textarea name="project_detail" id="textarea" title="프로젝트수행상세내용" style="ime-mode:active;width:1156px;height:192px;"></textarea></td></tr></tbody></table>';

	}


	/*
	*	테이블 row 삭제
	*/
	function doDeleteRow(){
		
		if(confirm('로우 삭제시 저장되지 않은 복구가 불가능 합니다.\n삭제하시겠습니까?') == false) {
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
			
			alert('※ 추가 버튼을 통해 한건 이상 등록하셔야 합니다.\n 등록하실 내용이 없는경우 추가후 없는상태로 저장 하시기 바랍니다.');
			return;
	
		}

		if(confirm('저장 후 다음단계로 진행됩니다. \n계속하시겠습니까?') == false) {
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
			<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
			<h3><span>채</span>용관리상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con recruitManage">
				<!-- 탭(step1 ~ step13) -->
				<!-- 탭(step1 ~ step13) -->
				<ol class="stepTab step11on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
					<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li>
					<li><a href="javascript:goManageHistory();">STEP2. 학력사항</a></li>
					<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. 자격/면허사항</a></li>
					<li><a href="javascript:goManageAwardView();">STEP4. 수상사항</a></li>
					<li><a href="javascript:goManageLangView();">STEP5. 어학사항</a></li>
					<li><a href="javascript:goManageFamilyView();">STEP6. 가족사항</a></li>
					<li><a href="javascript:goManageCareerView();">STEP7. 경력사항</a></li>
					<li><a href="javascript:goManageEduView();">STEP8. 교육사항</a></li>
					<li class="step9"><a href="javascript:goManageActiveView();">STEP9. 사회공헌및기여</a></li>
					<li class="step10"><a href="javascript:goManageTrainView();">STEP10. 해외여행및연수</a></li>
					<li class="step11 on"><a href="javascript:goManageProjectView();">STEP11. 프로젝트수행경력</a></li><!-- STEP에 맞춰 class="on" 추가 -->
					<li class="step12"><a href="javascript:goManageItroView();">STEP12. 자기소개</a></li>
					<li class="step13"><a href="javascript:goManageLastView();">STEP13. 입사지원서작성완료</a></li>
				</ol>
				<!-- //탭 -->
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
						<legend>STEP11. 프로젝트수행경력</legend>
						<table class="tbl_type tbl_type_list" summary="STEP11. 프로젝트수행경력">
							<thead>
							<tr>
								<th class="title">STEP11. 프로젝트수행경력</th>
							</tr>
							</thead>
						</table>
						<!-- 타이틀 :: START -->
						<table class="tbl_type tbl_type_list" id="defaultText">
							<tr>
								<td class="text_l"><span class="guide_txt">* 추가 버튼을 통해 한건 이상 등록하셔야 합니다. 등록하실 내용이 없는경우 추가후 없는상태로 저장 하시기 바랍니다.</span></td>
							</tr>
						</table>
						<!-- //타이틀 :: END -->
						<!-- 추가ROW :: START -->
						<table id="contentId">
						</table>
						<!-- //추가ROW :: END -->
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
<!--입력ROW :: END-->
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>