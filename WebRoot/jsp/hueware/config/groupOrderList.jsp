<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> arrlist = (ArrayList)model.get("steplist");
String GroupID = (String)model.get("GroupID");
String GroupStep = (String)model.get("GroupStep");
String t_retVal = StringUtil.nvl((String)model.get("t_retVal"),"");
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script>
	function groupModifyForm(index){
		
		var arrgroupdata = document.getElementsByName("groupdata");
		var arrM_groupdata = document.getElementsByName("M_groupdata");
		var arrM_groupRow = document.getElementsByName("groupRow");
		
		arrM_groupRow[index].className="selected";
		arrgroupdata[index].style.display = "none";
		arrM_groupdata[index].style.display = "block";
		
	}
	function groupCancel(index){
		
		var arrgroupdata = document.getElementsByName("groupdata");
		var arrM_groupdata = document.getElementsByName("M_groupdata");
		var arrM_groupRow = document.getElementsByName("groupRow");
		
		arrM_groupRow[index].className="";
		
		arrgroupdata[index].style.display = "block";
		arrM_groupdata[index].style.display = "none";
		
	}
	function groupDelet(index){
	
		var frm=document.groupListForm;
		var groupid;
		
		if(frm.GroupID.length>1){
			
			groupid=frm.GroupID[index].value;	
		}else{
			groupid=frm.GroupID.value;
		}

		if(confirm("���� ������ ���������� ������ �Ҽӵ� ����ڵ� �Բ� �����˴ϴ�.\n���� ���� �Ͻðڽ��ϱ�?")){

		}else{
			return;
		}

	var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=D&GroupID='+groupid+'&GroupName=';
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
		alert('���������� �����߽��ϴ�.');
    	parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
	}else{
		alert('���������� �����߽��ϴ�. �����ڿ��� �����ϼ���!');
	}
	
}
function groupModify(index){
	
	var frm=document.groupListForm;
	var groupid='';
	var groupstep=1;
	var groupname;
	var result;
	
	if(frm.GroupID.length>1){	
		groupid=frm.GroupID[index].value;
		groupname=frm.GroupName[index].value;
	}else{
		groupid=frm.GroupID.value;
		groupname=frm.GroupName.value;
	}

	result=parent.doCheck(groupname);
	
	if(result==1){
		alert('�����Ͻ� �������� �̹� ������Դϴ�.');
		return;
	}else if(result==2){
		alert('�����Ͻ� �������� ���������� �ֽ��ϴ�.');
		return;
	}

	if(confirm("���� ������ ������ �Ҽӵ� ����ڵ��� ���������� �Բ� �����˴ϴ�.\n���� ���� �Ͻðڽ��ϱ�?")){

	}else{
		return;
	}	
	
	var requestUrl='<%= request.getContextPath() %>/H_Group.do?cmd=groupControl&manageGb=U&GroupID='+groupid+'&GroupName='+groupname;
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
		alert('���� ������ �����߽��ϴ�.');
		parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
	}else{
		alert('���������� �����߽��ϴ�. �����ڿ��� �����ϼ���!');
		parent.tree.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupTreeList&GroupID='+groupid+'&GroupStep='+groupstep;
	}
	
}
</script>
<body>
<form name="groupListForm" method="post" >
	<%	if(arrlist.size() > 0){
				for(int j=0; j < arrlist.size(); j++ ){	
				    GroupDTO dto = arrlist.get(j);	
	%>
	<input type="hidden" name="GroupID" value="<%=dto.getGroupID()%>">
	<div id="groupRow" name="groupRow">
		<!-- ���� -->
		<ul id="groupdata" name="groupdata">
			<li><span class="groupId"><%=dto.getGroupID() %></span>&nbsp;&nbsp;<%=dto.getGroupName() %><a href="javascript:groupModifyForm(<%=j%>)" class="btn_type03"><span>����</span></a><a href="javascript:groupDelet(<%=j%>)" class="btn_type03"><span>����</span></a></li>
		</ul>
		<!-- //���� -->
		<!-- ���� -->
		<ul id="M_groupdata" name="M_groupdata" style="display:none;">
			<li class="modify"><span class="groupId"><%=dto.getGroupID() %></span>&nbsp;&nbsp;<input name="GroupName" type="text" class="text" title="�׷��" style="width:162px;height:23px;" value="<%=dto.getGroupName() %>" /><a href="javascript:groupModify(<%=j%>)" class="btn_type03"><span>Ȯ��</span></a><a href="javascript:groupCancel(<%=j%>)" class="btn_type03"><span>���</span></a></li><!-- ����  class="modify" �߰� -->
		</ul>
		<!-- //���� -->
	</div>
	<%
		    }
		}
	%>
</form>
</body>
<!-- //����Ʈ -->
