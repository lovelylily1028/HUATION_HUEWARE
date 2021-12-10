<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.about.NewsDTO"%>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
    NewsDTO newsDto = (NewsDTO)model.get("compDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>뉴스 수정페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){
	var frm = document.newsView; 

	if(frm.subject.value.length == 0){
		alert("제목을 입력하세요");
		return;
	}
	if(frm.contents.value.length == 0){
		alert("공지내용을 입력하세요");
		return;
	}

	if(confirm("수정 하시겠습니까?")){

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		frm.submit();
	}
}

function goDelete(){
	
	var frm = document.newsView;
	if(confirm("삭제 하시겠습니까?")){
		frm.action='<%= request.getContextPath()%>/B_About.do?cmd=newsDelete';
		frm.submit();
	}

}

function goList(){
	
	var frm = document.newsView;
	frm.action='<%= request.getContextPath()%>/B_About.do?cmd=newsPageList';
	frm.submit();

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
			<div class="content_navi">HUEHome관리 &gt; Lastest News</div>
			<h3><span>L</span>astest News상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->

				<form name="newsView" method="post" action="<%= request.getContextPath()%>/B_About.do?cmd=newsEdit">
					<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
					<input type = "hidden" name = "news_no"  value="<%=newsDto.getNews_no()%>"/>
     
				<fieldset>
					<legend>Lastest News상세보기</legend>
					<table class="tbl_type" summary="Lastest News상세정보(제목, 뉴스내용)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" id="" name="subject" class="text" title="제목" style="width:916px;" maxlength="100" value="<%=newsDto.getSubject()%>"/></td>
						</tr>     
     
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>뉴스내용</label></th>
							<td><textarea id="" name="contents" title="뉴스내용" style="width:916px;height:248px;"><%=newsDto.getContents()%></textarea></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->

				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"41") %>