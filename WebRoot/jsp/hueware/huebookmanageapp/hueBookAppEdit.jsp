<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.huebookmanage.HueBookManageDTO" %>
<%@ page import="com.huation.common.user.UserBroker"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	HueBookManageDTO hbDto = (HueBookManageDTO)model.get("hbDto");
	String strDate = (String)model.get("strDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>HueBook �������� �󼼺���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
//����Ϸ�
function goSaveApp(){
	var frm = document.hueBookAppView; 
	
	//��������
  	var dates = frm.clearDate.value;
	var clearDates = dates.replace(/-/g,'');
	
	frm.pYear1.value = clearDates.substr(0,4);
	frm.pMonth1.value = clearDates.substr(4,2);
	frm.pDay1.value = clearDates.substr(6,2);
	frm.clearDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	var clDate = frm.clearDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;
		if(frm.requestDate.value > clDate){
			alert('�������ں��� ��û���ڰ� Ů�ϴ�.');
			return;
		}
		if(frm.approvalAndReturn.value == ""){
			alert("����/�ݷ������� �Է��ϼ���.");
			return;
		}
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditY'	
				  
	frm.clearDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;
	frm.approvalUser.value = frm.user_id.value;
	frm.submit();
	}
}
//�ݷ�
function goReturns(){
	var frm = document.hueBookAppView; 
		if(frm.approvalAndReturn.value == ""){
			alert("����/�ݷ������� �Է��ϼ���.");
			return;
		}
	if(confirm("�ݷ� �Ͻðڽ��ϱ�?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditRT'	

	frm.approvalUser.value = frm.user_id.value;
	frm.submit();
	}
}
//���ſϷ�
function goSaveBuy(){
	var frm = document.hueBookAppView; 
	//��������
		var dates = frm.buyDate.value;
		var buyDates = dates.replace(/-/g,'');
		
		frm.pYear1.value = buyDates.substr(0,4);
		frm.pMonth1.value = buyDates.substr(4,2);
		frm.pDay1.value = buyDates.substr(6,2);
		frm.buyDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		
	var buyDate = frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;	

		if(frm.clearDate.value > buyDate){
			alert('�������ں��� �������ڰ� Ů�ϴ�.');
			return;
		}
		if(frm.buyPrice.value == ""){
			alert('���Ű����� �ʼ��Դϴ�.');
			return;
		}
		//����ó �Է� ��ȿ�� �˻� �߰�(21.10.18) START
		if(frm.purchasingOffice.value == ""){
			alert('����ó�� �Է����ֽñ� �ٶ��ϴ�.');
			return false;
		}
		//����ó �Է� ��ȿ�� �˻� �߰� END
	if(confirm("���ſϷ� �Ͻðڽ��ϱ�?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditBuy'	

	frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;

	frm.submit();
	}
}
//���ſϷ�
function goSaveBuy2(){
	var frm = document.hueBookAppView;
	//���ſϷ�(status==3)�� ��� �ɷ�����(21.10.18) START
	var status = document.getElementById("status4Modify").value; 
	if(status == 3){
		alert("���ſϷ���� �ݷ��� �Ұ��մϴ�.");
		return false;
	}
	//���ſϷ�(status==3)�� ��� �ɷ����� END
	
	//��������
		var dates = frm.buyDate.value;
		var buyDates = dates.replace(/-/g,'');
		
		frm.pYear1.value = buyDates.substr(0,4);
		frm.pMonth1.value = buyDates.substr(4,2);
		frm.pDay1.value = buyDates.substr(6,2);
		frm.buyDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		frm.updateYN.value = "Y";
		
	var buyDate = frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;	

		if(frm.clearDate.value > buyDate){
			alert('�������ں��� �������ڰ� Ů�ϴ�.');
			return;
		}
		if(frm.buyPrice.value == ""){
			alert('���Ű����� �ʼ��Դϴ�.');
			return;
		}
	if(confirm("�ݾ׼��� �Ͻðڽ��ϱ�?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditBuy'	

	frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;

	frm.submit();
	}
}
/*
 * int ���� üũ õ������ (1,000)����Ͽ� �����ص� �޸� ǥ��
 * ���� int���� ������.
 */
 function saleCntCal(form){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+'_view');
		var frm=eval("document."+form);
		var costobj=document.hueBookAppView;

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
		
		if(form=='hueBookAppView.buyPrice'){	
			var price=parseInt(onlyNum(costobj.buyPrice.value)*1,10);//<���� �������ٰ�
			costobj.buyPrice.value=addCommaStr(''+price); 
		    costobj.buyPrice.value=price;
		    
		}
		v_obj.focus();
	}

   //���
	function goList(){
		
		var frm = document.hueBookAppView;
		frm.action='<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList';
		frm.submit();
   }

	//��������ȸ
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=hueBookAppView","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
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
  <div class="content_navi">HUEBook &gt; ��������</div>
  <h3><span>��</span>�����������</h3>
  <!-- con -->
  <div class="con">
  <!-- ������ ��� ���� -->
	<div class="conTop_area">
		<!-- �ʼ��Է»����ؽ�Ʈ -->
		<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
		<!-- //�ʼ��Է»����ؽ�Ʈ -->
	</div>
  
  
    <form name="hueBookAppView" method="post">
     <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>
     <input type = "hidden" name = "updateYN" value="N"/>
     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
  	 <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
  	 <!-- status�� ���ſϷ��� ��� ������� �Ұ�ó���� -->
  	 <input type = "hidden" name = "status4Modify" id="status4Modify" value="<%=hbDto.getStatus()%>"/>
  	 
	  	<!-- Update�� �Ѱ��� ����(pk��) -->
	   <input type="hidden" name="SeqPk" value="<%=hbDto.getSeqPk()%>"></input>	
	   <!-- ������°� Action Null�����γѱ�(2.����Ϸ�)Setting -->
	   <input type="hidden" name="status" value=""></input>
	   
   <table class="tbl_type" summary="�������������(��û��, �о�, ������, ���ǻ�, ����, ����, ����, ��û(��)��, ��û����, ��������, ��������, ���Ű���, ������, ����ó, ����(����), ����/�ݷ�����)">
     <% //�޷°�ü �������� ���� 
     DateParam dateParam = new DateParam(); 
     %>
     
     <fieldset>
        <caption>������û ������</caption>
        <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��û��</label></th>
          <td><input type="text" name="" class="text dis" title="��û��" style="width:200px;" readOnly value="<%=hbDto.getRequestName()%>"></input></td>	
    	</tr>
    	<tr>
    		<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�о�</label></th>	
          	<td>
          		<!-- �о��ڵ�NAME�� �����ð� ����PARAM�ѱ�������. -->
          		<input type="text" name="branchCodeNm" value="<%=hbDto.getBranchCodeNm() %>" class="text dis" title="�о�" style="width:200px;" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="������" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	    </tr>
	    <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ǻ�</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="���ǻ�" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="����" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">����</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="����" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">����</label></th>
          <input type="hidden" name="price" class="text text_r dis"  title="����" style="width:200px;"" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="����" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> ��<span class="guide_txt">&nbsp;&nbsp;* ��ȭ�� �ƴѰ�� ȯ���� ����ؼ� �Է����ּ���.</span></td>
		</tr>
		<tr>
          	  <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��û(��)��</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="��û(��)��" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
      
		
		<%
			String statusChk1 ="1"; //(��û��)
			String statusChk2 ="2"; //(����Ϸ�)
			String statusChk3 ="3"; //(���ſϷ�)
			String statusChk4 ="4"; //(�ݷ�)
			
			//���ſϷ�
				if(statusChk3.equals(hbDto.getStatus())){			
		%>
		   <th><label for="">��û����</label></th>
			<td>
			<span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input>
       	 	<!-- ������ ID�Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="approvalUser" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 	<!-- �о� �ڵ�ID �Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="branchCode" value="<%=hbDto.getBranchCode() %>"></input>
       	 	<!-- ��û�� ID�Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="requestUser" value="<%=hbDto.getRequestUser() %>"></input>
			</td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
		</tr>
		<tr>
		   <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getClearDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->	
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="buyDate" value="<%=hbDto.getBuyDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getBuyDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->		
		</tr>
		<tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���Ű���</label></th>
          <input type="hidden" name="buyPrice" class="text text_r dis"  title="���Ű���" style="width:200px;" value="<%=hbDto.getBuyPrice() %>"   maxlength="9" />
<%--           <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>" title="���Ű���" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r dis" readonly="readonly"/> ��<span class="guide_txt">&nbsp;&nbsp;* ��ȭ�� �ƴѰ�� ȯ���� ����ؼ� �Է����ּ���.</span></td><!-- input ��Ȱ��ȭ class="dis" �߰� --> --%>
          <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>" title="���Ű���" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r" /> ��<span class="guide_txt">&nbsp;&nbsp;* ��ȭ�� �ƴѰ�� ȯ���� ����ؼ� �Է����ּ���.</span></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
          <td>
          <!-- ������ NAME�� ������. ���� param�ѱ�������. -->
           <input type="text" name="approvalUserNm" value="<%=hbDto.getApprovalName() %>" class="text dis" title="������" style="width:200px;" readonly="readonly"></input>
       	 	<!-- ������ ID�� �Ѱ��ٰ� or �޺ϸ�Ͽ� Insert��.(approvalUser) -->
       	 	<input type="hidden" name="approvalUser" title="������" style="width:200px;" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 </td>
   	  </tr>
   	  <tr>
        <th><label for="">����ó</label></th>
	          <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>"  title="����ó" style="width:300px;" class="text" ></input></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����(����)</label></th>
          <td><textarea name="contents" value="" title="����(����)" style="width:916px;height:192px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����/�ݷ�����</label></th>
          <td><textarea name="approvalAndReturn" value="" title="����/�ݷ�����" style="width:916px;height:96px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>	
		 
				<%
				//�ݷ�
				}else if(statusChk4.equals(hbDto.getStatus())){
					
				%>
		<tr>
		   <th><label for="">��û����</label></th>
          <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
		</tr>		
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����(����)</label></th>
          <td><textarea name="contents" value="" title="����(����)" style="width:916px;height:192px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����/�ݷ�����</label></th>
          <td><textarea name="approvalAndReturn" value="" title="����/�ݷ�����" style="width:916px;height:96px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>	
				<%
				//����Ϸ�
				}else if(statusChk2.equals(hbDto.getStatus())){
					
				%>
		<tr>		
		  <th><label for="">��û����</label></th>
			<td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
		</tr>
		<tr>
		   <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getClearDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->	
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" name="buyDate" value="<%=strDate%>"/></span><input type="hidden" value="<%=strDate%>"></input></td>
				<!-- �޺ϸ�Ͽ� Insert��.(buyDate)���� �� �������� -->
		</tr>
		<tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���Ű���</label></th>
          <input type="hidden" name="buyPrice" class="text text_r"  title="���Ű���" style="width:200px;" value=""   maxlength="9" />
                   <!-- �޺ϸ�Ͽ� Insert��. (buyPrice) ������ �������� -->
          <td><input type="text" name="buyPrice_view" value=""  title="���Ű���" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r" /> ��<span class="guide_txt">&nbsp;&nbsp;* ��ȭ�� �ƴѰ�� ȯ���� ����ؼ� �Է����ּ���.</span></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
          <td>
            <input type="text" name="approvalUserName" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>
       	 	<!-- ������ ID�Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="approvalUser" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 	<!-- �о� �ڵ�ID �Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="branchCode" value="<%=hbDto.getBranchCode() %>"></input>
       	 	<!-- ��û�� ID�Ѱ��ٰ� �޺ϸ�Ͽ� �� �Ѱ��ֱ����ػ��. -->
       	 	<input type="hidden" name="requestUser" value="<%=hbDto.getRequestUser() %>"></input>
       	 </td>
       	 </tr>
       	 <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ó</label></th>
	          <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>"  title="����ó" style="width:300px;" class="text"></input></td>   
        		<!-- �޺ϸ�Ͽ� Insert��. (purchasingOffice) ������ �������� -->
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����(����)</label></th>
          <td><textarea name="contents" value="" title="����(����)" style="width:916px;height:192px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����/�ݷ�����</label></th>
          <td><textarea name="approvalAndReturn" value="" title="����/�ݷ�����" style="width:916px;height:96px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="text"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>
				<%
				//��û��
				}else if(statusChk1.equals(hbDto.getStatus())){
					
				%>
		<tr>
			<th><label for="">��û����</label></th>
			<td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input ��Ȱ��ȭ class="dis" �߰� -->
		</tr>
		<tr>
		  <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
          <td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="clearDate" value="<%=strDate%>"/></span><input type="hidden" value="<%=strDate%>"></input></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
          <td><input type="text" name="user_nm" class="text" title="������" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"><a href="javascript:popSales();" class="btn_type03"><span>�����ȸ</span></a></td>
        </tr>
           <input type="hidden" name="approvalUser" value=""></input>
       	 	<!-- ����� �Ѱ��ٰ� -->
       	 </td>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����(����)</label></th>
          <td><textarea name="contents" value="" title="����(����)" style="width:916px;height:192px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����/�ݷ�����</label></th>
          <td><textarea name="approvalAndReturn" value="" title="����/�ݷ�����" style="width:916px;height:96px;" dispName="���� " onKeyUp="js_Str_ChkSub('1000', this)" class="text"></textarea></td>
       </tr>
				<%
				}
				%>
		</tbody>
      </table>
     </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC">
      <%
      	//�α��ΰ�üũ�� ��ư����+������°� üũ�� ��ư���� ��2012.11.27(ȭ)bsh.
    	statusChk1 = "1"; //(��û��)
        statusChk2 = "2"; //(����Ϸ�)
        statusChk3 = "3"; //(���ſϷ�)
      	statusChk4 = "4"; //(�ݷ�)
    	   if(statusChk3.equals(hbDto.getStatus()) || statusChk4.equals(hbDto.getStatus())){
      %>      
<!-- 	  <a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a> -->
	  <!-- button �̸� ����(���� -> �ݷ�) �� �ȳ����� �߰�(21.10.18) START -->
	  <a href="javascript:goSaveBuy2();" class="btn_type02"><span>�ݷ�</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a>
	  <br>
	  <br>
	  <h2>�ر��ſϷ�ǿ� ���� ������ ������ <strong><a href="<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList">�޺ϸ��</a></strong>���� �����մϴ�.</h2>
	  <!-- button �̸� ����(���� -> �ݷ�) �� �ȳ����� �߰� END -->
      <% 
          }else if(statusChk2.equals(hbDto.getStatus())){
	  %>
      <a href="javascript:goSaveBuy();" class="btn_type02"><span>���ſϷ�</span></a><a href="javascript:goReturns();" class="btn_type02 btn_type02_gray"><span>�ݷ�</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a>
	 <%    		    
     }else{
	 %>
      <a href="javascript:goSaveApp();" class="btn_type02"><span>����</span></a><a href="javascript:goReturns();" class="btn_type02 btn_type02_gray"><span>�ݷ�</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a>
	 <%    	  
     }
     %>	   
    </div>
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
<script>

//select option�� Dto��üũ�� ������ ��� ����(�󼼺�����)
document.hueBookAppView.requestBookCount.value='<%=hbDto.getRequestBookCount()%>';
</script>
<%= comDao.getMenuAuth(menulist,"51")%>
