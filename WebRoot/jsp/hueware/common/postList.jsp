<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="com.huation.common.PostCodeDTO" %>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	String vSearchType=(String)model.get("vSearchType");
	String vSearch = (String)model.get("vSearch");

    String pForm = (String)model.get("pForm");
    String pZip =(String)model.get("pZip");
    String pAddr =(String)model.get("pAddr");
    String pDong = (String)model.get("pDong");
    String LineBgColor = "#40B389";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�����ȣ�˻�</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="javascript">
<!--

var formObj;

	function ClickZipCode(zip, addr)
	{
		var f = opener.document.<%=pForm%>;
		f.<%=pZip%>.value = zip;
		f.<%=pAddr%>.value = addr;
		f.<%=pAddr%>.focus();
		self.close();
	}


//�ʱ⼼��
function init() {
	
	 formObj=document.ZipSearch; //form��ü����
	
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

	 formObj.searchGb.value='<%=vSearchType%>';
	 formObj.searchtxt.value='<%=vSearch%>';
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
	
	if(gubun=='0'){
		alert('�˻������� �����ϼ���.');
		formObj.searchtxt.value='';
		return;
	}
	
	if(gubun=='1'){
		if( formObj.searchtxt.value==''){
			alert('(��/��/��)�� �Է����ּ���.');
			return;
		}
	}else if(gubun=='2'){
		if( formObj.searchtxt.value==''){
			alert('���� ���� �Է����ּ���.');
			return;
		}
	}else if(gubun=='3'){
		if( formObj.searchtxt.value==''){
			alert('�ǹ� ���� �Է����ּ���.');
			return;
		}
	}
	
	formObj.submit();
}
	
//-->
</script>
<body onload="init();">
<div id="wrapWp">
<!-- header -->
<div id="headerWp">
	<h1>�����ȣ ��ȸ</h1>
</div>
<!-- //header -->
<!-- content -->
	<div id="contentWp">
<form name="ZipSearch" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
<fieldset>
	<legend>�����ȣ ��ȸ</legend>
      <!-- search -->
      <dl class="search_area">
        <input type=hidden name=pForm value="<%=pForm%>">
        <input type=hidden name=pZip value="<%=pZip%>">
        <input type=hidden name=pAddr value="<%=pAddr%>">
        <dt><span class="guide_txt">�Ʒ� �Է� ���� ã���� �ּҸ� �Է��ϼ���!<br />(���θ� �Ǵ� �ǹ������� �˻��� ������.)</span><br /><select name="searchGb" onchange="searchChk();">
          <option value="0" selected="selected">����</option>
          <option value="1" >��/��/��</option>
          <option value="2" >���θ�</option>
          <option value="3" >�ǹ���</option>
        </select>&nbsp;<input type="text" name="searchtxt" title="�˻��ּ�" style="width:200px;" value="<%=vSearch%>"  class="text" maxlength="100" ></input><a href="javascript:goSearch();" class="btn_type03"><span>��ȸ</span></a></dt>
      <!-- //search -->
      <dd class="listPost">
       <ul class="listPost_area">
      
			<%
				ListDTO ld = (ListDTO)model.get("listInfo");
				DataSet ds = (DataSet)ld.getItemList();	
				
				int iTotCnt = ld.getTotalItemCount();
				int iCurPage = ld.getCurrentPage();
				int iDispLine = ld.getListScale();
				int startNum = ld.getStartPageNum();
				
				
			%>
			<!-- :: loop :: -->
	        <!--����Ʈ---------------->
			<%
	         if (ld.getItemCount() > 0) {
	                 int i = 0;
	                 while (ds.next()) {
	                	 
	                	//�ּ� �� ���� �ʼ����� �ƴϹǷ� ���� ������ ���� ���⸦ ���� ���� ���ش�.
	                	String riSetting = "";
	     				if(!ds.getString("Ri").equals("")){
	     					riSetting = " "+ds.getString("Ri")+" ";
	     				}else{
	     					riSetting = " ";
	     				}
	     	%>
            <li><a href="javascript:ClickZipCode('<%=ds.getString("ZipCode")%>','<%=ds.getString("SiDo")%> <%=ds.getString("SiGunGu")%> <%=ds.getString("YubMyunDong")%><%=riSetting%><%=ds.getString("RoadName")%>')" ><strong>[<%=ds.getString("ZipCode")%>]</strong> <%=ds.getString("SiDo")%> <%=ds.getString("SiGunGu")%> <%=ds.getString("YubMyunDong")%> <%=ds.getString("Ri")%> <%=ds.getString("RoadName")%> <%=ds.getString("BuildingName")%></a></li>
          <%
          		i++;
	              	}
          %>
		  <%
		  }else{
		  %>
            <li class="none">�˻��� �����ȣ�� �����ϴ�.</li>
          <%
	      }
		  %>
		   </ul>   
		  </dd>
		  </dl>
		  </fieldset>
		  </form>


    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>   
    <!-- //button -->
        </div>
    <!-- contents -->
 </div>

</body>
</html>
