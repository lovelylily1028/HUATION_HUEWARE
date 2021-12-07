<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    
	CommonDAO comDao=new CommonDAO();
	 
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt=(String)model.get("searchtxt");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�����ȣ ����Ʈ</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var  formObj;//form ��ü����
	
	//�ʱ⼼��
	function init() {
		
		formObj=document.searchform; //form��ü����
		
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

	function goSearch() {
		
		var gubun=formObj.searchGb.value;

		if(gubun=='D'){
			if(formObj.searchtxt.value==''){
				alert('�����ȣ�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='B'){
			if(formObj.searchtxt.value==''){
				alert('������ �Է��� �ּ���');
				return;
			}
		}else if(gubun=='A'){
			if(formObj.searchtxt.value==''){
				alert('�����ڸ� �Է��� �ּ���');
				return;
			}
		}
		openWaiting();
		formObj.submit();

    }

	function goSelect(no,recv,titl){
		
		var p_public_no=eval('opener.document.<%=sForm%>.p_public_no');
		var receiver=eval('opener.document.<%=sForm%>.InvoiceeContactName1');
		var title=eval('opener.document.<%=sForm%>.title');
		

		p_public_no.value=no;
		receiver.value=recv;
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
//-->
</SCRIPT>
</head>
<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>
<%= ld.getPageScript("searchform", "curPage", "goPage") %>
<body onLoad = "init()">
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_baro">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
  <div id="wrap">
    <!-- title -->
    <div class="title">
      <h1 class="title_lft"><span class="title_rgt">�����ȣ ����Ʈ</span></h1>
    </div>
    <!-- //title -->
    <!-- search -->
    <div class="msearch">
      <fieldset class="">
        <legend></legend>
 	<!-- 
        <select name="contractGb">
          <option value="ALL" >��ü</option>
          <option checked value="Y"  >���</option>
          <option value="N"  >�̰��</option>
        </select>
 	 -->

        <select name="searchGb" class=""  onChange="searchChk()">
          <option checked value="">��ü</option>
          <option value="D" >�����ȣ</option>
          <option value="B" >����</option>
          <option value="A" >������</option>
        </select>
        <input type="text" name="searchtxt" style="ime-mode:active;width:200px" value="<%=searchtxt%>"  class="search" maxlength="100" >
        <a href="javascript:goSearch();"><img src="<%= request.getContextPath()%>/images/btn_search.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_search_on.gif'" onmousedown="this.src='<%= request.getContextPath()%>/images/btn_search_active.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_search.gif'" width="52" height="20" alt="�˻�" class="search_btn"//></a>
      </fieldset>
    </div>
    <!--//search -->
    <!-- contents -->
    <div id="contents">
      <div id="excelBody" class="con">
        <span class="tbl_line_top">&nbsp;</span>
        <table cellspacing="0" border="1" summary="�����ȣ ����Ʈ" class="tbl_type">
          <caption>�����ȣ ����Ʈ</caption>
          <colgroup>
          <col width="10%">
          <col width="">
          <col width="10%">
          <col width="18%">
          <col width="11%" span="3">
          </colgroup>
          <thead>
            <tr>
              <th rowspan="2">�����ȣ</th>
              <th rowspan="2">����</th>
              <th colspan="2">������</th>
              <th colspan="3">�����ݾ�</th>
            </tr>
            <tr>
              <th>������</th>
              <th>��ü��</th>
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
	long sprice=0;
	long vat=0;
	long total=0;

	while(ds.next()){
			sprice=ds.getLong("SUPPLY_PRICE");
			vat=ds.getLong("VAT");
			total=sprice+vat;
%>
          <tbody>
            <tr>
              <td><a href="javascript:goSelect('<%=ds.getString("PUBLIC_NO")%>','<%=ds.getString("RECEIVER")%>','<%=ds.getString("TITLE")%>')"><%=ds.getString("PUBLIC_NO")%></a></td>
              <td><%=ds.getString("TITLE")%></td>
              <td><%=ds.getString("RECEIVER")%></td>
              <td><%=ds.getString("E_COMP_NM")%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(total)%></td>
            </tr>
            <!-- :: loop :: -->
            <%		
    i++;
    }
}else{
%>
            <tr>
              <td colspan="660" align="center">��ȸ�� ������ �����ϴ�. </td>
            </tr>
            <% 
}
%>
          </tbody>
        </table>
        
      </div>
      <!-- //con -->
      <div>
     
      </div>
    
  <p class="noti2" align="left">���� �������� �����Ͻ� �� ������, ��Ͽ� ���� ��� ���������� ȭ�鿡�� �ش� �������� ��� ���¸� '���'���� �����Ͻʽÿ�.</p>
    </div>
    <!-- //contents -->
      
      <!-- paginate -->
      <div class="paginate">
        <%=ld.getPagging("goPage")%>
      </div>
      <!-- //paginate -->
    
    <!-- //button -->
    
    <div id="button">
      <a href="javascript:window.close()"><img src="<%= request.getContextPath()%>/images/btn_close.gif" width="40" height="23" title="�ݱ�"/></a>
    </div>
    <!-- //button -->
  </div>
</div> 
</form>
</body>
</html>

