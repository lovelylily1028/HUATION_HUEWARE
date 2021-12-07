<%@page import="com.huation.framework.util.StringUtil"%>
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
<%@ page import="com.huation.common.currentstatus.CurrentStatusDTO" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%


	Map model = (Map)request.getAttribute("MODEL");

	EstimateDTO estimateDto = (EstimateDTO)model.get("estimateDto");
	
	//2013_04_29(��) shbyeon.
	//htSalesProductCode Table�� �ִ� ��ǰ�ڵ� �� ����������Ȳ�� ��ϵ� �ش�pk�� ProjectPk(code)
	//��ǰ�ڵ�� ���������࿡ ����ProjectPk(code) ��ǰ�ڵ�� ���� ����ϸ�, ����������Ȳ Ȥ�� ���������� ���� Update �Ǵ� ���� ������.
	CurrentStatusDTO csDtoPro = (CurrentStatusDTO)model.get("csDtoPro");	//����������Ȳ ��ǰ�ڵ�ArrDTO
	//������ ��ü ���� �� ������ ����� �� ����� ������.
	
	String curPage = (String)model.get("curPage");
	String public_no = (String)model.get("public_no");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String type = (String)model.get("type");
	String title = "";
	if(type.equals("reg")){
		title = "����";
	}else{
		title = "����(��ü)";
	}
	
	//��ǰ�ڵ� Arr �𵨷� ��ü�� ������ codeList��. 2013_04_29(��) shbyeon.
	ArrayList codeList = (ArrayList)model.get("codeList"); //�ڻ� ��ǰ�ڵ�
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //���ڻ�(����)��ǰ�ڵ�
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //���ڻ�(�ܼ�)��ǰ�ڵ�
	ArrayList productList = (ArrayList)model.get("productList"); //��ǰ�ڵ� Array List ������ �ִ� ������
	
	//���ⱸ�� |���� token��ü�� �߶� Arr ���·� ��������.(üũ�ڽ� üũȮ���� ����.)2013-11-20 shbyeon.
	String[] SalesSortList = StringUtil.getTokens(estimateDto.getSalesSort(), "|");

	String acheckd=""; //�ý��� ����
	String bcheckd=""; //��ǰ ����
	String ccheckd=""; //�뿪 ����

	for(int i=0;i<SalesSortList.length; i++){

		if(SalesSortList[i].equals("S00")){
			acheckd="checked";
		}else if(SalesSortList[i].equals("S01")){
			bcheckd="checked";
		}else if(SalesSortList[i].equals("S02")){
			ccheckd="checked";
		}
	}
	
	
	//������ �ʱ� ���� ��.
		String estimate_dt = "";

		
		if(estimateDto.getEstimate_dt().equals("")){
			estimate_dt = estimateDto.getEstimate_dt();
			estimate_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			estimate_dt = estimateDto.getEstimate_dt();
			String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = estimate_dt.substring(0,4);
		    strM_Val1 = estimate_dt.substring(4,6);
		    strD_Val1 = estimate_dt.substring(6,8);
			
		    estimate_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
		}
	
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������(����) ������</title>
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

	var frm = document.estimateVeiw; 
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
	
	if(frm.SalesSort.value == ""){
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
		

	/*2013_04_01(��) shbyeon. -> 2013_05_07(ȭ)shbyeon. ���� ������.
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
	
	//�ʱ� ��Ͻÿ��� DB�����Ͱ� ���� Nullüũ�� ���������� ���� �ÿ��� �������� ������� ���� 0�̶� ����Ʈ ���ڰ��� ���Ƿ� ���ڷ� üũ������Ѵ�.
	if(frm.IndirectSaleschk.checked == true){
		if(frm.Purchase.value == "" || frm.Sales_profit.value == "" || frm.Profit_percent.value == ""){
			alert("�������� üũ �� ��������ݾ׶� �� �ʼ��Է� �׸��Դϴ�.");
			return;
		}
		if(frm.Purchase.value == 0){
			alert("�������� üũ �� ��������ݾ׶� �� �ʼ��Է� �׸��Դϴ�.");
			return;
		}
	}
	 
	frm.sales_charge.value=frm.user_id.value;

	if(frm.sales_charge.value.length == 0){
		alert("��� ��������� ������ �ּ���");
		return;
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
	frm.sales_charge.value=frm.user_id.value;
	frm.estimate_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value; //��������

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	if(strFileName!=''){
		
		frm.ESTIMATE_E_FILENM.value = strFileName;
	}
	if(strFileName2!=''){
		
		frm.ESTIMATE_P_FILENM.value = strFileName2;
	}
		frm.submit();
}


	function cancle(){
	
	var frm = document.estimateVeiw;
	frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
	frm.submit();

	}

	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNo&sForm=estimateVeiw&contractGb=N","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}

	
	function popComp(){

		var obj=document.estimateVeiw;
		
		if(obj.checkyn.checked==true){
				alert('�����Է� ������ ������ ��ü��ȸ �Ͻñ� �ٶ��ϴ�.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=estimateVeiw","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
	}

	
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=estimateVeiw","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}

	
	function saleCntCal(form,gbun){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateVeiw;

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

		if(form=='estimateVeiw.supply_price'  && gbun!='1'){	
			var vat=parseInt(onlyNum(costobj.supply_price.value)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		    
		    
		}

		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		//v_obj.focus();

	}
	
	
	function saleCntCalInit(form,gbun){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateVeiw;
	
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
	
		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);
	
		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;
	
		v_obj.focus();
	
	}
	
	
	//���Կ��� ��� 2013-11-19(ȭ) shbyeon.
	function saleCntCal2(){
		
		var frm = document.estimateVeiw;
		var supply_price = frm.supply_price_view.value;		//���ް�(�����ݾ� VAT����)
		var purchase = frm.purchase_view.value; 				//���Կ���
		if(frm.supply_price_view.value == '0' || frm.supply_price_view.value.length < 1){
			alert("�����ݾ��� �ٸ��� �Է��ϼ���.");
			frm.Purchase.value="0";
			frm.purchase_view.value="0";
			frm.Sales_profit.value="0"
			frm.sales_profit_view.value="0"
			frm.supply_price_view.value="";
			frm.supply_price.value="";
			frm.supply_price_view.focus();
			return;
		}else{
			//1.(�����ݾ�[���ް�] - ���Կ���) = sales_profit(��������)
			var sales_profit = parseInt(onlyNum(supply_price))-parseInt(onlyNum(purchase));
			//2. �������� / �����ݾ�[���ް�] * 100 = profit_percent(������)
			var profit_percent = sales_profit/parseInt(onlyNum(purchase)) * 100;	
			//3.�����ݾ�[���ް�] ���� �ÿ��� �������� ���ó���� ���� �߰���.
			if(purchase == 0){
			//4.�����ݾ� �Է� �� �������� ����� ������ ������ �Ѱ��� Name ���� View ������ ��������.	

			}else{
			//5.�����ݾ�[���ް�] ���� �ÿ��� �������� ����.(toFixed(1) Ex:�Լ� �Ҽ��� ���� 1�ڸ��� ǥ����)
			frm.purchase_view.value=addCommaStr(''+onlyNum(purchase));	 			  //���Կ��� ���װ�.
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
					frm.supply_price_view.value="";
					frm.supply_price.value="";
					frm.supply_price_view.focus();
					return;
				}
			}
		}
	}

	
	
	/*�����Է�üũ(����)
	function directInput(){

	    var obj=document.estimateView;
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
	*/
	
	
	
	
	/*
	2013_05_07(ȭ)shbyeon.
	�����Է��϶� 
	*/
	function directInput(){

	    var obj=document.estimateVeiw;
	    if(obj.checkyn.checked==true){
			
			if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
				obj.e_comp_nm.style.display='inline'
				//obj.e_comp_nm_se.style.display='inline' //�ߺ�üũ ����Ҷ� �뵵
				obj.comp_nm.style.display="none";
				obj.comp_nm.value='';
				obj.comp_code.value='';
			}else{
				obj.checkyn.checked=false;
			}
		}else{

			if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
				obj.e_comp_nm.style.display='none'
				//obj.e_comp_nm_se.style.display='none' //�ߺ�üũ ����Ҷ� �뵵
				obj.comp_nm.style.display="inline";
				obj.comp_code.value=''; //��ü�ڵ�
				obj.comp_nm.value='';   //��ü��ȸ ���ý� ��ü��
				obj.e_comp_nm.value=''; //�����Է� ���ý� ��ü��
			}else{
				obj.checkyn.checked=true;
			}


		}

	}
	
	<%-- ��ü�� �����Է��϶� �ߺ�üũ ���� �ϴ� ��ũ��Ʈ. 2013_05_07(ȭ)shbyeon.(���������.)
	 /*
	  *	2013_05_07(ȭ)shbyeon.
	  * �ߺ�üũ(����) XML ��� ���������.
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
	
	//��ü�ߺ�Ȯ�� check 2013_05_07(ȭ)shbyeon. ���������.
	 function fnDuplicateCheck() {
		
	 	var frm = document.estimateVeiw; 
	 	
	 	
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
	 			alert(frm.trueflag.value);
	 			frm.comp_code.value='';
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	 
	 ��ü�� �����Է��϶� �ߺ�üũ ���� �ϴ� ��ũ��Ʈ. 2013_05_07(ȭ)shbyeon.
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
	
	/*�ʱ�����Է� �� �� �� �ߺ�Ȯ�� ��ư ����.2013_05_07(ȭ)  ���������. �ʿ���°ɷ� �ǴܵǸ� ������Ű��.
	function chkNmButton(){
		var frm = document.estimateVeiw; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			frm.e_comp_nm_se.style.display='none';
			//�ʱ� �����Է����� ��Ͻ�  �ʱ� ��ü�ڵ尪 ���� 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			frm.e_comp_nm_se.style.display='inline';
		}
	}
	
	//�ʱ�����Է� �� �� �� �Է� 2013_05_07(ȭ)
	function chkNm(){
		var frm = document.estimateVeiw; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			//�ʱ� �����Է����� ��Ͻ�  �ʱ� ��ü�ڵ尪 ���� 
			frm.comp_code.value=frm.comp_code_ori.value;
		}
	}
	*/

	
	function goList(){
		
		var frm = document.estimateVeiw;
		frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList2';
		frm.submit();

	}

	function goDelete(){
		
		var frm = document.estimateDeleteFrm;

		if(confirm("���� �Ͻðڽ��ϱ�?")){
			frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateDelete';
			frm.submit();
		}

	}
	
	//JQuery - ��ǰ�ڵ� ���콺�� ������ �Ѱ��ֱ�.
	$(function() {
		
		var cartLen = $('#cart ol li').length; //cart ol li ��ǰ�ڵ尡 ����� length ��������
		/*
		cart ol li �� map ��ü�� ��ǰ�ڵ� cart�� ����ִ� �ش� ��ǰ�ڵ带  test������ map ���·δ�´�.
		*/
		var test = $('#cart ol li').map(function(){ 
			return $(this).attr("id");
		});
		/*
		cartLen ��ǰ�ڵ尡 ����� ���� ������ ����ŭ x�� �������Ѽ� 
		���� ��ǰ�ڵ� ���(products) �ش� map(��ǰ�ڵ�) ��ŭ�����ͼ� �� ��ǰ����� hide �����ش�.
		*/
		for(var x=0; x<cartLen; x++){
			$('#products #'+test.get(x)).hide();
			//alert(test.get(x));	
		}
		
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  $('#NoCode').remove(); //��ǰ�ڵ� �߰� �� Cart<li>�� �ִ�  ��ǰ�ڵ带 �־��ּ���. text �����.
		      $(this).hide(); //��ǰ�ڵ� ���ý� �ش� ��ǰ�ڵ� hide �����.
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+$(this).html()+" <input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
		  
		  
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
	
	
	//���� ����(�������� ���) 2013-11-19(ȭ)shbyeon.
	function indirectSalesChk(){	
		var frm = document.estimateVeiw;
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
	 
	
	//���౸�� �������� ������ �ƴ� ���  hide��Ų��. 2013_11_19(ȭ)shbyeon.
	$(function(){
		var frm = document.estimateVeiw;
		if(frm.IndirectSaleschk.checked == false){			
		$("#Indirect_info").hide(); //�������� ���� �� �������� �Է°� ����.
		}else{
		$("#Indirect_info").show(); //�������� ���� �� �������� �Է°� ����.	
		}
	})
	
	
	//���ⱸ�� üũ�ڽ� üũ(2013_11_20)shbyeon.
	function insert_SalesSortGb(){
		var frm = document.estimateVeiw;
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
		  var frm = document.estimateVeiw;	//������
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
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="content">

		<!-- title -->
		<div class="content_navi">�������� &gt; ������<%=title%> &gt; ������������</div>
		<h3><span>��</span>����������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
		<!-- title -->
			
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
				
				<!-- calendar -->
				<div id="CalendarLayer" style="display:none; width:172px; height:176px; "><iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe></div>
				<!-- //calendar -->
				
				<!-- ������ ���� �� ȣ���ϴ� �� ����. -->
				<form name="estimateDeleteFrm" method="post">
					<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
					<input type = "hidden" name = "public_no" value="<%=estimateDto.getPublic_no()%>"/>
					<!-- �ش� �������� ���� ����������Ȳ PROJECT_PK_CODE == PreSalesCode -->
					<input type="hidden" name="PROJECT_PK_CODE" value="<%=estimateDto.getPROJECT_PK_CODE() %>"></input>
					<input type="hidden" name="ContractCode" value="<%=estimateDto.getContractCode()%>"/>
					<input type="hidden" name="contract_yn" value="<%=estimateDto.getContract_yn()%>"/>
				</form>
				<!-- ������ ���� �� ȣ���ϴ� �� ��. -->
				
				
				<form name="estimateVeiw" method="post" action="<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateEdit" enctype="multipart/form-data">
				
				<input type = "hidden" name = "pYear1" value=""/>
     			 <input type = "hidden" name = "pMonth1" value=""/>
     			 <input type = "hidden" name = "pDay1" value=""/>
				
				
				<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
				<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
				<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
				<input type = "hidden" name = "type" value="<%=type%>"/>
				
				<input type = "hidden" name = "public_no" value="<%=estimateDto.getPublic_no()%>"/>
				<input type = "hidden" name = "comp_code_re" value="<%=estimateDto.getComp_code()%>"/>
				<input type = "hidden" name = "comp_code" value="<%=estimateDto.getComp_code()%>"/>
				<input type = "hidden" name = "comp_code1" value="<%=estimateDto.getComp_nm()%>"/>
				<input type = "hidden" name = "owner_nm" value=""/>
				<input type = "hidden" name = "business" value=""/>
				<input type = "hidden" name = "b_item" value=""/>
				<input type = "hidden" name = "post" value=""/>
				<input type = "hidden" name = "address" value=""/>
				<input type = "hidden" name = "addr_detail" value=""/>
				<input type = "hidden" name = "permit_no" value=""/>
				<input type = "hidden" name = "user_id" value="<%=estimateDto.getSales_charge()%>"/>
				<input type = "hidden" name = "sales_charge" value="<%=estimateDto.getSales_charge()%>"/>
				<!-- ������ȣ ��ȸ �����Է� �ʱ� ��ü�� ��. -->
				<input type = "hidden" name = "e_comp_nm_ori" value=""/>
				<!-- ������ȣ ��ȸ �����Է� �ʱ� ��ü�ڵ� ��. -->
				<input type = "hidden" name = "comp_code_ori" value=""/>
				<!-- �ߺ�üũ �÷��� -->
				<input type="hidden" name="trueflag" value="true"></input>
				<input type="hidden" name="falseflag" value="false"></input>
				
				<!-- ���������� -->
				<fieldset>
					<legend>����������</legend>
					<table class="tbl_type" summary="����������(�����ȣ, ������ȣ, ������Ȳ�ڵ�, ���౸��, ��࿩��, ���ⱸ��, ��ǰ�ڵ�(�ڻ�/����), ��������, �����ݾ�, ����������)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="">�����ȣ</label></th>
							<!-- 2013_04_29(��) shbyeon. ����������Ȳ �޴��� ���� ������Ʈ�ڵ� �߰� �� ���� �̽��� ������. ���� ������ȣ ������ ��ȸ�� ��� �� ������ ����. ���� ����ϴ�(��������)����� �´ٰ� �Ǵ�.
							<input type="text" name="p_public_no" class="in_txt" style="width:100px" readonly value="<%=estimateDto.getP_public_no()%>" onclick="javascript:popPublicNo();">
							<a href="javascript:popPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_num2.gif'" width="85" height="18" title="������ȣ ��ȸ" /></a>
							<a href="javascript:delPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_del_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_del_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_del_num2.gif'" width="85" height="18" title="������ȣ ����" /></a></td>
							-->
							<td><input type="text" name="public_no" id="" class="text dis" title="�����ȣ" style="width:200px;" readonly value="<%=estimateDto.getPublic_no()%>"/></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">������ȣ</label></th>
							 <!-- 2013_04_29(��) shbyeon. ����������Ȳ �޴��� ���� ������Ʈ�ڵ� �߰� �� ���� �̽��� ������. ���� ������ȣ ������ ��ȸ�� ��� �� ������ ����. ���� ����ϴ�(��������)����� �´ٰ� �Ǵ�.
							 <input type="text" name="p_public_no" class="in_txt" style="width:100px" readonly value="<%=estimateDto.getP_public_no()%>" onclick="javascript:popPublicNo();">
							 <a href="javascript:popPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_num2.gif'" width="85" height="18" title="������ȣ ��ȸ" /></a>
							 <a href="javascript:delPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_del_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_del_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_del_num2.gif'" width="85" height="18" title="������ȣ ����" /></a></td>
							 -->
							 <td><input type="text" name="p_public_no" id="" class="text dis" title="������ȣ" style="width:200px;" readonly value="<%=estimateDto.getP_public_no()%>"/></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
						</tr>
						<tr>
							<th><label for="">������Ȳ�ڵ�</label></th>
							<td><input type="text" id=""  name="PROJECT_PK_CODE" class="text dis" title="������ȣ" style="width:200px;" value="<%=estimateDto.getPROJECT_PK_CODE() %>" readonly="readonly"/><br /><span class="guide_txt br">* <strong>������Ȳ �ڵ�</strong> : ����������Ȳ�� ���ϵ� ������ ������ �ǿ� ���� �ڵ���� ��Ÿ���ϴ�.<br />(��, ����������Ȳ�� ���ϵ� ������Ȳ �ڵ�� ������ �������� �ƴ� �ǿ� ���ؼ��� �ڵ尡 �������� �ʽ��ϴ�.)</span></td>
						</tr>
						<%
							String dpublicyn="chekced";
							String d_public_yn=StringUtil.nvl(estimateDto.getD_public_yn(),"");
							
							if(d_public_yn.equals("Y")){
								dpublicyn="checked";			
							}else{
								dpublicyn="";	
							}
							
							//�������� ���� 2013-11-19(ȭ)shbyeon.
							
							String IndirectSalescheck = "";
							String IndirectSalesYN = StringUtil.nvl(estimateDto.getIndirectSalesYN());
							
							if(IndirectSalesYN.equals("Y")){
								IndirectSalescheck="checked";
							}else{
								IndirectSalescheck="";
							}
						%>
						<%--
						2013-12-20 shbyeon. ������ �ڵ� ����(x)
						 <tr>
					      	<th>������ �ڵ�</th>
					      	<td colspan="6">
					      		<!-- �ش� �������� ���� ����������Ȳ ProjectPk == PreSalesCode ��. (���� Į���� ������ѻ���.) -->
					    			<input type="text" name="ContractCode" class="in_txt_off" style="width:100px" value="<%=estimateDto.getContractCode() %>" readonly="readonly"></input>
					    			</br>
					    		<font color="black">*������ �ڵ�:������ ���� �� ������� ������ ������ �ǿ� ���� �ڵ���� ��Ÿ���ϴ�.* 
					    		</br>(�� �̰������ ������ ������ �������� ������ �ڵ尡 ���� ���� �ʽ��ϴ�.)</font>
					      	</td>	
					      </tr>	
						--%>
						<tr>
							<th><label for="">���౸��</label></th>
							<td><input type="checkbox" id="" name="dpublicyn"  <%=dpublicyn%> class="check md0" title="��������" /><label for="">��������</label><input type = "hidden" name = "d_public_yn" value=""/><input type="checkbox" id="" name="IndirectSaleschk" value="<%=estimateDto.getIndirectSalesYN() %>" <%=IndirectSalescheck %> class="check" title="��������" onclick="javascript:indirectSalesChk();"/><label for="">��������</label><input type="hidden" name="IndirectSalesYN" value=""></input><span class="guide_txt">&nbsp;&nbsp;* ���������̶�? <strong>End User(���� �����)���� ���� �������� �����ϰ� ��� ������ ��</strong>�� �ǹ��մϴ�.</span></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��࿩��</label></th>
							<td>
								<% 
									if ((StringUtil.nvl(estimateDto.getContract_yn(), "")).equals("Y")) { 
								%>
									<input type="radio" id="" name="contract_yn" checked  value="Y" class="radio md0" title="���" /><label for="">���</label><input type="radio" id="" name="contract_yn" value="N" class="radio" title="�̰��" /><label for="">�̰��</label>
								<%
									} else {
								%>
									<input type="radio" id="" name="contract_yn" value="Y" class="radio md0" title="���" /><label for="">���</label><input type="radio" id="" name="contract_yn" value="N" checked  class="radio" title="�̰��" /><label for="">�̰��</label>
								<%
									}
								%>
							</td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ⱸ��</label></th>
							<td><input type="hidden" name="SalesSort" value="<%=estimateDto.getSalesSort()%>"></input><input type="checkbox" id="" name="SalesSortChk" class="check md0" <%=acheckd %> onclick="javascript:insert_SalesSortGb();" title="�ý��۸���" /><label for="">�ý��۸���</label><input type="checkbox" id="" name="SalesSortChk" class="check" <%=bcheckd %> onclick="javascript:insert_SalesSortGb();" title="��ǰ����" /><label for="">��ǰ����</label><input type="checkbox" id="" name="SalesSortChk" class="check" <%=ccheckd %> onclick="javascript:insert_SalesSortGb();" title="�뿪����" /><label for="">�뿪����</label></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ǰ�ڵ�(�ڻ�/����)</label></th>
							<td class="prodCode">
								<div id="products" class="codeList">
									<h5>��ǰ�ڵ�(�ڻ�/����)</h5>
									<div id="catalog">
										<h6><a href="#">�ڻ�(����)</a></h6>
										<ul>
											<%
												for(int x=0; x<codeList.size(); x++){
													ComCodeDTO codeDto = new ComCodeDTO();
													codeDto = (ComCodeDTO)codeList.get(x);
											%>
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
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
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
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
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
											<%
												}
											%>
										</ul>
									</div>
								</div>
								<div id="cart">
									<h5>��ǰ�ڵ�</h5>
									<ol>
										<%
											for(int x=0; x<productList.size(); x++){
												csDtoPro = new CurrentStatusDTO();
												csDtoPro = (CurrentStatusDTO)productList.get(x);
										%>
											<li id="<%=csDtoPro.getProductCode() %>" ondblclick="delCode('<%=csDtoPro.getProductCode() %>')" style="cursor: pointer;"><a><%=csDtoPro.getProductName() %></a><input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>"/></li>
										<%
											}
										%>
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
							<td><span class="ico_calendar"><input id="calendarData1"name="estimate_dt" class="text" style="width:100px;" value="<%=estimate_dt%>"/></span>
							<input type="hidden"  class="" style="width:100px" value="<%=estimateDto.getEstimate_dt()%>" /></td>
						</tr>

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����ݾ�</label></th>
							<td class="listT">
								<input type="hidden" name="supply_price" class="in_txt"  style="width:80px" value="<%=estimateDto.getSupply_price()%>" />
								<input type="hidden" name="vat" class="in_txt"  style="width:80px" value="<%=estimateDto.getVat()%>" />
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
										<%-- <td><input type="text" id="" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getSupply_price())%>" onkeyup = "saleCntCal('estimateVeiw.supply_price','2')"/> ��</td> --%>
										<td><input type="text" id="" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getSupply_price())%>" onBlur = "saleCntCal('estimateVeiw.supply_price','2')"/> ��</td>
										<th><label for="">�ΰ���</label></th>
										<%-- <td><input type="text" name="vat_view" id="" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getVat())%>" onkeyup = "saleCntCal('estimateVeiw.vat','2')"/> ��</td> --%>
										<td><input type="text" name="vat_view" id="" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getVat())%>" onBlur = "saleCntCal('estimateVeiw.vat','2')"/> ��</td>
										<th><label for="">�հ�</label></th>
										<td class="last"><input type="text" name="total_amt_view" id="" class="text text_r" title="�հ�" style="width:163px;" readonly/> ��</td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr id="Indirect_info">
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
										<%-- <td><input type="text" id="" name="purchase_view" class="text text_r" title="���Կ���(VAT����)" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal2()" value="<%=NumberUtil.getPriceFormat(estimateDto.getPurchase())%>" /> ��</td> --%>
										<td><input type="text" id="" name="purchase_view" class="text text_r" title="���Կ���(VAT����)" style="width:153px;" maxlength="18"  onBlur = "saleCntCal2()" value="<%=NumberUtil.getPriceFormat(estimateDto.getPurchase())%>" /> ��</td>
										<th><label for="">��������</label></th>
										<td><input type="text" id="" name="sales_profit_view" class="text text_r dis" title="��������" style="width:153px;" maxlength="18" readOnly  value="<%=NumberUtil.getPriceFormat(estimateDto.getSales_profit())%>"/> ��</td>
										<th><label for="">������</label></th>
										<td class="last"><input type="text" name="profit_percent_view" id="" class="text text_r dis" title="������" style="width:161px;" readOnly value="<%=estimateDto.getProfit_percent()%>"/> %<input type="hidden" name="Purchase" class="in_txt"  style="width:80px" value="<%=estimateDto.getPurchase()%>" /><input type="hidden" name="Sales_profit" class="in_txt"  style="width:80px" value="<%=estimateDto.getSales_profit()%>" /><input type="hidden" name="Profit_percent" class="in_txt"  style="width:80px" value="<%=estimateDto.getProfit_percent()%>" /></td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th><label for="">����������</label></th>
							<%
// 								String serverUrl = "//" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
								//String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
								String serverUrl = "" + request.getContextPath();
							  	String estimate_e_file=estimateDto.getEstimate_e_file();
							  	String estimate_p_file=estimateDto.getEstimate_p_file();
								
								int e_index=estimate_e_file.lastIndexOf("/");
								int p_index=estimate_p_file.lastIndexOf("/");
								
								String estimate_e_filename=estimate_e_file.substring(e_index+1);
								String estimate_p_filename=estimate_p_file.substring(p_index+1);
								
								String estimate_e_path="";               
								            String estimate_p_path="";
								            
								            if(!estimate_e_file.equals("")){
								            	estimate_e_path=estimate_e_file.substring(0,e_index);
								            }
								            
								            if(!estimate_p_file.equals("")){
								            	estimate_p_path=estimate_p_file.substring(0,p_index);
								            }
							%>
							<input type="hidden" name="ESTIMATE_E_FILENM" value="<%=estimateDto.getESTIMATE_E_FILENM()%>"></input>
							<input type="hidden" name="ESTIMATE_P_FILENM" value="<%=estimateDto.getESTIMATE_P_FILENM()%>"></input>
							<td>
								<ul class="listD">
									<li class="first"><div class="fileUp">EXCEL&nbsp;&nbsp;<input type="text" class="text" id="file1" title="EXCEL" style="width:715px;" value="<%=estimateDto.getEstimate_e_file() %>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="estimate_e_file" id="upload1" /></div><% if(!estimateDto.getEstimate_e_file().equals("")){ %><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_e_filename%>&sFileName=<%=estimate_e_filename%>&filePath=<%=estimate_e_path%>" class="btn_type03"><span id="p_estimate_e_file_t">�������ٿ�ε�</span></a><!-- 2013_05_15(��)shbyeon. ��������������. &nbsp;|&nbsp;<a href="javascript:fileDel('p_estimate_e_file');"><span id="p_estimate_e_file_d">����</span></a> --><% } %><input type="hidden" name="p_estimate_e_file" value="<%=estimateDto.getEstimate_e_file()%>"/></li>
									<li><div class="fileUp">PDF&nbsp;&nbsp;<input type="text" class="text" id="file2" title="PDF" style="margin-left:14px;width:715px;" value="<%=estimateDto.getEstimate_p_file() %>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="estimate_p_file" id="upload2" /></div><% if(!estimateDto.getEstimate_p_file().equals("")){ %><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_p_filename%>&sFileName=<%=estimate_p_filename%>&filePath=<%=estimate_p_path%>" class="btn_type03"><span id="p_estimate_p_file_t">�������ٿ�ε�</span></a><!-- 2013_05_15(��)shbyeon. ��������������. &nbsp;|&nbsp;<a href="javascript:fileDel('p_estimate_p_file');"><span id="p_estimate_p_file_d">����</span></a> --><% } %><input type="hidden" name="p_estimate_p_file" value="<%=estimateDto.getEstimate_p_file()%>" /></li>
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
						<%
							/* ���� comp_code ���� �����Է½ÿ� ����ߴ� check ���� ����� ������. 
							       		2013_03_29(��) shbyeon.
							       		
							String comp_code=StringUtil.nvl(estimateDto.getComp_code(),"");
							String checkedyn="";
							String acomp="inline";
							String bcomp="none";
							
							if(!comp_code.equals("")){
								checkedyn="";
							                acomp="inline";
								bcomp="none";
							}else{
								checkedyn="checked";
							                acomp="none";
								bcomp="inline";
							}
							       */
						%>
							
						<%
							//�����Է� üũ �κ� 2013_05_09(��)shbyeon.
							
							String comp_code=StringUtil.nvl(estimateDto.getComp_code(),"");
							        	System.out.println("comp_code:"+comp_code);
							String checkedyn="";
							String acomp="inline";
							String bcomp="none";
							
							if(comp_code != ""){
								checkedyn="";
							                acomp="inline";
								bcomp="none";
							}else{
								checkedyn="checked";
							                acomp="none";
								bcomp="inline";
							}
						%>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
							<td><input type="text" name="receiver" id="" class="text" title="������" style="width:200px;" maxlength="50" value="<%=estimateDto.getReceiver()%>"/></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
							<td><input type="text" name="title" id="" class="text" title="����" style="width:917px;" maxlength="250" value="<%=estimateDto.getTitle()%>"/></td>
						</tr>
						<tr>
							<th><label for="">��ü��</label></th>
							<td><input type="checkbox" id="" name="checkyn" <%=checkedyn%> class="check md0" title="�����Է�" onclick="javascript:directInput();" /><label for="">�����Է�</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="" name="comp_nm" class="text" title="��ü��" style="display:<%=acomp %>;width:300px;" readonly value="<%=estimateDto.getE_comp_nm()%>"/><input type="text" id="" name="e_comp_nm" class="text" title="��ü��" style="display:<%=bcomp %>;width:300px;" value="<%=estimateDto.getE_comp_nm()%>" /><!-- 2013_05_07(ȭ)shbyeon. ���� �ߺ�üũ ������. <a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="�ߺ�Ȯ��" width="52" height="18" /></a>	--><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
			</div>
			<!-- //������ -->
			<!-- ��������� -->
			<div class="con_sub last">
				<h4>���������</h4>
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
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
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ۼ���</label></th>
							<td><input type="text" id="" class="text" title="�ۼ���" style="width:200px;" readonly value="<%=estimateDto.getReg_nm()%>"/></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��翵��</label></th>
							<td><input type="text" name="user_nm" id="" class="text" title="��翵��" style="width:200px;" readonly value="<%=estimateDto.getSales_charge_nm()%>"/><a href="javascript:popSales();" class="btn_type03"><span>�����ȸ</span></a></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ְ��ɼ�</label></th>
							<td><%
								CodeParam codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("td3");
								//codeParam.setFirst("��ü");
								codeParam.setName("orderble");
								codeParam.setSelected(estimateDto.getOrderble()); 
								//codeParam.setEvent("javascript:poductSet();"); 
								out.print(CommonUtil.getCodeList(codeParam,"A03")); 
							%></td>
						</tr>
						<tr>
							<th><label for="">Ư�̻���</label></th>
							<td><textarea id="" name="etc" title="Ư�̻���" style="width:917px;height:41px;" onkeyup="js_Str_ChkSub('500', this)" ><%=estimateDto.getEtc()%></textarea></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
			</div>
			<!-- //��������� -->
			<!-- Bottom ��ư���� -->
			<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
			<!-- //Bottom ��ư���� -->
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
<script>
saleCntCalInit('estimateVeiw.supply_price','1');
</script>
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