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
	<title>소속관리</title>
	<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
	<link href="<%= request.getContextPath()%>/css/dtree.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
</head>

<body id="dtree" style="padding:15px;">
<form name="treeFrm">
<div class="dtree">
	<p class="dOpenClose"><a href="javascript: d.openAll();">모두 펼치기</a> | <a href="javascript: d.closeAll();">모두 접기</a></p>
	<script type="text/javascript">
		<!--
		var openWin=0;//사용자 메뉴권한 트리 팝업객체
		
		//선택카테고리의 하위카테고리를 체킹한다
		function selectCheck(cateid,obj){
			
			var objcheck=obj.checked;

			var upcateids=eval("document.all.upCateId");//상위카테고리
			var cateids=eval("document.all.cateId");//카테고리

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
		//하위카테고리 체킹함수
		function subSelectCheck(cateid,objcheck){
			
			var upcate=cateid;
			var upcateids=eval("document.all.upCateId");//상위카테고리
			var cateids=eval("document.all.cateId");//카테고리

			for(i=0;i<upcateids.length;i++){

				if(upcateids[i].value==upcate){				
					upcate=cateid;			
					document.treeFrm.checkName[i].checked=objcheck;	
				}
			}
		}
		
		//사용자별 메뉴권한 창 팝업
		function goPopup(userid){
			parent.tabYN='Y';
			parent.userInfo.location.href='<%= request.getContextPath() %>/H_Auth.do?cmd=userAuthMenuTree&userid='+userid;
			
			var userInfoLayer= parent.document.getElementById('userInfoLayer');

			userInfoLayer.style.display="block";
		}
		//사용자 선택시 선택명 효과및 사용자메뉴권한 트리 팝업을 해준다.
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
			  	goPopup(userid);//사용자 메뉴권한 팝업
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
				
				if(!userid.equals("")){//그룹이 아닌 사용자의 경우 사용자 이미지로 표기해준다.
					userIcon=",'#','','','images/tree/people.gif'";
				}else{
					userIcon=",'#','','','images/tree/folder.gif'";
				}

	    %>
	  //트리구성
	    d.add('<%=cateid%>','<%=upcateid%>','&nbsp;<input type="checkbox" value="<%=upcateid%>" id="upCateId" class="check md0"  name="checkName" onClick=selectCheck("<%=cateid%>",this) ><input type=hidden id=cateId value="<%=cateid%>" ><a href=javascript:selectUser("<%=dto.getUserID()%>","<%=dto.getGroupName()%>");><span  id=fontId  title=<%=dto.getUserID()%> ><%=dto.getGroupName()%></span></a>' <%=userIcon%> );
		

		<%
			}
		}
		%>
		//트리생성
		document.write(d);
		//-->
	</script>
</div>
</form>
</body>
</html>
<script>
//조회결과에 따라 상위 폴더 오픈처리
<%	
if(grouplist.size() > 0){	

String userId="";
String searchResult="";

	for(int k=0; k < grouplist.size(); k++ ){	
		GroupDTO dto = grouplist.get(k);

		searchResult=dto.getSearchResult();
		userId=dto.getUserID();
		
		//System.out.println("[searchResult]:"+searchResult+":[카테고리명]:"+dto.getGroupName()+":[사용자 ID]:"+userId);
		if(0<k && k<grouplist.size() && searchResult.equals("1")){
			if(userId.equals("")){
				//System.out.println(dto.getGroupName()+"<<<연다.>>>");
				%>
				d.o(<%=k%>);	
				<%
			}else{
				//System.out.println(dto.getGroupName()+"<<<선택한다.>>>");
				%>
				selectUser('<%=dto.getUserID()%>','<%=dto.getGroupName()%>');
				<%
			}
		}
	}
}
%>
d.openAll();//기본 트리를 전체오픈시킨다.
//parent.document.UserSearchFrm.UserID.focus();
</script>
