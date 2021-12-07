<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import="java.lang.String.*" %>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchGb2 = (String)model.get("searchGb2");
	String searchGb3 = (String)model.get("searchGb3");
	String searchtxt = (String)model.get("searchtxt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
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
	function init_contractMg() {
		
		formObj=document.contractMgPageListForm; //form��ü����
		
		searchInit(); //��ȸ�ɼ� �ʱ�ȭ
		searchInit2(); //��ȸ�ɼ� �ʱ�ȭ
		searchInit3(); //���ⱸ�� �ʱ�ȭ
		
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
	
	//��ȸ�ɼ� �ʱⰪ	
	function searchInit2(){
	
		formObj.searchGb2.value='<%=searchGb2%>';
		searchChk();
		
	}
	//���ⱸ�� �ʱⰪ
	function searchInit3(){
		
		formObj.searchGb3.value='<%=searchGb3%>';
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
	

	/*
	 * �˻�
	 */
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		
		if(gubun=='1'){
			if( formObj.searchtxt.value==''){
				alert('����ȣ�� �Է����ּ���.');
				return;
			}
		}else if(gubun=='2'){
			if( formObj.searchtxt.value==''){
				alert('������ȣ�� �Է����ּ���.');
				return;
			}
		}else if(gubun=='3'){
			if( formObj.searchtxt.value==''){
				alert('���ֻ���� �Է����ּ���.');
				return;
			}
		}
	
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();
	
	}

	//��������� �̵�
	function goRegist() {
	
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegistForm";		
		 formObj.submit();
	
	}

	//�������� �̵�
	function goDetail(contractcode){
	
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgView";
		 formObj.ContractCode.value=contractcode;
		 formObj.submit();
	}

	//Excel Down
	function goExcel() {  
		
		 formObj.action = "<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgExcel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList";	
	}


	//���ݰ�꼭 �����ȣ ����Ʈ
	function goInvoiceList(contractcode,contractname){
	
	var a = window.open("<%= request.getContextPath()%>/B_ContractManage.do?cmd=invoiceDetailList&contractcode="+contractcode+"&contractname="+contractname,"","width=1200,height=593,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");
	
	}

	//-->
</script>
</head>
<body onload="init_contractMg();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
	
	<!-- title -->		
	<div class="content_navi">�������� &gt; ������</div>
	<h3><span>��</span>�����</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
	<!-- title -->
	
	<div class="con">
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
	<!-- ��ȸ -->
  
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
	
	%>
 
  <%=ld.getPageScript("contractMgPageListForm", "curPage", "goPage")%>
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>

    
    <!-- search -->
      <fieldset>
        <legend>�˻�</legend>
        <ul>
        	<li><select name="searchGb2" id="" class=""  title="�˻����Ǽ���">
	          <option checked value="">��ü</option>
	          <option value="1" >������</option>
	          <option value="2" >��������</option>
	          <option value="3" >�������</option>
        	</select></li>
        	<li>
        		<select name="searchGb3" id="searchGb3" class=""  title="���ⱸ�м���">
	          		<option checked value="">��ü</option>
	          		<option value="S00" >�ý��۸���</option>
	          		<option value="S01" >��ǰ����</option>
	          		<option value="S02" >�뿪����</option>
        		</select>
        	</li>        	
         	 <li><select name="searchGb" onchange="searchChk()" id="" class=""  title="�˻����Ǽ���">
	          <option checked value="">��ü</option>
	          <option value="1" >����ȣ</option>
	          <option value="2" >������ȣ</option>
	          <option value="3" >���ֻ��</option>
	          <option value="4" >����</option>
        	</select></li>

			<li><input type="text" name="searchtxt"  class="text" title="�˻���" id="textfield_search2" value="<%=searchtxt %>" /></li>
			<li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
		</ul>
	</fieldset>
	</form>
    <!--//search -->
    
	<!-- Top ��ư���� -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
	<!-- //Top ��ư���� -->
	</div>
	<!-- //������ ��� ���� -->
	
	<!-- ����Ʈ -->
	<table class="tbl_type tbl_type_list" summary="����������Ʈ(����ȣ, ������ȣ, ��༭, ���ּ�, ������, ���ֻ�, ����, ���ݾ�(���ް�, �ΰ���, �հ�), ��꼭����ݾ�(��������ݾ�, �̹���ݾ�), ���ݾ�(�Ѽ��ݾ�, �̼��ݾ�), ������Ῡ��, ���ⱸ��)">
		<colgroup>
			<col width="8%" />
			<col width="8%" />
			<col width="3%" />
			<col width="3%" />
			<col width="4%" />
			<col width="8%" />
			<col width="*" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="3%" />
		</colgroup>
					
		<thead>
			<tr>
				<th rowspan="2">����ȣ<br/>������ȣ</th>
				<th rowspan="2">���ⱸ��</th>
				<th rowspan="2">��༭</th>
				<th rowspan="2">���ּ�</th>
				<th rowspan="2">������</th>
				<th rowspan="2">���ֻ�</th>
				<th rowspan="2">����</th>
				<th colspan="3">���ݾ�</th>
				<th colspan="2">��꼭����ݾ�</th>
				<th colspan="2">���ݾ�</th>
				<th rowspan="2">������Ῡ��</th>
			</tr>
					
			<tr>
				<th>���ް�</th>
				<th>�ΰ���</th>
				<th>�հ�</th>
				<th>��������ݾ�</th>
				<th>�̹���ݾ�</th>
				<th>�Ѽ��ݾ�</th>
				<th>�̼��ݾ�</th>
			</tr>
		</thead>
        
        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
               
                String Status = ds.getString("ContractStatus"); //������� ���� �÷��� ��
                String StatusStr = "";							//������� ���� �÷��� ���� ��
                String StatusColor = "";						//������� ���� �÷��� ���� �÷� ��
                if(Status.equals("1")){
                	StatusStr = "������";
                }else if(Status.equals("2")){
                	StatusStr = "��������";
                	StatusColor = "txtColor_contractEarly";
                }else if(Status.equals("3")){
                	StatusStr = "�������";
                	StatusColor = "txtColor_contractEnd";
                }
                
                String salesSortValue = "";
                String salesSort = ds.getString("SalesSort");
                String[] sArray1 = salesSort.split(",");
                
				for( int s = 0; s < sArray1.length; s++ ){
					if (s > 0) {
						salesSortValue += "<br/>";
					}
                  	if ("S00".equals(sArray1[s])) {
                  		salesSortValue += "�ý��۸���";
                  	} else if ("S01".equals(sArray1[s])) {
                  		salesSortValue += "��ǰ����";
                  	} else if ("S02".equals(sArray1[s])) {
                  		salesSortValue += "�뿪����";
                  	}
                }

        %>
    <tbody>    
        <tr class="<%=StatusColor%>">
        
          <td><a href="javascript:goDetail('<%=ds.getString("ContractCode")%>');"><%=ds.getString("ContractCode")%></a><a href="javascript:goInvoiceList('<%=ds.getString("ContractCode")%>','<%=ds.getString("ContractName")%>');" class="btn_type03"><span>���೻��</span></a><br/><%=ds.getString("Public_No")%></td>
       	 
       	  <td><%=salesSortValue%></td>
          <td>
          
          <!-- ��༭ ���� ����. -->
          <%if(!ds.getString("ContractFile").equals("")){ %>
          <%
                   String ContractFile=ds.getString("ContractFile");
          		   String ContractFileNm=ds.getString("ContractFileNm");
          
                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=ContractFile.lastIndexOf("/");
                  	
                    String contractfilename=ContractFile.substring(c_index+1);
              
                    String contractfilepath=""; //���ϰ�� �о����
                   
                    if(!ContractFile.equals("")){
                    	contractfilepath=ContractFile.substring(0,c_index); //���ϰ�� �о����
                    
                    	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                    	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                    	String spStrReplace = "";
                    	if(ContractFileNm.indexOf("&") != -1){
                    		spStrReplace=  ContractFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ContractFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                    	
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=contractfilename%>&filePath=<%=contractfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="��༭"></a>
          <%
                     }
               
          %>
		 <!--��༭ ������.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- ��༭ ���� ��. -->
          </td>
          <td>
          <!-- ���ּ� ���� ����. -->
          <%if(!ds.getString("PurchaseOrderFile").equals("")){ %>
          <%
                   String PurchaseOrderFile=ds.getString("PurchaseOrderFile");
          		   String PurchaseOrderFileNm=ds.getString("PurchaseOrderFileNm");
          
                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=PurchaseOrderFile.lastIndexOf("/");
                  	
                    String purchasefilename=PurchaseOrderFile.substring(c_index+1);
              
                    String purchasefilepath=""; //���ϰ�� �о����
                   
                    	
          
                    if(!PurchaseOrderFile.equals("")){
                    	purchasefilepath=PurchaseOrderFile.substring(0,c_index); //���ϰ�� �о����
                    	
                    	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                    	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                    	String spStrReplace = "";
                    	if(PurchaseOrderFileNm.indexOf("&") != -1){
                    		spStrReplace=  PurchaseOrderFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  PurchaseOrderFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=purchasefilename%>&filePath=<%=purchasefilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="���ּ�"></a>
          <%
                     }
               
          %>
		  <!--���ּ� ������.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- ��༭ ���� ��. -->
          </td>
          <td>
          <!-- ������ ���� ����. -->
         <%if(!ds.getString("ESTIMATE_E_FILE").equals("") || !ds.getString("ESTIMATE_P_FILE").equals("")){%>
         <%
	     	//2013_11_26(ȭ)shbyeon.
	     	//������ ���࿡�� ����,PDF ���� ÷�� & ������ �����Ե� LIST
	     	//�����Ҷ����� ���ο� ÷�� ���Ϸ� UPDATE �ȴ�.
            String Estimate_E_File=ds.getString("ESTIMATE_E_FILE");
	     	String Estimate_E_FileNm=ds.getString("ESTIMATE_E_FILENM");
	     	String Estimate_P_File = ds.getString("ESTIMATE_P_FILE");
            String Estimate_P_FileNm = ds.getString("ESTIMATE_P_FILENM");
            //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
          //serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();
            int x_index=Estimate_E_File.lastIndexOf("/"); //��������
            int p_index=Estimate_P_File.lastIndexOf("/"); //PDF����
                    
            String Esti_xls_filename=Estimate_E_File.substring(x_index+1);
            String Esti_pdf_filename=Estimate_P_File.substring(p_index+1);
                    
            String Esti_xls_path="";
            String Esti_pdf_path="";
             
          if(!Estimate_E_File.equals("")){
        	  
        	  Esti_xls_path=Estimate_E_File.substring(0,x_index); //���ϰ�� �о���� 
        	  
            if(Estimate_E_FileNm.equals("")){  
            %>
            <!-- �������ϸ��� �������� ���� ���(���� ���������࿡���� �����̸����� ������ �����ö�) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=Esti_xls_filename%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="������(EXCEL)"></a>
            <%
            }else if(!Estimate_E_FileNm.equals("")){
            	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
            	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
            	String spStrReplace = "";
            	if(Estimate_E_FileNm.indexOf("&") != -1){
            		spStrReplace=  Estimate_E_FileNm.replace("&", "[replaceStr]");
            	System.out.println("spStrReplace:"+spStrReplace);
            	}else{
            		spStrReplace =  Estimate_E_FileNm;	
            	System.out.println("spStrReplace:"+spStrReplace) ;
            	}
            %>
			<!-- �������ϸ��� ���� �ϴ°��(�����̸��ִ� ������ �����ö�. ���� ������������ ÷�ε� ������ �����̸��� ���������ʰ� ���� ���ϰ�η� ÷�� �Ǿ��� ����.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="������(EXCEL)"></a>
            <%
            }
            %>
          <%
          }
          %>
        <%if(!Estimate_P_File.equals("")){ 
        	
        	Esti_pdf_path=Estimate_P_File.substring(0,p_index); //���ϰ�� �о���� 
        %> 
            <%
            if(Estimate_P_FileNm.equals("")){
            %>
            <!-- PDF���ϸ��� �������� ���� ���(���� ���������࿡���� �����̸����� ������ �����ö�) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=Esti_pdf_filename%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="������(PDF)"></a>
            <%
            }else if(!Estimate_P_FileNm.equals("")){
            	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
            	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
            	String spStrReplace = "";
            	if(Estimate_P_FileNm.indexOf("&") != -1){
            		spStrReplace=  Estimate_P_FileNm.replace("&", "[replaceStr]");
            	System.out.println("spStrReplace:"+spStrReplace);
            	}else{
            		spStrReplace =  Estimate_P_FileNm;	
            	System.out.println("spStrReplace:"+spStrReplace) ;
            	}
            %>
            <!-- PDF���ϸ��� ���� �ϴ°��(�����̸��ִ� ������ �����ö�. ���� ������������ ÷�ε� ������ �����̸��� ���������ʰ� ���� ���ϰ�η� ÷�� �Ǿ��� ����.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="������(PDF)"></a>
         	<%
            }
         	%>
         <%
         }
         %>
      <!-- ������ ������. -->
      <%}else{ %>
      	-
      <%}%>
         
          <!-- ������ ���� ��. -->
          </td>
          <td><%=ds.getString("Ordering_Organization") %></td>
          <td class="text_l"><%=ds.getString("ContractName") %></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
		  %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <%if(!ds.getString("sum_price_total").equals("")){%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("sum_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%}%>
          <%if(!ds.getString("min_price_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("min_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%} %>
         <%if(!ds.getString("deposit_amt_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <%if(!ds.getString("no_collect_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <td><%=StatusStr%></td>
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="15">�Խù��� �����ϴ�.</td>
        </tr>
        <%
                }
            %>
        </tbody>
      </table>
    </div>
    <!-- //con -->
    
    <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->

	<!-- Bottom ��ư���� -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
	<!-- //Bottom ��ư���� --> 
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
<%= comDao.getMenuAuth(menulist,"14") %>