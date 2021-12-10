<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.config.MenuDTO"%>
<%@ page import ="com.huation.common.user.UserDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<MenuDTO> menulist = (ArrayList)model.get("menulist");
UserDTO userDto= (UserDTO)model.get("userDto");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>메뉴별 화면</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/dtree.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
<script>
function selectOption(){

	var url;

	if(document.treeFrm.selectMenu.checked==true){
		url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=<%=userDto.getID()%>';
	}else{
		url=	'<%= request.getContextPath() %>/H_Auth.do?cmd=authMenuTree&userid=';
	}
	parent.menutree.location.href=url;
	
}
</script>
</head>
<body>
<form name="treeFrm">
<div id="authInfo_wrap">
	<dl>
		<dt><%=userDto.getGroupName() %> <span class="userName">[<%=userDto.getName()%> (<%=userDto.getID() %>)]</span><span class="setting"><input name="selectMenu" id="setting" type="checkbox" value="" class="check" onclick="selectOption();" title="선택정보로 메뉴세팅" /><label for="setting">선택정보로 메뉴세팅</label></span></dt>
		<dd>
			<!-- dtree -->
			<div style="overflow-y:auto; height:530px;">
				<div id="dtree" class="dtree" style="display:block;padding:15px;">
					<script type="text/javascript">
					<!--
					
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
					   //트리구성
					d.add('<%=cateid%>','<%=upcateid%>','&nbsp;<input type="checkbox" disabled  <%=auth%> class="check md0"  name="checkName") ><a href="#none"><span id=fontId  title=<%=dto.getMenuID()%> ><%=dto.getMenuName()%></span></a>','#','','','images/tree/folder.gif' );
					
					<%
						}
					}
					%>
					//트리생성
					document.write(d);
					d.openAll();//기본 트리를 전체오픈시킨다.
					//-->
					</script>
				</div>
			</div>
			<!-- /dtree -->
    	</dd>
	</dl>
	<div class="tap_clos m_cursor"><img src="<%= request.getContextPath() %>/images/sub/authManage_btn_tabclose.gif" onClick="parent.tabpAction();" alt="탭닫기" /></div><!-- 탭닫기 -->	 
</div>
</form>
</body>
</html>
