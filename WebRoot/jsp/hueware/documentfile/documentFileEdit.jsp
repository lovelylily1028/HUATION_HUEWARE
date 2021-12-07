<%@page import="com.huation.common.formfile.FormFileDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.documentfile.DocumentFileDTO" %>
<%@ page import ="com.huation.common.user.UserBroker" %>
<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");

	DocumentFileDTO dfDto = (DocumentFileDTO)model.get("dfDto");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>업무 문서파일 상세보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.documentFileEdit; 
	/* var fsize = $('#DocumentFile')[0].files[0].size;  //파일사이즈 */
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.DocumentFile.value;
	
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
	frm.action='<%=request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileEdit'
	if(frm.FormGroup.value == ""){
		alert("문서 분류를 선택해주세요.");
		return;
	}
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
/* 	if(frm.DocumentFile.value != "" && !isFile(frm.DocumentFile.value)){
			alert("첨부 가능한 파일 유형은 \n HWP, DOC, DOCX, PPT, PPTX XLS, XLSX, PDF 이상 8종 입니다.");
			return; 				
	} */
	   
	frm.WriteFormUser.value = frm.user_id.value;
	
	if(strFileName!=''){
		frm.DocumentFileNm.value = strFileName;
	}
	
	
	/*
	최종업데이트한사람(UpdateUser)로그인한 세션값+DTO데이터값 비교후 UpdateUser칼럼에 넣어준다.
	*/
	if(<%=UserBroker.getUserId(request).equals(dfDto.getWriteUser())%>){
		
	frm.UpdateUser.value=frm.WriteUserUp.value;
	
	}else if(<%=UserBroker.getUserId(request).equals(dfDto.getWriteFormUser())%>){
		
	frm.UpdateUser.value=frm.WriteFormUserUp.value;
	
	}
	
	 frm.submit();
   }
}


	/**
	 * 파일 확장자명 체크
	 *
	 **/
/* 	function isFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "hwp" || ext == "doc" || ext == "docx" || ext == "ppt" || ext == "pptx" || ext == "xls" || ext == "xlsx" || ext == "pdf") {
				return true;
			} else {
				return false;
			}
		}
	} */

	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=documentFileEdit","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
	
	//삭제
	function goDelete(){
		
		var frm = document.documentFileEdit;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileDelete';
			
			/*
			삭제한사람(DeletedUser)로그인한 세션값+DTO데이터값 비교후 DeletedUser DB에 넣어준다.
			*/
			if(<%=UserBroker.getUserId(request).equals(dfDto.getWriteUser())%>){
				
			frm.DeletedUser.value=frm.WriteUserUp.value;
			
			}else if(<%=UserBroker.getUserId(request).equals(dfDto.getWriteFormUser())%>){
				
			frm.DeletedUser.value=frm.WriteFormUserUp.value;
			
			}
			
			frm.submit();
		}

	}
	//목록
	function goList(){
		
		
		var frm = document.documentFileEdit;
		frm.action='<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList2';
		frm.submit();

	}
//-->
</SCRIPT>
</head>
<body >
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">게시판 &gt; 업무Manual</div>
			<h3><span>업</span>무Manual상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area" id="excelBody">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				
				<!-- 등록 -->
			    <form name="documentFileEdit" method="post" action="<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileEdit" enctype="multipart/form-data">
			     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			     
				  <input type = "hidden" name = "user_id" value="<%=dfDto.getWriteFormUser()%>"/>
				  <input type ="hidden" name="WriteFormUser" value=""></input>
				  
				  <!-- Update와 Delete 시 가져올DTO값 -->
				  <input type ="hidden" name="WriteFormUserUp" value="<%=dfDto.getWriteFormUser()%>"></input>
				  <input type="hidden" name="WriteUserUp" value="<%=dfDto.getWriteUser()%>"></input>
				  
				  <!-- Update 수정시 필요한 pk 값 : Seq 넘겨줘야된다.  -->
				  <input type="hidden" name="Seq" value="<%=dfDto.getSeq()%>"></input>
				  
				  <!-- Update 시 마지막으로 최종업데이트 유저 값 DB로 넘겨주기위한 히든값 -->
				  <input type="hidden" name="UpdateUser" value=""></input>
				  
				  <!-- Delete 시 삭제한 유저 값DB로 넘겨주기위한 히든값 -->
				  <input type="hidden" name="DeletedUser" value=""></input>
	  
				<fieldset>
					<legend>업무Manual상세정보</legend>
					<table class="tbl_type" summary="업무Manual상세정보(등록자, 서식작성자, 서식분류, 첨부파일, 제목, 내용)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>등록자</label></th>
							<td><input type="text" id="" class="text dis" title="등록자" style="width:200px;" readOnly value="<%=dfDto.getWriteUserName()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>      
        	
			        	<%
			    		
			    		if(UserBroker.getUserId(request).equals(dfDto.getWriteUser()) || UserBroker.getUserId(request).equals(dfDto.getWriteFormUser())){
			 			
			    		%>
    	 
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서작성자</label></th>
							<td><input type="text" id="" name="user_nm"  class="text" title="문서작성자" style="width:200px;" readOnly value="<%=dfDto.getWriteFormUserNm()%>" onClick="javascript:popSales();" /><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>    	

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서분류</label></th>
									
								<td><%
									CodeParam codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("td3");
									//codeParam.setFirst("전체");
									codeParam.setName("FormGroup");
									codeParam.setSelected(dfDto.getFormGroup()); 
									//codeParam.setEvent("javascript:poductSet();"); 
									out.print(CommonUtil.getCodeList(codeParam,"A07")); 
								%></td>
						
						</tr>    	
         		
         				<input type="hidden" name="DocumentFileNm" value="<%=dfDto.getDocumentFileNm()%>"></input>
        				<input type="hidden" name="p_DocumentFile" value="<%=dfDto.getDocumentFile() %>"></input>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>첨부파일</label></th>
							<td><div class="fileUp"><input type="text" class="text" id="file1" title="첨부파일" style="width:561px;" value="<%=dfDto.getDocumentFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="DocumentFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" id="" name="Title" value="<%=dfDto.getTitle() %>" class="text" title="제목" style="width:916px;" maxlength="100"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용</label></th>
							<td><textarea id="" title="내용" name="Contents" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('1000', this)"><%=dfDto.getContents()%></textarea></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
        
    					<%
    	
			    		}else{
    		
    					%>
    					
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서작성자</label></th>
							<td><input type="text" id="" name="user_nm"  class="text dis" title="문서작성자" style="width:200px;" readOnly value="<%=dfDto.getWriteFormUserNm()%>" readOnly/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>      					

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서분류</label></th>
							<td><input type="text" id="" name="FormGroup" value="<%=dfDto.getFormGroupNm()%>" class="text dis" title="문서분류" style="width:300px;" readonly="readonly"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>첨부파일</label></th>
							<td><div class="fileUp"><input type="text" class="text dis" id="file1" title="첨부파일" style="width:561px;" readOnly value="<%=dfDto.getDocumentFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="DocumentFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>    	
    	
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" id="" name="Title" value="<%=dfDto.getTitle() %>" class="text dis" title="제목" style="width:916px;" maxlength="100"  readonly="readonly"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용</label></th>
							<td><textarea id="" name="Contents" title="내용" class="dis" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('1000', this)" readonly="readonly"><%=dfDto.getContents()%></textarea></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
        
				    	<%
				    	}
				    	%>
						
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->
				
				<!-- Bottom 버튼영역 -->
		      	<%
		    		
		    	if(UserBroker.getUserId(request).equals(dfDto.getWriteUser()) || UserBroker.getUserId(request).equals(dfDto.getWriteFormUser())){
		 			
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

<%= comDao.getMenuAuth(menulist,"35") %>
<script type="text/javascript">fn_fileUpload();</script>