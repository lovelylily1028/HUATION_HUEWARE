<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.ComCodeDTO"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
    
	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String type = (String)model.get("type");
	String title = "";
	if(type.equals("reg")){
		title = "����";
	}else{
		title = "����(��ü)";
	}
	
	//��ǰ�ڵ� Arr �𵨷� ��ü�� ������ codeList��.
	ArrayList codeList = (ArrayList)model.get("codeList"); //�ڻ� ��ǰ�ڵ�
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //���ڻ�(����)��ǰ�ڵ�
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //���ڻ�(�ܼ�)��ǰ�ڵ�
	
	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
	
	
	String Month = df.format(cal.get(Calendar.MONTH)+1);
	String DATE =  df.format(cal.get(Calendar.DATE)); 
	
	//Date ����(2013-12-27) ���� ��¥�� type �����ֱ�.
	String estimate_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������(����) ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">

<!--
function goSave(){

	var frm = document.estimateRegist; 
	var dates = frm.estimate_dt.value;
	var estimate_dts = dates.replace(/-/g,'');
	
	frm.pYear1.value = estimate_dts.substr(0,4);
	frm.pMonth1.value = estimate_dts.substr(4,2);
	frm.pDay1.value = estimate_dts.substr(6,2);
 	frm.estimate_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
 	
 	


	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.estimate_e_file.value;
	var strFile2 = frm.estimate_p_file.value;

	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);

	var lastIndex2 = strFile2.lastIndexOf('\\');
	var strFileName2 = strFile2.substring(lastIndex2+1);

	if(fileCheckNm(strFileName)> 200){
		alert('[������ ����]�� (Excel���ϸ�)��/�� 200��(byte)�̻��� ���ڸ� ��� �� �� �����ϴ�.');
		return;
	}
	if(fileCheckNm(strFileName2)> 200){
		alert('[������ ����]�� (PDF���ϸ�)��/�� 200��(byte)�̻��� ���ڸ� ��� �� �� �����ϴ�.');
		return;
	}
		
//���ϸ� ���ڼ�(byte) üũ		
function fileCheckNm(szValue){
		var tcount=0;
		var tmpStr = new String(szValue);
		var temp = tmpStr.length;
		var onechar;
		for(k=0; k<temp; k++){
			onechar = tmpStr.charAt(k);
			if(escape(onechar).length>4){
				tcount +=2;
				
			}else{
				tcount +=1;
			}
		}
		return tcount;
	}	
	
	if(frm.SalesSort.value == ''){
		alert('���ⱸ���� �ּ��� �ϳ��̻� ���� �ϼž��մϴ�.');
		return;
	}
	
	//��ǰ�ڵ� ����üũ�� ���� length �ҷ�����.
	var ProductCode = $('#ProductCode').length;
	
	if(ProductCode == 0){
		alert("��ǰ�ڵ带 ������ �ּ���");
		return;
	}
	
	if(frm.estimate_dt.value.length == 0){
		alert("�������ڸ� ������ �ּ���");
		return;
	}
	
	

	//�޷�input(�ؽ�Ʈâ�Է½�) �������̼�üũ 2012.12.03(��) bsh.
	var Y = frm.pYear1.value;
	var M = frm.pMonth1.value;
	var D = frm.pDay1.value;

	if(Y.length>0){
		if (!isNumber(trim(Y))) {
			alert("�⵵�� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(Y);
			frm.pYear1.value ="";
			return;
			
		}else{
				Y=onlyNum(Y)
			} 
		}
	if(Y.length<4){
		alert('�⵵�� 4�ڸ��� �̸����Ұ����մϴ�.');
		Y=onlyNum(Y);
		frm.pYear1.value ="";
		return;
	}else{
		Y=onlyNum(Y)
	}
	
	
	if(M.length>0){
		if (!isNumber(trim(M))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(M);
			frm.pMonth1.value ="";
			return;
			
		}else{
				Y=onlyNum(M);
				
			} 
		}
	if(M.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� �Ͻ�=>01 �Է�).');
		M=onlyNum(M);
		frm.pMonth1.value ="";
		return;
	}else{
		M=onlyNum(M)
	}
	if(D.length>0){
		if (!isNumber(trim(D))) {
			alert("���ڴ� ���ڸ� �Է��� �����մϴ�.");
				Y=onlyNum(D);
			frm.pDay1.value ="";
			return;
		
		}else{
			Y=onlyNum(D);	
			}
		}
	if(D.length<2){
		alert('���ڴ� 2�ڸ��� �̸����Ұ����մϴ�(ex:1�� =>01 �Է�).');
		D=onlyNum(D);
		frm.pDay1.value ="";
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

		frm.pMonth1.value ="";
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
		frm.pDay1.value ="";
		return;
	}else{
		Y=onlyNum(D);
	}

	if(frm.receiver.value.length == 0 ){
		alert("�������� �Է��ϼ���!");
		return;
	}
		if(frm.title.value.length == 0 ){
		alert("������ �Է��ϼ���!");
		return;
	}

	if(frm.e_comp_nm.value.length == 0 && frm.comp_code.value.length == 0 && frm.comp_code.value.length == 0){
		alert("��ü���� �����Է� �Ǵ� ��ȸ �� �����ϼ���.");
		return;
	}

	//�����Է��� �ƴ� ��ü��ȸ �Է��϶�. ��ü��ȸ ��ü�� comp_nm -> e_comp_nm�� �Ѱ��ش�.(�� �����ʹ� e_comp_nm �� ���⶧��.)
	if(frm.checkyn.checked!=true){	
		if(frm.comp_code.value.length != 0){
			frm.e_comp_nm.value=frm.comp_nm.value
		}
	}	
		

	/*
	  2013_04_01(��) shbyeon. -> 2013_05_07(ȭ)shbyeon. ���� ������.
	    ������ȣ ��ȸ �� �ʱ� �� �����Է�  �÷��� üũ���ϰ� (��ü��)������� �ٷ� ���.
	  Note:������ȣ ��ȸ �� ��ü �����Է� �� �ÿ� �ߺ�üũ ��.
	    �ߺ�Ȯ�ι�ư display ������ üũ��.
	if(frm.e_comp_nm_se.style.display == "none"){
		//�ߺ� üũ ���ϰ� �Ѿ
		
	}else{
		if(frm.checkyn.checked==true){
			if(frm.e_comp_nm.value!=frm.trueflag.value){
				alert("��ü���� �ߺ��Ǵ��� Ȯ���ϼ���.");
				return;
			}
		}
	}
	*/
	
	if(frm.supply_price.value.length == 0 || trim(frm.supply_price.value) == "" || frm.supply_price.value == "0"||frm.vat.value.length == 0 || trim(frm.vat.value) == "" ||frm.vat.value == "0"
		 || frm.supply_price_view.value.length == 0 || trim(frm.supply_price_view.value) == "" || frm.supply_price_view.value == "0"||frm.vat_view.value.length == 0 || trim(frm.vat_view.value) == "" ||frm.vat_view.value == "0" ){
		alert("�����ݾ��� �Է��ϼ���!");
		return;
	}

	if(frm.IndirectSaleschk.checked == true){
		if(frm.Purchase.value == "" || frm.Sales_profit.value == "" || frm.Profit_percent.value == ""){
			alert("�������� üũ �� ��������ݾ׶� �� �ʼ��Է� �׸��Դϴ�.");
			return;
		}
	}
	
	if(frm.estimate_e_file.value != "" && !isExcelImageFile(frm.estimate_e_file.value)){
			alert("����������(EXCEL)��  ÷�� ������ ���� ������ \n xls,xlsx �Դϴ�.");
			return; 				
	}

	if(frm.estimate_p_file.value != "" && !isPDFImageFile(frm.estimate_p_file.value)){
			alert("����������(PDF)��  ÷�� ������ ���� ������ \n pdf �Դϴ�.");
			return; 				
	}
	//��������
	if(frm.dpublicyn.checked==true){
		frm.d_public_yn.value='Y';
	}else{
		frm.d_public_yn.value='N';
	}
	//��������
	if(frm.IndirectSaleschk.checked==true){
		frm.IndirectSalesYN.value='Y';
	}else{
		frm.IndirectSalesYN.value='N';
	}

	
	//������ ��ù������� ���� ����������Ȳ ���� ���� �������̼�üũ.
	var chk_Now = $("td#SalesChk input:checked").val();
	if(chk_Now == "3"){
		
		if(frm.OperatingCompany.value == ""){
			alert("���縦 �Է��ϼ���."); 
			return;
		}
		
		if(frm.AssignPerson.value == ""){
			alert("����о� �����η��� �Է��ϼ���."); 
			return;
		}
		
		//����ñ� �б� üũ�� �б⺰ ������ ����
	    if(frm.target_month.value == "01" || frm.target_month.value == "02" || frm.target_month.value == "03"){
	    	frm.Quarter.value = "1";
	    }
	    if(frm.target_month.value == "04" || frm.target_month.value == "05" || frm.target_month.value == "06"){
	    	frm.Quarter.value = "2";
	    }
	    if(frm.target_month.value == "07" || frm.target_month.value == "08" || frm.target_month.value == "09"){
	    	frm.Quarter.value = "3";
	    }
	    if(frm.target_month.value == "10" || frm.target_month.value == "11" || frm.target_month.value == "12"){
	    	frm.Quarter.value = "4";
	    }
	    
	    frm.DateProjections.value=frm.target_year.value+'.'+frm.target_month.value;
	}
    
	
	frm.sales_charge.value=frm.user_id.value;
	frm.ChargeSecondID.value=frm.user_id2.value;

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.ESTIMATE_E_FILENM.value = strFileName;
	frm.ESTIMATE_P_FILENM.value = strFileName2;
	
	if(frm.checkyn.checked==true){
		frm.checkyn.value='Y'; //�����Է�������.
		//alert(frm.checkyn.value);
	}else{
		frm.checkyn.value=''   //�����Է� ��� ��������
		//alert(frm.checkyn.value);
	}
	frm.submit();
}

function cancle(){
	
	var frm = document.test;
	frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
	frm.submit();

}

//�˾� ������ ������ �ڵ� ���� 2013_05_07(ȭ)shbyeon.
function settingCode(data){
	
	var pcname = data.split("+"); //��ǰ�ڵ� ������ (+)�����ڷ� ã�Ƽ�  Ajax�� ���� data�� �߶��ش�
	//alert("1"+pcname); //������(+) �� ��ǰ�ڵ� ���� ��ŭ  (ex:PC00HUEFAX|HUEFAX) arr������ �߶� ������Ų��.
	//����������Ȳ ��ǰ�ڵ� �� ��ȸ �� ��� �� ��ǰ�ڵ� �ʱ�ȭ.
	$('#cart ol li').remove();
	$('#products li').show();
	$('#NoCode').remove(); //(��ǰ�ڵ� cart) ����
	
	for(var x=0; x < pcname.length; x++){ /*������(+) �� ��ǰ�ڵ� ���� ��ŭ  (ex:PC00HUEFAX|HUEFAX)
											arr������ �߶� ������Ų��.
										   */
		//alert(pcname[x]); //ex:PC00HUEFAX|HUEFAX) ��ǰ�ڵ� ���� ���� alert
											
		var pcCode = pcname[x].split("|"); /*������ (+)�߶� (ex:PC00HUEFAX|HUEFAX) ������Ų �����͸�  (|)������
											 �������� �ѹ� �� �߶��ش�. ù��° [x]�� pcCode[0]�ι�° pcCode[x]�� [1]��.
											 ��ǰ�ڵ� (ex:PC00HUEFAX|HUEFAX) DAO���� ������ Ajax�� �Ѱܹ��� Data��
										   	(|)�����ڷ� ã�Ƽ� �߶� pcCode <<���� DB�� �� Value �����Ͱ��� ������ �־��ش�.
										   	 �߶��ٶ� [x] ��ǰ�ڵ� ������ ���� pcname[x]��ŭ �߶��� �����͸� (|)�����ڷ� 
										   	 [0]�϶��� �ڵ�� [1]�϶��� �̸������� �������ش�.
											*/
											
		//alert("2"+pcCode[0]+"...."+pcCode[1]);   //pcCode[0]�迭(�ڵ��), pcname[1]�迭(�̸���)
		
		//�˾����� ������ ���������� ���� ����..
		$('#products #'+pcCode[0]).hide(); //����(��ǰ�ڵ� ����) ���� ��ǰ�ڵ� ���Append�� �ִ�  �ش� ������ ����
		
		//������(��ǰ�ڵ� �ڽ�)�� �ڵ忡 �߰�
		$('#cart ol').append("<li id="+pcCode[0]+" ondblclick=\"delCode('"+pcCode[0]+"')\" style=\"cursor: pointer;\">"+"<a>"+pcCode[1]+"</a>"+" <input type='hidden' name='ProductCode' id='ProductCode' value="+pcCode[0]+"></li>");
	}
	
}


//����������Ȳ ��ȸ
function popProjectCode(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPreSalesCode&sForm=estimateRegist&contractGb=N","","width=1000,height=573,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	
}

//������ȣ ��ȸ.
function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNo&sForm=estimateRegist&contractGb=N&type=<%=type%>","","width=850,height=655,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}

//��ü ��ȸ �˾�â 
function popComp(){

		var obj=document.estimateRegist;
		if(obj.checkyn.checked==true){
				alert('�����Է� ������ ������ ��ü��ȸ �Ͻñ� �ٶ��ϴ�.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=estimateRegist","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
}

function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=estimateRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
function popSales_Second(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=estimateRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
function saleCntCal(form){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateRegist;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}

		if (!isNumber(trim(v_obj.value))) {
			if (trim(v_obj.value == "")) {
				v_obj.value = "";
				frm.value = "";
				return;
			}
			
			alert("���ڸ� �Է��� �ּ���.");	
			v_obj.value = "";
			frm.value = "";
			v_obj.focus();
			return;
		} 

		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;

		if(form=='estimateRegist.supply_price'){	
			var vat=parseInt(onlyNum(costobj.supply_price.value)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		    
		    
		}

		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		//v_obj.focus();

	}
		
//���Կ��� ��� 2013-11-19(ȭ) shbyeon.
function saleCntCal2(){
	
	var frm = document.estimateRegist;
	var supply_price = frm.supply_price_view.value;		//���ް�(�����ݾ� VAT����)
	var purchase = frm.purchase_view.value; 				//���Կ���
	if(frm.supply_price_view.value == '0'){
		alert("�����ݾ��� �ٸ��� �Է��ϼ���.");
		frm.Purchase.value="0";
		frm.purchase_view.value="0";
		frm.Sales_profit.value="0";
		frm.sales_profit_view.value="0";
		frm.supply_price_view.value = "";
		frm.supply_price.value = "";
		frm.supply_price_view.focus();
		return;
	}else{
		//1.(�����ݾ�[���ް�] - ���Կ���) = sales_profit(��������)
		var sales_profit = parseInt(onlyNum(supply_price))-parseInt(onlyNum(purchase));
		//2. �������� / �����ݾ�[���Կ���] * 100 = profit_percent(������)
		var profit_percent = sales_profit/parseInt(onlyNum(purchase)) * 100;	
		//3.�����ݾ�[���ް�] ���� �ÿ��� �������� ���ó���� ���� �߰���.
		if(purchase == 0){
		//4.�����ݾ� �Է� �� �������� ����� ������ ������ �Ѱ��� Name ���� View ������ ��������.	

		}else{
		//5.�����ݾ�[���ް�] ���� �ÿ��� �������� ����.(toFixed(1) Ex:�Լ� �Ҽ��� ���� 1�ڸ��� ǥ����)
		frm.purchase_view.value=addCommaStr(''+onlyNum(purchase));	 	  //���Կ��� ���װ�.
		frm.Purchase.value=parseInt(onlyNum(purchase));		   		      //���Կ���(VAT����) ���� DB�� �Ѱ��ٰ�.(����ȯ�Ͽ� ���� ������ �����Ƿ� ��������ȯ���ش�.)
		frm.sales_profit_view.value=addCommaStr(''+sales_profit);		  //�������� ���װ�.
		frm.Sales_profit.value=sales_profit;					  	      //�������� ���� DB�� �Ѱ��ٰ�.
		frm.profit_percent_view.value=profit_percent.toFixed(2);		   //������ ���װ�
		frm.Profit_percent.value=profit_percent.toFixed(2);			   	   //������ ���� DB�� �Ѱ��ٰ�.
		
			
		if(frm.Sales_profit.value == "NaN"){
				alert("�ùٸ� ���� �Էµ��� �ʾҽ��ϴ�. ���ް� �Ǵ� ���Կ����� �ٽ��ѹ� Ȯ�����ּ���.");
				frm.Purchase.value="0";
				frm.purchase_view.value="0";
				frm.Sales_profit.value="0";
				frm.sales_profit_view.value="0";
				frm.supply_price.value = "";
				frm.supply_price_view.value = "";
				frm.supply_price_view.focus();
				return;
			}
		}
	}
}
	
	/*�����Է�üũ(����)
	*/
	function directInput(){

	    var obj=document.estimateRegist;
		if(obj.checkyn.checked==true){
			obj.e_comp_nm.style.display='inline'
			obj.comp_nm.style.display="none";
			obj.comp_nm.value='';
			obj.comp_code.value='';
		}else{
			obj.e_comp_nm.style.display='none'
			obj.comp_nm.style.display="inline";
			
		}

	}
	
	/*�����Է�üũ(����)
	*/
	function directInput(){

	    var obj=document.estimateRegist;
		if(obj.checkyn.checked==true){
			obj.e_comp_nm.style.display='inline'
			obj.comp_nm.style.display="none";
			obj.comp_nm.value='';
			obj.comp_code.value='';
		}else{
			obj.e_comp_nm.style.display='none'
			obj.comp_nm.style.display="inline";
			
		}

	}
	
	/*�����Է� �÷��� �Ѱ��ֱ�.(����������Ȳ������ permit_no(����ڵ�Ϲ�ȣ��)�����Է� ��ü���� üũ�Ǵ��̰���������.)
	  ������ ���࿡���� Permit_no ���� �����Ƿ� ������ �÷��׷� �Ǵ��Ѵ�. (DB Colum �߰� COMP_FLAG)
	  2013_05_07(ȭ)shbyeon.
	*/
	
	
	
	<%-- ��ü�� �����Է��϶� �ߺ�üũ ���� �ϴ� ��ũ��Ʈ. 2013_05_07(ȭ)shbyeon.(���������)
	/*
	�����Է�üũ (�����Է� �϶��� ��ü�� �ߺ�üũ ��������� ����ϴ� function)
	2013_05_07(ȭ)shbyeon. �����Է� üũ ���������.
	function directInput(){

	    var obj=document.estimateRegist;
	    if(obj.checkyn.checked==true){
			
			if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
				obj.e_comp_nm.style.display='inline'
				obj.e_comp_nm_se.style.display='inline'
				obj.comp_nm.style.display="none";
				obj.comp_nm.value='';
				obj.comp_code.value='';
			}else{
				obj.checkyn.checked=false;
			}
		}else{
			if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
				obj.e_comp_nm.style.display='none'
				obj.e_comp_nm_se.style.display='none'
				obj.comp_nm.style.display="inline";
				obj.comp_code.value=''; //��ü�ڵ�
				obj.comp_nm.value='';   //��ü��ȸ ���ý� ��ü��
				obj.e_comp_nm.value=''; //�����Է� ���ý� ��ü��
			}else{
				obj.checkyn.checked=true;
			}
		}
	}
	*/
	
	 /*
	  * �ߺ�üũ(����) XML ��� 
	    2013_05_07(ȭ)shbyeon. ���� ��ü �ߺ�üũ ������.
	  */
	 function doCheck(e_comp_nm){
	 	
	 	var requestUrl='<%= request.getContextPath() %>/B_Common.do?cmd=CompNameCheckEs&e_comp_nm='+e_comp_nm;
	 	var result=0;
	 	
	 	var xmlhttp = null;
	 	var xmlObject = null;
	 	var resultText = null;


	 	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	 	xmlhttp.open("GET", requestUrl, false);
	 	xmlhttp.send(requestUrl);

	 	resultText = xmlhttp.responseText;

	 	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	 	xmlObject.loadXML(resultText);
	 	
	 	result=xmlObject.documentElement.childNodes.item(0).text;

	 	return result;
	 	
	 }
	
	/*��ü�ߺ�Ȯ�� check 2013_03_26(ȭ)shbyeon.
	   2013_05_07(ȭ)shbyeon. ���� ��ü�ߺ�üũ ������.(�� �ߺ�üũ DB SP�� 192.168.2.214 �� �״������.)
	 function fnDuplicateCheck() {
		
	 	var frm = document.estimateRegist; 
	 	
	 	
	 	if(frm.e_comp_nm.value.length == 0){
	 		alert("��ü���� �Է��ϼ���.");
	 		return;
	 	}
	 	
	 	var result= doCheck(frm.e_comp_nm.value);
	 	
	 	if(result==1){
	 		alert("�̹� ��ϵ� ��ü���Դϴ�. ��ü��ȸ�� ��ȸ �� �ش� ��üȮ�� �� �ٽ� �Է����ּ���.");
	 		
	 		if(alert){
	 			
	 		frm.e_comp_nm.focus();
	 		}
	 		
	 		return;
	 	}else {
	 		if( confirm("��� ������ ��ü�� �Դϴ�. ����Ͻðڽ��ϱ�?") ) {
	 			frm.trueflag.value  =  frm.e_comp_nm.value;
	 			//alert(frm.trueflag.value);
	 			frm.comp_code.value='';
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	*/
	
	��ü�� �����Է��϶� �ߺ�üũ ���� �ϴ� ��ũ��Ʈ.
	--%>
	
	
	/**
	 * ���� �̹���  ���� Ȯ���ڸ� üũ
	 *
	 **/
	function isExcelImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "xls" || ext == "xlsx" ) {
				return true;
			} else {
				return false;
			}
		}
	}
	/**
	 * PDF �̹���  ���� Ȯ���ڸ� üũ
	 *
	 **/
	function isPDFImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" ) {
				return true;
			} else {
				return false;
			}
		}
	}
	
	/*2013_05_07(ȭ)shbyeon. ���������.
	�ʱ�����Է� �� �� �� �ߺ�Ȯ�� ��ư ����.
	function chkNmButton(){
		var frm = document.estimateRegist; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			frm.e_comp_nm_se.style.display='none';
			//�ʱ� �����Է����� ��Ͻ�  �ʱ� ��ü�ڵ尪 ���� 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			frm.e_comp_nm_se.style.display='inline';
		}
	}
	*/
	
	/*2013_05_07(ȭ)shbyeon.
	    �ʱ�����Է� �� �� �� �Է�.
	*/
	function chkNm(){
		var frm = document.estimateRegist; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			//frm.e_comp_nm_se.style.display='none';
			//�ʱ� �����Է����� ��Ͻ�  �ʱ� ��ü�ڵ尪 ���� 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			//frm.e_comp_nm_se.style.display='inline';
		}
	}

	/*
	2013_11_27(��) shbyeon.
	��ù���/����������Ȳ/����� 
	�������� ���� Į�� hide&show
	*/
	function noneProjectColum(){		
		var chk = $("td#SalesChk input:checked").val();
		
		if(chk == "1"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').show();
			$('#hide_tr_pub').hide();
			$('[name=p_public_no]').val(''); //value �� ����� (������ȣ ��ȸ)
			$('[name=nowPubRegist]').val(''); //value �� ����� (��ù���)
			$('#sales_info').hide();
			return;
		}else if(chk == "2"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').hide();
			$('#hide_tr_pub').show();
			$('[name=PROJECT_PK_CODE]').val(''); //value �� ����� (����������Ȳ ��ȸ)
			$('[name=nowPubRegist]').val(''); //value �� ����� (��ù���)
			$('#sales_info').hide();
			return;
		}else if(chk == "3"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').hide();
			$('#hide_tr_pub').hide();
			$('[name=p_public_no]').val(''); //value �� ����� (������ȣ ��ȸ)
			$('[name=PROJECT_PK_CODE]').val(''); //value �� ����� (����������Ȳ ��ȸ)
			$('[name=nowPubRegist]').val('3'); //value �� ����� (��ù��� ��ȸ)
			$('#sales_info').show();
			return;
		}	

	}
	//���� ����(�������� ���)
	function indirectSalesChk(){	
		var frm = document.estimateRegist;
		var chk = frm.IndirectSaleschk.checked;
		
		if(chk == true){
			 $('#Indirect_info').show();
			 
		}else{
			 $('#Indirect_info').hide();
			 $('[name=Purchase]').val('');
			 $('[name=purchase_view]').val('0');
			 $('[name=Sales_profit]').val('');
			 $('[name=sales_profit_view]').val('0');
			 $('[name=Profit_percent]').val('');
			 $('[name=profit_percent_view]').val('0');
		}

	}
	
	
	//�ʱ� ����Ʈ ȭ���� ������ȣ �̱⶧���� 
	//����������Ȳ �ڵ� ��ȸ�� hide��Ų��. 2013_05_13(��)shbyeon.
	$(function(){
		$("#hide_tr_code").hide();	//����������Ȳ Į�� �ʱ� ������ ȣ�� �� hide
		$("#hide_tr_now").hide();	//��ù��� Į�� �ʱ� ������ ȣ�� �� hide
		$("#sales_info").hide();	//����������Ȳ Į�� �Է°� ����.
		$("#Indirect_info").hide(); //�������� ���� �� �������� �Է°� ����.
	})
	
	
	//JQuery - ��ǰ�ڵ� ���콺�� ������ �Ѱ��ֱ�.
	$(function() {
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  $('#NoCode').remove(); //��ǰ�ڵ� �߰� �� Cart<li>�� �ִ�  ��ǰ�ڵ带 �־��ּ���. text �����.
		      $(this).hide(); //��ǰ�ڵ� ���ý� �ش� ��ǰ�ڵ� hide �����.
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+"<a>"+$(this).html()+"</a>"+" <input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
		  
		  
		  });
		  
		  /* $('#cart ol li').on("dblclick", , function() {
			  alert('Success'); ������.
			});
			
		  $("#cart ol li").dblclick(function(){
			    //$(this).remove(); ������.
			    $('#products ol li').append("<li>"+$(this).html()+"</li>");
		  });
		  */
	});	 
	function delCode(chk){
		if( $( "#cart ol li" ).length == 1){
			$("#cart ol").append("<li id='NoCode' class='placeholder' style='color: red;'>��ǰ�ڵ带 �־��ּ���.</li>");
		}
		//alert($('#cart ol #'+chk).html()); hidden �������о� ������ �� alert
		$('#cart ol #'+chk).remove();
		$('#products #'+chk).show();
	}
	
	//�����ְ��� == ���� ���ϼ��� ��ư 2013_05_06(��)shbyeon.
	function chkSaOperatingAdd(){
		var frm = document.estimateRegist; 

		if(frm.comp_nm.value=='' && frm.e_comp_nm.value==''){
			alert('�����ְ��縦 �Է��ϼž� ��� �����մϴ�.');
			return ;
		}else{
			//�����Է� �϶�.
			if(frm.checkyn.checked==true){
				if(frm.chktest.checked==true){
		   		frm.OperatingCompany.value = frm.e_comp_nm.value;		
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
			//��ü��ȸ �϶�.
			if(frm.checkyn.checked==false){
				if(frm.chktest.checked==true){
				frm.OperatingCompany.value = frm.comp_nm.value;	
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
		}
}
	
	//��ȭ��ȣ ���� �Է½� üũ �� - ����
	 function MaskPhon( obj ) { 

	 	 obj.value =  PhonNumStr( obj.value ); //������ ������ PhonNumStr function ����.

	 } 



	//��ȭ��ȣ ���� �Է½� üũ �� - ����
	 function PhonNumStr( str ){ 

	 	 var RegNotNum  = /[^0-9]/g; 

	 	 var RegPhonNum = ""; 

	 	 var DataForm   = ""; 

	 	 // return blank     

	 	 if( str == "" || str == null ) return ""; 

	 	 // delete not number

	 	 str = str.replace(RegNotNum,'');    

	 	 if( str.length < 4 ) return str; 


	 	 if( str.length > 3 && str.length < 7 ) { 

	 	   	DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 7 ) {

	 		 DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})/; 

	 	 } else if(str.length == 9 ) {

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 10){ 

	 		 if(str.substring(0,2)=="02"){

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 

	 		 }else{

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;

	 		 }

	 	 } else if(str.length > 10){ 

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 

	 	 } 


	 	 while( RegPhonNum.test(str) ) {  

	 		 str = str.replace(RegPhonNum, DataForm);  

	 	 } 

	 	 return str; 

	 } 

	
	//���� �ݳ�/�ݿ� ������� �ڵ�����.
	 window.onload = function(){
	     var today = new Date();
	     var year = today.getFullYear();
	     var month = today.getMonth()+1;
	     if(month<10) month = "0" + month;

	     var target_year = document.getElementById('target_year');
	     var target_month = document.getElementById("target_month");
	     
	     for(var i=0; i<target_year.options.length; i++){
	         if(target_year.options[i].value==year){
	             target_year.options[i].selected = true;
	             break;
	         }
	     }
	     
	     for(var j=0; j<target_month.options.length; j++){
	         if(target_month.options[j].value==month){
	             target_month.options[j].selected = true;
	             break;
	         }
	     }
	 }
	 
	//���ⱸ�� üũ�ڽ� üũ(2013_11_20)
	function insert_SalesSortGb(){
		var frm = document.estimateRegist;
		var chklen = frm.SalesSortChk.length;
		var sales_sort = '';

			for(i=0; i<chklen; i++){
				if(frm.SalesSortChk[i].checked == true){
					sales_sort+='S0'+i+'|';		//S0 �ý��۸���, S1 ��ǰ ����, S2 �뿪 ����
				}
				frm.SalesSort.value = sales_sort;
			}
	}
	
	//�޷� �ؽ�Ʈ �Է�â ù��°.
	  function datepickerInputText1(){
		  var frm = document.estimateRegist;	//������
		  var inputDate1;									//������Ʈ ���� ������ �Է� �� ��������
		  var strY1;										//������Ʈ ���� ������ �Է� �� (-)�߶� �⵵�� ���
		  var strM1;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���
		  var strD1;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���
		  
		  inputDate1 = frm.estimate_dt.value; //������Ʈ ���� �����Ͽ� �ԷµǴ� ��/��/��
		  
		  if(inputDate1.length == 8){
			  inputDate = $('#calendarData1').val();	//������Ʈ ���� ������ input�� �Էµ� �� �ҷ�����.

			  strY1 = inputDate1.substr(0,4); //�Է� �⵵�� ������ ������ ���.
			  strM1 = inputDate1.substr(4,2); //�Է� ���ڸ� ������ ������ ���.
			  strD1 = inputDate1.substr(6,2); //�Է� ���ڸ� ������ ������ ���.
			 
			  frm.estimate_dt.value = strY1+'-'+strM1+'-'+strD1; //����Ʈ ��¥ �Ѱ� �ֱ����� ���� yyyy-mm-dd ���߱�.
		  }else if(event.keyCode == 8){
			  //alert('������Ʈ ���� �������� ��Ȯ�� �Է����ּ���.(ex1900-01-01)');
			  frm.estimate_dt.value=''; //�ؽ�Ʈ ��¥ �Է� ���� �� �ؽ�Ʈ �Է� â �ʱ�ȭ.
			  //alert(event.keyCode);
			  return;
		  }
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
<!-- contents -->
<div id="content">
  
  <!-- title -->
	<div class="content_navi">�������� &gt; ������<%=title%> &gt; ���������</div>
	<h3><span>��</span>�������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
  <!-- //title -->
  
  <!-- calendar -->
 
  <!-- //calendar -->
  
  <div class="con">
  	<!-- ���������� -->
	<div class="con_sub">
	<h4>����������</h4>
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
	
	</div>
	<!-- //������ ��� ���� -->
  	<form name="test" method="post">
  		<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
	      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
	      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
	      <input type = "hidden" name = "type" value="<%=type%>"/>
  	</form>
    <form name="estimateRegist" method="post" action="<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateRegist" enctype="multipart/form-data">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "type" value="<%=type%>"/>
      
      <input type = "hidden" name = "pYear1" value=""/>
      <input type = "hidden" name = "pMonth1" value=""/>
      <input type = "hidden" name = "pDay1" value=""/>
      
      <input type = "hidden" name = "comp_code" value=""/>
      <input type = "hidden" name = "permit_no" value=""/>
      <input type = "hidden" name = "owner_nm" value=""/>
      <input type = "hidden" name = "business" value=""/>
      <input type = "hidden" name = "b_item" value=""/>
      <input type = "hidden" name = "post" value=""/>
      <input type = "hidden" name = "address" value=""/>
      <input type = "hidden" name = "addr_detail" value=""/>
      <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
      <input type = "hidden" name = "user_id2" value="<%=dtoUser.getUserId()%>"/>
      <input type = "hidden" name = "sales_charge" value=""/>
      <!-- ��翵��(��) -->
      <input type = "hidden" name = "ChargeSecondID" value=""></input>
      <!-- ������ȣ ��ȸ �����Է� �ʱ� ��ü�� ��. -->
      <input type = "hidden" name = "e_comp_nm_ori" value=""/>
      <!-- ������ȣ ��ȸ �����Է� �ʱ� ��ü�ڵ� ��. -->
      <input type = "hidden" name = "comp_code_ori" value=""/>
       <!-- �ߺ�üũ �÷��� -->
      <input type="hidden" name="trueflag" value="true"></input>
      <input type="hidden" name="falseflag" value="false"></input>
      <!-- ����������Ȳ ���� �ڵ�� �� ���� ���� ���� ��� �� -->
      <input type="hidden" name="public_no_retry" value=""></input>
      <!-- span class="tbl_line_top">&nbsp;</span -->
      <!-- ���������� -->
		
	<fieldset>
		<legend>����������</legend>
	<table class="tbl_type" summary="����������(����ɼǼ���, ������Ȳ�ڵ��ȣ, ������ȣ, ���౸��, ��࿩��, ���ⱸ��, ��ǰ�ڵ�(�ڻ�/����), ��������, �����ݾ�, ��������ݾ�, ����������)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
      
      <tbody>
      	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ɼǼ���</label></th>
			<td id="SalesChk"><input type="radio" name="SalesChk" id="" class="radio md0" title="��ù���" value="3" onclick="javascirpt:noneProjectColum();"/><label for="">��ù���</label><input type="radio" name="SalesChk" id="" class="radio" title="����������Ȳ" value="1" onclick="javascirpt:noneProjectColum();"/><label for="">����������Ȳ</label><input type="radio" name="SalesChk" id="" class="radio" checked="checked" title="�� ����" value="2" onclick="javascirpt:noneProjectColum();"/><label for="">�� ����</label><br /><span class="guide_txt br">* <strong>��ù���</strong> : ��ù��� �� <strong>����������Ȳ ��� �� ���� ������ ����</strong>�� �����մϴ�.<br />*	<strong>����������Ȳ</strong>: ����������Ȳ �ڵ带 �����Ͽ� ���� ������ ������ �����մϴ�.<br />* <strong>�� ����</strong> : �� �����ȣ�� �����Ͽ� ��������� ���� �� ���� ������ ������ �����մϴ�.<br />(����������Ȳ�� ���Ե� ����������� ���� �� ����������Ȳ�� �ش�Ǵ� �� �����ȣ�� �����Ͽ� �����մϴ�.)</span></td>
		</tr>
		
		<tr id="hide_tr_now"><!-- ����ɼǿ��� ��ù��� ���� �� ���� -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ù���</label></th>
			<td><input type="text" id="nowPubRegist"  name="nowPubRegist"  class="text"  style="width:200px;" /><!-- value="3" =>��ù��� �÷��װ���. --><a href="searchPreSalesCode.html" class="btn_type03"><span>����������Ȳ��ȸ</span></a><span class="guide_txt">&nbsp;&nbsp;* ����������Ȳ �ɼ� ���� �� ���ϵ� ����������Ȳ �ڵ带 ���� �� �����ؾ��մϴ�.</span></td>
		</tr> 
        
		<tr id="hide_tr_code"><!-- ����ɼǿ��� ����������Ȳ ���� �� ���� -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������Ȳ�ڵ��ȣ</label></th>
			<td><input type="text" id="PROJECT_PK_CODE"  name="PROJECT_PK_CODE" class="text" title="������Ȳ�ڵ��ȣ" style="width:200px;" readOnly onClick="javascript:popProjectCode();"/><a href="javascript:popProjectCode();" class="btn_type03"><span>����������Ȳ��ȸ</span></a><span class="guide_txt">&nbsp;&nbsp;* ����������Ȳ �ɼ� ���� �� ���ϵ� ����������Ȳ �ڵ带 ���� �� �����ؾ��մϴ�.</span></td>
		</tr>
		
		<tr id="hide_tr_pub"><!-- ����ɼǿ��� ����� ���� �� ���� -->
			<th><label for="">������ȣ</label></th>
			<td><input type="text" id="" name="p_public_no" class="text" title="������ȣ" style="width:200px;" readOnly onClick="javascript:popPublicNo();"/><a href="javascript:popPublicNo();" class="btn_type03"><span>������ȣ��ȸ</span></a><span class="guide_txt">&nbsp;&nbsp;* �� �����ȣ�� �������� ���� �� <strong>���� �����ȣ</strong>�� �����˴ϴ�.</span></td>
		</tr>
		
		<tr>
			<th><label for="">���౸��</label></th>
			<td><input type="checkbox" id="" name="dpublicyn"  checked="checked" class="check md0" title="��������" /><label for="">��������</label><input type = "hidden" name = "d_public_yn" value=""/><input type="checkbox" id="" name="IndirectSaleschk" class="check" title="��������" onclick="javascript:indirectSalesChk();"/><label for="">��������</label><input type="hidden" name="IndirectSalesYN" value=""/><span class="guide_txt">&nbsp;&nbsp;* ���������̶�? <strong>End User(���� �����)���� ���� �������� �����ϰ� ��� ������ ��</strong>�� �ǹ��մϴ�.</span></td>
		</tr>
       
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��࿩��</label></th>
			<td><input type="radio" id="" class="radio md0" title="���" name="contract_yn"  value="Y"/><label for="">���</label><input type="radio" id="" class="radio" checked="checked" title="�̰��" name="contract_yn"  checked="checked"  value="N"/><label for="">�̰��</label></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ⱸ��</label></th>
			<td><input type="checkbox" id="sa1" name="SalesSortChk" class="check md0" title="�ý��۸���"  onclick="javascript:insert_SalesSortGb();"/><label for="">�ý��۸���</label><input type="checkbox" id="sa2" name="SalesSortChk" class="check" title="��ǰ����"  onclick="javascript:insert_SalesSortGb();"/><label for="">��ǰ����</label><input type="checkbox" id="sa3" name="SalesSortChk" class="check" title="�뿪����"  onclick="javascript:insert_SalesSortGb();"/><label for="">�뿪����</label><!-- ���� �Ѱ��� Param �� --><input type="hidden" name="SalesSort" value=""></input></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ǰ�ڵ�(�ڻ�/����)</label></th>
			<td class="prodCode">
					<div id="products" class="codeList">
						<h5>��ǰ�ڵ�(�ڻ�/����)</h5>
						<div id="catalog">
							<h6><a href="#none">�ڻ�(����)</a></h6><!-- �ڵ� Ȱ��ȭ : class="on" �߰� -->
							<ul>
										<%
				       						for(int x=0; x<codeList.size(); x++){
				       							ComCodeDTO codeDto = new ComCodeDTO();
				       							codeDto = (ComCodeDTO)codeList.get(x);
				       					%>
				       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
				       							</li>
				       					<%
				       						}
				       					%>
							</ul>
							
							<h6><a href="#none">���ڻ�(����)</a></h6>
							<ul>
								<%
		       						for(int x=0; x<codeList2.size(); x++){
		       							ComCodeDTO codeDto = new ComCodeDTO();
		       							codeDto = (ComCodeDTO)codeList2.get(x);
		       					%>
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
		       					<%
		       						}
		       					%>
						</ul>

						<h6><a href="#none">���ڻ�(����)</a></h6>
							<ul>
								<%
		       						for(int x=0; x<codeList3.size(); x++){
		       							ComCodeDTO codeDto = new ComCodeDTO();
		       							codeDto = (ComCodeDTO)codeList3.get(x);
		       					%>
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
		       					<%
		       						}
		       					%>
						</ul>
					</div>
			</div>
			
			<div id="cart">
				<h5>��ǰ�ڵ�</h5>
					<ol>
						<li class="placeholder" id="NoCode"><span>��ǰ�ڵ带 �־��ּ���.</span></li>
					</ol>
				</div>
			
			<div class="guide">
				<span class="guide_txt"><strong>* �ڻ��ǰ�ڵ� �Ǵ� ���ڻ�ǰ�ڵ� ���� �ϳ��� �������ּ���.</strong><br />
				* ��ǰ�ڵ� ��� ����� <strong>����Ŭ��</strong>�� �Ͽ� ������ �ش� ��ǰ�ڵ� �ڽ��� �߰� ��� �� ������ �����մϴ�.</span>
			</div>
			</td>
		</tr>
        <tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
							<td><span class="ico_calendar"><input id="calendarData1"value="<%=estimate_dt%>" class="text" name="estimate_dt" style="width:100px;"/></span><input type="hidden" class="in_txt"  style="width:80px" value=""/>
							</td>
		</tr>

       	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����ݾ�</label></th>
				<td class="listT">
					<input type="hidden" name="supply_price" class="in_txt"  style="width:80px" value="" />
		          	<input type="hidden" name="vat" class="in_txt"  style="width:80px" value="" />
		          	<input type="hidden" name="total_amt" class="in_txt"  style="width:80px" value="" />
					<table class="tbl_type" summary="�����ݾ�(���ް�, �ΰ���, �հ�)">
							
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
						<!-- <td><input type="text" id="" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal('estimateRegist.supply_price'),saleCntCal2()" value="0"/> ��</td> -->
						<td><input type="text" id="" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18"  onBlur = "saleCntCal('estimateRegist.supply_price'),saleCntCal2()" value="0" z-index=1/> ��</td>
						<th><label for="">�ΰ���</label></th>
						<!-- <td><input type="text" id="" name="vat_view" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('estimateRegist.vat')" value="0" z-index=2/> ��</td>  -->
						<td><input type="text" id="" name="vat_view" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" onBlur = "saleCntCal('estimateRegist.vat')" value="0" z-index=2/> ��</td>
						<th><label for="">�հ�</label></th>
						<td class="last"><input type="text" id="" name="total_amt_view" class="text text_r" title="�հ�" style="width:163px;" readOnly value="0"/> ��</td>
					</tr>
				
				</tbody>
					</table>
						</td>
							</tr>
			
			<input type="hidden" name="ESTIMATE_E_FILENM" value=""></input>
        	<input type="hidden" name="ESTIMATE_P_FILENM" value=""></input> 

				<tr id="Indirect_info"><!-- ���౸�п��� �������� ���� �� ���� -->
					<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������ݾ�</label></th>
						<td class="listT">
							<table class="tbl_type" summary="��������ݾ�(���Կ���(VAT����), ��������, ������)">
								
								<colgroup>
									<col width="11%" />
									<col width="22%" />
									<col width="11%" />
									<col width="22%" />
									<col width="11%" />
									<col width="*" />
								</colgroup>
										
						<tbody>
							
							<tr class="last" id="Indirect_info">
								<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
								<th><label for="">���Կ���<br />(VAT����)</label></th>
								<!-- <td><input type="text" id="" name="purchase_view" class="text text_r" title="���Կ���(VAT����)" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal2()" value="0" /> ��</td>  -->
								<td><input type="text" id="" name="purchase_view" class="text text_r" title="���Կ���(VAT����)" style="width:153px;" maxlength="18"  onBlur = "saleCntCal2()" value="0" /> ��</td>
								<th><label for="">��������</label></th>
								<td><input type="text" id="" name="sales_profit_view" class="text text_r dis" title="��������" style="width:153px;" maxlength="18"   value="0"/> ��</td>
								<th><label for="">������</label></th>
								<td class="last"><input type="text" name="profit_percent_view" id="" class="text text_r dis" title="������" style="width:161px;" value="0"/> %<input type="hidden" name="Purchase" class="in_txt"  style="width:80px" value="" /><input type="hidden" name="Sales_profit" class="in_txt"  style="width:80px" value="" /><input type="hidden" name="Profit_percent" class="in_txt"  style="width:80px" value="" /></td>
							</tr>
								
								</tbody>
							</table>
						</td>
					</tr>

			<tr>
				<th><label for="">����������</label></th>
					<td>
						<ul class="listD">
							<li class="first"><div class="fileUp">EXCEL&nbsp;&nbsp;<input type="text" class="text" id="file1" title="EXCEL" style="width:810px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="estimate_e_file" id="upload1" /></div></li>
							<li><div class="fileUp">PDF&nbsp;&nbsp;<input type="text" class="text" id="file2" title="PDF" style="margin-left:14px;width:810px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="estimate_p_file" id="upload2" /></div></li>
						</ul>
					</td>
				</tr>


				</tbody>
			</table>
		</fieldset>

	</div>
      <!-- //���������� -->
      
     <!-- ������ -->
    <div class="con_sub">
	<h4>������</h4>
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
					
	</div>
	<!-- //������ ��� ���� -->
		
	<!-- ��� -->
	<fieldset>
		<legend>������</legend>
				<table class="tbl_type" summary="������(������, ����, ��ü��)">
						
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>

		<tbody>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
				<td><input type="text" name="receiver" id="" class="text" title="������" style="width:200px;" maxlength="50"/></td>
			</tr>
							
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
				<td><input type="text" name="title" id="" class="text" title="����" style="width:917px;" maxlength="250"/></td>
			</tr>
        
			<tr>
				<th><label for="">��ü��</label></th>
				
					<td><input type="checkbox" name="checkyn" id="" class="check md0" title="�����Է�" onClick="javascript:directInput();"/><label for="">�����Է�</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="comp_nm" id="" class="text" title="��ü��" style="display:inline;width:300px;" readOnly/><input type="text" name="e_comp_nm" id="" class="text" title="��ü��" style="display:none;width:300px;" onkeyup="chkNm()"/><!-- 2013_05_07(ȭ)shbyeon. ���� ��ü�ߺ�üũ ������.(�ߺ��� �����Է� ��ü�� DB�� �� �� ���Ͼ�ü�������� ��ü�ڵ�(Comp_Code)pk �� �ٸ�.<a href="javascript:fnDuplicateCheck();"  class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="�ߺ�Ȯ��" width="52" height="18" /></a> --><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a></td>
			</tr>
          
          
						</tbody>
					</table>
				</fieldset>
      <!-- //������ -->
      </div>

	<!-- ��������� -->
	<div class="con_sub last">
		<h4>���������</h4>
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
					
	</div>
	<!-- //������ ��� ���� -->
	<!-- ��� -->
					
	<fieldset>
		<legend>���������</legend>
			<table class="tbl_type" summary="���������(�ۼ���, ��翵��, ���ְ��ɼ�, Ư�̻���)">
				
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>

 		<tbody>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ۼ���</label></th>
					<td><input type="text" id="" class="text" title="�ۼ���" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��翵��</label></th>
					<td><input type="text" id="" name="user_nm" class="text" title="��翵��" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>�����ȸ</span></a></td>
			</tr>     
     
 			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ְ��ɼ�</label></th>
					<td>
				         	 <%  
				          			  CodeParam codeParam = new CodeParam();
									  codeParam = new CodeParam();
									  codeParam.setType("select"); 
									  codeParam.setStyleClass("td3");
									  //codeParam.setFirst("��ü");
									  codeParam.setName("orderble");
									  codeParam.setSelected(""); 
									  //codeParam.setEvent("javascript:poductSet();"); 
									  out.print(CommonUtil.getCodeList(codeParam,"A03")); 
							  %>
					</td>
			</tr>
							
			<tr>
				<th><label for="">Ư�̻���</label></th>
					<td><textarea id="" name="etc" title="Ư�̻���" style="width:917px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
			</tr>
        
        
			</tbody>
		</table>
	</fieldset>
    </div>
    <!-- //��������� -->
     
	<!-- �����ְ������� - ����ɼǿ��� ��ù��� ���� �� ���� -->
	<div class="con_sub last last_display" id="sales_info">
		<h4>�����ְ�������</h4>
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
						
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
	
	</div>
	<!-- //������ ��� ���� -->
	<!-- ��� -->
	
	<fieldset>
		<legend>�����ְ�������</legend>
			<table class="tbl_type" summary="�����ְ�������(�����ְ�������, �����ְ������ڿ���ó, ����, ����о߹����η�, ����ñ�, ��翵��(��))">
				
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
     
		<tbody>
			
			<tr>
				<th><label for="">�����ְ�������</label></th>
				<td><input type="text" name="SalesMan" id="" class="text" title="�����ְ�������" style="width:200px;" maxlength="7"/></td>
			</tr>
							
			<tr>
				<th><label for="">�����ְ������ڿ���ó</label></th>
				<td><input type="text" id="" name="SalesManTel" maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="�����ְ������ڿ���ó" style="width:200px;" /></td>
			</tr>
        
 			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
				<td><input type="text" id="" name="OperatingCompany" class="text" title="����" style="width:300px;" maxlength="100"/><input type="checkbox" id="" name="chktest" value="N" class="check" title="��ü��(�����ְ���)�� ���ϼ���" onclick="javascript:chkSaOperatingAdd();"/><label for="">��ü��(�����ְ���)�� ���ϼ���</label></td>
			</tr>
							
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����о߹����η�</label></th>
				<td><input type="text" id="" name="AssignPerson" class="text" title="����о߹����η�" style="width:300px;" /></td>
			</tr>      
        
       		<tr>
       			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ñ�</label></th>
       			<input type="hidden" name="DateProjections" value=""></input>
          		<input type="hidden" name="Quarter" value=""></input>
          		
          		<td>
         			<script>
				         document.write("<select name='target_year' id='target_year' title='�⵵ ����' style='width:70px'>");
				          var now = new Date();  
				          var now_year = now.getFullYear() +5; //+1�� ���س⵵���� +1�� �Ѱ�. 
				          for (var i=now_year;i>=2010;i--) 
				          {   
				         document.write("<option value='"+i+"'>"+i+"</option>"); 
				         }  
				          document.write(" </select>"); 
			         </script> ��&nbsp;&nbsp;<select name="target_month" id="target_month" title="�� ����">
				    <option value='01'>1</option>
				    <option value='02'>2</option>
				    <option value='03'>3</option>
				    <option value='04'>4</option>
				    <option value='05'>5</option>
				    <option value='06'>6</option>
				    <option value='07'>7</option>
				    <option value='08'>8</option>
				    <option value='09'>9</option>
				    <option value='10'>10</option>
				    <option value='11'>11</option>
				    <option value='12'>12</option>
					</select> ��</td>
       	</tr>
       
	 		<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��翵��(��)</label></th>
					<td>
						<input type="text" id="" name="user_nm2" class="text" title="��翵��(��)" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales_Second();" class="btn_type03"><span>�����ȸ</span></a></td>
			</tr>         
							
			</tbody>
				</table>
					</fieldset>
      </div>
      <!-- //����������Ȳ ���� -->
   	</form>
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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

<%
if(type.equals("reg")){
%>
<%=comDao.getMenuAuth(menulist,"11")%>
<% 	
}else{
%>	
<%=comDao.getMenuAuth(menulist,"19")%>
<% 
}	
%>
<script type="text/javascript">fn_fileUpload();</script>