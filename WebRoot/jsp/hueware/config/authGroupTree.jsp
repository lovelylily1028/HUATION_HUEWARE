<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> grouplist = (ArrayList)model.get("grouplist");
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
		<!--
		var openWin=0;//����� �޴����� Ʈ�� �˾���ü
		
		//����ī�װ��� ����ī�װ��� üŷ�Ѵ�
		function selectCheck(cateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==cateid){
					document.treeFrm.checkName[i].checked=objcheck;	
				}

			}
			
			for(j=0;j<upcateids.length;j++){
			
				if(document.treeFrm.checkName[j].checked==true){
					
					subSelectCheck(cateids[j].value,objcheck);
					if(objcheck==false){
					document.treeFrm.checkName[j].checked=false;
					}
				}
			}
		}
		//����ī�װ� üŷ�Լ�
		function subSelectCheck(cateid,objcheck){
			
			var upcate=cateid;
			var upcateids=eval("document.all.upCateId");//����ī�װ�
			var cateids=eval("document.all.cateId");//ī�װ�

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==upcate){				
					upcate=cateid;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		
		//����ں� �޴����� â �˾�
		function goPopup(userid){
			parent.tabYN='Y';
			parent.userInfo.location.href='<%= request.getContextPath() %>/H_Auth.do?cmd=userAuthMenuTree&userid='+userid;
			
			var userInfoLayer= parent.document.getElementById('userInfoLayer');

			userInfoLayer.style.display="block";
		}
		//����� ���ý� ���ø� ȿ���� ����ڸ޴����� Ʈ�� �˾��� ���ش�.
		function selectUser(userid,groupname){
		
			if(userid==''){
				return;
			}
			   
			  	names=eval("document.all.fontId");
			
			  	for(i=0;i<names.length;i++){
			
			  		if(names[i].title==userid){
			  		names[i].style.fontWeight="bold";
			    	names[i].style.color="#ff6600";
			    	//document.treeFrm.checkName[i].checked=true;	
			  		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
			    	//document.treeFrm.checkName[i].checked=false;	
			  		}
			  	}
			  	goPopup(userid);//����� �޴����� �˾�
		  }

		d = new dTree('d');
		d.clearCookie();
		<%	

		if(grouplist.size() > 0){	
		int i = 0;
		String cateid="";
		String upcateid="";
		String searchResult="0";
		String userid="";
		String userIcon=",'','','','images/tree/folder.gif'";

			for(int j=0; j < grouplist.size(); j++ ){	
				GroupDTO dto = grouplist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				
				cateid=cateid.substring(1);
				upcateid=upcateid.substring(1);
				
				searchResult=dto.getSearchResult();
				
				userid=dto.getUserID();
				
				if(!userid.equals("")){//�׷��� �ƴ� ������� ��� ����� �̹����� ǥ�����ش�.
					userIcon=",'#','','','images/tree/people.gif'";
				}else{
					userIcon=",'#','','','images/tree/folder.gif'";
				}

	    %>
	  //Ʈ������
	    d.add('<%=cateid%>','<%=upcateid%>','&nbsp;<input type="checkbox" value="<%=upcateid%>" id="upCateId" class="check md0"  name="checkName" onClick=selectCheck("<%=cateid%>",this) ><input type=hidden id=cateId value="<%=cateid%>" ><a href=javascript:selectUser("<%=dto.getUserID()%>","<%=dto.getGroupName()%>");><span  id=fontId  title=<%=dto.getUserID()%> ><%=dto.getGroupName()%></span></a>' <%=userIcon%> );
		

		<%
			}
		}
		%>
		//Ʈ������
		document.write(d);
		//-->
	</script>
</div>
</form>
</body>
</html>
<script>
//��ȸ����� ���� ���� ���� ����ó��
<%	
if(grouplist.size() > 0){	

String userId="";
String searchResult="";

	for(int k=0; k < grouplist.size(); k++ ){	
		GroupDTO dto = grouplist.get(k);

		searchResult=dto.getSearchResult();
		userId=dto.getUserID();
		
		//System.out.println("[searchResult]:"+searchResult+":[ī�װ���]:"+dto.getGroupName()+":[����� ID]:"+userId);
		if(0<k && k<grouplist.size() && searchResult.equals("1")){
			if(userId.equals("")){
				//System.out.println(dto.getGroupName()+"<<<����.>>>");
				%>
				d.o(<%=k%>);	
				<%
			}else{
				//System.out.println(dto.getGroupName()+"<<<�����Ѵ�.>>>");
				%>
				selectUser('<%=dto.getUserID()%>','<%=dto.getGroupName()%>');
				<%
			}
		}
	}
}
%>
d.openAll();//�⺻ Ʈ���� ��ü���½�Ų��.
//parent.document.UserSearchFrm.UserID.focus();
</script>
