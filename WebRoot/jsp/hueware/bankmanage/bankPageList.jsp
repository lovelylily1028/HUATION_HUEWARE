<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>

<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������� ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
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
	function init_bank() {
		
		formObj=document.bankmanageform; //form��ü����
		
		//��ȸ�ɼ� �ʱ�ȭ searchInit(); 
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //ó���� �޼��� ��Ȱ��ȭ
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	
	}
    
	//��������� �̵�
	function goRegist() {

	     formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankRegistForm";		
		 formObj.submit();

	}
   
	//�������� �̵�
	function goDetail(AccountNumber){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankView";
		 formObj.AccountNumber.value=AccountNumber;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_BankManage.do?cmd=bankExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_BankManage.do?cmd=bankPageList";	
	}
	
	//-->
</script>
</head>
<body onload="init_bank()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
   	<!-- title -->
    <div class="content_navi">�ѹ����� &gt; �����������</div>
	<h3><span>��</span>���������</h3>
    <!-- //title -->
	<div class="con">
	  <%
		ListDTO ld = (ListDTO)model.get("listInfo");
		DataSet ds = (DataSet)ld.getItemList();	
		
		int iTotCnt = ld.getTotalItemCount();
		int iCurPage = ld.getCurrentPage();
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
		%>
	  
	  <%= ld.getPageScript("bankmanageform", "curPage", "goPage") %>
	  <form  method="post" name="bankmanageform" action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList">
	    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>
	    <input type="hidden" name="AccountNumber" value=""/>
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a></div>
		</div>
		<!-- //������ ��� ���� -->
		<!-- ����Ʈ -->
		<table class="tbl_type tbl_type_list" summary="���������������Ʈ(�ٿ�ε�, �����, �����ڵ�, ���¹�ȣ, �ű���(������), ������, ���°�����(�ű���), ���������, ����ȣ, �����, �����)">
			<colgroup>
				<col width="7%" />
				<col width="*" />
				<col width="7%" />
				<col width="11%" />
				<col width="7%" />
				<col width="7%" />
				<col width="11%" />
				<col width="11%" />
				<col width="11%" />
				<col width="7%" />
				<col width="7%" />
			</colgroup>
			
			<thead>
				<tr>
					<th>�ٿ�ε�</th>
					<th>�����</th>
					<th>�����ڵ�</th>
					<th>���¹�ȣ</th>
					<th>�ű���(������)</th>
					<th>������</th>
					<th>���°�����(�ű���)</th>
					<th>���������</th>
					<th>����ȣ</th>
					<th>�����</th>
					<th>�����</th>
				</tr>
			</thead>
	        <!-- :: loop :: -->
	        <!--����Ʈ---------------->
	        
	        <%			
	    if(ld.getItemCount() > 0){	
	        int i = 0;
	        while(ds.next()){
	    %>
	    
	    <thead>
	        <tr>
	          <td><%
	                   String bank_file=ds.getString("BankBookFile");
	                   String BankBookFileNm = ds.getString("BankBookFileNm");
	                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
	                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
						String serverUrl = "" + request.getContextPath();
	                    int c_index=bank_file.lastIndexOf("/");
	                    
	                    String bank_filename=bank_file.substring(c_index+1);
	                    
	                    String comppath="";
	                    
	                    String accountpath="";
	                   
	                    if(!bank_file.equals("")){
	                    	comppath=bank_file.substring(0,c_index);
	                 %>
	           			
	            
	            <%
	            if(BankBookFileNm.equals("")){
	            %>
	            	
	            	<!-- ���ϸ� (COMPANY_FILENM)�� ���� ������ �����ö�(���������͵�)-->
	             	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=bank_filename%>&sFileName=<%=bank_filename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="����ڵ����"></a>
	            	<%
	            	}if(!BankBookFileNm.equals("")){
	            		//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
	                	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
	                	String spStrReplace = "";
	                	if(BankBookFileNm.indexOf("&") != -1){
	                		spStrReplace=  BankBookFileNm.replace("&", "[replaceStr]");
	                	System.out.println("spStrReplace:"+spStrReplace);
	                	}else{
	                		spStrReplace =  BankBookFileNm;	
	                	System.out.println("spStrReplace:"+spStrReplace) ;
	                	}
	            	%>	
	            	 <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=bank_filename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="��������纻"></a>	
	            	<%
	            	}
	            	%>
	            		 <%
	                    	}else{
	                	 %>
					<!-- �����߰��������� -->
	                     <%                     
	                     	}
	                     %>	
	                </td>
	          <td><%=ds.getString("BankName")%></td>
	          <td><%=ds.getString("BankCode")%></td>
	          <td><a href="javascript:goDetail('<%=ds.getString("AccountNumber")%>')"><%=ds.getString("AccountNumber")%></a></td>
	          <td><%=ds.getString("NewDate")%></td>
	          <td><%=ds.getString("ReturnDate")%></td>
	          <td title="<%=ds.getString("AccountManage") %>"><span class="ellipsis"><%=ds.getString("AccountManage")%></span></td>
	          <td title="<%=ds.getString("BankBook") %>"><span class="ellipsis"><%=ds.getString("BankBook")%></span></td>
	          <td title="<%=ds.getString("CustomerNum") %>"><span class="ellipsis"><%=ds.getString("CustomerNum")%></span></td>
	          <td><%=ds.getString("CreateDate")%></td>
	          <td><%=ds.getString("RegistrationName")%></td>
	        </tr>
	        <!-- :: loop :: -->
	        <%		
	        i++;
	        }
	    }else{
	    %>
	        <tr>
	          <td colspan="10">�Խù��� �����ϴ�.</td>
	        </tr>
	        <% 
	    }
	    %>
	    
	    </thead>
     </table>
     
    <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
    
    <!-- Bottom ��ư���� -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>����ϱ�</span></a>	</div>
	<!-- //Bottom ��ư���� -->
      </form>
    </div>
    <!-- //con -->
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
<%=comDao.getMenuAuth(menulist,"01") %>