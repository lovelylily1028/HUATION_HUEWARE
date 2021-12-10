<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.recruit.DefaultDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	CodeParam codeParam=null;

	DefaultDTO defaultDto  = (DefaultDTO)model.get("defaultDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	
	String[] r_field = StringUtil.getTokens(defaultDto.getRecruit_field(), "|");
	String career = StringUtil.nvl(defaultDto.getCareer(),"");
	
	String acheckd="";
	String bcheckd="";
	String ccheckd="";
	String dcheckd="";
	String echeckd="";
	String fcheckd="";
	String gcheckd="";
	String hcheckd="";
	String icheckd="";

	for(int i=0;i<r_field.length; i++){

		if(r_field[i].equals("01")){
			acheckd="checked";
		}else if(r_field[i].equals("02")){
			bcheckd="checked";
		}else if(r_field[i].equals("03")){
			ccheckd="checked";
		}else if(r_field[i].equals("04")){
			dcheckd="checked";
		}else if(r_field[i].equals("05")){
			echeckd="checked";
		}else if(r_field[i].equals("06")){
			fcheckd="checked";
		}else if(r_field[i].equals("07")){
			gcheckd="checked";
		}else if(r_field[i].equals("08")){
			hcheckd="checked";
		}else if(r_field[i].equals("09")){
			icheckd="checked";
		}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>STEP1. 일반지원사항/기본인적사항</title>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script>
	document.onkeydown = function() {
		if (event.keyCode == 116) {
			event.keyCode = 505;
		}
		if (event.keyCode == 505) {
			return false;
		}
	}
	 function onlyNum_v(val)
		{
		 var num = val;
		 var tmp = "";

		 for (var i = 0; i < num.length; i ++)
		 {
		  if (num.charAt(i) >= 0 && num.charAt(i) <= 9)
		   tmp = tmp + num.charAt(i);
		  else
		   continue;
		 }
		 return tmp;
	}
   function careerYN(){

		var obj=document.defaultFrm.careeryn;

		if(obj[1].selected==true){
			document.defaultFrm.career.value='02';
			document.getElementById("c_year").style.display='none';
			document.getElementById("c_text").style.display='none';
			document.getElementById("c_year_t").style.display='block';
			document.getElementById("c_text_t").style.display='block';
			document.getElementById("cursal").style.display='none';
			document.getElementById("cursalview").style.display='none';
			document.getElementById("cursaltext").style.display='none';
			document.getElementById("t_cursal").style.display='block';
			document.getElementById("t_cursalview").style.display='block';
			document.getElementById("t_cursaltext").style.display='block';
			document.defaultFrm.c_year.value='';
			document.defaultFrm.current_sal_view.value='';
			document.defaultFrm.current_sal.value='';
		}else{
			document.defaultFrm.career.value='01';
			document.getElementById("c_year").style.display='block';
			document.getElementById("c_text").style.display='block';
			document.getElementById("c_year_t").style.display='none';
			document.getElementById("c_text_t").style.display='none';
			document.getElementById("cursal").style.display='block';
			document.getElementById("cursalview").style.display='block';
			document.getElementById("cursaltext").style.display='block';
			document.getElementById("t_cursal").style.display='none';
			document.getElementById("t_cursalview").style.display='none';
			document.getElementById("t_cursaltext").style.display='none';
		}
   }
   function saleCntCal(form){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.defaultFrm;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}

		if (!isNumber(trim(v_obj.value))) {
			alert("숫자만 입력해 주세요.");
		} 
	
		var num=onlyNum_v(v_obj.value);

		v_obj.value = addCommaStr(num);

		obj.value = num;

		v_obj.focus();

	}
	function searchZipCode(formNm) {
		var name = "우편번호검색";
		var features = "width=467,height=500,scrollbars=yes,top=100,left=100,status";
		var popupWin = window.open("", name, features);
		var obj=eval('document.'+formNm);
		obj.target=name;
		obj.submit();
		centerSubWindow(popupWin,467, 500);
		popupWin.focus();
}

function centerSubWindow(winName, ww, wh){
        if (document.layers) {
            sw = screen.availWidth;
            sh = screen.availHeight;
        }
        if (document.all) {
            sw = screen.width;
            sh = screen.height;
        }

        w = (sw - ww)/2;
        h = (sh - wh)/2;
        winName.moveTo(w,h);
}   
function setAddr(){

	var obj=document.defaultFrm;

	if(obj.equals_addr.checked==true){
		obj.c_post.value=obj.j_post.value;
		obj.c_address.value=obj.j_address.value;
		obj.c_addr_detail.value=obj.j_addr_detail.value;
	}else{
		obj.c_post.value='';
		obj.c_address.value='';
		obj.c_addr_detail.value='';

	}

}
	function militaryYN(){

		var obj=document.defaultFrm.military;

		if(obj[2].selected==true){
			document.getElementById("military_t").style.display='block';
			document.getElementById("military_tt").style.display='block';
			document.getElementById("t_military_t").style.display='none';
			document.getElementById("t_military_tt").style.display='none';
		}else{
			document.getElementById("military_t").style.display='none';
			document.getElementById("military_tt").style.display='none';
			document.getElementById("t_military_t").style.display='block';
			document.getElementById("t_military_tt").style.display='block';
			document.defaultFrm.exemption.value='';
			
		}
   }
	 function veteransYN(){

		var obj=document.defaultFrm.veterans_yn;

		if(obj[0].selected==true){
			document.getElementById("veterans_t").style.display='none';
			document.getElementById("veterans_tt").style.display='none';
			document.getElementById("t_veterans_t").style.display='block';
			document.getElementById("t_veterans_tt").style.display='block';
			document.defaultFrm.veterans_no.value='';
		}else{
			document.getElementById("veterans_t").style.display='block';
			document.getElementById("veterans_tt").style.display='block';
			document.getElementById("t_veterans_t").style.display='none';
			document.getElementById("t_veterans_tt").style.display='none';
		}
   }
    function disabledYN(){

		var obj=document.defaultFrm.disabled_yn;

		if(obj[0].selected==true){
			document.getElementById("disabled_t").style.display='none';
			document.getElementById("disabled_tt").style.display='none';
			document.getElementById("t_disabled_t").style.display='block';
			document.getElementById("t_disabled_tt").style.display='block';
			document.defaultFrm.disabled_grade.value='';
		}else{
			document.getElementById("disabled_t").style.display='block';
			document.getElementById("disabled_tt").style.display='block';
			document.getElementById("t_disabled_t").style.display='none';
			document.getElementById("t_disabled_tt").style.display='none';
		}
   }
	 function preStep(){
	
		if(confirm('입사 지원서 작성을 중단 하시겠습니까? \n저장된 내용이 있으면 다음에 수정이 가능합니다.') == false) {
				return;
		}
		this.close();
   }
   function tempSave(){

		var frm=document.defaultFrm;

		if(frm.email.value.length==0){
			alert('이메일 정보가  없습니다.');
			return;
		}

		if(frm.passwd.value.length==0){
			alert('패스워드가 없습니다.');
			return;
		}
		if(frm.user_nm.value.length==0){
			alert('지원자 성명이 없습니다.');
			return;
		}

		if(frm.national_gb.value.length==0){
			alert('내/외국인 여부가 없습니다.');
			return;
		}
		if(frm.jumin_no.value.length==0){
			alert('주민번호가 없습니다.');
			return;
		}
		if(frm.recruit_no.value.length==0){
			alert('채용번호가 없습니다.');
			return;
		}
		if(frm.career.value.length==0){
			alert('경력구분이 없습니다.');
			return;
		}
		/*
		if(frm.wish_sal.value.length==0){
			alert('희망연봉이 없습니다.');
			return;
		}
		if(frm.current_sal.value.length==0){
			alert('현재연봉이 없습니다.');
			return;
		}
		if(frm.position.value.length==0){
			alert('희망직위가 없습니다.');
			return;
		}
		*/
		var recruit_field='';
		var cnt=9;
		for(i=0;i<cnt;i++){
			if(frm.recruitfield[i].checked==true){
				if(i==cnt-1){
					recruit_field+='0'+i;
				}else{
					recruit_field+='0'+i+'|';
				}
			}
		}
		if(recruit_field==''){
			alert('지원분야를 하나이상 선택하세요.');
			return;
		}else{
			frm.recruit_field.value=recruit_field;
		}
		/*
		if(frm.creed.value.length==0){
			alert('개인신념 및 신조가 없습니다.');
			return;
		}
		if(frm.h_user_nm.value.length==0){
			alert('지원자성명(한자)가 없습니다.');
			return;
		}
		*/
		if(frm.e_user_nm.value.length==0){
			alert('지원자성명(영문)이 없습니다.');
			return;
		}
		/*
		if(frm.english_nm.value.length==0){
			alert('지원자성명(영어이름)이 없습니다.');
			return;
		}
		*/
		if(frm.nationality.value.length==0){
			alert('국적이 없습니다.');
			return;
		}
		var handphone=frm.hand1.value+'-'+frm.hand2.value+'-'+frm.hand3.value;
		var homephone=frm.home1.value+'-'+frm.home2.value+'-'+frm.home3.value;
		var etcphone=frm.etc1.value+'-'+frm.etc2.value+'-'+frm.etc3.value;

		if(frm.hand2.value.length==0 || frm.hand3.value.length==0){
			alert('핸드폰 정보가 없습니다.');
			return;
		}else{
			frm.hand_phone.value=handphone;
		}
		
		frm.home_phone.value=homephone;
		frm.etc_phone.value=etcphone;
	/*
		if(frm.rriage_yn.value.length==0){
			alert('결혼여부가 없습니다.');
			return;
		}
		*/
		//frm.birth_day.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		frm.birth_day.value=onlyNum_v(frm.birth_day_view.value);
		if(frm.birth_day.value.length==0){
			alert('생년월일이 없습니다.');
			return;
		}
		if(frm.military.value.length==0){
			alert('병역사항이 없습니다.');
			return;
		}
		if(frm.military[2].selected==true){
			if(frm.exemption.value.length==0){
				alert('면제사유가 없습니다.');
				return;
			}
		}
		if(frm.photo.value.length==0){
			alert('사진정보가 없습니다.');
			return;
		}
		if(frm.j_post.value.length==0 || frm.j_address.value.length==0 || frm.j_addr_detail.value.length==0){
			alert('주민등록상 주소정보가 없습니다.');
			return;
		}
		if(frm.c_post.value.length==0 || frm.c_address.value.length==0 || frm.c_addr_detail.value.length==0){
			alert('현거주지 주소정보가 없습니다.');
			return;
		}
		if(frm.veterans_yn.value.length==0){
			alert('선택된 보훈대상 여부가 없습니다.');
			return;
		}
		if(frm.veterans_yn[1].selected==true){
			if(frm.veterans_no.value.length==0){
				alert('보훈번호가 없습니다.');
				return;
			}
		}
		if(frm.disabled_yn.value.length==0){
			alert('장애인 등록여부가 없습니다.');
			return;
		}
		if(frm.disabled_yn[1].selected==true){
			if(frm.disabled_grade.value.length==0){
				alert('장애등급이 없습니다.');
				return;
			}
		}
		if(confirm('임시로 저장하시겠습니까?') == false) {
				return;
		}
		
		frm.cmd.value="defaultTempSave";
		frm.submit();
   }

    function nextStep(){

		var frm=document.defaultFrm;

		if(frm.email.value.length==0){
			alert('이메일 정보가  없습니다.');
			return;
		}

		if(frm.passwd.value.length==0){
			alert('패스워드가 없습니다.');
			return;
		}
		if(frm.user_nm.value.length==0){
			alert('지원자 성명이 없습니다.');
			return;
		}

		if(frm.national_gb.value.length==0){
			alert('내/외국인 여부가 없습니다.');
			return;
		}
		if(frm.jumin_no.value.length==0){
			alert('주민번호가 없습니다.');
			return;
		}
		if(frm.recruit_no.value.length==0){
			alert('채용번호가 없습니다.');
			return;
		}
		if(frm.career.value.length==0){
			alert('경력구분이 없습니다.');
			return;
		}
		/*
		if(frm.wish_sal.value.length==0){
			alert('희망연봉이 없습니다.');
			return;
		}
		if(frm.current_sal.value.length==0){
			alert('현재연봉이 없습니다.');
			return;
		}
		if(frm.position.value.length==0){
			alert('희망직위가 없습니다.');
			return;
		}
		*/
		var recruit_field='';
		var cnt=9;
		for(i=0;i<cnt;i++){
			if(frm.recruitfield[i].checked==true){
				if(i==cnt-1){
					recruit_field+='0'+i;
				}else{
					recruit_field+='0'+i+'|';
				}
			}
		}
		if(recruit_field==''){
			alert('지원분야를 하나이상 선택하세요.');
			return;
		}else{
			frm.recruit_field.value=recruit_field;
		}
		/*
		if(frm.creed.value.length==0){
			alert('개인신념 및 신조가 없습니다.');
			return;
		}
		if(frm.h_user_nm.value.length==0){
			alert('지원자성명(한자)가 없습니다.');
			return;
		}
		*/
		if(frm.e_user_nm.value.length==0){
			alert('지원자성명(영문)이 없습니다.');
			return;
		}
		/*
		if(frm.english_nm.value.length==0){
			alert('지원자성명(영어이름)이 없습니다.');
			return;
		}
		*/
		if(frm.nationality.value.length==0){
			alert('국적이 없습니다.');
			return;
		}
		var handphone=frm.hand1.value+'-'+frm.hand2.value+'-'+frm.hand3.value;
		var homephone=frm.home1.value+'-'+frm.home2.value+'-'+frm.home3.value;
		var etcphone=frm.etc1.value+'-'+frm.etc2.value+'-'+frm.etc3.value;

		if(frm.hand2.value.length==0 || frm.hand3.value.length==0){
			alert('핸드폰 정보가 없습니다.');
			return;
		}else{
			frm.hand_phone.value=handphone;
		}
		
		frm.home_phone.value=homephone;
		frm.etc_phone.value=etcphone;
	/*
		if(frm.rriage_yn.value.length==0){
			alert('결혼여부가 없습니다.');
			return;
		}
		*/
		//frm.birth_day.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		frm.birth_day.value=onlyNum_v(frm.birth_day_view.value);
		if(frm.birth_day.value.length==0){
			alert('생년월일이 없습니다.');
			return;
		}
		if(frm.military.value.length==0){
			alert('병역사항이 없습니다.');
			return;
		}
		if(frm.military[2].selected==true){
			if(frm.exemption.value.length==0){
				alert('면제사유가 없습니다.');
				return;
			}
		}
		if(frm.photo.value.length==0){
			alert('사진정보가 없습니다.');
			return;
		}
		if(frm.j_post.value.length==0 || frm.j_address.value.length==0 || frm.j_addr_detail.value.length==0){
			alert('주민등록상 주소정보가 없습니다.');
			return;
		}
		if(frm.c_post.value.length==0 || frm.c_address.value.length==0 || frm.c_addr_detail.value.length==0){
			alert('현거주지 주소정보가 없습니다.');
			return;
		}
		if(frm.veterans_yn.value.length==0){
			alert('선택된 보훈대상 여부가 없습니다.');
			return;
		}
		if(frm.veterans_yn[1].selected==true){
			if(frm.veterans_no.value.length==0){
				alert('보훈번호가 없습니다.');
				return;
			}
		}
		if(frm.disabled_yn.value.length==0){
			alert('장애인 등록여부가 없습니다.');
			return;
		}
		if(frm.disabled_yn[1].selected==true){
			if(frm.disabled_grade.value.length==0){
				alert('장애등급이 없습니다.');
				return;
			}
		}
	
		if(confirm('저장 후 다음단계로 진행됩니다. \n계속하시겠습니까?') == false) {
				return;
		}

		frm.cmd.value="defaultSaveNext";
		frm.submit();
   }
   function goTab(url){

		var frm=document.defaultFrm;
		frm.action=url;
		frm.submit();

   }
   function goCancel(){
	
	var frm = document.defaultFrm;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitManageList';
	frm.submit();

}
   
   
   function goManageDefaultView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageDefaultView';
	   frm.submit();
   }
  
   function goManageHistory(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageHistoryView';
	   frm.submit();
   }
   
   function goManageLicenseView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageLicenseView';
	   frm.submit();
   }
   
   function goManageAwardView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageAwardView';
	   frm.submit();
   }
   
   function goManageLangView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageLangView';
	   frm.submit();
   }
   
   function goManageFamilyView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageFamilyView';
	   frm.submit();
   }
   
   function goManageCareerView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageCareerView';
	   frm.submit();
   }
   
   function goManageEduView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageEduView';
	   frm.submit();
   }
   
   function goManageActiveView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageActiveView';
	   frm.submit();
   }
   
   function goManageTrainView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageTrainView';
	   frm.submit();
   }
   
   function goManageProjectView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageProjectView';
	   frm.submit();
   }
   
   function goManageItroView(){
	   var frm = document.defaultFrm;
	   frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=manageItroView';
	   frm.submit();
   }
   
   function goManageLastView(){
	   var frm = document.defaultFrm;
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
<ol class="stepTab step1on"><!-- STEP에 맞춰 class설정 (ex : step1on) -->
	<li class="step1 on"><a href="javascript:goManageDefaultView();">STEP1. 일반지원사항/기본인적사항</a></li><!-- STEP에 맞춰 class="on" 추가 -->
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
	<li class="step13"><a href="javascript:goManageLastView();">STEP13. 입사지원서작성완료</a></li>
</ol>
<!-- //탭 -->
<!-- 등록 -->
<div class="info">
<form name="defaultFrm" method="post" >
<input type="hidden" name="cmd"/>
<input type="hidden" name="apply_code" value="<%= StringUtil.nvl(defaultDto.getApply_code(),"")%>"/>
<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>

<fieldset>
<legend>STEP1. 일반지원사항/기본인적사항</legend>

<table class="tbl_type" summary="STEP1. 일반지원사항/기본인적사항">
	<colgroup>
		<col width="20%" />
		<col width="*" />
		<col width="11%" />
	</colgroup>
	<tbody>
	<tr>
       <th colspan="3" class="title">STEP1. 일반지원사항/기본인적사항</th>
    </tr>
	<tr>
		<th colspan="3" class="title subtitle">일반지원사항</th>
	<tr>
		<th><label for="">지원자성명</label></th>
           <td colspan="2"><input type="text"name="user_nm" class="text"  readOnly   maxlength="20" title="지원자성명" style="width:200px;" value="<%= StringUtil.nvl(defaultDto.getUser_nm(),"")%>"  /></td>
    </tr>
	<tr>
		<th><label for="">경력구분 (해당분야1년이상)</label></th>
		<td colspan="2">
       	   <%  
		        codeParam = new CodeParam();
				codeParam.setType("select"); 
				codeParam.setStyleClass("td3");
				//codeParam.setFirst("전체");
				codeParam.setName("careeryn");
				codeParam.setSelected(career); 
				//codeParam.setEvent("javascript:careerYN();"); 
				out.print(CommonUtil.getCodeList(codeParam,"H02")); 
			%>
		  <script>
		     document.defaultFrm.careeryn.disabled=true;
		  </script>
          <input name="c_year" readOnly style="width:100px;" class="text" size="13" maxlength="2" value="<%=  StringUtil.nvl(defaultDto.getC_year(),"")%>"  /> 년</td>
     </tr>
      <tr>
      	<th><label for="">희망연봉</label></th>
		<input type="hidden" name="wish_sal"  value="<%= defaultDto.getWish_sal()%>" />
        <td colspan="2"><input type="text" name="wish_sal_view" title="희망연봉" style="width:200px;" class="text"  size="10" readOnly maxlength="8" value="<%=NumberUtil.getPriceFormat(defaultDto.getWish_sal())%>" /> 만원</td>
	</tr>
	<tr>
		<th id="cursal"><label for="">현재(최종)연봉 (경력만해당)</label></th>
		<td id="cursalview" colspan="2"><input type="hidden" name="current_sal"  value="<%= defaultDto.getCurrent_sal()%>" />
        <input name="current_sal_view" class="text" style="width:200px;" size="10" readOnly  maxlength="8"  value="<%=NumberUtil.getPriceFormat(defaultDto.getCurrent_sal())%>" /> 만원</td>
	</tr>
	<tr>
		<th><label for="">희망직위</label></th>
        <td colspan="2">
             <%  
		        codeParam = new CodeParam();
				codeParam.setType("select"); 
				codeParam.setStyleClass("style2");
				codeParam.setFirst("선택");
				codeParam.setName("position");
				codeParam.setSelected(StringUtil.nvl(defaultDto.getPosition(),"")); 
				//codeParam.setEvent(""); 
				out.print(CommonUtil.getCodeList(codeParam,"H04")); 
			 %>
		   <script>
		     document.defaultFrm.position.disabled=true;
		  </script>
      </tr>
      <tr>
          <th><label for="">지원분야 (다중선택가능)</label></th>
          <td colspan="2"><input name="recruitfield" type="checkbox" <%=acheckd%> value="01" checked="checked" disabled class="check md0" title="R&amp;D" /><label for="">R&amp;D</label><input type="checkbox" name="recruitfield" <%=bcheckd%> value="02" disabled class="check" title="기술지원"/><label for="">기술지원</label><input type="checkbox" name="recruitfield" <%=ccheckd%> value="03" disabled class="check" title="조직관리"/><label for="">조직관리</label><input type="checkbox" name="recruitfield" <%=dcheckd%> value="04" disabled class="check" title="기획"/><label for="">기획</label><input type="checkbox" name="recruitfield" <%=echeckd%> value="05" disabled class="check" title="디자인"/><label for="">디자인</label><input type="checkbox" name="recruitfield" <%=fcheckd%> value="06" disabled class="check" title="영업"/><label for="">영업</label><input type="checkbox" name="recruitfield" <%=gcheckd%> value="07" disabled class="check" title="마케팅"/><label for="">마케팅</label><input type="checkbox" name="recruitfield" <%=hcheckd%> value="08" disabled class="check" title="재무"/><label for="">재무</label><input type="checkbox" name="recruitfield" <%=icheckd%> value="09" disabled class="check" title="고객지원"/><label for="">고객지원</label></td>
       </tr>
       <tr>
       		<th><label for="">개인신념및신조</label></th>
            <td colspan="2"><textarea name="creed"  readOnly title="개인신념및신조" style="width:917px;height:41px;" class="td3" id="textarea" ><%=StringUtil.nvl(defaultDto.getCreed(),"")%></textarea></td>
       </tr>
       </tbody>
       <tbody>
       <tr>
			<th colspan="3" class="title subtitle">기본인적사항</th>
		</tr>
		<tr>
			<th><label for="">지원자성명</label></th>
			<td class="listT">
				<table class="tbl_type" summary="지원자성명(한글, 한자, 영문(여권표기), 영어이름)">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
			<tbody>
			<tr>
				<th><label for="">한글</label></th>
	            <td><input name=""  value="<%= StringUtil.nvl(defaultDto.getUser_nm(),"")%>" readOnly class="text"  title="한글" style="width:246px;"  /></td>
	            <th><label for="">영문 (여권표기)</label></th>
	            <td class="last"><input type="text" name="e_user_nm" readOnly  class="text"   title="영문 (여권표기)" style="width:247px;"  maxlength="20"  value="<%=StringUtil.nvl(defaultDto.getE_user_nm(),"")%>"/></td>
         	</tr>
         	<tr class="last">
         		<th><label for="">한자</label></th>
                <td><input type="text" name="h_user_nm" readOnly class="text" title="한자" style="width:246px;"  maxlength="5"  value="<%=StringUtil.nvl(defaultDto.getH_user_nm(),"")%>" /></td>
                <th><label for="">영어이름</label></th>
                <td class="last"><input name="english_nm" type="text" readOnly class="text" title="영어이름" style="width:247px;"  maxlength="20"  value="<%=StringUtil.nvl(defaultDto.getEnglish_nm(),"")%>"/></td>
             </tr>
         	 </tbody>
         	</table>
         	</td>  
         	<td rowspan="3" class="pic"> <!-- 지원자 사진 -->
         	<iframe class="pic_area" src="<%= request.getContextPath()%>/B_Recruit.do?cmd=photoForm&photo=<%= StringUtil.nvl(defaultDto.getPhoto(),"")%>"  frameborder="0" height="120" width="110" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></td>
		</tr>
		<tr>
			<th><label for="">주민등록번호 (외국인등록번호)</label></th>   
			 <td><%
				String jumin_no= StringUtil.nvl(defaultDto.getJumin_no(),"");
				int index=jumin_no.indexOf("-");
				String jumin1=jumin_no.substring(0,index);
				String jumin2=jumin_no.substring(index+1);
				%>
			<input type = "hidden" name = "jumin_no"   maxlength="14"  value="<%=jumin_no%>">
            <input type="text" name="jumin1" readOnly value="<%=jumin1%>" class="text" size="13" title="앞번호" style="width:80px;" />&nbsp;&nbsp;-&nbsp;&nbsp;<input name="jumin2" type="text" readOnly value="<%=jumin2%>" class="text" size="13" title="뒷번호" style="width:80px;" /></td>
        </tr>
        <tr>                                   
            <th><label for="">국적</label></th>
			<td><input type = "hidden" name = "national_gb"  maxlength="40"   value="<%= StringUtil.nvl(defaultDto.getNational_gb(),"")%>">
             	<input name="nationality" readOnly class="text" height="20" value="<%= StringUtil.nvl(defaultDto.getNationality(),"")%>" title="국적" style="width:300px;"  maxlength="25" /></td>
        </tr>
         <tr>
			<th><label for="">연락처</label></th>
			<td colspan="2" class="listT">
				<table class="tbl_type" summary="연락처(핸드폰, 집전화, 이메일, 기타)">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
					<tr>
                         <th><label for="">핸드폰</label></th>
						 <td><input type = "hidden" name = "hand_phone" value="<%=StringUtil.nvl(defaultDto.getHand_phone(),"")%>"  maxlength="20"  value="">
						 <%  
						        String handphone=StringUtil.nvl(defaultDto.getHand_phone(),"");
								int index2=handphone.indexOf("-");
								String hand1=handphone.substring(0,index2);
								String temphand=handphone.substring(index2+1);
								int index3=temphand.indexOf("-");
								String hand2=temphand.substring(0,index3);
								String hand3=temphand.substring(index3+1);

						        codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("style2");
								codeParam.setFirst("선택");
								codeParam.setName("hand1");
								codeParam.setSelected(hand1); 
								//codeParam.setEvent(""); 
								out.print(CommonUtil.getCodeList(codeParam,"H05")); 
							 %> - <input type="text" name="hand2" class="text" size="4" height="20" readOnly notNull dispName="휴대폰번호" value="<%=hand2%>"  > - <input type="text" name="hand3" size="4" height="20" class="text" value="<%=hand3%>" readOnly notNull maxlength="4" dispName="휴대폰번호" >
      				 	<script>
						   document.defaultFrm.hand1.disabled=true;
						</script>
						</td>
						<th><label for="">집전화</label></th>
						<input type = "hidden" name = "home_phone" value="<%=StringUtil.nvl(defaultDto.getHome_phone(),"")%>"  maxlength="20"  value="">
                        <td class="last">
						 <%  
							String homephone=StringUtil.nvl(defaultDto.getHome_phone(),"");
							int index5=homephone.indexOf("-");
							String home1=homephone.substring(0,index5);
							String temphome=homephone.substring(index5+1);
							int index6=temphome.indexOf("-");
							String home2=temphome.substring(0,index6);
							String home3=temphome.substring(index6+1);

					        codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("style2");
							codeParam.setFirst("선택");
							codeParam.setName("home1");
							codeParam.setSelected(home1); 
							//codeParam.setEvent(""); 
							out.print(CommonUtil.getCodeList(codeParam,"H06")); 
						 %></select> - <input type="text" name="home2" class="text" size="4" height="20" readOnly notNull dispName="집" value="<%=home2%>" > - <input type="text" value="<%=home3%>" name="home3" size="4" height="20" class="text" readOnly notNull maxlength="4" dispName="집" >
						 <script>
							     document.defaultFrm.home1.disabled=true;
						</script>
						</td>
                       </tr>
                       <tr class="last">
                       		<th><label for="">이메일</label></th>
                            <td><input name="email" readOnly value="<%= StringUtil.nvl(defaultDto.getEmail(),"")%>" class="text" size="35" title="이메일" style="width:292px;" /></td>
                            <th><label for="">기타</label></th>
							   <%  
										String etcphone=StringUtil.nvl(defaultDto.getEtc_phone(),"");
										int index7= etcphone.indexOf("-");
										String  etc1= etcphone.substring(0,index7);
										String tempetc= etcphone.substring(index7+1);
										int index8=tempetc.indexOf("-");
										String etc2=tempetc.substring(0,index8);
										String etc3=tempetc.substring(index8+1);
								%>
                                <td class="last"><input name="etc_phone" type="hidden" class="text" tabindex="11" height="20"  maxlength="20" value="<%=StringUtil.nvl(defaultDto.getEtc_phone(),"")%>"/><input name="etc1" value="<%=etc1%>" class="text" size="4" height="20"  maxlength="3" readOnly  />
                                                    -
                                                    <input name="etc2" value="<%=etc2%>" class="text" size="4" height="20" maxlength="4" readOnly  />
                                                    -
                                                    <input name="etc3" value="<%=etc3%>" class="text" size="4" height="20" maxlength="4" readOnly /></td>
                         </tr>
                         </tbody>
                        </table>
                        </td>
                       </tr>
                       <tr>
                           <th><label for="">결혼여부</label></th>
                           <td colspan="2"><select name="rriage_yn" disabled title="결혼여부선택" id="select3">
                              <option value="01">기혼</option>
                              <option value="02">미혼</option>
                            </select></td>
                            <script>
                            		document.defaultFrm.rriage_yn.value='<%=StringUtil.nvl(defaultDto.getRriage_yn(),"")%>';
                            </script>
                        </tr>
						<tr>
							<th><label for="">생년월일</label></th>
							<td colspan="2"><input type = "text" name = "birth_day_view" class="text"  size="15" title="생년월일" style="width:200px;" value="<%=DateTimeUtil.getDateType(1,defaultDto.getBirth_day(),"/")%>"  maxlength="10"  readOnly  />
							</td>
                        </tr>
                        <tr>
                             <th><label for="">병역사항</label></th>
                             <td colspan="2" class="listT">
									<table class="tbl_type" summary="병역사항(병역사항, 면제사유)">
										<colgroup>
											<col width="15%" />
											<col width="35%" />
											<col width="15%" />
											<col width="35%" />
										</colgroup>
										<tbody>
										<tr class="last">
											<th><label for="">병역사항</label></th>
                                            <td><%  
										        codeParam = new CodeParam();
												codeParam.setType("select"); 
												codeParam.setStyleClass("style2");
												//codeParam.setFirst("선택");
												codeParam.setName("military");
												codeParam.setSelected(StringUtil.nvl(defaultDto.getMilitary(),"")); 
												codeParam.setEvent("javascript:militaryYN();"); 
												out.print(CommonUtil.getCodeList(codeParam,"H08")); 
											 %> 
												<script>
													 document.defaultFrm.military.disabled=true;
												</script>
												</td>
                                                <th><label for="">면제사유</label></th>
												  <td class="last"><input name="exemption" readOnly class="text" size="35" maxlength="25" value="<%= StringUtil.nvl(defaultDto.getExemption(),"")%>" title="면제사유" style="width:293px;"/></td>
                                         </tr>
                                              </tbody>
                                            </table>
                                    </td>
                           </tr>
                           <tr>
                               <th><label for="">주민등록상주소</label></th>
								<td colspan="2">
									<ul class="listD">
									<li class="first"><input type="text"  name="j_post" readOnly class="text"  size="15" title="우편번호" style="width:80px;" value="<%= StringUtil.nvl(defaultDto.getJ_post(),"")%>" /></li>
                                    <li><input type="text" name="j_address" value="<%= StringUtil.nvl(defaultDto.getJ_address(),"")%>" readOnly  class="text" size="35" title="기본주소" style="width:917px;" /></li>
                                    <li><input type="text" name="j_addr_detail"  readOnly class="text" size="30" class="text" title="상세주소" style="width:917px;"  maxlength="100" value="<%= StringUtil.nvl(defaultDto.getJ_addr_detail(),"")%>" /></li>
                                 	</ul>
								</td>
							</tr>
							<tr>
                               <th><label for="">거주지주소</label></th>
                               <td colspan="2">
								<ul class="listD">
									<li class="first"><input type="text" name="c_post" value="<%= StringUtil.nvl(defaultDto.getC_post(),"")%>" readOnly class="text" size="15" title="우편번호" style="width:80px;" /></li>
                                    <li><input type="text" name="c_address" value="<%= StringUtil.nvl(defaultDto.getC_address(),"")%>" readOnly  class="text" size="35"title="기본주소" style="width:917px;" /></li>
                                    <li><input type="text" name="c_addr_detail" readOnly class="text" size="30" title="상세주소" style="width:917px;"  maxlength="100" value="<%= StringUtil.nvl(defaultDto.getC_addr_detail(),"")%>" /></li>
                                 </ul>
								</td>
							</tr>
                            <tr>
                              <th><label for="">보훈대상</label></th>
                              <td colspan="2" class="listT">
									<table class="tbl_type" summary="보훈대상(보훈대상, 보훈번호)">
										<colgroup>
											<col width="15%" />
											<col width="35%" />
											<col width="15%" />
											<col width="35%" />
										</colgroup>
										<tbody>
										<tr class="last">
										<th><label for="">보훈대상</label></th>
											<td>
	                                            <%  
										        codeParam = new CodeParam();
												codeParam.setType("select"); 
												codeParam.setStyleClass("style2");
												//codeParam.setFirst("선택");
												codeParam.setName("veterans_yn");
												codeParam.setSelected(StringUtil.nvl(defaultDto.getVeterans_yn(),"")); 
												codeParam.setEvent("javascript:veteransYN();"); 
												out.print(CommonUtil.getCodeList(codeParam,"H09")); 
											 	%>
												<script>
													     document.defaultFrm.veterans_yn.disabled=true;
												</script>
											</td>
                                            <th><label for="">보훈번호</label></th>
											<td class="last"><input type="text" name="veterans_no"readOnly  class="text" title="보훈번호" style="width:293px;"  maxlength="25"  value="<%= StringUtil.nvl(defaultDto.getVeterans_no(),"")%>" /></td>
                                          </tr>
                                          </tbody>
                                      </table>
                                      </td>
                                      </tr>
                                      <tr>
                                         <th><label for="">장애인등록여부</label></th>
										<td colspan="2" class="listT">
											<table class="tbl_type" summary="장애인등록여부(장애인등록여부, 장애등급)">
												<colgroup>
													<col width="15%" />
													<col width="35%" />
													<col width="15%" />
													<col width="35%" />
												</colgroup>
												<tbody>
												<tr class="last">
												<th><label for="">장애인등록여부</label></th>
                                                    <td><%  
													        codeParam = new CodeParam();
															codeParam.setType("select"); 
															codeParam.setStyleClass("style2");
															//codeParam.setFirst("선택");
															codeParam.setName("disabled_yn");
															codeParam.setSelected(StringUtil.nvl(defaultDto.getDisabled_yn(),"")); 
															codeParam.setEvent("javascript:disabledYN();"); 
															out.print(CommonUtil.getCodeList(codeParam,"H10")); 
														 %>
                                                  
												 	<script>
													     document.defaultFrm.disabled_yn.disabled=true;
													</script>
													</td>
                                                    <th><label for="">장애등급</label></th>
													 <td class="last"><input name="disabled_grade" readOnly class="text" title="장애등급" style="width:293px;"  maxlength="25"  value="<%= StringUtil.nvl(defaultDto.getDisabled_grade(),"")%>" /></td>
                                                </tr>
                                                </tbody>
                                              </table>
                                              </td>
                                             </tr>
                                             </tbody>
                                           </table>
                                         </fieldset>
                                         </form>
                                       </div>
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
<script>
careerYN();
militaryYN();
veteransYN();
disabledYN();
</script>
<%= comDao.getMenuAuth(menulist,"43") %>