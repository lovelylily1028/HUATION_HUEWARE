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
<%@ page import="com.huation.common.currentstatus.CurrentStatusDTO" %>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserBroker"%>
<%@ page import="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>

<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	CurrentStatusDTO csDto = (CurrentStatusDTO)model.get("csDto");			//����������Ȳ �󼼺���DTO 
	CurrentStatusDTO csDtoPro = (CurrentStatusDTO)model.get("csDtoPro");	//����������Ȳ ��ǰ�ڵ�ArrDTO
																			//������ ��ü ���� �� ������ ����� �� ����� ������.
	//��ǰ�ڵ� Arr �𵨷� ��ü�� ������ codeList��.
	ArrayList codeList = (ArrayList)model.get("codeList"); //�ڻ� ��ǰ�ڵ�
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //���ڻ�(����)��ǰ�ڵ�
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //���ڻ�(�ܼ�)��ǰ�ڵ�
	ArrayList productList = (ArrayList)model.get("productList"); //��ǰ�ڵ� Array List ������ �ִ� ������
	
	
	//���� ��/��/�� ��������.
	String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����������Ȳ ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="javascript">
<!--

//��ȭ��ȣ ���� �Է½� üũ �� - ���� 2013_05_03(��)shbyeon.
function MaskPhon( obj ) { 

	 obj.value =  PhonNumStr( obj.value ); //������ ������ PhonNumStr function ����.

} 



//��ȭ��ȣ ���� �Է½� üũ �� - ���� 2013_05_03(��)shbyeon.
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


	//�̽��ڸ�Ʈ ����ϱ�
	function goSaveRep(){
	
	var frm=document.currentCommentIframe;
	

	if(frm.SalesMan_co.value == ""){
		alert("�̽��ڸ�Ʈ �Է½� �̽� ����� �� ������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(frm.Contents.value == ""){
		alert("�̽��ڸ�Ʈ �Է½� �̽� ����� �� ������ �ݵ�� �Է��ϼž� �մϴ�."); 
		return;
	}
	
	if(confirm("�̽� �ڸ�Ʈ�� ����Ͻðڽ��ϱ�?")){
		
	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.SalesFile.value;
	//alert(strFile);
		
	var lastIndex = strFile.lastIndexOf('\\');
	//alert(lastIndex);
	var strFileName= strFile.substring(lastIndex+1);
	//alert(strFileName);
	if(fileCheckNm(strFileName)> 200){
		alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
			return;
	}
	
	
	frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaComment&ProjectPkCo=<%=csDto.getPreSalesCode()%>';
	frm.target='hiddenframe';
	frm.submit();
	document.getElementByTagName('frm')[0].reset();
	
	}
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
	var preview = "";
	
	
	//�̽��ڸ�� ��� ���� �� currentCommentResult.jsp ����  AddView ������ 
	//���ο� iframe jsp������ ��  ��� �� ���� �����ָ鼭 ����Ʈ�� �ʱ�ȭ.
	function AddView(makeview) {
		//alert(makeview);
		
		document.all("MakeView").innerHTML = "";
		makeview = makeview + preview;
		preview = makeview;
		
	   //�̽��ڸ�� ��� ���� �Ŀ� currentCommentResult.jsp iframe �������� �� Add �� �ʱ�ȭ ��Ű��.
	   document.all("MakeView").insertAdjacentHTML("beforeEnd",makeview);
	   document.currentCommentIframe.SalesMan_co.value='';
	   document.currentCommentIframe.Contents.value='';
	   document.currentCommentIframe.SalesFileNm.value='';
	   //input file <<���� ��ü�� value �ʱ�ȭ�� �Ҽ� ����. html�� readonly������ ���ֱ� ����.
	   //�ʱ�ȭ ����� select();��ü�� ����Ͽ� �ش� selection.clear()�� �ʱ�ȭ����.
	   document.currentCommentIframe.SalesFile.select();
	   document.selection.clear();  
		
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
		
	
	//�̽� �ڸ�Ʈ ����
	function goDeleteRep(ComentPk){
		var frm = eval('document.currentCommentIframe_'+ComentPk);
		
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			
			var requestUrl='<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=comentDeleteResult&ComentPk='+ComentPk;
			var msg='';
			var ComentPk ='';
			
			var xmlhttp = null;
			var xmlObject = null;
			var resultText = null;
	
	
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			xmlhttp.open("GET", requestUrl, false);
			xmlhttp.send(requestUrl);
	
			resultText = xmlhttp.responseText;
	
			xmlObject = new ActiveXObject("Microsoft.XMLDOM");
			xmlObject.loadXML(resultText);
			ComentPk=xmlObject.documentElement.childNodes.item(0).text;
			msg=xmlObject.documentElement.childNodes.item(1).text;
			alert(msg);
			if(msg == '������  �����Ͽ����ϴ�'){
				
				//$('#displayDiv').hide();
				
			}
	
		}
	
	}

	//�̽� �ڸ�Ʈ ����
	function goUpdateRep(ComentPk){
		var frm = eval('document.currentCommentIframe_'+ComentPk);
		//$('[name=SalesMan_co_updel'+ComentPk+']').val();
		//alert($('[name=SalesMan_co_updel'+ComentPk+']').val());
		
		if(frm.SalesMan_co.value == ""){
			alert("���縦 �Է��ϼ���.");
			return;
		}
		if(frm.Contents.value == ""){
			alert("������ �Է��ϼ���."); 
			return;
		}
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			
			//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
			var strFile = frm.SalesFile.value;
			
			var lastIndex = strFile.lastIndexOf('\\');
			//alert(lastIndex);
			var strFileName= strFile.substring(lastIndex+1);
			//alert(strFileName);
			if(fileCheckNm(strFileName)> 200){
				alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
				return;
			}
			
			frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaCommentUp&ProjectPkCo=<%=csDto.getPreSalesCode()%>';
			frm.target = 'hiddenframe';
			frm.SalesFileNm.value = strFileName;
			frm.ComentPk.value = ComentPk;
			frm.submit(); 
		}
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

	function goSave(){
		
		var frm = document.currentStaEdit;
		
		//��ǰ�ڵ� üũ
		var NoCode = $('#NoCode').length;
		
		if(confirm("���� �Ͻðڽ��ϱ�?")){
			frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaEdit';
		if(frm.checkyn.checked!=true){
			if(frm.comp_code.value.length == 0){
				alert("�����ְ���(��ü��)��/�� �����ϼ���!");
				return;
			}
		}else{
			if(frm.e_comp_nm.value.length == 0){
				alert("�����ְ���(��ü��)��/�� �Է��ϼ���!");
				return;
			}
		}	

	/*
	2013_05_06(��)shbyeon. �ߺ�üũ �����ϹǷ� ���� ������.
	if(frm.checkyn.checked==true){
		if(frm.e_comp_nm.value!=frm.trueflag.value){
			alert("�����ְ��簡(��ü��) �ߺ��Ǵ��� Ȯ���ϼ���.");
			return;
		}
	}
	*/
	
	/*
	���� ��ǰ�ڵ� üũ�ڽ� ��������� �������̼� üũ.
	if(document.getElementById("pcbox01").checked == false && document.getElementById("pcbox02").checked == false
	   && document.getElementById("pcbox03").checked == false && document.getElementById("pcbox04").checked == false
	   && document.getElementById("pcbox05").checked == false && document.getElementById("pcbox06").checked == false
	   && document.getElementById("pcbox07").checked == false && document.getElementById("pcbox08").checked == false
	   && document.getElementById("pcbox11").checked == false && document.getElementById("pcbox12").checked == false
	   && document.getElementById("pcbox13").checked == false && document.getElementById("pcbox14").checked == false
	   && document.getElementById("pcbox15").checked == false && document.getElementById("pcbox16").checked == false
	   && document.getElementById("pcbox17").checked == false && document.getElementById("pcbox18").checked == false){
		alert("�ڻ� �Ǵ� ���� ��ǰ�ڵ带 �������ּ���."); 
		return;
	}
	*/
	
	//NoCode < jQuery �Լ�
	//alert(NoCode);
	if(NoCode == 1){
		alert("��ǰ�ڵ带 �־��ּ���.")	;
		return;
	}
	
	if(frm.OperatingCompany.value == ""){
		alert("���縦 �Է��ϼ���."); 
		return;
	}
	if(frm.ProjectName.value == ""){
		alert("���� ������Ʈ���� �Է��ϼ���."); 
		return;
	}
	if(frm.Orderble.value == ""){
		alert("���ְ��ɼ��� �����ϼ���."); 
		return;
	}
	if(frm.ChargeID.value == ""){
		alert("��翵��(��)�� �����ϼ���."); 
		return;
	}
	if(frm.AssignPerson.value == ""){
		alert("����о� �����η��� �Է��ϼ���."); 
		return;
	}
	//�б� üũ�� �б⺰ ������ ����
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
    
    //��ü�ڵ尡  �ִٸ� ��ü�ڵ���� ����.
    if(frm.permit_no.value.length != 0){
		frm.e_comp_nm.value=frm.comp_nm.value
	}
	frm.DateProjections.value=frm.target_year.value+'.'+frm.target_month.value;
	frm.ChargeID.value=frm.user_id.value;
	frm.ChargeSecondID.value=frm.user_id2.value;

	frm.submit();
	}
}
		

	/*
	 * int ���� üũ 000, ����Ͽ� �����ص� �޸� ǥ��
	 */
	 function saleCntCal(form){
		
		    var v_obj;
			var obj;
			var veiwfrm=eval("document."+form+'_view');
			var frm=eval("document."+form);
			var costobj=document.currentStaEdit;
	
			if(frm.length>1){
				v_obj=veiwfrm[index];
				obj=frm[index];
			}else{
				v_obj=veiwfrm;
				obj=frm;
		
			}
		
			if (!isNumber(trim(v_obj.value))) {
				alert("0~9 ����(����)�� �Է��� �ּ���.");
			} 
			
			
			var num=onlyNum(v_obj.value);
			v_obj.value = addCommaStr(num);
			obj.value = num;
			
			if(form=='currentStaEdit.SalesProjections'){	
				var price=parseInt(onlyNum(costobj.SalesProjections.value)*1,10);
				costobj.SalesProjections.value=addCommaStr(''+SalesProjections);
			    costobj.SalesProjections.value=SalesProjections;	    
			    
			}
			v_obj.focus();
		}
 
	
	function popComp(){

		var obj=document.currentStaEdit;
		
		if(obj.checkyn.checked==true){
				alert('�����Է� ������ ������ ��ü��ȸ �Ͻñ� �ٶ��ϴ�.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=currentStaEdit","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
	}
	
	
	//�����Է� üũ �Ǵ� �� �Է�â Ȱ��ȭ����.
	 function directInput(){

		    var obj=document.currentStaEdit;
		    if(obj.checkyn.checked==true){
				
				if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
					obj.e_comp_nm.style.display='inline'
					//obj.e_comp_nm_se.style.display='inline' 2013_05_02(��) shbyeon. �ߺ�üũ ������.
					obj.comp_nm.style.display="none";
					obj.comp_nm.value='';
					obj.comp_code.value='';
					obj.permit_no.value='';
				}else{
					obj.checkyn.checked=false;
				}
			}else{

				if(confirm("�����Է����� �����Ͻðڽ��ϱ�?")){
					obj.e_comp_nm.style.display='none'
					//obj.e_comp_nm_se.style.display='none' 2013_05_02(��) shbyeon. �ߺ�üũ ������.
					obj.comp_nm.style.display="inline";
					obj.e_comp_nm.value=''; //�����Է� ��ü�� �ʱ�ȭ
					obj.comp_nm.value='';  //��ü��ȸ ��ü�� �ʱ�ȭ
				}else{
					obj.checkyn.checked=true;
				}


			}

		}
	
	 <%--
	   �ߺ�üũ(����)
	  2013_05_02(��) shbyeon ���������.
	 function doCheck(e_comp_nm){
	 	
	 	var requestUrl='<%= request.getContextPath() %>/B_Common.do?cmd=CompNameCheck&e_comp_nm='+e_comp_nm;
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
	
	//��ü�ߺ�Ȯ�� check 2013_03_26(ȭ)shbyeon.
	 function fnDuplicateCheck() {
		
	 	var frm = document.currentStaEdit; 
	 	
	 	
	 	if(frm.e_comp_nm.value.length == 0){
	 		alert("��û�縦 �Է��ϼ���.");
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
	 			frm.trueflag.value  =  frm.e_comp_nm.value ;	
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	 --%>
	
	//JQuery - ��ǰ�ڵ� ���콺�� ������ �Ѱ��ֱ�.
	$(function() {
		//alert($('#cart ol li').length);
		var cartLen = $('#cart ol li').length;
		var test = $('#cart ol li').map(function(){
			return $(this).attr("id");
		});
		
		for(var x=0; x<cartLen; x++){
			$('#products #'+test.get(x)).hide();
			//alert(test.get(x));	
		}
		
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  
			  $('#NoCode').remove(); //��ǰ�ڵ� �߰� �� Cart<li>�� �ִ�  ��ǰ�ڵ带 �־��ּ���. text �����.
			  $(this).hide(); //��ǰ�ڵ� ���ý� �ش� ��ǰ�ڵ� hide �����.
		    
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+"<a>"+$(this).html()+"</a>"+"<input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
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
		var frm = document.currentStaEdit; 

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
	
	<%--
	���� ������.
	2013_05_02(��)shbyeon.
	function openComment(){
		var str = "";
		str += "<tr>";
		str += "<th>��¥</th>";
		str += "<td>2012-03-03</td>";
		str += "<td rowspan=\"3\"><textarea rows=\"4\" style=\"ime-mode:active;width:600px; height:65px;padding:5px\" dispName=\"����������Ȳ �ڸ�Ʈ\"></textarea> </td>";
		str += "<td rowspan=\"3\"><img src=\"<%= request.getContextPath()%>/images/ico_down.gif\" width=\"16\" height=\"16\" align=\"absmiddle\" title=\"÷������\"></td>";
		str += "</tr>";
		str += "<tr>";
		str += "<th>�ۼ���</th>";
		str += "<td>������</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<th>����</th>";
		str += "<td><input type=\"text\" name=\"SalesMan\"></td>";
		str += "</tr>";
	
		
   		$('#CommentTb').append(str);
	}
	--%>

	
		//����������Ȳ �������.
		function goList(){
			var frm = document.currentStaEdit;
			location.href='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList';
		}
	
		//����������Ȳ ��ϻ���.
		function goDelete(){
			
			var frm = document.currentStaEdit;
			if(confirm("���� �Ͻðڽ��ϱ�?")){
				frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaDelete';
				frm.submit();
			}

		}
		
		//�����ȸ ù ��°	
		function popSales(){
				var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=currentStaEdit","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
		//�����ȸ �� ��°
		function popSales_Second(){
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=currentStaEdit","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
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
	<div class="content_navi">�������� &gt; ����������Ȳ</div>
	<h3><span>��</span>��������Ȳ������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� --v>
  <!-- //title -->

	<div class="con currentStaRegistForm">
	<!-- ����������Ȳ������ -->
	<div>
	<h4 class="hidden_obj">����������Ȳ������</h4>
		
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	
	<!-- �ʼ��Է»����ؽ�Ʈ -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
	<!-- //�ʼ��Է»����ؽ�Ʈ -->
	
	</div>
	<!-- //������ ��� ���� -->
	

	<!-- ��� -->
  <div id="excelBody">
    <form name="currentStaEdit" method="post" action="<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaEdit">
     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
	  <!-- ��ü��ȸ�˾� â���� �Ѱܼ� �޾ƿ� ��. ��ü�ڵ常 DB�� ����������Ƿ� ��������ȴ�. -->
	  <input type = "hidden" name = "comp_code" value="<%=csDto.getEnterpriseCode()%>"/>
	  <!-- ��ü��ȸ�˾� â���� �Ѿ���� �� name����. -->
      <input type = "hidden" name = "owner_nm" value=""/>
      <input type = "hidden" name = "business" value=""/>
      <input type = "hidden" name = "b_item" value=""/>
      <input type = "hidden" name = "post" value=""/>
      <input type = "hidden" name = "address" value=""/>
      <input type = "hidden" name = "addr_detail" value=""/>
      <input type = "hidden" name = "EnterpriseCode" value="<%=csDto.getEnterpriseCode()%>"/>
      <input type = "hidden" name = "permit_no" value="<%=csDto.getPermitNo()%>"/>
      <input type = "hidden" name = "PreSalesCode" value="<%=csDto.getPreSalesCode()%>"/>
      <input type = "hidden" name="OrderStatus" value="<%=csDto.getOrderStatus() %>"></input>
      <input type = "hidden" name="PublicNo" value="<%=csDto.getPublicNo() %>"></input>
      <input type = "hidden" name="P_PublicNo" value="<%=csDto.getP_PublicNo() %>"></input>
      <input type = "hidden" name="SalesFile_Xls" value="<%=csDto.getSalesFile_Xls() %>"></input>
      <input type = "hidden" name="SalesFileNm_Xls" value="<%=csDto.getSalesFileNm_Xls() %>"></input>
      <input type = "hidden" name="SalesFile_Pdf" value="<%=csDto.getSalesFile_Pdf() %>"></input>
      <input type = "hidden" name="SalesFileNm_pdf" value="<%=csDto.getSalesFileNm_Pdf() %>"></input>
      <input type = "hidden" name = "user_id" value="<%=csDto.getChargeID()%>"></input>
      <input type = "hidden" name = "user_id2" value="<%=csDto.getChargeSecondID()%>"></input>
      <!-- ��翵�� (��) -->
      <input type = "hidden" name = "ChargeID" value = "<%=csDto.getChargeID()%>"></input>
      <!-- ��翵�� (��) -->
      <input type = "hidden" name = "ChargeSecondID" value = "<%=csDto.getChargeSecondID()%>"></input>
      
      
      <!-- �ߺ�üũ �÷��� -->
      <input type="hidden" name="trueflag" value="true"></input>
      <input type="hidden" name="falseflag" value="false"></input>
      
	<fieldset>
	<legend>����������Ȳ������</legend>
	<table class="tbl_type" summary="����������Ȳ������(�����ְ���, �����ְ�������, �����ְ������ڿ���ó, ��ǰ�ڵ�(�ڻ�/����), ����, ����������Ʈ��, ������־�(VAT����), ���ְ��ɼ�, ��翵��, ����о߹����η�, ����ñ�)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
        
        <%
        String OrderStatus  = csDto.getOrderStatus();
        if(OrderStatus.equals("N")){        	
        %>
   
            <%
            
            	//�����Է� üũ �κ� 2013_05_09(��)shbyeon.
				String permit=StringUtil.nvl(csDto.getPermitNo(),"");
            	System.out.println("PERMIT:"+permit);
				String checkedyn="";
				String acomp="inline";
				String bcomp="none";

				if(permit != ""){
					checkedyn="";
                    acomp="inline";
					bcomp="none";
				}else{
					checkedyn="checked";
                    acomp="none";
					bcomp="inline";
				}
			%>
          
      <tbody>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����ְ���</label></th>
			<td><input type="checkbox" name="checkyn" <%=checkedyn %> onClick="javascript:directInput();" id="" class="check md0" title="�����Է�" /><label for="">�����Է�</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" maxlength="100" name="comp_nm" title="�����ְ���" class="text" style="display:<%=acomp %>;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readOnly><input type="text" name="e_comp_nm" title="�����ְ���" class="text" style="display:<%=bcomp %>;ime-mode:active;width:300px;" value="<%=csDto.getEnterpriseNm() %>"><!-- 2013_05_02(��)shbyeon. ���������.<a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="�ߺ�Ȯ��" width="52" height="18" /></a> --><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a></td>
		</tr>
							
		<tr>
			<th><label for="">�����ְ�������</label></th>
			<td><input type="text" name="SalesMan" value="<%=csDto.getSalesMan() %>"  id="" class="text" title="�����ְ�������" style="width:200px;" maxlength="7"/></td>
		</tr>
							
		<tr>
			<th><label for="">�����ְ������ڿ���ó</label></th>
			<td><input type="text" id="" name="SalesManTel" value="<%=csDto.getSalesManTel() %>"   maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="�����ְ������ڿ���ó" style="width:200px;" /></td>
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
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
		       					<%
		       						}
		       					%>
						</ul>

						<h6><a href="#none">���ڻ�(����)</a></h6>
							<ul><!-- �ڵ� ��Ȱ��ȭ class="display_none" �߰� -->
								
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
							<ul><!-- �ڵ� ��Ȱ��ȭ class="display_none" �߰� -->
								<li><a href="#none">Avaya PBX</a></li>
								
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
								<%
									
		       						for(int x=0; x<productList.size(); x++){
		       							csDtoPro = new CurrentStatusDTO();
		       							csDtoPro = (CurrentStatusDTO)productList.get(x);
		       					%>
		       							<li id="<%=csDtoPro.getProductCode() %>" ondblclick="delCode('<%=csDtoPro.getProductCode() %>')" style="cursor: pointer;"><a><%=csDtoPro.getProductName() %></a>
		       							<input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>">
		       							
		       							</li>
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
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="" name="OperatingCompany" value="<%=csDto.getOperatingCompany() %>" class="text" title="����" style="width:300px;" maxlength="25"/><input type="checkbox" id="" name="chktest" value="N" class="check" onclick="javascript:chkSaOperatingAdd();" title="�����ְ���� ���ϼ��� " /><label for="">�����ְ���� ���ϼ��� </label></td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����������Ʈ��</label></th>
			<td><input type="text" id="" name="ProjectName" value="<%=csDto.getProjectName() %>" class="text" title="����������Ʈ��" style="width:300px;" maxlength="50" /></td>
		</tr>         
         
		<tr>
			<th><label for="">������־�(VAT����)</label></th>
			<td><input type="hidden" name="SalesProjections"  style="width:80px" value="<%=csDto.getSalesProjections()%>" maxlength="13" /><input type="text" id="" name="SalesProjections_view" value="<%=NumberUtil.getPriceFormat(csDto.getSalesProjections())%>" maxlength="13" class="text text_r" title="������־�(VAT����)" style="width:200px;" onKeyUp = "saleCntCal('currentStaEdit.SalesProjections')"/> ��</td>
		</tr>
        
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ְ��ɼ�</label></th>
          		<td title="���ְ��ɼ�����"><%  
					  CodeParam codeParam = new CodeParam();
          			  codeParam.setType("select"); 
          			  codeParam.setStyleClass("td3");
					  codeParam.setFirst("��ü");
					  codeParam.setName("Orderble");
					  codeParam.setSelected(csDto.getOrderble()); 
					  //codeParam.setEvent("javascript:poductSet();"); 
					  out.print(CommonUtil.getCodeList(codeParam,"A03")); 
			  																%></td>
	  </tr>
		
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��翵��</label></th>
			<td>��&nbsp;&nbsp;<input type="text" name="user_nm" id="" class="text" title="��翵�� ��" style="width:100px;" readOnly value="<%=csDto.getChargeNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>�����ȸ</span></a>&nbsp;&nbsp;/&nbsp;&nbsp;��&nbsp;&nbsp;<input type="text" name="user_nm2" id="" class="text" title="��翵�� ��" style="width:100px;" readOnly value="<%=csDto.getChargeSeNm()%>" onClick="javascript:popSales_Second();"/><a href="javascript:popSales_Second();" class="btn_type03"><span>�����ȸ</span></a>
			<%--
			 <%
			 	String ChargeID = csDto.getChargeID();
			 	String ChargeSecondID = csDto.getChargeSecondID();
			 %>
			  --%> 
			  </td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����о߹����η�</label></th>
			<td><input type="text" id="" name="AssignPerson" value="<%=csDto.getAssignPerson() %>" class="text" title="����о߹����η�" style="width:300px;" maxlength="25" /></td>
		</tr>

        <tr>
          	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ñ�</label></th>
          	<input type="hidden" name="DateProjections" value=""></input>
          	<input type="hidden" name="Quarter" value=""></input>
         
        	<td>
		         <%
		         		//����ñ�DTO Substring ���� 2013.03 2013/03 ������ Select Option���� ��������.
		         			String TargetMonth=StringUtil.nvl(csDto.getDateProjections(),"2013.04");
							int indexxs=TargetMonth.indexOf("2013.04");
							String target_year = TargetMonth.substring(0,4); //subString ("�ڸ����ڼ�","������ ���ڼ�")
							String target_month = TargetMonth.substring(5,7);
		         %>
         
		         <script>
		         document.write("<select name='target_year' id='target_year' title='�⵵ ����' style='width:70px'>");
		          var now = new Date();  
		          var now_year = now.getFullYear() +5; //+1�� ���س⵵���� +1�� �Ѱ�.
		          for (var i=now_year;i>=2010;i--) 
		          {   
		         document.write("<option value='"+i+"'>"+i+"</option>"); 
		         }  
		          document.write(" </select>"); 
		         </script> ��&nbsp;&nbsp;<select name="target_month" id="target_month" title="�� ����" style="width:60px">
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
								
<!-- script ����. -->	
<script>
//select option�� Dto��üũ�� ������ ��� ����(�󼼺�����)
document.currentStaEdit.target_year.value='<%=target_year%>';
document.currentStaEdit.target_month.value='<%=target_month%>';
</script>
<!-- script ���� ��. -->
  
  <%
   }else{	   
  %>
     <!-- comp_nm == EnterpriseNm 
          comp_comd == EnterpriseCode
     -->
            <%
				String comp_code=StringUtil.nvl(csDto.getEnterpriseCode(),"");
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
			%>
        	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����ְ���</label></th>
			<td><%-- <input type="checkbox" name="checkyn" <%=checkedyn %> onClick="javascript:directInput();" id="" class="check md0" title="�����Է�" /><label for="">�����Է�</label>&nbsp;&nbsp;&nbsp;&nbsp; --%><input type="text" maxlength="100" name="comp_nm" class="text" style="display:<%=acomp %>;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readonly="readonly"/><input type="text" name="e_comp_nm" class="text" style="display:<%=bcomp %>;ime-mode:active;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readonly="readonly"/><!-- 2013_05_02(��)shbyeon. ���������. <a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="�ߺ�Ȯ��" width="52" height="18" /></a> --><!-- <input type="text" id="" class="text" title="�����ְ���" style="width:300px;" /><a href="javascript:popComp();" class="btn_type03"><span>��ü��ȸ</span></a> --></td>
		</tr>
							
		<tr>
			<th><label for="">�����ְ�������</label></th>
			<td><input type="text" name="SalesMan" value="<%=csDto.getSalesMan() %>"  id="" class="text" title="�����ְ�������" style="width:200px;" maxlength="7" readonly="readonly"/></td>
		</tr>
							
		<tr>
			<th><label for="">�����ְ������ڿ���ó</label></th>
			<td><input type="text" id="" name="SalesManTel" value="<%=csDto.getSalesManTel() %>"   maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="�����ְ������ڿ���ó" style="width:200px;" readonly="readonly"/></td>
		</tr>
 
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��ǰ�ڵ�(�ڻ�/����)</label></th>
       <td class="prodCode">
			<div id="cart">
				<h5>��ǰ�ڵ�</h5>

					<ol>
								<%
									
		       						for(int x=0; x<productList.size(); x++){
		       							csDtoPro = new CurrentStatusDTO();
		       							csDtoPro = (CurrentStatusDTO)productList.get(x);
		       					%>
		       							<li id="NoCode" ><%=csDtoPro.getProductName() %>
		       							<input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>" readonly="readonly">
		       							<!-- 
		       							<a href="javascript:delCode('<%=csDtoPro.getProductCode() %>');" name='del' title='Delete' class='ui-icon ui-icon-refresh'></a>
		       							 -->
		       							</li>
		       					<%
		       						}
		       					%>

					</ol>
				</div>
				
				<div class="guide">
					<span class="guide_txt"><strong>* �ڻ��ǰ�ڵ� �Ǵ� ���ڻ�ǰ�ڵ� ���� �ϳ��� �������ּ���.</strong><br />
					 <strong>* ����� �Ϸ�� ����������Ȳ�Դϴ�.</strong><br />* ����� �Ϸ�� ����������Ȳ ��� �Է�â�� ���� �� ������ �Ұ����մϴ�.</span>
				</div>
			</td>
		</tr>
			
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
			<td><input type="text" id="" name="OperatingCompany" value="<%=csDto.getOperatingCompany() %>" class="text" title="����" style="width:300px;" maxlength="25" readonly="readonly"/><input type="checkbox" id="" name="chktest" value="N" class="check" onclick="javascript:chkSaOperatingAdd();" title="�����ְ���� ���ϼ��� " /><label for="">�����ְ���� ���ϼ��� </label></td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" readonly="readonly"/></span>����������Ʈ��</label></th>
			<td><input type="text" id="" name="ProjectName" value="<%=csDto.getProjectName() %>" class="text" title="����������Ʈ��" style="width:300px;" maxlength="50" /></td>
		</tr>  			
        
		<tr>
			<th><label for="">������־�(VAT����)</label></th>
			<td><input type="hidden" name="SalesProjections"  style="width:80px" value="<%=csDto.getSalesProjections()%>" maxlength="13"  readonly="readonly"/><input type="text" id="" name="SalesProjections_view" value="<%=NumberUtil.getPriceFormat(csDto.getSalesProjections())%>" maxlength="13" class="text text_r" title="������־�(VAT����)" style="width:200px;" onKeyUp = "saleCntCal('currentStaEdit.SalesProjections')"readonly="readonly" /> ��</td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ְ��ɼ�</label></th>
          		<td><input type="hidden" name="Orderble" class="text" value="<%=csDto.getOrderble() %>"></input>
          		<input type="text" name="OrderbleNm" class="text" value="<%=csDto.getOrderbleNm() %>" style="ime-mode:active;width:200px" readonly="readonly"></input></td>
        </tr>
          
        <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��翵��</label></th>
			<td>��&nbsp;&nbsp;<input type="hidden" name="ChargeID" class="in_txt_off" value="<%=csDto.getChargeID() %>" readonly="readonly"></input><input type="text" name="ChargeNm" id="" class="text" title="��翵�� ��" style="width:100px;" value="<%=csDto.getChargeNm() %>" readonly="readonly"/>&nbsp;&nbsp;/&nbsp;&nbsp;��&nbsp;&nbsp;<input type="hidden" name="ChargeSecondID" class="in_txt_off" value="<%=csDto.getChargeSecondID() %>" readonly="readonly"></input><input type="text" name="ChargeSecondNm" id="" class="text" title="��翵�� ��" style="width:100px;" value="<%=csDto.getChargeSeNm() %>" readonly="readonly"/></td>
		</tr>
          
		  
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����о߹����η�</label></th>
			<td><input type="text" id="" name="AssignPerson" value="<%=csDto.getAssignPerson() %>" class="text" title="����о߹����η�" style="width:300px;" maxlength="25" readonly="readonly"/></td>
		</tr>

        <tr>
          	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ñ�</label></th>
          	<!-- �̰���϶� Substring ������ �����.
          	<input type="hidden" name="DateProjections"  value=""></input> -->
          	<input type="hidden" name="Quarter" value=""></input>
         <td >
         <!-- 
        	<input type="hidden" name="DateProjections" value="<%=csDto.getDateProjections() %>"></input>
          -->
        	<input type="text" name="DateProjections" class="text" value="<%=csDto.getDateProjections() %>" style="width:200px;" readonly="readonly"></input></td>
        </tr>
        
  <%
   }
  %>
  				</tbody>
        	</table>
        </fieldset>
    </form>
    
    <%if(OrderStatus.equals("N")){ %>
    <!-- Bottom ��ư���� -->
	<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
	<!-- //Bottom ��ư���� -->
    <%
    }else{    	
    %>
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
   <!-- //button -->
    <%
    }
    %>
</div>
</div>
<div class="issueComm">
	<h4>Issue Comment</h4>
	<form name="currentCommentIframe" method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		
		<fieldset>
		<legend>Issue Comment</legend>
		
		<%
		String ID = UserBroker.getUserId(request); //�α��� �� ���� ID
		String NAME = UserBroker.getUserNm(request); //�α��� �� ���� �̸�
		%>
		
		<!-- �ش� �̽� �ڸ�Ʈ ������ �Ʒ� �ʱ� ��� �� ����-->
		<!-- �̽� �ڸ�Ʈ ��� �� �ش� �̽� �ڸ�Ʈ �������� �������� Hidden ��  Action ���� �Ѱ��ֱ�. -->
		<input type="hidden" name="PreSalesCode" value="<%=csDto.getPreSalesCode() %>"></input>
	
	<!-- �̽������ -->
	<div class="issueCon_area">	
		
		<ul class="info">			
			<li><label for="">�̽� ����� :</label> <input type="text" id="" name="SalesMan_co" class="text" title="�̽� �����" style="width:100px;" maxlength="10"/></li>
			<!-- �α��� ���� ID ��翵�� �Ķ���� �Ѱ��༭ ��Ͻ� ������ �� DB���. -->
			<li><span>��翵�� : <%=NAME %></span></li>
			<li><span>����� : <%=todayDate %></span></li>			
		</ul>

		<ul class="issueCon">
			<li><textarea id="" name="Contents" title="�̽�����" style="width:1078px;height:50px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></li>
			<li><div class="fileUp"><input type="text" class="text" id="file1" title="÷������" style="width:1015px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="SalesFile" id="upload1" /></div></li>
			<input type="hidden" name="SalesFileNm" value=""></input>
			<li class="btn_regist"><a href="javascript:goSaveRep();">���</a></li>
			
			<!-- ����/���� ��ư
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goSaveRep();" title="������ư" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goSaveRep();" title="������ư" /></a></p>
			 -->
			
			<li><span class="guide_txt">* ÷�ΰ��� �������� : ��� ���� / ÷�ΰ��� �뷮 : �ִ� 200M</span></li>
		</ul>
	</div>
		

		</fieldset>
</form> 
	
	<div id="MakeView"  ></div>  	
		<%
		//����Ʈ �������� ����.
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();
		
		int iTotCnt = ld.getTotalItemCount(); //�ѵ����ͼ�
		int iCurPage = ld.getCurrentPage();	//������������
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
		%>
		
		 <!-- :: loop :: -->
        <!--����Ʈ---------------->
     
     <%
     	//����������Ȳ�� ��ϵ� pk �� Issue Comment Pk �� �����鼭 ������ ������ �Ʒ� List����.
     	
     	String pjc = csDto.getProjectPkCo();	 //�ڸ�Ʈ ����(����������Ȳ==�ڸ�Ʈ) pk
     	String pj  = csDto.getPreSalesCode();	 //����������Ȳ pk
     	
     	if(pjc.equals("") == pj.equals("")){		
     %>
        <%
                if (ld.getItemCount() > 0) {
                    
                	int i = 0;
                	
                    while (ds.next()) {
                    	//System.out.println("TEST:"+ds.getString("CreateDate"));
            %>
	            <%
	             //�ڸ�Ʈ �۾��� ���� üũ �� ����/���� ���� Ȱ��ȭ �� ��Ȱ��ȭ
	             if(UserBroker.getUserId(request).equals(ds.getString("ChargeID_co"))){
	            	 
	            %>
		
		<!-- �ڸ�Ʈ ���� ��. -->
		<form name="currentCommentIframe_<%=ds.getString("ComentPk") %>"  method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		<input type="hidden" name="ComentPk" value=""></input>
		
		
		<div id="displayDiv" name="displayDiv"  class="issueCon_area">
		<fieldset>
		<ul class="info">
			<li><label for="">�̽� ����� :</label> <input type="text" name="SalesMan_co" value="<%=ds.getString("SalesMan_co") %>" id="" class="text" title="�̽� �����" style="width:100px;" maxlength="10" readonly="readonly"/></li>
			<!-- �α��� ���� ID ��翵�� �Ķ���� �Ѱ��༭ ����/������ DB ������ �̷� ID ����. -->
			<input type="hidden" name="ChargeID_co" value="<%=ID %>"></input>
			<li><span>��翵�� :  <%=ds.getString("ChargeNm") %></span></li>
			<li><span>����� : <%=ds.getString("CreateDate") %></span></li>
			
			<%
				
             String SalesFile=ds.getString("SalesFile"); //�������ϰ��
             String SalesFileNm=ds.getString("SalesFileNm");
              
//              String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
             //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();				
              int c_index=SalesFile.lastIndexOf("/"); // /�������� ����ڸ���.
            	
              String salesfilename=SalesFile.substring(c_index+1); // /�������� �ڸ� ���ڿ�1���� ��ġ��
        
              String salespath=""; //���ϰ�� �о����
             
              	
    
              if(!SalesFile.equals("")){
            	  salespath=SalesFile.substring(0,c_index); //���ϰ�� �о����
            	
            	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
              	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
              	String spStrReplace = "";
              	if(SalesFileNm.indexOf("&") != -1){
              		spStrReplace=  SalesFileNm.replace("&", "[replaceStr]");
              	System.out.println("spStrReplace:"+spStrReplace);
              	}else{
              		spStrReplace =  SalesFileNm;	
              	System.out.println("spStrReplace:"+spStrReplace) ;
              	}
				%>
				<li class="btn"><a id="SfilePath_<%=ds.getString("ComentPk") %>" href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=salesfilename%>&filePath=<%=salespath%>" class="btn_type03" ><span>÷�����ϴٿ�ε�</span></a></li>
            	<%
                     }
               
                %>
		</ul>

		<ul class="issueCon">
			<li><textarea id="" name="Contents" title="�̽�����" style="width:1078px;height:50px;" onKeyUp="js_Str_ChkSub('3000', this)" readonly="readonly" ><%=ds.getString("Contents") %></textarea></li>
		</ul>
				
			
			<!-- 
			<p class="btn_saveComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg_save_curr.gif" onclick="javascript:goSaveRep();" title="��Ϲ�ư" /></a></p>
			 -->
			<!-- ����/���� ��ư
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goUpdateRep('<%=ds.getString("ComentPk") %>');" title="������ư" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goDeleteRep('<%=ds.getString("ComentPk") %>');" title="������ư" /></a></p>
			 -->
		</fieldset>
		</div>
		</form>
		<%
	             }else{	            	 
        %>
        
        <!-- �ڸ�Ʈ ���� ��. -->
		<form name="currentCommentIframe_<%=ds.getString("ComentPk") %>"  method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		<input type="hidden" name="ComentPk" value=""></input>
		<div id="displayDiv" name="displayDiv" class="issueCon_area">
		<legend>Issue Comment</legend>
		<fieldset>
		<ul class="info">
			<!-- �ٸ� �α��λ���� �϶� -->
			<li><label for="">�̽� ����� :</label> <input type="text" name="SalesMan_co" value="<%=ds.getString("SalesMan_co") %>" id="" class="text" title="�̽� �����" style="width:100px;" maxlength="10" readonly="readonly"/></li>
			<!-- �α��� ���� ID ��翵�� �Ķ���� �Ѱ��༭ ����/������ DB ������ �̷� ID ����. -->
			<input type="hidden" name="ChargeID_co" value="<%=ID %>"></input>
			<li><span>��翵�� : <%=ds.getString("ChargeNm") %></span></li>
			<li><span>����� : <%=ds.getString("CreateDate") %></span></li>
			
			<%
				
             String SalesFile=ds.getString("SalesFile"); //�������ϰ��
             String SalesFileNm=ds.getString("SalesFileNm");
              
//              String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
             //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();
              int c_index=SalesFile.lastIndexOf("/"); // /�������� ����ڸ���.
            	
              String salesfilename=SalesFile.substring(c_index+1); // /�������� �ڸ� ���ڿ�1���� ��ġ��
        
              String salespath=""; //���ϰ�� �о����
             
              	
    
              if(!SalesFile.equals("")){
            	  salespath=SalesFile.substring(0,c_index); //���ϰ�� �о����	
            	  
            		//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                	String spStrReplace = "";
                	if(SalesFileNm.indexOf("&") != -1){
                		spStrReplace=  SalesFileNm.replace("&", "[replaceStr]");
                	System.out.println("spStrReplace:"+spStrReplace);
                	}else{
                		spStrReplace =  SalesFileNm;	
                	System.out.println("spStrReplace:"+spStrReplace) ;
                	}
				%>
				<li class="btn"><a id="SfilePath_<%=ds.getString("ComentPk") %>" href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=salesfilename%>&filePath=<%=salespath%>" class="btn_type03"><span>÷�����ϴٿ�ε�</span></a></li>
            	<%
                     }
               
                %>
		</ul>

		<ul class="issueCon">
			<li><textarea name="Contents" style="ime-mode:active;width:1078px;height:50px;"  title="�ڸ�Ʈ �Է�" dispName="����" onKeyUp="js_Str_ChkSub('3000', this)" readonly="readonly"><%=ds.getString("Contents") %></textarea></li>
        </ul>
			<!-- 
			<p class="btn_saveComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg_save_curr.gif" onclick="javascript:goSaveRep();" title="��Ϲ�ư" /></a></p>
			 -->
			<!-- ����/���� ��ư
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goUpdateRep('<%=ds.getString("ComentPk") %>');" title="������ư" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goDeleteRep('<%=ds.getString("ComentPk") %>');" title="������ư" /></a></p>
			 -->
		
		</fieldset>
		</div>
		</form>
	          <%
	             }
	          %>

		  <!-- :: loop :: -->
		        <%   
		        i++;
		        %>   
        <%
              }
           }	
     	}
        %>
        
        
 
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
	<iframe name="hiddenframe" frameBorder=0 width="0" height="0" ></iframe> 
</html>
<%= comDao.getMenuAuth(menulist,"10") %>
<script type="text/javascript">fn_fileUpload();</script>