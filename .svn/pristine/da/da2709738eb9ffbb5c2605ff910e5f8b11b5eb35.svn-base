<%@page import="java.net.URLEncoder"%>
<%@page import="org.directwebremoting.util.SystemOutLoggingOutput"%>
<%@page import="com.huation.framework.data.DataSet"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("curPage");   //현재 페이지 번호
	String strPageCnt = (String) model.get("pageCnt"); //총 페이지 개수
	int intPageCnt = Integer.parseInt(strPageCnt); 
	String category = (String) model.get("category");
	String searchWord = (String) model.get("searchWord");

%> 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추가게시판 리스트</title>
		<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
		<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
		<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
		<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		
			/** 
			 * 
			 * 페이지 최초 접속
			 *
			 */
			$(document).ready(function(){
				searchChk();
			});
			
		
			
			
			/** 
			 * 
			 * '전체'검색기능 -> disabled 처리
			 *
			 */
			function searchChk(){
				var category = $("#category option:selected").val();
				if(category == "total"){
					$("#textfield_search2").attr("disabled", true);
					$("#textfield_search2").val("");
				}else {
					$("#textfield_search2").removeAttr("disabled");
				}
			}
			
			 
			 
			 
			 
			/** 
			 * 
			 * 검색 기능
			 *
			 */
			function goSearch(){
				var curPage = $("#curPage").val();
				var category = $("#category").val();
				var searchWord = $("#textfield_search2").val();
				
				if(!searchWord && category == 'title'){
					alert("검색어를 입력해 주세요!");
					$("#searchWord").focus();
					return false;
				}else if(category == 'total'){
					return false;
				}
				
				var uri = "<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList&curPage="+curPage+"&category="+category+"&searchWord="+searchWord;
				uri = encodeURI(uri);
				location.href=uri;
			}
			

			
			
			
			
			
			/** 
			 * 
			 * 스트라이프 테이블
			 *
			 */
			$(function(){
				$("tr:nth-child(odd)").addClass("odd");
				$("tr:nth-child(even)").addClass("even");
				
				//마우스오버로 행에 하이라이트효과
				$("tr:not(:first-child)").mouseover(function(){
					$(this).addClass("hover");
				}).mouseout(function(){
					$(this).removeClass("hover");
				});
			});
			

			
			
			
			
			
			/** 
			 * 
			 * 등록하기 클릭 -> 쓰기 Form으로 이동
			 *
			 */
			function goRegist(){
				location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardRegistForm";
			}


			 
			 
			 
			/** 
			 * 
			 * 상세페이지 이동
			 *
			 */
			function goDetail(addBoardSeq, curPage, category, searchWord){
				
				var uri = "<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage+"&category="+category+"&searchWord="+searchWord;
				uri = encodeURI(uri);
				location.href=uri;
			}

			
			
			 
			
			/** 
			 * 
			 * 페이지 넘버링 이동
			 *
			 */
			function movePg(pageNum, direction){
				if(direction == "" || direction == null){
					location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList&curPage="+pageNum;	
				}else if(direction == "prev"){
					var intPageNum = (pageNum*1)-1;
					if(intPageNum > 0){
						location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList&curPage="+intPageNum;	
					}
				}else if(direction == "next"){
					var intPageNum = (pageNum*1)+1;
					if(intPageNum <= <%=intPageCnt%>){
						location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList&curPage="+intPageNum;	
					}
				}
			}
			
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
				<div class="content_navi">게시판 &gt; 추가게시판</div>
				<h3><span>추</span>가게시판</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
				<div class="con">
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area">
						<!-- 조회 -->
						<%
							ListDTO ld = (ListDTO) model.get("listInfo");			
							DataSet ds = (DataSet) ld.getItemList();
						%>
						<form action="<%=request.getContextPath()%>/B_AddBoard.do?cmd=addBoardView" class="search">
							<input type="hidden" name="curPage" id="curPage" value="<%=curPage%>">
							
							<fieldset>
								<legend>검색</legend>
								<ul>
									<li>
										<select name="category" id="category" onchange="searchChk()">
											<option value="total" checked>전체</option>
											
											<%
												if(category.equals("title")){
											%>
												<option value="title" selected>제목</option>
											
											<%
												}else {
											%>
												<option value="title">제목</option>
											<%		
												}//if
											%>
											
										</select>
									</li>
									<li>
										<input type="text" class="text" id="textfield_search2" maxlength="100" value="<%=searchWord%>">
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
							<a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a>
						</div>
						<!-- //Top 버튼영역 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
					<!-- 리스트 -->
					<table class="tbl_type tbl_type_list" summary="추가게시판리스트(첨부파일, 게시자, 등록일, 등록시간, 제목, 조회수)">
					
						<colgroup>
							<col width="5%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="*" />
							<col width="5%" />
						</colgroup>
					
						<thead>
						<tr>
							<th>첨부파일</th>
							<th>게시자</th>
							<th>등록일</th>
							<th>등록시간</th>
							<th>제목</th>
							<th>조회수</th>
						</tr>
						</thead>
						
							<!-- 반복시작 -->
							<%
								if(ld.getItemCount() > 0){
									int i = 0;
									while(ds.next()){
							%>
							<tbody>		
							<tr>		
								<td>
								
								<%
								String boardFile = ds.getString("boardFile");
								String boardFileNm = ds.getString("boardFileNm");
								String serverUrl = "" + request.getContextPath();
								int c_index = boardFile.lastIndexOf("/");
								String boardFileName = boardFile.substring(c_index+1);  //가공된 파일명(원본명X)
								String boardPath = "";  //파일경로 읽어오기
								
								//한글파일명 꺠짐 테스트 중...............
								boardFileName = URLEncoder.encode(boardFileName, "UTF-8");
								
								if(!boardFile.equals("")){
									boardPath = boardFile.substring(0, c_index);
									
									//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
			                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
									String spStrReplace = "";
									if(boardFileNm.indexOf("&") != -1){
										spStrReplace = boardFileNm.replace("&", "[replaceStr]");
										//System.out.println("spStrReplace:"+spStrReplace);
									}else {
										spStrReplace = boardFileNm;
										//System.out.println("spStrReplace:"+spStrReplace);
									}//if
									
									//첨부파일명 한글깨짐 처리
									spStrReplace = URLEncoder.encode(spStrReplace, "UTF-8");
								%>
								<a href="<%=serverUrl%>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=boardFileName%>&filePath=<%=boardPath%>">
									<img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="첨부파일">
								</a>
								 
								<%	
								}//if
								%>
								
								</td>		
								<td><%= ds.getString("writeUser") %></td>
								<td><%= ds.getString("createDateTime").substring(0,10) %></td>
								<td><%= ds.getString("createDateTime").substring(11,19) %></td>		
								<td class="text_l" title="<%=ds.getString("title")%>">
									<span class="ellipsis">
										<a href="javascript:goDetail(<%=ds.getInt("addBoardSeq") %>, curPage.value, category.value, textfield_search2.value);">&nbsp;<%= ds.getString("title") %>
										<%
										int comCnt = ds.getInt("comCnt");
										if(comCnt != 0){
											%>
											<span style="font-weight:bold;color:red;">[<%= comCnt %>]</span>
											<%
										}%>
										</a>
									</span>
								</td>
								<td><%= ds.getString("readCount") %></td>
								<%
									i++;
								}//while
							} else {
							%>
							<tr>
					          <td colspan="6">게시물이 없습니다.</td>
					        </tr>
							<%	
							}
							%>
							</tr>
							<!-- 반복 끝 -->
						</tbody>
					</table>
					
						<!-- paging -->
						<div class="paging">
							<span>
								<!-- 제일 첫 페이지로 이동 -->
								<%
								int intCurPage = Integer.parseInt(curPage);
								if(intCurPage == 1){
								%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_first_off.gif">
								</span>
								<%	
								}else {
								
								%>
								<span class="direction_off pd0">
									<a href="javascript:movePg(1);"><img alt="" src="images/sub/btn_first_off.gif"></a>
								</span>
								<%
								}//if
								%>
								
								<!-- 이전 페이지로 이동 -->
								<span class="direction_off pd0">
									<a href="javascript:movePg(curPage.value, 'prev');"><img alt="" src="images/sub/btn_prev_off.gif"></a>
								</span>
							</span>
							
							<!-- 페이지넘버링 - 반복구간 시작 -->
							<%
							
							for(int i=0; i<intPageCnt; i++){
								if((i+1) == intCurPage){
							%>
							<span>
								<strong><%=i+1%></strong>
							</span>		
							
							<%		
								}else {
							%>
							<span>
								<a href="javascript:movePg(<%=i+1%>);"><%=i+1%></a>
							</span>
							<%		
								}//if
							}//for
							%>
												
								
							<span>
								<!-- 다음 페이지로 이동 -->	
								<span class="direction_off pd0"">
									<a href="javascript:movePg(curPage.value, 'next');"><img alt="" src="images/sub/btn_next_off.gif"></a>
								</span>
								
								<!-- 제일 마지막 페이지로 이동 -->
								<%
								if(intCurPage == intPageCnt){
								%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_last_off.gif">
								</span>
								<%	
								}else {
								%>
								<span class="direction_off pd0">
									<a href="javascript:movePg(<%=intPageCnt%>);"><img alt="" src="images/sub/btn_last_off.gif"></a>
								</span>
								<%	
								}//if
								%>
							</span>
						</div>
						<!-- //paging -->
						
						<!-- Bottom 버튼영역 -->
						<div class="Bbtn_areaR">
							<a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a>
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
<%= comDao.getMenuAuth(menulist,"36") %>