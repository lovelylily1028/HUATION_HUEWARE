<%@page import="java.security.interfaces.DSAKey"%>
<%@page import="java.util.concurrent.CountDownLatch"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
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
<%@ page import="java.util.*" %>

<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String moreC = (String)model.get("moreC"); //이전페이지 Y값 넘겨주면서 hidden값 처리사용
	String moreCC = (String)model.get("moreCC"); //다음페이지 Y값 넘겨주면서 hidden값 처리사용
	
	FreeBoardDTO fbDto = (FreeBoardDTO)model.get("fbDto");
	
	
	//더보기 버튼 활성화사용하기 위해 전역변수 선언
	int count = fbDto.getReplyCount(); //총페이지수
	int countt = fbDto.getReplyCountt(); //총페이지수2
	
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>자유게시판 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.min.js"/>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript">

	//덧글입력
	function goSaveRep(){
		
		var frm = document.freeBoardReplyIframe;
		if(confirm("덧글을 등록하시겠습니까?")){
			
			frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardRegistRep&SeqBoard=<%=fbDto.getSeq()%>&WriteUserBoard=<%=fbDto.getWriteUser()%>&TitleBoard=<%=fbDto.getTitle()%>';
			frm.submit(); 
		}
	} 
	//덧글삭제
	function goDeleteRep(SeqRep){
		
		var frm = document.freeBoardReplyIframe;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardDeleteRep';
			frm.SeqRep.value=SeqRep;
			frm.submit();
		}

	}
	// 텍스트에어리어 (내용 디폴트 내용보여지기 내용입력시 hidden 내용 입력x 디폴트내용)
	function contentsChange(target,type)
	{
	 if (target.value == target.defaultValue && type==0) target.value = "";
	 if (!target.value && type==1) target.value = target.defaultValue;
	}
	
	
	
//-->
</script>
</head>
<!-- Enter시 이중서브밋이 되면서 Post방식 Action페이지(초기)호출로 인해서 엔터키 막음. -->
<body>
	<%
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();

		int iTotCnt = ld.getTotalItemCount(); //총데이터수
		int iCurPage = ld.getCurrentPage();	//현재페이지수
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
	%>

	<!-- 댓글 -->
	<div class="reply_area">
		<h4>댓글</h4>
		<p class="total">전체 글갯수 <strong><%=NumberUtil.getPriceFormat(""+StringUtil.nvl(""+ld.getTotalItemCount() ,"0")) %>개</strong></p>
		<form  name="freeBoardReplyIframe" method="post" action="<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardReplyIframe" enctype="multipart/form-data">
		<input type = "hidden" name = "curPage" value="<%=curPage%>"></input>
		<!-- Update 수정시 필요한 pk 값 : Seq 넘겨줘야된다.  -->
		<input type="hidden" name="Seq" value="<%=fbDto.getSeq()%>"></input>
		<input type="hidden" name="SeqRep" value="<%=fbDto.getSeqRep()%>"></input>
		<fieldset>
			<legend>댓글</legend>
			
				<!-- :: loop :: -->
				<!--리스트---------------->
				<%
					if(fbDto.getSeq() == fbDto.getSeqBoard()){
				%>

				<%
					if (ld.getItemCount() > 0) {

					int i = 0;
					int j = 0;

					while (ds.next()) {
				%>
				
				<dl class="replyList">

				<%
					//ds로 TotCount 비교하면 인덱스 에러문제로 값을 넣을 dto(count)생성후 넣어준뒤에 ds가아닌 dto개념으로 비교해야 에러X
					count = ds.getInt("TotCount");
					countt = ds.getInt("TotCount");
					if(UserBroker.getUserId(request).equals(ds.getString("RepWriteUser"))){
				%>

				<dt><%=ds.getString("RepUserName") %><span>(<%=ds.getString("CreateDateRep") %> <%=ds.getString("CreateTimeRep") %>)</span></dt>
				<dd><%=ds.getString("ContentsRep") %><a href="javascript:goDeleteRep('<%=ds.getString("SeqRep")%>');" class="btn_type03"><span>삭제</span></a></dd>

				<%
					}else{
				%>

				<dt><%=ds.getString("RepUserName") %><span>(<%=ds.getString("CreateDateRep") %> <%=ds.getString("CreateTimeRep") %>)</span></dt>
				<dd><%=ds.getString("ContentsRep") %><a href="javascript:goDeleteRep('<%=ds.getString("SeqRep")%>');" class="btn_type03"><span>삭제</span></a></dd>

				<%
					}
				%>

				<%
					i++;
				%>
					
				</dl>

				<%
					}
				%>

				<%
					}
				%>
				<!-- :: loop :: -->

			<!-- 페이징 -->
			<%
				//총댓글 현재페이지 비교 변수
				int totcount; //총댓글수
				int nowPagem; //현재페이지*웹단에뿌려줄목록
				totcount = countt; 
				nowPagem = fbDto.getnPage() * fbDto.getnRow();
				
				int nPage; //현재페이지 -2(-1로 셋팅)이전목록을 위한 변수
				nPage = fbDto.getnPage()-2;
				//현재페이지log
				//System.out.print("nPage:"+nPage);
			%>
			<%
			//댓글목록 5개 이상일경우 다음목록 버튼활성화.
			if(count > 5){
			%>
			<div class="paging">
				<!-- 0보다 현재페이지(-1) 이 크거나 같을때 이전목록 버튼 활성화 및 이전목록 페이징 처리 스크립트 실행  -->
				<% if(nPage >= 0){ %>
					<a href="javascript:goListRepPre('moree3',1);"  id="moree3" value="<%=curPage%>" class="btn btn_prev"><span class="hidden_obj">이전페이지</span></a>
				<%} %>
				<strong><%=curPage%></strong>
				<!-- 현재페이지목록 보다 총댓글수 가 클때까지 다음목록 버튼  활성 화 및 다음목록 페이징 처리 스크립트실행 -->
				<% if(nowPagem < totcount){ %>
					<a href="javascript:goListRepNext('moree',1);" id="moree" class="btn btn_next" value="<%=curPage%>"><span class="hidden_obj">다음페이지</span></a>
				<%} %>
				<!-- 현재페이지목록 보다 총댓글 수가 클때 파라미터"Y"넘긴 값을 받아 체크 한다. -->
				<%if(moreCC.equals("Y")){ %>
					<!-- 마지막Page일때(총댓글목록 보다 현재페이지목록이 크거나 같을때) 다음목록 버튼 숨기기 처리. -->
					<%if(nowPagem >= totcount){ %>
						<a href="javascript:goListRepNext('moree',1);" id="moree2" class="btn btn_next" value="<%=curPage%>" style="display:none;"><span class="hidden_obj">다음페이지</span></a>
					<%} %>
				<%} %>
			</div>
			<%} %>
			<!-- //페이징 -->

			<!-- 등록 -->
			<!-- fbDto.getSeq() == fbDto.getSeqBoard() 데이터(댓글) 있을 시 보여지는 두번째 등록 폼  -->
			<!-- 등록 버튼 top메뉴 색 검정색 동일 크기 정사각형 크게 맞추기. -->
			<dl class="replyCon">
				<dt><input type="text" id="" name="ContentsRep" class="text" title="댓글내용" style="ime-mode:active;width:1078px;height:27px;line-height:27px;" onKeyUp="js_Str_ChkSub('100', this)" onfocus="contentsChange(this,0)" onblur="contentsChange(this,1)" value="주제에 맞지 않는 덧글, 비방, 악성 덧글은 모니터링 후 삭제될 수 있습니다." /></dt>
				<dd class="btn_regist"><a href="javascript:goSaveRep();">등록</a></dd>
				<dd><span class="guide_txt">* 댓글은(한글/영문)<span>100byte</span> 이내 입력 가능합니다.</span></dd>
			</dl>

			<%
				//fbDto.getSeq() == fbDto.getSeqBoard() 데이터(댓글)없을 시 보여지는 초기 1번째 등록 폼
				} else {
			%>

			<dl class="replyCon">
				<dt><input type="text" id="" name="ContentsRep" class="text" title="댓글내용" style="ime-mode:active;width:1078px;height:27px;line-height:27px;" onKeyUp="js_Str_ChkSub('100', this)" onfocus="contentsChange(this,0)" onblur="contentsChange(this,1)" value="주제에 맞지 않는 덧글, 비방, 악성 덧글은 모니터링 후 삭제될 수 있습니다." /></dt>
				<dd class="btn_regist"><a href="javascript:goSaveRep();">등록</a></dd>
				<dd><span class="guide_txt">* 댓글은(한글/영문)<span>100byte</span> 이내 입력 가능합니다.</span></dd>
			</dl>

				<%
				}
				%>

			<!-- //등록 -->
		</fieldset>
		</form>
	</div>
	<!-- //댓글 -->
</body>
</html>
<script>
   
    //덧글목록(더보기)
function goListRepNext(id,add){
	var frm = document.freeBoardReplyIframe;
	var pageObj = document.getElementById(id);
	var addPage = add;
	var pageNum = Number(pageObj.value)+add; //add 숫자1
	pageObj.value=pageNum;
	<%
	int totalCount; //총댓글수
	int nowPage; //현재페이지수
	
	totalCount = count; //총댓글수 
	nowPage =fbDto.getnPage(); //현재페이지수 
	%>
	<%if((nowPage*fbDto.getnRow()) < totalCount){%> //다음페이지 계산(페이징)
	location.href='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq=<%=fbDto.getSeq()%>&moreCC=Y&curPage='+pageNum;
	<%}%>
	
}

	//덧글목록(이전목록)
function goListRepPre(id,add){
	var frm = document.freeBoardReplyIframe;
	var pageObj = document.getElementById(id);
	var addPage = add;
	var pageNum = Number(pageObj.value)-add; //add 숫자1
	pageObj.value=pageNum;
	
	location.href='<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq=<%=fbDto.getSeq()%>&curPage='+pageNum;

	
}
</script>
