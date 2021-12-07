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
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>미수채권현황</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
var  formObj; //form 객체선언
//초기세팅
 function inits() {

	formObj=document.UnissuedListForm; //form객체세팅
	
	searchInit(); //조회옵션 초기화
	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting(); //처리중 메세지 비활성화
		return;
	} 
	
	observer = window.setTimeout("inits()", 100);  // 0.1초마다 확인

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
	function goExcel() { 
		 formObj.action = "<%=request.getContextPath()%>/B_BaroInvoice.do?cmd=outstandingBondExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_BaroInvoice.do?cmd=outstandingBondList";	
	}
	
</script>
</head>
<body onload="inits()">
 <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
	<!-- container -->
	<div id="container">
	<!-- contents -->
		<div id="content">
			<div class="content_navi">영업지원 &gt; 미수채권현황</div>
			<h3><span>미</span>수채권현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
				  <%=ld.getPageScript("UnissuedListForm", "curPage", "goPage")%>
				<form method ="post" name="UnissuedListForm" action="<%=request.getContextPath()%>/B_BaroInvoice.do?cmd=outstandingBondList" class="search">
				 <input type="hidden" name="curPage" value="<%=curPage%>"/>
				 <!-- search -->
			       <fieldset>
			        <legend>검색</legend>
			        
			        	<ul>
			        		<%-- 
							<li><span class="ico_calendar"><input type="text" name="EsStartDate" id="calendarData1" class="text textdate" value="<%=EsStartDate %>"  title="검색시작일"  readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('1')"/></span> ~ <span class="ico_calendar"><input type="text" class="text textdate" title="검색종료일" value="<%=EsEndDate %>" name="EsEndDate" id="calendarData2" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('2')"/></span></li> 
							--%>				
							<li><select name="searchGb" onChange="searchChk()" id="" title="검색조건선택">
							        <option checked value="">전체</option>
							        <option value="A"  >발주사(업체명)</option>
							        <!-- <option value="B"  >계약명</option>
							        <option value="C"  >계약번호</option>  -->
							</select></li>
			  
			 				<li><input type="text" name="searchtxt" class="text" title="검색어" id="" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100"  /></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
									
						</ul>
					</fieldset>
				</form>    
				 <!--//search --> 
				
				<!-- Top 버튼영역 -->
				 	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
				<!-- //Top 버튼영역 -->  
			
			    </div>
			   <!-- //컨텐츠 상단 영역 --> 
			    
				<!-- 리스트 -->
				<table class="tbl_type tbl_type_list" summary="미발행리스트(계약번호, 계약일자, 견적번호, 발주사, 계약명, 계약금액(VAT포함), 미발행금액, 기발행금액, 담당영업, 담당PM)">
					<colgroup>
						<col width="5%" />
						<col width="8%" />
						<col width="7%" />
						<col width="8%" />
						<col width="12%" />
						<col width="*" />
						<col width="7%" />
						<col width="10%" />
						<col width="7%" />
						<col width="7%" />
						<col width="6%" />
						<col width="6%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>계약번호</th>
						<th>발행일자</th>
						<th>견적번호</th>
						<th>발주사</th>
						<th>품명</th>
						<th>총 계약금액<br />(VAT포함)</th>
						<th>계산서 발행금액<br />(VAT포함)</th>
						<th>미수금액</th>
						<th>회수금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
					</thead>
					<tbody>
									<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											while(ds.next()){
												
												/* long sprice = ds.getLong("SUPPLY_PRICE");
												long vat = ds.getLong("VAT");
												long total = sprice+vat; */
												long nocollect = ds.getLong("IPRice") - ds.getLong("DEPOSIT_AMT");
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("ContractCode") %></td>	<!-- 계약번호 -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- 계약일자 -->
													<td><%=ds.getString("PUBLIC_NO") %></td>	<!-- 견적번호 -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- 발주사 -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- 계약명 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getString("EPRice")) %></td>	<!-- 계약금 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("IPRice")) %></td>	<!-- 기발행금액 -->
											      <%--   <%if(!ds.getString("no_collect_total").equals("")){ %> --%>	<!-- 미수금액  -->
											        <td><%=NumberUtil.getPriceFormat(nocollect)%></td>
											    <%--     <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("DEPOSIT_AMT").equals("")){%>	<!-- 회수금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("DEPOSIT_AMT"))%></td>
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
											<td colspan="12">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
				</tbody>
				</table>
				<%-- <!-- paginate -->
			    <div class="paging">
			      <%=ld.getPagging("goPage")%>
			    </div>
			    <!-- //paginate --> --%>
				<!-- //리스트 -->
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
<%= comDao.getMenuAuth(menulist,"18") %>