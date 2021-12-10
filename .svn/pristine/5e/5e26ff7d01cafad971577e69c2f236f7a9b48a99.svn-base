<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>HueBook 도서신청 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
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
	
	var  formObj;//form 객체선언
	//초기세팅
	function inits() {
		
		formObj=document.huebookAppPageList; //form객체세팅
		
		searchInit(); //조회옵션 초기화
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //처리중 메세지 비활성화
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	}
	
	//조회옵션 초기값	
	function searchInit(){
	
		 formObj.searchGb.value='<%=searchGb%>';
		 formObj.searchtxt.value='<%=searchtxt%>';
		searchChk();
		
	}
	
	//조회옵션 체크	
	function searchChk(){
	
		if( formObj.searchGb[0].selected==true){
			formObj.searchtxt.disabled=true;
			formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}
	
	/*
	 * 검색
	 */
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		
		if(gubun=='1'){
			if( formObj.searchtxt.value==''){
				alert('도서명을 입력해주세요.');
				return;
			}
		}else if(gubun=='2'){
			if( formObj.searchtxt.value==''){
				alert('저자를 입력해 주세요');
				return;
			}
		}else if(gubun=='3'){
			if( formObj.searchtxt.value==''){
				alert('출판사를 입력해 주세요');
				return;
			}
		}
		
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();
	
	}
	
	//상세페이지 이동
	function goDetail(SeqPk){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppView";
		 formObj.SeqPk.value=SeqPk;
		 formObj.submit();
	}
	
	//Excel Export
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppExcel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList";	
	}

	
</script>
</head>
<body onload="inits()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
    <!-- title -->
    <div class="content_navi">HUEBook &gt; 도서결재</div>
	<h3><span>도</span>서결재</h3>
    <!-- //title -->
    <div class="con hueBook">
	<div class="conTop_area">
  
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
//	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  
  <%=ld.getPageScript("huebookAppPageList", "curPage", "goPage")%>
  <form method="post" name="huebookAppPageList" action="<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList"  class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
     <input type="hidden" name="SeqPk" value=""/>
    

    
    <!-- search -->
      <fieldset>
        <legend>검색</legend>
   		 <ul>
   		 <li><select name="searchGb" onchange="searchChk()" id="" class="">
	   		 <option checked value="">전체</option>
	         <option value="1">도서명</option>
	   		 <option value="2">저자</option>
	   		 <option value="3">출판사</option>
   		 </select></li>
   		  
   		  <li><input type="text" name="searchtxt" title="검색어" class="text" maxlength="100" value="<%=searchtxt %>" /></li>
          <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
        </ul>
      </fieldset>
     </form>
    <!--//search -->
    <div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
   </div>
  <!--리스트---------------->
      <table class="tbl_type tbl_type_list" summary="도서결재리스트(진행상태, 번호, 도서명, 출판사, 저자, 신청자, 신청가격, 결재일자, 구매가격 , 구매일자, 구매처, 신청일시)">
        <caption>도서신청 리스트</caption>
        <colgroup>
			<col width="6%" />
			<col width="4%" />
			<col width="*" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
		</colgroup>
		<thead>
		<tr>
			<th>진행상태</th>
			<th>번호</th>
			<th>도서명</th>
			<th>출판사</th>
			<th>저자</th>
			<th>신청자</th>
			<th>신청가격</th>
			<th>결재일자</th>
			<th>구매가격</th>
			<th>구매일자</th>
			<th>구매처</th>
			<th>신청일시</th>
		</tr>
		</thead>
		<tbody>
        
        <!-- :: loop :: -->

        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String status =""; //상태값(신청중.결재완료,구매완료)
                    	String fColor = ""; //상태값 에따른 폰트색상변경.
                    
                    	
                    	status=ds.getString("status");
                    	
                    	if(status.equals("1")){
                    		fColor="requesting";
                    		status="신청중";
                    	}else if(status.equals("2")){
                    		fColor="approvalOk";
                    		status="결재완료";
                    	}else if(status.equals("3")){
                    		fColor="buyOk";
                    		status="구매완료";
                    	}else{
                    		fColor="return";
                    		status="반려";
                    	}
                    		
            %>
        
        <tr>
          <td class="<%=fColor%>"><%=status%></td>
          <td><%=ds.getString("indexno") %></td>
          <td title="<%=ds.getString("bookName") %>" class="text_l"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("SeqPk")%>')"><%=ds.getString("bookName")%></a></span></td>
          <td title="<%=ds.getString("publisher") %>"><span class="ellipsis"><%=ds.getString("publisher") %></span></td>
          <td title="<%=ds.getString("writer") %>"><span class="ellipsis"><%=ds.getString("writer") %></span></td>
          <td><%=ds.getString("requestName") %></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("price")) %>원</td> <!--&#8361;(원)표시현재사용안함 --> 
          <td><%=ds.getString("clearDate") %></td>
          
          <td class="text_r"><%=NumberUtil.getPriceFormat(StringUtil.nvl(ds.getString("buyPrice"),0)) %>원</td>
          
          <td><%=ds.getString("buyDate") %></td>
          <td title="<%=ds.getString("purchasingOffice") %>"><span class="ellipsis"><%=ds.getString("purchasingOffice") %></span></td>
          <td><%=ds.getString("createDate") %></td>
        </tr>
        
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="12">게시물이 없습니다.</td>
        </tr>
        <%
                }
            %>
       </tbody>
      </table>
    </div>
<!-- paginate -->
<div class="paging">
   <%=ld.getPagging("goPage")%>
</div>
<!-- //paginate -->
  

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
<%= comDao.getMenuAuth(menulist,"51") %>