<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
Map model = (Map)request.getAttribute("MODEL"); 

ArrayList<GroupDTO> grouplist = (ArrayList)model.get("grouplist");
String GroupID = (String)model.get("GroupID");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>그룹별 상세현황</title>
<!-- 트리구조 -->
<script type="text/javascript">
var setGroupID;

	$(function(){
	// 트리옵션
	$("#tree").dynatree({
		checkbox: false, //체크박스 주기
		selectMode : 3, //체크박스 모드
		fx: { height: "toggle", duration: 100 },
		autoCollapse: false,
		clickFolderMode : 1, //폴더 클릭 옵션
		minExpandLevel : 3, //최초 보일 레벨
		onActivate : function(node){
			
			var GroupID	= node.data.key;
			setGroupID=GroupID;
			goSearchs();
		}
	});
	// 트리옵션

	// 모두펼치기/모두접기
	$("#btnCollapseAll").click(function(){
		$("#tree").dynatree("getRoot").visit(function(node){
		node.expand(false);       });
			return false;     });

	$("#btnExpandAll").click(function(){
		$("#tree").dynatree("getRoot").visit(function(node){
		node.expand(true);       });
			return false;     });
	// 모두펼치기/모두접기

	var rootNode = $("#tree").dynatree("getRoot");
	
	<%
	if(grouplist.size() > 0){
		int i = 0;
		String cateid="";
		String upcateid="";
		String searchResult="0";
		String userid="";
		boolean folderYN = false;
		boolean checked = false;
		int test = 0;
		for(int j=0; j < grouplist.size(); j++ ){	
			int totalCnt = 0;
			GroupDTO dto = grouplist.get(j);
			GroupDTO dto2 = grouplist.get(0);
			
			cateid=dto.getGroupID();
			upcateid=dto.getUpGroupID();
			
			//Tree 생성
			if(j == 0){
			%>
				var <%=cateid%> = rootNode.addChild({
					title: "<%=dto.getGroupName()%>",
					isFolder: true,
					key : "<%=cateid%>",
					icon : '<%= request.getContextPath() %>/images/tree/base.gif'
				});
			<%
			}else{
				if(cateid.equals(dto2.getGroupID())){
					%>
					var <%=cateid%> = rootNode.addChild({
						title: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>",
						icon : '<%= request.getContextPath() %>/images/tree/base.gif'
					});
					<%
				}else{
					%>
					var <%=cateid%> = <%=upcateid%>.addChild({
						title: "<%=dto.getGroupName()%>",
						isFolder: true,
						key : "<%=cateid%>"
					});
					<%					
				}
			}
		}
	}
	%>
	

});
	
	
function goSearchs(){
	$.ajax({
	        type: "POST",
	           url:  "<%=request.getContextPath()%>/S_Sms.do?cmd=ajaxSmsAddList2",
	           data : {
	        	   "GroupID" : setGroupID
	   		},
	           success: function(result) {
	               $("#lists").html(result);
	               
	              }
	    });
} 

</script>
<!-- //트리구조 -->
</head>
<body>

					<div id="tree" style="padding-bottom:15px;">
						<p style="padding-bottom:15px;"><a href="#" id="btnExpandAll">모두 펼치기</a> | <a href="#" id="btnCollapseAll">모두 접기</a></p>
					</div>
					
</body>
</html>