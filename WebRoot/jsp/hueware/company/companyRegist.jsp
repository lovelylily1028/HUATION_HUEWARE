<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String sForm =  (String)model.get("sForm");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>

<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>

<title>��ü ���</title>
<script>

<!--
function goSave(){
	var frm = document.companyRegist; 

    frm.comp_no.value=frm.comp_no1.value+'-'+frm.comp_no2.value;
	
	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.comp_file.value;
	var strFile2 = frm.account_copy1.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);

	var lastIndex2 = strFile2.lastIndexOf('\\');
	var strFileName2 = strFile2.substring(lastIndex+1);
	
	if(fileCheckNm(strFileName)> 200){
		alert('[����ڵ����]�� (���ϸ�)��/�� 200��(byte)�̻��� ���ڸ�  ��� �� �� �����ϴ�.');
		return;
	}
	if(fileCheckNm(strFileName2)> 200){
		alert('[����-�纻1]�� (���ϸ�)��/��  200��(byte)�̻��� ���ڸ� ��� �� �� �����ϴ�.');
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
	
  
	if(frm.permit_no.value.length == 0){
		alert("����� ��Ϲ�ȣ�� �Է��ϼ���!");
		return;
	}

	if(frm.comp_nm.value.length == 0){
		alert("��ȣ(���θ�)�� �Է��ϼ���!");
		return;
	}
	if(frm.comp_no1.value.length == 0 || frm.comp_no2.value.length == 0){
		alert("���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)��  �Է��ϼ���!");
		return;
	}
	if(frm.owner_nm.value.length == 0){
		alert("��ǥ�ڸ���  �Է��ϼ���!");
		return;
	}
	if(frm.business.value.length == 0){
		alert("���¸�  �Է��ϼ���!");
		return;business
	}
	if(frm.b_item.value.length == 0){
		alert("������  �Է��ϼ���!");
		return;business
	}
		if(frm.post.value.length == 0){
		alert("���� ��������  �Է��ϼ���!");
		return;business
	}
	
	if(frm.comp_file.value != "" && !isImageFile(frm.comp_file.value)){
			alert("����� �������  ÷�� ������ ���� ������ \n PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
	if(frm.account_copy1.value != "" && !isImageFile(frm.account_copy1.value)){
			alert(" ����纻1�� ÷�� ������ ���� ������ PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
	if(frm.account_copy2.value != "" && !isImageFile(frm.account_copy2.value)){
			alert(" ����纻2�� ÷�� ������ ���� ������ PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
	if(frm.account_copy3.value != "" && !isImageFile(frm.account_copy3.value)){
			alert(" ����纻3�� ÷�� ������ ���� ������ PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
	if(frm.account_copy4.value != "" && !isImageFile(frm.account_copy4.value)){
			alert(" ����纻4�� ÷�� ������ ���� ������ PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
	if(frm.account_copy5.value != "" && !isImageFile(frm.account_copy5.value)){
			alert(" ����纻5�� ÷�� ������ ���� ������ PDF, GIF, JPG, TIF, BMP, PNG �̻� 6�� �Դϴ�.");
			return; 				
	}
	
		frm.open_dt.value = $("#calendarData1").val().replace(/-/g,'');//frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		
		var dates = frm.open_dt.value;

		frm.pYear1.value = dates.substr(0,4);
		frm.pMonth1.value = dates.substr(4,2);
		frm.pDay1.value = dates.substr(6,2);
		
		
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
		frm.COMPANY_FILENM.value = strFileName;
		frm.ACCOUNT_COPYNM1.value = strFileName2;
		frm.submit();
	}

	function cancle(){
		
		var frm = document.companyRegist;
	
		if(frm.sForm.value=='N'){
			frm.action='<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
		}
		frm.submit();
	
	}
	
	//���θ� �˻�.
	function searchZipCode() {
			var name = "�����ȣ�˻�";
			var features = "width=450,height=445,scrollbars=yes,top=100,left=100,status";
			var popupWin = window.open("", name, features);
			document.postForm.target=name;
			document.postForm.submit();
			centerSubWindow(popupWin, 450, 445);
			popupWin.focus();
	}
	
	//���� �ּҷ� �˻�.
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
	function popCompNo(){
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo&sForm=companyRegist","","width=400,height=500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	function compNocheck(form){
		   
		   var frm=document.companyRegist;
		   var obj=eval("document."+form);
		   var comp1=frm.comp_no1;
		   var comp2=frm.comp_no2;
		   var comp=frm.comp_no.value;
		   if(obj.value.length>0){
				if (!isNumber(trim(obj.value))) {
					alert("���ڸ� �Է��� �ּ���.");
					obj.value=onlyNum(obj.value);
				} 
		   }
	        
			
			if(comp1.value.length==6){
				comp2.focus();
			}
			
	
		}

	/**
	 * �̹���  ���� Ȯ���ڸ� üũ
	 *
	 **/
	function isImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp" || ext == "png") {
				return true;
			} else {
				return false;
			}
		}
	}
	
	/*
	// submit��  ����Ű �̺�Ʈ
	 document.onkeypress = keyPress ;
	 function keyPress(){
	 	var ieKey = window.event.keyCode ;
	 	if( ieKey == 13 ){
	 		goSave();
	 	}
	 }
	 */
	
	
	 
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
	 

	 function openCal(){
		 $('#calendarData1').datepicker("show");
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
    <div class="content_navi">�ѹ����� &gt; ��ü����</div>
	<h3><span>��</span>ü���</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
<!-- title -->

	<!--���θ� �����ȣ ��-->
		<form name="postForm" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
			<input type = "hidden" name = "pForm" value="companyRegist"/>
			<!--���õ� ����-->
			<input type = "hidden" name = "pZip" value="post"/>
			<!--���õ� �����ȣ-->
			<input type = "hidden" name = "pAddr" value="address"/>
			<!--���õ� �ּ�-->
		</form>
	<!--���θ� �����ȣ ��-->
				  
	<!--���� �ּ� �����ȣ ��-->
		<form name="postForm2" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost2">
			<input type = "hidden" name = "pForm" value="companyRegist"/>
			<!--���õ� ����-->
			<input type = "hidden" name = "pZip" value="post"/>
			<!--���õ� �����ȣ-->
			<input type = "hidden" name = "pAddr" value="address"/>
			<!--���õ� �ּ�-->
		</form>
	<!--���� �ּ� �����ȣ ��-->
  
	<div class="con">
	
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
	
	</div>  
	<!-- //������ ��� ���� -->
				
	<!-- ��� -->	
    <form name="companyRegist" method="post" action="<%= request.getContextPath()%>/B_Company.do?cmd=companyRegist"   enctype="multipart/form-data">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "sForm" value="<%=sForm%>"/>
      				  <input type = "hidden" name = "pYear1" value=""/>
    			 <input type = "hidden" name = "pMonth1" value=""/>
  				   <input type = "hidden" name = "pDay1" value=""/>

	<fieldset>
		<legend>��ü���</legend>
	<table class="tbl_type" summary="��ü���(����ڵ�Ϲ�ȣ, ��ȣ(���θ�), ���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ), ��ǥ�ڸ�, ����, ����, �ּҰ˻����Ǽ���, ����������, ������, ����ڵ����, ����纻, ��ü��)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
    
    <tbody>    
		
		<tr>
			<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
			<th><label for="permit_no"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ڵ�Ϲ�ȣ</label></th>
			<td><input type="text" id="permit_no" name="permit_no" class="text" title="����ڵ�Ϲ�ȣ" style="width:200px;" readOnly onClick="javascript:popCompNo();"/><a href="javascript:popCompNo();" class="btn_type03"><span>��ȸ</span></a></td>
		</tr>        
        
		<tr>
			<th><label for="comp_nm"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ȣ(���θ�)</label></th>
			<td><input type="text" id="comp_nm" name="comp_nm" class="text" title="��ȣ(���θ�)" style="width:300px;" /></td>
		</tr>
        
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)</label></th>
			<td><input type="text" id="" name="comp_no1" class="text" title="�չ�ȣ" style="width:80px;" maxlength="6"  />&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="" name="comp_no2" class="text" title="�޹�ȣ" style="width:80px;" maxlength="7" /><input type ="hidden" name ="comp_no" value=""  maxlength="14" ></td>
		</tr>
        
		<tr>
			<th><label for="owner_nm"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ǥ�ڸ�</label></th>
			<td><input type="text" id="owner_nm" name="owner_nm" class="text" title="��ǥ�ڸ�" style="width:300px;"  maxlength="100" /></td>
		</tr>
        
		<tr>
			<th><label for="business"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="business" name="business" class="text" title="����" style="width:917px;" maxlength="250"/></td>
		</tr>
        
		<tr>
			<th><label for="b_item"><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="b_item" name="b_item" class="text" title="����" style="width:917px;" maxlength="250" /></td>
		</tr>
        
        <tr id="adrChk_tr">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ּҰ˻����Ǽ���</label></th>
			<td><input type="radio" id="adrChk" name="adrChk" class="radio md0" value="1" checked="checked" onclick="javascript:addressWhereCheck();" title="���θ����� ã��" /><label for="">���θ����� ã��</label><input type="radio" id="adrChk" name="adrChk" class="radio" title="���� �ּҷ� ã��" value="2" onclick="javascript:addressWhereCheck();"/><label for="">���� �ּҷ� ã��</label></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����������</label></th>
			<td>
				
				<ul class="listD">
					<li class="first"><input type="text" id="" name="post" readOnly class="text" title="�����ȣ" style="width:80px;" /><a id="NewAddress" value="�����ȣ" href="javascript:searchZipCode();" class="btn_type03"><span>�����ȣ</span></a><a id="OriAddress" value="�����ȣ" href="javascript:searchZipCode2();" class="btn_type03"><span>�����ȣ</span></a></li>
					<li><input type="text" id=""  name="address" class="text" title="�⺻�ּ�" style="width:917px;" maxlength="100"/></li>
					<li><input type="text" id="" name="addr_detail" class="text" title="���ּ�" style="width:917px;" maxlength="100"/></li>
				</ul>
			
			</td>
		</tr>
        
 		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
			<td>
				<!-- 
				<input type="text" id="" class="text" title="��" style="width:40px;" /> ��&nbsp;&nbsp;
				<input type="text" id="" class="text" title="��" style="width:40px;" /> ��&nbsp;&nbsp;
				<input type="text" id="" class="text" title="��" style="width:40px;" /> ��&nbsp;&nbsp; 
				<img onclick="openCal();" src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="�޷�" />
				 -->
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;"/></span>
				<input type="hidden" name="open_dt" class="in_txt"  style="width:80px" value="" />
			</td>
		</tr>
        
        
        <!--tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>����ڸ�</td>
				<td><input type="text" name="charge_nm" class="in_txt" style="width:200px" maxlength="20"></td>
			</tr>
			<tr>
				<td height="1" bgcolor="#c7c7c7"  colspan="2"></td>
			</tr>
			<tr>
				<td>����� �̸���</td>
				<td><input type="text" name="charge_email" class="in_txt" style="width:200px" maxlength="50"></td>
			</tr-->
       
       <tr>
			<th><input type="hidden" name="COMPANY_FILENM" value=""></input>
			<input type="hidden" name="ACCOUNT_COPYNM1" value=""></input>
			<label for="">����ڵ����</label></th>
			<td><div class="fileUp"><input type="text" class="text" id="file1" title="����ڵ����" style="width:852px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="comp_file" id="upload1" onKeyUp = "compFileNmCheck('companyRegist.comp_file')" /></div></td>
	   </tr>
      
	   <tr>
		   <th><label for="">����纻</label></th>
			<td>
				<ul class="listD">
					<li class="first"><div class="fileUp">�纻1&nbsp;&nbsp;<input type="text" class="text" id="file2" title="����纻1" style="width:816px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy1" id="upload2" /></div></li>
					<li><div class="fileUp">�纻2&nbsp;&nbsp;<input type="text" class="text" id="file3" title="����纻2" style="width:816px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy2" id="upload3" /></div></li>
					<li><div class="fileUp">�纻3&nbsp;&nbsp;<input type="text" class="text" id="file4" title="����纻3" style="width:816px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy3" id="upload4" /></div></li>
					<li><div class="fileUp">�纻4&nbsp;&nbsp;<input type="text" class="text" id="file5" title="����纻4" style="width:816px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy4" id="upload5" /></div></li>
					<li><div class="fileUp">�纻5&nbsp;&nbsp;<input type="text" class="text" id="file6" title="����纻5" style="width:816px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy5" id="upload6" /></div></li>
					<li class="guide_txt">* ÷�ΰ��� �������� : PDF, GIF, JPG, TIF, BMP, PNG / ÷�ΰ��� �뷮 : �ִ� 10M</li>
				</ul>
			</td>
		</tr> 
       
		<tr>
			<th><label for="">��ü��</label></th>
			<td>
				<ul class="listD">
					<li class="first"><textarea id="" name="COMPANYEVALUATION" title="��ü��" onKeyUp="js_Str_ChkSub('500', this)" style="width:917px;height:45px;"></textarea></li>
				</ul>
			</td>
		</tr>
	   
	   </tbody>
      </table>
     </fieldset>
    </form>
    
    <!-- button -->
    <div class="Bbtn_areaC">
    	<a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>���</span></a>
    </div>
    <!-- //button -->
  </div>
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
<%= comDao.getMenuAuth(menulist,"00") %>
<script type="text/javascript">fn_fileUpload();</script>