<%@page import="com.huation.common.invoice.InvoiceItemDTO"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.CodeParam" %>
<%@ page import ="com.huation.common.bankmanage.BankManageDTO" %>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO" %>


<%
	InvoiceItemDTO itemlist = new InvoiceItemDTO();
	Map model = (Map)request.getAttribute("MODEL");
	InvoiceDTO invoiceDto = (InvoiceDTO)model.get("invoiceDto");
	EstimateDTO esDto = new EstimateDTO();
	BankManageDTO bmDto = (BankManageDTO)model.get("bmDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String AccountNumber = (String)model.get("AccountNumber");
	
	String addressNo = invoiceDto.getPost()+invoiceDto.getAddress()+invoiceDto.getAddr_detail();
	String permitno1 = invoiceDto.getPermit_no();
	String number[] = permitno1.split("-");
	String permitno2 = number[0]+number[1]+number[2];
	System.out.println("222222222222222:"+invoiceDto.getModifyFlag());
   	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int Supply = Integer.parseInt(invoiceDto.getSupply_price());
	int vat = Integer.parseInt(invoiceDto.getVat());
	System.out.println("qqqqqqqqqqqqqqqqqqqq:"+invoiceDto.getModifyFlag());
	
%>

<% 
DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE)); 
	String Month = df.format(cal.get(Calendar.MONTH)+1);
	String DATE =  df.format(cal.get(Calendar.DATE)); 

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>세금계산서 즉시발행</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">

function registInvoice(){

	
	/* var frm = document.baroInvoiceRegist; */
	var frm2 = document.baroInvoiceRegist1;
	
	/* frm.issuetype.value="02"; */
		 frm2.issuetype1.value="02";
		 frm2.state1.value="02";
		 frm2.curPage1.value='1';
		 frm2.searchGb1.value='';
		 frm2.searchtxt1.value='';
		
		/* frm2.public_no.value=frm.p_public_no.value;
		/* frm.public_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value; */
		/* frm2.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //입금일자
		frm2.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //입금예상일자
		
		var Y = frm2.pYear5.value;
		var M = frm2.pMonth5.value;
		var D = frm2.pDay5.value;
		
		var Y1 = frm2.pYear3.value;
		var M1 = frm2.pMonth3.value;
		var D1 = frm2.pDay3.value; */
		frm2.submit();
	
		
}


function cancle(){
	
	var frm = document.baroInvoiceRegist1;
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
	frm.submit();

}
function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}

function popContractNo(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=1200,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}


function popComp(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_baro&sForm=baroInvoiceRegist","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}


function format_phone(obj) {
	alert("aaaaaa");
	var str=onlyNum(obj.value);
	
	if(str.length<5){
		return;
	}

	rgnNo = new Array;
	rgnNo[0] = "02";
	rgnNo[1] = "031";
	rgnNo[2] = "032";
	rgnNo[3] = "033";
	rgnNo[4] = "041";
	rgnNo[5] = "042";
	rgnNo[6] = "043";
	rgnNo[7] = "0502";
	rgnNo[8] = "0504";
	rgnNo[9] = "0505";
	rgnNo[10] = "0506";
	rgnNo[11] = "0507";
	rgnNo[12] = "051";
	rgnNo[13] = "052";
	rgnNo[14] = "053";
	rgnNo[15] = "054";
	rgnNo[16] = "055";
	rgnNo[17] = "061";
	rgnNo[18] = "062";
	rgnNo[19] = "063";
	rgnNo[20] = "064";
	rgnNo[21] = "070";
	rgnNo[22] = "010";
	rgnNo[23] = "011";
	rgnNo[24] = "016";
	rgnNo[25] = "017";
	rgnNo[26] = "018";
	rgnNo[27] = "019";
	
	var temp = str;

	for (var i = 0; i < rgnNo.length; i++) {
		if (str.indexOf(rgnNo[i]) == 0) {
			len_rgn = rgnNo[i].length;
			formattedNo = getFormattedPhone(str.substring(len_rgn));
			temp=rgnNo[i] + "-" + formattedNo;
			
			break;
		}
	}
	
	obj.value=temp;

}


function saleCntCal(form, rowNumber){//(행추가시 금액계산)
	
	
	var qtyVal = $("#"+rowNumber+" [name=Qty_view1]").val();//해당 tr의 수량을 가져옴
	var unitCostVal = $("#"+rowNumber+" [name=UnitCost_view1]").val();//해당 tr의 단가를 가져옴
	
	
	var oriNumber = new String(parseInt(qtyVal)*parseInt(unitCostVal));//숫자값으로 곱한후 스트링으로 만듬
	
	var oriTaxVal = new String((parseInt(qtyVal)*parseInt(unitCostVal))*0.1);//부가세
	var oriTaxVal1 = new String(parseInt(oriTaxVal));//부가세 소수점 때기
	
	var changeNumber = 	addCommaStr(oriNumber);//콤마 추가
	var changeTaxVal = addCommaStr(oriTaxVal1);//콤마추가

	if(changeNumber=="NaN"){//예외처리
		
	}else{
		$("#"+rowNumber+" [name=Amount_view1]").val(changeNumber);
	}
	if(changeTaxVal=="NaN"){//예외처리
		
	}else{
		$("#"+rowNumber+" [name=Tax1]").val(changeTaxVal);
	}
		
	var amountCnt = $('[name=Amount_view1]').length;//각행의 공급가액을 더해줘야함
	var amountTotal=0;//토탈 공급가액
	
	for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view1]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	var taxCnt1 = $('[name=Tax1]').length;
	var taxTotal1=0;//토탈 부가세
	for(var x=0; x<taxCnt1; x++){//반복문으로 넣어줌
		
		
		
		var tax = $('[name=Tax1]').eq(x).val().replace(/,/gi,"");
		
		var tax1 = parseInt(tax);
		
		taxTotal1 += tax1;	
	}
	var taxTotal2 = taxTotal1/2;
	
	var amountTotalVal = addCommaStr(new String(amountTotal)); 
	 var taxTotalVal = addCommaStr(new String(taxTotal2));
	
	
	
	 if(addCommaStr(new String(taxTotal2))=="NaN"){//예외처리
		}else{
			$('[name=TaxTotal1]').val(taxTotalVal);
		}
	
	if(addCommaStr(new String(amountTotal))=="NaN"){//예외처리
	
	}else{
		$('[name=AmountTotal1]').val(amountTotalVal);
	}
	var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
	var changeTotalAmount = addCommaStr(TotalAmount);
	
	if(addCommaStr(new String(TotalAmount))=="NaN"){//예외처리
		
	}else{
		$('[name=TotalAmount1]').val(changeTotalAmount);
	}
}
	

//품목 행추가
var rowNumber = 2; //행 추가 시 함께 넣을 index 자동증가
var rowNumber2 = 2;
function addRow(){
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	if(addRow_tr_count==16){
		 alert("더이상 행을 추가할수 없습니다.");
		 return;
	 }
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\" class=\"\">";
	rowString +=	"<td><input type=\"text\" name=\"PurchaseDT11\" id=\"\" class=\"in_txt\" value=\"<%=Month%>\" style=\"width:12px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\" name=\"PurchaseDT21\" id=\"\" class=\"in_txt\" value=\"<%=DATE%>\" style=\"width:12px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"3\">"
	rowString +=	"<textarea name=\"ItemName1\" id=\"\" class=\"in_txt\" style=\"width:96.5%;\" maxlength=\"100\" tabindex=\"50\"></textarea>"
	rowString +=	"</td>"
						
	rowString +=		"<input type = \"hidden\" id=\"Qty_"+rowNumber+"\"  name=\"Qty1\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"UnitCost1\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Amount1\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Tax1\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
						
	rowString +=	"<td colspan=\"3\"><textarea name=\"Spec1\" id=\"\" class=\"in_txt\" style=\"width:94.5%;\" maxlength=\"60\" tabindex=\"50\"></textarea></td>"
	rowString +=	"<td colspan=\"2\"><input type=\"text\" name=\"Qty_view1\" id=\"Qty_view\" class=\"in_txt\" onKeyUp = \"saleCntCal('Qty','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('Qty','tr"+rowNumber+"');\"  value=\"\" style=\"width:91%;\" maxlength=\"12\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\"  name=\"UnitCost_view1\" id=\"UnitCost_view1\" class=\"in_txt\"  onKeyUp = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" value=\"\" style=\"width:90.5%;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\" readOnly name=\"Amount_view1\" id=\"Amount\" class=\"in_txt\"  value=\"\" style=\"width:92%;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"2\"><input type=\"text\" readOnly name=\"Tax1\" id=\"\" class=\"in_txt\" value=\"\" style=\"width:93%;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"3\"><textarea name=\"Remark1\" id=\"\" class=\"in_txt\" style=\"width:93%;\" maxlength=\"100\" tabindex=\"50\"></textarea></td>"
		rowString +="<td><img src=\"<%= request.getContextPath()%>/images/btn_delete5.gif\" value=\"행삭제\" id =\"bt\"  style=\"cursor:pointer;\" onclick=\"javascript:removeRow(this,rowNumber);\"/></td>"; 
		rowString +="</tr>";
									
	$('#template').append(rowString);
	
	rowNumber = rowNumber+1;
	var amountTotal=0;//토탈 공급가액
	
	for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view1]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	
	
}
	 
		 
		// 행 삭제
		 function removeRow(obj,rowNumber){	
		  $(obj).parent().parent().remove(); //화면 tbody 안에 tr td 지워주기.
		  
			
			var amountCnt = $('[name=Amount_view1]').length;//각행의 공급가액을 더해줘야함
			var amountTotal=0;//토탈 공급가액
			
			for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
				
				/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
				var amount = $('[name=Amount_view1]').eq(x).val().replace(/,/gi,"");
				
				var amount1 = parseInt(amount);
				
				amountTotal = amountTotal+amount1;
				
			}
			var taxCnt1 = $('[name=Tax1]').length;
			var taxTotal1=0;//토탈 부가세
			for(var x=0; x<taxCnt1; x++){//반복문으로 넣어줌
				
				
				
				var tax = $('[name=Tax1]').eq(x).val().replace(/,/gi,"");
				
				var tax1 = parseInt(tax);
				
				taxTotal1 += tax1;	
			}
			var taxTotal2 = taxTotal1/2;
			
			var amountTotalVal = addCommaStr(new String(amountTotal)); 
			 var taxTotalVal = addCommaStr(new String(taxTotal2));
			
			
			
			 if(addCommaStr(new String(taxTotal2))=="NaN"){//예외처리
				}else{
					$('[name=TaxTotal1]').val(taxTotalVal);
				}
			
			if(addCommaStr(new String(amountTotal))=="NaN"){//예외처리
			
			}else{
				$('[name=AmountTotal1]').val(amountTotalVal);
			}
			var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
			var changeTotalAmount = addCommaStr(TotalAmount);
			
			if(addCommaStr(new String(TotalAmount))=="NaN"){//예외처리
				
			}else{
				$('[name=TotalAmount1]').val(changeTotalAmount);
			}
			
			
		 
		 } 
		
		function day_check(){
			var ttt = $('[name=WriteDT31]').val();
			$('[name=PurchaseDT21]').val(ttt);
		}
</SCRIPT>





</head>
<body>
<div id="wrap">
	<!-- header -->
	<div id="header">
		<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	</div>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div class="clear">
		</div>
		<!-- lnb -->
		<div class="lnb">
			<%@ include file="/jsp/hueware/common/include/left.jsp" %>
		</div>
		<!-- //lnb -->
		<!-- contents -->
		<div class="contents">
			<!-- title -->
			<div class="title">
				<h2>세금계산서 등록</h2>
			</div>
			<!-- //title -->
			<!-- con -->
			<div class="con">
				<div id="panel_content">
					<!-- title -->
					<p class="title_sub"><img src="<%= request.getContextPath()%>/images/p_baroInvoice.gif" alt="국세청 세금계산서 발행" /></p>
					<!-- //title -->
					<!-- calendar -->
					<div id="CalendarLayer" style="display:none; width:172px; height:176px; ">
						<iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
					</div>
					<form name="baroInvoiceRegist1" method="post"  action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroModifyRegist">
						<input type="hidden" name="modifyFlag" id="" value="<%=invoiceDto.getModifyFlag()%>" >
						<input type="hidden" name="LMF1" id="" value="3" >
						<input type="hidden" name="LMC1" id="" value="1" >
						<input type="hidden" name="InvoiceKey1" id="" value="" >
						<input type="hidden" name="Role1" id="" value="1" >
						<input type="hidden" name="contract1" id="" value="<%=invoiceDto.getCONTRACT_CODE()%>" >
						<input type="hidden" name="publicno" id="" value="<%=invoiceDto.getPublic_no()%>" >
						<input type="hidden" name="ModifyCode1" id="" value="0" >
						<input type = "hidden" name = "curPage1" value="<%=curPage%>">
						<input type = "hidden" name = "searchGb1" value="<%=searchGb%>">
						<input type = "hidden" name = "searchtxt1" value="<%=searchtxt%>">
						<input type = "hidden" name = "comp_code1" value="<%=invoiceDto.getComp_code()%>">
						<input type = "hidden" name = "permit_no1" value="<%=invoiceDto.getPermit_no()%>"></input>
						<input type = "hidden" name = "publicorg1" value="바로빌">
						<input type = "hidden" name = "user_id1" value="">
						<input type = "hidden" name = "user_nm1" value="">
						<input type = "hidden" name = "sales_charge1" value="">
						<input type = "hidden" name = "e_comp_nm1" value="">
						<input type = "hidden" name = "state1" value="">
						<input type = "hidden" name = "issuetype1" value="">
						<input type = "hidden" name = "aprove1" value="<%=invoiceDto.getApprove_no()%>">

						<div id="panel_taxtype"><input type="hidden" name="TaxCalcType" id="" value="2" ></div>

						<div id="panel_form">
							<div id="panel_InvoiceForm">
								<p class="title_sub2">- 이 세금계산서는 당초 발급한 세금계산서 취소분입니다.</p>
								<table cellspacing="0" border="1" summary="전자세금계산서" class="tbl_type3">
									<caption>전자세금계산서</caption>
									<colgroup>
										<col width="3%" />
										<col width="3%" />
										<col width="6%" />
										<col width="*" />
										<col width="3%" />
										<col width="6%" />
										<col width="5%" />
										<col width="4%" />
										<col width="6%" />
										<col width="3%" />
										<col width="9%" />
										<col width="11%" />
										<col width="6%" />
										<col width="6%" />
										<col width="5%" />
										<col width="4%" />
										<col width="3%" />
										<col width="3%" />
									</colgroup>
									<tbody>
									<!-- ie7을 위한 빈태그(지우지 마세요) -->
									<tr class="ie7">
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<!-- //ie7을 위한 빈태그(지우지 마세요) -->
									<tr class="hd_bg">
										<th colspan="10" rowspan="2" class="hd_bdR"><span id="FormTitleName">전자세금계산서 취소발행</span><br><br>(재화의 환입)</th>
										<th colspan="2" rowspan="2">공급자<br>(보관용)</th>
										<th colspan="2">책번호</th>
										<td colspan="4">
											<input type="text" name="Kwon" id="" class="in_txt_off"  readOnly value="" style="width:33%;" maxlength="4" tabindex="1">권&nbsp;
											<input type="text" name="Ho" id="" class="in_txt_off"  readOnly value="" style="width:33%;" maxlength="4" tabindex="2">호
										</td>
										</tr>
										<tr class="hd_bg">
											<th colspan="2">일련번호</th>
											<td colspan="4"><input type="text" name="SerialNum" readOnly id="" class="in_txt_off"  value="" style="width:95%;*width:94%;" maxlength="27" tabindex="3"></td>
										</tr>
										<tr>
											<th rowspan="6">공급자</th>
											<th colspan="2">등록번호</th>
											<td colspan="3"><input type="text"  name="InvoicerCorpNum1" id="" class="in_txt_off" readOnly value="108-81-93762" style="width:96.5%;*width:95.5%;" maxlength="10" readonly tabindex="4"></td>
											<th colspan="2">종사업장</th>
											<td><input type="text" name="InvoicerTaxRegID1" id="" class="in_txt_off" readOnly value="" style="width:85%;*width:84%;" maxlength="4" tabindex="5"></td>
											<th rowspan="6">공급받는자</th>
											<th>등록번호</th>
											<td colspan="3"><input type="text"  name="InvoiceeCorpNum1"onClick="javascript:popComp();" id="" class="in_txt_off" readOnly value="<%=permitno2%>" style="width:69.1%;*width:68.1%;" maxlength="14" tabindex="14"><a href="#" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_comp.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_comp_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_comp.gif'" value="업체조회" onclick="javascript:popComp();" title="업체조회" /></a></td>
											<th colspan="2">종사업장</th>
											<td colspan="2"><input type="text" name="InvoiceeTaxRegID1" id="" class="in_txt_off" readOnly value="" style="width:85%;*width:84%;" maxlength="4" tabindex="15"></td>
										</tr>
										<tr>
											<th colspan="2">상호</th>
											<td colspan="3"><textarea name="InvoicerCorpName1" id="" class="in_txt_off" readOnly style="width:96.5%;*width:95.5%;" maxlength="70" tabindex="6">주식회사 휴에이션</textarea></td>
											<th>성명</th>
											<td colspan="2"><textarea name="InvoicerCEOName1" id="" class="in_txt_off" readOnly style="width:91%;*width:89%;" maxlength="30" tabindex="7">김준민</textarea></td>
											<th>상호 *</th>
											<td colspan="3"><textarea name="InvoiceeCorpName1" id="" class="in_txt_off" readOnly style="width:96.5%;*width:95.5%;" maxlength="70" tabindex="16"><%=invoiceDto.getComp_nm() %></textarea></td>
											<th>성명 *</th>
											<td colspan="3"><textarea name="InvoiceeCEOName1" id="" class="in_txt_off" readOnly style="width:91.5%;*width:89.5%;" maxlength="30" tabindex="17"><%=invoiceDto.getOwner_nm() %></textarea></td>
										</tr>
										<tr>
											<th colspan="2">사업장주소</th>
											<td colspan="6"><textarea name="InvoicerAddr1" id="" class="in_txt_off" readOnly style="width:98%;height:50px;*width:97%;" maxlength="150" tabindex="8">서울특별시 금천구 디지털로9길 32(가산동,갑을그레이트밸리B동 602호)</textarea></td>
											<th>사업장주소 *</th>
											<td colspan="7"><textarea name="InvoiceeAddr1" id="" class="in_txt_off" readOnly style="width:98%;height:50px;*width:97%;" maxlength="150" tabindex="18"><%=addressNo%></textarea></td>
										</tr>
										<tr>
											<th colspan="2">업태</th>
											<td colspan="2"><textarea name="InvoicerBizType1" id="" class="in_txt_off" readOnly style="width:95%;*width:94%;" maxlength="40" tabindex="9">서비스,도소매</textarea></td>
											<th>종목</th>
											<td colspan="3"><textarea name="InvoicerBizClass1" id="" class="in_txt_off" readOnly style="width:94%;*width:93%;" maxlength="40" tabindex="10">소프트웨어개발외,컴퓨터 및 주변장치,통신 재판매업</textarea></td>
											<th>업태</th>
											<td colspan="2"><textarea name="InvoiceeBizType1" id="" class="in_txt_off" readOnly style="width:95%;*width:94%;" maxlength="40" tabindex="19"><%=invoiceDto.getBusiness() %></textarea></td>
											<th>종목</th>
											<td colspan="4"><textarea name="InvoiceeBizClass1" id="" class="in_txt_off" readOnly style="width:95%;*width:93%;" maxlength="40" tabindex="20"><%=invoiceDto.getB_item() %></textarea></td>
										</tr>
										<tr>
											<th colspan="2">담당자</th>
											<td colspan="2"><input type="text" name="InvoicerContactName11" id="" class="in_txt_off" readOnly value="김경화" style="width:95%;*width:94%;" maxlength="30" tabindex="11"></td>
											<th>연락처</th>
											<td colspan="3"><input type="text" name="InvoicerTEL11" id="" class="in_txt_off" readOnly value="02-2081-6713" style="width:94%;*width:93%;" maxlength="20" tabindex="12"></td>
											<th>담당자</th>
											<td colspan="2"><input type="text" name="InvoiceeContactName11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getReceiver()%>" style="width:95%;*width:94%;" maxlength="30" tabindex="21"></td>
											<th >연락처</th>
											<td colspan="4"><input type="text" name="InvoiceeTEL11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getTELL()%>" style="width:95%;*width:93%;" maxlength="20" tabindex="22"></td>
										</tr>
										<tr>
											<th colspan="2">이메일</th>
											<td colspan="6"><input type="text" name="InvoicerEmail11" id="" class="in_txt_off" readOnly value="khkim@huation.com" style="width:98%;*width:97%;" maxlength="40" tabindex="13"></td>
											<th>이메일</th>
											<td colspan="7"><input type="text" name="InvoiceeEmail11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getE_MAIL()%>" style="width:98%;" maxlength="40" tabindex="23"></td>
										</tr>
										<tr>
											<th colspan="3">작성</th>
											<th colspan="8">공급가액</th>
											<th colspan="7">세액</th>
										</tr>
										<tr>
											<td colspan="3">
												<input type="text" name="WriteDT1" maxlength="4" id="" class="in_txt_off" readOnly IconYN="0" value="<%=Today%>" style="width:93%;" maxlength="10" tabindex="25">
												
											</td>
											<td colspan="8"><input type="text" name="AmountTotal1"  id="" class="in_txt"  value="" style="width:98.5%;" maxlength="18" ></td>
											<td colspan="7"><input type="text"  name="TaxTotal1" id="" class="in_txt"  value="" style="width:98%;" maxlength="18" ></td>
										</tr>
										<tr>
											<th colspan="3">비고1</th>
											<td colspan="14"><input type="text" name="Remark11" id="" class="in_txt_off" readOnly value="당초세금계산서 작성일(<%=invoiceDto.getPublic_dt()%>),당초 승인번호 (<%=invoiceDto.getApprove_no()%>)" style="width:99.1%;*width:99%;" maxlength="150" tabindex="26"></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th colspan="3">작성방법</th>
											<td colspan="15">
												<input type="radio" name="WriteType1" id="WriteType4" value="4" checked onclick="changeWriteType(4);"><label class="for" for="WriteType4"> 직접입력</label>
											</td>
										</tr>
										<tr>
											<th>월<input type="hidden" name="DetailJSON" id="" value="" ></th>
											<th>일</th>
											<th colspan="3">품목</th>
											<th colspan="3">규격</th>
											<th colspan="2">수량</th>
											<th>단가</th>
											<th>공급가액</th>
											<th colspan="2">세액</th>
											<th colspan="3">비고</th>
											<th><img src="<%= request.getContextPath()%>/images/btn_plus.gif" value="행추가" id ="bt"  style="cursor:pointer;" onclick="javascript:addRow();"/></th>
										</tbody>
										<tbody id="template">
										<%while(ds.next()){%>
										<tr id="tr1">
											<td><input type="text" name="PurchaseDT11" id="" class="in_txt"  value="<%=Month%>" style="width:12px;" maxlength="2" tabindex="50"></td>
											<td><input type="text" name="PurchaseDT21" id="" class="in_txt"  value="<%=DATE%>" style="width:12px;" maxlength="2" tabindex="50"></td>
											<td colspan="3"><textarea name="ItemName1" id="" class="in_txt"  style="width:96.5%;*width:95.5%;" maxlength="100" tabindex="50"><%=ds.getString("ITEM_NAME")%></textarea></td>
											
												<input type = "hidden" name="Qty1" class="in_txt2" style="width:80px" value=""/>
												<input type = "hidden" name="UnitCost1" class="in_txt2" style="width:80px" value=""/>
												<input type = "hidden" name="Amount1" class="in_txt2" style="width:80px" value=""/>
												<input type = "hidden" name="Tax1" class="in_txt2" style="width:80px" value=""/>
											
											<td colspan="3"><textarea name="Spec1" id="" class="in_txt"  style="width:94.5%;*width:93.5%;" maxlength="60" tabindex="50"></textarea></td>
											<td colspan="2"><input type="text" name="Qty_view1" id="Qty_view" class="in_txt"  onKeyUp = "saleCntCal('Qty','tr1');"  value="" style="width:91%;*width:90%;" maxlength="4" tabindex="50"></td>
											<td><input type="text" name="UnitCost_view1" id="UnitCost_view1" class="in_txt"  onKeyUp = "saleCntCal('UnitCost','tr1');" value="" style="width:90.5%;*width:89.5%;" maxlength="18" tabindex="50"></td>
											<td><input type="text"  name="Amount_view1" id="Amount" class="in_txt"  value="" style="width:92%;*width:91%;" maxlength="18" tabindex="50"></td>
											<td colspan="2"><input type="text"  name="Tax1" id="" class="in_txt"  value="" style="width:93%;*width:92%;" maxlength="18" tabindex="50"></td>
											<td colspan="3"><textarea name="Remark1" id="" class="in_txt"  style="width:93%;*width:91%;" maxlength="100" tabindex="50"></textarea></td>
											<td>&nbsp;</td>
										</tr>
										<%
										}
										%>
										</tbody>
										<tbody>
										<tr>
											<th colspan="4">합계금액</th>
											<th colspan="3">현금</th>
											<th colspan="2">수표</th>
											<th colspan="2">어음</th>
											<th>외상미수금</th>
											<td colspan="6" rowspan="2" class="claim">이 금액을&nbsp;&nbsp;&nbsp;<input type="radio" name="PurposeType" id="PurposeType2" value="2" checked ><label class="for" for="PurposeType2"> 청구함</label></td>
										</tr>
										<tr>
											<td colspan="4"><input type="text" name="TotalAmount1"  id="" class="in_txt" value="-<%=Supply+vat%>" style="width:97%;*width:96%;"  maxlength="18"></td>
											<td colspan="3"><input type="text" name="Cash1" id="" readOnly class="in_txt_off" value="" style="width:94%;*width:92%;" maxlength="18" tabindex="51"></td>
											<td colspan="2"><input type="text" name="ChkBill1" id="" readOnly class="in_txt_off" value="" style="width:91%;*width:89%;" maxlength="18" tabindex="52"></td>
											<td colspan="2"><input type="text" name="Note1" id="" readOnly class="in_txt_off" value="" style="width:93%;*width:91%;" maxlength="18" tabindex="53"></td>
											<td><input type="text" name="Credit" id="" readOnly class="in_txt_off" value="" style="width:92%;*width:90%;" maxlength="18" tabindex="54"></td>
										</tr>
								</tbody>
								</table>
								
	<!-- //////////////////////////////////////////////////////////////////////////////////////// -->







</div>

<div class="clearb"></div>
<input type="hidden" name="InvoicerContactID1" id="" value="huation" ><input type="hidden" name="InvoiceeContactID1" id="" value="" ><input type="hidden" name="TrusterContactID1" id="" value="" ></div>



</form>
	
	<!-- //////////////////////////////////////////////////////////////////////////////////////// -->







</div>

<div class="clearb"></div>
<input type="hidden" name="InvoicerContactID1" id="" value="huation" ><input type="hidden" name="InvoiceeContactID1" id="" value="" ><input type="hidden" name="TrusterContactID1" id="" value="" ></div>



</form>
	<div id="panel_button">
		<center>
			
			<a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg2.gif" value="발행" onclick="javascript:registInvoice();"  width="73" height="28" alt="발행" /></a>
			<a href="#"><img src="<%=request.getContextPath()%>/images/btn_cancel2.gif" onclick="javascript:cancle();" width="73" height="28" alt="취소" title="취소" /></a>
			
		</center>
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

<%= comDao.getMenuAuth(menulist,"14") %>