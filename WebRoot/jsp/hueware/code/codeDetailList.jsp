<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String listPage = (String)model.get("listPage");
	String searchGb =(String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String sml_cd = (String)model.get("sml_cd");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>코드 상세리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.banner.js"></script>
<script type="text/javascript">

//스트라이프 테이블
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



<!--
	var  formObj;//form 객체선언
	
	//초기세팅
	function inits() {
		
		formObj=document.codeform; //form객체세팅
		
		searchInit(); //조회옵션 초기화
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //처리중 메세지 비활성화
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	}
	//상세등록
	function goRegist() {

		formObj.target ='_self';
		formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeRegistForm";		
		formObj.submit();

	}
    //상세화면
	function goDetail(big_cd){

		formObj.target ='_self';
		formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeView";
		formObj.big_cd.value=big_cd;
		formObj.submit();

	}

    //상위리스트 이동
	function goList(){
		
	formObj.action='<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
	formObj.curPage.value=formObj.listPage.value;
	formObj.submit();

}
//-->
</SCRIPT>
</head>
<body onLoad="inits()">
<div id="wrap">
<!-- header -->
<div id="header">
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
</div>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
<div class="content_navi">관리 &gt; 코드북관리</div>
<h3><span>코</span>드상세리스트</h3>
<div class="con codePageList">
<div class="conTop_area">
  <%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>
  <%= ld.getPageScript("codeform", "curPage", "goPage") %>

  <form  method="post" name=codeform action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeDetailList" class="search">
    <input type = "hidden" name = "big_cd">
    <input type = "hidden" name="listPage"  value="<%=listPage%>">
    <input type = "hidden" name="curPage"  value="<%=curPage%>">
    <input type = "hidden" name="searchGb"  value="<%=searchGb%>">
    <input type = "hidden" name="searchtxt"  value="<%=searchtxt%>">

    <!-- search -->
<fieldset>
<legend>검색</legend>
	<ul>
	<li><label for="">코드분류</label>&nbsp;&nbsp;<input type="text" name="sml_cd" class="text dis" readOnly style="width:100px;margin-right:5px;" value="<%=sml_cd%>" /></li>
    </ul>
 </fieldset>
 </form>
 <!--//search -->
 <!-- Top 버튼영역 -->
 <div class="Tbtn_areaR"><a href="javascript:goRegist();" class="btn_type01"><span>등록하기</span></a><a href="javascript:goList();" class="btn_type01 btn_type01_gray md0"><span>취소하기</span></a></div>
 <!-- //Top 버튼영역 -->
 </div>

     <table class="tbl_type tbl_type_list" summary="코드상세리스트(코드번호, 코드분류, 코드명, 코드설명)">
        <caption>코드리스트</caption>
       <colgroup>
			<col width="25%" span="4" />
		</colgroup>
		<thead>
		<tr>
			<th>코드번호</th>
			<th>코드분류</th>
			<th>코드명</th>
			<th>코드설명</th>
		</tr>
		</thead>
		<tbody>
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%			
if(ld.getItemCount() > 0){	
    int i = 0;
	while(ds.next()){
%>
        <tr>
          <td><a href="javascript:goDetail('<%=ds.getString("BIG_CD")%>')"><%=ds.getString("BIG_CD")%></a></td>
          <td><%=ds.getString("SML_CD")%></td>
          <td><%=ds.getString("CD_NM")%></td>
          <td><%=ds.getString("CD_DESC")%></td>
        </tr>
        <!-- :: loop :: -->
        <%		
    i++;
    }
}else{
%>
        <tr>
          <td colspan="4">게시물이 없습니다.</td>
        </tr>
        <% 
}
%>
	</tbody>
      </table>
<!-- paginate -->
<div class="paging">
<%=ld.getPagging("goPage")%>
</div>
<!-- //paginate -->
  <!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01"><span>등록하기</span></a><a href="javascript:goList();" class="btn_type01 btn_type01_gray md0"><span>취소하기</span></a></div>
  <!-- //Bottom 버튼영역 -->
    </div>
 
</div>
<!-- //contents -->
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"63") %>