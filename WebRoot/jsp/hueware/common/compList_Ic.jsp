<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import = "com.huation.framework.persist.ListDTO"%>
<%@ page import = "com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = "";
	String aselect="";
	String bselect="";

	if(searchGb.equals("A")){
		searchtxt=(String)model.get("searchtxt");
		aselect="selected";
	}else if(searchGb.equals("B")){
		searchtxt=(String)model.get("searchtxt");
		bselect="selected";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��ü ����Ʈ</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch() {
	
		var obj=document.searchform;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			if(obj.searchtxt.value==''){
				alert('��ü���� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='B'){
			if(obj.searchtxt.value==''){
				alert('����� ��ȣ�� �Է��� �ּ���');
				return;
			}
		}
		openWaiting();
		obj.submit();

    }

	function init() {

		openWaiting( );
		
		var frm = document.searchform;
		
		frm.searchtxt.focus();

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	}

	function searchChk(){

		var obj = document.searchform;

		if(obj.searchGb[0].selected==true){
		/* 	obj.searchtxt.disabled=true; */
			obj.searchtxt.value='';	
		}else {
			obj.searchtxt.disabled=false;
		}
	}
	function goSelect(code,permit,nm,owner,busi,bite,pos,adres,adrtl){
		//���� (��ü�ڵ�)COMP_CODE=> (��ü��ȣ)PERMIT_NO ���� 2013_03_18(��)shbyeon.
		
		var compcode=eval('opener.document.<%=sForm%>.comp_code'); 
		var permitno=eval('opener.document.<%=sForm%>.permit_no');
		var comopnm=eval('opener.document.<%=sForm%>.comp_nm');
		var ownernm=eval('opener.document.<%=sForm%>.owner_nm');
		var business=eval('opener.document.<%=sForm%>.business');
		var bitem=eval('opener.document.<%=sForm%>.b_item');
		var post=eval('opener.document.<%=sForm%>.post');
		var adress=eval('opener.document.<%=sForm%>.address');
		var addrdtl=eval('opener.document.<%=sForm%>.addr_detail');

		compcode.value=code;
		permitno.value=permit;
		comopnm.value=nm;
		ownernm.value=owner;
		business.value=busi;
		bitem.value=bite;
		post.value=pos;
		adress.value=adres;
		addrdtl.value=adrtl;

		self.close();

	}
	function goRegist() {

		document.searchform.target ='_self';
		document.searchform.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyRegistForm";		
		document.searchform.submit();

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
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>��ü ����Ʈ</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
	<!-- ������ ��� ���� -->
		<div class="conTop_area">
	<!-- ��ȸ -->
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_lC" class="search">
  <input type = "hidden" name = "comp_nm" value="">
  <input type = "hidden" name = "comp_no" value="">
  <input type = "hidden" name = "comp_code" value="">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
	<fieldset>
        <legend>�˻�</legend>
		<ul>
        <li><select name="searchGb" class="" onchange="searchChk()" >
          <option checked value="A"  <%=aselect%>>��ü��</option>
          <option value="B"  <%=bselect%>>����� ��ȣ</option>
          <option value="">��ü</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="�˻���" value="<%=searchtxt%>"  class="text" maxlength="100" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01 md0"><span>�˻�</span></a></li>
        </ul>
       
      </fieldset>
      </form>
    <!-- //��ȸ -->
    </div>
    <!-- contents -->
      <table class="tbl_type tbl_type_list" summary="��ü����Ʈ(����ڵ�Ϲ�ȣ, ��ü��, ���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ), ��ǥ�ڸ�(����))">
          <caption>��ü ����Ʈ</caption>
         <colgroup>
         	<col width="6%" />
			<col width="20%" />
			<col width="*" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
		<tr>
			<th>�����ݾ�ü</th>
			<th>����ڵ�Ϲ�ȣ</th>
			<th>��ü��</th>
			<th>���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)</th>
			<th>��ǥ�ڸ�(����)</th>
		</tr>
		</thead>
		<tbody>
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
    String UNFIT_ID = "";
	while(ds.next()){
%>
          <tr>
        <%
        UNFIT_ID = ds.getString("UNFIT_ID");
        	if(!UNFIT_ID.isEmpty()){
        %>
           <td><img src="<%= request.getContextPath()%>/images/common/ico_unfit.gif" title="�����ݾ�ü����"></td>
        <%
        	}else{
        %>
        <td></td>
        <%
        	} 
        %>   
            <td><%=ds.getString("PERMIT_NO")%></td>
            <!-- COMP_CODE = ��ü�ڵ尪 2013_03_22 shbyeon. -->
            <td title="<%=ds.getString("COMP_NM")%>"><span class="ellipsis"><a href="javascript:goSelect('<%=ds.getString("COMP_CODE")%>','<%=ds.getString("PERMIT_NO")%>','<%=ds.getString("COMP_NM")%>','<%=ds.getString("OWNER_NM")%>','<%=ds.getString("BUSINESS")%>','<%=ds.getString("B_ITEM")%>','<%=ds.getString("POST")%>','<%=ds.getString("ADDRESS")%>','<%=ds.getString("ADDR_DETAIL")%>')"><%=ds.getString("COMP_NM")%></a></span></td>
            <td><%=ds.getString("COMP_NO")%></td>
            <td title="<%=ds.getString("OWNER_NM")%>"><span class="ellipsis"><%=ds.getString("OWNER_NM")%></span></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="4">��ȸ�� ������ �����ϴ�. </td>
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
		<div class="Bbtn_areaC">
      <!-- a href="javascript:goRegist();"><img src="<%= request.getContextPath()%>/images/btn_reg3.gif" width="40" height="23" title="���"/></a -->
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
    <!-- //button -->
    </div>
    <!-- //contents -->
</div>
</body>
</html>
<script>
searchChk();
</script>
