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


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
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

	openWaiting();
	
	formObj.curPage.value='1';
	formObj.submit();

}
//�����ؼ� �� �Ѱܶ�
function goSelect(no,recv,titl){
	
	var contract_no=eval('opener.document.<%=sForm%>.contract_no');
	var public_no=eval('opener.document.<%=sForm%>.p_public_no');
	var title=eval('opener.document.<%=sForm%>.title');
	

	contract_no.value=no;
	public_no.value=recv;
	title.value=titl;
	

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
<div id="wrap">
<!-- header -->

<!-- //header -->
<!-- container -->
<div id="container">
<div class="clear">
</div>
<!-- lnb -->

<!-- //lnb -->
<!-- contents -->
<div class="contents">
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  <%=ld.getPageScript("contractMgPageListForm", "curPage", "goPage")%>
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>
    <input type = "hidden" name="sForm"  value="<%=sForm%>">
    
    
    <!-- title -->
    <div class="title">
     <h2>������</h2>
    </div>
    <!-- //title -->
    <!-- search -->
    <div class="msearch">
      <fieldset class="">
        <legend>�˻�</legend>
          <select name="searchGb" onchange="searchChk()" id="" class="">
          <option checked value="">��ü</option>
          <option value="1" >����ȣ</option>
          <option value="2" >������ȣ</option>
          <option value="3" >���ֻ��</option>
        </select>
        <input type="text" name="searchtxt" style="ime-mode:active;width:200px" class="search" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" />
        <a href="javascript:goSearch();"><img src="<%= request.getContextPath()%>/images/btn_search.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_search_on.gif'" onmousedown="this.src='<%= request.getContextPath()%>/images/btn_search_active.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_search.gif'" width="52" height="20" alt="�˻�" class="search_btn"/></a>
        <a href="javascript:goExcel();"><img src="<%= request.getContextPath()%>/images/btn_download.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_download_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_download.gif'" width="66" height="20" alt="�����ٿ�ε�" class="search_btn" style="padding:0 5px"/></a>
      </fieldset>
    </div>
    <!--//search -->
    <!-- con -->
    <div class="con">
      <span class="tbl_line_top"></span>
      <table cellspacing="0" border="1" cellpadding="0" summary="" class="tbl_type" style="table-layout:fixed">
        <caption>������ ����Ʈ</caption>
        <tr>
          <th width="8" rowspan="2">����ȣ</th>
          <th width="8" rowspan="2">������ȣ</th>
          <th width="4" rowspan="2">��༭</th>
          <th width="4" rowspan="2">���ּ�</th>
          <th width="5" rowspan="2">������</th>
          <th width="5" rowspan="2">���ֻ�</th>
          <th width="20" rowspan="2">����</th>
          <th width="20" colspan="3">���ݾ�</th>
          <th width="15" colspan="2">��꼭 ����ݾ�</th>
          <th width="15" colspan="2">���ݾ�</th>
          <th width="5" rowspan="2">������� </br>���� </th>
        </tr>
        <tr>
          <th>���ް�</th>
          <th>�ΰ���</th>
          <th>�հ�</th>
          
          <th>���� ����ݾ�</th>
          <th>�� ����ݾ�</th>
  
   		  <th>�� ���ݾ�</th>
          <th>�� ���ݾ�</th>
        </tr>
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
                	StatusColor = "#F29661";
                }else if(Status.equals("3")){
                	StatusStr = "�������";
                	StatusColor = "#2F9D27";
                }
        %>
        <tr>
          <td><a href="javascript:goSelect('<%=ds.getString("ContractCode")%>','<%=ds.getString("Public_No")%>','<%=ds.getString("ContractName")%>')"><%=ds.getString("ContractCode")%></a>
          	<a href="javascript:goInvoiceList('<%=ds.getString("ContractCode")%>','<%=ds.getString("ContractName")%>');"><img src="<%= request.getContextPath()%>/images/btn_issue_list.gif" width="60" height="18" title="���ݰ�꼭���೻��" /></a>
          </td>
       	  <td><font color="<%=StatusColor%>"><%=ds.getString("Public_No")%></font></td>
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
         <%if(!ds.getString("Estimate_E_File").equals("") || !ds.getString("Estimate_P_File").equals("")){%>
         <%
	     	//2013_11_26(ȭ)shbyeon.
	     	//������ ���࿡�� ����,PDF ���� ÷�� & ������ �����Ե� LIST
	     	//�����Ҷ����� ���ο� ÷�� ���Ϸ� UPDATE �ȴ�.
            String Estimate_E_File=ds.getString("Estimate_E_File");
	     	String Estimate_E_FileNm=ds.getString("Estimate_E_FileNm");
	     	String Estimate_P_File = ds.getString("Estimate_P_File");
            String Estimate_P_FileNm = ds.getString("Estimate_P_FileNm");
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
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("Estimate_E_FileNm")%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="������(EXCEL)"></a>
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
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("Estimate_P_FileNm")%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="������(PDF)"></a>
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
          <td><font color="<%=StatusColor%>"><%=ds.getString("Ordering_Organization") %></font></td>
          <td><font color="<%=StatusColor%>"><%=ds.getString("ContractName") %></font></td>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></font></td>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></font></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
		  %>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(total)%></font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>"><%=StatusStr %></font></td>

          
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
      </table>
    </div>
    <!-- //con -->
    <!-- paginate -->
    <div class="paginate">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
  </form>
</div>
<!-- //contents -->
</div>
<!-- //container -->

</div>
</body>
</html>
