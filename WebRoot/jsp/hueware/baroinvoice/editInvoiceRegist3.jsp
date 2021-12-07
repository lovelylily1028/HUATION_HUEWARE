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
	System.out.println("333333333333333:"+invoiceDto.getModifyFlag());
	String addressNo = invoiceDto.getPost()+invoiceDto.getAddress()+invoiceDto.getAddr_detail();
	String permitno1 = invoiceDto.getPermit_no();
	String number[] = permitno1.split("-");
	String permitno2 = number[0]+number[1]+number[2];
	
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
<title>���ݰ�꼭 ��ù���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">

function registInvoice(){

	
	var frm = document.baroInvoiceRegist;
	
	frm.public_no.value=frm.p_public_no.value;
	
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //�Ա�����
	
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //�Աݿ�������
	
	frm.WriteDT.value = frm.WriteDT1.value+frm.WriteDT2.value+frm.WriteDT3.value;
	
	frm.purchase.value = frm.year.value + frm.PurchaseDT1.value + frm.PurchaseDT2.value;

	if(frm.InvoiceeCorpNum.value == ""){
		alert("��Ϲ�ȣ�� �Է��ϼ���.");
		return;
	}if(frm.InvoiceeCorpName.value == ""){
		alert("��ȣ���� �Է��ϼ���.");
		return;
	}if(frm.InvoiceeCEOName.value == ""){
		alert("���޹޴����� ������ �Է��ϼ���.");
		return;
	}if(frm.InvoiceeAddr.value == ""){
		alert("���޹޴����� ����� �ּҸ� �Է��ϼ���.");
		return;
	}if(frm.InvoiceeBizType.value == ""){
		alert("���޹޴����� ���¸� �Է��ϼ���.");
		return;
	}if(frm.InvoiceeBizClass.value == ""){
		alert("���޹޴����� ������ �Է��ϼ���.");
		return;
	}
	if(frm.AmountTotal.value == ""){
		alert("���ް����� �Է��ϼ���.");
		return;
	}
	if(frm.TaxTotal.value == ""){
		alert("������ �Է��ϼ���.");
		return;
	}
	if(frm.contract_no.value == ""){
		alert("������ ��ȣ�� �����ϼ���.");
		return;
	}
	if(frm.p_public_no.value.length == 0){
		alert("������ �����ȣ�� �Է��ϼ���!");
		return;
	}
	
	if(frm.pre_deposit_dt.value.length == 0){
		alert("�Աݿ������ڸ� �����ϼ���.");
		return;
		}
	
	if(frm.pre_deposit_an.value == ""){
		alert("�Աݿ������¸� �����ϼ���.");
		return;
	}
	
	
	if(frm.deposit_dt.value.length != 0){
		if(frm.deposit_amt.value== 0){
			alert("�Ա����� �Է��ϽŰ�� �Աݱݾ��� �ʼ��� �Է��ϼž� �մϴ�.");
			return;
		}
	}

	if(frm.deposit_amt.value!= 0){
		if(frm.deposit_dt.value.length == 0){
			alert("�Աݱݾ� �Է½� �Ա����� �ʼ��� �Է��ϼž� �մϴ�.");
			return;
		}
	}
	
	
	
	
	var Y2 = frm.WriteDT1.value;
	var M2 = frm.WriteDT2.value;
	var D2 = frm.WriteDT3.value;
	
	if(Y2.length>0){
		if (!isNumber(trim(Y2))) {
			alert("�⵵�� ���ڸ� �Է��� �����մϴ�.");
				Y2=onlyNum(Y2);
			frm.WriteDT1.value ="";
			return;
			
		}else{
				Y2=onlyNum(Y2)
			} 
		}
	if(Y2.length<4){
		alert('�⵵�� 4�ڸ��� �̸����Ұ����մϴ�.');
		Y2=onlyNum(Y2);
		frm.WriteDT1.value ="";
		return;
	}else{
		Y2=onlyNum(Y2)
	}
	
	
	if(M2.length>0){
		if (!isNumber(trim(M2))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y2=onlyNum(M2);
			frm.WriteDT2.value ="";
			return;
			
		}else{
				Y2=onlyNum(M2);
				
			} 
		}
	if(M2.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� �Ͻ�=>01 �Է�).');
		M2=onlyNum(M2);
		frm.WriteDT2.value ="";
		return;
	}else{
		M2=onlyNum(M2)
	}
	if(D2.length>0){
		if (!isNumber(trim(D2))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y2=onlyNum(D2);
			frm.WriteDT3.value ="";
			return;
		
		}else{
			Y2=onlyNum(D2);	
			}
		}
	if(D2.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� =>01 �Է�).');
		D2=onlyNum(D2);
		frm.WriteDT3.value ="";
		return;
	}else{
		D2=onlyNum(D2)
	}
	if(Y2.length==0){
		alert('�⵵ �Է��ϼ���.');
		return;
	}
	if(M2.length==0){
		alert('���ڸ� �Է��ϼ���.');
		return;
	}
	if(M2 > 12){
		alert('�� �ؿ� 12�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');

		frm.WriteDT2.value ="";
		return;
	}else{
		Y2=onlyNum(M2);
	}
		
	if(D2.length==0){
		alert('���ڸ� �Է��ϼ���.');
		return;
	}
	if(D2 > 31){
		alert('�Ѵ޿� 31�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');
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
			alert("�⵵�� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(Y);
			frm.pYear5.value ="";
			return;
			
		}else{
				Y=onlyNum(Y)
			} 
		}
	if(Y.length<4){
		alert('�⵵�� 4�ڸ��� �̸����Ұ����մϴ�.');
		Y=onlyNum(Y);
		frm.pYear5.value ="";
		return;
	}else{
		Y=onlyNum(Y)
	}
	
	
	if(M.length>0){
		if (!isNumber(trim(M))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(M);
			frm.pMonth5.value ="";
			return;
			
		}else{
				Y=onlyNum(M);
				
			} 
		}
	if(M.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� �Ͻ�=>01 �Է�).');
		M=onlyNum(M);
		frm.pMonth5.value ="";
		return;
	}else{
		M=onlyNum(M)
	}
	if(D.length>0){
		if (!isNumber(trim(D))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(D);
			frm.pDay5.value ="";
			return;
		
		}else{
			Y=onlyNum(D);	
			}
		}
	if(D.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� =>01 �Է�).');
		D=onlyNum(D);
		frm.pDay5.value ="";
		return;
	}else{
		D=onlyNum(D)
	}
	if(Y.length==0){
		alert('�⵵ �Է��ϼ���.');
		return;
	}
	if(M.length==0){
		alert('���ڸ� �Է��ϼ���.');
		return;
	}
	if(M > 12){
		alert('�� �ؿ� 12�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');

		frm.pMonth5.value ="";
		return;
	}else{
		Y=onlyNum(M);
	}
		
	if(D.length==0){
		alert('���ڸ� �Է��ϼ���.');
		return;
	}
	if(D > 31){
		alert('�Ѵ޿� 31�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');
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
				alert("�⵵�� ���ڸ� �Է��� �����մϴ�.");
					Y1=onlyNum(Y1);
				frm.pYear3.value ="";
				return;
				
			}else{
					Y1=onlyNum(Y1)
				} 
			}
		if(Y1.length<4){
			alert('�⵵�� 4�ڸ��� �̸����Ұ����մϴ�.');
			Y1=onlyNum(Y1);
			frm.pYear3.value ="";
			return;
		}else{
			Y1=onlyNum(Y1)
		}
		
		
		if(M1.length>0){
			if (!isNumber(trim(M1))) {
				alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
					Y1=onlyNum(M1);
				frm.pMonth3.value ="";
				return;
				
			}else{
					Y1=onlyNum(M1);
					
				} 
			}
		if(M1.length<2){
			alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� �Ͻ�=>01 �Է�).');
			M1=onlyNum(M1);
			frm.pMonth3.value ="";
			return;
		}else{
			M1=onlyNum(M1)
		}
		if(D1.length>0){
			if (!isNumber(trim(D1))) {
				alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
					Y1=onlyNum(D1);
				frm.pDay3.value ="";
				return;
			
			}else{
				Y1=onlyNum(D1);	
				}
			}
		if(D1.length<2){
			alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� =>01 �Է�).');
			D1=onlyNum(D1);
			frm.pDay3.value ="";
			return;
		}else{
			D1=onlyNum(D1)
		}
		if(Y1.length==0){
			alert('�⵵ �Է��ϼ���.');
			return;
		}
		if(M1.length==0){
			alert('���ڸ� �Է��ϼ���.');
			return;
		}
		if(M1 > 12){
			alert('�� �ؿ� 12�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');

			frm.pMonth3.value ="";
			return;
		}else{
			Y1=onlyNum(M1);
		}
			
		if(D1.length==0){
			alert('���ڸ� �Է��ϼ���.');
			return;
		}
		if(D1 > 31){
			alert('�Ѵ޿� 31�� �̻��� ���������ʽ��ϴ�. �ٽ��Է��ϼ���!!');
			frm.pDay3.value ="";
			return;
		}else{
			Y1=onlyNum(D1);
		}
		if(frm.public_dt.value > frm.deposit_dt.value){
			alert('�Ա����ں��� �������ڰ� Ů�ϴ�.');
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


function saleCntCal(form, rowNumber){//(���߰��� �ݾװ��)
	
	
	var qtyVal = $("#"+rowNumber+" [name=Qty_view]").val();//�ش� tr�� ������ ������
	var unitCostVal = $("#"+rowNumber+" [name=UnitCost_view]").val();//�ش� tr�� �ܰ��� ������
	
	
	var oriNumber = new String(parseInt(qtyVal)*parseInt(unitCostVal));//���ڰ����� ������ ��Ʈ������ ����
	
	var oriTaxVal = new String((parseInt(qtyVal)*parseInt(unitCostVal))*0.1);//�ΰ���
	var oriTaxVal1 = new String(parseInt(oriTaxVal));//�ΰ��� �Ҽ��� ����
	
	var changeNumber = 	addCommaStr(oriNumber);//�޸� �߰�
	var changeTaxVal = addCommaStr(oriTaxVal1);//�޸��߰�

	if(changeNumber=="NaN"){//����ó��
		
	}else{
		$("#"+rowNumber+" [name=Amount_view]").val(changeNumber);
	}
	if(changeTaxVal=="NaN"){//����ó��
		
	}else{
		$("#"+rowNumber+" [name=Tax]").val(changeTaxVal);
	}
		
	var amountCnt = $('[name=Amount_view]').length;//������ ���ް����� ���������
	var amountTotal=0;//��Ż ���ް���
	
	for(var x=0; x<amountCnt; x++){//�ݺ������� �־���
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	var taxCnt1 = $('[name=Tax]').length;
	var taxTotal1=0;//��Ż �ΰ���
	for(var x=0; x<taxCnt1; x++){//�ݺ������� �־���
		
		
		
		var tax = $('[name=Tax]').eq(x).val().replace(/,/gi,"");
		
		var tax1 = parseInt(tax);
		
		taxTotal1 += tax1;	
	}
	var taxTotal2 = taxTotal1/2;
	
	var amountTotalVal = addCommaStr(new String(amountTotal)); 
	 var taxTotalVal = addCommaStr(new String(taxTotal2));
	
	
	
	 if(addCommaStr(new String(taxTotal2))=="NaN"){//����ó��
		}else{
			$('[name=TaxTotal]').val(taxTotalVal);
		}
	
	if(addCommaStr(new String(amountTotal))=="NaN"){//����ó��
	
	}else{
		$('[name=AmountTotal]').val(amountTotalVal);
	}
	var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
	var changeTotalAmount = addCommaStr(TotalAmount);
	
	if(addCommaStr(new String(TotalAmount))=="NaN"){//����ó��
		
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
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
} 

function popContractNo(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro&sForm=baroInvoiceRegist&contractGb=Y","","width=1100,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=1, status=no");
}

function popComp(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_baro&sForm=baroInvoiceRegist","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}


//ǰ�� ���߰�
var rowNumber = 2; //�� �߰� �� �Բ� ���� index �ڵ�����
var rowNumber2 = 2;
function addRow(){
	
	var addRow_tr_count = $('#template tr').size(); //�߰��� �� ���� ��������.
	if(addRow_tr_count==16){
		 alert("���̻� ���� �߰��Ҽ� �����ϴ�.");
		 return;
	 }
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\" class=\"\">";
	rowString +=	"<td colspan=\"1\" align=\"center\" class=\"in_txt1\"><input type=\"text\" name=\"PurchaseDT1\" id=\"\" class=\"in_txt2\" value=\"<%=Month%>\" style=\"width:15px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"1\" align=\"center\" class=\"in_txt1\"><input type=\"text\" name=\"PurchaseDT2\" id=\"\" class=\"in_txt2\" value=\"<%=DATE%>\" style=\"width:15px;\" maxlength=\"2\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"8\" align=\"center\" class=\"in_txt1\">"
	rowString +=	"<textarea name=\"ItemName\" id=\"\" class=\"in_txt2\" style=\"width:144px;height:24px;\" maxlength=\"100\" tabindex=\"50\"></textarea>"
	rowString +=	"</td>"
						
	rowString +=		"<input type = \"hidden\" id=\"Qty_"+rowNumber+"\"  name=\"Qty\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"UnitCost\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Amount\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
	rowString +=		"<input type = \"hidden\" name=\"Tax\" class=\"in_txt2\" style=\"width:80px\" value=\"\"/>"
						
	rowString +=	"<td colspan=\"5\" align=\"center\" class=\"in_txt1\"><textarea name=\"Spec\" id=\"\" class=\"in_txt2\" style=\"width:100px;height:24px;\" maxlength=\"60\" tabindex=\"50\"></textarea></td>"
	rowString +=	"<td colspan=\"3\" align=\"center\" class=\"in_txt1 tt2\"><input type=\"text\" name=\"Qty_view\" id=\"Qty_view\" class=\"in_txt2\" onKeyUp = \"saleCntCal('Qty','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('Qty','tr"+rowNumber+"');\"  value=\"\" style=\"width:55px;\" maxlength=\"12\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"3\" align=\"center\" class=\"in_txt1 tt3\"><input type=\"text\"  name=\"UnitCost_view\" id=\"UnitCost_view\" class=\"in_txt2\"  onKeyUp = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" onKeyDown = \"saleCntCal('UnitCost','tr"+rowNumber+"');\" value=\"\" style=\"width:55px;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"4\" align=\"center\" class=\"in_txt1 tt4\"><input type=\"text\" readOnly name=\"Amount_view\" id=\"Amount\" class=\"in_txt2\"  value=\"\" style=\"width:78px;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"4\" align=\"center\" class=\"in_txt1 tt5\" style=\"display:;\"><input type=\"text\" readOnly name=\"Tax\" id=\"\" class=\"in_txt2\" value=\"\" style=\"width:78px;\" maxlength=\"18\" tabindex=\"50\"></td>"
	rowString +=	"<td colspan=\"4\" align=\"center\" class=\"in_txt1\"><textarea name=\"Remark\" id=\"\" class=\"in_txt2\" style=\"width:78px;height:24px;\" maxlength=\"100\" tabindex=\"50\"></textarea></td>"
		rowString +="<td colspan=\"1\" class=\"in_txt1\" align=\"center\"><img src=\"<%= request.getContextPath()%>/images/btn_delete5.gif\" value=\"������\" id =\"bt\"  style=\"cursor:hand;\" onclick=\"javascript:removeRow(this,rowNumber);\"/></td>"; 
		rowString +="</tr>";
									
	$('#template').append(rowString);
	
	rowNumber = rowNumber+1;
	var amountTotal=0;//��Ż ���ް���
	
	for(var x=0; x<amountCnt; x++){//�ݺ������� �־���
		
		/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
		var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
		
		var amount1 = parseInt(amount);
		
		amountTotal = amountTotal+amount1;
		
	}
	
	
 }
 
	 
	// �� ����
	 function removeRow(obj,rowNumber){	
	  $(obj).parent().parent().remove(); //ȭ�� tbody �ȿ� tr td �����ֱ�.
	  
		
		var amountCnt = $('[name=Amount_view]').length;//������ ���ް����� ���������
		var amountTotal=0;//��Ż ���ް���
		
		for(var x=0; x<amountCnt; x++){//�ݺ������� �־���
			
			/* var amount = parseInt($('[name=Amount_view]').eq(x).val().replace(",","")); */
			var amount = $('[name=Amount_view]').eq(x).val().replace(/,/gi,"");
			
			var amount1 = parseInt(amount);
			
			amountTotal = amountTotal+amount1;
			
		}
		var taxCnt1 = $('[name=Tax]').length;
		var taxTotal1=0;//��Ż �ΰ���
		for(var x=0; x<taxCnt1; x++){//�ݺ������� �־���
			
			
			
			var tax = $('[name=Tax]').eq(x).val().replace(/,/gi,"");
			
			var tax1 = parseInt(tax);
			
			taxTotal1 += tax1;	
		}
		var taxTotal2 = taxTotal1/2;
		
		var amountTotalVal = addCommaStr(new String(amountTotal)); 
		 var taxTotalVal = addCommaStr(new String(taxTotal2));
		
		
		
		 if(addCommaStr(new String(taxTotal2))=="NaN"){//����ó��
			}else{
				$('[name=TaxTotal]').val(taxTotalVal);
			}
		
		if(addCommaStr(new String(amountTotal))=="NaN"){//����ó��
		
		}else{
			$('[name=AmountTotal]').val(amountTotalVal);
		}
		var TotalAmount = new String(parseInt(amountTotal)+parseInt(taxTotal2));
		var changeTotalAmount = addCommaStr(TotalAmount);
		
		if(addCommaStr(new String(TotalAmount))=="NaN"){//����ó��
			
		}else{
			$('[name=TotalAmount]').val(changeTotalAmount);
		}
		
		
	 
	 } 
	
	function day_check(){
		var ttt = $('[name=WriteDT3]').val();
		$('[name=PurchaseDT2]').val(ttt);
	}
	
	</script>

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
<div id="panel_content">
<!-- calendar -->
  <div id="CalendarLayer" style="display:none; width:172px; height:176px; ">
    <iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
  </div>
	<form name="baroInvoiceRegist" method="post"   action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroRegist" >
	<input type="hidden" name="LMT" id="" value="0" >
	<input type="hidden" name="LMF" id="" value="3" >
	<input type="hidden" name="LMC" id="" value="1" >
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


	<div id="panel_taxtype"><input type="hidden" name="TaxCalcType" id="" value="2" >
<!-- <div class="taxtype">
	<img src="http://image.barobill.co.kr/barobill_testbed/invoice/taxtype_title1.gif" class="title1">
	<div class="taxtype_radio">
		<input type="radio" name="TaxType" id="TaxType1" class="rb" value="1" checked onclick="changeTaxType(1);"><label class="for" for="TaxType1">����(10%)</label>&nbsp;&nbsp;
		
	</div>
	
	<img src="http://image.barobill.co.kr/barobill_testbed/invoice/taxtype_title2.gif" class="title2">
	<div class="invoiceetype_radio">
		<input type="radio" name="InvoiceeType" id="InvoiceeType1" class="rb" value="1" checked onclick="changeInvoiceeType(1);"><label class="for" for="InvoiceeType1">�����</label>&nbsp;&nbsp;
		<input type="radio" name="InvoiceeType" id="InvoiceeType2" class="rb" value="2"  onclick="changeInvoiceeType(2);"><label class="for" for="InvoiceeType2">����</label>&nbsp;&nbsp;
		<input type="radio" name="InvoiceeType" id="InvoiceeType3" class="rb" value="3"  onclick="changeInvoiceeType(3);"><label class="for" for="InvoiceeType3">�ܱ���</label>
	</div>
	
</div> -->
</div>

	<div id="panel_form"><div id="panel_InvoiceForm" class="clearb formborder_red">

	<table bgcolor="#EAEAEA" summary="(����)��꼭"  border = "1">
		<colgroup>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
			<col width="2.94117647058824%"></col>
			
		</colgroup>
		<thead>
		<tr>
			<th colspan="16" rowspan="2" class="in_txt1"><span class="f24 b ls0" id="FormTitleName">���ڼ��ݰ�꼭</span></th>
			<th colspan="4" rowspan="2" class="in_txt1">�� �� ��<br>(�� �� ��)</th>
			<td colspan="2" rowspan="2" class="in_txt1">&nbsp;</td>
			<th colspan="4" class="in_txt1">å��ȣ : </th>
			<td colspan="3" class="in_txt1"><input type="text" name="Kwon" id="" class="in_txt2 " value="" style="width:61px;" maxlength="4" tabindex="1"></td>
			<td colspan="1" class="in_txt1">��</td>
			<td colspan="3" class="in_txt1"><input type="text" name="Ho" id="" class="in_txt2 " value="" style="width:61px;" maxlength="4" tabindex="2"></td>
			<td colspan="1" class="in_txt1">ȣ</td>
		</tr>
		<tr>
			<th colspan="4" class="in_txt1">�Ϸù�ȣ : </th>
			<td colspan="8"><input type="text" name="SerialNum" id="" class="in_txt2 " value="" style="width:169px;" maxlength="27" tabindex="3"></td>
		</tr>
		</thead>
		<tbody>
		<tr>
			<th colspan="1" rowspan="6" class="in_txt1"><span class="b lh30">��<br>��<br>��</span></th>
			<th colspan="3" class="in_txt1">��Ϲ�ȣ </th>
			<td colspan="8" class="in_txt1"><input type="text" readOnly name="InvoicerCorpNum" id="" class="in_txt_off" value="108-81-93762" style="width:169px;" maxlength="10" readonly tabindex="4"></td>
			<th colspan="3" class="in_txt1">�������</th>
			<td colspan="2" class="in_txt1"><input type="text" name="InvoicerTaxRegID" id="" class="in_txt2" value="" style="width:33px;" maxlength="4" tabindex="5"></td>
			<th colspan="1" rowspan="6" class="in_txt1"><span class="b lh16">��<br>��<br>��<br>��<br>��</span></th>
			<th colspan="3" class="in_txt1">��Ϲ�ȣ *</th>
			<td colspan="8" class="in_txt1"><input type="text"  name="InvoiceeCorpNum"onClick="javascript:popComp();" id="" class="in_txt2" value="<%=permitno2%>" style="width:127px;" maxlength="14" tabindex="14">&nbsp;
			<a href="#" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_comp.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_comp_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_comp.gif'" value="��ü��ȸ" onclick="javascript:popComp();" width="60" height="18" title="��ü��ȸ" /></a></td>
			<th colspan="3" class="in_txt1">�������</th>
			<td colspan="2" class="in_txt1"><input type="text" name="InvoiceeTaxRegID" id="" class="in_txt2" value="" style="width:32px;" maxlength="4" tabindex="15"></td>
		</tr>
		<tr>
			<th colspan="3" class="in_txt1">��ȣ</th>
			<td colspan="8" class="in_txt1"><textarea name="InvoicerCorpName" id="" class="in_txt2" style="width:169px;height:24px;" maxlength="70" tabindex="6">�ֽ�ȸ�� �޿��̼�</textarea></td>
			<th colspan="1" class="in_txt1">����</th>
			<td colspan="4" class="in_txt1"><textarea name="InvoicerCEOName" id="" class="in_txt2" style="width:79px;height:24px;" maxlength="30" tabindex="7">���ع�</textarea></td>
			<th colspan="3" class="in_txt1">��ȣ *</th>
			<td colspan="8" class="in_txt1"><textarea name="InvoiceeCorpName" id="" class="in_txt2" style="width:170px;height:24px;" maxlength="70" tabindex="16"><%=invoiceDto.getComp_nm() %></textarea></td>
			<th colspan="3" class="in_txt1">���� *</th>
			<td colspan="4" class="in_txt1"><textarea name="InvoiceeCEOName" id="" class="in_txt2" style="width:78px;height:24px;" maxlength="30" tabindex="17"><%=invoiceDto.getOwner_nm() %></textarea></td>
		</tr>
		<tr>
			<th colspan="3" class="in_txt1">������ּ�</th>
			<td colspan="13" class="in_txt1"><textarea name="InvoicerAddr" id="" class="in_txt2" style="width:380px;height:50px;" maxlength="150" tabindex="8">����Ư���� ��õ�� �����з�9�� 32(���굿,�����׷���Ʈ�븮B�� 602ȣ)</textarea></td>
			<th colspan="3" class="in_txt1">������ּ� * </th>
			<td colspan="13" class="in_txt1"><textarea name="InvoiceeAddr" id="" class="in_txt2" style="width:380px;height:50px;" maxlength="150" tabindex="18"><%=addressNo%></textarea></td>
		</tr>
		<tr>
			<th colspan="3" class="in_txt1">����</th>
			<td colspan="6" class="in_txt1"><textarea name="InvoicerBizType" id="" class="in_txt2" style="width:150px;height:24px;" maxlength="40" tabindex="9">����,���Ҹ�</textarea></td>
			<th colspan="2" class="in_txt1">����</th>
			<td colspan="5" class="in_txt1"><textarea name="InvoicerBizClass" id="" class="in_txt2" style="width:150px;height:24px;" maxlength="40" tabindex="10">����Ʈ����߿�,��ǻ�� �� �ֺ���ġ,��� ���Ǹž�</textarea></td>
			<th colspan="3" class="in_txt1">���� *</th>
			<td colspan="6" class="in_txt1"><textarea name="InvoiceeBizType" id="" class="in_txt2" style="width:150px;height:24px;" maxlength="40" tabindex="19"><%=invoiceDto.getBusiness() %></textarea></td>
			<th colspan="2" class="in_txt1">���� *</th>
			<td colspan="5" class="in_txt1"><textarea name="InvoiceeBizClass" id="" class="in_txt2" style="width:150px;height:24px;" maxlength="40" tabindex="20"><%=invoiceDto.getB_item() %></textarea></td>
		</tr>
		<tr>
			<th colspan="3" class="in_txt1">�����</th>
			<td colspan="6" class="in_txt1"><input type="text" name="InvoicerContactName1" id="" class="in_txt2" value="���ȭ" style="width:124px;" maxlength="30" tabindex="11"></td>
			<th colspan="2" class="in_txt1">����ó</th>
			<td colspan="5" class="in_txt1"><input type="text" name="InvoicerTEL1" id="" class="in_txt2 " value="02-2081-6713" style="width:100px;" maxlength="20" tabindex="12"></td>
			<th colspan="3" class="in_txt1">�����</th>
			<td colspan="6" class="in_txt1"><input type="text" name="InvoiceeContactName1" id="" class="in_txt2" value="<%=invoiceDto.getReceiver()%>" style="width:124px;" maxlength="30" tabindex="21"></td>
			<th colspan="2" class="in_txt1">����ó</th>
			<td colspan="5" class="in_txt1"><input type="text" name="InvoiceeTEL1"  onkeyup="javascript:format_phone(this);" id="" class="in_txt2" value="<%=invoiceDto.getTELL()%>"  style="width:100px;" maxlength="14" tabindex="22"></td>
		</tr>
		<tr>
			<th colspan="3" class="in_txt1">�̸���</th>
			<td colspan="13" class="in_txt1"><input type="text" name="InvoicerEmail1" id="" class="in_txt2" value="khkim@huation.com" style="width:283px;" maxlength="40" tabindex="13"></td>
			<th colspan="3" class="in_txt1">�̸���</th>
			<td colspan="13" class="in_txt1"><input type="text" name="InvoiceeEmail1" id="" class="in_txt2" value="<%=invoiceDto.getE_MAIL()%>" style="width:283px;" maxlength="40" tabindex="23"></td>
		
		</tr>
		<tr>
			<td colspan="34" class="in_txt1 splitline">&nbsp;</td>
		</tr>
		</tbody>
		
		<tbody>
		<tr>
			<th colspan="6" class="in_txt1"><span class="b">�ۼ�</span>&nbsp;</th>
			<th colspan="16" class="in_txt1 tt0"><span class="b">���ް���</span></th>
			<th colspan="14" class="in_txt1 tt1" style="display:;"><span class="b">����</span></th>
		</tr>
		<tr>
			<td colspan="6" align="center" class="in_txt1">
			<input type = "hidden" name="WriteDT" id = "WriteDT"/>
			<input type="text" name="WriteDT1" maxlength="4" id="" class="in_txt2" IconYN="0" value="<%=Integer.toString(cal.get(Calendar.YEAR))%>" style="width:30px;" maxlength="10" tabindex="25">��
			<input type="text" name="WriteDT2" maxlength="2" class="in_txt2" value="<%=df.format(cal.get(Calendar.MONTH)+1) %>" style="width:20px;"/>��
			<input type="text" name="WriteDT3" maxlength="2" class="in_txt2" value="<%=df.format(cal.get(Calendar.DATE))%>" onkeyup="javascript:day_check();" style="width:20px;"/>��
			</td>
			
			<td colspan="16" align="center" class="in_txt1 tt0"><input type="text" name="AmountTotal"  id="" class="in_txt1" value="" style="width:351px;"  maxlength="18" ></td>
			<td colspan="14" align="center" class="in_txt1 tt1" style="display:;"><input type="text"  name="TaxTotal" id="" class="in_txt1" value="" style="width:306px;"  maxlength="18" ></td>
		</tr>
		<tr> 
			<td colspan="34" class="in_txt1 splitline">&nbsp;</td>
		</tr>
		</tbody>
		<tbody>
		<tr>
			<th  colspan="4" class="in_txt1"><span class="b">���1</span></th>
			<td colspan="29" class="in_txt1"><input type="text" name="Remark1" id="" class="in_txt2" value="" style="width:648px;" maxlength="150" tabindex="26"></td>
			<td class="in_txt1"></td>
		</tr>
		<tr>
			<td colspan="34" class="in_txt2">&nbsp;</td>
		</tr>
		</tbody>
		<tbody>
		<input type="hidden" name="row_cnt">
		<!-- <input type="checkbox" name="all_chk" onClick="checkExcute(this)"> -->
		<tr>
			<th colspan="4" class="in_txt1"><span class="b">�ۼ����</span></th>
			<td colspan="30" class="in_txt2">
				<span class="WT"><input type="radio" name="WriteType" id="WriteType4" class="in_txt2" value="4" checked onclick="changeWriteType(4);"><label class="for" for="WriteType4">�����Է�</label></span>
				
			</td>
		</tr>
		<tr>
			<td colspan="34" class="in_txt2">&nbsp;</td>
		</tr>
		</tbody>
		
		
		<tr>
			<th colspan="1" class="in_txt1"><span class="b">��</span><input type="hidden" name="DetailJSON" id="" value="" ></th>
			<th colspan="1" class="in_txt1"><span class="b">��</span></th>
			<th colspan="8" class="in_txt1"><span class="b">ǰ��</span></th>
			<th colspan="5" class="in_txt1"><span class="b">�԰�</span></th>
			<th colspan="3" class="in_txt1 tt2"><span class="b">����</span></th>
			<th colspan="3" class="in_txt1 tt3"><span class="b">�ܰ�</span></th>
			<th colspan="4" class="in_txt1 tt4"><span class="b">���ް���</span></th>
			<th colspan="4" class="in_txt1 tt5" style="display:;"><span class="b">����</span></th>
			<th colspan="4" class="in_txt1"><span class="b">���</span></th>
			<th colspan="1" class="in_txt1">
			<img src="<%= request.getContextPath()%>/images/btn_plus.gif" value="���߰�" id ="bt"  style="cursor:hand;" onclick="javascript:addRow();"/></th>
		</tr>
		
		<tbody id="template">
		<tr id="tr1" class="">
			<td colspan="1" align="center" class="in_txt1"><input type="text" name="PurchaseDT1" id="" class="in_txt2" value="<%=Month%>" style="width:15px;" maxlength="2" tabindex="50"></td>
			<td colspan="1" align="center" class="in_txt1"><input type="text" name="PurchaseDT2" id="" class="in_txt2" value="<%=DATE%>" style="width:15px;" maxlength="2" tabindex="50"></td>
			<td colspan="8" align="center" class="in_txt1">
				<textarea name="ItemName" id="" class="in_txt2" style="width:144px;height:24px;" maxlength="100" tabindex="50"></textarea>
				
			</td>
			
			<input type = "hidden" name="Qty" class="in_txt2" style="width:80px" value=""/>
			<input type = "hidden" name="UnitCost" class="in_txt2" style="width:80px" value=""/>
			<input type = "hidden" name="Amount" class="in_txt2" style="width:80px" value=""/>
			<input type = "hidden" name="Tax" class="in_txt2" style="width:80px" value=""/>
			
			<td colspan="5" align="center" class="in_txt1"><textarea name="Spec" id="" class="in_txt2" style="width:100px;height:24px;" maxlength="60" tabindex="50"></textarea></td>
			<td colspan="3" align="center" class="in_txt1 tt2"><input type="text" name="Qty_view" id="Qty_view" class="in_txt2" onKeyUp = "saleCntCal('Qty','tr1');"  value="" style="width:55px;" maxlength="4" tabindex="50"></td>
			<td colspan="3" align="center" class="in_txt1 tt3"><input type="text" name="UnitCost_view" id="UnitCost_view" class="in_txt2"  onKeyUp = "saleCntCal('UnitCost','tr1');" value="" style="width:55px;" maxlength="18" tabindex="50"></td>
			<td colspan="4" align="center" class="in_txt1 tt4"><input type="text" readOnly name="Amount_view" id="Amount" class="in_txt2"  value="" style="width:78px;" maxlength="18" tabindex="50"></td>
			<td colspan="4" align="center" class="in_txt1 tt5" style="display:;"><input type="text" readOnly name="Tax" id="" class="in_txt2" value="" style="width:78px;" maxlength="18" tabindex="50"></td>
			<td colspan="4" align="center" class="in_txt1"><textarea name="Remark" id="" class="in_txt2" style="width:78px;height:24px;" maxlength="100" tabindex="50"></textarea></td>
			<td colspan="1" align="center" class="in_txt1"></td>
		</tr>
		</tbody>
		<tbody>
		<tr>
			<td colspan="34" class="in_txt1 splitline">&nbsp;</td>
		</tr>
		<tr>
			<th colspan="9" class="in_txt1"><span class="b">�հ�ݾ�</span></th>
			<th colspan="4" class="in_txt1">����</th>
			<th colspan="4" class="in_txt1">��ǥ</th>
			<th colspan="4" class="in_txt1">����</th>
			<th colspan="4" class="in_txt1">�ܻ�̼���</th>
			<td colspan="9" rowspan="2" class="in_txt1">
				<div class="PT1">�� �ݾ���</div>
				<div class="PT2" align="center">
					<span class="PT"><input type="radio" name="PurposeType" id="PurposeType2" class="in_txt2" value="2" checked ><label class="for" for="PurposeType2">û��</label></span>
				��
				</div>
				
			</td>
		</tr>
		<tr>
			<td colspan="9" align="center" class="in_txt1"><input type="text" name="TotalAmount" readOnly  id="" class="in_txt_off"  value="" style="width:194px;"  maxlength="18"></td>
			<td colspan="4" align="center" class="in_txt1"><input type="text" name="Cash" id="" class="in_txt_off" value="" style="width:78px;" maxlength="18" tabindex="51"></td>
			<td colspan="4" align="center" class="in_txt1"><input type="text" name="ChkBill" id="" class="in_txt_off" value="" style="width:78px;" maxlength="18" tabindex="52"></td>
			<td colspan="4" align="center" class="in_txt1"><input type="text" name="Note" id="" class="in_txt_off" value="" style="width:78px;" maxlength="18" tabindex="53"></td>
			<td colspan="4" align="center" class="in_txt1"><input type="text" name="Credit" id="" class="in_txt_off" value="" style="width:78px;" maxlength="18" tabindex="54"></td>
		</tr>
		</tbody>
	</table>

</div>

<div class="clearb"></div>
<input type="hidden" name="InvoicerContactID1" id="" value="huation" ><input type="hidden" name="InvoiceeContactID1" id="" value="" ><input type="hidden" name="TrusterContactID1" id="" value="" ></div>

	
	<div id="panel_button">
		<center>
			
			<a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg2.gif" value="����" onclick="javascript:registInvoice();"  width="73" height="28" alt="����" /></a>
			<a href="#"><img src="<%=request.getContextPath()%>/images/btn_cancel2.gif" onclick="javascript:cancle();" width="73" height="28" alt="���" title="���" /></a>
			
		</center>
	</div>
	
	</form>
	

	<!-- </form> -->

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