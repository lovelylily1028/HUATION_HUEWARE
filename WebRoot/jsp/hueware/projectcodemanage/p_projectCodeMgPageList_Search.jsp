<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt=(String)model.get("searchtxt");
	String sForm = (String)model.get("sForm");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�� ������Ʈ ��ȸ ����Ʈ</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
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
function init() {
	
	formObj=document.p_ProjectCodeSearchForm; //form��ü����
	
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
			alert('������Ʈ �ڵ��ȣ�� �Է����ּ���.');
			return;
		}
	}else if(gubun=='2'){
		if( formObj.searchtxt.value==''){
			alert('������Ʈ ���� �Է����ּ���.');
			return;
		}
	}else if(gubun=='3'){
		if( formObj.searchtxt.value==''){
			alert('���� ���� �Է����ּ���.');
			return;
		}
	}else if(gubun=='4'){
		if( formObj.searchtxt.value==''){
		alert('��翵���� �Է����ּ���.');
		return;
		}
	}else if(gubun=='5'){
		if( formObj.searchtxt.value==''){
		alert('���PM�� �Է����ּ���.');
		return;
		}
	}

	openWaiting();
	
	formObj.curPage.value='1';
	formObj.submit();

}
	//�� ������Ʈ �����ϱ�.(�����ڵ嵵 �����ؿ�.)
	function goSelect(projectcode,projectname){

		var project_code=eval('opener.document.<%=sForm%>.P_ProjectCode');
		var project_name=eval('opener.document.<%=sForm%>.P_ProjectName');
		//var project_name;
		
		project_code.value=projectcode;			//�� ������Ʈ �ڵ� ��ȣ ������ �� ���� �� openner�� �Ѱ��ֱ�.
		project_name.value=projectname;			//�� ������Ʈ �� ������ �� ���� �� openner�� �Ѱ��ֱ�.
		
		<%-- Get ��� ó�� ���.
		document.p_ProjectCodeSearchForm.action = "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectMoreCodeMgCreate&project_code="+projectcode+"&project_name="+projectname;
		document.p_ProjectCodeSearchForm.submit();
		--%>
		
		//Jquery Ajax..(�� ������Ʈ �ڵ� ������������ �����ڵ� ���� Action ȣ�� Start.)
		$.ajax({
			   url : "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectMoreCodeMgCreate",
			   type : "post",		//Post���.
			   dataType : "text",	//����Ÿ Ÿ�� �ؽ�Ʈ.
			   async : false,		//���ũ false = �񵿱�, true = ����
			   
			   //�Ѱ��� �Ķ���� �� ���� �� ����.
			   data : {				
			    "project_code" : project_code.value	//������ ������Ʈ �ڵ� �� ������.
			   },
			   //���� �� �Ʒ� ��� ����. Action�ܿ��� ������ Data
			   success : function(data, textStatus, XMLHttpRequest){
				   
				   if(data != "MAX"){					   
				   //�� ������Ʈ �ڵ�� ���� ������ �����ڵ� ��� �� �������� �Ѱ��ֱ�.
				   var more_code=eval('opener.document.<%=sForm%>.MoreCode');	
				   more_code.value=data;	//Action���� ������ ����Ÿ.
				   }else{
					   alert("�ش� ������Ʈ�� ���Ͽ� ������ �ڵ� ���� 9999�� �Ѿ (MAX)�Դϴ�.\n�ش� ������Ʈ�� ���̻� �ڵ尡 ���� �Ұ��ϹǷ� �����ڿ��� �����ϼ���!");
					   var more_code=eval('opener.document.<%=sForm%>.MoreCode');
					   more_code.value=""; //�����ڵ� Value �ʱ�ȭ.
					   var project_name=eval('opener.document.<%=sForm%>.P_ProjectName');
					   project_name.value="";	//�� ������Ʈ �� Value �ʱ�ȭ.
					   return;
				   }
				
			   },
			   //Error �� ��µǴ� ��� �޽���.
			   error : function(request, status, error){
			    alert("code :"+request.status + "\r\nmessage :" + request.responseText);
			   }
			  });  
		
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
<%= ld.getPageScript("p_ProjectCodeSearchForm", "curPage", "goPage") %>
<body onload = "init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>������Ʈ�ڵ� ����Ʈ</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- ��ȸ -->
<form  method="post" name="p_ProjectCodeSearchForm" action = "<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=p_projectCodeSearch"  class="search">
  <input type = "hidden" name="curPage"  value="<%=curPage%>"/>
  <input type = "hidden" name="sForm" value="<%=sForm %>"/>
  <fieldset>
	<legend>�˻�</legend>
	<ul>
        <li><select name="searchGb" class=""  onchange="searchChk()">
          <option checked value="">��ü</option>
          <option value="1" >������Ʈ �ڵ��ȣ</option>
          <option value="2" >������Ʈ ��</option>
          <option value="3" >���� ��</option>
          <option value="4" >��翵��</option>
          <option value="5" >���PM</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="�˻���" value="<%=searchtxt%>"  class="text" maxlength="100" ></input></li>
        <li><a href="javascript:goSearch();" class="btn_type01 md0"><span>�˻�</span></a></li>
        </ul>
      </fieldset>
      </form>
   	 <!-- //��ȸ -->
	</div>
	<!-- //������ ��� ���� -->
		<!-- ����Ʈ -->
        <table class="tbl_type tbl_type_list" summary="������Ʈ�ڵ帮��Ʈ(No., ����, ������Ʈ�ڵ�, ������Ʈ����, ������Ʈ��, ����, ���ֻ�, ��翵��, ���PM, ������Ʈ������, ������Ʈ������, ������Ʈ����Ⱓ, �����)">
          <caption>�� ������Ʈ ��ȸ ����Ʈ</caption>
          <colgroup>
				<col width="4%" />
				<col width="5%" />
				<col width="7%" />
				<col width="7%" />
				<col width="*" />
				<col width="9%" />
				<col width="9%" />
				<col width="5%" />
				<col width="5%" />
				<col width="7%" />
				<col width="7%" />
				<col width="5%" />
				<col width="5%" />
			</colgroup>
			<thead>
			<tr>
				<th>No.</th>
				<th>����</th>
				<th>������Ʈ�ڵ�</th>
				<th>������Ʈ����</th>
				<th>������Ʈ��</th>
				<th>����</th>
				<th>���ֻ�</th>
				<th>��翵��</th>
				<th>���PM</th>
				<th>������Ʈ������</th>
				<th>������Ʈ������</th>
				<th>������Ʈ����Ⱓ</th>
				<th>�����</th>
			</tr>
			</thead>
			<tbody>
         <!-- :: loop :: -->
        <!--����Ʈ---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	/*������Ʈ ���� A-�ű�, B-����, C-��������
                      	 */
                        	String ProjectDivision = ds.getString("ProjectDivision"); //������Ʈ ����
                            String ProjectStr = "";
                        	
                            if(ProjectDivision.equals("A")){
                        		ProjectStr = "�ű�";
                            }else if(ProjectDivision.equals("B")){
                            	ProjectStr = "����";
                            }else if(ProjectDivision.equals("C")){
                            	ProjectStr = "��������";
                            }
                        	
                            String FreeCostYN = ds.getString("FreeCostYN"); //������Ʈ ����
                            String ProjectStr2 = "";
                        	
                            if(FreeCostYN.equals("Y")){
                            	ProjectStr2 = "(����)";
                            }else if(FreeCostYN.equals("N")){
                            	ProjectStr2 = "(����)";
                            }
                            
                            String ProgressStatus = ds.getString("CheckSuccessYN");
                        	String progressStatus2 = ds.getString("ProjectEndYN");
                        	String ProgressStr = "";
                        	if(ProgressStatus.equals("N")){
                        		ProgressStr = ds.getInt("ProgressPercent")+"%";
                        	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("Y")){
                        		ProgressStr = "�Ϸ�";
                        	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("N")){
                        		ProgressStr = "�˼�";
                        	}
        %>
        <tr>
       	  <td><%=i+1 %></td>
       	  <td><%=ProgressStr %></td>
          <td><a href="javascript:goSelect('<%=ds.getString("ProjectCode")%>','<%=ds.getString("ProjectName") %>')";><%=ds.getString("ProjectCode") %></a></td>
          <td><%=ProjectStr %><%=ProjectStr2 %></td>
          <td class="text_l" title="<%=ds.getString("ProjectName") %>"><span class="ellipsis"><%=ds.getString("ProjectName") %></span></td>
          <td title="<%=ds.getString("CustomerName") %>"><span class="ellipsis"><%=ds.getString("CustomerName") %></span></td>
          <td title="<%=ds.getString("PurchaseName") %>"><span class="ellipsis"><%=ds.getString("PurchaseName") %></span></td>
          <td title="<%=ds.getString("ChargeNm") %>"><span class="ellipsis"><%=ds.getString("ChargeNm") %></span></td>
          <td title="<%=ds.getString("ChargePmNm") %>"><span class="ellipsis"><%=ds.getString("ChargePmNm") %></span></td>
          <td><%=ds.getString("StartDate") %></td>
          <td><%=ds.getString("EndDate") %></td>
          <td><%=ds.getString("ProgressDate") %>��</td>
          <td title="<%=ds.getString("ProjectCreateUserNm") %>"><span class="ellipsis"><%=ds.getString("ProjectCreateUserNm") %></span></td>    
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="13">��ȸ�� ������ �����ϴ�.</td>
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
    
    <!-- button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a>
    </div>
    <!-- //button -->
    	</div>
	<!-- //content -->
  </div>
</form>
</body>
</html>

