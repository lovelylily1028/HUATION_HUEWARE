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
	String IvStartDate = (String)model.get("IvStartDate");
	String IvEndDate = (String)model.get("IvEndDate");
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
		
		formObj=document.hollyDayForm; //form객체세팅
		
		searchInit(); //조회옵션 초기화
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //처리중 메세지 비활성화
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	}	
	    
	<%-- //등록
	function goRegist() {

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeRegistForm";		
		 formObj.submit();

	} --%>
	//등록 팝업
	function goRegist() {
		if(openWin != 0) {
			  openWin.close();
		}
		openWin=window.open("<%=request.getContextPath()%>/H_Holly.do?cmd=HollyDayRegistForm","","width=380, height=300, top=150, left=900, toolbar=no, menubar=no, scrollbars=no, status=no");
	}
		
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageList";	
	}
//-->
//조회
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		var dch=dateCheck_5Year(formObj.IvStartDate,formObj.IvEndDate,1827);//검색조건 날짜체크 : 시작일,종료일,기간(5년)
		
		if (dch==false){
			return;
		}
		
		/* if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('발행종류를 입력해주세요');
				return;
			} */
		
		 openWaiting();
		 formObj.curPage.value='1';
		 formObj.submit();

    }
		
	//체크박스 전체 선택
	function fnCheckAll(objCheck) {
		  var arrCheck = document.getElementsByName('checkbox');
		  
		  for(var i=0; i<arrCheck.length; i++){
		  	if(objCheck.checked) {
		    	arrCheck[i].checked = true;
		    } else {
		    	arrCheck[i].checked = false;
		    }
		 }
	}
	
	//체크 박스 선택 삭제(다건/단건) 
	function goDelete(){

		var checkYN;
		//var checks=0;
		if( formObj.seqs.length>1){
			for(i=0;i< formObj.seqs.length;i++){
				if( formObj.checkbox[i].checked==true){
					checkYN='Y';
					//checks++;
				}else{
					checkYN='N';
				}
				 formObj.seqs[i].value=fillSpace( formObj.checkbox[i].value)+'|'+fillSpace(checkYN);
			}
		}else{
			if( formObj.checkbox.checked==true){
				checkYN='Y';
				//checks++;
			}else{
				checkYN='N';
			}
			 formObj.seqs.value=fillSpace( formObj.checkbox.value)+'|'+fillSpace(checkYN);
			
		}
		var checks = document.getElementsByName("checkbox");
		var users = new Array();
		
		for(var i = 0; i < checks.length; i++) {	
			if (checks[i].checked ){
				users.push(checks[i].ID);	//users에 push를 이용해 체크된 값을 담는다.
			}
		}
		
		if (users.length == 0){
			alert("삭제할 사용자를 선택해 주세요!")
		} else {
			if(!confirm("정말로 삭제하시겠습니까?"))
				return;
			
			 formObj.action = "<%=request.getContextPath()%>/H_Holly.do?cmd=HollyDayDeletes";
			 formObj.submit();
		}
	}
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
    <div class="content_navi">관리 &gt; 휴일관리</div>
	<h3><span>휴</span>일관리</h3>
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
  
  <%= ld.getPageScript("hollyDayForm", "curPage", "goPage") %>
  <form  method="post" name="excelform">
  </form>
  <form  method ="post" name=hollyDayForm action = "<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDayMgPageList" class="search">
    <input type = "hidden" name = "sml_cd"/>
    <input type = "hidden" name = "big_cd" value="*"/>
    <input type = "hidden" name = "gubun" value="BIG"/>
    <input type = "hidden" name = "listPage" value="<%=curPage%>"/>
    <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
   
    <!-- Top 버튼영역 -->
    <li><span class="ico_calendar"><input type="text" class="text textdate" title="검색시작일" id="calendarData1" name="IvStartDate" value="<%=IvStartDate %>" readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" onclick="showCalendar('1')"/></span> ~ <span class="ico_calendar"><input type="text" name="IvEndDate" class="text textdate" title="검색종료일" id="calendarData2" value="<%=IvEndDate %>" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" onclick="showCalendar('2')"/></span></li>
	<li><select id="" title="검색조건선택" name="searchGb" onChange="searchChk()">
								<option checked value="">휴일명</option>
								<!--  <option value="E" >대표자</option> -->
							</select></li>
	<li><input type="text" class="text" title="검색어" id="" name="searchtxt" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100"/></li>
	<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
	<div class="Tbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>삭제하기</span></a></div>
	<!-- //Top 버튼영역 -->
     </div>
    
    <table class="tbl_type tbl_type_list" summary="휴일관리리스트(휴일명, 휴일, 휴일설명)">
        <caption>코드리스트</caption>
        <colgroup>
       		<col width="5%" />
			<col width="30%" />
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<thead>
		<tr>
			<th><input type="checkbox" id="checkboxAll" class="check md0"  name="checkboxAll" onclick="fnCheckAll(this)"/></th>
			<th>휴일명</th>
			<th>휴일일자</th>
			<th>휴일설명</th>
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
          <input type="hidden" name="seqs" >
         	 <td><input type="checkbox" name="checkbox" value="<%=ds.getString("Seq")%>" /></td>
            <td><%=ds.getString("HollyDayTitle")%></td>
            <td><%=ds.getString("HollyDayDate").substring(0,10)%></td>
            <td><%=ds.getString("Description")%></td>
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
        <a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>삭제하기</span></a>
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
<%= comDao.getMenuAuth(menulist,"64") %>