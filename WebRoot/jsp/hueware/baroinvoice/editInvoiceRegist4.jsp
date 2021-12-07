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
<title>���ݰ�꼭 ��ù���</title>
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
		/* frm2.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //�Ա�����
		frm2.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //�Աݿ�������
		
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
function saleCntCal(form){

    var v_obj;
	var obj;
	var veiwfrm=eval("document."+form+"_view");
	var frm=eval("document."+form);
	var costobj=document.baroInvoiceRegist;

	if(frm.length>1){
		v_obj=veiwfrm[index];
		obj=frm[index];
	}else{
		v_obj=veiwfrm;
		obj=frm;
	}

	if (!isNumber(trim(v_obj.value))) {
		alert("���ڸ� �Է��� �ּ���.");
	} 

	var num=onlyNum(v_obj.value);
	v_obj.value = addCommaStr(num);
	obj.value = num;

	if(form=='baroInvoiceRegist.Q'){	
		var vat=parseInt(onlyNum(costobj.supply_price.value)*0.1,10);
		costobj.vat_view.value=addCommaStr(''+vat);
	    costobj.vat.value=vat;
	    
	    
	}

	var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);

	costobj.total_amt_view.value=addCommaStr(''+tcost);
	costobj.total_amt.value=tcost;

	v_obj.focus();

}


function addRow2(){
	var rowString = "";
	rowString += "<tr>";
	rowString += "<td colspan=\"1\" class=\"a_c\"><input type=\"text\" name=\"PurchaseDT1\" id=\"\" class=\"tb a_c detailinput\" value= \"<%=Month%>\" style=\"width:15px;\" maxlength=\"2\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"1\" class=\"a_c\"><input type=\"text\" name=\"PurchaseDT2\" id=\"\" class=\"tb a_c detailinput\" value=\"<%=DATE%>\" style=\"width:15px;\" maxlength=\"2\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"8\" class=\"a_c\">";
	rowString += "<textarea name=\"ItemName\" id=\"\" class=\"ta scroll \" style=\"width:144px;height:24px;\" maxlength=\"100\" tabindex=\"50\"></textarea>";
	rowString +="</td>";
	rowString +="<input type = \"hidden\" name=\"Qty_cal\" class=\"tb a_r detailinput\" style=\"width:80px\" value=\"0\"/>";
	rowString +="<input type = \"hidden\" name=\"UnitCost_cal\" class=\"tb a_r detailinput\" style=\"width:80px\" value=\"0\"/>";
	rowString +="<input type = \"hidden\" name=\"Amount_cal\" class=\"tb a_r detailinput\" style=\"width:80px\" value=\"0\"/>";
	rowString +="<td colspan=\"5\" class=\"a_c\"><textarea name=\"Spec\" id=\"\" class=\"ta scroll \" style=\"width:100px;height:24px;\" maxlength=\"60\" tabindex=\"50\"></textarea></td>";
	rowString +="<td colspan=\"3\" class=\"a_c tt2\"><input type=\"text\" name=\"Qty\" id=\"\" class=\"tb a_r detailinput\" onKeyUp = \"saleCntCal('baroInvoiceRegist.Qty_cal')\"  value=\"\" style=\"width:55px;\" maxlength=\"12\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"3\" class=\"a_c tt3\"><input type=\"text\" name=\"UnitCost\" id=\"\" class=\"tb a_r detailinput\" onKeyUp = \"saleCntCal('baroInvoiceRegist.UnitCost_cal')\" value=\"\" style=\"width:55px;\" maxlength=\"18\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"4\" class=\"a_c tt4\"><input type=\"text\" name=\"Amount\" id=\"\" class=\"tb a_r detailinput\" onKeyUp = \"saleCntCal('baroInvoiceRegist.Amount_cal')\" value=\"\" style=\"width:78px;\" maxlength=\"18\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"4\" class=\"a_c tt5\" style=\"display:;\"><input type=\"text\" name=\"Tax\" id=\"\" class=\"tb a_r detailinput\" value=\"\" style=\"width:78px;\" maxlength=\"18\" tabindex=\"50\"></td>";
	rowString += "<td colspan=\"4\" class=\"a_c\"><textarea name=\"Remark\" id=\"\" class=\"ta scroll \" style=\"width:78px;height:24px;\" maxlength=\"100\" tabindex=\"50\"></textarea></td>";
	rowString +="<td colspan=\"1\" class=\"a_c\"><input type=\"button\" value=\"������\" id =\"bt\"  style=\"cursor:hand;\" onclick=\"javascript:removeRow(this);\"/></td>"; 
	rowString +="</tr>";
									
	$('#template2').append(rowString);
	
	
	
}
	 
	// �� ����
	 function removeRow(obj){
		
	  $(obj).parent().parent().remove();

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
				<h2>���ݰ�꼭 ���</h2>
			</div>
			<!-- //title -->
			<!-- con -->
			<div class="con">
				<div id="panel_content">
					<!-- title -->
					<p class="title_sub"><img src="<%= request.getContextPath()%>/images/p_baroInvoice.gif" alt="����û ���ݰ�꼭 ����" /></p>
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
						<input type = "hidden" name = "publicorg1" value="�ٷκ�">
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
								<p class="title_sub2">- �� ���ݰ�꼭�� ���� �߱��� ���ݰ�꼭 ��Һ��Դϴ�.</p>
								<table cellspacing="0" border="1" summary="���ڼ��ݰ�꼭" class="tbl_type3">
									<caption>���ڼ��ݰ�꼭</caption>
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
									<!-- ie7�� ���� ���±�(������ ������) -->
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
									<!-- //ie7�� ���� ���±�(������ ������) -->
									<tr class="hd_bg">
										<th colspan="10" rowspan="2" class="hd_bdR"><span id="FormTitleName">���ڼ��ݰ�꼭 ��ҹ���</span><br><br>(����� ����)</th>
										<th colspan="2" rowspan="2">������<br>(������)</th>
										<th colspan="2">å��ȣ</th>
										<td colspan="4">
											<input type="text" name="Kwon" id="" class="in_txt_off"  readOnly value="" style="width:33%;" maxlength="4" tabindex="1">��&nbsp;
											<input type="text" name="Ho" id="" class="in_txt_off"  readOnly value="" style="width:33%;" maxlength="4" tabindex="2">ȣ
										</td>
										</tr>
										<tr class="hd_bg">
											<th colspan="2">�Ϸù�ȣ</th>
											<td colspan="4"><input type="text" name="SerialNum" readOnly id="" class="in_txt_off"  value="" style="width:95%;*width:94%;" maxlength="27" tabindex="3"></td>
										</tr>
										<tr>
											<th rowspan="6">������</th>
											<th colspan="2">��Ϲ�ȣ</th>
											<td colspan="3"><input type="text"  name="InvoicerCorpNum1" id="" class="in_txt_off" readOnly value="108-81-93762" style="width:96.5%;*width:95.5%;" maxlength="10" readonly tabindex="4"></td>
											<th colspan="2">�������</th>
											<td><input type="text" name="InvoicerTaxRegID1" id="" class="in_txt_off" readOnly value="" style="width:85%;*width:84%;" maxlength="4" tabindex="5"></td>
											<th rowspan="6">���޹޴���</th>
											<th>��Ϲ�ȣ</th>
											<td colspan="3"><input type="text"  name="InvoiceeCorpNum1"onClick="javascript:popComp();" id="" class="in_txt_off" readOnly value="<%=permitno2%>" style="width:69.1%;*width:68.1%;" maxlength="14" tabindex="14"><a href="#" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_comp.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_comp_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_comp.gif'" value="��ü��ȸ" onclick="javascript:popComp();" title="��ü��ȸ" /></a></td>
											<th colspan="2">�������</th>
											<td colspan="2"><input type="text" name="InvoiceeTaxRegID1" id="" class="in_txt_off" readOnly value="" style="width:85%;*width:84%;" maxlength="4" tabindex="15"></td>
										</tr>
										<tr>
											<th colspan="2">��ȣ</th>
											<td colspan="3"><textarea name="InvoicerCorpName1" id="" class="in_txt_off" readOnly style="width:96.5%;*width:95.5%;" maxlength="70" tabindex="6">�ֽ�ȸ�� �޿��̼�</textarea></td>
											<th>����</th>
											<td colspan="2"><textarea name="InvoicerCEOName1" id="" class="in_txt_off" readOnly style="width:91%;*width:89%;" maxlength="30" tabindex="7">���ع�</textarea></td>
											<th>��ȣ *</th>
											<td colspan="3"><textarea name="InvoiceeCorpName1" id="" class="in_txt_off" readOnly style="width:96.5%;*width:95.5%;" maxlength="70" tabindex="16"><%=invoiceDto.getComp_nm() %></textarea></td>
											<th>���� *</th>
											<td colspan="3"><textarea name="InvoiceeCEOName1" id="" class="in_txt_off" readOnly style="width:91.5%;*width:89.5%;" maxlength="30" tabindex="17"><%=invoiceDto.getOwner_nm() %></textarea></td>
										</tr>
										<tr>
											<th colspan="2">������ּ�</th>
											<td colspan="6"><textarea name="InvoicerAddr1" id="" class="in_txt_off" readOnly style="width:98%;height:50px;*width:97%;" maxlength="150" tabindex="8">����Ư���� ��õ�� �����з�9�� 32(���굿,�����׷���Ʈ�븮B�� 602ȣ)</textarea></td>
											<th>������ּ� *</th>
											<td colspan="7"><textarea name="InvoiceeAddr1" id="" class="in_txt_off" readOnly style="width:98%;height:50px;*width:97%;" maxlength="150" tabindex="18"><%=addressNo%></textarea></td>
										</tr>
										<tr>
											<th colspan="2">����</th>
											<td colspan="2"><textarea name="InvoicerBizType1" id="" class="in_txt_off" readOnly style="width:95%;*width:94%;" maxlength="40" tabindex="9">����,���Ҹ�</textarea></td>
											<th>����</th>
											<td colspan="3"><textarea name="InvoicerBizClass1" id="" class="in_txt_off" readOnly style="width:94%;*width:93%;" maxlength="40" tabindex="10">����Ʈ����߿�,��ǻ�� �� �ֺ���ġ,��� ���Ǹž�</textarea></td>
											<th>����</th>
											<td colspan="2"><textarea name="InvoiceeBizType1" id="" class="in_txt_off" readOnly style="width:95%;*width:94%;" maxlength="40" tabindex="19"><%=invoiceDto.getBusiness() %></textarea></td>
											<th>����</th>
											<td colspan="4"><textarea name="InvoiceeBizClass1" id="" class="in_txt_off" readOnly style="width:95%;*width:93%;" maxlength="40" tabindex="20"><%=invoiceDto.getB_item() %></textarea></td>
										</tr>
										<tr>
											<th colspan="2">�����</th>
											<td colspan="2"><input type="text" name="InvoicerContactName11" id="" class="in_txt_off" readOnly value="���ȭ" style="width:95%;*width:94%;" maxlength="30" tabindex="11"></td>
											<th>����ó</th>
											<td colspan="3"><input type="text" name="InvoicerTEL11" id="" class="in_txt_off" readOnly value="02-2081-6713" style="width:94%;*width:93%;" maxlength="20" tabindex="12"></td>
											<th>�����</th>
											<td colspan="2"><input type="text" name="InvoiceeContactName11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getReceiver()%>" style="width:95%;*width:94%;" maxlength="30" tabindex="21"></td>
											<th >����ó</th>
											<td colspan="4"><input type="text" name="InvoiceeTEL11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getTELL()%>" style="width:95%;*width:93%;" maxlength="20" tabindex="22"></td>
										</tr>
										<tr>
											<th colspan="2">�̸���</th>
											<td colspan="6"><input type="text" name="InvoicerEmail11" id="" class="in_txt_off" readOnly value="khkim@huation.com" style="width:98%;*width:97%;" maxlength="40" tabindex="13"></td>
											<th>�̸���</th>
											<td colspan="7"><input type="text" name="InvoiceeEmail11" id="" class="in_txt_off" readOnly value="<%=invoiceDto.getE_MAIL()%>" style="width:98%;" maxlength="40" tabindex="23"></td>
										</tr>
										<tr>
											<th colspan="3">�ۼ�</th>
											<th colspan="8">���ް���</th>
											<th colspan="7">����</th>
										</tr>
										<tr>
											<td colspan="3">
												<input type="text" name="WriteDT1" maxlength="4" id="" class="in_txt_off" readOnly IconYN="0" value="<%=Today%>" style="width:93%;" maxlength="10" tabindex="25">
												
											</td>
											<td colspan="8"><input type="text" name="AmountTotal1"  id="" class="in_txt_off" readOnly value="-<%=Supply%>" style="width:98.5%;" maxlength="18" ></td>
											<td colspan="7"><input type="text"  name="TaxTotal1" id="" class="in_txt_off" readOnly value="-<%=vat%>" style="width:98%;" maxlength="18" ></td>
										</tr>
										<tr>
											<th colspan="3">���1</th>
											<td colspan="14"><input type="text" name="Remark11" id="" class="in_txt_off" readOnly value="���ʼ��ݰ�꼭 �ۼ���(<%=invoiceDto.getPublic_dt()%>),���� ���ι�ȣ (<%=invoiceDto.getApprove_no()%>)" style="width:99.1%;*width:99%;" maxlength="150" tabindex="26"></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th colspan="3">�ۼ����</th>
											<td colspan="15">
												<input type="radio" name="WriteType1" id="WriteType4" value="4" checked onclick="changeWriteType(4);"><label class="for" for="WriteType4"> �����Է�</label>
											</td>
										</tr>
										<tr>
											<th>��<input type="hidden" name="DetailJSON" id="" value="" ></th>
											<th>��</th>
											<th colspan="3">ǰ��</th>
											<th colspan="3">�԰�</th>
											<th colspan="2">����</th>
											<th>�ܰ�</th>
											<th>���ް���</th>
											<th colspan="2">����</th>
											<th colspan="3">���</th>
											<th>&nbsp;</th>
										</tr>
										</tbody>
										<tbody id="template1">
										<%while(ds.next()){%>
										<tr id="tr1">
											<td><input type="text" name="PurchaseDT11" id="" class="in_txt_off" readOnly value="<%=Month%>" style="width:12px;" maxlength="2" tabindex="50"></td>
											<td><input type="text" name="PurchaseDT21" id="" class="in_txt_off" readOnly value="<%=DATE%>" style="width:12px;" maxlength="2" tabindex="50"></td>
											<td colspan="3"><textarea name="ItemName1" id="" class="in_txt_off" readOnly style="width:96.5%;*width:95.5%;" maxlength="100" tabindex="50"><%=ds.getString("ITEM_NAME")%></textarea></td>
											
											<td colspan="3"><textarea name="Spec1" id="" class="in_txt_off" readOnly style="width:94.5%;*width:93.5%;" maxlength="60" tabindex="50"><%=ds.getString("SPEC")%></textarea></td>
											<td colspan="2"><input type="text" name="Qty1" id="Qty_view" class="in_txt_off" readOnly onKeyUp = "saleCntCal('Qty','tr1');"  value="-<%=ds.getString("QTY")%>" style="width:91%;*width:90%;" maxlength="4" tabindex="50"></td>
											<td><input type="text" name="UnitCost1" id="UnitCost_view1" class="in_txt_off" readOnly onKeyUp = "saleCntCal('UnitCost','tr1');" value="<%=ds.getString("UNIT_COSE")%>" style="width:90.5%;*width:89.5%;" maxlength="18" tabindex="50"></td>
											<td><input type="text" readOnly name="Amount1" id="Amount" class="in_txt_off" readOnly value="-<%=ds.getString("AMOUNT")%>" style="width:92%;*width:91%;" maxlength="18" tabindex="50"></td>
											<td colspan="2"><input type="text" readOnly name="Tax1" id="" class="in_txt_off" readOnly value="-<%=ds.getString("TAX")%>" style="width:93%;*width:92%;" maxlength="18" tabindex="50"></td>
											<td colspan="3"><textarea name="Remark1" id="" class="in_txt_off" readOnly style="width:93%;*width:91%;" maxlength="100" tabindex="50"><%=ds.getString("ETC")%></textarea></td>
											<td>&nbsp;</td>
										</tr>
										<%
										}
										%>
										</tbody>
										<tbody>
										<tr>
											<th colspan="4">�հ�ݾ�</th>
											<th colspan="3">����</th>
											<th colspan="2">��ǥ</th>
											<th colspan="2">����</th>
											<th>�ܻ�̼���</th>
											<td colspan="6" rowspan="2" class="claim">�� �ݾ���&nbsp;&nbsp;&nbsp;<input type="radio" name="PurposeType" id="PurposeType2" value="2" checked ><label class="for" for="PurposeType2"> û����</label></td>
										</tr>
										<tr>
											<td colspan="4"><input type="text" name="TotalAmount1" readOnly  id="" class="in_txt_off" value="-<%=Supply+vat%>" style="width:97%;*width:96%;"  maxlength="18"></td>
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
	<div id="panel_button">
		<center>
			
			<a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg2.gif" value="����" onclick="javascript:registInvoice();"  width="73" height="28" alt="����" /></a>
			<a href="#"><img src="<%=request.getContextPath()%>/images/btn_cancel2.gif" onclick="javascript:cancle();" width="73" height="28" alt="���" title="���" /></a>
			
		</center>
	</div>
	
	

	

</div>
</div>
</div>
<!-- //container -->
</div>
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>

</html>

<%= comDao.getMenuAuth(menulist,"14") %>