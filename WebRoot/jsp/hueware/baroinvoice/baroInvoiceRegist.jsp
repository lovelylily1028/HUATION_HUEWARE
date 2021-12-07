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

<%
	Map model = (Map)request.getAttribute("MODEL");

	BankManageDTO bmDto = (BankManageDTO)model.get("bmDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String AccountNumber = (String)model.get("AccountNumber");
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
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.js"></script>


<SCRIPT LANGUAGE="JavaScript">
	



function registInvoice(){

	
	var frm = document.baroInvoiceRegist;
	
	frm.public_no.value=frm.p_public_no.value;
	
	
	var PreDeposit = frm.pre_deposit_dt_View.value;
	var PreDeposit2 = PreDeposit.replace(/-/g,'');
	frm.pYear5.value=PreDeposit2.substr(0,4);
	frm.pMonth5.value=PreDeposit2.substr(4,2);
	frm.pDay5.value=PreDeposit2.substr(6,2);
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //입금예상일자

	
	var Deposit = frm.deposit_dt_View.value;
	var Deposit2 = Deposit.replace(/-/g,'');
	frm.pYear3.value=Deposit2.substr(0,4);
	frm.pMonth3.value=Deposit2.substr(4,2);
	frm.pDay3.value=Deposit2.substr(6,2);
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //입금일자
	
	
	frm.WriteDT.value = frm.WriteDT1.value+frm.WriteDT2.value+frm.WriteDT3.value;
	
	frm.purchase.value = frm.year.value + frm.PurchaseDT1.value + frm.PurchaseDT2.value;

	if(frm.InvoiceeCorpNum.value == ""){
		alert("등록번호를 입력하세요.");
		return;
	}if(frm.InvoiceeCorpName.value == ""){
		alert("상호명을 입력하세요.");
		return;
	}if(frm.InvoiceeCEOName.value == ""){
		alert("공급받는자의 성명을 입력하세요.");
		return;
	}if(frm.InvoiceeAddr.value == ""){
		alert("공급받는자의 사업장 주소를 입력하세요.");
		return;
	}if(frm.InvoiceeBizType.value == ""){
		alert("공급받는자의 업태를 입력하세요.");
		return;
	}if(frm.InvoiceeBizClass.value == ""){
		alert("공급받는자의 종목을 입력하세요.");
		return;
	}
	if(frm.AmountTotal.value == ""){
		alert("공급가액을 입력하세요.");
		return;
	}
	if(frm.TaxTotal.value == ""){
		alert("세액을 입력하세요.");
		return;
	}
	if(frm.contract_no.value == ""){
		alert("계약관리 번호를 선택하세요.");
		return;
	}
	if(frm.p_public_no.value.length == 0){
		alert("견적서 발행번호를 입력하세요!");
		return;
	}
	
	if(frm.pre_deposit_dt.value.length == 0){
		alert("입금예상일자를 선택하세요.");
		return;
		}
	
	if(frm.pre_deposit_an.value == ""){
		alert("입금예정계좌를 선택하세요.");
		return;
	}
	
	
	if(frm.deposit_dt.value.length != 0){
		if(frm.deposit_amt.value== 0){
			alert("입금일을 입력하신경우 입금금액을 필수로 입력하셔야 합니다.");
			return;
		}
	}

	
	
	
	
	var Y2 = frm.WriteDT1.value;
	var M2 = frm.WriteDT2.value;
	var D2 = frm.WriteDT3.value;
	
	if(Y2.length>0){
		if (!isNumber(trim(Y2))) {
			alert("년도는 숫자만 입력이 가능합니다.");
				Y2=onlyNum(Y2);
			frm.WriteDT1.value ="";
			return;
			
		}else{
				Y2=onlyNum(Y2)
			} 
		}
	if(Y2.length<4){
		alert('년도는 4자리수 미만사용불가능합니다.');
		Y2=onlyNum(Y2);
		frm.WriteDT1.value ="";
		return;
	}else{
		Y2=onlyNum(Y2)
	}
	
	
	if(M2.length>0){
		if (!isNumber(trim(M2))) {
			alert("월자는 숫자만 입력이 가능합니다.");
				Y2=onlyNum(M2);
			frm.WriteDT2.value ="";
			return;
			
		}else{
				Y2=onlyNum(M2);
				
			} 
		}
	if(M2.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		M2=onlyNum(M2);
		frm.WriteDT2.value ="";
		return;
	}else{
		M2=onlyNum(M2)
	}
	if(D2.length>0){
		if (!isNumber(trim(D2))) {
			alert("일자는 숫자만 입력이 가능합니다.");
				Y2=onlyNum(D2);
			frm.WriteDT3.value ="";
			return;
		
		}else{
			Y2=onlyNum(D2);	
			}
		}
	if(D2.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		D2=onlyNum(D2);
		frm.WriteDT3.value ="";
		return;
	}else{
		D2=onlyNum(D2)
	}
	if(Y2.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(M2.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(M2 > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.WriteDT2.value ="";
		return;
	}else{
		Y2=onlyNum(M2);
	}
		
	if(D2.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(D2 > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.WriteDT3.value ="";
		return;
	}else{
		Y=onlyNum(D2);
	}
	
	
	
	if(frm.deposit_amt.value!= 0 && frm.deposit_dt.value.length != 0){
		frm.state.value='03';
	}else{
		frm.state.value='01';
	}
	
	
	frm.issuetype.value='01';
	
	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	
	var Y = frm.pYear5.value;
	var M = frm.pMonth5.value;
	var D = frm.pDay5.value;
	
	if(Y.length>0){
		if (!isNumber(trim(Y))) {
			alert("년도는 숫자만 입력이 가능합니다.");
				Y=onlyNum(Y);
			frm.pYear5.value ="";
			return;
			
		}else{
				Y=onlyNum(Y)
			} 
		}
	if(Y.length<4){
		alert('년도는 4자리수 미만사용불가능합니다.');
		Y=onlyNum(Y);
		frm.pYear5.value ="";
		return;
	}else{
		Y=onlyNum(Y)
	}
	
	
	if(M.length>0){
		if (!isNumber(trim(M))) {
			alert("월자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(M);
			frm.pMonth5.value ="";
			return;
			
		}else{
				Y=onlyNum(M);
				
			} 
		}
	if(M.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		M=onlyNum(M);
		frm.pMonth5.value ="";
		return;
	}else{
		M=onlyNum(M)
	}
	if(D.length>0){
		if (!isNumber(trim(D))) {
			alert("일자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(D);
			frm.pDay5.value ="";
			return;
		
		}else{
			Y=onlyNum(D);	
			}
		}
	if(D.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		D=onlyNum(D);
		frm.pDay5.value ="";
		return;
	}else{
		D=onlyNum(D)
	}
	if(Y.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(M.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(M > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.pMonth5.value ="";
		return;
	}else{
		Y=onlyNum(M);
	}
		
	if(D.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(D > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.pDay5.value ="";
		return;
	}else{
		Y=onlyNum(D);
	}
	
	
	
	if(frm.deposit_dt.value != ''){
		
		var Y1 = frm.pYear3.value;
		var M1 = frm.pMonth3.value;
		var D1 = frm.pDay3.value;
		
		if(Y1.length>0){
			if (!isNumber(trim(Y1))) {
				alert("년도는 숫자만 입력이 가능합니다.");
					Y1=onlyNum(Y1);
				frm.pYear3.value ="";
				return;
				
			}else{
					Y1=onlyNum(Y1)
				} 
			}
		if(Y1.length<4){
			alert('년도는 4자리수 미만사용불가능합니다.');
			Y1=onlyNum(Y1);
			frm.pYear3.value ="";
			return;
		}else{
			Y1=onlyNum(Y1)
		}
		
		
		if(M1.length>0){
			if (!isNumber(trim(M1))) {
				alert("월자는 숫자만 입력이 가능합니다.");
					Y1=onlyNum(M1);
				frm.pMonth3.value ="";
				return;
				
			}else{
					Y1=onlyNum(M1);
					
				} 
			}
		if(M1.length<2){
			alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
			M1=onlyNum(M1);
			frm.pMonth3.value ="";
			return;
		}else{
			M1=onlyNum(M1)
		}
		if(D1.length>0){
			if (!isNumber(trim(D1))) {
				alert("일자는 숫자만 입력이 가능합니다.");
					Y1=onlyNum(D1);
				frm.pDay3.value ="";
				return;
			
			}else{
				Y1=onlyNum(D1);	
				}
			}
		if(D1.length<2){
			alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
			D1=onlyNum(D1);
			frm.pDay3.value ="";
			return;
		}else{
			D1=onlyNum(D1)
		}
		if(Y1.length==0){
			alert('년도 입력하세요.');
			return;
		}
		if(M1.length==0){
			alert('월자를 입력하세요.');
			return;
		}
		if(M1 > 12){
			alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

			frm.pMonth3.value ="";
			return;
		}else{
			Y1=onlyNum(M1);
		}
			
		if(D1.length==0){
			alert('일자를 입력하세요.');
			return;
		}
		if(D1 > 31){
			alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
			frm.pDay3.value ="";
			return;
		}else{
			Y1=onlyNum(D1);
		}
		if(frm.WriteDT.value > frm.deposit_dt.value){
			alert('입금일자보다 발행일자가 큽니다.');
			return;
		}
	}
	
	
	
	
	
	
	frm.submit();
	
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
	
	
	var qtyVal = $("#"+rowNumber+" [name=Qty_view]").val();//해당 tr의 수량을 가져옴
	var unitCostVal = $("#"+rowNumber+" [name=UnitCost_view]").val();//해당 tr의 단가를 가져옴
	
	
	var oriNumber = new String(parseInt(qtyVal)*parseInt(unitCostVal));//숫자값으로 곱한후 스트링으로 만듬
	
	var oriTaxVal = new String((parseInt(qtyVal)*parseInt(unitCostVal))*0.1);//부가세
	var oriTaxVal1 = new String(parseInt(oriTaxVal));//부가세 소수점 때기
	
	var changeNumber = 	addCommaStr(oriNumber);//콤마 추가
	var changeTaxVal = addCommaStr(oriTaxVal1);//콤마추가

	if(changeNumber=="NaN"){//예외처리
		
	}else{
		$("#"+rowNumber+" [name=Amount_view]").val(changeNumber);
	}
	if(changeTaxVal=="NaN"){//예외처리
		
	}else{
		$("#"+rowNumber+" [name=Tax_view]").val(changeTaxVal);
	}
	var amountCnt = $('[name=Amount_view]').length;//각행의 공급가액을 더해줘야함
	var amountTotal=0;//토탈 공급가액
	
	for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	var taxCnt1 = $('[name=Tax_view]').length;
	var taxTotal1=0;//토탈 부가세
	for(var x=0; x<taxCnt1; x++){//반복문으로 넣어줌
		
		
		
		var tax = $('[name=Tax_view]').eq(x).val().replace(/,/gi,"");
		
		var tax1 = parseInt(tax);
		
		taxTotal1 += tax1;	
	}
	var taxTotal2 = taxTotal1;
	
	var amountTotalVal = addCommaStr(new String(amountTotal)); 
	 var taxTotalVal = addCommaStr(new String(taxTotal2));
	
	
	
	 if(addCommaStr(new String(taxTotal2))=="NaN"){//예외처리
		}else{
			$('[name=TaxTotal]').val(taxTotalVal);
		}
	
	if(addCommaStr(new String(amountTotal))=="NaN"){//예외처리
	
	}else{
		$('[name=AmountTotal]').val(amountTotalVal);
	}
	var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
	var changeTotalAmount = addCommaStr(TotalAmount);
	
	if(addCommaStr(new String(TotalAmount))=="NaN"){//예외처리
		
	}else{
		$('[name=TotalAmount]').val(changeTotalAmount);
	}
	
	
	
	
}

function cancle(){
	
	var frm = document.baroInvoiceRegist;
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
	frm.submit();

}
function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
} 

function popContractNo(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=1400,height=700,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=1, status=no");
}

function popComp(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_baro&sForm=baroInvoiceRegist","","width=850,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
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
	rowString +=	"<td><input type=\"text\" name=\"PurchaseDT1\" id=\"\" class=\"text\" value=\"<%=Month%>\" style=\"width:14px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\" name=\"PurchaseDT2\" id=\"\" class=\"text\" value=\"<%=DATE%>\" style=\"width:13px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"2\">"
	rowString +=	"<textarea name=\"ItemName\" id=\"\" class=\"text\" style=\"width:253px;\" maxlength=\"100\" tabindex=\"50\"></textarea>"
	rowString +=	"</td>"
						
	rowString +=		"<input type = \"hidden\" id=\"Qty_"+rowNumber+"\"  name=\"Qty\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"UnitCost\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Amount\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Tax\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
						
	rowString +=	"<td colspan=\"2\"><textarea name=\"Spec\" id=\"\" class=\"text\" style=\"width:133px;\" maxlength=\"60\" tabindex=\"50\"></textarea></td>"
	rowString +=	"<td colspan=\"2\"><input type=\"text\" name=\"Qty_view\" id=\"Qty_view\" class=\"text\" onKeyUp = \"saleCntCal('Qty','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('Qty','tr"+rowNumber+"');\"  value=\"\" style=\"width:109px;\" maxlength=\"12\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\"  name=\"UnitCost_view\" id=\"UnitCost_view\" class=\"text\"  onKeyUp = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" value=\"\" style=\"width:109px;\"  maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\" readOnly name=\"Amount_view\" id=\"Amount\" class=\"text\"  value=\"\" style=\"width:109px;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td><input type=\"text\" readOnly name=\"Tax_view\" id=\"\" class=\"text\" value=\"\" style=\"width:109px;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td><textarea name=\"Remark\" id=\"\" class=\"text\" style=\"width:109px;\" maxlength=\"100\" tabindex=\"50\"></textarea></td>"
		rowString +="<td class=\"text_c\"><img  src=\"<%= request.getContextPath()%>/images/sub/invoice_btn_del.gif\" value=\"행삭제\" id =\"bt\"  style=\"cursor:pointer;\" onclick=\"javascript:removeRow(this,rowNumber);\"/></td>"; 
		rowString +="</tr>";
									
	$('#template').append(rowString);
	
	rowNumber = rowNumber+1;
	var amountTotal=0;//토탈 공급가액
	
	for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	
	
 }
 
	 
	// 행 삭제
	 function removeRow(obj,rowNumber){	
	  $(obj).parent().parent().remove(); //화면 tbody 안에 tr td 지워주기.
	  
		
		var amountCnt = $('[name=Amount_view]').length;//각행의 공급가액을 더해줘야함
		var amountTotal=0;//토탈 공급가액
		
		for(var x=0; x<amountCnt; x++){//반복문으로 넣어줌
			
			/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
			var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
			
			var amount1 = parseInt(amount);
			
			amountTotal = amountTotal+amount1;
			
		}
		var taxCnt1 = $('[name=Tax]').length;
		var taxTotal1=0;//토탈 부가세
		for(var x=0; x<taxCnt1; x++){//반복문으로 넣어줌
			
			
			
			var tax = $('[name=Tax]').eq(x).val().replace(/,/gi,"");
			
			var tax1 = parseInt(tax);
			
			taxTotal1 += tax1;	
		}
		var taxTotal2 = taxTotal1/2;
		
		var amountTotalVal = addCommaStr(new String(amountTotal)); 
		 var taxTotalVal = addCommaStr(new String(taxTotal2));
		
		
		
		 if(addCommaStr(new String(taxTotal2))=="NaN"){//예외처리
			}else{
				$('[name=TaxTotal]').val(taxTotalVal);
			}
		
		if(addCommaStr(new String(amountTotal))=="NaN"){//예외처리
		
		}else{
			$('[name=AmountTotal]').val(amountTotalVal);
		}
		var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
		var changeTotalAmount = addCommaStr(TotalAmount);
		
		if(addCommaStr(new String(TotalAmount))=="NaN"){//예외처리
			
		}else{
			$('[name=TotalAmount]').val(changeTotalAmount);
		}
		
		
	 
	 } 
	
	function day_check(){
		var ttt = $('[name=WriteDT3]').val();
		$('[name=PurchaseDT2]').val(ttt);
	}
	
	function saleCntCal2(form){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.invoiceVeiw;
		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}

		if (!isNumber(trim(v_obj.value))) {
			alert("숫자만 입력해 주세요.");
			return;
		} 
		
			if(form=='invoiceVeiw.deposit_amt'){
			var num=onlyNum(v_obj.value);
			v_obj.value = addCommaStr(num);
			obj.value = num;
			v_obj.focus();
			}else{
			
			var num=onlyNum(v_obj.value);
			v_obj.value = addCommaStr(num);
			obj.value = num;
		if(form=='invoiceVeiw.supply_price'){	
			var vat=parseInt(parseInt(costobj.supply_price.value,10)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		}

		var tcost=parseInt(costobj.supply_price.value,10)+parseInt(costobj.vat.value,10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		v_obj.focus();
			}
	}
	
	</script>

</head>
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
	<div id="content">
	
	<!-- title -->	
	<div class="content_navi">영업지원 &gt; (신)세금계산서등록</div>
	<h3><span>(신)</span>세금계산서등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
	<!-- title -->
		
	<div class="con baroRegistForm">
	<!-- 국세청세금계산서발행 -->
	<div class="con_sub">
	<h4>국세청세금계산서발행</h4>
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
					
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
	</div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 등록 -->

			<!-- calendar -->
			<div id="CalendarLayer" style="display:none; width:172px; height:176px; ">
				<iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
			</div>
			<form name="baroInvoiceRegist" method="post"   action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroRegist" >
				<input type="hidden" name="pYear3" id="" value="" >
				<input type="hidden" name="pMonth3" id="" value="" >
				<input type="hidden" name="pDay3" id="" value="" >
				<input type="hidden" name="pDay5" id="" value="" >
				<input type="hidden" name="pYear5" id="" value="" >
				<input type="hidden" name="pMonth5" id="" value="" >
				<input type="hidden" name="InvoiceKey" id="" value="" >
				<input type="hidden" name="Role" id="" value="1" >
				<input type="hidden" name="supply_price_view" id="" value="" >
				<input type="hidden" name="vat_view" id="" value="" >
				<input type="hidden" name="receiver" id="" value="" >
				<input type="hidden" name="total_amt_view" id="" value="" >
				<input type="hidden" name="ModifyCode" id="" value="0" >
				<input type = "hidden" name = "curPage" value="<%=curPage%>">
				<input type = "hidden" name = "searchGb" value="<%=searchGb%>">
				<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
				<input type = "hidden" name = "comp_code" value="">
				<input type = "hidden" name = "permit_no" value=""></input>
				<input type = "hidden" name = "public_no" value="">
				<input type = "hidden" name = "user_id" value="">
				<input type = "hidden" name = "user_nm" value="">
				<input type = "hidden" name = "sales_charge" value="">
				<input type = "hidden" name = "e_comp_nm" value="">
				<input type = "hidden" name = "state" value="">
				<input type = "hidden" name = "issuetype" value="">
				<input type = "hidden" name = "purchase" value="">
				<input type = "hidden" name = "year" value="<%=Integer.toString(cal.get(Calendar.YEAR))%>">
				<!-- <div id="panel_taxtype"><input type="hidden" name="TaxCalcType" id="" value="2" >
					<div class="taxtype">
						<img src="http://image.barobill.co.kr/barobill_testbed/invoice/taxtype_title1.gif" class="title1">
						<div class="taxtype_radio">
							<input type="radio" name="TaxType" id="TaxType1" class="rb" value="1" checked onclick="changeTaxType(1);"><label class="for" for="TaxType1">과세(10%)</label>&nbsp;&nbsp;
						</div>
						<img src="http://image.barobill.co.kr/barobill_testbed/invoice/taxtype_title2.gif" class="title2">
						<div class="invoiceetype_radio">
							<input type="radio" name="InvoiceeType" id="InvoiceeType1" class="rb" value="1" checked onclick="changeInvoiceeType(1);"><label class="for" for="InvoiceeType1">사업자</label>&nbsp;&nbsp;
							<input type="radio" name="InvoiceeType" id="InvoiceeType2" class="rb" value="2"  onclick="changeInvoiceeType(2);"><label class="for" for="InvoiceeType2">개인</label>&nbsp;&nbsp;
							<input type="radio" name="InvoiceeType" id="InvoiceeType3" class="rb" value="3"  onclick="changeInvoiceeType(3);"><label class="for" for="InvoiceeType3">외국인</label>
						</div>
					</div>
				</div> -->

					<fieldset>
						<legend>전자세금계산서</legend>
						<table class="tbl_type tbl_type_invoice" summary="전자세금계산서">
							<colgroup>
								<col width="3%" />
								<col width="3%" />
								<col width="8%" />
								<col width="15%" />
								<col width="2%" />
								<col width="11%" />
								<col width="8%" />
								<col width="3%" />
								<col width="11%" />
								<col width="11%" />
								<col width="11%" />
								<col width="11%" />
								<col width="3%" />
							</colgroup>
							
							<tbody>
							<tr class="title_area">
								<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
								<th rowspan="2" colspan="8" class="title" id="FormTitleName">전자세금계산서</th>
								<th rowspan="2" colspan="2">공급자<br />(보관용)</th>
								<th><label for="">책번호</label></th>
								<td colspan="2"><input type="text" id="" name="Kwon" class="text" title="권" style="width:48px;" maxlength="4" tabindex="1"/> 권&nbsp;&nbsp;<input type="text" id="" name="Ho" class="text" title="호" style="width:48px;" maxlength="4" tabindex="2"/> 호</td>
							</tr>

							<tr class="title_area">
								<th><label for="">일련번호</label></th>
								<td colspan="2"><input type="text" id="" name="SerialNum" class="text" title="일련번호" style="width:145px;" maxlength="27" tabindex="3"/></td>
							</tr>							
		
							<tr>
								<th><label for="">공<br />급<br />자</label></th>
								<td colspan="6" class="listT">
									<table class="tbl_type" summary="공급자정보">
										<colgroup>
											<col width="17%" />
											<col width="33%" />
											<col width="17%" />
											<col width="33%" />
										</colgroup>
										<tbody>
										<tr>
											<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
											<th><label for="">등록번호</label></th>
											<td><input type="text" id="" name="InvoicerCorpNum" class="text dis" title="등록번호" style="width:162px;" value="108-81-93762" maxlength="10" readonly tabindex="4"/></td><!-- input 비활성화 class="dis" 추가 -->
											<th><label for="">종사업장</label></th>
											<td class="last"><input type="text" name="InvoicerTaxRegID" id="" class="text" title="종사업장" style="width:163px;" maxlength="4" tabindex="5"/></td>
										</tr>			
							
										<tr>
											<th><label for="">상호</label></th>
											<td><textarea id="" title="상호" name="InvoicerCorpName" style="width:162px;" maxlength="70" tabindex="6">주식회사 휴에이션</textarea></td>
											<th><label for="">성명</label></th>
											<td class="last"><textarea id="" name="InvoicerCEOName" title="성명" style="width:163px;" maxlength="30" tabindex="7">김준민</textarea></td>
										</tr>							
							
										<tr>
											<th><label for="">사업장주소</label></th>
											<td colspan="3" class="last"><textarea id="" name="InvoicerAddr" title="사업장주소" style="width:444px;height:41px;" maxlength="150" tabindex="8">서울특별시 금천구 디지털로9길 32(가산동,갑을그레이트밸리A동 1701호)</textarea></td>
										</tr>	
										
										<tr>
											<th><label for="">업태</label></th>
											<td><textarea id="" name="InvoicerBizType" title="업태" style="width:162px;"maxlength="40" tabindex="9">서비스,도소매</textarea></td>
											<th><label for="">종목</label></th>
											<td class="last"><textarea id="" name="InvoicerBizClass" title="종목" style="width:163px;" maxlength="40" tabindex="10">소프트웨어개발외,컴퓨터 및 주변장치,통신 재판매업</textarea></td>
										</tr>	

										<tr>
											<th><label for="">담당자</label></th>
											<td><input type="text" id="" name="InvoicerContactName1" class="text" title="담당자" style="width:163px;" maxlength="30" tabindex="11" value="휴에이션"/></td>
											<th><label for="">연락처</label></th>
											<td class="last"><input type="text" name="InvoicerTEL1" id="" class="text" title="연락처" style="width:164px;" value="02-2081-6713" maxlength="20" tabindex="12"/></td>
										</tr>																									

										<tr class="last">
											<th><label for="">이메일</label></th>
											<td colspan="3" class="last"><input type="text" id=""  name="InvoicerEmail1" class="text" title="이메일" style="width:445px;" value="taxinvoice@huation.com" maxlength="40" tabindex="13"/></td>
										</tr>
										</tbody>
									</table>
								</td>
							
							<th><label for="">공<br />급<br />받<br />는<br />자</label></th>
				<td colspan="5" class="listT">
					<table class="tbl_type" summary="공급받는자정보">
								<colgroup>
									<col width="17%" />
									<col width="33%" />
									<col width="17%" />
									<col width="33%" />
								</colgroup>
								<tbody>
							<tr>
								<th><label for="">등록번호</label></th>
								<td><input type="text"  name="InvoiceeCorpNum"onClick="javascript:popComp();" id="" class="text" value="" style="width:98px;" maxlength="14" tabindex="14"><a href="#" class="btn_type03" onclick="javascript:popComp();"><span>업체조회</span></a></td>
								<th><label for="">종사업장</label></th>
								<td class="last"><input type="text" name="InvoiceeTaxRegID" id="" class="text" value="" style="width:164px;" maxlength="4" tabindex="15"></td>
							</tr>
							
							<tr>
								<th><label for="">상호 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></label></th>
								<td><textarea name="InvoiceeCorpName" id=""style="width:163px;" maxlength="70" tabindex="16"></textarea></td>
								<th><label for="">성명 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></label></th>
								<td class="last"><textarea name="InvoiceeCEOName" id="" style="width:164px;" maxlength="30" tabindex="17"></textarea></td>
							</tr>
							
							<tr>
								<th><label for="">사업장주소 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></label></th>
								<td colspan="3" class="last"><textarea name="InvoiceeAddr" id="" style="width:445px;height:41px;" maxlength="150" tabindex="18"></textarea></td>
							</tr>
							
							<tr>
								<th><label for="">업태 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></label></th>
								<td><textarea name="InvoiceeBizType" id="" style="width:163px;" maxlength="40" tabindex="19"></textarea></td>
								<th><label for="">종목 <img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></label></th>
								<td class="last"><textarea name="InvoiceeBizClass" id="" style="width:164px;" maxlength="40" tabindex="20"></textarea></td>
							</tr>
							
							<tr>
								<th><label for="">담당자</label></th>
								<td><input type="text" name="InvoiceeContactName1" id="" class="text" value="---" style="width:163px;" maxlength="30" tabindex="21"></td>
								<th><label for="">연락처</label></th>
								<td class="last"><input type="text" name="InvoiceeTEL1"  onkeyup="javascript:format_phone(this);" id="" class="text" value=""  style="width:164px;" maxlength="14" tabindex="22"></td>
							</tr>
							
							<tr class="last">
								<th><label for="">이메일</label></th>
								<td colspan="3" class="last"><input type="text" name="InvoiceeEmail1" id="" class="text" value="" style="width:445px;" maxlength="40" tabindex="23"></td>
							</tr>
							</tbody>
						</table>
					</td>
				</tr>
							<tr>
								<th colspan="3"><label for="">작성</label></th>
								<th colspan="6"><label for="">공급가액</label></th>
								<th colspan="4"><label for="">세액</label></th>
							</tr>
							
							<tr>
								<td colspan="3"><input type = "hidden" name="WriteDT" id = "WriteDT"/><input type="text" name="WriteDT1" maxlength="4" id="" class="text" IconYN="0" value="<%=Integer.toString(cal.get(Calendar.YEAR))%>" style="width:35px;" maxlength="10" tabindex="25"> 년&nbsp;&nbsp;<input type="text" name="WriteDT2" maxlength="2" class="text" value="<%=df.format(cal.get(Calendar.MONTH)+1) %>" style="width:14px;"/> 월&nbsp;&nbsp;<input type="text" name="WriteDT3" maxlength="2" class="text" value="<%=df.format(cal.get(Calendar.DATE))%>" onkeyup="javascript:day_check();"style="width:14px;"/> 일</td>
								<td colspan="6"><input type="text" name="AmountTotal"  id="" class="text" value="" style="width:577px;" maxlength="18" ></td>
								<td colspan="4"><input type="text"  name="TaxTotal" id="" class="text" value="" style="width:409px;" maxlength="18" ></td>
							</tr>
							
							
							<tr>
								<th colspan="3">비고1</th>
								<td colspan="10"><input type="text" name="Remark1" id="" class="text" value="" style="width:1009px;" maxlength="150" tabindex="26"></td>
								<td>&nbsp;</td>
							</tr>
							
							<tr>
								<th colspan="3">작성방법</th>
								<td colspan="10">
									<input type="radio" name="WriteType"  class="radio md0" id="WriteType4" value="4" checked onclick="changeWriteType(4);"><label  for=""> 직접입력</label>
								</td>
							</tr>
							<tr>
								<th><label for="">월</label></th>
								<th><label for="">일</label></th>
								<th colspan="2"><label for="">품목</label></th>
								<th colspan="2"><label for="">규격</label></th>
								<th colspan="2"><label for="">수량</label></th>
								<th><label for="">단가</label></th>
								<th><label for="">공급가액</label></th>
								<th><label for="">세액</label></th>
								<th><label for="">비고</label></th>
								<th><a href="#none"><img id ="bt" src="<%= request.getContextPath()%>/images/sub/invoice_btn_add.gif" alt="추가" onclick="javascript:addRow();" /></a></th>
							</tr>
							<tbody id="template">
							<tr id="tr1">
								<td><input type="text" name="PurchaseDT1" id="" class="text" value="<%=Month%>" style="width:14px;"  maxlength="2" tabindex="50"></td>
								<td><input type="text" name="PurchaseDT2" id="" class="text" value="<%=DATE%>" style="width:13px;" maxlength="2" tabindex="50"></td>
								<td colspan="2"><textarea name="ItemName" id="" class="text" style="width:253px;" maxlength="100" tabindex="50"></textarea></td>
								
								<input type = "hidden" name="Qty" class="in_txt2" style="width:80px" value=""/>
								<input type = "hidden" name="UnitCost" class="in_txt2" style="width:80px" value=""/>
								<input type = "hidden" name="Amount" class="in_txt2" style="width:80px" value=""/>
								<input type = "hidden" name="Tax" class="in_txt2" style="width:80px" value=""/>
								
								<td colspan="2"><textarea name="Spec" id="" class="text" style="width:133px;" maxlength="60" tabindex="50"></textarea></td>
								<td colspan="2"><input type="text" name="Qty_view" id="Qty_view" class="text" onKeyUp = "saleCntCal('Qty','tr1');"  value="" style="width:109px;" maxlength="4" tabindex="50"></td>
								<td><input type="text" name="UnitCost_view" id="UnitCost_view" class="text" onKeyUp = "saleCntCal('UnitCost','tr1');" value="" style="width:109px;" maxlength="18" tabindex="50"></td>
								<td><input type="text" readOnly name="Amount_view" id="Amount" class="text" value="" style="width:109px;" maxlength="18" tabindex="50"></td>
								<td><input type="text" readOnly name="Tax_view" id="" class="text" value="" style="width:109px;" maxlength="18" tabindex="50"></td>
								<td><textarea name="Remark" id="" class="text" style="width:109px;" maxlength="100" tabindex="50"></textarea></td>
								<td class="text_c"><a href="#none"><img src="<%= request.getContextPath()%>/images/sub/invoice_btn_del.gif" alt="삭제" /></a></td>
							</tr>
							</tbody>
						
						
							<tr>
								<th colspan="5"><label for="">합계금액</label></th>
								<th><label for="">현금</label></th>
								<th colspan="2"><label for="">수표</label></th>
								<th><label for="">어음</label></th>
								<th><label for="">외상미수금</label></th>
								<td rowspan="2" colspan="3" class="claim">이 금액을 <span><input type="radio" id="" class="radio" checked="checked" title="청구함" /><label for="">청구함</label></span></td>
							</tr>
							
							<tr>
								<td colspan="5"><input type="text" name="TotalAmount" readOnly  id="" class="text dis" value="" style="width:348px;"  maxlength="18"></td>
								<td><input type="text" name="Cash" id=""  class="text dis" value="" style="width:109px;" maxlength="18" tabindex="51"></td>
								<td colspan="2"><input type="text" name="ChkBill" id=""  class="text dis" value="" style="width:109px;" maxlength="18" tabindex="52"></td>
								<td><input type="text" name="Note" id=""  class="text dis" value="" style="width:109px;" maxlength="18" tabindex="53"></td>
								<td><input type="text" name="Credit" id=""  class="text dis" value="" style="width:109px;" maxlength="18" tabindex="54"></td>
							</tr>
							
							</tbody>
						</table>
						</fieldset>
						</div>
					<!-- 세금계산서부가정보 -->
					<div class="con_sub last">
					<h4>세금계산서부가정보</h4>
					<!-- 컨텐츠 상단 영역 -->
					<div class="conTop_area">
						<!-- 필수입력사항텍스트 -->
						<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
						<!-- //필수입력사항텍스트 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
						<fieldset>
						<legend>세금계산서부가정보</legend>
						<table class="tbl_type" summary="세금계산서부가정보(계약관리번호, 제목, 견적서발행번호, 전자세금계산서발행기관, 입금예상일자, 입금예상계좌, 입금금액, 입금일자, 참고사항)">
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약관리번호</label></th>
								<td><input type="text" name="contract_no" class="text dis" value=""  style="width:200px;" readOnly onClick="javascript:popContractNo();"><a href="javascript:popContractNo();" class="btn_type03"><span>계약관리리스트 조회</span></a></td>
							</tr>
							
							
							<tr>
								<th><label for="">제목</label></th>
								<td><input type="text" name="title" class="text dis" style="width:917px;"  readOnly value=""></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적서발행번호</label></th>
								<td><input type="text" name="p_public_no" class="text dis" value=""  style="width:200px;" readOnly></td>
							</tr>
							<tr>
								<th><label for="">전자세금계산서발행기관</label></th>
								<td><input type="text" name="public_org" class="text" value="바로빌" style="width:300px;" maxlength="25"></td>
							</tr>
							
						<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입금예상일자</label></th>
								<td><span class="ico_calendar">
								<input id="calendarData1" name="pre_deposit_dt_View" class="text" style="width:100px;"/></span>
								<input type="hidden" name="pre_deposit_dt" class="text"  style="width:100px" value=""/>
								</td>
						</tr>
								
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입금예상계좌</label></th>
								<td>
									<%
										CodeParam codeParam = new CodeParam();
										codeParam.setType("select"); 
										codeParam.setStyleClass("td3");
										codeParam.setFirst("전체");
										codeParam.setName("pre_deposit_an");
										codeParam.setSelected(""); 
										//codeParam.setEvent("javascript:poductSet();"); 
										out.print(CommonUtil.getCodeListHanSeqq(codeParam,"BankAC"));
									%>
								</td>
							</tr>
						<tr>
									<th><label for="">입금금액</label></th>
							<td><input type="hidden" name="deposit_amt" class="text" style="width:200px;" value="0" /><input type="text" name="deposit_amt_view" class="text" style="width:200px;" maxlength="18"onKeyUp = "javascript:saleCntCal2('baroInvoiceRegist.deposit_amt')" value="0"/> 원<span class="guide_txt">&nbsp;&nbsp;* 입금금액 입력 시 입금일자는 필수 입력 항목입니다.</span></td>
						</tr>
							
							
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>입금일자</label></th>
								<td><span class="ico_calendar">
								<input id="calendarData2" name="deposit_dt_View" class="text" style="width:100px;"/></span>
								<input type="hidden" name="deposit_dt" class="text"  style="width:100px" value=""/>
								</td>
						</tr>
							<tr>
								<th><label for="">참고사항</label></th>
								<td><textarea name="reference"  id="" title="참고사항" style="width:917px;height:41px;"></textarea></td>
							</tr>
							</tbody>
						</table>
						</fieldset>
					</div>
				<div class="clearb"></div>
				<input type="hidden" name="InvoicerContactID1" id="" value="huation" >
				<input type="hidden" name="InvoiceeContactID1" id="" value="" >
				<input type="hidden" name="TrusterContactID1" id="" value="" >
				<!-- button -->
				<div  class="Bbtn_areaC"><a href="#" class="btn_type02" onclick="javascript:registInvoice();"><span>발행</span></a><a href="#" class="btn_type02 btn_type02_gray" onclick="javascript:cancle();"><span>취소</span></a></div>
				<!-- //button -->
			</form>
		</div>
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
<%= comDao.getMenuAuth(menulist,"17") %>