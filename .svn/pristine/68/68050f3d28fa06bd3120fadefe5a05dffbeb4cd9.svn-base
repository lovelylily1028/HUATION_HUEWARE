<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>그룹 관리</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">

	//tablememo 열림
	function onVisible(){
		var arrAddFrm = document.getElementsByName("groupAddForm");
		arrAddFrm[0].style.display = "block";
	}
	
	
	//tablememo 닫힘
	function offVisible() {
		var arrAddFrm = document.getElementsByName("groupAddForm");
		arrAddFrm[0].style.display = "none";
	}
	
	function doCheck(GroupName){
	
		var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupNameDupCheck&GroupName='+GroupName;
		var result=0;
		
		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
		
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);
		
		resultText = xmlhttp.responseText;
		
		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
		
		result=xmlObject.documentElement.childNodes.item(0).text;
		
		return result;
		
	}
	
	function goInsert(){
	
			var frm=document.groupManageFrm;
			var groupid;
			var groupname;
			var result;
			
			if(frm.GroupName.value==''){
				alert('추가하실 조직명을 입력하세요.');
				return;
			}
			
			groupid=document.group.groupVeiwFrm.GroupID.value;
			groupname=frm.GroupName.value;
	        result=doCheck(frm.GroupName.value);
			
			if(result==1){
				alert('추가하실 조직명은 이미 사용중입니다.');
				return;
			}else if(result==2){
				alert('추가하실 조직명은 삭제내역이 있습니다.');
				return;
			}
	
			if(confirm("조직 추가시 선책된 하위조직에 생성됩니다.\n정말 추가 하시겠습니까?")){
				offVisible();
				frm.GroupName.value='';
			}else{
				return;
			}	
	
		var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=I&GroupID='+groupid+'&GroupName='+groupname;
	
		var result=0;
		var groupid='';
		var groupstep=1;
		
		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
	
	
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		xmlhttp.open("GET", requestUrl, false);
		xmlhttp.send(requestUrl);
	
		resultText = xmlhttp.responseText;
	
		xmlObject = new ActiveXObject("Microsoft.XMLDOM");
		xmlObject.loadXML(resultText);
		
		result=xmlObject.documentElement.childNodes.item(0).text;
		groupid=xmlObject.documentElement.childNodes.item(1).text;
		groupstep=xmlObject.documentElement.childNodes.item(2).text;
	
		if(groupid!=null){
			alert('조직 추가를 성공했습니다.');
	    	document.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
		}else{
			alert('조직 추가를 실패했습니다. 관리자에게 문의하세요!');
		}
	}
	
	function pre_doCheck(){
	
		if(document.groupManageFrm.GroupName.value==''){
			alert('추가하실 조직명을 입력하세요.');
			return;
		}
		var result=doCheck(document.groupManageFrm.GroupName.value);
	
		if(result==1){
			alert('추가하실 조직명은 이미 사용중입니다.');
			document.groupManageFrm.GroupName.value='';
			
		}else if(result==2){
			alert('추가하실 조직명은 삭제내역이 있습니다.');
			document.groupManageFrm.GroupName.value='';
	
		}else{
			alert('사용가능한 조직명 입니다.');
		}
		
	}

</script>
</head>
<body onkeypress="if(event.keyCode==13){return false;}">
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">관리 &gt; 그룹관리</div>
			<h3><span>그</span>룹관리</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con groupManage">
				<form name="groupManageFrm">
				<!-- 그룹선택 -->
				<div class="groupTree">
					<dl>
						<dt>그룹선택</dt>
						<dd><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupTreeList&GroupID=G00001&GroupStep=1" id="tree" name="tree" frameborder="0" class="" scrolling="auto" width="100%" height="100%"></iframe></dd>
					</dl>
				</div>
				<!-- //그룹선택 -->				
				<!-- 그룹관리 -->
				<div class="groupList">
					<dl>
						<dt><span id="groupTitle" name="groupTitle">그룹관리</span><a href="javascript:onVisible();" class="btn_type03"><span>그룹추가</span></a></dt>
						<dd>
							<!-- 그룹정보 프레임 --><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupView" width="0" height="0"  id="group" name="group" frameborder="0" scrolling="no"></iframe>
							<!-- 리스트 프레임 --><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupOrderList" width="100%" height="100%" name="list" frameborder="0" scrolling="auto"></iframe>
						</dd>
					</dl>
				</div>
				<!-- //그룹관리 -->
				<!-- 레이어팝업(그룹추가) -->
				<div id="groupAddForm" name="groupAddForm" style="display:none;position:absolute;left:321px;top:36px;">
					<div id="wrapLp" class="groupReg">
						<!-- header -->
						<div id="headerLp">
							<h1>그룹추가</h1>
						</div>
						<!-- //header -->
						<!-- content -->
						<div id="contentLp">
							<!-- 그룹추가 -->
							<fieldset>
								<legend>그룹추가</legend>
								<div class="con"><label for="CName">소속명</label>&nbsp;&nbsp;<input name="GroupName" id="CName" type="text" class="text" title="소속명" style="width:150px;" maxlength="20" value="" /><a href="javascript:pre_doCheck();" class="btn_type03"><span>중복확인</span></a><br /><span class="guide_txt">선택된 <strong id="groupTitle" name="groupTitle">조직</strong>의 <strong>하위그룹</strong>으로 추가됩니다.</span></div>
							</fieldset>
							<!-- //그룹추가 -->
							<!-- Bottom 버튼영역 -->
							<div class="Bbtn_areaC"><a href="javascript:goInsert();" class="btn_type02"><span>저장</span></a><a href="javascript:offVisible();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
							<!-- //Bottom 버튼영역 -->
						</div>
						<!-- //content -->
					</div>
				</div>
				<!-- //레이어팝업(그룹추가) -->
				</form>
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
<%= comDao.getMenuAuth(menulist,"61") %>