<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 

	String curPage = (String) model.get("curPage");
	String searchGb = (String) model.get("searchGb");
	String searchtxt = (String) model.get("searchtxt");
	
	String position = "-";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���� ����</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
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

	var observerkey=false;//ó���߿���
	var openWin=0;//�˾���ü
	
	var  formObj;//form ��ü����
	
	//�ʱ⼼��
	function inits() {
		
		formObj=document.UserForm; //form��ü����

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
	
	//�˻�
	function goSearch() {
	
		var gubun= formObj.searchGb.value;
		var invalid = ' ';	//���� üũ
	
		if(gubun=='1'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('����� �̸��� �Է��� �ּ���');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='2'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('����� ID�� �Է��� �ּ���');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='3'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('�ѽ���ȣ�� �Է��� �ּ���');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='4'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('��ȭ��ȣ�� �Է��� �ּ���');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}else if(gubun=='5'){
			if( formObj.searchtxt.value=='' ||  formObj.searchtxt.value.indexOf(invalid) > -1){
				 alert('�׷�ID�� �Է��� �ּ���');
				 formObj.searchtxt.value="";
				 formObj.searchtxt.focus();
				return;
			}
		}
		
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userPageList";
		 if(observerkey==true){return;}
		 openWaiting( );
		 formObj.curPage.value='1';
		 formObj.submit();
	}
	
	//���� �˾�
	function goDetail(ID){
		var url = "<%=request.getContextPath()%>/B_User.do?cmd=userModifyForm";
		var params = "&ID=" + ID;
	
		if(openWin != 0) {
			  openWin.close();
		}
		
		openWin=window.open(url + params, "", "width=806, height=735, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
		
	}
	
	//��� �˾�
	function goRegist() {
		if(openWin != 0) {
			  openWin.close();
		}
		openWin=window.open("<%=request.getContextPath()%>/B_User.do?cmd=userRegistForm","","width=806, height=613, top=150, left=592, toolbar=no, menubar=no, scrollbars=no, status=no");
	}
	
	//üũ�ڽ� ��ü ����
	function fnCheckAll(objCheck) {
		  var arrCheck = document.getElementsByName('checkbox');
		  
		  for(var i=0; i<arrCheck.length; i++){
		  	if(objCheck.checked) {
		    	arrCheck[i].checked = true;
		    } else {
		    	arrCheck[i].checked = false;
		    }
		 }
	}
	
	//üũ �ڽ� ���� ����(�ٰ�/�ܰ�) 
	function goDelete(){

		var checkYN;
		//var checks=0;
		if( formObj.seqs.length>1){
			for(i=0;i< formObj.seqs.length;i++){
				if( formObj.checkbox[i].checked==true){
					checkYN='Y';
					//checks++;
				}else{
					checkYN='N';
				}
				 formObj.seqs[i].value=fillSpace( formObj.checkbox[i].value)+'|'+fillSpace(checkYN);
			}
		}else{
			if( formObj.checkbox.checked==true){
				checkYN='Y';
				//checks++;
			}else{
				checkYN='N';
			}
			 formObj.seqs.value=fillSpace( formObj.checkbox.value)+'|'+fillSpace(checkYN);
			
		}
		var checks = document.getElementsByName("checkbox");
		var users = new Array();
		
		for(var i = 0; i < checks.length; i++) {	
			if (checks[i].checked ){
				users.push(checks[i].ID);	//users�� push�� �̿��� üũ�� ���� ��´�.
			}
		}
		
		if (users.length == 0){
			alert("������ ����ڸ� ������ �ּ���!")
		} else {
			if(!confirm("������ �����Ͻðڽ��ϱ�?"))
				return;
			
			 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userDeletes";
			 formObj.submit();
		}
	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_User.do?cmd=userPageList";	
	}

</script>
</head>
<body onload = "inits();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
//	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  
  <%=ld.getPageScript("UserForm", "curPage", "goPage")%>
  <form method="post" name=UserForm action="<%=request.getContextPath()%>/B_User.do?cmd=userPageList">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="users" value=""/>
    <input type="hidden" name="SearchGroup" value=""/>
    
<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
 <!-- title -->
<div class="content_navi">���� &gt; ��������</div>
<h3><span>��</span>������</h3>
<!-- //title -->
<!-- con -->
<div class="con">
<div class="conTop_area">
    <!-- search -->
    <div class="search">  
      <fieldset>
        <legend>�˻�</legend>
       <ul> 
       <li><select id="select" name="searchGb" title="�˻����Ǽ���" onchange="searchChk()">
			<option checked value="">��ü</option>
			<option  value="1">����ڸ�</option>
			<option  value="2">ID</option>
			<option  value="4">��ȭ��ȣ</option>
		</select></li>
        
        <li><input type="text" name="searchtxt" value="<%=searchtxt%>" class="text" maxlength="100" id="textfield_search2" onkeydown="if(event.keyCode == 13)  goSearch()" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
        </ul>
      </fieldset>
      </div>     
    <!--//search -->
    <!-- Top ��ư���� -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>�����ޱ�</span></a><a href="javascript:goRegist();" class="btn_type01"><span>����ϱ�</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>�����ϱ�</span></a></div>
	<!-- //Top ��ư���� -->
   </div>

      <table class="tbl_type tbl_type_list" summary="������������Ʈ(����, ����ڸ�, ID, �Ҽ�, ��ȭ��ȣ, ��뿩��, ���ʵ������, ������������)">
		<colgroup>
			<col width="3%" />
			<col width="5%" />
			<col width="5%" />
			<col width="8%" />
			<col width="13%" />
			
			<col width="6%" />
			<col width="10%" />
			<col width="6%" />
			<col width="9%" />
			<col width="9%" />
			
			<col width="5%" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			
		</colgroup>
        <thead>
        <tr>
        <th><input type="checkbox" id="checkboxAll" class="check md0"  name="checkboxAll" onclick="fnCheckAll(this)"/></th>
			<th>����ڸ�</th>
			<th>ID</th>
			<th>���</th>
			<th>�ֹι�ȣ</th>
			<th>����(��)</th>
			<th>�Ҽ�</th>
			<th>����</th>
			<th>�޴�����ȣ</th>
			<th>�系�����ȣ</th>
			<th>��뿩��</th>
			<th>�Ի���</th>
			<th>�����</th>
			<th>�����η���������</th>
		</tr>
		</thead>
		<tbody>
        
        <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String HireDate ="";
                    	
                    	if(ds.getString("HireDateTime").equals("")){
                    		HireDate ="";
                    	}else{
                    		HireDate = ds.getString("HireDateTime").substring(0,10);
                    	}
            %>
        <tr>
          <input type="hidden" name="seqs" >
          <td><input type="checkbox" name="checkbox" value="<%=ds.getString("UserID")%>" /></td>
          <td><a href="#none" onclick="goDetail('<%=ds.getString("UserID")%>');"><%=ds.getString("UserName")%></a></td>
          <td><%=ds.getString("UserID")%></td>
          <td><%=ds.getString("EmployeeNum")%></td>
          <td><%=ds.getString("jumin1").equals("-")?ds.getString("jumin1"):ds.getString("jumin1")+"******"%></td>
          <td><%=ds.getString("jumin2")%></td>
          <td><%=ds.getString("GroupName")%></td>
          <td>
          <%
         		if(ds.getString("Position").equals("A")) {
          			position = "��ǥ�̻�";
          		} else if(ds.getString("Position").equals("B")) {
          			position = "�̻�";
          		} else if(ds.getString("Position").equals("C")) {
          			position = "�׷츮��";
          		} else if(ds.getString("Position").equals("D")) {
          			position = "������";
          		} else if(ds.getString("Position").equals("E")) {
          			position = "�Ŵ���";
          		} else if(ds.getString("Position").equals("F")) {
          			position = "���";
          		} else if(ds.getString("Position").equals("G")) {
          			position = "����";
          		} else if(ds.getString("Position").equals("6")) {
          			position = "��Ÿ";
          		}
          %>
          <%=position %>
          </td>
          <td><%=ds.getString("OfficeTellNoFormat")%></td>
          <td><%=ds.getString("OfficeTellNoFormat2")%></td>
          <td><%=ds.getString("UseYN")%></td>
          <td><%=HireDate%></td>
          <td><%=ds.getString("FireDateTime") %></td>
                    <td><%
                   String BoardFile=ds.getString("BoardFile");
          		   String BoardFileNm=ds.getString("BoardFileNm");
          
                    
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
                   String serverUrl = "";// + request.getServerName() + request.getContextPath();
                    int c_index=BoardFile.lastIndexOf("/");
                  	
                    String boardfilename=BoardFile.substring(c_index+1);
              
                    String boardpath=""; //���ϰ�� �о����
                   
                    	
          
                    if(!BoardFile.equals("")){
                    	boardpath=BoardFile.substring(0,c_index); //���ϰ�� �о����
                    	
                    	//���ϸ� (&) ���� ���� �� �ش� ���ڿ� ���� ([replaceStr]) ġȯ
                    	//Descript: get������� ���� ������ ���� �Ķ���� ���� �� rFileName �� & �� �� �� �Ķ���͸� �ѱ�� �ɷ� �ν��Ͽ� �ѱ� ���ϸ� ���� ����� �������� ����.
                    	String spStrReplace = "";
                    	if(BoardFileNm.indexOf("&") != -1){
                    		spStrReplace=  BoardFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  BoardFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                 %>
           
            <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=boardfilename%>&filePath=<%=boardpath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" title="�����η���������"></a>
            	<%
                     }
               
                %>
       </td>
       
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="11">�Խù��� �����ϴ�.</td>
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
<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01"><span>����ϱ�</span></a><a href="javascript:goDelete();" class="btn_type01 btn_type01_gray md0"><span>�����ϱ�</span></a></div>
    </div>
    <!-- //con -->

  
</div>
<!-- //contents -->
</div>
<!-- //container -->
 </form>

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"60") %>