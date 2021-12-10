<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>추가 게시판 등록</title>
		<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
		<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script type="text/javascript">
			
			/* 
			 * 
			 * 등록하기
			 *
			 */
			function goSave(){
				
				//변수선언
				var frm = document.addBoardRegist;
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
				
				frm.boardFileNm.value = strFileName;
				frm.submit();
				
			}
			
			
			
			
			
			/* 
			 * 
			 * 취소하기
			 *
			 */
			function goCancel(){
				
				//변수선언
				var frm = document.addBoardRegist;
				frm.action='<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList';
				frm.submit();
			}
		</script>
	</head>
	<body>
		<!-- <h1>추가게시판 쓰기 페이지</h1> -->
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
					<div class="conTop_area" id="excelBody">
						<!-- 필수입력사항텍스트 -->
						<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
						<!-- //필수입력사항텍스트 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
					
					<!-- 등록 -->
					<form action="<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardRegist" method="post" name="addBoardRegist" enctype="multipart/form-data">
						<input type="hidden" name="curPage" value="">
						<input type="hidden" name="user_id" value="">
						<fieldset>
							<legend>추가게시판 등록</legend>
							
							<table class="tbl_type" summary="추가게시판등록(게시자, 첨부파일, 제목, 내용)">
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
										</span>게시자
										</label>
									</th>
									<td>
										<input type="text" id="writeUser" name="writeUser" class="text dis" title="게시자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/>
									</td><!-- input 비활성화 class="dis" 추가 -->
								</tr>
								<input type="hidden" name="boardFileNm" value=""></input>
								<tr>
									<th><label for="">첨부파일</label></th>
									<td>
										<div class="fileUp">
											<input type="text" class="text" id="file1" title="첨부파일" style="width:550px;" />
											<a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a>
											<input type="file" name="boardFile" id="upload1" />
										</div>
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
										<input type="text" id="title" name="title" class="text" title="제목" style="width:916px;" maxlength="100"/>
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
										<textarea id="contents" name="contents" title="내용" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('10000', this)"></textarea>
									</td>
								</tr>
								</tbody>
							</table>
						</fieldset>
					</form>
					<!-- //등록 -->
					
					<!-- Bottom 버튼영역 -->
					<div class="Bbtn_areaC">
						<a href="javascript:goSave();" class="btn_type02"><span>등록</span></a>
						<a href="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>취소</span></a>
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
<script type="text/javascript">fn_fileUpload();</script>