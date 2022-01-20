<%@ page contentType="text/html; charset=euc-kr"%>
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
	String strDate = (String)model.get("strDate");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݰ�꼭 ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">





<!--
function goSave(){
	var frm = document.invoiceRegist; 
	
	
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

	
	frm.pre_deposit_dt.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;//�Աݿ�������
	
	var dates = frm.deposit_dt.value;
	var deposit_dts = dates.replace(/-/g,'');
	frm.pYear3.value = deposit_dts.substr(0,4);
	frm.pMonth3.value = deposit_dts.substr(4,2);
	frm.pDay3.value = deposit_dts.substr(6,2);
	
	frm.deposit_dt.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;//�Ա�����
	
	
	/*
	2013_05_13(��)shbyeon. ����� ��û���� ���� ������.
	description:���ݰ�꼭 ������ ��� ������ �����ȣ�� productno ��ǰ�ڵ带 ������ DB�� �־�����.
	����� ��û�������� �ʿ���� �κ��̶� �ּ����� ���� ������ null������ ó����.
	if(frm.productno.value.length == 0){
		alert("���õ� �������� ��ǰ��ȣ�� �����ϴ�. \n �ش� �������� ��ǰ��ȣ�� �����ڸ� ���� Ȯ���ϼ���");
		return;

	}
	*/
	
	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.inverseregist.value;
	
	
	var lastIndex = strFile.lastIndexOf('\\');


	var strFileName = strFile.substring(lastIndex+1);
	

	if(fileCheckNm(strFileName)> 200){
		alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
		return;
	}
	
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

	if(frm.p_public_no.value.length == 0){
		alert("������ �����ȣ�� �Է��ϼ���!");
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

	if(frm.deposit_amt.value!= 0 && frm.deposit_dt.value.length != 0){
		frm.state.value='03';
	}else{
		frm.state.value='01';
	}
	frm.issuetype.value='03';	
	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.public_no.value=frm.p_public_no.value;
	
	frm.inverseregistNm.value = strFileName;
	


	frm.submit();
}

function cancle(){
	
	var frm = document.invoiceRegist;
	frm.action='<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
	frm.submit();

}
function popContractNo(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro&sForm=invoiceRegist&contractGb=Y","","width=1400,height=750,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}


function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY&sForm=invoiceRegist&contractGb=Y","","width=850,height=683,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}
function popComp(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_Ic&sForm=invoiceRegist","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
function saleCntCal(form){

	    var v_obj;
		var obj;
		
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		
		
		var costobj=document.invoiceRegist;
		
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

		if(form=='invoiceRegist.supply_price'){	
			var vat=parseInt(parseInt(costobj.supply_price.value,10)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		}

		var tcost=parseInt(costobj.supply_price.value,10)+parseInt(costobj.vat.value,10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		v_obj.focus();

	}
	function poductSet(){
	  alert(document.invoiceRegist.productno[0].value);
		
	}
	
function searchZipCode() {
		var name = "�����ȣ�˻�";
		var features = "width=450,height=445,scrollbars=yes,top=100,left=100,status";
		var popupWin = window.open("", name, features);
		document.postForm.target=name;
		document.postForm.submit();
		centerSubWindow(popupWin, 450, 445);
		popupWin.focus();
}
function searchZipCode2() {
	var name = "�����ȣ�˻�";
	var features = "width=450,height=445,scrollbars=yes,top=100,left=100,status";
	var popupWin = window.open("", name, features);
	document.postForm2.target=name;
	document.postForm2.submit();
	centerSubWindow(popupWin, 450, 445);
	popupWin.focus();
}

function centerSubWindow(winName, ww, wh){
        if (document.layers) {
            sw = screen.availWidth;
            sh = screen.availHeight;
        }
        if (document.all) {
            sw = screen.width;
            sh = screen.height;
        }

        w = (sw - ww)/2;
        h = (sh - wh)/2;
        winName.moveTo(w,h);
}   
	
//�ּ� �˻����� ����.
function addressWhereCheck(){
	 var chk = $("#adrChk_tr input:checked").val();
	 //alert(chk);
	 
	 if(chk == "1"){
		 $('#NewAddress').show();		//���θ� �����ȣ �˻� Show
		 $('#OriAddress').hide();		//���� �ּ� �����ȣ �˻� hide
	 }else{
		 $('#NewAddress').hide();		//���θ� �����ȣ �˻� hide
		 $('#OriAddress').show();		//���� �ּ� �����ȣ �˻� Show
	 }
}

//������ �ʱ� �ε� �� ȣ��.
$(function(){
		//���� �����ȣ �˻� a�±� hide
		$('#OriAddress').hide();
});
	
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <!-- title -->
<div class="content_navi">�������� &gt; (��)���ݰ�꼭���</div>
			<h3><span>(��)</span>���ݰ�꼭���</h3>
  <!-- //title -->





<!--���θ� �����ȣ ��-->
  <form name="postForm" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
    <input type = "hidden" name = "pForm" value="invoiceRegist">
    <!--���õ� ����-->
    <input type = "hidden" name = "pZip" value="post">
    <!--���õ� �����ȣ-->
    <input type = "hidden" name = "pAddr" value="address">
    <!--���õ� �ּ�-->
  </form>
  <!--���θ� �����ȣ ��-->
<!--���� �ּ� �����ȣ ��-->
  <form name="postForm2" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost2">
    <input type = "hidden" name = "pForm" value="invoiceRegist">
    <!--���õ� ����-->
    <input type = "hidden" name = "pZip" value="post">
    <!--���õ� �����ȣ-->
    <input type = "hidden" name = "pAddr" value="address">
    <!--���õ� �ּ�-->
  </form>
<!--���� �ּ� �����ȣ ��-->  






<%-- 
  <!-- calendar -->
  <div id="CalendarLayer" style="display:none; width:172px; height:176px; ">
    <iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe>
  </div>
  <!-- //calendar -->
  
   --%>
  
  
  <!-- con -->
  <div id="excelBody" class="con">
  <div class="conTop_area">
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
	</div>
    <form name="invoiceRegist" method="post" action="<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=inverseRegist" enctype="multipart/form-data">
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

      <table class="tbl_type" summary="(��)���ݰ�꼭���(�����������ȣ(�����ȣ, ����), ��꼭�ݾ�(���ް�, �ΰ���, �հ�), ����(���ι�ȣ, ����(����)��), ��������, ���ڼ��ݰ�꼭������, ���޹޴���(��ȣ(���θ�), ����, ����, ��ǥ�ڸ�, ����������), �Աݿ�������, �Աݿ������, �Աݱݾ�, �Ա�����, �������)">
        <caption>���ݰ�꼭 ����</caption>
       <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		
		
	<tbody>
	<tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������ȣ</label></th>
          <td><input type="text" name="contract_no" class="text" value=""  style="width:200px;" readOnly onClick="javascript:popContractNo();"/><a href="javascript:popContractNo();" class="btn_type03"><span>�����ȣ��ȸ</span></a></td>
     </tr>	
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����������ȣ</label></th>
          <td class="listT">
            <%-- <a href="#" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_num.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_num_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_num.gif'" value="�����ȣ" onclick="javascript:popPublicNo();" width="60" height="18" title="�����ȣã��" /></a> --%>  
             <table class="tbl_type" summary="�����������ȣ(�����ȣ, ����)">
             <colgroup>
				<col width="33%" />
				<col width="11%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr class="last">
			<td><input type="text" name="p_public_no" class="text"  title="�����ȣ" style="width:200px;" readOnly onClick="javascript:popPublicNo();" /></td>
			<th><label for="">����</label></th>
              <td class="last"><input type="text" name="title" class="text dis" style="width:495px;"  readOnly value="" />  
             </td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��꼭�ݾ�</label></th>
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
			<td>
				<input type="hidden" name="supply_price" class="text text_r"  style="width:80px" value="" />
	            <input type="hidden" name="vat" class="text text_r"  style="width:80px" value="" />
	            <input type="hidden" name="total_amt" class="text text_r"  style="width:80px" value="" />
	            <input type="text" name="supply_price_view" class="text text_r" title="���ް�" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('invoiceRegist.supply_price')" value="0" /> ��</td>
			<th><label for="">�ΰ���</label></th>
			<td><input type="text" id="" name="vat_view" class="text text_r" title="�ΰ���" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('invoiceRegist.vat')" value="0"/> ��</td>
			<th><label for="">�հ�</label></th>
			<td class="last"><input type="text" id="" name="total_amt_view" class="text text_r" title="�հ�" style="width:163px;" readOnly value="0" /> ��</td>
		</tr>
		</tbody>
		</table>
        </tr>
        <input type = "hidden" name = "productno" value="">
        <!--tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>��ǰ��</td>
				<td><%
							//CodeParam codeParam = new CodeParam();
							//codeParam.setType("select"); 
							//codeParam.setStyleClass("td3");
							//codeParam.setFirst("��ü");
							//codeParam.setName("productno");
							//codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							//out.print(CommonUtil.getCodeList(codeParam,"A02")); 
						%></td>
			</tr-->
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
          <td class="listT">
          <table class="tbl_type" summary="����(���ι�ȣ, ����(����)��)">
          	<colgroup>
				<col width="11%" />
				<col width="22%" />
				<col width="11%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr class="last">
        		<th><label for="">���ι�ȣ</label></th>
	          <td><input type="text" name="approve_no" class="text" title="���ι�ȣ" style="width:168px;" maxlength="50" /></td>
	          <th><label for="">����(����)��</label></th>
	          <td class="last"><input type="text" name="receiver" class="text" title="����(����)��" style="width:200px;" maxlength="10" /></td>
	        </tr>
	        </tbody>
	        </table>
	        </td>
	    </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td>
            <span class="ico_calendar"><input id="calendarData1" name="public_dt" class="text" style="width:100px;" value="<%=strDate%>"/></span><input type="hidden" class="text"  style="width:80px" value="" />
          </td>
        </tr>
        <tr>
          <th><label for="">���ڼ��ݰ�꼭������</label></th>
          <td><input type="text" name="public_org" class="text" title="���ڼ��ݰ�꼭������" style="width:300px;" maxlength="25"></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���޹޴���</label></th>
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
          <td><input type="text" name="comp_nm" class="text" title="��ȣ(���θ�)" style="width:103px;" readOnly onClick="javascript:popComp();" value="" /><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a></td>
          <th><label for="">����</label></th>
          <td><input type="text" name="business" class="text" title="����" style="width:168px;" value=""  readOnly /></td>
          <th><label for="">����</label></th>
          <td class="last"><input type="text" name="b_item" class="text" title="����" style="width:178px;" value=""  readOnly /></td>
        </tr>
        <tr id="adrChk_tr" class="last">
          <th><label for="">��ǥ�ڸ�</label></th>
          <td><input type="text" name="owner_nm" class="text" title="��ǥ�ڸ�" style="width:168px;" value=""  readOnly /></td>
          <th><label for="">����������</label></th>
          <td colspan="3" class="last">
          <ul class="listD">
            <li class="first"><input type="text" name="post" class="text" title="�����ȣ" style="width:80px;" value=""  readOnly /><a id="NewAddress" href="javascript:searchZipCode();" class="btn_type03"><span>�����ȣ</span></a><a id="OriAddress" href="javascript:searchZipCode2();" class="btn_type03"><span>�����ȣ</span></a><!-- �����ȣ ����. --><input type="radio" class="radio" id="adrChk" name="adrChk" value="1" checked="checked" onclick="javascript:addressWhereCheck();" /><label for="">���θ����� ã��</label><input type="radio" class="radio" id="adrChk" name="adrChk" value="2" onclick="javascript:addressWhereCheck();" /><label for="">���� �ּҷ� ã��</label></li>
            <li><input type="text" name="address" class="text" title="�⺻�ּ�" style="width:239px;" value=""  readOnly /> <input type="text" name="addr_detail" class="text" title="���ּ�" style="width:239px;" value=""  readOnly /></li>
            </ul>
            </td>
            </tr>
            </tbody>
            </table>
            </td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ�������</label></th>
           <td><span class="ico_calendar"><input id="calendarData2" name="pre_deposit_dt"  class="text" style="width:100px;"/></span><input type="hidden" class="text"  style="width:100px" /></td>
        </tr>
         <tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Աݿ������</label></th>
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("��ü");
							codeParam.setName("pre_deposit_an");
							codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeListHanSeqq(codeParam,"BankAC")); 
						%></td>
				 
         		</tr>
 
                 
        <tr>
          <th><label for="">�Աݱݾ�</label></th>
         <td><input type="hidden" name="deposit_amt" class="in_txt"  style="width:80px" value="0" /><input type="text" id="" name="deposit_amt_view" class="text" title="�Աݱݾ�" style="width:200px;" maxlength="18"  onKeyUp = "saleCntCal('invoiceRegist.deposit_amt')" value="0"/> ��<span class="guide_txt">&nbsp;&nbsp;* �Աݱݾ� �Է� �� �Ա����ڴ� �ʼ� �Է� �׸��Դϴ�.</span></td>
        </tr>
        <tr>
          <th><label for="">�Ա�����</label></th>
            <td><span class="ico_calendar"><input id="calendarData3" name="deposit_dt" class="text" style="width:100px;"/></span><input type="hidden" class="text"  style="width:100px" value="<%=( String )model.get("curDate")%>"/></td>
		</tr>
        <tr>
          <th><label for="">���ݰ�꼭</label></th>
          <td>
          	<input type="hidden" name="inverseregistNm" value=""></input><div class="fileUp"><input type="text" class="text" id="file1" title="���ݰ�꼭" style="width:566px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="inverseregist" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* ÷�ΰ��� �������� : ���� ���� / ÷�ΰ��� �뷮 : �ִ� 20M</span></td>
        </tr>
        <tr>
          <th><label for="">�������</label></th>
          <td><textarea name="reference" class="text" title="�������" style="width:917px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
    </form>
<!-- ���̵��ؽ�Ʈ -->
<p class="guide_txt">��ü ����� �Ǿ� ���� ������ ���ݰ�꼭�� ���� �� �� �����ϴ�. ����ڵ���� �� ����纻 ���� �� ��ü�� ����Ͻʽÿ�.</p>
<!-- //���̵��ؽ�Ʈ -->
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
<%= comDao.getMenuAuth(menulist,"17") %>
<script type="text/javascript">fn_fileUpload();</script>