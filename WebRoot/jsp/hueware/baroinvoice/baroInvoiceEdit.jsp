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

	//�ԱݿϷ� üũ����
		String fcYN = invoiceDto.getDepositFinish();
		String Checked_Y = "";
		//String Checked_N = "";
		
		if(fcYN.equals("Y")){
			Checked_Y = "checked";
		}
		/* else if(fcYN.equals("N")){
			Checked_N = "checked";
		} */


	
	int total = Integer.parseInt(invoiceDto.getSupply_price())+Integer.parseInt(invoiceDto.getVat());
	
	String allTotal= NumberUtil.getPriceFormat(total);
	String issue = invoiceDto.getIssuetype();
	System.out.println("issue:"+issue);
	
	//������ �ʱ� ���� ��.
			String public_dt_View = "";

			
			if(invoiceDto.getPublic_dt().equals("")){
				public_dt_View = invoiceDto.getPublic_dt();
				public_dt_View = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			}else{
				public_dt_View = invoiceDto.getPublic_dt();
				String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strD_Val1;
				
			    strY_Val1 = public_dt_View.substring(0,4);
			    strM_Val1 = public_dt_View.substring(4,6);
			    strD_Val1 = public_dt_View.substring(6,8);
				
			    public_dt_View = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
			}
			
			//�Աݿ����� �ʱ� ���� ��.
			String pre_deposit_dt_View = "";
			
			if(invoiceDto.getPre_deposit_dt().equals("")){
				pre_deposit_dt_View = invoiceDto.getPre_deposit_dt();
				pre_deposit_dt_View = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			}else{
				pre_deposit_dt_View = invoiceDto.getPre_deposit_dt();
				String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strD_Val1;
				
			    strY_Val1 = pre_deposit_dt_View.substring(0,4);
			    strM_Val1 = pre_deposit_dt_View.substring(4,6);
			    strD_Val1 = pre_deposit_dt_View.substring(6,8);
				
			    pre_deposit_dt_View = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
			}
			
			
			//�Ա��� �ʱ� ���� ��.
					String deposit_dt_View = "";
					
					if(invoiceDto.getDeposit_dt().equals("")){
						deposit_dt_View = invoiceDto.getDeposit_dt();
						
					}else{
						deposit_dt_View = invoiceDto.getDeposit_dt();
						String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
						String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
						String strD_Val1;
						
					    strY_Val1 = deposit_dt_View.substring(0,4);
					    strM_Val1 = deposit_dt_View.substring(4,6);
					    strD_Val1 = deposit_dt_View.substring(6,8);
						
					    deposit_dt_View = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
					}
		
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݰ�꼭 ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">
<!--
function goSave(){

	var frm = document.invoiceVeiw; 
	
	
	
	var PreDeposit = frm.pre_deposit_dt_View.value;
	var PreDeposit2 = PreDeposit.replace(/-/g,'');
	frm.pYear5.value=PreDeposit2.substr(0,4);
	frm.pMonth5.value=PreDeposit2.substr(4,2);
	frm.pDay5.value=PreDeposit2.substr(6,2);
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value; //�Աݿ�������

	
	var Deposit = frm.deposit_dt_View.value;
	var Deposit2 = Deposit.replace(/-/g,'');
	frm.pYear3.value=Deposit2.substr(0,4);
	frm.pMonth3.value=Deposit2.substr(4,2);
	frm.pDay3.value=Deposit2.substr(6,2);
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;  //�Ա�����
	
	var Public = frm.public_dt_View.value;
	var Public2 = Public.replace(/-/g,'');
	frm.pYear1.value=Public2.substr(0,4);
	frm.pMonth1.value=Public2.substr(4,2);
	frm.pDay1.value=Public2.substr(6,2);
	frm.public_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;  //�Ա�����

	var chk = $("input:checkbox[id='depositFinish']").is(":checked");	
	 if(chk){depositFinishCheckYN() }
	
	
	
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
			frm.state.value='03';//�ԱݿϷ�
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
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
	frm.submit();

}

function goDelete(){
	
	var frm = document.invoiceVeiw;
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceDelete';
		frm.submit();
	}

}
<%-- function goCancel(){
	
	
	var a = window.open("<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=modifyInvoiceFlag&gun=<%=invoiceDto.getGun()%>&ho=<%=invoiceDto.getHo()%>&manage=<%=invoiceDto.getManage_no()%>&mgtkey=<%=invoiceDto.getMGTKEY()%>","","width=700,height=570,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
} --%>

function goCancel(){
	 var frm = document.invoiceVeiw;
	 if(confirm("��� �Ͻðڽ��ϱ�?")){
	 frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=cancel&gun=<%=invoiceDto.getGun()%>&ho=<%=invoiceDto.getHo()%>&manage=<%=invoiceDto.getManage_no()%>&mgtkey=<%=invoiceDto.getMGTKEY()%>","","width=700,height=570,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no';
	 frm.submit();
	 }
}

//user��� �˾�

 <%-- function goCancel(gun,ho,manageno){
	
	var frm = document.invoiceVeiw;
	
	if(confirm("������ ��� �Ͻðڽ��ϱ�?")){
		frm.gun.value=gun;
		frm.ho.value=ho;
		frm.manage_no.value=manageno;
		frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
		
		frm.submit();
	}
}  --%>

function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY&sForm=invoiceVeiw&contractGb=Y","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}
function popComp(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_Ic&sForm=invoiceVeiw","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
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

function invoiceModify_1(){
	
	var frm =document.invoiceVeiw;
	frm.modifyFlag.value="01";
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
	frm.submit();
	
	
}
function invoiceModify_2(){
	
	var frm =document.invoiceVeiw;
	frm.modifyFlag.value="02";
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
	frm.submit();
	
	
}
function invoiceModify_3(){
	
	var frm =document.invoiceVeiw;
	frm.modifyFlag.value="03";
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
	frm.submit();
	
	
}
function invoiceModify_4(){
	
	var frm =document.invoiceVeiw;
	frm.modifyFlag.value="04";
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
	frm.submit();
	
	
}
function invoiceModify_5(){
	
	var frm =document.invoiceVeiw;
	frm.modifyFlag.value="05";
	frm.action='<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceCancel';
	frm.submit();
	
	
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

	
	v_obj.focus();

}


//�Ա� Ȯ�� üũ
function depositFinishCheckYN(){
	var frm = document.invoiceVeiw;
	var chk = $("input:checkbox[id='depositFinish']").is(":checked");	
	 if(chk){
		 frm.depositFinish.value = "Y";
			if(frm.deposit_dt_View.value.length == 0){
				alert("�ԱݿϷḦ üũ�Ͻ� ��� �Ա����� �Է����ֽʽÿ�.");
			}

			if(frm.deposit_amt.value == 0){
				alert("�ԱݿϷḦ üũ�Ͻ� ��� �Աݾ��� �Է����ֽʽÿ�.");
			}
		 frm.state.value='03';//�ԱݿϷ�
		 
	 }else{
		 frm.depositFinish.value = "N";
	 }
}



//-->
</SCRIPT>
</head>
<body >
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
 <div class="content_navi">�������� &gt; (��)���ݰ�꼭������</div>
	<h3><span>(��)</span>���ݰ�꼭������</h3>
  <!-- calendar -->
  <div id="CalendarLayer" style="display:none; width:172px; height:176px;">
    <iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
  </div>
  <!-- //calendar -->
  <div class="con">
  <!-- con -->
  <!-- ������ ��� ���� -->
				<div class="conTop_area">
				<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
  <%if(issue.equals("03")){%>
    <form name="invoiceVeiw" method="post" action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceEdit" enctype="multipart/form-data">
    
    <%}else{%>
    <form name="invoiceVeiw" method="post"   action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=BaroInvoiceEdit_2" >
   
   <%}%>
   	  <input type="hidden" name="pYear3" id="" value="" >
	  <input type="hidden" name="pMonth3" id="" value="" >
	  <input type="hidden" name="pDay3" id="" value="" >
	  <input type="hidden" name="pDay5" id="" value="" >
	  <input type="hidden" name="pYear5" id="" value="" >
	  <input type="hidden" name="pMonth5" id="" value="" >
	  <input type="hidden" name="pDay1" id="" value="" >
	  <input type="hidden" name="pYear1" id="" value="" >
	  <input type="hidden" name="pMonth1" id="" value="" >
      <input type = "hidden" name = "curPage" value="<%=curPage%>">
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>">
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
      <input type = "hidden" name = "comp_code" value="<%=invoiceDto.getComp_code()%>">
      <input type = "hidden" name = "permit_no" value="<%=invoiceDto.getPermit_no() %>"></input>
      <input type = "hidden" name = "TELL" value="<%=invoiceDto.getTELL()%>">
      <input type = "hidden" name = "E_MAIL" value="<%=invoiceDto.getE_MAIL()%>">
      <input type = "hidden" name = "public_no" value="">
      <input type = "hidden" name = "mgtkey" value="<%=invoiceDto.getMGTKEY()%>">
      <input type = "hidden" name = "user_id" value="">
      <input type = "hidden" name = "user_nm" value="">
      <input type = "hidden" name = "sales_charge" value="">
      <input type = "hidden" name = "e_comp_nm" value="">
      <input type = "hidden" name = "productno" value="">
      <input type = "hidden" name = "state" value="">
      <input type = "hidden" name = "modifyFlag" value="">
      <input type = "hidden" name = "supply_price" value="<%=invoiceDto.getSupply_price()%>">
      <input type = "hidden" name = "vat" value="<%=invoiceDto.getVat()%>">
      <input type = "hidden" name = "approve" value="<%=invoiceDto.getApprove_no()%>">
	  <input type = "hidden" name = "contract" value="<%=invoiceDto.getCONTRACT_CODE()%>">	   
     <fieldset>
			<legend>(��)���ݰ�꼭������</legend>
			<table class="tbl_type" summary="(��)���ݰ�꼭������(��������ȣ, �����������ȣ(�����ȣ, ����), ��꼭�ݾ�(���ް�, �ΰ���, �հ�), ����(��, ȣ, ������ȣ, ���ι�ȣ, ����(����)��), ��������, ���ڼ��ݰ�꼭������, ���޹޴���(��ȣ(���θ�), ����, ����, ��ǥ�ڸ�, ����������), �Աݿ�������, �Աݿ������, �Աݱݾ�, �Ա�����, �������)">
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tbody>
		<tr>
  		<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������ȣ</label></th>
          <td><input type="text"  name="contract_no" class="text dis" value="<%=invoiceDto.getCONTRACT_CODE()%>"   style="width:200px;" />
       	  </td>
        </tr>
        
        
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
					<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
					<td><input type="text" name="p_public_no" class="text dis" readOnly style="width:200px;" readOnly  value="<%=invoiceDto.getPublic_no()%>"></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
					<th><label for="">����</label></th>
            	    <td class="last"><input type="text" name="title" class="text dis" style="width:495px;"  readOnly value="<%=invoiceDto.getTITLE()%>"></td>
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
        										  <!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
										<th><label for="">���ް�</label></th>
							          <input type="hidden" name="supply_price"  class="in_txt"  style="width:80px" value="<%=invoiceDto.getSupply_price()%>" >
							          <input type="hidden" name="vat" class="in_txt"   style="width:80px" value="<%=invoiceDto.getVat()%>" >
							          <input type="hidden" name="total_amt"  class="in_txt"  style="width:80px" value="" >
							          <td><input type="text" name="supply_price_view" readOnly class="text text_r dis" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(invoiceDto.getSupply_price())%>"  onKeyUp = "saleCntCal('invoiceVeiw.supply_price')" >
								            ��</td> 
								          <th><label for="">�ΰ���</label></th>
								          <td><input type="text" name="vat_view" readOnly class="text text_r dis" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(invoiceDto.getVat())%>"  onKeyUp = "saleCntCal('invoiceVeiw.vat')" >
								            ��</td>
								          <th><label for="">�հ�</label></th>
								          <td class="last"><input type="text" name="total_amt_view" readOnly class="text text_r dis" value="<%=allTotal %>" style="width:163px;" readOnly>
								            ��</td>
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
					<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
   		  <th><label for="">��</label></th>
          <td><input type="text" name="gun" readOnly class="text dis" style="width:168px;" readOnly value="<%=invoiceDto.getGun()%>"></td>
          <th><label for="">ȣ</label></th>
          <td><input type="text" name="ho"  readOnly class="text dis" style="width:168px;" value="<%=invoiceDto.getHo()%>"></td>
          <th><label for="">������ȣ</label></th>
          <td class="last"><input type="text" readOnly name="manage_no" class="text dis" style="width:178px;" value="<%=invoiceDto.getManage_no()%>"></td>
        </tr>
       <tr class="last">
		<th><label for="">���ι�ȣ</label></th>
          <td colspan=""><input type="text"  name="approve_no" class="text dis" style="width:168px;" maxlength="50"  value="<%=invoiceDto.getApprove_no()%>"></td>
         <th><label for="">����(����)��</label></th>
          <td colspan="3" class="last"><input type="text" readOnly name="receiver" class="text dis" style="width:200px;" maxlength="20"  value="<%=invoiceDto.getReceiver()%>"></td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        
                
       <tr>
		<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
					<td><span class="ico_calendar">
					<input id="calendarData1" name="public_dt_View" value="<%=public_dt_View%>" class="text" style="width:100px;"/></span>
					<input type="hidden" name="public_dt" class="text"  style="width:100px" value=""/>
					</td>
		</tr>
        
        
        
        
        <tr>
				<th><label for="">���ڼ��ݰ�꼭������</label></th>
          <td><input type="text" name="public_org" readonly="readonly" class="text dis" style="width:300px;" maxlength="25"  value="<%=invoiceDto.getPublic_org()%>"></td>
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
										<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
										<th><label for="">��ȣ(���θ�)</label></th>
          <td><input type="text" name="comp_nm" readOnly class="text dis" style="width:168px;" readOnly onClick="javascript:popComp();" value="<%=invoiceDto.getComp_nm()%>">
          <th><label for="">����</label></th>
          <td><input type="text" name="business" readOnly class="text dis" style="width:168px;" value="<%=invoiceDto.getBusiness()%>"  readOnly></td>
          <th><label for="">����</label></th>
          <td><input type="text" name="b_item" readOnly class="text dis" style="width:178px;" value="<%=invoiceDto.getB_item()%>"  readOnly></td>
        </tr>
       <tr class="last">
										<th><label for="">��ǥ�ڸ�</label></th>
          <td><input type="text" name="owner_nm" readOnly class="text dis" style="width:168px;" value="<%=invoiceDto.getOwner_nm()%>"  readOnly></td>
         <th><label for="">����������</label></th>
         <td colspan="3" class="last">
         	<ul class="listD">
         <li class="first"><input type="text" readOnly name="post" class="text dis" style="width:80px;" value="<%=invoiceDto.getPost()%>"  readOnly></li>
          <li>  <input type="text" name="address" readOnly  class="text dis" style="width:239px;" value="<%=invoiceDto.getAddress()%>"  readOnly>
            <input type="text" name="addr_detail" readOnly  class="text dis" style="width:239px;" value="<%=invoiceDto.getAddr_detail()%>"  readOnly></li>
            </td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        
        
          <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ�������</label></th>
					<td><span class="ico_calendar">
					<input id="calendarData2" name="pre_deposit_dt_View" value="<%=pre_deposit_dt_View%>" class="text" style="width:100px;"/></span>
					<input type="hidden" name="pre_deposit_dt" class="text"  style="width:100px" value=""/>
					</td>
		</tr>
		
		
    
            <tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ������</label></th>
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("��ü");
							codeParam.setName("pre_deposit_an");
							codeParam.setSelected(invoiceDto.getPre_deposit_an()); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeListHanSeqq(codeParam,"BankAC")); 
						%></td>
						
         		</tr>
         		
       
        <tr>
		<th><label for="">�Աݱݾ�</label></th>
		<td><input type="hidden" name="deposit_amt" class="in_txt"  style="width:80px;" value="<%=invoiceDto.getDeposit_amt()%>" />
		<input type="text" id="" name="deposit_amt_view" class="text" title="�Աݱݾ�" style="width:200px;" maxlength="18"  onKeyUp = "saleCntCal2('invoiceVeiw.deposit_amt')" value="<%=NumberUtil.getPriceFormat(invoiceDto.getDeposit_amt())%>"/> ��<span class="guide_txt">&nbsp;&nbsp;* �Աݱݾ� �Է� �� �Ա����ڴ� �ʼ� �Է� �׸��Դϴ�.</span></td>
		</tr>
		
          <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Ա�����</label></th>
					<td><span class="ico_calendar">
					<input id="calendarData3" name="deposit_dt_View" value="<%=deposit_dt_View%>" class="text" style="width:100px;"/></span>
					<input type="hidden" name="deposit_dt" class="text"  style="width:100px" value="<%=invoiceDto.getDeposit_dt()%>"/>
					
					&nbsp;�ԱݿϷ�&nbsp;&nbsp;<input type="checkbox" name="depositFinish" id="depositFinish" <%= Checked_Y %> value="<%= invoiceDto.getDepositFinish() %>" onclick="javascript:depositFinishCheckYN();"/><span class="guide_txt">&nbsp;&nbsp;* �ԱݿϷ� üũ �� �Աݾ��� �����ص� ȸ�� �Ϸ�ó�� �˴ϴ�.</span>
					</td>
		</tr>
		
		
		
        <%if(issue.equals("03")){%>
         <tr>
          <th><label for="">���ݰ�꼭</label></th>
          <td><input type="hidden" name="inverseregistNm" value="" /><div class="fileUp"><input type="text" class="text" id="file1" title="���ݰ�꼭" style="width:566px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="inverseregist" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* ÷�ΰ��� �������� : ��� ���� / ÷�ΰ��� �뷮 : �ִ� 20M</span></td>
        </tr>
     <%} %>
        
        
        <tr>
         <th><label for="">�������</label></th>
          <td><textarea name="reference" style="width:917px;height:41px;" dispName="������� " onKeyUp="js_Str_ChkSub('500', this)"><%=invoiceDto.getReference()%></textarea></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
    </form>
    <!-- ���̵��ؽ�Ʈ -->
				<p class="guide_txt">��ü ����� �Ǿ� ���� ������ ���ݰ�꼭�� ���� �� �� �����ϴ�. ����ڵ���� �� ����纻 ���� �� ��ü�� ����Ͻʽÿ�.</p>
				<!-- //���̵��ؽ�Ʈ -->
   <!-- button -->
    <div class="Bbtn_areaC"><a href="#" onclick="javascript:goSave();" class="btn_type02"><span>�Ա�Ȯ��</span></a>
    <a href="#" onClick="javascript:goCancel();" class="btn_type02 btn_type02_gray"><span>��������</span></a>
   <%--  <a href="#"><img src="<%=request.getContextPath()%>/images/btn_delete.gif" onClick="javascript:goDelete();" width="73" height="28" alt="����" title="����" /></a> --%>
    <a href="#" class="btn_type02 btn_type02_gray" onClick="javascript:goList();"><span>���</span></a></div>
   <!-- //button -->
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
<script>
saleCntCalInit('invoiceVeiw.supply_price');
</script>
<script type="text/javascript">fn_fileUpload();</script>