<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>휴가신청</title>
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
	//기존 (업체코드)COMP_CODE=> (업체번호)PERMIT_NO 변경 2013_03_18(월)shbyeon.
	
// 	self.close();

}
function employLeavePopup(pUserid,pCarrer,pName,pEmployeeNum){
<%-- 	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo&sForm=companyRegist","","width=400,height=500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no"); --%>
	//한글안되면 오프너.pName로
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
			<div class="content_navi">관리 &gt; 휴가조회</div>
			<!-- 휴가정보 -->
			<form method="post" action="<%=request.getContextPath()%>/H_Holly.do?cmd=adminLeaveApplyPageList" name = "adminLeaveApplyPageList" class="search">
			<input type="hidden" name="curPage" value="<%=curPage%>"/>
			<input type="hidden" name="pName" value=""/>
			<input type="hidden" name="pEmployeeNum" value=""/>
			<!-- //휴가정보 -->
			<!-- 휴가신청현황 -->
			<h3><span>임</span>직원 연간 휴가현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con leaveAppPageList">
				<table class="tbl_type tbl_type_list" summary="휴가신청현황(진행상태, 휴가구분, 일수, 시작일, 종료일, 등록일, 사유, 결재자)">

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
						<th>이름</th>
						<th>사번</th>
						<th>입사일</th>
						<th>연차(만)</th>
						<th>연간 휴가가능일수</th>
						<th>잔여휴가</th>
					</tr>
					</thead>
					<tbody>
	<%
		//현재 어레이 형태로받는중
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
				<!-- //리스트 -->
				<!-- 페이징  없앴음. -->
<!-- 				<div class="paging"> -->
<%-- 			      <%=ld.getPagging("goPage")%> --%>
<!-- 			    </div> -->
		<!-- //페이징 -->
			</div>
			<!-- //휴가신청현황 -->
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