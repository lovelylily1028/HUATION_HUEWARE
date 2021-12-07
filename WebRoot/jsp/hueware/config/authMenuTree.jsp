<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.config.MenuDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<MenuDTO> menulist = (ArrayList)model.get("menulist");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>�ҼӰ���</title>
	<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/dtree.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body id="dtree" style="padding:15px;">
<form name="treeFrm">
<div class="dtree">
	<p class="dOpenClose"><a href="javascript: d.openAll();">��� ��ġ��</a> | <a href="javascript: d.closeAll();">��� ����</a></p>
	<script type="text/javascript">
		
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck2(upcateid, cateid){
			
			var obj = "";
			var cateids=eval("document.all.cateId");//ī�װ�
			
			for (i=0; i<cateids.length; i++) {
				if (cateids[i].value == cateid) {
					if (document.treeFrm.checkName[i].checked) {
						document.treeFrm.checkName[i].checked = false;	
					} else {
						document.treeFrm.checkName[i].checked = true;
					}
					obj = document.treeFrm.checkName[i];			
				}
			}
			
			if (obj != "") {
				selectCheck(upcateid, obj, cateid);	
			}
		}
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck(upcateid,obj, cateid){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�
			
			/* 0. ��ü(main menu)�� �����ϸ� ��� ó���Ѵ� */
			if (upcateid == -1) {
				for (i=0; i<cateids.length; i++) {
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
			
			/* 1. ���� ���� ī�װ��� ������ �ִ� ��� �������װ��� ��� ó���Ѵ�*/
			if (upcateid == 0) {
				for (i=0; i<upcateids.length; i++) {
					if (upcateids[i].value == cateid) {
						document.treeFrm.checkName[i].checked=objcheck;	
					}
				}
			}
			
			/* 2. ���� üũ�Ǹ� ���� ī�װ��� üũ �Ǿ�� �Ѵ� */
			if (objcheck == true && upcateid != 0) {
				for (i=0; i<cateids.length; i++) {
					if (cateids[i].value == upcateid) {
						document.treeFrm.checkName[i].checked=objcheck;	
					}
				}
			}
			
			/* 3. ���� üũ ���� �Ǹ� ���� ī�װ� ���� ���θ� �Ǵ��Ͽ� ó���Ѵ� */
			var chkSubCate = false;
			if (objcheck == false && upcateid != 0) {
				for (i=0; i<upcateids.length; i++) {
					if (upcateids[i].value == upcateid) {
						if (document.treeFrm.checkName[i].checked == true) {
							chkSubCate = true;
							break;
						}
					}
				}
				
				/* ������� �Դµ�, chkSubCate �� false �� ����ī�װ��� false ��Ų�� */
				if (chkSubCate == false) {
					for (i=0; i<cateids.length; i++) {
						if (cateids[i].value == upcateid) {
							document.treeFrm.checkName[i].checked=objcheck;	
						}
					}
				}
			}
			
			/* 4. ��ü üũ ó�� */
			var allCheck = false;
			if (upcateid != -1) {
				for (i=1; i<cateids.length; i++) {
					if (document.treeFrm.checkName[i].checked == true) {
						allCheck = true;
						break;
					}
				}				
				document.treeFrm.checkName[0].checked = allCheck;
			}
		}
		
		
		d = new dTree('d');
		<%	

		if(menulist.size() > 0){	
			int i = 0;
			String cateid="";
			String upcateid="";
			String auth="";
		
		
			for(int j=0; j < menulist.size(); j++ ){	
				MenuDTO dto = menulist.get(j);
				
				cateid=dto.getMenuID();
				upcateid=dto.getUpMenuID();
				
				cateid=cateid.substring(1);
				upcateid=upcateid.substring(1);
				
				auth=dto.getAuth();
				
				if(!"N".equals(auth)){
					auth="checked";
				}else{
					auth="";
				}
		
	    %>
	 			//Ʈ������
				d.add('<%=cateid%>','<%=upcateid%>','&nbsp;<input type="checkbox" <%=auth%> value=<%=upcateid%> id=upCateId class="check md0" name="checkName" onClick=selectCheck(<%=upcateid%>,this,<%=cateid%>) ><input type=hidden id=cateId value=<%=cateid%> ><a href=javascript:selectCheck2(<%=upcateid%>,<%=cateid%>)><span id=fontId  title=<%=dto.getMenuID()%> ><%=dto.getMenuName()%></span></a>','#','','','images/tree/folder.gif' );
		<%
			}
		}
		%>
		//Ʈ������
		document.write(d);
		d.openAll();//�⺻ Ʈ���� ��ü���½�Ų��.
	
	</script>
</div>
</form>
</body>
</html>
