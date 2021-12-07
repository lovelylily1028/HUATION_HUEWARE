<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>

<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String)model.get("curPage");
	String searchGb =(String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ڵ� ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
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

<!--
	var  formObj;//form ��ü����
	
	//�ʱ⼼��
	function inits() {
		
		formObj=document.codeform; //form��ü����
		
		searchInit(); //��ȸ�ɼ� �ʱ�ȭ
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //ó���� �޼��� ��Ȱ��ȭ
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	
	}
	
	//��ȸ
	function goSearch() {

		var gubun=formObj.searchGb.value;

		if(gubun=='SML_CD'){
			if( formObj.searchtxt.value==''){
				alert('�ڵ�з� �Է��� �ּ���');
				return;
			}
		}else if (gubun=='CD_NM'){
			if( formObj.searchtxt.value==''){
				alert('�ڵ���� �Է��� �ּ���');
				return;
			}
		}else if (gubun=='CD_DESC'){
			if( formObj.searchtxt.value==''){
				alert('�ڵ弳���� �Է��� �ּ���');
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
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeRegistForm";		
		 formObj.submit();

	}
    
	//��
	function goDetail(sml_cd){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeView";
		 formObj.sml_cd.value=sml_cd;
		 formObj.curPage.value='1';
		 formObj.submit();

	}
    
	//�󼼸���Ʈ
	function goDetailList(sml_cd){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Code.do?cmd=codeDetailList";
		 formObj.sml_cd.value=sml_cd;
		 formObj.curPage.value='1';
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Code.do?cmd=codePageList";	
	}
//-->

</script>
</head>
<body onload = "inits();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
    <!-- title -->
    <div class="content_navi">���� &gt; �ڵ�ϰ���</div>
	<h3><span>��</span>��ϰ���</h3>
    <!-- //title -->
  <div class="con codePageList">
  <div class="conTop_area">
  <%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>
  
  <%= ld.getPageScript("codeform", "curPage", "goPage") %>
  <form  method="post" name="excelform">
  </form>
  <form  method ="post" name=codeform action = "<%= request.getContextPath()%>/B_Code.do?cmd=codePageList" class="search">
    <input type = "hidden" name = "sml_cd"/>
    <input type = "hidden" name = "big_cd" value="*"/>
    <input type = "hidden" name = "gubun" value="BIG"/>
    <input type = "hidden" name = "listPage" value="<%=curPage%>"/>
    <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
   
    <!-- search -->
      <fieldset>
        <legend>�˻�</legend>
        <ul>
        <li><select name="searchGb" onchange="searchChk()">
          <option checked value="">��ü</option>
          <option value="SML_CD" >�ڵ�з�</option>
          <option value="CD_NM"   >�ڵ��</option>
          <option value="CD_DESC"  >�ڵ弳��</option>
        </select></li>
        
        <li><input type="text" name="searchtxt" value="<%=searchtxt%>"  class="text" maxlength="100" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
       </ul>
      </fieldset>
        </form>
    <!--//search -->
    <!-- Top ��ư���� -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
	<!-- //Top ��ư���� -->
     </div>
    
    <table class="tbl_type tbl_type_list" summary="�ڵ�ϰ�������Ʈ(�ڵ�з�, �ڵ��, �ڵ弳��)">
        <caption>�ڵ帮��Ʈ</caption>
        <colgroup>
			<col width="30%" />
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<thead>
		<tr>
			<th>�ڵ�з�</th>
			<th>�ڵ��</th>
			<th>�ڵ弳��</th>
		</tr>
		</thead>
		<tbody>
        
        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			while(ds.next()){
		%>
          <tr>
            <td><%=ds.getString("SML_CD")%><a href="javascript:goDetailList('<%=ds.getString("SML_CD")%>')" class="btn_type03"><span>�󼼸���Ʈ</span></a></td>
            <td><a href="javascript:goDetail('<%=ds.getString("SML_CD")%>')"><%=ds.getString("CD_NM")%></a></td>
            <td><%=ds.getString("CD_DESC")%></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="3">�Խù��� �����ϴ�.</td>
          </tr>
          <% 
}
%>
      </table>
<!-- paginate -->
<div class="paging">
<%=ld.getPagging("goPage")%>
</div>
      
      <!-- Bottom ��ư���� -->
      <div class="Bbtn_areaR">
        <a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a>
      </div>
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