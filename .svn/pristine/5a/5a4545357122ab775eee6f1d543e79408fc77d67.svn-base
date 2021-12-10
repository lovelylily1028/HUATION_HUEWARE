<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.recruit.QnaDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    QnaDTO qnaDto = (QnaDTO)model.get("compDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>채용문의 리스트(1:1 문의)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goAnswer(){
	var frm = document.qnaView; 

	if(frm.answer.value.length == 0){
		alert("답변을 입력하세요");
		return;
	}

	if(confirm("고객문의에 답변 하시겠습니까?\n답변시 고객 이메일 주소로 내용이 전달됩니다.")){

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		openWaiting();
		frm.submit();
	}
}

function goList(){
	
	var frm = document.qnaView;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList';
	frm.submit();

}
		// 여기서 부터는 처리중 표현하는 function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//보이기
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function waitStart() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("waitStart()", 100);  // 0.1초마다 확인
	}
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome관리 &gt; 채용문의(1:1문의)</div>
			<h3><span>채</span>용문의상세정보(1:1문의)</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->
			    <form name="qnaView" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=qnaEdit">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
			      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
			      <input type = "hidden" name = "qna_no"  value="<%=qnaDto.getQna_no()%>"/>
			      <input type = "hidden" name = "qna_gb" value="02"/>
			      <input type = "hidden" name = "question"  value="<%=qnaDto.getQuestion()%>"/>

				<fieldset>
					<legend>채용문의상세정보(1:1문의)</legend>
					<table class="tbl_type" summary="채용문의상세정보(1:1문의)(제목, 보낸사람, 첨부파일, 질문, 답변)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" id="" name="subject" class="text dis" title="제목" style="width:916px;" readOnly value="<%=qnaDto.getSubject()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>      
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>보낸사람</label></th>
							<td><input type="text" id="" name="email" class="text dis" title="보낸사람" style="width:916px;" readOnly value="<%=qnaDto.getEmail()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>첨부파일</label></th>
							<td><% if(!qnaDto.getQna_file().equals("")){ %><a href="<%= request.getContextPath()%>/data/<%=qnaDto.getQna_file()%>" target="new"><span id="p_account_copy1_t">첨부파일 [click]</span></a><% } %></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>질문</label></th>
							<td><textarea id="" name="question" title="질문" class="dis" style="width:916px;height:124px;" readOnly><%=qnaDto.getQuestion()%></textarea></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>답변</label></th>
							<td><%
								 String answer=qnaDto.getAnswer();
									
									if(answer.equals("")){
								%>
							<textarea id="" name="answer" title="답변" style="width:916px;height:124px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
						        <%
									}else{
								%>
							<textarea id="" name="answer" title="답변" class="dis" style="width:916px;height:124px;" readOnly><%=qnaDto.getAnswer()%></textarea></td>
						        <%
									}
								%>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC">
					<%
		                if(answer.equals("")){
		            %><a href="javascript:goAnswer();" class="btn_type02"><span>등록</span></a><%
					}else{}
					%><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"45") %>