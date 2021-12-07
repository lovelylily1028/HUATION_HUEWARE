<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�׷� ����</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">

	//tablememo ����
	function onVisible(){
		var arrAddFrm = document.getElementsByName("groupAddForm");
		arrAddFrm[0].style.display = "block";
	}
	
	
	//tablememo ����
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
				alert('�߰��Ͻ� �������� �Է��ϼ���.');
				return;
			}
			
			groupid=document.group.groupVeiwFrm.GroupID.value;
			groupname=frm.GroupName.value;
	        result=doCheck(frm.GroupName.value);
			
			if(result==1){
				alert('�߰��Ͻ� �������� �̹� ������Դϴ�.');
				return;
			}else if(result==2){
				alert('�߰��Ͻ� �������� ���������� �ֽ��ϴ�.');
				return;
			}
	
			if(confirm("���� �߰��� ��å�� ���������� �����˴ϴ�.\n���� �߰� �Ͻðڽ��ϱ�?")){
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
			alert('���� �߰��� �����߽��ϴ�.');
	    	document.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
		}else{
			alert('���� �߰��� �����߽��ϴ�. �����ڿ��� �����ϼ���!');
		}
	}
	
	function pre_doCheck(){
	
		if(document.groupManageFrm.GroupName.value==''){
			alert('�߰��Ͻ� �������� �Է��ϼ���.');
			return;
		}
		var result=doCheck(document.groupManageFrm.GroupName.value);
	
		if(result==1){
			alert('�߰��Ͻ� �������� �̹� ������Դϴ�.');
			document.groupManageFrm.GroupName.value='';
			
		}else if(result==2){
			alert('�߰��Ͻ� �������� ���������� �ֽ��ϴ�.');
			document.groupManageFrm.GroupName.value='';
	
		}else{
			alert('��밡���� ������ �Դϴ�.');
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
			<div class="content_navi">���� &gt; �׷����</div>
			<h3><span>��</span>�����</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con groupManage">
				<form name="groupManageFrm">
				<!-- �׷켱�� -->
				<div class="groupTree">
					<dl>
						<dt>�׷켱��</dt>
						<dd><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupTreeList&GroupID=G00001&GroupStep=1" id="tree" name="tree" frameborder="0" class="" scrolling="auto" width="100%" height="100%"></iframe></dd>
					</dl>
				</div>
				<!-- //�׷켱�� -->				
				<!-- �׷���� -->
				<div class="groupList">
					<dl>
						<dt><span id="groupTitle" name="groupTitle">�׷����</span><a href="javascript:onVisible();" class="btn_type03"><span>�׷��߰�</span></a></dt>
						<dd>
							<!-- �׷����� ������ --><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupView" width="0" height="0"  id="group" name="group" frameborder="0" scrolling="no"></iframe>
							<!-- ����Ʈ ������ --><iframe src="<%=request.getContextPath()%>/H_Group.do?cmd=groupOrderList" width="100%" height="100%" name="list" frameborder="0" scrolling="auto"></iframe>
						</dd>
					</dl>
				</div>
				<!-- //�׷���� -->
				<!-- ���̾��˾�(�׷��߰�) -->
				<div id="groupAddForm" name="groupAddForm" style="display:none;position:absolute;left:321px;top:36px;">
					<div id="wrapLp" class="groupReg">
						<!-- header -->
						<div id="headerLp">
							<h1>�׷��߰�</h1>
						</div>
						<!-- //header -->
						<!-- content -->
						<div id="contentLp">
							<!-- �׷��߰� -->
							<fieldset>
								<legend>�׷��߰�</legend>
								<div class="con"><label for="CName">�ҼӸ�</label>&nbsp;&nbsp;<input name="GroupName" id="CName" type="text" class="text" title="�ҼӸ�" style="width:150px;" maxlength="20" value="" /><a href="javascript:pre_doCheck();" class="btn_type03"><span>�ߺ�Ȯ��</span></a><br /><span class="guide_txt">���õ� <strong id="groupTitle" name="groupTitle">����</strong>�� <strong>�����׷�</strong>���� �߰��˴ϴ�.</span></div>
							</fieldset>
							<!-- //�׷��߰� -->
							<!-- Bottom ��ư���� -->
							<div class="Bbtn_areaC"><a href="javascript:goInsert();" class="btn_type02"><span>����</span></a><a href="javascript:offVisible();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
							<!-- //Bottom ��ư���� -->
						</div>
						<!-- //content -->
					</div>
				</div>
				<!-- //���̾��˾�(�׷��߰�) -->
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