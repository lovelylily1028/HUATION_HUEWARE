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
<title>미발행/미수</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
var  formObj; //form 객체선언
var  formObj2; //form 객체선언
//초기세팅
 function inits() {

	formObj=document.UnissuedListForm; //form객체세팅
	formObj2=document.NoCollectListForm; //form객체세팅
	
	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting(); //처리중 메세지 비활성화
		return;
	} 
	
	observer = window.setTimeout("inits()", 100);  // 0.1초마다 확인

} 
	//Excel Export(미발행 엑셀 내려받기)
	function goExcel() { 
		 formObj.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollectExcel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollect";	
	}
	
	//Excel Export(미수채권엑셀 내려받기)
	function goExcel2() {  
		 formObj2.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollectExcel2";	
		 formObj2.submit();
		 formObj2.action = "<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollect";	
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
		<div id="content" class="contractUnPageList">
			<div class="content_navi">영업지원 &gt; 미발행/미수</div>
			<h3><span>미</span>발행현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
					<!-- //Top 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 리스트 -->
				  <%=ld.getPageScript("UnissuedListForm", "curPage", "goPage")%>
				<form method ="post" name="UnissuedListForm" action="<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollect">
				 <input type="hidden" name="curPage" value="<%=curPage%>"/>
				<table class="tbl_type tbl_type_list" summary="미발행리스트(계약번호, 계약일자, 견적번호, 발주사, 계약명, 계약금액(VAT포함), 미발행금액, 기발행금액, 담당영업, 담당PM)">
					<colgroup>
						<col width="50px" />
						<col width="100px" />						
						<col width="100px" />
						<col width="100px" />
						<col width="150px" />
						<col width="200px" />
						<col width="100px" />
						<col width="100px" />
						<col width="100px" />
						<col width="100px" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>계약번호</th>
						<th>계약일자</th>
						<th>견적번호</th>
						<th>발주사</th>
						<th>계약명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>미발행금액</th>
						<th>기발행금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td colspan="11" class="tbl_type_scrollY">
							<div class="scrollY">
								<table class="tbl_type tbl_type_list">
									<colgroup>
										<col width="49px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="150px" />
										<col width="200px" />
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="*" />
									</colgroup>
									<tbody>
									<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											while(ds.next()){
												
												long sprice = ds.getLong("SUPPLY_PRICE");
												long vat = ds.getLong("VAT");
												long total = sprice+vat;
												
												if(!ds.getString("ContractStatus").equals("1")){
													i++;
													continue;
												}
												if(ds.getString("min_price_total").equals("0")){
													i++;
													continue;
												}
												if(!ds.getString("min_price_total").isEmpty()){
													
												
													if(ds.getString("min_price_total").substring(0,1).equals("-")){
														i++;
														continue;
													}
												}
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("ContractCode") %></td>	<!-- 계약번호 -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- 계약일자 -->
													<td><%=ds.getString("Public_No") %></td>	<!-- 견적번호 -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- 발주사 -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- 계약명 -->
											        <td><%=NumberUtil.getPriceFormat(total) %></td>	<!-- 계약금 -->
											        <%if(!ds.getString("min_price_total").equals("")){ %>	<!-- 미발행금액  -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("min_price_total"))%></td>
											        <%}else{%>
          											<td>-</td>
          											<%} %>
          											<%if(!ds.getString("sum_price_total").equals("")){%>	<!-- 기발행금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("sum_price_total"))%></td>
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
											<td colspan="11">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
									</tbody>
								</table>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- //리스트 -->
			</div>
			</form>
			<h3 class="secondTi"><span>미</span>수채권현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel2();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
					<!-- //Top 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 리스트 -->
				<%=ld.getPageScript("NoCollectListForm", "curPage", "goPage")%>
				<form method ="post" name="NoCollectListForm" action="<%=request.getContextPath()%>/B_CurrentStatus.do?cmd=UnissuedNoCollect">
				<input type="hidden" name="curPage" value="<%=curPage%>"/>
				<table class="tbl_type tbl_type_list" summary="미발행리스트(계약번호, 계약일자, 견적번호, 발주사, 계약명, 계약금액(VAT포함), 미발행금액, 기발행금액, 담당영업, 담당PM)">
					<colgroup>
						<col width="50px" />
						<col width="100px" />
						<col width="100px" />
						<col width="100px" />
						<col width="150px" />
						<col width="200px" />
						<col width="100px" />
						<col width="100px" />
						<col width="100px" />
						<col width="100px" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>계약번호</th>
						<th>계약일자</th>
						<th>견적번호</th>
						<th>발주사</th>
						<th>계약명</th>
						<th>계약금액<br />(VAT포함)</th>
						<th>미수금액</th>
						<th>회수금액</th>
						<th>담당영업</th>
						<th>담당PM</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td colspan="11" class="tbl_type_scrollY">
							<div class="scrollY">
								<table class="tbl_type tbl_type_list">
									<colgroup>
										<col width="49px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="150px" />
										<col width="200px" />
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="*" />
									</colgroup>
									<tbody>
									<%
										if(ld.getItemCount()>0){
											int i = 0, cnt = 0;
											ds.first();
											while(ds.next()){
												long sprice = ds.getLong("SUPPLY_PRICE");
												long vat = ds.getLong("VAT");
												long total = sprice+vat;
												
												if(!ds.getString("ContractStatus").equals("1")){
													i++;
													continue;
												}
										 	 	if(ds.getString("no_collect_total").equals("0") || ds.getString("no_collect_total").equals("")){
													i++;
													continue;
												}
									%>
												<tr>
													<% cnt++; %>
													<td><%= cnt %></td>
													<td><%=ds.getString("ContractCode") %></td>	<!-- 계약번호 -->
													<td><%=ds.getString("ContractDate") %></td>	<!-- 계약일자 -->
													<td><%=ds.getString("Public_No") %></td>	<!-- 견적번호 -->
											        <td><%=ds.getString("Ordering_Organization") %></td>	<!-- 발주사 -->
											        <td class="text_l"><%=ds.getString("ContractName") %></td>	<!-- 계약명 -->
											        <td><%=NumberUtil.getPriceFormat(total) %></td>	<!-- 계약금 -->
											       <%--  <%if(!ds.getString("no_collect_total").equals("")){ %>	<!-- 미수금액  --> --%>
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
											        <%-- <%}else{%>
          											<td>-</td>
          											<%} %> --%>
          											<%if(!ds.getString("deposit_amt_total").equals("")){%>	<!-- 회수금액 -->
											        <td><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
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
											<td colspan="11">게시물이 없습니다.</td>
										</tr>
							        	<%
							                }
							            %> 
									</tbody>
								</table>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- //리스트 -->
				</form>
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
<%= comDao.getMenuAuth(menulist,"15") %>