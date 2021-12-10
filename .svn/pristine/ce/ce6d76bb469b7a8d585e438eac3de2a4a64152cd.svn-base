<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");

	
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>업무 문서파일 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.documentFileRegist; 
	/* var fsize = $('#DocumentFile')[0].files[0].size; */
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
	if(frm.FormGroup.value == ""){
		alert("서식 분류를 선택해주세요.");
		return;
	}
	if(frm.DocumentFile.value == ""){
		alert("서식 파일을 첨부해주세요.");
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
	}
	 */
/* 	if(frm.DocumentFile.value != "" && !isFile(frm.DocumentFile.value)){
			alert("첨부 가능한 파일 유형은 \n HWP, DOC, DOCX, PPT, PPTX, XLS, XLSX, PDF 이상 6종 입니다.");
			return; 				
	} */
	   
	frm.WriteFormUser.value = frm.user_id.value;
	frm.DocumentFileNm.value = strFileName;
	frm.submit();
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
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=documentFileRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
	
	function cancle(){
		
		var frm = document.documentFileRegist;
		frm.action='<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList';
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
			<h3><span>업</span>무Manual등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con" id="excelBody">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				
				<!-- 등록 -->
			    <form name="documentFileRegist" method="post" action="<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileRegist" enctype="multipart/form-data">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
				  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
				  <input type ="hidden" name="WriteFormUser" value=""></input>
      
				<fieldset>
					<legend>업무Manual등록</legend>
					
					<table class="tbl_type" summary="업무Manual등록(등록자, 서식작성자, 서식분류, 첨부파일, 제목, 내용)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>등록자</label></th>
							<td><input type="text" id="" class="text dis" title="등록자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>     
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서작성자</label></th>
							<td><input type="text" id="" name="user_nm" class="text" title="문서작성자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>문서분류</label></th>
							
							<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("전체");
							codeParam.setName("FormGroup");
							codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A07")); 
							%></td>
						
						</tr>												      
						<input type="hidden" name="DocumentFileNm" value=""></input>        
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>첨부파일</label></th>
							<td><div class="fileUp"><input type="text" class="text" id="file1" title="첨부파일" style="width:561px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="DocumentFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 500M</span></td>
						</tr>        
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" id="" name="Title" class="text" title="제목" style="width:916px;" maxlength="100"/></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용</label></th>
							<td><textarea id="" name="Contents" title="내용" style="width:916px;height:248px;" onKeyUp="js_Str_ChkSub('1000', this)"></textarea></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
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