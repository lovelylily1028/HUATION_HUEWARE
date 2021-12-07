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
<title>HueBook 휴북목록 리스트</title>
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
		
		formObj=document.huebookPageList; //form객체세팅
		
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
	
	
	// 등록 폼으로 이동
	function goRegist(){
		
		
		formObj.target ='_self';							
		formObj.action = "<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookReRegistForm";
		formObj.submit();
	}
	
	//상세페이지 이동
	function goDetail(hueBookCode){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookView";
		 formObj.hueBookCode.value=hueBookCode;
		 formObj.submit();
	}
	
	//Excel Export
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/B_HueBookList.do?cmd=hueBookExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList";	
	}

//-->
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
     <div class="content_navi">HUEBook &gt; 휴북목록</div>
	 <h3><span>휴</span>북목록</h3>
     <!-- //title -->
     <!-- con -->
     <div class="con">
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
  
  <%=ld.getPageScript("huebookPageList", "curPage", "goPage")%>
  <form method="post" name="huebookPageList" action="<%=request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
     <input type="hidden" name="hueBookCode" value=""/>
    

    
    <!-- search -->
      <fieldset>
        <legend>검색</legend>
   		<ul>
   		 <li><select name="searchGb" onchange="searchChk()" id="" class="">
	   		 <option checked value="">전체</option>
	         <option value="1">도서명</option>
	   		 <option value="2">저자</option>
	   		 <option value="3">출판사</option></li>
   		 </select>
   		  
   		 <li><input type="text" name="searchtxt" title="검색어" class="text" maxlength="100" value="<%=searchtxt %>" /></li>
       	 <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
        </ul>
      </fieldset>
     </form>
    <!--//search -->
    <div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
    </div>
    
      <!--리스트---------------->
      <table class="tbl_type tbl_type_list" summary="휴북목록(관리번호, 분야, 도서명, 출판사, 저자, 구매처, 신청자, 신청일자, 결재자, 결재일자, 구매가격 , 구매일자)">
        <caption>휴북목록 리스트</caption>
        <colgroup>
			<col width="8%" />
			<col width="8%" />
			<col width="*" />
			<col width="8%" />
			<col width="8%" />
			<col width="7%" />
			<col width="5%" />
			<col width="7%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" /> 
		</colgroup>
		<thead>
		<tr>
			<th>관리번호</th>
			<th>분야</th>
			<th>도서명</th>
			<th>출판사</th>
			<th>저자</th>
			<th>구매처</th>
			<th>신청자</th>
			<th>신청일자</th>
			<th>결재자</th>
			<th>결재일자</th>
			<th>구매가격</th>
			<th>구매일자</th>
		</tr>
		</thead>
		<tbody>
        <!-- :: loop :: -->
        
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                 	String tcl="";
                  	tcl="txtColor_invoiceCancel";
                    while (ds.next()) {
                    	tcl="";
                    	if(ds.getString("useYn").equals("N"))tcl="txtColor_invoiceCancel";
            %>
        
        <tr class ="<%=tcl%>">
          <td><a href="javascript:goDetail('<%=ds.getString("hueBookCode")%>')"><%=ds.getString("hueBookCode") %></a></td>
          <td><%=ds.getString("branchCodeNm") %></td>
          <td title="<%=ds.getString("bookName") %>" class="text_l"><span class="ellipsis"><%=ds.getString("bookName") %></span></td>
          <td title="<%=ds.getString("publisher") %>"><span class="ellipsis"><%=ds.getString("publisher") %></span></td>
          <td title="<%=ds.getString("writer") %>"><span class="ellipsis"><%=ds.getString("writer") %></span></td>
          <td title="<%=ds.getString("purchasingOffice") %>"><span class="ellipsis"><%=ds.getString("purchasingOffice") %></span></td>
          <td><%=ds.getString("requestName") %></td>
          <td><%=ds.getString("requestDate") %></td>
          <td><%=ds.getString("approvalName") %></td>
          <td><%=ds.getString("clearDate") %></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(StringUtil.nvl(ds.getString("buyPrice"),0)) %>원</td>
          <td><%=ds.getString("buyDate") %></td>
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
    
<!-- paginate -->
<div class="paging">
   <%=ld.getPagging("goPage")%>
</div>
<!-- //paginate -->

</div>
</div>
<!-- //contents -->
</div>
<!-- //container -->


<div class="btn">
<!-- 
      <a href="#"><img src="<%= request.getContextPath()%>/images/btn_req.gif" value="신청하기" onclick="javascript:goRegist();" width="73" height="23" title="신청하기" /></a>
-->
</div>




<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"52") %>