<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.common.recruit.IntroDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    String message =StringUtil.nvl((String)model.get("message"),"");
	String apply_code = (String)model.get("apply_code");
	IntroDTO introDto = (IntroDTO)model.get("introDto");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>STEP12. 자기소개</title>
<script>
    document.onkeydown = function() {
		if (event.keyCode == 116) {
			event.keyCode = 505;
		}
		if (event.keyCode == 505) {
			return false;
		}
	}
	
	function tempSave(){
		
		var frm=document.historyFrm;
		
		if(confirm('임시로 저장하시겠습니까?') == false) {
				return;
		}

		frm.cmd.value="introTempSave";
		frm.submit();

	}
	function Previous(){
		var frm=document.historyFrm;
		frm.cmd.value="projectInfoView";
		frm.submit();

	}
	function nextStep(){
	   
	    var frm=document.historyFrm;

		if(confirm('저장 후 다음단계로 진행됩니다. \n계속하시겠습니까?') == false) {
				return;
		}

		frm.cmd.value="introSaveNext";
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
				<ol class="stepTab step12on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
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
					<li class="step12 on"><a href="javascript:goManageItroView();">STEP12. 자기소개</a></li><!-- STEP에 맞춰 class="on" 추가 -->
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
						<legend>STEP12. 자기소개</legend>
						<table class="tbl_type tbl_type_list" summary="STEP12. 자기소개">
							<thead>
							<tr>
								<th class="title">STEP12. 자기소개</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<th><label for="">인생의 Role Model이 있다면 누구인지와 이유를 설명하세요.(없다면 작성하지 않아도 됩니다.)</label></th>
							</tr>
							<tr>
								<td><textarea name="introduce1" readOnly title="Role Model" style="ime-mode:active;width:1156px;height:96px;"><%=StringUtil.nvl(introDto.getIntroduce1(),"")%></textarea></td>
							</tr>
							<tr>
								<th><label for="">가장 최근에 읽은책 이름과 저자 그리고 읽은 후 자신의 느낀점을 적어보세요.</label></th>
							</tr>
							<tr>
								<td><textarea name="introduce2" readOnly title="가장 최근에 읽은책" style="ime-mode:active;width:1156px;height:96px;"><%=StringUtil.nvl(introDto.getIntroduce2(),"")%></textarea></td>
							</tr>
							<tr>
								<th><label for="">당신은 어떤 사람입니까?(자기자신을 분석해 보세요.)</label></th>
							</tr>
							<tr>
								<td><textarea name="introduce3" readOnly title="당신은 어떤 사람입니까?" style="ime-mode:active;width:1156px;height:96px;"><%=StringUtil.nvl(introDto.getIntroduce3(),"")%></textarea></td>
							</tr>
							</tbody>
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
	}
</script>
<%= comDao.getMenuAuth(menulist,"43") %>