<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.HistoryDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	ArrayList<HistoryDTO> arrlist = (ArrayList)model.get("historyList");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<title>STEP2. 학력사항</title>
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
	function doAddRowData(history_code,school_nm,start_ym,grad_ym,major,credit){

		defaultText.style.display='none';

		var rowCnt = contentId.rows.length;

		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
		
		var newCell = newRow.insertCell();
		 newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="*" /><col width="12%" /><col width="12%" /><col width="25%" /><col width="10%" /><col width="10%" /></colgroup><tbody><tr><td><input name="school_nm" readOnly  class="text" size="33" title="학교명" style="width:329px;"  maxlength="20" value="'+school_nm+'" /></td><td><input name="start_ym" readOnly  class="text" size="10" title="입학년월" style="width:101px;" value="'+addYmFormatDefault(start_ym)+'"  maxlength="6" onKeyUp="if(this.value.length==6) addYmFormat(this);" /></td><td><input name="grad_ym" readOnly  class="text" size="11" title="졸업(예정)년월" style="width:100px;" value="'+addYmFormatDefault(grad_ym)+'"  maxlength="6" onKeyUp="if(this.value.length==6) addYmFormat(this);" /></td><td><input name="major" readOnly  class="text" size="20" title="전공(세부전공)" style="width:257px;" value="'+major+'"  maxlength="15" /></td><td><input name="credit" readOnly  class="text" size="6" title="학점" style="width:77px;" value="'+credit+'"  maxlength="5" /></td><td><select name="grad_gb" disabled  title="졸업구분선택" style="width:89px;" ><option value="01">졸업</option><option value="02">졸업예정</option><option value="03">휴학</option><option value="04">재학</option><option value="05">수료</option><option value="06">중퇴/자퇴</option></select></td></tr></tbody></table>';


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
		newCell.innerHTML = '<input type="hidden" name="seqs"><table class="tbl_type tbl_type_list"><colgroup><col width="*" /><col width="12%" /><col width="12%" /><col width="25%" /><col width="10%" /><col width="10%" /></colgroup><tbody><tr><td><input name="school_nm" class="text" size="33" title="학교명" style="width:329px;"  maxlength="20" /></td><td><input name="start_ym" class="text" size="10" title="입학년월" style="width:101px;" maxlength="6" onKeyUp="if(this.value.length==6) addYmFormat(this);" /></td><td><input name="grad_ym" class="text" size="11" title="졸업(예정)년월" style="width:100px;" maxlength="6" onKeyUp="if(this.value.length==6) addYmFormat(this);" /></td><td><input name="major" class="text" size="20" title="전공(세부전공)" style="width:257px;" maxlength="15" /></td><td><input name="credit" class="text" size="6" title="학점" style="width:77px;" maxlength="5" /></td><td><select name="grad_gb" title="졸업구분선택" style="width:89px;" ><option value="01">졸업</option><option value="02">졸업예정</option><option value="03">휴학</option><option value="04">재학</option><option value="05">수료</option><option value="06">중퇴/자퇴</option></select></td></tr></tbody></table>';
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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.school_nm[i].value)+'|'+fillSpace(onlyNum(frm.start_ym[i].value))+'|'+fillSpace(onlyNum(frm.grad_ym[i].value))+'|'+fillSpace(frm.major[i].value)+'|'+fillSpace(frm.credit[i].value)+'|'+fillSpace(frm.grad_gb[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.school_nm.value)+'|'+fillSpace(onlyNum(frm.start_ym.value))+'|'+fillSpace(onlyNum(frm.grad_ym.value))+'|'+fillSpace(frm.major.value)+'|'+fillSpace(frm.credit.value)+'|'+fillSpace(frm.grad_gb.value);

		}

		frm.cmd.value="historyTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="defaultInfoView";
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

				frm.seqs[i].value='<%=apply_code%>|'+fillSpace(frm.school_nm[i].value)+'|'+fillSpace(onlyNum(frm.start_ym[i].value))+'|'+fillSpace(onlyNum(frm.grad_ym[i].value))+'|'+fillSpace(frm.major[i].value)+'|'+fillSpace(frm.credit[i].value)+'|'+fillSpace(frm.grad_gb[i].value);
			}

		}else{

			frm.seqs.value='<%=apply_code%>|'+fillSpace(frm.school_nm.value)+'|'+fillSpace(onlyNum(frm.start_ym.value))+'|'+fillSpace(onlyNum(frm.grad_ym.value))+'|'+fillSpace(frm.major.value)+'|'+fillSpace(frm.credit.value)+'|'+fillSpace(frm.grad_gb.value);

		}

		frm.cmd.value="historySaveNext";
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
			<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
			<h3><span>채</span>용관리상세정보</h3>
			<div class="con recruitManage">
				<!-- 탭(step1 ~ step13) -->
				<ol class="stepTab step2on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
					<li class="step1"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li><!-- STEP에 맞춰 class="on" 추가 -->
					<li class="on"><a href="javascript:goManageHistory();">STEP2. 학력사항</a></li>
					<li class="step3"><a href="javascript:goManageLicenseView();">STEP3. 자격/면허사항</a></li>
					<li><a href="javascript:goManageAwardView();">STEP4. 수상사항</a></li>
					<li><a href="javascript:goManageLangView();">STEP5. 어학사항</a></li>
					<li><a href="javascript:goManageFamilyView();">STEP6. 가족사항</a></li>
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
					<form name="historyFrm" method="post" >
					<input type="hidden" name="cmd">
					<input type="hidden" name="apply_code" value="<%= apply_code%>">
					<input type = "hidden" name = "curPage" value="<%=curPage%>">
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
					<fieldset>
						<legend>STEP2. 학력사항</legend>
						<table class="tbl_type tbl_type_list" summary="STEP2. 학력사항 타이틀">
							<colgroup>
								<col width="*" />
								<col width="12%" />
								<col width="12%" />
								<col width="25%" />
								<col width="10%" />
								<col width="10%" />
							</colgroup>
							<thead>
							<tr>
								<th colspan="6" class="title">STEP2. 학력사항</th>
							</tr>
							<tr>
								<th><label for="">학교명</label></th>
								<th><label for="">입학년월</label></th>
								<th><label for="">졸업(예정)년월</label></th>
								<th><label for="">전공(세부전공)</label></th>
								<th><label for="">학점</label></th>
								<th><label for="">졸업구분</label></th>
							</tr>
							</thead>
						</table>
						<table id="defaultText"></table>
						<table id="contentId"></table>
					</fieldset>
					</form>
				</div>
				<!-- //등록 -->
				<!-- 가이드텍스트 -->
				<p class="guide_txt">고등학교부터 기재</p>
				<!-- //가이드텍스트 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
				<!-- //Bottom 버튼영역 -->
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
			HistoryDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getSchool_nm().trim()%>','<%=dto.getStart_ym().trim()%>','<%=dto.getGrad_ym().trim()%>','<%=dto.getMajor().trim()%>','<%=dto.getCredit().trim()%>');
	
	if('<%=arrlist.size()%>'>1){ 
		 document.historyFrm.grad_gb['<%=i%>'].value='<%=dto.getGrad_gb()%>';
	}else{
		 document.historyFrm.grad_gb.value='<%=dto.getGrad_gb()%>';
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