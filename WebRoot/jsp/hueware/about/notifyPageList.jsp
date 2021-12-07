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
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������� ����Ʈ</title>
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
		var obj=document.notifyform;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			if(obj.searchtxt.value==''){
				alert('������ �Է��� �ּ���');
				return;
			}
		}
		
		obj.curPage.value='1';
		obj.submit();

    }

	function goRegist() {

		document.notifyform.target ='_self';
		document.notifyform.action = "<%= request.getContextPath()%>/B_About.do?cmd=notifyRegistForm";		
		document.notifyform.submit();

	}

	function goDetail(notify_no){
		
		document.notifyform.target ='_self';
		document.notifyform.action = "<%= request.getContextPath()%>/B_About.do?cmd=notifyView";
		document.notifyform.notify_no.value=notify_no;
		document.notifyform.submit();

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
	
	function init_notify() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	}
	
	function searchChk(){

		var obj = document.notifyform;

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

<body onload="init_notify()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome���� &gt; ��������</div>
			<h3><span>��</span>������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con" id="excelBody">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- ��ȸ -->
					<%= ld.getPageScript("notifyform", "curPage", "goPage") %>
					<form  method="post" name="excelform"></form>
					<form  method="post" name=notifyform action = "<%= request.getContextPath()%>/B_About.do?cmd=notifyPageList" class="search">
					   <input type = "hidden" name = "notify_no"/>
					   <input type = "hidden" name = "filename" value="notifyList.xls"/>
					   <input type = "hidden" name="curPage"  value="<%=curPage%>"/>

					<fieldset>
						<legend>�˻�</legend>
						<ul>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<li><select id="" title="�˻����Ǽ���" name="searchGb" onchange="searchChk()">
								<option checked value="">��ü</option>
								<option value="A" <%=aselect%>>����</option>
								<!--option value="B"  <%=bselect%>>����� ��Ϲ�ȣ</option>
	  							<option value="C"  <%=cselect%>>��ǥ�ڸ�</option-->
							</select></li>
							<li><input type="text" class="text" name="searchtxt" title="�˻���" id="" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //��ȸ -->
					<!-- Top ��ư���� -->
					<div class="Tbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
					<!-- //Top ��ư���� -->
				</div>
				<!-- //������ ��� ���� -->    

				<!-- ����Ʈ -->
				<table class="tbl_type tbl_type_list" summary="�������׸���Ʈ(No., ����, �ۼ���, �����)">
					<colgroup>
						<col width="5%" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
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
			while(ds.next()){
		
				no=Long.parseLong(ds.getString("NOTI_NO"));
		%>

		<tbody>
        <tr>
          <td><%=no%></td>
          <td  class="text_l" title="<%=ds.getString("SUBJECT")%>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("NOTI_NO")%>')"><%=ds.getString("SUBJECT")%></a></span></td>
          <td><%=ds.getString("REG_ID")%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("REG_DT"),"/")%></td>
        </tr>
        <!-- :: loop :: -->
        <%		
		    i++;
		    }
		}else{
		%>
        <tr>
          <td colspan="4">�Խù��� �����ϴ�.</td>
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
<script>
searchChk();
</script>
<%= comDao.getMenuAuth(menulist,"40") %>