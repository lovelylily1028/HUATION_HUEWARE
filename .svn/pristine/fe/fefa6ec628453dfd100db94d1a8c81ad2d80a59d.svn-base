<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.FamilyDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<FamilyDTO> arrlist = (ArrayList)model.get("historyList");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP6. 가족사항</title>
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
	function doAddRowData(history_code,name,relation,birth_ymd,workplace){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list" summary="STEP6. 가족사항"><colgroup><col width="20%" /><col width="15%" /><col width="12%" /><col width="10%" /><col width="*" /></colgroup><thead><tr><td><input name="name" readOnly  class="text"  value="'+name+'" title="성명" style="width:197px;" maxlength="10"size="15" /></td><td><input name="relation"readOnly  class="text"   value="'+relation+'" title="관계" style="width:137px;" maxlength="5" size="15" /></td><td><input name="birth_ymd" value="'+addDateFormatDefault(birth_ymd)+'" maxlength="8"  readOnly  class="text"  size="12" title="생년월일" style="width:101px;" /></td><td><select name="cohabit_yn" disabled title="동거여부선택" style="width:88px;" id="select2"><option selected="selected" value="01">동거</option><option value="02">비동거</option></select></td><td><input name="workplace" readOnly  class="text"  value="'+workplace+'" title="근무처및직위" style="width:473px;"maxlength="50" size="45" /></td></tr></table>';
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
		newCell.innerHTML = '<table width="704" border="0" cellpadding="0" cellspacing="0"><tr><td width="110 height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input type="hidden" name="seqs"><input name="name" style="ime-mode:active" maxlength="10"  size="15" height="20" /></td><td width="1" height="35" bgcolor="f3f8eb"></td><td width="110" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="relation" style="ime-mode:active"  maxlength="5"  size="15" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="100" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="birth_ymd" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" size="12" height="20" /></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="80" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><select name="cohabit_yn" class="style2" id="select2"><option selected="selected" value="01">동거</option><option value="02">비동거</option></select></td><td width="1" height="35" align="left" valign="top" bgcolor="f3f8eb" style="border-bottom:#f3f8eb 1px solid"></td><td width="300" height="35" align="center" valign="middle" bgcolor="#FFFFFF" style="border-bottom:#f3f8eb 1px solid"><input name="workplace" style="ime-mode:active"  maxlength="50"  size="45" height="20" /></td></tr></table>';

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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.name[i].value)+'|'+fillSpace(frm.relation[i].value)+'|'+fillSpace(onlyNum(frm.birth_ymd[i].value))+'|'+fillSpace(frm.cohabit_yn[i].value)+'|'+fillSpace(frm.workplace[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.name.value)+'|'+fillSpace(frm.relation.value)+'|'+fillSpace(onlyNum(frm.birth_ymd.value))+'|'+fillSpace(frm.cohabit_yn.value)+'|'+fillSpace(frm.workplace.value);

		}

		frm.cmd.value="familyTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="langInfoView";
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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.name[i].value)+'|'+fillSpace(frm.relation[i].value)+'|'+fillSpace(onlyNum(frm.birth_ymd[i].value))+'|'+fillSpace(frm.cohabit_yn[i].value)+'|'+fillSpace(frm.workplace[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.name.value)+'|'+fillSpace(frm.relation.value)+'|'+fillSpace(onlyNum(frm.birth_ymd.value))+'|'+fillSpace(frm.cohabit_yn.value)+'|'+fillSpace(frm.workplace.value);

		}

		frm.cmd.value="familySaveNext";
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

<body   marginheight=0 marginwidth=0 topmargin=0 leftmargin=0>
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
	<ol class="stepTab step6on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
		<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li>
		<li><a href="javascript:goManageHistory();">STEP2. 학력사항</a></li>
		<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. 자격/면허사항</a></li>
		<li><a href="javascript:goManageAwardView();">STEP4. 수상사항</a></li>
		<li><a href="javascript:goManageLangView();">STEP5. 어학사항</a></li>
		<li class="on"><a href="javascript:goManageFamilyView();">STEP6. 가족사항</a></li><!-- STEP에 맞춰 class="on" 추가 -->
		<li><a href="javascript:goManageCareerView();">STEP7. 경력사항</a></li>
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
<legend>STEP6. 가족사항</legend>
<table class="tbl_type tbl_type_list" summary="STEP6. 가족사항">
	<colgroup>
		<col width="20%" />
		<col width="15%" />
		<col width="12%" />
		<col width="10%" />
		<col width="*" />
	</colgroup>
	<thead>
	<tr>
		<th colspan="5" class="title">STEP6. 가족사항</th>
	</tr>
	<tr>
		<th><label for="">성명</label></th>
		<th><label for="">관계</label></th>
		<th><label for="">생년월일</label></th>
		<th><label for="">동거여부</label></th>
		<th><label for="">근무처및직위</label></th>
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
<!-- 가이드텍스트 -->
<p class="guide_txt">직계존속비속만 기재하십시오.</p>
<!-- //가이드텍스트 -->

<!-- Bottom 버튼영역 -->
<div class="Bbtn_areaC">
<a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
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
			FamilyDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getName().trim()%>','<%=dto.getRelation().trim()%>','<%=dto.getBirth_ymd().trim()%>','<%=dto.getWorkplace().trim()%>');

	if('<%=arrlist.size()%>'>1){ 
		 document.historyFrm.cohabit_yn['<%=i%>'].value='<%=dto.getCohabit_yn()%>';
	}else{
		 document.historyFrm.cohabit_yn.value='<%=dto.getCohabit_yn()%>';
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
<%= comDao.getMenuAuth(menulist,"43") %>