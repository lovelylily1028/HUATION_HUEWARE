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
<title>STEP13. 입사지원서작성완료</title>
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
			result='(불합격)';
		}else if (frm.result_state.value=='S'){
			result='(합격)';
		}else{
			result='(대기)';
		}
		
		if(confirm('입사지원 결과를'+result+'으로 저장 하시겠습니까?\n저장하시면 최종 입사지원에 대한 결과가 반영됩니다.') == false) {
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
			<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
			<h3><span>채</span>용관리상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con recruitManage">
				<!-- 탭(step1 ~ step13) -->
				<ol class="stepTab step13on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
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
					<li class="step11"><a href="javascript:goManageProjectView();">STEP11. 프로젝트수행경력</a></li>
					<li class="step12"><a href="javascript:goManageItroView();">STEP12. 자기소개</a></li>
					<li class="step13 on"><a href="javascript:goManageLastView();">STEP13. 입사지원서작성완료</a></li><!-- STEP에 맞춰 class="on" 추가 -->
				</ol>
				<!-- //탭 -->
				<!-- 등록 -->
				<div class="info">
					<form name="historyFrm" method="post" action="<%= request.getContextPath()%>/B_Recruit.do">
					<input type="hidden" name="cmd">
					<input type="hidden" name="apply_code" value="<%=apply_code%>">
					<input type = "hidden" name = "curPage" value="<%=curPage%>">
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
					<fieldset>
						<legend>STEP13. 입사지원서작성완료</legend>
						<table class="tbl_type tbl_type_list" summary="STEP13. 입사지원서작성완료">
							<thead>
							<tr>
								<th class="title">STEP13. 입사지원서작성완료</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td class="step13_area"><strong class="guide_txt">입사 지원서 작성이 완료되었습니다.<br />작성된 내용에 대해 지원결과를 저장하시면 합격여부가 반영됩니다.</strong><br /><label for=""><strong>합격여부</strong></label>&nbsp;&nbsp;<%
									CodeParam codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("style2");
									//codeParam.setFirst("선택");
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
				<!-- //등록 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:applySave();" class="btn_type02"><span>저장</span></a><a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
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
<script>
	if('<%=message%>'!=''){

		alert('<%=message%>');
		this.close();
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>