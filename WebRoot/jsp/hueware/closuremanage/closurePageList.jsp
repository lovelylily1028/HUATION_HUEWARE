<%@page import="java.net.URLEncoder"%>
<%@page import="org.directwebremoting.util.SystemOutLoggingOutput"%>
<%@page import="com.huation.framework.data.DataSet"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>휴폐업 리스트</title>
		<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
		<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
		<link href="<%= request.getContextPath()%>/css/layout.css"  rel="stylesheet" type="text/css"/>
		<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			
		</script>
	</head>
<body>

	<div id="wrap">
	 
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	
		<!-- container -->
		<div id="container">
			<div id="content">
				<div class="content_navi">게시판 &gt; 휴폐업</div>
				<h3><span>휴</span>폐업 조회</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
				<div class="con">
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area">
						<!-- 조회 -->
						<%-- <%
							ListDTO ld = (ListDTO) model.get("listInfo");			
							DataSet ds = (DataSet) ld.getItemList();
						%> --%>
						<form action="<%=request.getContextPath()%>/B_ClosureMg.do?cmd=ClosureView" class="search">
							<input type="hidden" name="curPage" id="curPage" value="0">
							
							<fieldset>
								<legend>검색</legend>
								<ul>
									<li>
										<select name="category" id="category" onchange="searchChk()">
											<option value="total" checked>사업자번호</option>
											<option value="tem_close">상호명</option>
											
											<%-- <%
												if(category.equals("title")){
											%>
												<option value="title" selected>제목</option>
											
											<%
												}else {
											%>
												<option value="title">제목</option>
											<%		
												}//if
											%> --%>
											
										</select>
									</li>
									<li>
										<input type="text" class="text" id="textfield_search2" maxlength="100" value="">
									</li>
									<li>
										<a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a>
									</li>
								</ul>
							</fieldset>
						</form>
						<!-- //조회 -->
						<!-- Top 버튼영역 -->
						<div class="Tbtn_areaR">
							<!-- 등록하기 -->
							<a href="javascript:goRegist();" class="btn_type01 md0"><span>엑셀 업로드</span></a>
						</div>
						<!-- //Top 버튼영역 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
					<!-- 리스트 -->
					<table class="tbl_type tbl_type_list" summary="추가게시판리스트(첨부파일, 게시자, 등록일, 등록시간, 제목, 조회수)">
					
						<colgroup>
							<col width="15%" />
							<col width="20%" />
							<col width="40%" />
							<col width="10%" />
							<col width="*" />
						</colgroup>
					
						<thead>
						<tr>
							<th>사업자등록번호</th>
							<th>상호명</th>
							<th>사업자구분</th>
							<th>상태</th>
							<th>휴폐업일</th>
						</tr>
						</thead>
						<tbody>	
							<!-- 출력부분 -->	
							<tr>		
								<td>108-81-93762</td>
								<td>(주)휴에이션</td>
								<td>부가가치세 일반과세자 입니다.</td>
								<td>정상</td>		
								<td>-</td>		
							<tr>
							<!-- 출력끝 -->
						</tbody>
					</table>
						<!-- paging -->
						<div class="paging">
							<span>
								<!-- 제일 첫 페이지로 이동 -->
								<%-- <%
								int intCurPage = Integer.parseInt(curPage);
								if(intCurPage == 1){
								%> --%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_first_off.gif">
								</span>
								<%-- <%	
								}else {
								
								%> --%>
								<span class="direction_off pd0">
									<a href="javascript:movePg(1);"><img alt="" src="images/sub/btn_first_off.gif"></a>
								</span>
								<%-- <%
								}//if
								%> --%>
								
								<!-- 이전 페이지로 이동 -->
								<span class="direction_off pd0">
									<a href="javascript:movePg(curPage.value, 'prev');"><img alt="" src="images/sub/btn_prev_off.gif"></a>
								</span>
							</span>
							
							<!-- 페이지넘버링 - 반복구간 시작 -->
							<%-- <%
							
							for(int i=0; i<intPageCnt; i++){
								if((i+1) == intCurPage){
							%> --%>
							<span>
								<strong>1</strong>
							</span>		
							<%-- 
							<%		
								}else {
							%> --%>
							<!-- <span>
								<a href="javascript:movePg();">1</a>
							</span> -->
							<%-- <%		
								}//if
							}//for
							%> --%>
												
								
							<span>
								<!-- 다음 페이지로 이동 -->	
								<span class="direction_off pd0"">
									<a href="javascript:movePg(curPage.value, 'next');"><img alt="" src="images/sub/btn_next_off.gif"></a>
								</span>
								
								<!-- 제일 마지막 페이지로 이동 -->
								<%-- <%
								if(intCurPage == intPageCnt){
								%> --%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_last_off.gif">
								</span>
								<%-- <%	
								}else {
								%> --%>
								<span class="direction_off pd0">
									<a href="javascript:movePg(1);"><img alt="" src="images/sub/btn_last_off.gif"></a>
								</span>
								<%-- <%	
								}//if
								%> --%>
							</span>
						</div>
						<!-- //paging -->
						
						<!-- Bottom 버튼영역 -->
						<div class="Bbtn_areaR">
							<a href="javascript:goRegist();" class="btn_type01 md0"><span>엑셀 다운로드</span></a>
						</div>
						<!-- //Bottom 버튼영역 -->
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
<%= comDao.getMenuAuth(menulist,"37") %>