<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>메뉴권한 관리</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<%-- <link href="<%=request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css" /> --%>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<script>

	var observer;//처리중
	//초기함수
	function init() {
	
		openWaiting( );
	
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}
	
	//조회
	function goSearch(){
		
		var obj=document.UserSearchFrm;
		var uid=document.UserSearchFrm.UserID.value;
		var invalid = ' ';	//공백 체크
		
		if(obj.UserID.value=='' || obj.UserID.value.indexOf(invalid) > -1){
			alert('조회할 ID를 입력해 주세요');
			obj.UserID.value="";
			obj.UserID.focus();
			return;
		}
		//openWaiting( );
		obj.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree&UserID='+uid;
		obj.target="grouptree";
		obj.submit();
		
	}
	
	//엔터처리
	function captureReturnKey(e) {
		 if(e.keyCode==13 && e.srcElement.type != 'textarea')
		 //return false;
		 goSearch();
	}

	//권한저장
	function goAuthSave(){
	
	var frm=document.UserSearchFrm;
	var userfrm = grouptree.treeFrm;
	var menufrm = menutree.treeFrm;
	var users =eval("grouptree.document.all.fontId");
	var menus =eval("menutree.document.all.fontId"); 
	var checkYN;
	var checkucnt=0;
	var checkmcnt=0;
	
	//선택여부 판단
	if(userfrm.checkName.length>1){
		for(i=0;i<userfrm.checkName.length;i++){
			if(userfrm.checkName[i].checked==true){
				if(users[i].title!=''){
					checkucnt++;
				}
			}
		}
	}else{
		if(userfrm.checkName.checked==true){
			if(users[i].title!=''){
				checkucnt++;
			}
		}
	}
	
	if(checkucnt==0){
		alert('선택된 사용자 정보가 없습니다.');
		return;
	}
	
	//선택여부 판단
	if(menufrm.checkName.length>1){
		for(i=0;i<menufrm.checkName.length;i++){
			if(menufrm.checkName[i].checked==true){
				checkmcnt++;
			}
		}
	}else{
		if(userfrm.checkName.checked==true){
			checkmcnt++;
		}
	}
	
	if(checkmcnt==0){
		alert('선택된 메뉴 정보가 없습니다.');
		return;
	}
	
	
	if(confirm("선택된 내용으로 권한을 저장하시겠습니까?")){
		
		if(userfrm.checkName.length>1){
			for(i=0;i<userfrm.checkName.length;i++){
				if(userfrm.checkName[i].checked==true){
					checkYN='Y';
				}else{
					checkYN='N';
				}

				doAddHiddenRowData(fillSpace(users[i].title),fillSpace(checkYN),'users');
			}
		}else{
			if(userfrm.checkName.checked==true){
				checkYN='Y';
			}else{
				checkYN='N';
			}
			doAddHiddenRowData(fillSpace(users.title),fillSpace(checkYN),'users');

		}
		
		if(menufrm.checkName.length>1){
			for(i=0;i<menufrm.checkName.length;i++){
				if(menufrm.checkName[i].checked==true){
					checkYN='Y';
				}else{
					checkYN='N';
				}
	
				doAddHiddenRowData(fillSpace(menus[i].title),fillSpace(checkYN),'menus');
			}
		}else{
			if(menufrm.checkName.checked==true){
				checkYN='Y';
			}else{
				checkYN='N';
			}
			doAddHiddenRowData(fillSpace(menus.title),fillSpace(checkYN),'menus');

		}
		
		openWaiting( );
		frm.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authRegist';
		frm.submit();
		
	}
	
}
	
	/*
	*	테이블  hidden row 추가
	*/
	function doAddHiddenRowData(data,checkyn,name){
	
		defaultText.style.display='none';
	
		var rowCnt = contentId.rows.length;
	
		var newRow = contentId.insertRow( rowCnt++ );
		newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
	
		var newCell = newRow.insertCell();
		newCell.innerHTML = '<input name="'+name+'" value="'+data+'|'+checkyn+'" type="hidden"  />';
	}
	
	var tabYN='N';
	
	function tabpAction(){
	
		var userInfoLayer= document.getElementById('userInfoLayer');
	
		if(userInfoLayer.style.display=='block'){
			userInfoLayer.style.display="none";
		}else{
			if(tabYN=='Y'){
				userInfoLayer.style.display='block';
			}else{
				alert('사용자를 선택하셔야 상세보기가 가능합니다.');
				return;
			}
		}
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
<!-- contents -->
<div id="content">
    <!-- title -->
    <div class="content_navi">관리 &gt; 메뉴권한관리</div>
	<h3><span>메</span>뉴권한관리</h3>
    <!-- //title -->
  <div class="con authManage">
  <form name="UserSearchFrm" method="post" onkeydown="return captureReturnKey(event)">   
    <!-- 메뉴권한관리 -->
 
    <div class="manage">
      <div class="groupTree">
        
        <!-- 그룹별사용자 -->
        <dl>
          <dt>그룹별사용자</dt>
          <dd><iframe id="grouptree"  name="grouptree"  src="<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe></dd>
        </dl>
      </div>      
      <!-- //그룹별사용자 -->
      <!-- 메뉴권한선택 -->
      <div class="groupTree">
      <dl>
         <dt>메뉴권한선택</dt>
         <dd><iframe name="menutree"  src="<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe></dd>
      </dl>
      </div>      
      <!-- //메뉴권한선택 -->
      <!-- 메뉴권한상세정보 -->
      <div class="authInfo_wrap" >
        <div class="tap_open m_cursor"><img src="<%= request.getContextPath() %>/images/sub/authManage_btn_tabopen.gif"  onClick="tabpAction();" alt="탭열기" /></div><!-- 탭열기 -->
        <div id="userInfoLayer" style="display:none;"><iframe id="userInfo"  name="userInfo"  src="" scrolling="no" frameborder="0" width="100%" height="100%" ></iframe></div>
      </div>
      <!-- //메뉴권한상세정보 -->      
      <!-- //선택 사용자 정보 -->
      <!-- 임시데이타 배열테이블 START -->
      <table width="100%" height="0" border="0" cellpadding="0" cellspacing="0" id="defaultText">
      </table>
      <!-- 임시데이타 배열테이블 END -->      
      <!--추가ROW :: START-->
      <table width="100%" border="0" cellpadding="0" cellspacing="0"   id="contentId">
      </table>
      <!--추가ROW :: END-->    
    </div>    
    <!-- //메뉴권한관리 -->
    <!-- 버튼영역 -->
    <div class="Bbtn_areaC">
      <a href="javascript:goAuthSave();" class="btn_type02"><span>저장</span></a>
    </div>
    <!-- //버튼영역 -->
    
<!-- 이용TIP -->
<dl class="tip">
	<dt>이용 TIP</dt>
	<dd>그룹별 사용자에서 메뉴권한 대상자를 설정합니다.(개인 혹은 그룹별 선택가능)</dd>
	<dd>선택된 사용자에 대해 메뉴별 화면 트리에서 적용할 메뉴를 선택합니다.</dd>
	<dd>저장시 선택 사용자들에 대해 선택된 메뉴가 일괄적용 됩니다.</dd>
	<dd>적용된 메뉴는 개별 사용자명을 선택시 사용자별 메뉴화면이 Display되면서 확인이 가능합니다.</dd>
	<dd>Display 된 개별 사용자 권한정보는 선택정보 메뉴세팅 옵션을 통해 메뉴권한정보에 세팅할 수 있습니다.</dd>
</dl>
<!-- //이용TIP -->
  </form>
  </div>
</div>
<!-- //contents -->
</div>
<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</body>
</html>
<%= comDao.getMenuAuth(menulist,"62") %>