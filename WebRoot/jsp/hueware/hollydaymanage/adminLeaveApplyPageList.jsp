<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ް���û</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>


</head>
<%
Map model = (Map)request.getAttribute("MODEL"); 

String curPage = (String)model.get("curPage");
String searchGb = (String)model.get("searchGb");
String searchtxt = (String)model.get("searchtxt");
String StartDT = (String)model.get("StartDT");
String EndDT = (String)model.get("EndDT");
ArrayList<HollyDTO> arraylist = (ArrayList)model.get("arraylist");
HollyDTO atDto = new HollyDTO();
// hollyDayRequestAllList
%>


<script language="javascript">
function goSelect(code,nm,owner,busi,bite,pos,adres,adrtl,permitno){
	//���� (��ü�ڵ�)COMP_CODE=> (��ü��ȣ)PERMIT_NO ���� 2013_03_18(��)shbyeon.
	
// 	self.close();

}
function employLeavePopup(pUserid,pCarrer,pName,pEmployeeNum){
<%-- 	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo&sForm=companyRegist","","width=400,height=500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no"); --%>
	//�ѱ۾ȵǸ� ������.pName��
	document.adminLeaveApplyPageList.pName.value = pName;
	document.adminLeaveApplyPageList.pEmployeeNum.value = pEmployeeNum;
	var a = window.open("<%= request.getContextPath()%>/H_Holly.do?cmd=adminLeaveApplyPageListPopup&pUserid="+pUserid+"&pCarrer="+pCarrer+"&pName="+pName,"","width=800,height=600,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	
	
}

</script>

	<%
// 	ListDTO ld = (ListDTO) model.get("listInfo");
// 	DataSet ds = (DataSet) ld.getItemList();
	
// 	int iTotCnt = ld.getTotalItemCount();
// 	int iCurPage = ld.getCurrentPage();
// 	int iDispLine = ld.getListScale();
// 	int startNum = ld.getStartPageNum();
	%>
  
<body>
			  
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container" style="height: 650px;">
		<div id="content" >
			<div class="content_navi">���� &gt; �ް���ȸ</div>
			<!-- �ް����� -->
			<form method="post" action="<%=request.getContextPath()%>/H_Holly.do?cmd=adminLeaveApplyPageList" name = "adminLeaveApplyPageList" class="search">
			<input type="hidden" name="curPage" value="<%=curPage%>"/>
			<input type="hidden" name="pName" value=""/>
			<input type="hidden" name="pEmployeeNum" value=""/>
			<!-- //�ް����� -->
			<!-- �ް���û��Ȳ -->
			<h3><span>��</span>���� ���� �ް���Ȳ</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con leaveAppPageList">
				<table class="tbl_type tbl_type_list" summary="�ް���û��Ȳ(�������, �ް�����, �ϼ�, ������, ������, �����, ����, ������)">

					<colgroup>
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
						<col width="16%" />
					</colgroup>
					<thead>
					<tr>
						<th>�̸�</th>
						<th>���</th>
						<th>�Ի���</th>
						<th>����(��)</th>
						<th>���� �ް������ϼ�</th>
						<th>�ܿ��ް�</th>
					</tr>
					</thead>
					<tbody>
	<%
		//���� ��� ���·ι޴���
		for(int j=0; j < arraylist.size(); j++){
			atDto = new HollyDTO();
			atDto = arraylist.get(j);
		%>
			<tr>
				<td> <a onclick="javascript:employLeavePopup('<%=atDto.getUserID()%>','<%=atDto.getCareer()%>','<%=atDto.getUserName()%>','<%=atDto.getEmployeeNum()%>');"><%=atDto.getUserName()%></a></td>
				<td><%=atDto.getEmployeeNum()%></td>
				<td><%=atDto.getHireDateTime()%></td>
				<td><%=atDto.getCareer()%></td>
				<td><%=atDto.getTotalHollyDay2()%></td>
				<td><%=atDto.getRemainHollyDay()%></td>
			</tr>
		<%
		}
		%>
					</tbody>
				</table>
				<!-- //����Ʈ -->
				<!-- ����¡  ������. -->
<!-- 				<div class="paging"> -->
<%-- 			      <%=ld.getPagging("goPage")%> --%>
<!-- 			    </div> -->
		<!-- //����¡ -->
			</div>
			<!-- //�ް���û��Ȳ -->
		</div>
	</div>
	<!-- //container -->
		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
		<!-- //footer -->
</div>

</body>
<%= comDao.getMenuAuth(menulist,"83") %>
</html>