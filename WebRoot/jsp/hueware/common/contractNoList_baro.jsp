<%@page import="com.huation.common.CommonDAO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>

<%

	CommonDAO comDao=new CommonDAO();
	Map model = (Map)request.getAttribute("MODEL"); 
	
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb"); 
	String searchtxt = (String)model.get("searchtxt");
	if(searchGb.equals("")&&searchtxt.equals(""))searchGb = "3";


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
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
function init() {
	
	formObj=document.contractMgPageListForm; //form��ü����
	
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

	
	formObj.curPage.value='1';
	formObj.submit();

}
//�����ؼ� �� �Ѱܶ�
function goSelect(no,recv,titl,supplyprice,vat1,reciver1){
	
	var contract_no=eval('opener.document.<%=sForm%>.contract_no');
	var public_no=eval('opener.document.<%=sForm%>.p_public_no');
	var title=eval('opener.document.<%=sForm%>.title');
	var supply_price=eval('opener.document.<%=sForm%>.supply_price_view');
	var vat=eval('opener.document.<%=sForm%>.vat_view');
	var receiver=eval('opener.document.<%=sForm%>.receiver');
	var total1=eval('opener.document.<%=sForm%>.total_amt_view');
	
	
	var total = parseInt(vat1)+parseInt(supplyprice);
	
	/*alert(contract_no);
	alert(public_no);
	alert(title);
	alert(supply_price);
	alert(vat);
	alert(receiver); */
	contract_no.value = no;
	public_no.value = recv;
	title.value = titl;
	supply_price.value = supplyprice;
	vat.value = vat1;
	receiver.value = reciver1;
	total1.value = total;
	var obj=eval('opener.document.<%=sForm%>.checkyn');
	var obj2=eval('opener.document.<%=sForm%>.dpublicyn');

	if(obj!=undefined){

		if(compcode==''){
			obj.checked=true;
			e_comp_nm.style.display='block'
			comp_nm.style.display="none";
		}else{
			obj.checked=false;
			e_comp_nm.style.display='none'
			comp_nm.style.display="block";
		}
	}

	if(obj2!=undefined){

		if(dpublicyn=='Y'){
			obj2.checked=true;
		}else{
			obj2.checked=false;
		}
	}

	self.close();

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

	var a = window.open("<%= request.getContextPath()%>/B_ContractManage.do?cmd=invoiceDetailList&contractcode="+contractcode+"&contractname="+contractname,"","width=860,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");

}
//-->
</script>
</head>
<body onload="init();">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>������ ����Ʈ</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
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
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>
    <input type = "hidden" name="sForm"  value="<%=sForm%>" />
    <fieldset>
   <legend>�˻�</legend>
		<ul>
          <li><select name="searchGb" onchange="searchChk()" id="" class="">
          <option value="">��ü</option>
          <option value="1" >����ȣ</option>
          <option value="2" >������ȣ</option>
          <option selected="selected" value="3" >���ֻ��</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="�˻���" class="text" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
       </ul>
      </fieldset>
    </form>
    <!-- //��ȸ -->
	<!-- Top ��ư���� -->
     <div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>�����ޱ�</span></a></div>
    <!-- //Top ��ư���� -->
	</div>
	<!-- //������ ��� ���� -->
	<!-- ����Ʈ -->
      <table class="tbl_type tbl_type_list" summary="����������Ʈ(����ȣ, ������ȣ, ��༭, ���ּ�, ������, ���ֻ�, ����, ���ݾ�(���ް�, �ΰ���, �հ�), ��꼭����ݾ�(��������ݾ�, �̹���ݾ�), ���ݾ�(�Ѽ��ݾ�, �̼��ݾ�), ������Ῡ��)">
        <caption>������ ����Ʈ</caption>
        <colgroup>
				<col width="7%" />
				<col width="7%" />
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
				<col width="4.5%" />
			</colgroup>
			<thead>
			<tr>
				<th rowspan="2">����ȣ</th>
				<th rowspan="2">������ȣ</th>
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
			<tbody>
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
                	StatusStr = "-";
                }else if(Status.equals("2")){
                	StatusStr = "��������";
                	StatusColor = "txtColor_contractEarly";
                }else if(Status.equals("3")){
                	StatusStr = "�������";
                	StatusColor = "txtColor_contractEnd";
                }
        %>
        <tr class="<%=StatusColor%>">
          <td><a href="javascript:goSelect('<%=ds.getString("ContractCode")%>','<%=ds.getString("Public_No")%>','<%=ds.getString("ContractName")%>','<%=ds.getString("SUPPLY_PRICE")%>','<%=ds.getString("VAT")%>','<%=ds.getString("RECEIVER")%>')"><%=ds.getString("ContractCode")%></a>
          	
          </td>
       	  <td><%=ds.getString("Public_No")%></td>
          <td>
          <!-- ��༭ ���� ����. -->
          <%if(!ds.getString("ContractFile").equals("")){ %>
          <%
                   String ContractFile=ds.getString("ContractFile");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=ContractFile.lastIndexOf("/");
                  	
                    String contractfilename=ContractFile.substring(c_index+1);
              
                    String contractfilepath=""; //���ϰ�� �о����
                   
                    	
          
                    if(!ContractFile.equals("")){
                    	contractfilepath=ContractFile.substring(0,c_index); //���ϰ�� �о����
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ContractFileNm")%>&sFileName=<%=contractfilename%>&filePath=<%=contractfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="��༭"></a>
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
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=PurchaseOrderFile.lastIndexOf("/");
                  	
                    String purchasefilename=PurchaseOrderFile.substring(c_index+1);
              
                    String purchasefilepath=""; //���ϰ�� �о����
                   
                    	
          
                    if(!PurchaseOrderFile.equals("")){
                    	purchasefilepath=PurchaseOrderFile.substring(0,c_index); //���ϰ�� �о����
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("PurchaseOrderFileNm")%>&sFileName=<%=purchasefilename%>&filePath=<%=purchasefilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="���ּ�"></a>
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
//             String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
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
            %>
			<!-- �������ϸ��� ���� �ϴ°��(�����̸��ִ� ������ �����ö�. ���� ������������ ÷�ε� ������ �����̸��� ���������ʰ� ���� ���ϰ�η� ÷�� �Ǿ��� ����.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ESTIMATE_E_FILENM")%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="������(EXCEL)"></a>
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
            %>
            <!-- PDF���ϸ��� ���� �ϴ°��(�����̸��ִ� ������ �����ö�. ���� ������������ ÷�ε� ������ �����̸��� ���������ʰ� ���� ���ϰ�η� ÷�� �Ǿ��� ����.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ESTIMATE_P_FILENM")%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="������(PDF)"></a>
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
          <td title="<%=ds.getString("Ordering_Organization") %>"><span class="ellipsis"><%=ds.getString("Ordering_Organization") %></span></td>
          <td class="text_l" title="<%=ds.getString("ContractName") %>"><span class="ellipsis"><%=ds.getString("ContractName") %></span></td>
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
      <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
    <!-- Bottom ��ư���� -->
	<div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
	<!-- //Bottom ��ư���� -->
</div>
<!-- //contents -->
</div>
</body>
</html>
