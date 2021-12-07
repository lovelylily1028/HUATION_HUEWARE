<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.NumberUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
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
	ArrayList<InvoiceDTO> arrlist= (ArrayList)model.get("arrlist");

%>
<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
	<!-- title -->
    <div class="title">
      <h1>세금계산서 발행내역 <span>(발행번호 : <%= (String)model.get("publicno")%>) [제목 : <%= (String)model.get("title")%>]</span></h1>
    </div>
    <!-- //title -->
<form  method="post" name=invoiceform action = "">
  <input type = "hidden" name = "objExcel">
  <input type = "hidden" name = "filename" value="">
  <input type = "hidden" name = "invoice_code" value="">
	<!-- //header -->
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
          
        long sum=0;
      	long sup=0;
      	long vat=0;
      	long sum_price=0;
      	long deposit_amt=0;
      	long deposit_amt_1=0;
      	
       
		if(arrlist.size() > 0){	
		int i = 0;
		int no = 1;
		String tcl="";
		String dipositYN="";
		
	
		for(int j=0; j < arrlist.size(); j++ ){	
			InvoiceDTO dto = arrlist.get(j);
			
			long estmate=Long.parseLong(dto.getT_estiamt());
			/*원본_2013_01_17_shbyeon
			if(DateTimeUtil.getDateType(1,dto.getDeposit_dt(),"/").equals("")){
				tcl="";
				dipositYN="";
			}else{
				tcl="td3";
				dipositYN="완료";
			}
			*/
			/*추가 2013_01_17_shbyeon
			  --입금대기&입금완료된 발행내역 보여주기위함.
			*/
			if(dto.getState().equals("01")){
				tcl="txt_green"; //현재 색깔안바뀜...
				dipositYN="미수";
			}else{
				tcl="td3";
				dipositYN="완료";
			}

		 sup = dto.getSupply_price_i();
		 vat = dto.getVat_i();
		
		 sum_price = sup+vat; 
		 deposit_amt_1 = Long.parseLong(dto.getDeposit_amt());
		
		 deposit_amt +=deposit_amt_1;
		/* long sumpriceUp = sum_price; */
		
		
		/* for(int k=1; k<=arrlist.size(); k++){ */
			
		/* } */
		
		sum += sum_price;
		
		String sums = String.valueOf(NumberUtil.getPriceFormat(sum));
        estmate -=sum;
		
		
		%>
          <tr>
            <td><%=no++ %></td><!-- 넘버 -->
            <td class="<%=tcl%>"><%=dipositYN%></td><!-- 입금여부 -->
            
            
            
            <td class="<%=tcl%>"><%=DateTimeUtil.getDateType(1,dto.getPublic_dt(),"/")%></td><!-- 발행일자 -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(sum_price)%></td><!-- 발행금액 --> <!-- 세금계산서 발행한 공급가+부가세 2013_01_17 shbyeon -->
            <td><%=NumberUtil.getPriceFormat(sum)%></td><!-- 누적발행금액 -->
            <td><%=NumberUtil.getPriceFormat(estmate)%></td><!-- 미발행금액 -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(dto.getDeposit_amt())%></td><!-- 입금액 -->
            <%
				/* long testiamt=Long.parseLong(sum_price); */
				long sumprice=sum_price;
				long t_estiamte=Long.parseLong(dto.getT_estiamt());
				long calval1=t_estiamte-deposit_amt;

				long plus1=0;
				long minus1=0;
                
				if(calval1>0){
					plus1=calval1;
				}else{
					minus1=calval1;
				}
				
				
			%>
			
            <td class="<%=tcl%>"><%=DateTimeUtil.getDateType(1,dto.getPre_deposit_dt(),"/")%></td><!-- 입금예정일자 --> <!-- 입금일자에서 입금예정일자로 변경2013_01_17 shbyeon -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(dto.getT_estiamt())%></td><!-- 총견적금액 -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(deposit_amt)%> </td><!-- 누적입금액 -->
            
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(calval1)%></td><!-- 미회수금액 -->
            <%
				long testiamt=Long.parseLong(dto.getT_estiamt());
				long tdeposiamt=Long.parseLong(dto.getT_deposiamt());
				long calval=testiamt-tdeposiamt;

				long plus=0;
				long minus=0;
                
				if(calval>0){
					plus=calval;
				}else{
					minus=calval;
				}
					
			%>
            
            <td align="right" class="<%=tcl%>"><span class="txt_red"><%=NumberUtil.getPriceFormat(minus)%></span></td><!-- 초과금액 -->
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    
}
}else{
%>
          <tr>
            <td colspan="12">조회된 데이타가 없습니다.</td>
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
    <!-- //button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
    </div>
    <!-- //button -->
	</div>
	<!-- //content -->
	</div>
</div>
</form>
</body>
</html>
