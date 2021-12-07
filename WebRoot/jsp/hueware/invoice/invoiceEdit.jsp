<%@page import="com.huation.common.estimate.EstimateDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");

	InvoiceDTO invoiceDto = (InvoiceDTO)model.get("invoiceDto");
	EstimateDTO esDto = new EstimateDTO();
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
	//������ �ʱ� ���� ��.
		String public_dt = "";

		
		if(invoiceDto.getPublic_dt().equals("")){
			public_dt = invoiceDto.getPublic_dt();
			public_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			public_dt = invoiceDto.getPublic_dt();
			String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = public_dt.substring(0,4);
		    strM_Val1 = public_dt.substring(4,6);
		    strD_Val1 = public_dt.substring(6,8);
			
		    public_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
		}
		
		//�Աݿ����� �ʱ� ���� ��.
		String pre_deposit_dt = "";
		
		if(invoiceDto.getPre_deposit_dt().equals("")){
			pre_deposit_dt = invoiceDto.getPre_deposit_dt();
			pre_deposit_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			pre_deposit_dt = invoiceDto.getPre_deposit_dt();
			String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = pre_deposit_dt.substring(0,4);
		    strM_Val1 = pre_deposit_dt.substring(4,6);
		    strD_Val1 = pre_deposit_dt.substring(6,8);
			
		    pre_deposit_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
		}
		
		
		//�Ա��� �ʱ� ���� ��.
				String deposit_dt = "";
				
				if(invoiceDto.getDeposit_dt().equals("")){
					deposit_dt = invoiceDto.getDeposit_dt();
				}else{
					deposit_dt = invoiceDto.getDeposit_dt();
					String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
					String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
					String strD_Val1;
					
				    strY_Val1 = deposit_dt.substring(0,4);
				    strM_Val1 = deposit_dt.substring(4,6);
				    strD_Val1 = deposit_dt.substring(6,8);
					
				    deposit_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
				}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݰ�꼭 ������</title>
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
<!--
function goSave(){

	var frm = document.invoiceVeiw; 

	var dates = frm.public_dt.value;
	var public_dts = dates.replace(/-/g,'');
	frm.pYear1.value = public_dts.substr(0,4);
	frm.pMonth1.value = public_dts.substr(4,2);
	frm.pDay1.value = public_dts.substr(6,2);
	
	frm.public_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	var dates = frm.pre_deposit_dt.value;
	var pre_deposit_dts = dates.replace(/-/g,'');
	frm.pYear5.value = pre_deposit_dts.substr(0,4);
	frm.pMonth5.value = pre_deposit_dts.substr(4,2);
	frm.pDay5.value = pre_deposit_dts.substr(6,2);

	
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;
	
	var dates = frm.deposit_dt.value;
	var deposit_dts = dates.replace(/-/g,'');
	frm.pYear3.value = deposit_dts.substr(0,4);
	frm.pMonth3.value = deposit_dts.substr(4,2);
	frm.pDay3.value = deposit_dts.substr(6,2);
	
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;
	
	
	
	
	if(frm.deposit_dt.value.length != 0){
		if(frm.deposit_amt.value == 0){
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

	if(frm.p_public_no.value.length == 0){
		alert("������ �����ȣ�� �Է��ϼ���!");
		return;
	}

	if(frm.gun.value.length == 0 || frm.ho.value.length == 0 || frm.manage_no.value.length == 0){
		alert("���� ������ �Է��ϼ���!");
		return;
	}
	if(frm.approve_no.value.length == 0){
		alert("���ι�ȣ�� �Է��ϼ���!");
		return;
	}
		
	if(frm.receiver.value.length == 0){
		alert("����(����)���� �Է��ϼ���!");
		return;
	}

	if(frm.public_dt.value.length == 0){
		alert("�������ڸ� �Է��ϼ���!");
		return;
	}

	if(frm.comp_code.value.length == 0){
		alert("��ü���� �Է��ϼ���!");
		return;
	}
	if(frm.pre_deposit_dt.value.length == 0){
		alert("�Աݿ������ڸ� �����ϼ���.");
		return;
	}
	if(frm.public_dt.value > frm.pre_deposit_dt.value){
		alert('�Աݿ������ں��� �������ڰ� Ů�ϴ�.');
		return;
	}
	
	//�޷�input(�ؽ�Ʈâ�Է½�) �������̼�üũ 2012.12.03(��) bsh.(�Աݿ�������)
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

	
	if(frm.pre_deposit_an.value == ""){
		alert("�Աݿ������¸� �����ϼ���.");
		return;
	}
	
	//�޷�input(�ؽ�Ʈâ�Է½�) �������̼�üũ 2012.12.03(��) bsh.(�Ա�����)
	//�Ա����ڰ� text input â�� �Էµ� �ÿ� ���۵Ǵ� �������̼�üũ
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

	if(confirm("���� �Ͻðڽ��ϱ�?")){

		if(frm.deposit_amt.value!= 0 && frm.deposit_dt.value.length != 0){
			frm.state.value='03';
		}else{
			frm.state.value='01';
		}

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		frm.public_no.value=frm.p_public_no.value;
		frm.submit();
	}
}

function goList(){
	
	var frm = document.invoiceVeiw;
	frm.action='<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
	frm.submit();

}

function goDelete(){
	
	var frm = document.invoiceVeiw;
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceDelete';
		frm.submit();
	}

}
function goCancel(){
	
	var frm = document.invoiceVeiw;
	if(confirm("������ ��� �Ͻðڽ��ϱ�?")){
		frm.action='<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceCancel';
		frm.submit();
	}

}

	
	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY&sForm=invoiceVeiw&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}
	
	function popComp(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_Ic&sForm=invoiceVeiw","","width=850,height=626,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	
	function saleCntCal(form){

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
			alert("���ڸ� �Է��� �ּ���.");
		} 

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
	

	function saleCntCalInit(form){

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
		alert("���ڸ� �Է��� �ּ���.");
	} 

	var num=onlyNum(v_obj.value);
	v_obj.value = addCommaStr(num);
	obj.value = num;

	var tcost=parseInt(costobj.supply_price.value,10)+parseInt(costobj.vat.value,10);

	costobj.total_amt_view.value=addCommaStr(''+tcost);
	costobj.total_amt.value=tcost;

	v_obj.focus();

}


//-->
</script>
</head>
<body >
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
	<div id="content">
		
		<!-- title -->
		<div class="content_navi">�������� &gt; (��)���ݰ�꼭������</div>
		<h3><span>(��)</span>���ݰ�꼭������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
		<!-- title -->
			
		<div class="con">
		<!-- ������ ��� ���� -->
		<div class="conTop_area"  id="excelBody">
					
		<!-- �ʼ��Է»����ؽ�Ʈ -->
		<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
		<!-- //�ʼ��Է»����ؽ�Ʈ -->
				
		</div>
		<!-- //������ ��� ���� -->
  
  <!-- calendar -->
  <div id="CalendarLayer" style="display:none; width:172px; height:176px;">
    <iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
  </div>
  <!-- //calendar -->
  
  	<!-- ��� -->
    <form name="invoiceVeiw" method="post" action="<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceEdit">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "comp_code" value="<%=invoiceDto.getComp_code()%>"/>
      <input type = "hidden" name = "permit_no" value="<%=invoiceDto.getPermit_no() %>"></input>
      <input type = "hidden" name = "public_no" value=""/>
      <input type = "hidden" name = "user_id" value=""/>
      <input type = "hidden" name = "user_nm" value=""/>
      <input type = "hidden" name = "sales_charge" value=""/>
      <input type = "hidden" name = "e_comp_nm" value=""/>
      <input type = "hidden" name = "productno" value=""/>
      <input type = "hidden" name = "state" value=""/>
      
      
      <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>

      <input type = "hidden" name = "pYear5" value=""/>
     <input type = "hidden" name = "pMonth5" value=""/>
     <input type = "hidden" name = "pDay5" value=""/>

      <input type = "hidden" name = "pYear3" value=""/>
     <input type = "hidden" name = "pMonth3" value=""/>
     <input type = "hidden" name = "pDay3" value=""/>




      
 	<fieldset>
		<legend>(��)���ݰ�꼭������</legend>
		<table class="tbl_type" summary="(��)���ݰ�꼭������(�����������ȣ(�����ȣ, ����), ��꼭�ݾ�(���ް�, �ΰ���, �հ�), ����(��, ȣ, ������ȣ, ���ι�ȣ, ����(����)��), ��������, ���ڼ��ݰ�꼭������, ���޹޴���(��ȣ(���θ�), ����, ����, ��ǥ�ڸ�, ����������), �Աݿ�������, �Աݿ������, �Աݱݾ�, �Ա�����, �������)">
			
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
		
		<tbody>
 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����������ȣ</label></th>
				<td class="listT">
					<table class="tbl_type" summary="�����������ȣ(�����ȣ, ����)">
						
						<colgroup>
							<col width="33%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
		<tbody>
		<tr class="last">
			<td><input type="text" id="" name="p_public_no" class="text" title="�����ȣ" style="width:188px;" readOnly onClick="javascript:popPublicNo();" value="<%=invoiceDto.getPublic_no()%>"/><a href="javascript:popPublicNo();" class="btn_type03"><span>�����ȣ��ȸ</span></a></td>
										
			<th><label for="">����</label></th>
			<td class="last"><input type="text" id="" name="title" class="text dis" title="����" style="width:494px;" readOnly value="<%=invoiceDto.getTITLE()%>"/></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
		</tr>
		</tbody>
		</table>
			</td>
				</tr>     
 
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��꼭�ݾ�</label></th>
				<td class="listT">
					
					<table class="tbl_type" summary="��꼭�ݾ�(���ް�, �ΰ���, �հ�)">
						<colgroup>
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
		<tbody>
			<tr class="last">
				<th><label for="">���ް�</label></th>
				<td><input type="hidden" name="supply_price" class="text"  style="width:80px" value="<%=invoiceDto.getSupply_price()%>" /><input type="hidden" name="vat" class="text"  style="width:80px" value="<%=invoiceDto.getVat()%>" /><input type="hidden" name="total_amt" class="text"  style="width:80px" value="" /><input type="text" id="" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(invoiceDto.getSupply_price())%>"  onKeyUp = "saleCntCal('invoiceVeiw.supply_price')"/> ��</td>
														
				<th><label for="">�ΰ���</label></th>
				<td><input type="text" id="" name="vat_view" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(invoiceDto.getVat())%>"  onKeyUp = "saleCntCal('invoiceVeiw.vat')"/> ��</td>
										
				<th><label for="">�հ�</label></th>
				<td class="last"><input type="text" name="total_amt_view" id="" class="text text_r" title="�հ�" style="width:163px;" readOnly/> ��</td>
			</tr>
		</tbody>
		</table>
		</td>
			</tr> 
 
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
				<td class="listT">
					<table class="tbl_type" summary="����(��, ȣ, ������ȣ, ���ι�ȣ, ����(����)��)">
						<colgroup>
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
				
				<tbody>
					<tr>
						<th><label for="">��</label></th>
						<td><input type="text" id="" name="gun" class="text" title="��" style="width:168px;" readOnly value="<%=invoiceDto.getGun()%>"/></td>
										
						<th><label for="">ȣ</label></th>
						<td><input type="text" id="" name="ho" class="text" title="ȣ" style="width:168px;" readOnly value="<%=invoiceDto.getHo()%>"/></td>
										
						<th><label for="">������ȣ</label></th>
						<td class="last"><input type="text" name="manage_no" id="" class="text" title="������ȣ" style="width:178px;" readOnly value="<%=invoiceDto.getManage_no()%>"/></td>
					</tr>

					<tr class="last">
						<th><label for="">���ι�ȣ</label></th>
						<td><input type="text" id="" name="approve_no" class="text" title="���ι�ȣ" style="width:168px;" maxlength="50"  value="<%=invoiceDto.getApprove_no()%>"/></td>
						
						<th><label for="">����(����)��</label></th>
						<td colspan="3" class="last"><input type="text" id="" name="receiver" class="text" title="����(����)��" style="width:200px;" maxlength="10"  value="<%=invoiceDto.getReceiver()%>"/></td>
					</tr>
				</tbody>
			</table>
		</td>
		</tr>

 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
				<td><span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="public_dt" value="<%=public_dt%>"/></span></td>
		</tr>

		<tr>
			<th><label for="">���ڼ��ݰ�꼭������</label></th>
			<td><input type="text" id="" name="public_org" class="text" title="���ڼ��ݰ�꼭������" style="width:300px;" maxlength="25"  value="<%=invoiceDto.getPublic_org()%>"/></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���޹޴���</label></th>
				<td class="listT">
					
					<table class="tbl_type" summary="���޹޴���(��ȣ(���θ�), ����, ����, ��ǥ�ڸ�, ����������)">
						<colgroup>
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="22%" />
							<col width="11%" />
							<col width="*" />
						</colgroup>
									
					<tbody>
						<tr>
							<th><label for="">��ȣ(���θ�)</label></th>
								<td><input type="text" id="" name="comp_nm" class="text" title="��ȣ(���θ�)" style="width:103px;" readOnly onClick="javascript:popComp();" value="<%=invoiceDto.getComp_nm()%>"/><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a></td>
							
							<th><label for="">����</label></th>
								<td><input type="text" id="" name="business" class="text" title="����" style="width:168px;" value="<%=invoiceDto.getBusiness()%>"  readOnly/></td>
										
							<th><label for="">����</label></th>
								<td class="last"><input type="text" id="" name="b_item" class="text" title="����" style="width:178px;" value="<%=invoiceDto.getB_item()%>"  readOnly/></td>
						</tr>

   						<tr class="last">
							<th><label for="">��ǥ�ڸ�</label></th>
							<td><input type="text" id="" name="owner_nm" class="text" title="��ǥ�ڸ�" style="width:168px;" value="<%=invoiceDto.getOwner_nm()%>"  readOnly/></td>
										
							<th><label for="">����������</label></th>
							<td colspan="3" class="last">
								<ul class="listD">
									<li class="first"><input type="text" id="" name="post" class="text" title="�����ȣ" style="width:80px;" value="<%=invoiceDto.getPost()%>"  readOnly/></li>
									
									<li>
										<input type="text" id="" name="address" class="text" title="�⺻�ּ�" style="width:239px;" value="<%=invoiceDto.getAddress()%>"  readOnly /> 
										<input type="text" id="" name="addr_detail" class="text" title="���ּ�" style="width:239px;" value="<%=invoiceDto.getAddr_detail()%>"  readOnly/>
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>    

 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ�������</label></th>
				<td><span class="ico_calendar"><input id="calendarData2" name="pre_deposit_dt" class="text" style="width:100px;" value="<%=pre_deposit_dt%>" /></span><input type="hidden" class="in_txt"  style="width:80px" value="<%=invoiceDto.getPre_deposit_dt()%>"/></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ������</label></th>
				<td>	
						<%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("��ü");
							codeParam.setName("pre_deposit_an");
							codeParam.setSelected(invoiceDto.getPre_deposit_an()); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeListHanSeqq(codeParam,"BankAC")); 
						%>
				</td>
		</tr>

		<tr>
			<th><label for="">�Աݱݾ�</label></th>
				<td><input type="hidden" name="deposit_amt" class="in_txt"  style="width:80px;" value="<%=invoiceDto.getDeposit_amt()%>" /><input type="text" id="" name="deposit_amt_view" class="text" title="�Աݱݾ�" style="width:200px;" maxlength="18"  onKeyUp = "saleCntCal('invoiceVeiw.deposit_amt')" value="<%=NumberUtil.getPriceFormat(invoiceDto.getDeposit_amt())%>"/> ��<span class="guide_txt">&nbsp;&nbsp;* �Աݱݾ� �Է� �� �Ա����ڴ� �ʼ� �Է� �׸��Դϴ�.</span></td>
		</tr>
         		
 		<tr>
			<th><label for="">�Ա�����</label></th>
				<td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" name="deposit_dt" value="<%=deposit_dt%>"/></span><input type="hidden" class="in_txt" style="width:80px" value="<%=invoiceDto.getDeposit_dt()%>"/></td>
		</tr>

		<tr>
			<th><label for="">�������</label></th>
				<td><textarea id="" title="�������" name="reference" style="width:917px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"><%=invoiceDto.getReference()%></textarea></td>
		</tr>
		</tbody>
	</table>
	</fieldset>
	</form>
	<!-- //��� -->
				
	<!-- ���̵��ؽ�Ʈ -->
	<p class="guide_txt">��ü ����� �Ǿ� ���� ������ ���ݰ�꼭�� ���� �� �� �����ϴ�. ����ڵ���� �� ����纻 ���� �� ��ü�� ����Ͻʽÿ�.</p>
	<!-- //���̵��ؽ�Ʈ -->
				
	<!-- Bottom ��ư���� -->
	<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
	<!-- //Bottom ��ư���� -->
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

<script>
saleCntCalInit('invoiceVeiw.supply_price');
</script>