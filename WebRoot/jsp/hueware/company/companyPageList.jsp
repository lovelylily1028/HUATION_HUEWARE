<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
/* 	CompanyDTO compDto = (CompanyDTO)model.get(compDto); */

	String curPage = (String)model.get("curPage");
	//String search = (String)model.get("search"); �̵�� ��ü ��ȸ �߰� 2013_03_18(��)shbyeon.(���������.)
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ü����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<!-- Tooltip -->
<style>
	.ui-tooltip, .arrow:after {background:#3ba90d !important;}
	.ui-tooltip {padding:5px 10px !important;background:#fff !important;color:#666 !important;border:1px solid #3ba90d !important;border-radius:5px;}
	.arrow {width:70px;height:16px;overflow:hidden;position: absolute;left:50%;margin-left:-33px;bottom:-16px;}
	.arrow.top {top:-16px;bottom:auto;}
	.arrow.left {left:20%;}
	.arrow:after {content: "";position:absolute;left:20px;top:-24px;width:25px;height:25px;-webkit-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}
	.arrow.top:after {bottom:-20px;top:auto;}
</style>
<!-- Tooltip -->


<script type="text/javascript">
/* Tooltip */

 $(function() {

    $( document ).tooltip({

      position: {

        my: "center bottom-20",

        at: "center top",

        using: function( position, feedback ) {

          $( this ).css( position );

          $( "<div>" )

            .addClass( "arrow" )

            .addClass( feedback.vertical )

            .addClass( feedback.horizontal )

            .appendTo( this );

        }

      }

    });

  });

/* Tooltip */

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
	function init_companyPageList() {
		
		formObj=document.companyform; //form��ü����
		
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
	
		//search �̵�Ͼ�ü search�� �߰� ���ִ� ���а��� �߰����ִ� ����������. JSPȭ�鿡�� ��û���� ���� �ּ�ó����.(������.)
		<%-- formObj.search.value='<%=search%>'; --%>
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
    
	//�˻�
	function goSearch() {
		var gubun= formObj.searchGb.value;

		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('��ȣ(���θ�)�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='B'){
			if( formObj.searchtxt.value==''){
				alert('����ڵ�Ϲ�ȣ �Է��� �ּ���');
				return;
			}
		}else if(gubun=='C'){
			if( formObj.searchtxt.value==''){
				alert('��ǥ�ڸ��� �Է��� �ּ���');
				return;
			}
		}
		
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();

    }
    
	//����������� �̵�
	function goRegist() {

	     formObj.target ='_self';	//(default)����â�� ǥ��
		 formObj.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyRegistForm";		
		 formObj.submit();

	}
    
	//�������� �̵�
	function goDetail(comp_code){
		 
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyView";
		 formObj.comp_code.value=comp_code;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Company.do?cmd=companyExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Company.do?cmd=companyPageList";	
	}

	//-->
</script>
</head>
<body onload="init_companyPageList()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

<!-- title -->
 	<div class="content_navi">�ѹ����� &gt; ��ü����</div>
	<h3><span>��</span>ü����</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
<!-- //title -->

	<div class="con">
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
		<!-- ��ȸ -->
		<%
					
				ListDTO ld = (ListDTO)model.get("listInfo");
				DataSet ds = (DataSet)ld.getItemList();	
					
				int iTotCnt = ld.getTotalItemCount();
				int iCurPage = ld.getCurrentPage();
				int iDispLine = ld.getListScale();
				int startNum = ld.getStartPageNum();
					
														%>
 
  <%= ld.getPageScript("companyform", "curPage", "goPage") %>
<!--   <form  method="post"  name="excelform"> </form> -->
  <form  method="post" class="search" name=companyform action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList">
    <input type = "hidden" name = "objExcel" />
    <!-- <input type = "hidden" name = "filename" value="companyList.xls"> -->
    <input type = "hidden" name = "comp_nm" value="" />
    <input type = "hidden" name = "comp_no" value="" />
    <input type = "hidden" name = "comp_code" value="" />
    <input type = "hidden" name = "curPage"  value="<%=curPage%>" />
	
	<fieldset>
			<legend>�˻�</legend>

			          <!-- 
			          2013_05_13(��)shbyeon. ����������Ȳ,���������༭ �����Է��������� ���ο� Comp_Code ������ �����.
			        <select name="search" id="" class="" >
			          <option checked value="">��ü</option>
			          <option value="S">�̵�Ͼ�ü</option>
			        </select>
			           -->
						<ul>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->

							<li><select name="searchGb" onchange="searchChk()" id="" class="">
								<option checked value="">��ü</option>
								<option value="A" >��ȣ(���θ�)</option>
								<option value="B" >����� ��Ϲ�ȣ</option>
								<option value="C" >��ǥ�ڸ�</option>
							</select></li>
							<li><input type="text" class="text" title="�˻���" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //��ȸ -->
					
					<!-- Top ��ư���� -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="#" class="btn_type01 md0" onclick="javascript:goRegist();"><span>����ϱ�</span></a></div>
					<!-- //Bottom ��ư���� -->
					</div>
					<!-- //������ ��� ���� -->
    
    <!-- con -->
			<table class="tbl_type tbl_type_list" id="excelBody" summary="��ü��������Ʈ(�����ݾ�ü����, �ٿ�ε�, ����ڵ�Ϲ�ȣ, ��ȣ(���θ�), ���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ), ��ǥ�ڸ�, ������, ����, ����, �����)">
					
					<colgroup>
						<col width="4%" />
						<col width="7%" />
						<col width="10%" />
						<col width="15%" />
						<col width="10%" />
						<col width="10%" />
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="7%" />
					</colgroup>
					
					<thead>
					<tr>
						<th>�����ݾ�ü</th>
						<th>�ٿ�ε�</th>
						<th>����ڵ�Ϲ�ȣ</th>
						<th>��ȣ(���θ�)</th>
						<th>���ε�Ϲ�ȣ(�ֹε�Ϲ�ȣ)</th>
						<th>��ǥ�ڸ�</th>
						<th>������</th>
						<th>����</th>
						<th>����</th>
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
       <tbody>
        <tr>
        <%
        	String UNFIT_ID = ds.getString("UNFIT_ID");
        	if(!UNFIT_ID.isEmpty()){
        %>
        <!-- ������ ��ü�� �� -->
        <%
        	/* ������ ������, ������ ���� Tooltip */
        	String unfit_id = ds.getString("UNFIT_ID");
        	String unfit_reason = ds.getString("UNFIT_REASON");
        %>
        <td><img src="<%= request.getContextPath()%>/images/common/ico_unfit.gif" title="<%=unfit_id %> / <%=unfit_reason%>" alt="�����ݾ�ü"></td>
        <%
        	}else{
        %>
        <!-- �����ݾ�ü�� �ƴ� �� -->
        <td></td>
        <%
        	} 
        %>
          <td><%
                   String comp_file=ds.getString("COMP_FILE");
                   String account_file=ds.getString("ACCOUNT_COPY1");
                   String COMPANY_FILENM = ds.getString("COMPANY_FILENM");
                   String ACCOUNT_COPYNM1 = ds.getString("ACCOUNT_COPYNM1");
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=comp_file.lastIndexOf("/");
                    int a_index=account_file.lastIndexOf("/");
                    
                    String compfilename=comp_file.substring(c_index+1);
               
                    String accountfilename=account_file.substring(a_index+1);
                    
                    String comppath="";
                    
                    String accountpath="";
                   
                    if(!comp_file.equals("")){
                    	comppath=comp_file.substring(0,c_index);
                 %>
           			
            <%
            if(COMPANY_FILENM.equals("")){
            %>
            	<!-- ���ϸ� (COMPANY_FILENM)�� ���� ������ �����ö�(���������͵�)-->
             	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=compfilename%>&sFileName=<%=compfilename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="����ڵ����"></a>
            	<%
            	}if(!COMPANY_FILENM.equals("")){
            		//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                	String spStrReplace = "";
                	if(COMPANY_FILENM.indexOf("&") != -1){
                		spStrReplace=  COMPANY_FILENM.replace("&", "[replaceStr]");
                	System.out.println("spStrReplace:"+spStrReplace);
                	}else{
                		spStrReplace =  COMPANY_FILENM;	
                	System.out.println("spStrReplace:"+spStrReplace) ;
                	}
            	%>	
            	 <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=compfilename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="����ڵ����2"></a>	
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
            	<%
                if(!account_file.equals("")){
                	
                	accountpath=account_file.substring(0,a_index);
                %>
                	<!-- ���ϸ� (ACCOUNT_COPYNM1)�� ���� ������ �����ö�(���������͵�)-->
                	<%
                	if(ACCOUNT_COPYNM1.equals("")){	 
                	%>
                	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename%>&sFileName=<%=accountfilename%>&filePath=<%=accountpath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="����纻"></a>
                	<%
                 	}if(!ACCOUNT_COPYNM1.equals("")){
                 		//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                    	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                    	String spStrReplace = "";
                    	if(ACCOUNT_COPYNM1.indexOf("&") != -1){
                    		spStrReplace=  ACCOUNT_COPYNM1.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ACCOUNT_COPYNM1;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                	%>	 
            		<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=accountfilename%>&filePath=<%=accountpath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="����纻"></a>
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
        
          <td><%=ds.getString("PERMIT_NO")%></td>
          <td><a href="javascript:goDetail('<%=ds.getString("COMP_CODE")%>')"><%=ds.getString("COMP_NM")%></a></td>
          <td><%=ds.getString("COMP_NO")%></td>
          <td><%=ds.getString("OWNER_NM")%></td>
          <!--td><%=ds.getString("CHARGE_NM")%></td-->
          <td><%=DateTimeUtil.getDateType(1,ds.getString("OPENYMD"),"/")%></td>
          <td><%=ds.getString("BUSINESS")%></td>
          <td class="text_l"><%=ds.getString("B_ITEM")%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("REG_DT"),"/")%></td>
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
	   </tbody>
      </table>
      
    </div>
    <!-- //con -->
    
    <!-- ����¡  -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //����¡  -->
    
    <!-- Bottom ��ư���� -->
		<div class="Bbtn_areaR"><a href="#" class="btn_type01 md0" onclick="javascript:goRegist();"><span>����ϱ�</span></a></div>
	<!-- //Bottom ��ư���� -->
  
</div>
<!-- //contents -->
</div>
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%=comDao.getMenuAuth(menulist,"00") %>