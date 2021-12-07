<%@page import="com.sun.jndi.url.ldaps.ldapsURLContextFactory"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import="com.huation.common.freeboard.FreeBoardDTO" %>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserBroker"%>

<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	FreeBoardDTO fbDto = (FreeBoardDTO)model.get("fbDto");
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>자유게시판 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.freeBoardEdit; 
	/* var fsize = $('#BoardFile')[0].files[0].size;  //파일사이즈 */
	var ffrm = document.freeBoardReplyIframe.freeBoardReplyIframe;
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.BoardFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	//alert(lastIndex);
	var strFileName= strFile.substring(lastIndex+1);
	//alert(strFileName);
	if(fileCheckNm(strFileName)> 200){
		alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
		return;
	}

		
//파일명 글자수(byte) 체크		
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
	}	
if(confirm("수정 하시겠습니까?")){
	frm.action='<%=request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardEdit'
	if(frm.Title.value == ""){
		alert("제목을 입력하세요.");
		return;
	}
	if(frm.Contents.value == ""){
		alert("내용을 입력하세요.");
		return;
	}
/* 	if(fsize > 524288000 ){   //파일용량 체크
		alert("첨부하신 파일이 용량을 초과했습니다.최대 500M 까지 가능합니다.");
		return;
	}
	if(fsize > 104857600 ){   //용량이큰 100MB ~500M alert창뜨게
		alert("파일 업로드 중입니다. 잠시만 기다려주세요.");
	} */
	/*
	if(frm.NotifyFile.value != "" && !isFile(frm.NotifyFile.value)){
			alert("첨부 가능한 파일 유형은 \n PDF, GIF, JPG, TIF, BMP, XML, XLSX 이상 7종 입니다.");
			return; 				
	}
	*/
	if (strFileName!=''){
	frm.BoardFileNm.value = strFileName;
	}
	
	frm.submit();
	
	}
	
}


	/**
	 * 파일 확장자명 체크
	 *
	function isFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp" || ext == "xls" || ext == "xlsx") {
				return true;
			} else {
				return false;
			}
		}
	}
	 **/ 

	//삭제
	function goDelete(){
		
		var frm = document.freeBoardEdit;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardDelete';
			frm.submit();
		}

	}
	//목록
	function goList(){
		
		
		var frm = document.freeBoardEdit;
		frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardPageList2';
		frm.submit();

	}
	//덧글입력
	function goSaveRep(){
		
		var frm = document.freeBoardEdit;
		if(confirm("덧글을 등록하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardRegistRep&SeqBoard=<%=fbDto.getSeq()%>&WriteUserBoard=<%=fbDto.getWriteUser()%>&TitleBoard=<%=fbDto.getTitle()%>';
			frm.submit();
		}
	}
	//덧글삭제
	function goDeleteRep(SeqRep){
		
		var frm = document.freeBoardEdit;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardDeleteRep';
			frm.SeqRep.value=SeqRep;
			frm.submit();
		}

	}
	
	
//-->
</SCRIPT>


<script language="JavaScript">

//iframe resize

function calcHeight() 
{ 
  //find the height of the internal page 
  var the_height= 
    document.getElementById('freeBoardReplyIframe').contentWindow. 
      document.body.scrollHeight; 
  
  //change the height of the iframe 
  document.getElementById('freeBoardReplyIframe').height= 
      the_height; 
} 
</script>

</head>
<body >
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">게시판 &gt; 자유게시판</div>
			<h3><span>자</span>유게시판상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 자유게시판상세정보 -->
				<div>
					<h4 class="hidden_obj">자유게시판상세정보</h4>
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area" id="excelBody">
						<!-- 필수입력사항텍스트 -->
						<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
						<!-- //필수입력사항텍스트 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
				
				<!-- 등록 -->
			    <form name="freeBoardEdit" method="post" action="<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardPageListRep" enctype="multipart/form-data">
			     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
				  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
				  <!-- Update 수정시 필요한 pk 값 : Seq 넘겨줘야된다.  -->
				  <input type="hidden" name="Seq" value="<%=fbDto.getSeq()%>"></input>
			  	  <input type="hidden" name="SeqRep" value="<%=fbDto.getSeqRep()%>"></input>

					<fieldset>
						<legend>자유게시판상세정보</legend>
						
						<table class="tbl_type" summary="자유게시판상세정보(게시자, 첨부파일, 제목, 내용)">
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							
							<tbody>
							
							<tr>
								<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>게시자</label></th>
								<td><input type="text" id="" class="text dis" title="게시자" style="width:200px;" readOnly value="<%=fbDto.getWriteUserName()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
							</tr>	
					        
					        <%
					    		
					    	if(UserBroker.getUserId(request).equals(fbDto.getWriteUser())){
					 			
					    	%>	
					    	
					    	<tr>
								<th><label for="">첨부파일</label></th>
								<td><div class="fileUp"><input type="text" class="text" id="file1" title="첨부파일" style="width:561px;" value="<%=fbDto.getBoardFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BoardFile" id="upload1" /></div><input type="hidden" name="p_BoardFile" value="<%=fbDto.getBoardFile()%>"></input><input type="hidden" name="BoardFileNm" value="<%=fbDto.getBoardFileNm()%>"></input><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
							</tr>						
							
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
								<td><input type="text" id="" name="Title" value="<%=fbDto.getTitle() %>" class="text" title="제목" style="width:916px;" maxlength="100"/></td>
							</tr>
							
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용</label></th>
								<td><textarea id="" name="Contents" title="내용" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('10000', this)"><%=fbDto.getContents()%></textarea></td>
							</tr>								 
        	 
        	     			<%
    						
					    	}else{
    		
    						%>
    						
    						<tr>
								<th><label for="">첨부파일</label></th>
								<td><div class="fileUp"><input type="text" class="text dis" id="file1" title="첨부파일" style="width:561px;" value="<%=fbDto.getBoardFile() %>" readOnly /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BoardFile" id="upload1" /></div><input type="hidden" name="p_BoardFile" value="<%=fbDto.getBoardFile()%>"></input><input type="hidden" name="BoardFileNm" value="<%=fbDto.getBoardFileNm()%>"></input><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
							</tr>
        	 
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
								<td><input type="text" id="" name="Title" value="<%=fbDto.getTitle() %>" class="text dis" title="제목" style="width:916px;" maxlength="100" readonly="readonly"/></td>
							</tr>
							
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용</label></th>
								<td><textarea id="" name="Contents" title="내용" class="dis" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('10000', this)" readonly="readonly"><%=fbDto.getContents()%></textarea></td>
							</tr>  
							
							<%
					    	}
					    	%>      	 
					
					</tbody>
						</table>
					</fieldset>
					</form>
					<!-- //등록 -->
				</div>        	 
				<!-- 자유게시판상세정보 -->        	 

				<!-- 댓글 -->
        	 <!-- 게시판 댓글 리스트 Iframe 시작 -->
            <iframe src="<%=request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq=<%=fbDto.getSeq() %>" id="freeBoardReplyIframe" name="freeBoardReplyIframe" onLoad="calcHeight();" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" width="100%" height="137"></iframe>
       		 <!-- 게시판 댓글 리스트 Iframe 시작 끝-->
    	
<%--      	   <!-- 팩스양식 선택 세트 시작 -->
        	<!-- freeBoardReplyIframe.jsp 댓글리스트 아이프레임 시작  -->
            <iframe src="<%=request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq=<%=fbDto.getSeq() %>" id="freeBoardReplyIframe" name="freeBoardReplyIframe" frameborder="0" marginheight="100" marginwidth="100" class="" scrolling="no" width="615" height="350"></iframe>
       		<!-- freeBoardReplyIframe.jsp 댓글리스트 아이프레임  끝-->  --%>
          
		<!-- //Bottom 버튼영역 -->
    	
    	<%
    		
    	if(UserBroker.getUserId(request).equals(fbDto.getWriteUser())){
 			
    	%>
    	  
    	  <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
    
    	<%
    	}else{
    		
    	%>
    	
    		<div class="Bbtn_areaC"><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
    	
    	<%
    	}
    	%>
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

<%= comDao.getMenuAuth(menulist,"33") %>
<script type="text/javascript">fn_fileUpload();</script>