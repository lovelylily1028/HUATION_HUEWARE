<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");

	CompanyDTO compDto = (CompanyDTO)model.get("compDto");
	String curPage = (String)model.get("curPage");
	String comp_code = (String)model.get("comp_code");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String sForm =  (String)model.get("sForm");
	
	//������ �ʱ� ���� ��.
			String open_dt = "";

			
			if(compDto.getOpen_dt().equals("")){
				open_dt = compDto.getOpen_dt();
				open_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			}else{
				open_dt = compDto.getOpen_dt();
				String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
				String strD_Val1;
				
			    strY_Val1 = open_dt.substring(0,4);
			    strM_Val1 = open_dt.substring(4,6);
			    strD_Val1 = open_dt.substring(6,8);
				
			    open_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
			}
			
			
			
			//�������� ����
			String date = "";
			
			date = compDto.getDate();
		/* 	String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = date.substring(0,4);
		    strM_Val1 = date.substring(4,6);
		    strD_Val1 = date.substring(6,8);
			
		    date = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1; */
			
			
			
			//����,����ó üũ�ϱ�
			String[] b_check = StringUtil.getTokens(compDto.getBusiness_check(), "|");

			String acheckd="";
			String bcheckd="";
			

			for(int i=0;i<b_check.length; i++){

				if(b_check[i].equals("01")){
					acheckd="checked";
				}else if(b_check[i].equals("02")){
					bcheckd="checked";
				}
			}
			
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<title>��ü ������</title>
<script language="JavaScript">
<!--

	function goSave(){
	
		var frm = document.companyView; 
		
		
		
		
		
		var dates = frm.open_dt.value;
		var open_dts = dates.replace(/-/g,'');
		frm.pYear1.value = open_dts.substr(0,4);
		frm.pMonth1.value = open_dts.substr(4,2);
		frm.pDay1.value = open_dts.substr(6,2);
		
		frm.open_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		
	    frm.comp_no.value=frm.comp_no1.value+'-'+frm.comp_no2.value;

  
    //�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.comp_file.value;
	var strFile2 = frm.account_copy1.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);
	
	var lastIndex2 = strFile2.lastIndexOf('\\');
	var strFileName2 = strFile2.substring(lastIndex2+1);
	
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
		if(confirm("���� �Ͻðڽ��ϱ�?")){
		
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
	
			/* frm.open_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value; */
			frm.open_dt.value = $("#calendarData1").val().replace("-","");
		
		if(strFileName!=''){
			
			frm.COMPANY_FILENM.value = strFileName;
		}
		if(strFileName2!=''){
			
			frm.ACCOUNT_COPYNM1.value = strFileName2;
		}
		
		
		
		var business_check='';
		var cnt=2;
		for(i=0;i<cnt;i++){
			if(frm.businesscheck[i].checked==true){
				if(i==cnt-1){
					i++;
					business_check+='0'+i;
					i--;
				}else{
					i++;
					business_check+='0'+i+'|';
					i--;
				}
			}
			
			frm.business_check.value = business_check;
			
		}
		
			frm.submit();
		
		}
	}

	function goList(){
		
		var frm = document.companyView;
		frm.action='<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList2';
		frm.submit();
	
	}

	function goDelete(){
		
		var frm = document.companyView;
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			frm.action='<%= request.getContextPath()%>/B_Company.do?cmd=companyDelete';
			frm.submit();
		}
	
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
	
	function compNocheck(form){
		   
		   var frm=document.companyView;
		   var obj=eval("document."+form);
		   var comp1=frm.comp_no1;
		   var comp2=frm.comp_no2;
	/*
		   if(obj.value.length>0){
				if (!isNumber(trim(obj.value))) {
					alert("���ڸ� �Է��� �ּ���.");
					obj.value=onlyNum(obj.value);
				} 
		   }
	   */     
			if(comp1.value.length==6){
				comp2.focus();
			}
	
		}
	
	
	function fileDel(obj){
	
		var file=eval('document.companyView.'+obj);
	
		file.value='';
	
		document.getElementById(obj+'_t').innerText ='';
		document.getElementById(obj+'_d').innerText ='';
	
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
	
	
	//����� ��Ϲ�ȣ ���� �� ��� 2013_03_20(��) shbyeon.
	function popCompNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo&sForm=companyView","","width=400,height=500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	
	function popUnfit(compcode){
		window.open("<%= request.getContextPath()%>/B_Company.do?cmd=companyUnfit&comp_code="+compcode+"","","width=455,height=335,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}
	
	//�ּ� �˻����� ����.
	 function addressWhereCheck(){
		 var chk = $("#adrChk_tr input:checked").val();
		 //Alert(chk);
		 
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
	
	
	 function inits(){	
			var frm = document.companyView;
			var chk = $("#unfitId_value").val();
			if(!chk){
				$('#cmStChk').hide();					//���� ��	1�̸� �������� ���� ���� hide
				$('#UnfitBusiness').hide();						//���� ��	1�̸� �������� ���� hide
				$('#UnfitDt').hide();
				$('#UnfitId').hide();
						//���� �� 1�̸� value �� �ʱ�ȭ (����)
				return;
			}else {
				$('#unfit_bottom').hide();
			}
			observer = window.setTimeout("inits()", 100);   // 0.1�ʸ��� Ȯ��
		}
	 
	 function show(chk){
		 if(chk == 'show'){
			$('#cmStChk').show();					//���� ��	1�̸� �������� ���� ���� hide
			$('#UnfitBusiness').show();						//���� ��	1�̸� �������� ���� hide
			$('#UnfitDt').show();
			$('#UnfitId').show();
		 }
	 }
	
//-->
</script>
</head>
<body  onload="inits();">

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
		<h3><span>��</span>ü������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
	<!-- title -->

	<!--���θ� �����ȣ ��-->
	<form name="postForm" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
		<input type = "hidden" name = "pForm" value="companyView"/><!--���õ� ����-->
		<input type = "hidden" name = "pZip" value="post"/><!--���õ� �����ȣ-->
		<input type = "hidden" name = "pAddr" value="address"/><!--���õ� �ּ�-->
	</form>
	<!--���� �� �����ȣ ��-->

	<!--���� �ּ� �����ȣ ��-->
  	<form name="postForm2" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost2">
        <input type = "hidden" name = "pForm" value="companyView"/>
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
 
    <form name="companyView" method="post" action="<%= request.getContextPath()%>/B_Company.do?cmd=companyEdit"  enctype="multipart/form-data">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "sForm" value="<%=sForm%>"/>
      <input type = "hidden" name = "comp_code" value="<%=compDto.getComp_code() %>"></input>
      
      <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>
      
      

	<fieldset>
	<legend>��ü������</legend>
		<table class="tbl_type" summary="��ü������(����ڵ�Ϲ�ȣ, ��ȣ(���θ�), ���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ), ��ǥ�ڸ�, ����, ����, �ּҰ˻����Ǽ���, ����������, ������, ����ڵ����, ����纻, ��ü��)">
		
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup>
        
       <tbody>
        
        <%
        if(compDto.getPermit_no() != ""){       	
        %>
        
        <tr>
			<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ڵ�Ϲ�ȣ</label></th>
			<td><input type="text" id="" name="permit_no" class="text" title="����ڵ�Ϲ�ȣ" style="width:200px;" readonly="readonly" value="<%=compDto.getPermit_no() %>" /></td>
		</tr>
        
        <%
        }else{        	
        %>
        
        <tr>
			<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ڵ�Ϲ�ȣ</label></th>
			<td><input type="text" id="" name="permit_no" class="text" title="����ڵ�Ϲ�ȣ" style="width:200px;" readOnly onClick="javascript:popCompNo();" /><a href="javascript:popCompNo();" class="btn_type03"><span>��ȸ</span></a></td>
		</tr>
        
        <%
        }
        %>
        
        <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ȣ(���θ�)</label></th>
			<td><input type="text" id="" name="comp_nm" class="text" title="��ȣ(���θ�)" style="width:300px;" value="<%=compDto.getComp_nm()%>" maxlength="100"/></td>
		</tr>
        
        <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)</label></th>
			    
			    <%
					String compno=StringUtil.nvl(compDto.getComp_no(),"-");
					int index=compno.indexOf("-");
					String comp1=compno.substring(0,index);
					String comp2=compno.substring(index+1);
				
				%>
			
			<td><input type="text" id="" name="comp_no1" class="text" title="�չ�ȣ" style="width:80px;" value="<%=comp1%>" maxlength="6"/>&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="" name="comp_no2" class="text" title="�޹�ȣ" style="width:80px;" value="<%=comp2%>" maxlength="7"/><input type="hidden" name ="comp_no" maxlength="14" value="<%=compDto.getComp_no()%>"></td>
		</tr>
		

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ǥ�ڸ�</label></th>
			<td><input type="text" id="" name="owner_nm" class="text" title="��ǥ�ڸ�" style="width:300px;" value="<%=compDto.getOwner_nm()%>" maxlength="100"/></td>
		</tr>
						
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="" name="business" class="text" title="����" style="width:917px;" value="<%=compDto.getBusiness()%>" maxlength="250"/></td>
		</tr>
		
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="" name="b_item" class="text" title="����" style="width:917px;" value="<%=compDto.getB_item()%>" maxlength="250"/></td>
		</tr>        
        
		<tr id="adrChk_tr">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ּҰ˻����Ǽ���</label></th>
			<td><input type="radio" id="adrChk" name="adrChk" value="1" class="radio md0" checked="checked" onclick="javascript:addressWhereCheck();"onclick="javascript:addressWhereCheck();" title="���θ����� ã��" /><label for="">���θ����� ã��</label><input type="radio" id="adrChk" name="adrChk" value="2" onclick="javascript:addressWhereCheck();" class="radio" title="���� �ּҷ� ã��" /><label for="">���� �ּҷ� ã��</label></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����������</label></th>
				<td>
					<ul class="listD">
						<li class="first"><input type="text" id="" class="text" title="�����ȣ" style="width:80px;" name="post" value="<%=compDto.getPost()%>" /><a id="NewAddress" href="javascript:searchZipCode();" value="�����ȣ" class="btn_type03"><span>�����ȣ</span></a><a id="OriAddress" href="javascript:searchZipCode2();" value="�����ȣ" class="btn_type03"><span>�����ȣ</span></a></li>
						<li> <input type="text" readonly name="address" id="" class="text" title="�⺻�ּ�" style="width:917px;"  value="<%=compDto.getAddress()%>" maxlength="100"/> </li>
						<li> <input type="text" id="" name="addr_detail" class="text" title="���ּ�" style="width:917px;" value="<%=compDto.getAddr_detail()%>" maxlength="100"/> </li>
					</ul>
				</td>
		</tr>
        
        <tr>
			<th><label for="">������</label></th>
			<td>
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="open_dt" value="<%=open_dt%>"/></span>
				<input type="hidden" class="in_txt"  style="width:80px" value="<%=compDto.getOpen_dt()%>" />
			</td>
		</tr>

        <!--tr>
				<th>����ڸ�</th>
				<td><input type="text" name="charge_nm" class="" style="width:200px" maxlength="20" value="<%=compDto.getCharge_nm()%>"></td>
			</tr>
			<tr>
				<th>����� �̸���</th>
				<td><input type="text" name="charge_email" class="" style="width:200px" maxlength="50" value="<%=compDto.getCharge_email()%>"></td>
				</tr-->

        <tr>
          
          <%
			   String comp_file=compDto.getComp_file();
			   String account_file1=StringUtil.nvl(compDto.getAccount_copy1(),"/");
			   String account_file2=StringUtil.nvl(compDto.getAccount_copy2(),"/");
			   String account_file3=StringUtil.nvl(compDto.getAccount_copy3(),"/");
			   String account_file4=StringUtil.nvl(compDto.getAccount_copy4(),"/");
			   String account_file5=StringUtil.nvl(compDto.getAccount_copy5(),"/");
				
			   
// 				String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
				//String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
				String serverUrl = "" + request.getContextPath();
				
				int a_index=comp_file.lastIndexOf("/");
				int b_index=account_file1.lastIndexOf("/");
				int c_index=account_file2.lastIndexOf("/");
				int d_index=account_file3.lastIndexOf("/");
				int e_index=account_file4.lastIndexOf("/");
				int f_index=account_file5.lastIndexOf("/");
				
				String compfilename=comp_file.substring(a_index+1);
				String accountfilename1=account_file1.substring(b_index+1);
				String accountfilename2=account_file2.substring(c_index+1);
				String accountfilename3=account_file3.substring(d_index+1);
				String accountfilename4=account_file4.substring(e_index+1);
				String accountfilename5=account_file5.substring(f_index+1);
				
				String comppath="";
                String accountpath1="";
                String accountpath2="";
                String accountpath3="";
                String accountpath4="";
                String accountpath5="";
                
                if(!comp_file.equals("")){
                	comppath=comp_file.substring(0,a_index);
                }
                
                if(!account_file1.equals("")){
                	accountpath1=account_file1.substring(0,b_index);
                }
                
                if(!account_file2.equals("")){
                	accountpath2=accountfilename2.substring(0,c_index);
                }
                
                if(!account_file3.equals("")){
                	accountpath3=accountfilename3.substring(0,d_index);
                }
                
                if(!account_file4.equals("")){
                	accountpath4=accountfilename4.substring(0,e_index);
                }
                
                if(!account_file5.equals("")){
                	accountpath5=accountfilename5.substring(0,f_index);
                }
               
			
                %>
			  
			  <th> <label for="">����ڵ����</label> </th>
			  <td><div class="fileUp"><input type="text" class="text" id="file1" title="����ڵ����" style="width:680px;" value="<%=compDto.getComp_file() %>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="comp_file" id="upload1" /></div><% if(!compDto.getComp_file().equals("")){ %><!-- ����� ����� �̹��� ����  --><span id="p_comp_file_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=compfilename%>&sFileName=<%=compfilename%>&filePath=<%=comppath%>" class="btn_type03"> <span>����ڵ���� �ٿ�ε�</span></a></span><span id="p_comp_file_d"><a href="javascript:fileDel('p_comp_file');"  class="btn_type03"><span>����</span></a></span>
            
	            <% 
	            } 
	            %>
            	<input type="hidden" name="p_comp_file" value="<%=compDto.getComp_file()%>" />
            	<input type="hidden" name="COMPANY_FILENM" value="<%=compDto.getCOMPANY_FILENM()%>" />			  
			  </td>
		  </tr>
          
     	  <tr>
			 <th><label for="">����纻</label></th>
				<td>
					
					<ul class="listD">
						<li class="first"><div class="fileUp">�纻1&nbsp;&nbsp;<input type="text" class="text" id="file2" title="����纻1" style="width:658px;" value="<%=compDto.getAccount_copy1()%>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy1" id="upload2" /></div><% if(!compDto.getAccount_copy1().equals("")){ %><span id="p_account_copy1_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename1%>&sFileName=<%=accountfilename1%>&filePath=<%=accountpath1%>" class="btn_type03"><span>����纻1 �ٿ�ε�</span></a></span><span id="p_account_copy1_d"><a href="javascript:fileDel('p_account_copy1');" class="btn_type03"><span>����</span></a></span></li>
						
						<% } %>
						<input type="hidden" name="p_account_copy1" value="<%=compDto.getAccount_copy1()%>">
            			<input type="hidden" name="ACCOUNT_COPYNM1" value="<%=compDto.getACCOUNT_COPYNM1()%>">
						
						<li><div class="fileUp">�纻2&nbsp;&nbsp;<input type="text" class="text" id="file3" title="����纻2" style="width:658px;" value="<%=compDto.getAccount_copy2()%>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy2" id="upload3" /></div><% if(!compDto.getAccount_copy2().equals("")){ %><span id="p_account_copy2_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename2%>&sFileName=<%=accountfilename2%>&filePath=<%=accountpath2%>" class="btn_type03"><span>����纻2 �ٿ�ε�</span></a></span><span id="p_account_copy2_d"><a href="javascript:fileDel('p_account_copy2');" class="btn_type03"><span>����</span></a></span></li>
						
						<% } %>
            			<input type="hidden" name="p_account_copy2" value="<%=compDto.getAccount_copy2()%>">
						
						<li><div class="fileUp">�纻3&nbsp;&nbsp;<input type="text" class="text" id="file4" title="����纻3" style="width:658px;" value="<%=compDto.getAccount_copy3()%>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy3" id="upload4" /></div><% if(!compDto.getAccount_copy3().equals("")){ %><span id="p_account_copy3_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename3%>&sFileName=<%=accountfilename3%>&filePath=<%=accountpath3%>" class="btn_type03"><span>����纻3 �ٿ�ε�</span></a></span><span id="p_account_copy3_d"><a href="javascript:fileDel('p_account_copy3');" class="btn_type03"><span>����</span></a></span></li>
						
						<% } %>
            			<input type="hidden" name="p_account_copy3" value="<%=compDto.getAccount_copy3()%>">
						
						<li><div class="fileUp">�纻4&nbsp;&nbsp;<input type="text" class="text" id="file5" title="����纻4" style="width:658px;" value="<%=compDto.getAccount_copy4()%>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy4" id="upload5" /></div><% if(!compDto.getAccount_copy4().equals("")){ %><span id="p_account_copy4_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename4%>&sFileName=<%=accountfilename4%>&filePath=<%=accountpath4%>" target="new" class="btn_type03"><span>����纻4 �ٿ�ε�</span></a></span><span id="p_account_copy4_d"><a href="javascript:fileDel('p_account_copy4');" class="btn_type03"><span>����</span></a></span></li>
						
						<% } %>
            			<input type="hidden" name="p_account_copy4" value="<%=compDto.getAccount_copy4()%>">
						
						<li><div class="fileUp">�纻5&nbsp;&nbsp;<input type="text" class="text" id="file6" title="����纻5" style="width:658px;" value="<%=compDto.getAccount_copy5()%>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="account_copy5" id="upload6" /></div><% if(!compDto.getAccount_copy5().equals("")){ %><span id="p_account_copy5_t"><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename5%>&sFileName=<%=accountfilename5%>&filePath=<%=accountpath5%>" class="btn_type03"><span>����纻5 �ٿ�ε�</span></a></span><span id="p_account_copy5_d"><a href="javascript:fileDel('p_account_copy5');" class="btn_type03"><span>����</span></a></span></li>
						            
						<% } %>
            			<input type="hidden" name="p_account_copy5" value="<%=compDto.getAccount_copy5()%>">
						<li class="guide_txt">* ÷�ΰ��� �������� : PDF, GIF, JPG, TIF, BMP, PNG / ÷�ΰ��� �뷮 : �ִ� 10M</li>
					</ul>
				
				</td>
		 </tr>    

		<tr>
			<th><label for="">��ü��</label></th>
			<td><textarea name="COMPANYEVALUATION" id="" title="��ü��" style="width:917px;height:45px;"onKeyUp="js_Str_ChkSub('500', this)"><%=compDto.getCOMPANYEVALUATION()%></textarea></td>
		</tr>
		<tr id="cmStChk">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������������</label></th>
			<td><textarea id="" name="unfit_reason" class="dis" title="��������������" style="width:917px;height:45px;" readonly="readonly"><%=compDto.getUnfit_reason()%></textarea></td>
		</tr>
		<tr id="UnfitBusiness">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ó/����ó</label></th>
			<td>
				<input type="hidden" name="business_check"></input>
				<input type="checkbox" id="businesscheck" name="businesscheck" class="check md0" value="01" title="����ó" disabled="disabled" <%=acheckd %> /><label for="">����ó</label>
				<input type="checkbox" id="businesscheck" name="businesscheck" class="check" value="02" title="����ó" disabled="disabled" <%=bcheckd %> /><label for="">����ó</label>
			</td>
		</tr>
		<tr id="UnfitDt">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
			<td><input class="text dis" id="date" style="width:100px;" name="date" title="��������" readonly="readonly" value="<%=date%>"/></td>
		</tr>
		<tr id="UnfitId">
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
			<td><input type="text" id="unfitId_value" name="unfit_id" class="text dis" title="������" style="width:200px;" readonly="readonly" value="<%=compDto.getUnfit_id()%>" /></td>
		</tr>        
        </tbody>
      </table>
      </fieldset>
      	
     <!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC">
			<a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a><div class="Bbtn_areaRFix">
			<a href="javascript:popUnfit('<%=comp_code%>');" id="unfit_bottom" class="btn_type02 btn_type02_orange"><span>�����ݾ�ü����</span></a></div>
		</div>
	<!-- //Bottom ��ư���� -->
    </form>
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
</form>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"00") %>
<script type="text/javascript">fn_fileUpload();</script>