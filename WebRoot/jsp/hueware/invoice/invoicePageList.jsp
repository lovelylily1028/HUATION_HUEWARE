<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String IvStartDate = (String)model.get("IvStartDate");
	String IvEndDate = (String)model.get("IvEndDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>세금계산서 발행 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
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


	var  formObj;//form 객체선언
	
	//초기세팅
	function init_invoice() {
		
		formObj=document.invoiceform; //form객체세팅
		
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
	
	//조회
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		var dch=dateCheck_5Year(formObj.IvStartDate,formObj.IvEndDate,1827);//검색조건 날짜체크 : 시작일,종료일,기간(5년)
		
		if (dch==false){
			return;
		}
		
		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('견적서 발행번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			
			if( formObj.searchtxt.value==''){
				alert('발행기관을 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			
			if( formObj.searchtxt.value==''){
				alert('사업자등록번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='D'){
			
			if( formObj.searchtxt.value==''){
				alert('상호를 입력해 주세요');
				return;
			}
		}else if(gubun=='E'){
			
			if( formObj.searchtxt.value==''){
				alert('대표자를 입력해 주세요');
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
		 formObj.action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceRegistForm";		
		 formObj.submit();

	}
   
	//상세
	function goDetail(gun,ho,manageno){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceView";
		 formObj.gun.value=gun;
		 formObj.ho.value=ho;
		 formObj.manage_no.value=manageno;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoiceExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList";	
	}
    
	//업체상세정보
	function goCompDetail(compcode){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=companyView&comp_code="+compcode,"","width=600,height=445,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
    
	
	/*세금계산서 달력 검색 기능
    2013_05_28(화)shbyeon.
  	*/
  
  	$(document).ready(function(){
  		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
  			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
  			//maxDate:0,
  			showOn: 'both',
  			buttonImageOnly: true,
  			prevText: "이전",
  			nextText: "다음",
  			dateFormat: "yy-mm-dd",
  			dayNamesMin:["일","월","화","수","목","금","토"],
  			monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			changeMonth: true,
  		    changeYear: true
  		});
  	});

	function showCalendar(div){

		   if(div == "1"){
		   	   $('#calendarData1').datepicker("show");
		   } else if(div == "2"){
			   $('#calendarData2').datepicker("show");
		   } 
	}
	
	/**	key down function (엔터키가 입력되면 검색함수 호출)*/
 	function checkKeyASearch(){
		if(event.keyCode == 13){
			goSearch();
		}
	} 
	
//-->
</script>
</head>
<body onload = "init_invoice()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

	<!-- title -->
	<div class="content_navi">영업지원 &gt; (구)세금계산서발행</div>
	<h3><span>(구)</span>세금계산서발행</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			
	<div class="con">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	<!-- 조회 -->  
  	
  	<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

	%>
  
  <%= ld.getPageScript("invoiceform", "curPage", "goPage") %>
  <form  method="post" name="excelform"></form>
  <form  method="post" name=invoiceform action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList" class="search">
    <input type = "hidden" name = "objExcel"/>
    <input type = "hidden" name = "filename" value="companyList.xls"/>
    <input type = "hidden" name = "gun" value=""/>
    <input type = "hidden" name = "ho" value=""/>
    <input type = "hidden" name = "manage_no" value=""/>
    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>

    
    <!-- search -->
	<fieldset>
		<legend>검색</legend>
		<ul>
        <!-- 달력 시작 //2013_05_28(화)shbyeon. 달력 검색 기능 추가. -->
        	<li><span class="ico_calendar"><input type="text" class="text textdate" title="검색시작일" id="calendarData1" name="IvStartDate" value="<%=IvStartDate %>" readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/></span> ~	<span class="ico_calendar"><input type="text" class="text textdate" title="검색종료일" id="calendarData2" name="IvEndDate" value="<%=IvEndDate %>" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"/></span></li>
	    <!-- 달력 종료 //2013_05_28(화)shbyeon. 달력 검색 기능 추가. -->
	        
	        <li><select name="searchGb" onChange="searchChk()" title="검색조건선택">
	          <option checked value="">전체</option>
	          <option value="A" >견적서 발행번호</option>
	          <option value="B" >계약명</option>
	          <option value="C" >사업자등록번호</option>
	          <option value="D" >상호</option>
	          <option value="E" >대표자</option>
	        </select></li>

			<li><input type="text" class="text" title="검색어" id="" name="searchtxt" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100" /></li>
			<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
		</ul>
	</fieldset>
	</form>       
	<!-- //조회 -->			
		
	<!-- Top 버튼영역 -->
	<div class="Tbtn_areaR" id="excelBody"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
	<!-- //Top 버튼영역 -->
	</div>
	<!-- //컨텐츠 상단 영역 -->        


 	<!-- 리스트 -->
	<table class="tbl_type tbl_type_list" summary="(구)세금계산서발행리스트(상태, 구분(승인번호, 수신인, 계약명), 발행일자, 발행기관, 공급받는자(사업자등록번호, 상호, 대표자), 공급액(공급가, 부가세, 합계), 입금예상일자, 입금액, 입금일자)">
		<colgroup>
			<col width="3%" />
			<col width="7%" />
			<col width="5%" />
			<col width="*" />
			<col width="4%" />
			<col width="7%" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="4%" />
			<col width="7%" />
			<col width="4%" />
		</colgroup>
					
		<thead>
		<tr>
			<th rowspan="2">상태</th>
			<th colspan="3">구분</th>
			<th rowspan="2">발행일자</th>
			<th rowspan="2">발행기관</th>
			<th colspan="3">공급받는자</th>
			<th colspan="3">공급액</th>
			<th rowspan="2">입금예상일자</th>
			<th rowspan="2">입금액</th>
			<th rowspan="2">입금일자</th>
		</tr>
					
		<tr>
			<th>승인번호</th>
			<th>수신인(수령인)</th>
			<th>계약명</th>
			<th>사업자등록번호</th>
			<th>상호</th>
			<th>대표자</th>
			<th>공급가</th>
			<th>부가세</th>
			<th>합계</th>
		</tr>
	</thead>
 
 
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			String state="";
			String tcl="";
			String dipositYN="";
		
			while(ds.next()){
		
				    state=ds.getString("STATE");
		
					if(state.equals("03")){
						tcl="";
						dipositYN="입금<br>완료";
					}else if(state.equals("02")){
						tcl="txtColor_invoiceCancel";
						dipositYN="발행<br>취소";
						
					}else{
						tcl="txtColor_depositWait";
						dipositYN="입금<br>대기"; 
					}
		%>
    <tbody>    
        <tr class="<%=tcl%>">
          <td><%=dipositYN%></td>
        <%--
         2013_10_30(수) 현재 권,호,관리번호 화면에서만 사용안함. 단 DB UPDATE 에선 사용함.
          <td class="<%=tcl%>"><%=ds.getString("GUN")%></td>
          <td class="<%=tcl%>"><%=ds.getString("HO")%></td>
         
          <%	if(!state.equals("02")){ %>
          <td class="<%=tcl%>"><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>')"><%=ds.getString("MANAGE_NO")%></a></td>
          <%}else{%>
          <td class="<%=tcl%>"><%=ds.getString("MANAGE_NO")%></td>
          <%}%>
         --%>
          <td><%=ds.getString("APPROVE_NO")%></td>
          <td><%=ds.getString("RECEIVER")%></td>
          <%	if(!state.equals("02")){ %>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>')"><%=ds.getString("TITLE")%></a></span></td>
          <%}else{%>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span class="ellipsis"><%=ds.getString("TITLE")%></span></td>
          <%}%>
         
          
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
          <td><%=ds.getString("PUBLIC_ORG")%></td>
          <%	if(!state.equals("02")){ %>
          <!-- COMP_CODE - > PERMIT_NO 리스트상에서는 사업자등록번호로 보여야된다.2013_03_20(수)shbyeon. -->
          <td><a href="javascript:goCompDetail('<%=ds.getString("COMP_CODE")%>')"><%=ds.getString("PERMIT_NO")%></a></td>
          <%}else{%>
          <!-- 발행취소된 건의 사업자등록번호 -->
          <td><%=ds.getString("PERMIT_NO")%></td>
          <%}%>
          <td><%=ds.getString("COMP_NM")%></td>
          <td><%=ds.getString("OWNER_NM")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_VAT"))%></td>
          <%
				long sprice=ds.getLong("I_SUPPLY_PRICE");
				long vat=ds.getLong("I_VAT");
				long total=sprice+vat;
			%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PRE_DEPOSIT_DT"),"/")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("DEPOSIT_AMT"))%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("DEPOSIT_DT"),"/")%></td>
          
        </tr>
        <!-- :: loop :: -->
        
        <%		
		    i++;
		    }
		}else{
		%>
       
        <tr>
          <td colspan="660">조회된 데이타가 없습니다.</td>
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
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"16") %>