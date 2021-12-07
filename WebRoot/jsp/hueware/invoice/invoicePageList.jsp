<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String IvStartDate = (String)model.get("IvStartDate");
	String IvEndDate = (String)model.get("IvEndDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݰ�꼭 ���� ����Ʈ</title>
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

	//��Ʈ������ ���̺�
	$(function(){
		$("tr:nth-child(odd)").addClass("odd");
		$("tr:nth-child(even)").addClass("even");
	
		//���콺������ �࿡ ���̶���Ʈȿ��
		$("tr:not(:first-child)").mouseover(function(){
			$(this).addClass("hover");
		}).mouseout(function(){
			$(this).removeClass("hover");
		});
	});


	var  formObj;//form ��ü����
	
	//�ʱ⼼��
	function init_invoice() {
		
		formObj=document.invoiceform; //form��ü����
		
		searchInit(); //��ȸ�ɼ� �ʱ�ȭ
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //ó���� �޼��� ��Ȱ��ȭ
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	
	}
	
	//��ȸ�ɼ� �ʱⰪ	
	function searchInit(){
	
		 formObj.searchGb.value='<%=searchGb%>';
		 formObj.searchtxt.value='<%=searchtxt%>';
	
		searchChk();
		
	}
	
	//��ȸ�ɼ� üũ	
	function searchChk(){
	
		if( formObj.searchGb[0].selected==true){
			 formObj.searchtxt.disabled=true;
			 formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}
	
	//��ȸ
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		var dch=dateCheck_5Year(formObj.IvStartDate,formObj.IvEndDate,1827);//�˻����� ��¥üũ : ������,������,�Ⱓ(5��)
		
		if (dch==false){
			return;
		}
		
		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('������ �����ȣ�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='B'){
			
			if( formObj.searchtxt.value==''){
				alert('�������� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='C'){
			
			if( formObj.searchtxt.value==''){
				alert('����ڵ�Ϲ�ȣ�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='D'){
			
			if( formObj.searchtxt.value==''){
				alert('��ȣ�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='E'){
			
			if( formObj.searchtxt.value==''){
				alert('��ǥ�ڸ� �Է��� �ּ���');
				return;
			}
		}
		 openWaiting();
		 formObj.curPage.value='1';
		 formObj.submit();

    }
    
	//���
	function goRegist() {

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceRegistForm";		
		 formObj.submit();

	}
   
	//��
	function goDetail(gun,ho,manageno){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceView";
		 formObj.gun.value=gun;
		 formObj.ho.value=ho;
		 formObj.manage_no.value=manageno;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoiceExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList";	
	}
    
	//��ü������
	function goCompDetail(compcode){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=companyView&comp_code="+compcode,"","width=600,height=445,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
    
	
	/*���ݰ�꼭 �޷� �˻� ���
    2013_05_28(ȭ)shbyeon.
  	*/
  
  	$(document).ready(function(){
  		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
  			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
  			//maxDate:0,
  			showOn: 'both',
  			buttonImageOnly: true,
  			prevText: "����",
  			nextText: "����",
  			dateFormat: "yy-mm-dd",
  			dayNamesMin:["��","��","ȭ","��","��","��","��"],
  			monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
  			monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
  			changeMonth: true,
  		    changeYear: true
  		});
  	});

	function showCalendar(div){

		   if(div == "1"){
		   	   $('#calendarData1').datepicker("show");
		   } else if(div == "2"){
			   $('#calendarData2').datepicker("show");
		   } 
	}
	
	/**	key down function (����Ű�� �ԷµǸ� �˻��Լ� ȣ��)*/
 	function checkKeyASearch(){
		if(event.keyCode == 13){
			goSearch();
		}
	} 
	
//-->
</script>
</head>
<body onload = "init_invoice()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

	<!-- title -->
	<div class="content_navi">�������� &gt; (��)���ݰ�꼭����</div>
	<h3><span>(��)</span>���ݰ�꼭����</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			
	<div class="con">
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	<!-- ��ȸ -->  
  	
  	<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

	%>
  
  <%= ld.getPageScript("invoiceform", "curPage", "goPage") %>
  <form  method="post" name="excelform"></form>
  <form  method="post" name=invoiceform action = "<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList" class="search">
    <input type = "hidden" name = "objExcel"/>
    <input type = "hidden" name = "filename" value="companyList.xls"/>
    <input type = "hidden" name = "gun" value=""/>
    <input type = "hidden" name = "ho" value=""/>
    <input type = "hidden" name = "manage_no" value=""/>
    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>

    
    <!-- search -->
	<fieldset>
		<legend>�˻�</legend>
		<ul>
        <!-- �޷� ���� //2013_05_28(ȭ)shbyeon. �޷� �˻� ��� �߰�. -->
        	<li><span class="ico_calendar"><input type="text" class="text textdate" title="�˻�������" id="calendarData1" name="IvStartDate" value="<%=IvStartDate %>" readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/></span> ~	<span class="ico_calendar"><input type="text" class="text textdate" title="�˻�������" id="calendarData2" name="IvEndDate" value="<%=IvEndDate %>" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"/></span></li>
	    <!-- �޷� ���� //2013_05_28(ȭ)shbyeon. �޷� �˻� ��� �߰�. -->
	        
	        <li><select name="searchGb" onChange="searchChk()" title="�˻����Ǽ���">
	          <option checked value="">��ü</option>
	          <option value="A" >������ �����ȣ</option>
	          <option value="B" >����</option>
	          <option value="C" >����ڵ�Ϲ�ȣ</option>
	          <option value="D" >��ȣ</option>
	          <option value="E" >��ǥ��</option>
	        </select></li>

			<li><input type="text" class="text" title="�˻���" id="" name="searchtxt" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100" /></li>
			<li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
		</ul>
	</fieldset>
	</form>       
	<!-- //��ȸ -->			
		
	<!-- Top ��ư���� -->
	<div class="Tbtn_areaR" id="excelBody"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
	<!-- //Top ��ư���� -->
	</div>
	<!-- //������ ��� ���� -->        


 	<!-- ����Ʈ -->
	<table class="tbl_type tbl_type_list" summary="(��)���ݰ�꼭���ฮ��Ʈ(����, ����(���ι�ȣ, ������, ����), ��������, ������, ���޹޴���(����ڵ�Ϲ�ȣ, ��ȣ, ��ǥ��), ���޾�(���ް�, �ΰ���, �հ�), �Աݿ�������, �Աݾ�, �Ա�����)">
		<colgroup>
			<col width="3%" />
			<col width="7%" />
			<col width="5%" />
			<col width="*" />
			<col width="4%" />
			<col width="7%" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="4%" />
			<col width="7%" />
			<col width="4%" />
		</colgroup>
					
		<thead>
		<tr>
			<th rowspan="2">����</th>
			<th colspan="3">����</th>
			<th rowspan="2">��������</th>
			<th rowspan="2">������</th>
			<th colspan="3">���޹޴���</th>
			<th colspan="3">���޾�</th>
			<th rowspan="2">�Աݿ�������</th>
			<th rowspan="2">�Աݾ�</th>
			<th rowspan="2">�Ա�����</th>
		</tr>
					
		<tr>
			<th>���ι�ȣ</th>
			<th>������(������)</th>
			<th>����</th>
			<th>����ڵ�Ϲ�ȣ</th>
			<th>��ȣ</th>
			<th>��ǥ��</th>
			<th>���ް�</th>
			<th>�ΰ���</th>
			<th>�հ�</th>
		</tr>
	</thead>
 
 
        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			String state="";
			String tcl="";
			String dipositYN="";
		
			while(ds.next()){
		
				    state=ds.getString("STATE");
		
					if(state.equals("03")){
						tcl="";
						dipositYN="�Ա�<br>�Ϸ�";
					}else if(state.equals("02")){
						tcl="txtColor_invoiceCancel";
						dipositYN="����<br>���";
						
					}else{
						tcl="txtColor_depositWait";
						dipositYN="�Ա�<br>���"; 
					}
		%>
    <tbody>    
        <tr class="<%=tcl%>">
          <td><%=dipositYN%></td>
        <%--
         2013_10_30(��) ���� ��,ȣ,������ȣ ȭ�鿡���� ������. �� DB UPDATE ���� �����.
          <td class="<%=tcl%>"><%=ds.getString("GUN")%></td>
          <td class="<%=tcl%>"><%=ds.getString("HO")%></td>
         
          <%	if(!state.equals("02")){ %>
          <td class="<%=tcl%>"><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>')"><%=ds.getString("MANAGE_NO")%></a></td>
          <%}else{%>
          <td class="<%=tcl%>"><%=ds.getString("MANAGE_NO")%></td>
          <%}%>
         --%>
          <td><%=ds.getString("APPROVE_NO")%></td>
          <td><%=ds.getString("RECEIVER")%></td>
          <%	if(!state.equals("02")){ %>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>')"><%=ds.getString("TITLE")%></a></span></td>
          <%}else{%>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span class="ellipsis"><%=ds.getString("TITLE")%></span></td>
          <%}%>
         
          
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
          <td><%=ds.getString("PUBLIC_ORG")%></td>
          <%	if(!state.equals("02")){ %>
          <!-- COMP_CODE - > PERMIT_NO ����Ʈ�󿡼��� ����ڵ�Ϲ�ȣ�� �����ߵȴ�.2013_03_20(��)shbyeon. -->
          <td><a href="javascript:goCompDetail('<%=ds.getString("COMP_CODE")%>')"><%=ds.getString("PERMIT_NO")%></a></td>
          <%}else{%>
          <!-- ������ҵ� ���� ����ڵ�Ϲ�ȣ -->
          <td><%=ds.getString("PERMIT_NO")%></td>
          <%}%>
          <td><%=ds.getString("COMP_NM")%></td>
          <td><%=ds.getString("OWNER_NM")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_VAT"))%></td>
          <%
				long sprice=ds.getLong("I_SUPPLY_PRICE");
				long vat=ds.getLong("I_VAT");
				long total=sprice+vat;
			%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PRE_DEPOSIT_DT"),"/")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("DEPOSIT_AMT"))%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("DEPOSIT_DT"),"/")%></td>
          
        </tr>
        <!-- :: loop :: -->
        
        <%		
		    i++;
		    }
		}else{
		%>
       
        <tr>
          <td colspan="660">��ȸ�� ����Ÿ�� �����ϴ�.</td>
        </tr>
        
        <% 
		}
		%>
		
		</tbody>
      </table>
      
    <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
      
	<!-- Bottom ��ư���� -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
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