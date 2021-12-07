<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�޴����� ����</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<%-- <link href="<%=request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css" /> --%>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<script>

	var observer;//ó����
	//�ʱ��Լ�
	function init() {
	
		openWaiting( );
	
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	}
	
	//��ȸ
	function goSearch(){
		
		var obj=document.UserSearchFrm;
		var uid=document.UserSearchFrm.UserID.value;
		var invalid = ' ';	//���� üũ
		
		if(obj.UserID.value=='' || obj.UserID.value.indexOf(invalid) > -1){
			alert('��ȸ�� ID�� �Է��� �ּ���');
			obj.UserID.value="";
			obj.UserID.focus();
			return;
		}
		//openWaiting( );
		obj.action='<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree&UserID='+uid;
		obj.target="grouptree";
		obj.submit();
		
	}
	
	//����ó��
	function captureReturnKey(e) {
		 if(e.keyCode==13 && e.srcElement.type != 'textarea')
		 //return false;
		 goSearch();
	}

	//��������
	function goAuthSave(){
	
	var frm=document.UserSearchFrm;
	var userfrm = grouptree.treeFrm;
	var menufrm = menutree.treeFrm;
	var users =eval("grouptree.document.all.fontId");
	var menus =eval("menutree.document.all.fontId"); 
	var checkYN;
	var checkucnt=0;
	var checkmcnt=0;
	
	//���ÿ��� �Ǵ�
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
		alert('���õ� ����� ������ �����ϴ�.');
		return;
	}
	
	//���ÿ��� �Ǵ�
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
		alert('���õ� �޴� ������ �����ϴ�.');
		return;
	}
	
	
	if(confirm("���õ� �������� ������ �����Ͻðڽ��ϱ�?")){
		
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
	*	���̺�  hidden row �߰�
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
				alert('����ڸ� �����ϼž� �󼼺��Ⱑ �����մϴ�.');
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
    <div class="content_navi">���� &gt; �޴����Ѱ���</div>
	<h3><span>��</span>�����Ѱ���</h3>
    <!-- //title -->
  <div class="con authManage">
  <form name="UserSearchFrm" method="post" onkeydown="return captureReturnKey(event)">   
    <!-- �޴����Ѱ��� -->
 
    <div class="manage">
      <div class="groupTree">
        
        <!-- �׷캰����� -->
        <dl>
          <dt>�׷캰�����</dt>
          <dd><iframe id="grouptree"  name="grouptree"  src="<%= request.getContextPath() %>/H_Auth.do?cmd=authGroupTree" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe></dd>
        </dl>
      </div>      
      <!-- //�׷캰����� -->
      <!-- �޴����Ѽ��� -->
      <div class="groupTree">
      <dl>
         <dt>�޴����Ѽ���</dt>
         <dd><iframe name="menutree"  src="<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe></dd>
      </dl>
      </div>      
      <!-- //�޴����Ѽ��� -->
      <!-- �޴����ѻ����� -->
      <div class="authInfo_wrap" >
        <div class="tap_open m_cursor"><img src="<%= request.getContextPath() %>/images/sub/authManage_btn_tabopen.gif"  onClick="tabpAction();" alt="�ǿ���" /></div><!-- �ǿ��� -->
        <div id="userInfoLayer" style="display:none;"><iframe id="userInfo"  name="userInfo"  src="" scrolling="no" frameborder="0" width="100%" height="100%" ></iframe></div>
      </div>
      <!-- //�޴����ѻ����� -->      
      <!-- //���� ����� ���� -->
      <!-- �ӽõ���Ÿ �迭���̺� START -->
      <table width="100%" height="0" border="0" cellpadding="0" cellspacing="0" id="defaultText">
      </table>
      <!-- �ӽõ���Ÿ �迭���̺� END -->      
      <!--�߰�ROW :: START-->
      <table width="100%" border="0" cellpadding="0" cellspacing="0"   id="contentId">
      </table>
      <!--�߰�ROW :: END-->    
    </div>    
    <!-- //�޴����Ѱ��� -->
    <!-- ��ư���� -->
    <div class="Bbtn_areaC">
      <a href="javascript:goAuthSave();" class="btn_type02"><span>����</span></a>
    </div>
    <!-- //��ư���� -->
    
<!-- �̿�TIP -->
<dl class="tip">
	<dt>�̿� TIP</dt>
	<dd>�׷캰 ����ڿ��� �޴����� ����ڸ� �����մϴ�.(���� Ȥ�� �׷캰 ���ð���)</dd>
	<dd>���õ� ����ڿ� ���� �޴��� ȭ�� Ʈ������ ������ �޴��� �����մϴ�.</dd>
	<dd>����� ���� ����ڵ鿡 ���� ���õ� �޴��� �ϰ����� �˴ϴ�.</dd>
	<dd>����� �޴��� ���� ����ڸ��� ���ý� ����ں� �޴�ȭ���� Display�Ǹ鼭 Ȯ���� �����մϴ�.</dd>
	<dd>Display �� ���� ����� ���������� �������� �޴����� �ɼ��� ���� �޴����������� ������ �� �ֽ��ϴ�.</dd>
</dl>
<!-- //�̿�TIP -->
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