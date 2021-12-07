<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String strDate = (String)model.get("strDate");
	String listType = (String)model.get("listType");
	
	//Date ����(2013-12-27) ���� ��¥�� type �����ֱ�.
		String StartDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String EndDateTime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������� ����Ʈ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


/*���۽ð� ���ý� ����ð�(+3)�ڵ�����
 * 2013_05_08(��)shbyeon.
 */
 
function func_Select(){

	var selStart = document.getElementById('Start_Hour');
	var selEnd = document.getElementById('End_Hour');
	var StartIndex = selStart.selectedIndex;

	
	    /* StartHour ���ý� +3 EndHour ���� ��� ����.
	       Start �ð��� ���� 23�� ��(index�� 23)���� �ִ�. 24�ô� ���⶧��.
	   	      �׷��Ƿ� 21�� �� Ʋ�� 00��~20�� ������ �ð��� EndHour �� + 3�ð� ������
	       21�� ������ +3�ð��̶�� 24�� �� 00 �� �� �ʱ�ȭ ������� �ϹǷ� + 0�� ��.
	  	   22�ÿ� 23�� �� 21�ÿ� ��������.
		*/
		if(StartIndex != 21){
		  selEnd.selectedIndex = StartIndex+3; 	
		}
		if(StartIndex == 21){
		  selEnd.selectedIndex = 0;
		}
		if(StartIndex == 22){
			  selEnd.selectedIndex = 1;
		}
		if(StartIndex == 23){
			  selEnd.selectedIndex = 2;
		}
}



function goSave(){
	var frm = document.projectRegist; 
	
	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.ReportFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);
	
	if(fileCheckNm(strFileName)> 200){
		alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
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
	
	if(frm.CompanyCode.value == ""){
		alert("�������� ��� ����Ʈ�� �����ϼ���");
		return;
	}
	if(frm.Start_Hour.value == ""){
		alert("���� ���۽ð��� �����ϼ���");
		return;
	}
	if(frm.Start_Minute.value == ""){
		alert("���� ���۽ð�(��)�� �����ϼ���");
		return;
	}
	if(frm.End_Hour.value == ""){
		alert("���� ����ð��� �����ϼ���");
		return;
	}
	if(frm.End_Minute.value == ""){
		alert("���� ����ð�(��)�� �����ϼ���");
		return;
	}
	
	var dates = frm.StartDateTime.value;
	var StartDateTimes = dates.replace(/-/g,'');
	frm.pYear1.value = StartDateTimes.substr(0,4);
	frm.pMonth1.value = StartDateTimes.substr(4,2);
	frm.pDay1.value = StartDateTimes.substr(6,2);
	
	frm.StartDateTime.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	var dates = frm.EndDateTime.value;
	var EndDateTimes = dates.replace(/-/g,'');
	frm.pYear5.value = EndDateTimes.substr(0,4);
	frm.pMonth5.value = EndDateTimes.substr(4,2);
	frm.pDay5.value = EndDateTimes.substr(6,2);
	
	frm.EndDateTime.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;
	
	
	var sdate=frm.pYear1.value+frm.pMonth1.value+frm.pDay1.value+frm.Start_Hour.value+frm.Start_Minute.value;
	var edate= frm.pYear5.value+frm.pMonth5.value+frm.pDay5.value+frm.End_Hour.value+frm.End_Minute.value;

	if(sdate>edate){
		alert('�������� �����Ϻ��� Ů�ϴ�.');
		return false;
	}

	
	if(frm.target_year.value == ""){
		alert("������� (�⵵)�������ϼ���");
		return;
	}
	if(frm.target_month.value == ""){
		alert("������� (��)�������ϼ���");
		return;
	}
	if(frm.user_nm.value == ""){
		alert("����ڸ� �����ϼ���");
		return;
	}
	if(frm.CustChargeNm.value == ""){
		alert("���� ����ڸ� �Է��ϼ���");
		return;
	}
	if(frm.WorkSite.value == ""){
		alert("������Ҹ� �Է��ϼ���.");
		return;
	}
	if(frm.WorkContents.value == ""){
		alert("���೻���� �Է��ϼ���.");
		return;
	}
	if(frm.ReportFile.value != "" && !isImageFile(frm.ReportFile.value)){
			alert("���� ������  ÷�� ������ ���� ������ \n PDF, GIF, JPG, TIF, BMP �̻� 5�� �Դϴ�.");
			return; 				
	}
	frm.StartDateTime.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value+' '+frm.Start_Hour.value+':'+frm.Start_Minute.value;
	frm.EndDateTime.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value+' '+frm.End_Hour.value+':'+frm.End_Minute.value;
	
	frm.TargetMonth.value=frm.target_year.value+frm.target_month.value;
	frm.ChargeID.value = frm.user_id.value;
	frm.FileNm.value = strFileName;
	
	frm.submit();
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


//Ư������ �Ұ�check
function inputCheckSpecial(){
	var strobj = document.projectRegist.CustChargeNm;
	re =/[.,~!@\#$%^&*\()\-=+_{}]/;
	if(re.test(strobj.value)){
		alert("�̸����� �ѱ�, ���� ��ҹ���, ���ڸ� �̿��� �ּ���.");
		strobj.value=strobj.value.replace(re,"");
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
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp"|| ext == "doc") {
				return true;
			} else {
				return false;
			}
		}
	}
	
	
	  //�޷� �ؽ�Ʈ �Է�â ù��°.
	  function datepickerInputText1(){
		  var frm = document.projectRegist;	//������
		  var inputDate1;									//������Ʈ ���� ������ �Է� �� ��������
		  var strY1;										//������Ʈ ���� ������ �Է� �� (-)�߶� �⵵�� ���
		  var strM1;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���
		  var strD1;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���
		  
		  inputDate1 = frm.StartDateTime.value; //������Ʈ ���� �����Ͽ� �ԷµǴ� ��/��/��
		  
		  if(inputDate1.length == 8){
			  inputDate = $('#calendarData1').val();	//������Ʈ ���� ������ input�� �Էµ� �� �ҷ�����.

			  strY1 = inputDate1.substr(0,4); //�Է� �⵵�� ������ ������ ���.
			  strM1 = inputDate1.substr(4,2); //�Է� ���ڸ� ������ ������ ���.
			  strD1 = inputDate1.substr(6,2); //�Է� ���ڸ� ������ ������ ���.
			  
			 
			  frm.StartDateTime.value = strY1+'-'+strM1+'-'+strD1; //����Ʈ ��¥ �Ѱ� �ֱ����� ���� yyyy-mm-dd ���߱�.
		  }else if(event.keyCode == 8){
			  //alert('������Ʈ ���� �������� ��Ȯ�� �Է����ּ���.(ex1900-01-01)');
			  frm.StartDateTime.value=''; //�ؽ�Ʈ ��¥ �Է� ���� �� �ؽ�Ʈ �Է� â �ʱ�ȭ.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  //�޷� �ؽ�Ʈ �Է�â �ι�°.
	  function datepickerInputText2(){
		  var frm = document.projectRegist;	//������
		  var inputDate2;									//������Ʈ ���� ������ �Է� �� ��������
		  var strY2;										//������Ʈ ���� ������ �Է� �� (-)�߶� �⵵�� ���
		  var strM2;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���
		  var strD2;										//������Ʈ ���� ������ �Է� �� (-)�߶� ���ڸ� ���

		 inputDate2 = frm.EndDateTime.value; //������Ʈ ���� �����Ͽ� �ԷµǴ� ��/��/��
		  
		  if(inputDate2.length == 8){
			  inputDate2 = $('#calendarData2').val();	//������Ʈ ���� ������ input�� �Էµ� �� �ҷ�����.

			  strY2 = inputDate2.substr(0,4); //�Է� �⵵�� ������ ������ ���.
			  strM2 = inputDate2.substr(4,2); //�Է� ���ڸ� ������ ������ ���.
			  strD2 = inputDate2.substr(6,2); //�Է� ���ڸ� ������ ������ ���.
			 
			  frm.EndDateTime.value = strY2+'-'+strM2+'-'+strD2; //����Ʈ ��¥ �Ѱ� �ֱ����� ���� yyyy-mm-dd ���߱�.
			  
		  }else if(event.keyCode == 8){
			  //alert('������Ʈ ���� �������� ��Ȯ�� �Է����ּ���.(ex1900-01-01)');
			  frm.EndDateTime.value=''; //�ؽ�Ʈ ��¥ �Է� ���� �� �ؽ�Ʈ �Է� â �ʱ�ȭ.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	  
	  function dateProgressStatus()
	    {
		var frm = document.projectRegist;		//form
		var startDate = $('#calendarData1').val();		//������Ʈ ���ۿ��� ��
		var endDate = $('#calendarData2').val();			//������Ʈ ���Ό�� ��
	        
		/*
		    // FORMAT("-")�� ������ ���� üũ
	        if (startDate.length != 10 || endDate.length != 10){
	        	
	            return null;
	        }

	        // FORMAT("-")�� �ִ��� üũ
	        if (startDate.indexOf("-") < 0 || endDate.indexOf("-") < 0){
	        	
	            return null;
	        }
		*/
	        // �⵵, ��, �Ϸ� �и�
	        var start_dt = startDate.split("-");
	        var end_dt = endDate.split("-");

	        // �� - 1(�ڹٽ�ũ��Ʈ�� ���� 0���� �����ϱ� ������...)
	        // Number()�� �̿��Ͽ� 08, 09���� 10������ �ν��ϰ� ��.
	        start_dt[1] = (Number(start_dt[1]) - 1) + "";
	        end_dt[1] = (Number(end_dt[1]) - 1) + "";
		
	        var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]); //���� ������.(��,��,��)
	        var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);		   //���� ������.(��,��,��)

	        if(to_dt.getTime() < from_dt.getTime()){
				alert('�������ں��� �������ڰ� Ů�ϴ�.');
				//���ۿ������� �� Ŭ �� ���� ��¥�� �ʱ� ��¥ ����.
				frm.EndDateTime.value='<%=strDate%>';	
				frm.StartDateTime.value='<%=strDate%>';
				return;
			}
	    }
	
	
	
	
	
	
	
	
	
	
	
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=projectRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}

	function cancle(){
		
		var frm = document.projectRegist;
		if ("P" == frm.listType.value) {
			frm.action='<%= request.getContextPath()%>/B_Project.do?cmd=projectPageList';	
		} else {
			frm.action='<%= request.getContextPath()%>/B_Project.do?cmd=projectPageListAll';
		}		
		frm.submit();

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
  <!-- title -->
  <div class="content_navi">������Ʈ���� &gt; ��������</div>
<h3><span>��</span>�����˵��</h3>
  <!-- //title -->

  <!-- con -->
  <div class="con">
  <div class="conTop_area">
 <!-- �ʼ��Է»����ؽ�Ʈ -->
<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
 <!-- //�ʼ��Է»����ؽ�Ʈ -->
</div>
  
    <form name="projectRegist" method="post" action="<%= request.getContextPath()%>/B_Project.do?cmd=projectRegist" enctype="multipart/form-data">
     <input type = "hidden" name = "curPage" value="<%=curPage%>">
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>">
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
      <input type="hidden" name="TargetMonth">
	  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
	  <input type = "hidden" name = "ChargeID" value="">
	  	  
	 <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>

     <input type = "hidden" name = "pYear5" value=""/>
     <input type = "hidden" name = "pMonth5" value=""/>
     <input type = "hidden" name = "pDay5" value=""/>
     <input type = "hidden" id = "listType" name = "listType" value="<%=listType%>"/>
      
      <fieldset>
		<legend>�������˵��</legend>
      
      <table class="tbl_type" summary="�������˵��(����, ��������, ��������, ����, �ۼ���, �����, ��������, �������, ���೻��, Ư�̻���, �������˺���)">
						
        <caption>���˻���Ʈ ������</caption>
        <colgroup>
		<col width="20%" />
		<col width="*" />
		</colgroup>
		<tbody>
         		<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							//codeParam.setFirst("��ü");
							codeParam.setName("CompanyCode");
							codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A06")); 
						%></td>
			

         		</tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td><span class="ico_calendar"><input id="calendarData1" name="StartDateTime" class="text" style="width:100px;" value="<%=strDate%>"onkeyup="javascript:datepickerInputText1();  dateProgressStatus();" onchange="javascript:dateProgressStatus();"/></span>&nbsp;&nbsp;���۽ð�&nbsp;&nbsp;<select name="Start_Hour" id="Start_Hour" title="�ð� ����" onchange="javascript:func_Select()">
							<option value='00'>00��</option>
							<option value='01'>01��</option>
							<option value='02'>02��</option>
							<option value='03'>03��</option>
							<option value='04'>04��</option>
							<option value='05'>05��</option>
							<option value='06'>06��</option>
							<option value='07'>07��</option>
							<option value='08'>08��</option>
							<option value='09'>09��</option>
							<option value='10'>10��</option>
							<option value='11'>11��</option>
							<option value='12' selected="selected">12��</option>
							<option value='13'>13��</option>
							<option value='14'>14��</option>
							<option value='15'>15��</option>
							<option value='16'>16��</option>
							<option value='17'>17��</option>
							<option value='18'>18��</option>
							<option value='19'>19��</option>
							<option value='20'>20��</option>
							<option value='21'>21��</option>
							<option value='22'>22��</option>
							<option value='23'>23��</option>
						</select> <select name="Start_Minute" id="Start_Minute" title="�� ����">
							<option value='00'>00��</option>
							<option value='10'>10��</option>
							<option value='20'>20��</option>
							<option value='30'>30��</option>
							<option value='40'>40��</option>
							<option value='50'>50��</option>
						</select>
          </td>
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td ><span class="ico_calendar"><input id="calendarData2" name="EndDateTime" class="text" style="width:100px;" value="<%=strDate%>"onkeyup="javascript:datepickerInputText2(); dateProgressStatus();" onchange="javascript:dateProgressStatus();"/></span>&nbsp;&nbsp;����ð�&nbsp;&nbsp;<select name="End_Hour" id="End_Hour" title="�ð� ����" selected>
							<option value='00'>00��</option>
							<option value='01'>01��</option>
							<option value='02'>02��</option>
							<option value='03'>03��</option>
							<option value='04'>04��</option>
							<option value='05'>05��</option>
							<option value='06'>06��</option>
							<option value='07'>07��</option>
							<option value='08'>08��</option>
							<option value='09'>09��</option>
							<option value='10'>10��</option>
							<option value='11'>11��</option>
							<option value='12' selected="selected">12��</option>
							<option value='13'>13��</option>
							<option value='14'>14��</option>
							<option value='15'>15��</option>
							<option value='16'>16��</option>
							<option value='17'>17��</option>
							<option value='18'>18��</option>
							<option value='19'>19��</option>
							<option value='20'>20��</option>
							<option value='21'>21��</option>
							<option value='22'>22��</option>
							<option value='23'>23��</option>
						</select>
						<select name="End_Minute" id="End_Minute" title="�� ����">
							<option value='00'>00��</option>
							<option value='10'>10��</option>
							<option value='20'>20��</option>
							<option value='30'>30��</option>
							<option value='40'>40��</option>
							<option value='50'>50��</option>
						</select>
            </td>
        </tr>
  
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
         <td>
         <script>
         document.write("<select name='target_year' id='target_year' title='�⵵ ����'>");
          var now = new Date();  
          var now_year = now.getFullYear(); 
          for (var i=now_year;i>=2002;i--) 
          {   
         document.write("<option value='"+i+"'>"+i+"��</option>"); 
         }  
          document.write(" </select>"); 
         </script> <select name="target_month" id="target_month" title="�� ����">
				    <option value='01'>1��</option>
				    <option value='02'>2��</option>
				    <option value='03'>3��</option>
				    <option value='04'>4��</option>
				    <option value='05'>5��</option>
				    <option value='06'>6��</option>
				    <option value='07'>7��</option>
				    <option value='08'>8��</option>
				    <option value='09'>9��</option>
				    <option value='10'>10��</option>
				    <option value='11'>11��</option>
				    <option value='12'>12��</option>
				</select>

   

	</td>
	</tr>
        <tr>
          <th><label for="">�ۼ���</label></th>
          <td><input type="text" name="" class="text dis" title="�ۼ���" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����</label></th>
          <td><input type="text" name="user_nm" class="text" style="width:200px" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>�����ȸ</span></a></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td><input type="text" name="CustChargeNm" value="" onkeyup="inputCheckSpecial()" class="text" style="width:200px;" maxlength="10"  /></td>
        </tr>
         <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�������</label></th>
          <td><input type="text" name="WorkSite" value="" class="text" title="�������" style="width:916px;" maxlength="50"  /></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���೻��</label></th>
          <td><input type="text" name="WorkContents" value="" class="text" title="���೻��" style="width:916px;" maxlength="50"  /></td>
        </tr>
         <tr>
          <th><label for="">Ư�̻���</label></th>
          <td><textarea name="IssueReport" value=""class="text" title="Ư�̻���" style="width:916px;height:41px;" dispName="Ư�̻��� " onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
        </tr>
     		<input type="hidden" name="FileNm" value=""></input>
     	<tr>
          <th><label for="">�������˺���</label></th>
          <td>
          <div class="fileUp"><input type="text" class="text" id="file1" title="�������˺���" style="width:494px;" />
          	<a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a>
          	<input type="file" name="ReportFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* ÷�ΰ��� �������� : PDF, GIF, JPG, TIF, BMP / ÷�ΰ��� �뷮 : �ִ� 10M</span></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle()" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
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

<%= comDao.getMenuAuth(menulist,"23") %>
<script type="text/javascript">fn_fileUpload();</script>