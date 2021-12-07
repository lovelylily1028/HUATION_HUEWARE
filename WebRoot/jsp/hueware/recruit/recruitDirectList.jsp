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
	String aselect="";
	String bselect="";
	String cselect="";

	if(searchGb.equals("A")){
		searchtxt=(String)model.get("searchtxt");
		aselect="selected";
	}else if(searchGb.equals("C")){
		searchtxt=(String)model.get("searchtxt");
		cselect="selected";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ä�빮�� ����Ʈ(1:1 ����)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
<!--


	function goSearch() {

		var obj=document.Qnaform;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			if(obj.searchtxt.value==''){
				alert('�˻��Ͻ� ������ �Է��� �ּ���');
				return;
			}
		}else if(gubun=='C'){
			if(obj.searchtxt.value==''){
				alert('�˻��Ͻ� �̸��� �ּҸ� �Է��� �ּ���');
				return;
			}
		}
		
		obj.curPage.value='1';
		obj.submit();

    }

	function goDetail(qna_no){
		
		document.Qnaform.target ='_self';
		document.Qnaform.action = "<%=request.getContextPath()%>/B_Recruit.do?cmd=qnaDirectView";
		document.Qnaform.qna_no.value=qna_no;
		document.Qnaform.submit();

	}

	// ���⼭ ���ʹ� ó���� ǥ���ϴ� function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//���̱�
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function init_recruitDirect() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	}

	function searchChk(){

		var obj = document.Qnaform;

		if(obj.searchGb[0].selected==true){
			obj.searchtxt.disabled=true;
			obj.searchtxt.value='';	
		}else {
			obj.searchtxt.disabled=false;
		}
	}
//-->
</script>
</head>

<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>

<body onload="init_recruitDirect()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome���� &gt; ä�빮��(1:1����)</div>
			<h3><span>ä</span>�빮��(1:1����)</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con recruitQnAList_02">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- ��ȸ -->
					<%= ld.getPageScript("Qnaform", "curPage", "goPage") %>
					  <form  method="post" name="excelform"></form>
					  <form  method="post" class="search" name=Qnaform action = "<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList">
					    <input type = "hidden" name="qna_gb"  value="02"/>
					    <input type = "hidden" name="qna_no" />
					    <input type = "hidden" name="curPage"  value="<%=curPage%>"/>
    
					<fieldset>
						<legend>�˻�</legend>
						<ul>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<li><select id="" title="�˻����Ǽ���" name="searchGb" onchange="searchChk()">
								<option checked value="">��ü</option>
								<option value="A"  <%=aselect%>>����</option>
								<option value="C"  <%=cselect%>>�������(�̸���)</option>
							</select></li>
							<li><input type="text" class="text" title="�˻���" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01 md0"><span>�˻�</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //��ȸ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ����Ʈ -->
				<table class="tbl_type tbl_type_list" summary="ä�빮�Ǹ���Ʈ(1:1����)(No., �亯����, ����, �ۼ���, �����)">
					<colgroup>
						<col width="5%" />
						<col width="8%" />
						<col width="*" />
						<col width="15%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>�亯����</th>
						<th>����</th>
						<th>�ۼ���</th>
						<th>�����</th>
					</tr>
					</thead>
   
        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			long  no=0;
			String answer="";
			String clr="";
			while(ds.next()){
		
					no=Long.parseLong(ds.getString("QNA_NO"));
					answer=ds.getString("ANSWER");
					if(answer.equals("")){
						answer="�̿Ϸ�";
						clr="replyNo";
					}else{
						answer="�亯�Ϸ�";
						clr="replyOk";
					}
		%>
      <tbody>  
        <tr>
          <td><%=no%></td>
          <td class="<%=clr%>"><%=answer%></td>
          <td  class="text_l" title="<%=ds.getString("SUBJECT")%>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("QNA_NO")%>')"><%=ds.getString("SUBJECT")%></a></span></td>
          <td><%=ds.getString("EMAIL")%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("REG_DT"),"/")%></td>
        </tr>
        
        <!-- :: loop :: -->
		<%		
		    i++;
		    }
		}else{
		%>
        <tr>
          <td colspan="660" >�Խù��� �����ϴ�.</td>
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
<script>
searchChk();
</script>
<%= comDao.getMenuAuth(menulist,"45") %>