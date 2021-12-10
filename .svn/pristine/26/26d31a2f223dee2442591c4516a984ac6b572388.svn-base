<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>

<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String)model.get("curPage");
	String searchGb =(String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>코드 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
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
	
	//조회
	function goSearch() {

		var gubun=formObj.searchGb.value;

		if(gubun=='SML_CD'){
			if( formObj.searchtxt.value==''){
				alert('코드분류 입력해 주세요');
				return;
			}
		}else if (gubun=='CD_NM'){
			if( formObj.searchtxt.value==''){
				alert('코드명을 입력해 주세요');
				return;
			}
		}else if (gubun=='CD_DESC'){
			if( formObj.searchtxt.value==''){
				alert('코드설명을 입력해 주세요');
				return;
			}
		}
		 openWaiting();
		 formObj.curPage.value='1';
		 formObj.submit();

    }
    
	//등록
	function goRegist() {

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeRegistForm";		
		 formObj.submit();

	}
    
	//상세
	function goDetail(sml_cd){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeView";
		 formObj.sml_cd.value=sml_cd;
		 formObj.curPage.value='1';
		 formObj.submit();

	}
    
	//상세리스트
	function goDetailList(sml_cd){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeDetailList";
		 formObj.sml_cd.value=sml_cd;
		 formObj.curPage.value='1';
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageList";	
	}
//-->

</script>
</head>
<body onload = "inits();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
    <!-- title -->
    <div class="content_navi">관리 &gt; 코드북관리</div>
	<h3><span>코</span>드북관리</h3>
    <!-- //title -->
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
  <form  method="post" name="excelform">
  </form>
  <form  method ="post" name=codeform action = "<%= request.getContextPath()%>/B_Code.do?cmd=codePageList" class="search">
    <input type = "hidden" name = "sml_cd"/>
    <input type = "hidden" name = "big_cd" value="*"/>
    <input type = "hidden" name = "gubun" value="BIG"/>
    <input type = "hidden" name = "listPage" value="<%=curPage%>"/>
    <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
   
    <!-- search -->
      <fieldset>
        <legend>검색</legend>
        <ul>
        <li><select name="searchGb" onchange="searchChk()">
          <option checked value="">전체</option>
          <option value="SML_CD" >코드분류</option>
          <option value="CD_NM"   >코드명</option>
          <option value="CD_DESC"  >코드설명</option>
        </select></li>
        
        <li><input type="text" name="searchtxt" value="<%=searchtxt%>"  class="text" maxlength="100" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
       </ul>
      </fieldset>
        </form>
    <!--//search -->
    <!-- Top 버튼영역 -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
	<!-- //Top 버튼영역 -->
     </div>
    
    <table class="tbl_type tbl_type_list" summary="코드북관리리스트(코드분류, 코드명, 코드설명)">
        <caption>코드리스트</caption>
        <colgroup>
			<col width="30%" />
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<thead>
		<tr>
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
            <td><%=ds.getString("SML_CD")%><a href="javascript:goDetailList('<%=ds.getString("SML_CD")%>')" class="btn_type03"><span>상세리스트</span></a></td>
            <td><a href="javascript:goDetail('<%=ds.getString("SML_CD")%>')"><%=ds.getString("CD_NM")%></a></td>
            <td><%=ds.getString("CD_DESC")%></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="3">게시물이 없습니다.</td>
          </tr>
          <% 
}
%>
      </table>
<!-- paginate -->
<div class="paging">
<%=ld.getPagging("goPage")%>
</div>
      
      <!-- Bottom 버튼영역 -->
      <div class="Bbtn_areaR">
        <a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a>
      </div>
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