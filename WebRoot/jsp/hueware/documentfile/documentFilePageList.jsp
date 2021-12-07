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
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���� �������� ����Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
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
	
	var  formObj;//form ��ü����
	//�ʱ⼼��
	function init_document() {
		
		formObj=document.documentPageListForm; //form��ü����
		
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
				alert('������ �Է����ּ���.');
				return;
			}
		}
	
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();
	
	}
	
	
	// ��� ������ �̵�
	function goRegist(){
		
		
		formObj.target ='_self';							
		formObj.action = "<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileRegistForm";
		formObj.submit();
	}
	
	//�������� �̵�
	function goDetail(Seq){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentfileView";
		 formObj.Seq.value=Seq;
		 formObj.submit();
	}

//-->
</script>
</head>
<body onload="init_document()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">�Խ��� &gt; ����Manual</div>
			<h3><span>��</span>��Manual</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- ��ȸ -->
  
				  <%
					ListDTO ld = (ListDTO) model.get("listInfo");
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
				%>
  
			  <%=ld.getPageScript("documentPageListForm", "curPage", "goPage")%>
			  <form method="post" name="documentPageListForm" action="<%=request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList" class="search">
			    <input type="hidden" name="curPage" value="<%=curPage%>"/>
			    <input type="hidden" name="Seq" value=""/>

					<fieldset>
						<legend>�˻�</legend>
		         			<!-- �޷� ���� -->
		                 	<!--  >input name="FrDate" type="text" value="" class="textField" id="calendarData1" size="10" value="" readonly="readonly" dispName="��¥" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle"  onclick="new CalendarFrame.Calendar(document.getElementById('calendarData1'),'','','','','','','','810px','200px')" />
		                    ~ 
		                    <div id="CalendarLayer" style="display:none; width:172px; height:176px">
		                    <iframe name="CalendarFrame" id="CalendarFrame" src="/html/lib.calendar2.js.html" width="172" height="250" border="0" frameborder="0" scrolling="no"></iframe>
		                    </div> 
		                   	<input name="ToDate" type="text" value="" class="textField" id="calendarData2" size="10" value="" readonly="readonly" dispName="��¥" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" /> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle" onclick="new CalendarFrame.Calendar(document.getElementById('calendarData2'),'','','','','','','','910px','200px')"-->
		                    <!-- �޷� ���� -->
		        			<!-- �޷� ���� -->
		        			<!-- 
		                 	<input name="FrDate"  type="text" value="" class="textField" id="calendarData1" size="10" readonly="readonly" dispName="��¥" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle"  onclick="showCalendar('1')" />
		                    ~ 
		                 	<input name="ToDate"  type="text" value="" class="textField" id="calendarData2" size="10" readonly="readonly" dispName="��¥" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" /> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle" onclick="showCalendar('2')">
		                    <!-- �޷� ���� -->						
						<ul>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<li><select id="" title="�˻����Ǽ���" name="searchGb" onchange="searchChk()">
								<option checked value="">��ü</option>
								<option value="1">������</option>
							</select></li>
							<li><input type="text" class="text" title="�˻���" id="textfield_search2" name="searchtxt" maxlength="100" value="<%=searchtxt %>"/></li>
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
				<table class="tbl_type tbl_type_list" summary="����Manual����Ʈ(÷������, �з�, �����, �����ۼ���, �����, ��Ͻð�, ������, ��ȸ��)">
					
					<colgroup>
						<col width="5%" />
						<col width="12%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="*" />
						<col width="5%" />
					</colgroup>
					
					<thead>
					<tr>
						<th>÷������</th>
						<th>�з�</th>
						<th>�����</th>
						<th>�����ۼ���</th>
						<th>�����</th>
						<th>��Ͻð�</th>
						<th>������</th>
						<th>��ȸ��</th>
					</tr>
					</thead>   

        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        	<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                  
            %>
        
       <tbody> 
        <tr>
          <td><%
                   String DocumentFile=ds.getString("DocumentFile");
          		   String DocumentFileNm=ds.getString("DocumentFileNm");
          
                    
                  // String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=DocumentFile.lastIndexOf("/");
                  	
                    String documentfilename=DocumentFile.substring(c_index+1);
              
                    String documentFilepath=""; //���ϰ�� �о����
                   
                    	
          
                    if(!DocumentFile.equals("")){
                    	documentFilepath=DocumentFile.substring(0,c_index); //���ϰ�� �о����
                    	
                    	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                    	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                    	String spStrReplace = "";
                    	if(DocumentFileNm.indexOf("&") != -1){
                    		spStrReplace=  DocumentFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  DocumentFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                 %>
           
            <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=documentfilename%>&filePath=<%=documentFilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down01.gif" width="16" height="16" align="absmiddle" title="÷������"></a>
            <%
                     }
               
                %>
       </td>

       	  <td><%=ds.getString("FormGroupNm")%></td>
          <td><%=ds.getString("WriteUserName") %></td>
          <td><%=ds.getString("WriteFormUserNm") %></td>
          <td><%=ds.getString("CreateDate") %></td>
          <td><%=ds.getString("CreateTime") %></td>
          <td class="text_l" title="<%=ds.getString("Title") %>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("Seq")%>')"><%=ds.getString("Title") %></a></span></td>  
          <td><%=ds.getString("ReadCount") %></td>
        </tr>
        <!-- :: loop :: -->
       
       		<%
                i++;
                    }
                } else {
            %>
        
        <tr>
          <td colspan="8">�Խù��� �����ϴ�.</td>
        </tr>
       
        	<%
                }
            %>
        </tbody>
      </table>

			    <!-- paginate -->
			    <div class=paging>
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
<%= comDao.getMenuAuth(menulist,"35") %>