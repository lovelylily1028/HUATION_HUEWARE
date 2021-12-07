<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String EsStartDate = (String)model.get("EsStartDate");
	String EsEndDate = (String)model.get("EsEndDate");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>견적코드미발행현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
var  formObj;//form 객체선언

//초기세팅
function init_contractCodeUnissued() {
	
	formObj=document.contractCodeUnissued; //form객체세팅
	
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
	/* var dch=dateCheck_5Year(formObj.EsStartDate,formObj.EsEndDate,1827);//검색조건 날짜체크 : 시작일,종료일,기간(5년)
	
	if (dch==false){
		return;
	} */
	
	if(gubun=='A'){

		if( formObj.searchtxt.value==''){
			alert('발주사(업체명)를 입력해 주세요');
			return;
		}
	}else if(gubun=='B'){
		if( formObj.searchtxt.value==''){
			alert('프로젝트명을 입력해 주세요');
			return;
		}
	}else if(gubun=='C'){
		if( formObj.searchtxt.value==''){
			alert('발행 번호를 입력해 주세요');
			return;
		}
	}
	 openWaiting();
	 formObj.curPage.value='1';
	 formObj.submit();

}

//Excel Export(미발행 엑셀 내려받기)
function goExcel() { 
	 formObj.action = "<%=request.getContextPath()%>/B_Estimate.do?cmd=contractCodeUnissuedExcelList";	
	 formObj.submit();
	 formObj.action = "<%=request.getContextPath()%>/B_Estimate.do?cmd=contractCodeUnissued";	
}

</script>
</head>
<body onload="init_contractCodeUnissued();">
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
	<!-- contents -->
	<div id="content">
	
	<!-- title -->
	<div class="content_navi">영업지원 &gt; 계약코드미발행현황</div>
	<h3><span>계</span>약코드미발행현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
	<div class="con">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	%>
	
	<%=ld.getPageScript("contractCodeUnissued", "curPage", "goPage")%>
	 	<form method ="post" name="contractCodeUnissued" action="<%=request.getContextPath()%>/B_Estimate.do?cmd=contractCodeUnissued"  class="search">
		<input type = "hidden" name = "ProjectPk" value=""/>
	    <input type = "hidden" name = "public_no" value=""/>
	    <input type = "hidden" name = "p_public_no" value=""/>
	    <input type = "hidden" name = "estimate_dt" value=""/>
	    <input type = "hidden" name = "title" value=""/>
	    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>
    
    <!-- search -->
     <%--  <fieldset>
        <legend>검색</legend>
        
        	<ul>
				<li><span class="ico_calendar"><input type="text" name="EsStartDate" id="calendarData1" class="text textdate" value="<%=EsStartDate %>"  title="검색시작일"  readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('1')"/></span> ~ <span class="ico_calendar"><input type="text" class="text textdate" title="검색종료일" value="<%=EsEndDate %>" name="EsEndDate" id="calendarData2" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('2')"/></span></li>
								
				<li><select name="searchGb" onChange="searchChk()" id="" title="검색조건선택">
				        <option checked value="">전체</option>
				        <option value="A"  >발주사(업체명)</option>
				        <option value="B"  >프로젝트명</option>
				        <option value="C"  >발행번호</option>
				</select></li>
  
 				<li><input type="text" name="searchtxt" class="text" title="검색어" id="" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100"  /></li>
				<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
						
			</ul>
		</fieldset> --%>
	</form>    
	 <!--//search -->

	<!-- Top 버튼영역 -->
		<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
	<!-- //Top 버튼영역 -->  

    </div>
   <!-- //컨텐츠 상단 영역 --> 
    
	<!-- 리스트 -->
				<table class="tbl_type tbl_type_list" summary="계약코드미발행현황(견적서발행번호, 계약일자, 발주사, 프로제젝트명, 계약금액(VAT포함), 미발행금액, 기발행금액, 담당영업, 담당PM)">
					<colgroup>
						<col width="5%" />
						<col width="8%" />
						<col width="7%" />
						<col width="12%" />
						<col width="*" />
						<col width="9%" />
						<col width="9%" />
						<col width="9%" />
						<col width="6%" />
						<col width="6%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>견적서발행번호</th>
						<th>견적일자</th>
						<th>발주사</th>
						<th>프로제젝트명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>미발행금액</th>
						<th>기발행금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
					</thead>
					<tbody>
									<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											while(ds.next()){
												//long sprice = ds.getLong("SUPPLY_PRICE");
												//long vat = ds.getLong("VAT");
												//long total = sprice+vat;
												long unissued = ds.getLong("EPRice") - ds.getLong("IPRice");
												
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("PUBLICNO") %></td>	<!-- 견적서 발행 번호 -->
													<td><%=ds.getString("ESTIMATE_DT") %></td>	<!-- 견적일자 -->
											        <td><%=ds.getString("E_COMP_NM") %></td>	<!-- 발주사(업체명) -->
											        <td class="text_l"><%=ds.getString("TITLE") %></td>	<!-- 프로젝트명 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("EPRice"))%></td>	<!-- 계약금 -->
											       <%--  <%if(!ds.getString("min_price_total").equals("")){ %>	<!-- 미발행금액  --> --%>
											        <td><%=NumberUtil.getPriceFormat(unissued)%></td>
											       <%--  <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("IPRice").equals("")){%>	<!-- 기발행금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("IPRice"))%></td>
											        <%}else{%>
											        <td>-</td>
											        <%}%>
											        <td><%=comDao.getUserNm(ds.getString("SALES_CHARGE")) %></td>	<!-- 담당영업 -->
											        <%if(!ds.getString("ChargePmNm").equals("")){%>
											        <td><%=ds.getString("ChargePmNm") %></td>	<!-- 담당PM -->
											        <%}else{%>
          											<td>-</td>
          											<%} %>
										          </tr>
										          <% 
										          i++;
												}
											}
										 	else {
										%>
										<tr>
											<td colspan="10">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
				</tbody>
				</table>
<%-- 				<!-- paginate -->
			    <div class="paging">
			      <%=ld.getPagging("goPage")%>
			    </div>
			    <!-- //paginate -->
 --%>				<!-- //리스트 -->
			  </div>
			    <!-- //con -->
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
<%= comDao.getMenuAuth(menulist,"12") %>