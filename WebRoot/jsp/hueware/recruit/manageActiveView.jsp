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
<title>STEP9. 사회공헌및기여</title>
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
	function doAddRowData(history_code,start_ymd,end_ymd,activety_org,major_activety){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list" summary="STEP9. 사회공헌및기여"><colgroup><col width="17%" /><col width="30%" /><col width="*" /></colgroup><tr><td><input name="start_ymd" value="'+addDateFormatDefault(start_ymd)+'" maxlength="8" readOnly  class="text" size="9" title="활동시작일" style="width:67px;" /> ~ <input name="end_ymd" value="'+addDateFormatDefault(end_ymd)+'" maxlength="8" readOnly  class="text" size="9" title="활동종료일" style="width:67px;" /></td><td><input name="activety_org" title="활동기관명" style="width:317px;" readOnly  class="text"  value="'+activety_org+'" maxlength="25" size="18"  /></td><td><input name="major_activety" readOnly  class="text" title="주요활동" style="width:592px;"  value="'+major_activety+'" maxlength="500" size="62" /></td></tr></table>';
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
		newCell.innerHTML = '<table width="704" border="0" cellpadding="0" cellspacing="0"><tr><td width="160 height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input type="hidden" name="seqs"><input name="start_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"  size="9" height="20" /> ~ <input name="end_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"  size="9" height="20" /></td><td width="1" height="35" bgcolor="f3f8eb"></td><td width="140" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="activety_org" style="ime-mode:active" maxlength="25" size="18" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="400" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="major_activety" maxlength="500" style="ime-mode:active" size="62" height="20" /></td></tr></table>';

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
			
			alert('※ 추가 버튼을 통해 한건 이상 등록하셔야 합니다.\n 등록하실 내용이 없는경우 추가후 없는상태로 저장 하시기 바랍니다.');
			return;
	
		}

		if(confirm('저장 후 다음단계로 진행됩니다. \n계속하시겠습니까?') == false) {
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
<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
<h3><span>채</span>용관리상세정보</h3>
<div class="con recruitManage">
	<!-- 탭(step1 ~ step13) -->
	<ol class="stepTab step9on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
		<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li>
		<li><a href="javascript:goManageHistory();">STEP2. 학력사항</a></li>
		<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. 자격/면허사항</a></li>
		<li><a href="javascript:goManageAwardView();">STEP4. 수상사항</a></li>
		<li><a href="javascript:goManageLangView();">STEP5. 어학사항</a></li>
		<li><a href="javascript:goManageFamilyView();">STEP6. 가족사항</a></li>
		<li><a href="javascript:goManageCareerView();">STEP7. 경력사항</a></li>
		<li><a href=javascript:goManageEduView();>STEP8. 교육사항</a></li>
		<li class="step9 on"><a href="javascript:goManageActiveView();">STEP9. 사회공헌및기여</a></li><!-- STEP에 맞춰 class="on" 추가 -->
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
	<legend>STEP9. 사회공헌및기여</legend>
	<table class="tbl_type tbl_type_list" summary="STEP9. 사회공헌및기여">
		<colgroup>
			<col width="17%" />
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<thead>
		<tr>
			<th colspan="3" class="title">STEP9. 사회공헌및기여</th>
		</tr>
		<tr>
			<th><label for="">활동기간(년/월/일)</label></th>
			<th><label for="">활동기관명</label></th>
			<th><label for="">주요활동</label></th>
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
<!--입력ROW :: END-->
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>