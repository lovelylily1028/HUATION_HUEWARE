<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.NumberUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	//CodeDAO codeDAO = new CodeDAO();
	//CodeDTO codeDto = new CodeDTO();

	//String comp_type="";
  	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>세금계산서 발행내역</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
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


	// 여기서 부터는 처리중 표현하는 function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//보이기
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function init() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}
//-->
</SCRIPT>
</head>
<form  method="post" name="excelform">
</form>
<!-- 처리중 시작 -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
  <table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
          <tr>
            <td align=center height=middle><img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5"></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- 처리중 종료 -->
<%
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();
		
		int iTotCnt = ld.getTotalItemCount();
		int iCurPage = ld.getCurrentPage();
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();

%>
<body onLoad="init()">
<div id="wrapWp">
 <!-- title -->
    <div id="headerWp">
      <h1>세금계산서 발행내역 <span>세금계산서 발행내역 (계약번호 : <%= (String)model.get("ContractCode")%>)&nbsp;&nbsp;[제목:<%= (String)model.get("ContractName")%>]</span></h1>
    </div>
    <!-- //title -->
    <!-- content -->
	<div id="contentWp" class="invoiceDetailList">
	<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
		<!-- 가이드텍스트 -->
			<p class="Tguide_txt">모든 금액은 부가세가 포함되어있습니다.</p>
			<!-- //가이드텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
<form  method="post" name=invoiceform action = "">
  <input type = "hidden" name = "objExcel">
  <input type = "hidden" name = "filename" value="">
  <input type = "hidden" name = "invoice_code" value="">

        <table class="tbl_type tbl_type_list" summary="세금계산서 발행내역(No., 입금여부, 구분(발행일자, 발행금액, 누적발행금액, 미발행금액), 수금현황(입금액, 입금예정일자, 총견적금액, 누적입금액, 미회수금액, 초과금액))">
          <caption>세금계산서 발행내역</caption>
          <colgroup>
          		<col width="40px" />
				<col width="70px" />
				<col width="84px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="84px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th rowspan="2">No.</th>
				<th rowspan="2">입금여부</th>
				<th colspan="4">구분</th>
				<th colspan="6">수금현황</th>
			</tr>
			<tr>
				<th>발행일자</th>
				<th>발행금액</th>
				<th>누적발행금액</th>
				<th>미발행금액</th>
				<th>입금액</th>
				<th>입금예정일자</th>
				<th>총견적금액</th>
				<th>누적입금액</th>
				<th>미회수금액</th>
				<th>초과금액</th>
			</tr>
			</thead>
			<tbody>
			<td colspan="12" class="tbl_type_scrollY">
				<div class="scrollY">
					<table class="tbl_type tbl_type_list">
					<colgroup>
						<col width="39px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
						<col width="70px" />
						<col width="84px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="84px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="*" />
					</colgroup>
					<tbody>
          
          <!-- :: loop :: -->
          <!--리스트---------------->
    <%	
    	long esti_amt=0;				//총견적금액(공급가+부가세) 견적서발행금액.
      	long sup=0;						//공급가 = 발행금액
      	long vat=0;						//부가세
        long supply_sum_vat=0; 			//발행금액(공급가+부가세) 세금계산서발행금액.
      	long sum_price_total=0; 		//누적발행금액
      	long min_price_total=0; 		//미발행금액
      	long deposit_amt=0;				//입금액
      	long deposit_amt_total=0;		//누적 입금액
      	long no_collect_total=0;		//미회수금액
      	long exceed_total=0;			//초과금액
      	
      	String tcl="";			//status로 인한 칼럼색상
		String dipositYN="";	//status로 인한 입금여부(미수/완료)
		int no = 1;				//순차 넘버링.
        if (ld.getItemCount() > 0) {
            int i = 0;
            while (ds.next()) {
            	
            	if(ds.getString("STATE").equals("01")){
    				tcl="txt_green"; //현재 색깔안바뀜...
    				dipositYN="미수";
    			}else{
    				tcl="td3";
    				dipositYN="완료";
    			}
       			
            	//구분
            	sup = Long.parseLong(ds.getString("I_SUPPLY_PRICE")); //세금계산서 발행금액
            	vat = Long.parseLong(ds.getString("I_VAT"));			//세금계산서 발행 부가세
            	esti_amt = Long.parseLong(ds.getString("Esti_AMT")); 	//견적서 발행 총견적금액
            	supply_sum_vat = sup+vat; 		   			 //발행금액(공급가+부가세)
            	sum_price_total += sup+vat; 	   			 //누적발행금액(발행금액++)
            	min_price_total = esti_amt - sum_price_total; //미발행금액(총견적금액-누적발행금액)
            	
            	//수금현황
            	deposit_amt = Long.parseLong(ds.getString("DEPOSIT_AMT"));			//입금액
            	deposit_amt_total += deposit_amt; 									//누적 입금액(입금액++)
            	no_collect_total = esti_amt-deposit_amt_total;						//미회수금액(총견적금액-누적입금액)
            	
            	
            	
            	
            	
            
    %>
<tr>
  <td><%=no++ %></td>
  <td class="<%=tcl%>"><%=dipositYN %></td>
  <td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(supply_sum_vat) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(sum_price_total) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(min_price_total) %></td>  
  <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("DEPOSIT_AMT")) %></td>
  <td><%=DateTimeUtil.getDateType(1,ds.getString("PRE_DEPOSIT_DT"),"/") %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(esti_amt) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(deposit_amt_total) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(no_collect_total) %></td>
  <%
  		exceed_total =esti_amt-deposit_amt_total;	//초과금액(총견적금액-입금액)
  		long plus=0;
		long minus=0;
		
  		if(exceed_total > 0){
  			plus=0;
  %>
  <td class="text_r"><%=NumberUtil.getPriceFormat(plus) %></td>
  <%
  		}else{
  			minus=exceed_total;
  %>
  <td class="text_r"><%=NumberUtil.getPriceFormat(minus) %></td>
  <%
  		}
  %> 	
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
	</td>
		</tr>
          </tbody>
    </tbody>
        </table>
      <!-- //con -->
    <!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    <!-- //button -->
  </div>
</form>
</div>
</body>
</html>
