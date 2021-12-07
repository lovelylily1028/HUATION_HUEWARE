<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.code.CodeDTO"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

    CodeDTO codeDto = (CodeDTO)model.get("codeDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String gubun =  (String)model.get("gubun");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ڵ�� ����������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){

	var frm = document.codeView; 

	if(frm.big_cd.value.length == 0){
		alert("�ڵ��ȣ�� �Է��ϼ���");
		return;
	}
	if(frm.sml_cd.value.length == 0){
		alert("�ڵ�з��� �Է��ϼ���");
		return;
	}
	if(frm.cd_nm.value.length == 0){
		alert("�ڵ���� �Է��ϼ���");
		return;
	}


	if(confirm("���� �Ͻðڽ��ϱ�?")){

		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		frm.submit();
	}
}

function goDelete(){

	var frm = document.codeView;
	if(confirm("���� �Ͻðڽ��ϱ�?")){

		frm.action='<%= request.getContextPath()%>/B_Code.do?cmd=codeDelete';
		frm.submit();
	}

}

function goList(){
	
	var frm = document.codeView;
	
	if('<%=gubun%>'=='BIG'){
		frm.action='<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
	}else{
		frm.action='<%= request.getContextPath()%>/B_Code.do?cmd=codeDetailList';
	}

	frm.submit();

}
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <!-- title -->
  <div class="content_navi">���� &gt; �ڵ�ϰ���</div>
  <h3><span>��</span>�����</h3>
  <!-- //title -->
  <!-- con -->
  <div class="con">
  <div class="conTop_area">
  <p class="must_txt"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
  </div>
    <form name="codeView" method="post" action="<%= request.getContextPath()%>/B_Code.do?cmd=codeEdit">
      <input type = "hidden" name = "curPage" value="<%=curPage%>">
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>">
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>">
      <input type = "hidden" name = "gubun" value="<%=gubun%>">
      <fieldset>
		<legend>�ڵ����</legend>
		<table class="tbl_type" summary="�ڵ����(�ڵ��ȣ, �ڵ�з�, �ڵ��, �ڵ弳��)">
        <caption>�ڵ����</caption>
        <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
        <% 
		   if(gubun.equals("BIG")){
         %>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ڵ��ȣ</label></th>
          <td><input type="text" name="big_cd" readOnly class="text" title="�ڵ��ȣ" style="width:200px;" value="*" /></td>
        </tr>
        <%
			}else{
		%>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ڵ��ȣ</label></th>
          <td><input type="text" name="big_cd" class="text" readOnly style="width:80px" title="�ڵ��ȣ" style="width:200px;" value="<%=codeDto.getBigCd()%>" /></td>
        </tr>
        <%
		 }
		%>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ڵ�з�</label></th>
          <td><input type="text" name="sml_cd" class="text" readOnly title="�ڵ�з�" style="width:200px;" value="<%=codeDto.getSmlCd()%>" /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ڵ��</label></th>
          <td><input type="text" name="cd_nm" class="text" maxlength="50"  title="�ڵ��" style="width:500px;" value="<%=codeDto.getCdNm()%>" /></td>
        </tr>
        <tr>
          <th><label for="">�ڵ弳��</label></th>
          <td><input type="text" name="cd_desc" class="text" maxlength="100"  title="�ڵ弳��" style="width:916px;" value="<%=codeDto.getCdDesc()%>" /></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
      </form>
      <!-- //��� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
  	    <!-- //Bottom ��ư���� -->
  	  </div>
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
<%= comDao.getMenuAuth(menulist,"63") %>