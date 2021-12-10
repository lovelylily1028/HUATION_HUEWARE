<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.user.UserBroker"%>
<%@page import="com.huation.common.addBoard.AddBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="UTF-8"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("pageNo");
	String category = (String)model.get("category");
	String searchWord = (String)model.get("searchWord");
	AddBoardDTO abDto = (AddBoardDTO) model.get("abDto");
	String boardFile = (String) model.get("boardFile");
	String boardFileNm = (String) model.get("boardFileNm");
	String comCnt = (String) model.get("comCnt");
	String comPageCnt = (String) model.get("comPageCnt");
	int intComPageCnt = Integer.parseInt(comPageCnt);
	String comPageNo = (String) model.get("comPageNo");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추가게시판 상세정보</title>
		<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
		<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		

		
		/* ===============================================================
		 *
		 *                           게시판 부분
		 *
		 * ===============================================================
		 */


		
		/* 
		* 
		* 목록 버튼 -> 게시글 리스트로 이동
		*
		*/
		function goList(){
			
			//참고 : url매개변수로 검색관련 값(category, searchWord)을 같이 넘기면 페이지가 로딩되지 않음
			var curPage = $("#curPage").val();
			location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList&curPage="+curPage;
			
		}
		
		
		
		/* 
		* 
		* 게시글 수정하기
		*
		*/
		function goModify(){
			
			//변수선언
			var frm = document.boardDetailForm;
			var title = $("#title").val();
			var contents = $("#contents").val();
			
			  
			//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
			var strFile = frm.boardFile.value;
			//alert(strFile);
			var lastIndex = strFile.lastIndexOf('\\');
			//alert(lastIndex);
			var strFileName= strFile.substring(lastIndex+1);
			//alert(strFileName);
			if(fileCheckNm(strFileName)> 200){
				alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
				return;
			}
			
			//첨부파일명 글자수(byte) 체크
			function fileCheckNm(szValue){
				var tcount=0;
				var tmpStr = new String(szValue);
				var temp = tmpStr.length;
				var onechar;
				for(k=0; k<temp; k++){
					onechar = tmpStr.charAt(k);
					if(escape(onechar).length>4){
						tcount +=2;
						
					}else{
						tcount +=1; 
					}
				}
				return tcount;
			}//fileCheckNm()
			
			
			if(!title){
				alert("제목을 입력하세요!");
				$("#title").focus();
				return false;
			}
			
			if(!contents){
				alert("내용을 입력하세요!");
				$("#contents").focus();
				return false;
			}
			
			if(confirm("수정하시겠습니까?")){
				frm.boardFileNm.value = strFileName;	
				frm.submit();
			}else {
				return false;
			}
			
		}
		 
		
		
		/* 
		* 
		* 게시글 삭제하기
		*
		*/
		function goDelete(){
			
			var curPage = $("#curPage").val();
			
			if(confirm("정말 삭제하시겠습니까?")){
				var addBoardSeq = <%=abDto.getAddBoardSeq()%>;
				location.href = "<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardDelete&addBoardSeq="+addBoardSeq+"&curPage="+curPage;
			}else{
				return false;
			}
			
		}
		
		
		
		
		
		
		
		
		/* ===============================================================
		 *
		 *                           댓글 부분
		 *
		 * ===============================================================
		 */
		
		
		
		/* 
		* 
		* 댓글 저장하기
		*
		*/
		function goComSave(){
			
			var comFrm = document.addBoardComForm;
			
			if(!$("#comContents").val()){
				alert("내용을 입력해 주세요!");
				$("#comContents").focus();
				return false;
			}
	
			comFrm.action = "<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardComRegist";
			comFrm.submit();
			
		}
		
		
		
		/* 
		* 
		* 댓글 byte 체크
		*
		*/
		/* 
		$(document).ready(function(){
			
			$("#comContents").keyup(function(){
				
				var comContents = $("#comContents").val();
				stringByteLength = comContents.replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length;
				$(".guide_byte span").text(stringByteLength);
				if(stringByteLength > 100){
					alert("글자는 100byte까지 입력가능합니다.");
					$("#comContents").focus();
				}
			});//keyup
			
		});
		 */
		
		 
		 
		 
		/* 
		* 
		* 댓글 수정하기
		*
		*/
		function goComModify(comSeq){
			 
			 var comFrm = document.addBoardComForm;
			 
			 var comContentsModify = $("#comContentsModify").val();
			 if(!comContentsModify){
				 alert("내용을 입력해 주세요!");
				 $("#comContentsModify").focus();
				 return false;
			 }
			 
			comFrm.action = "<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardComModify&comSeq="+comSeq;
			comFrm.submit();
			 
			 
		 }
		 
		
		 
		 
		 
		 /* 
		  * 
		  * 댓글 삭제하기
		  *
		  */
		 function goComDelete(comSeq){
			 
			 var addBoardSeq = $("#addBoardSeq").val();
			 var comWriteUser = $("#comWriteUser").val();
			 
			 if(confirm("정말 삭제하시겠습니까?")){
				 location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardComDelete&comSeq="+comSeq+"&addBoardSeq="+addBoardSeq+"&comWriteUser="+comWriteUser;
			 }else {
				 return false;
			 }
			 
		 }
		 
		 
		 
		 
		 
		 /* 
		  * 
		  * 댓글 페이징 이동
		  *
		  */
		 function moveComPg(pageNum, direction){
			 
			 var addBoardSeq = $("#addBoardSeq").val();
			 var curPage = $("#curPage").val();
			 
			 if(direction == "" || direction == null){
				 location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage+"&comPageNo="+pageNum;
			 }else if(direction == 'prev'){
				 var intComPageNum = (pageNum*1)-1;
				 if(intComPageNum > 0){
					 location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage+"&comPageNo="+intComPageNum; 
				 }
			 }else if(direction == 'next'){
				 var intComPageNum = (pageNum*1)+1;
				 if(intComPageNum <= <%=intComPageCnt%>){
					 location.href="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage+"&comPageNo="+intComPageNum; 
				 }
			 }
		 }//moveComPg()
		  
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
				<!-- 추가게시판상세정보 -->
				<div>
					<h4 class="hidden_obj">추가게시판 상세정보</h4>
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area" id="excelBody">
						<!-- 필수입력사항텍스트 -->
							<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>						
						<!-- //필수입력사항텍스트 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
				
					<!-- 등록 -->
					<form action="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardModify" name="boardDetailForm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="curPage" id="curPage" value="<%=curPage%>">
						<input type="hidden" name="category" id="category" value="<%=category%>">
						<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>">
						<input type="hidden" name="addBoardSeq" id="addBoardSeq" value="<%=abDto.getAddBoardSeq()%>">
						<fieldset>
							<legend>추가게시판상세정보</legend>
							
							<table class="tbl_type" summary="추가게시판상세정보(게시자, 첨부파일, 제목, 내용)">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								
								<tbody>
								
								<tr>
									<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
									<th>
										<label for="">
											<span class="must_ico">
												<img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" />
											</span>
										게시자</label>
									</th>
									<td>
										<input type="text" id="userName" name="userName" class="text dis" title="게시자" style="width:200px;" readOnly value="<%=abDto.getUserName() %>">
									</td><!-- input 비활성화 class="dis" 추가 -->
								</tr>
								
								
								<!-- 조건문 시작 -->
								<%
									if(UserBroker.getUserId(request).equals(abDto.getWriteUser())){
								%>
								<tr>
									<th><label for="">첨부파일</label></th>
									<td>
										<div class="fileUp">
											<input type="text" class="text" id="file1" title="첨부파일" style="width:550px;" value="<%=boardFile%>" />
											<a href="#link" class="btn_type03" value="찾아보기">
												<span>찾아보기</span>
											</a>
											<input type="file" name="boardFile" id="upload1" />
										</div>
										<input type="hidden" name="boardFileNm" value="">
										<span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span>
									</td>
								</tr>
								
								<tr>
									<th>
										<label for="">
											<span class="must_ico">
												<img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" />
											</span>
										제목</label>
									</th>
									<td>
										<input type="text" id="title" name="title" value="<%=abDto.getTitle() %>" class="text" title="제목" style="width:916px;" maxlength="100">	
									</td>
								</tr>
								
								<tr>
									<th>
										<label for="">
											<span class="must_ico">
												<img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" />
											</span>
										내용</label>
									</th>
									<td>
										<textarea rows="" cols="" id="contents" name="contents" title="내용" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('10000', this)"><%=abDto.getContents()%></textarea>
									</td>
								</tr>
								
								<%	
								}else {
								%>
								
								<tr>
									<th><label for="">첨부파일</label></th>
									<td>
										<div class="fileUp">
											<input type="text" class="text dis" class="text" id="file1" title="첨부파일" style="width:550px;" readonly value="<%=boardFile%>" />
											<a href="#link" class="btn_type03" value="찾아보기">
												<span>찾아보기</span>
											</a>
											<input type="file" name="boardFile" id="upload1" />
										</div>
										<input type="hidden" name="boardFileNm" value="">
										<span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span>
									</td>
								</tr>
								
								<tr>
									<th>
										<label for="">
											<span class="must_ico">
												<img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" />
											</span>
										제목</label>
									</th>
									<td>
										<input type="text" id="" name="" readonly value="<%=abDto.getTitle() %>" class="text dis" class="text" title="제목" style="width:916px;" maxlength="100">	
									</td>
								</tr>
								
								<tr>
									<th>
										<label for="">
											<span class="must_ico">
												<img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" />
											</span>
										내용</label>
									</th>
									<td>
										<textarea rows="" cols="" id="" name="" title="내용" class="text dis" style="width:916px;height:248px;" readonly onKeyUp="js_Str_ChkSub('10000', this)"><%=abDto.getContents()%></textarea>
									</td>
								</tr>
								
								<%
								}
								%>
								<!-- 조건문 끝 -->
								</tbody>
							</table>
						</fieldset>
					</form>
					<!-- //등록 -->
				</div>
				<!-- //추가게시판상세정보 -->
				
				<!-- 댓글 -->
				<div class="reply_area">
					<h4>댓글</h4>
					<p class="total">전체 글갯수 <strong><%=comCnt%></strong>개</p>
					<form action="" name="addBoardComForm" method="post">
					<input type="hidden" name="comWriteUser" id="comWriteUser" value="<%=dtoUser.getUserId()%>">  
					<input type="hidden" name="addBoardSeq" id="addBoardSeq" value="<%=abDto.getAddBoardSeq()%>">
					<input type="hidden" name="curPage" id="curPage" value="<%=curPage%>"> 
					<input type="hidden" name="comPageNo" id="comPageNo" value="<%=comPageNo%>"> <!-- 댓글 현재 페이지 번호 -->
					<fieldset>
						<legend>댓글</legend>	
						<%
							ListDTO ldCom = (ListDTO) model.get("comListInfo");
							DataSet ds = (DataSet) ldCom.getItemList();
							
							
							if(ldCom.getItemCount() > 0){
								int i = 0;
								while(ds.next()){
						%>
						
						<dl class="replyList">
							<dt><%=ds.getString("userName") %>&nbsp;
								<span><%=ds.getString("comCreateDateTime") %></span>
								<%
									String comWriteUser = ds.getString("comWriteUser");
									if(dtoUser.getUserId().equals(comWriteUser)){
								 %>
									<a href="javascript:goComModify(<%=ds.getInt("comSeq")%>)" class="btn_type03"><span>수정</span></a>&nbsp;
									<a href="javascript:goComDelete(<%=ds.getInt("comSeq")%>)" class="btn_type03"><span>삭제</span></a>
								</dt>
								<dd>
									<input type="text" id="comContentsModify" name="comContentsModify" class="text" value="<%=ds.getString("comContents") %>" style="ime-mode:active;width:1078px;height:27px;line-height:27px;" onKeyUp="js_Str_ChkSub('100', this)" onfocus="contentsChange(this,0)" onblur="contentsChange(this,1)" />
								</dd>
							</dl>
								 <%		
								 	}else {
								 %>
								 </dt>
 								 <dd>
 								 	<input type="text" id="" name="" class="text dis" class="text" readonly="readonly" value="<%=ds.getString("comContents") %>" style="ime-mode:active;width:1078px;height:27px;line-height:27px;" onKeyUp="js_Str_ChkSub('100', this)" onfocus="contentsChange(this,0)" onblur="contentsChange(this,1)" />
								 </dd>
							 </dl>
								<%		
								 	}//if
								i++;
								}//while
								%>
						<!-- 댓글 페이징 -->
						<!-- paging -->
						<div class="paging">
							<span>
								<!-- 제일 첫 페이지로 이동 -->
								<%
								int intComPageNo = Integer.parseInt(comPageNo);
								if(intComPageNo == 1){
								%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_first_off.gif">
								</span>
								<%	
								}else {
								%>
								<span class="direction_off pd0">
									<a href="javascript:moveComPg(1);"><img alt="" src="images/sub/btn_first_off.gif"></a>
								</span>
								<%	
								}//if
								%>
								
								<!-- 이전 페이지로 이동 -->
								<span class="direction_off pd0">
									<a href="javascript:moveComPg(comPageNo.value, 'prev');"><img alt="" src="images/sub/btn_prev_off.gif"></a>
								</span>
							</span>
							
							<!-- 페이지넘버링 - 반복구간 -->
							<%
							for(int j=0; j<intComPageCnt; j++){
								if((j+1) == intComPageNo){
							%>
							<span>
								<strong><%=j+1%></strong>
							</span>
							
							<%			
								}else {
							%>
							<span>
								<a href="javascript:moveComPg(<%=j+1%>);"><%=j+1%></a>
							</span>
							<%			
								}//if
							}//for
							
							%>
												
							<!-- //페이지넘버링 - 반복구간 -->
								
							<span>
								<!-- 다음 페이지로 이동 -->	
								<span class="direction_off pd0"">
									<a href="javascript:moveComPg(comPageNo.value, 'next');"><img alt="" src="images/sub/btn_next_off.gif"></a>
								</span>
								
								<!-- 제일 마지막 페이지로 이동 -->
								<%
								if(intComPageNo == intComPageCnt){
								%>
								<span class="direction_off pd0">
									<img alt="" src="images/sub/btn_last_off.gif">
								</span>
								<%	
								}else {
								%>
								<span class="direction_off pd0">
									<a href="javascript:moveComPg(<%=comPageCnt%>);"><img alt="" src="images/sub/btn_last_off.gif"></a>
								</span>
								<%	
								}//if
								%>
							</span>
						</div>
						<!-- //paging -->
						<!-- //댓글 페이징 -->
						<%
							}//if
						%>
						
						<!-- 댓글 등록하기 -->
						<dl class="replyCon">
							<dt>
								<input type="text" id="comContents" name="comContents" class="text" title="댓글내용" style="ime-mode:active;width:1078px;height:27px;line-height:27px;" onKeyUp="js_Str_ChkSub('100', this)" onfocus="contentsChange(this,0)" onblur="contentsChange(this,1)" placeholder="주제에 맞지 않는 덧글, 비방, 악성 덧글은 모니터링 후 삭제될 수 있습니다." />
							</dt>
							<dd class="btn_regist">
								<a href="javascript:goComSave();">등록</a>
							</dd>
							<dd>
								<span class="guide_txt">* 댓글은(한글/영문)<span>100byte</span> 이내 입력 가능합니다.</span>
								<!-- 댓글 바이트 수 제한 -->
								<!-- &nbsp;&nbsp;<span class="guide_byte"><span>0</span>&nbsp;bytes</span> --> 
							</dd>
						</dl>
						
						<!-- //댓글 등록하기 -->
					</fieldset>	
					</form>
				</div>
				<!-- //댓글 -->
				
				<!-- Bottom 버튼 영역 -->
				<%
					if(UserBroker.getUserId(request).equals(abDto.getWriteUser())){
				%>
				<div class="Bbtn_areaC">
					<a href="javascript:goModify()" class="btn_type02"><span>수정</span></a>
					<a href="javascript:goDelete()" class="btn_type02 btn_type02_gray"><span>삭제</span></a>
					<a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
				</div>
				
				<%
				}else {
				%>
				<div class="Bbtn_areaC">
					<a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
				</div>
				
				<%
				}//if
				%>
				<!-- //Bottom 버튼 영역 -->
				
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
<script type="text/javascript">fn_fileUpload();</script>