<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.config.GroupDTO"%>
<%
Map model = (Map)request.getAttribute("MODEL");
ArrayList<GroupDTO> arrlist = (ArrayList)model.get("grouplist");
String GroupID = (String)model.get("GroupID");
String GroupStep = (String)model.get("GroupStep");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>그룹관리</title>
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
	    function goGroup(groupid,step){
	    
	    	names=eval("document.all.selectName");
	    	checkes=eval("document.all.checkName");

	    	for(i=0;i<names.length;i++){

	    		if(names[i].title==groupid){
	    			names[i].style.fontWeight="bold";
			    	names[i].style.color="#ff6600";
			    	checkes[i].checked=true;
	    		}else{
			    	names[i].style.fontWeight="";
			    	names[i].style.color="";
			    	checkes[i].checked=false;
	    		}
	    	}
	    	
	    	parent.group.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupView&GroupID='+groupid;
	    	parent.list.location.href='<%= request.getContextPath() %>/H_Group.do?cmd=groupOrderList&GroupID='+groupid+'&GroupStep='+step;
	    	
	    }
		<!--
		d = new dTree('d');	
		d.clearCookie();
		<%	
		if(arrlist.size() > 0){	

		String cateid="";
		String upcateid="";
		String searchResult="";

			for(int j=0; j < arrlist.size(); j++ ){	
				GroupDTO dto = arrlist.get(j);
				
				cateid=dto.getGroupID();
				upcateid=dto.getUpGroupID();
				searchResult=dto.getSearchResult();

				cateid=cateid.substring(1);
				upcateid=upcateid.substring(1);

	    %>
		d.add('<%=cateid%>','<%=upcateid%>','&nbsp;<input type="checkbox" id=upCateId class="check md0" name="checkName" onClick=goGroup("<%=dto.getGroupID()%>","<%=dto.getGroupStep()%>");><a href=javascript:goGroup("<%=dto.getGroupID()%>","<%=dto.getGroupStep()%>")><span  id=selectName title=<%=dto.getGroupID()%> ><%=dto.getGroupName()%></span></a>','#','','','images/tree/folder.gif');	
		<%
			}
		}
		%>
		document.write(d);
		//-->
	</script>
  </div>
</form>
</body>
</html>
<script>
<%	
if(arrlist.size() > 0){	

String searchResult="";

	for(int k=0; k < arrlist.size(); k++ ){	
		GroupDTO dto = arrlist.get(k);

		searchResult=dto.getSearchResult();

		if(0<k && k<arrlist.size()-1 && searchResult.equals("1")){
			%>
			d.o(<%=k%>);	
			<%
		}
	}
}
%>
goGroup("<%=GroupID%>",<%=GroupStep%>);
d.openAll();
</script>