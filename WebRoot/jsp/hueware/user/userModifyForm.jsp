<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet"%>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import="com.huation.common.user.UserDAO"%>
<%@ page import="com.huation.common.user.UserDTO"%>
<%@ page import="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	UserDTO userDto = (UserDTO)model.get("userDto");
	CommonDAO comDao=new CommonDAO();
	
	String position_select = userDto.getPosition();
	String acheckd="";
	String bcheckd="";
	String ccheckd="";
	String dcheckd="";
	String echeckd="";
	String fcheckd="";
	String gcheckd="";
	String hcheckd="";
	
		if(position_select.equals("A")){
			acheckd="selected='selected'";
		} else if(position_select.equals("B")){
			bcheckd="selected='selected'";
		} else if(position_select.equals("C")){
			ccheckd="selected='selected'";
		} else if(position_select.equals("D")){
			dcheckd="selected='selected'";
		} else if(position_select.equals("E")){
			echeckd="selected='selected'";
		} else if(position_select.equals("F")){
			fcheckd="selected='selected'";
		} else if(position_select.equals("G")){
			gcheckd="selected='selected'";
		} else if(position_select.equals("6")){
			hcheckd="selected='selected'";
		} else if(position_select.isEmpty()){
			hcheckd="selected='selected'";
		}
		
	String EmployeeNum_EnEc = "";
	if(userDto.getEmployeeNum().isEmpty()){
		EmployeeNum_EnEc = "-";
	}else{
		EmployeeNum_EnEc = userDto.getEmployeeNum().substring(0,2);
	}
	String EN="";
	String EC="";
	
	if(EmployeeNum_EnEc.equals("EN")){
		EN="checked";
	}else{
		EC="checked";
	}
		
	String HireDateTime = "";
	HireDateTime = userDto.getHireDateTime();
	if(HireDateTime.isEmpty()){
		HireDateTime = userDto.getHireDateTime();
	}else{
		HireDateTime = HireDateTime.substring(0,10);
	}
		
	String FireDateTime = "";
	FireDateTime = userDto.getFireDateTime();
	if(FireDateTime.isEmpty()){
		FireDateTime = userDto.getFireDateTime();
		System.out.println("================================��� �ִ� ���========================================"+FireDateTime);
	}else{
		FireDateTime = FireDateTime.substring(0,10);
		System.out.println("================================�� �ִ� ���========================================"+FireDateTime);
	}
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����� ��������</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script>

//2013-03-13 �����޷¿��� jQuery �޷����� ����
$(document).ready(function(){
	$('#calendarData1, #calendarData2, #calendarData3').datepicker({
		buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
		//maxDate:0,
		showOn: 'both',
		buttonImageOnly: true,
		prevText: "����",
		nextText: "����",
		dateFormat: "yy-mm-dd",
		dayNamesMin:["��","��","ȭ","��","��","��","��"],
		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		changeMonth: true,
	    changeYear: true
	});
});



var openWin=0;//�˾���ü
var observer;//ó����
//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	var jumin2 = "<%=userDto.getJumin2()%>";
	var frm = document.UserModify;
	frm.jumin2.value = jumin2;
}
//����
function goSave(){

	var frm = document.UserModify; 
	if(frm.GroupID.value.length == 0){
		alert("�Ҽ��� �Է��ϼ���");
		return;
	}
	
	if(frm.OfficeTellNoFormat.value.length == 0){
		alert("�ڵ��� ��ȣ�� �Է��ϼ���");
		return;
	}
	
	/* if(frm.OfficeTellNoFormat2.value.length == 0){
		alert("�系 �����ȣ�� �Է��ϼ���");
		return;
	} */
	

	if(!isNumber(frm.OfficeTellNoFormat.value) && frm.OfficeTellNoFormat.value != 0) {
		alert("�޴�����ȣ�� ���ڸ� �Է°����մϴ�.");
		return;
	}
	
	if(frm.OfficeTellNoFormat.value != 0 && ( frm.OfficeTellNoFormat.value < 11 || frm.OfficeTellNoFormat.value > 14) ) {
		alert("��ȿ���� ���� �޴�����ȣ�Դϴ�.");
		return;
	}
	
	if(!isNumber(frm.OfficeTellNoFormat2.value) && frm.OfficeTellNoFormat2.value != 0) {
		alert("�系�����ȣ�� ���ڸ� �Է°����մϴ�.");
		return;
	}
	
	if(frm.OfficeTellNoFormat2.value != 0 && ( frm.OfficeTellNoFormat2.value < 9 || frm.OfficeTellNoFormat2.value > 14) ) {
		alert("��ȿ���� ���� �系�����ȣ�Դϴ�.");
		return;
	}
	
	var invalid = ' ';	//���� üũ
	
	if(frm.Password.value.indexOf(invalid) > -1 || frm.RePassword.value.indexOf(invalid) > -1){
		alert("��й�ȣ�� ������ ���� �� �����ϴ�.");
		return;
	}
	
	if(frm.Password.value != frm.RePassword.value) {
		alert("�Է��Ͻ� ��й�ȣ�� ���Է��Ͻ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		return;
	}
	if(frm.HireDateTime.value.length == 0){
		alert("�Ի����� �Է��� �ֽʽÿ�");
		return;
	}
	
	//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
	var strFile = frm.BoardFile.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	//alert(lastIndex);
	var strFileName= strFile.substring(lastIndex+1);
	//alert(strFileName);
	if(fileCheckNm(strFileName)> 200){
		alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
		return;
	}

		
//���ϸ� ���ڼ�(byte) üũ		
function fileCheckNm(szValue){
		var tcount=0;
		var tmpStr = new String(szValue);
		var temp = tmpStr.length;
		var onechar;
		for(k=0; k<temp; k++){
			onechar = tmpStr.charAt(k);
			if(escape(onechar).length>4){
				tcount +=2;
				
			}else{
				tcount +=1;
			}
		}
		return tcount;
	}	
	
	
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		
		if(frm.initPW.value!=frm.Password.value){
			frm.PasswordModifyYN.value='Y';
			
		}else{
			frm.PasswordModifyYN.value='N';
		}
		
		
		if (strFileName!=''){
			frm.BoardFileNm.value = strFileName;
		}
		
		frm.action='<%=request.getContextPath()%>/B_User.do?cmd=userModify';
		//frm.FaxNo.value=onlyNum(frm.FaxNo.value);
		frm.OfficeTellNo.value=onlyNum(frm.OfficeTellNoFormat.value);
		frm.OfficeTellNo2.value=onlyNum(frm.OfficeTellNoFormat2.value);
		frm.submit();
	}
}
//�׷� ���̵�� �׷�� �����Լ�.
function groupSet(groupid,groupnm){
	//����� �ʵ忡 �°� ������
	var frm = document.UserModify; 
	frm.GroupID.value=groupid;
	frm.GroupName.value=groupnm;
}
//�׷���� ���̵�� �׷� ���Ѹ� �����Լ�.
function authSet(authid,authnm){
	//����� �ʵ忡 �°� ������
	var frm = document.UserModify; 
	frm.AuthID.value=authid;
	frm.AuthName.value=authnm;
}
//�ѽ���ȣ �����Լ�.
function faxNoSet(faxno){
	//����� �ʵ忡 �°� ������
	var frm = document.UserModify; 
	frm.FaxNo.value=faxno;
}
//�׷� ��  �ѽ���ȸ ���� �˾�â
function goPopup(url){

   var top, left,scroll;
   var width='350';
   var height='550';
   var loc='center';
   
	if(scroll == null || scroll == '')	scroll='0';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}

	var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	if(openWin != 0) {
		  openWin.close();
	}
	openWin = window.open(url, 'POP', option);
}	
</script>
</head>
<!-- ó���� ���� -->
<div id="waitwindow" style="position: absolute; left: 0px; top: 0px; background-color: transparent; layer-background-color: transparent; height: 100%; width: 100%; visibility: hidden; z-index: 10;">
  <table width="100%" height="100%" border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=293 height=148 border='0' cellspacing='0' cellpadding='0' background="<%=request.getContextPath()%>/images/main/ing.gif" >
          <tr>
            <td align=center><img src="<%=request.getContextPath()%>/images/main/spacer.gif" width="1" height="50" /><img src="<%=request.getContextPath()%>/images/main/wait2.gif" width="242" height="16" /></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- ó���� ���� -->
<body onload="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>����� ��������</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- �ʼ��Է»����ؽ�Ʈ -->
			<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ��� -->
		<div class="userRegistForm">
<form method="post" name="UserModify" action="<%=request.getContextPath()%>/B_User.do?cmd=userModify" enctype="multipart/form-data">
	<input type="hidden" name="photo">
  <fieldset>
	<legend>����� ��������</legend>
	<table class="tbl_type" summary="����� ��������(�����ID, ����ڸ�, �Ҽ�, ��ȭ��ȣ, ��뿩��, ��й�ȣ, ��й�ȣ���Է�)">
        <caption>����� ��������</caption>
		<colgroup>
			<col width="331px" />
			<col width="138px" />
			<col width="*" />
		</colgroup>
		<tbody>
		  <tr>
          <td rowspan="14"><iframe class="pic_area" src="<%= request.getContextPath()%>/B_User.do?cmd=photoForm&photo=<%= StringUtil.nvl(userDto.getPhoto(),"")%>&Flag=M"  frameborder="0" height="406" width="300" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></td>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����ID</label></th>
          <td><input name="ID" type="text" class="text" value="<%=StringUtil.nvl(userDto.getID(), "") %>" title="�����ID" style="width:200px;" readOnly /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ڸ�</label></th>
          <td><input name="Name" type="text" class="text" value="<%=StringUtil.nvl(userDto.getName(), "") %>" title="����ڸ�" style="width:200px;" readOnly /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>ä�뱸��</label></th>
          <td><input name="section" type="radio" class="radio md0" title="������" id="" <%=EN %> value="EN" /><label for="">������</label><input name="section" type="radio" class="radio" id="" title="�İ���(����)" <%=EC %> value="EC" /><label for="">�İ���(����)</label></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���</label></th>
          <td>
          <input name="getEmployeeNum" type="text" class="text dis" title="���" style="width:80px;" readOnly value="<%= userDto.getEmployeeNum() %>" />
        </tr>  
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ֹι�ȣ</label></th>
		  <td>          
          <input name="jumin1" type="text" class="text dis" title="�ֹ���" style="width:50px;"  value="<%= userDto.getJumin1() %>" maxlength="6" />-
          
<%--           <input name="jumin2" type="password"  title="�ֹ���" style="width:80px;"  value="<%=userDto.getJumin2()%>" maxlength="7" /> --%>
          <input type="password" name="jumin2"  class="text" style="width:80px;"  maxlength="7" value="<%=StringUtil.nvl(userDto.getJumin2(), "") %>" />
          <input type="hidden" name="jumin3"  class="text" style="width:80px;"  maxlength="7" value="<%=StringUtil.nvl(userDto.getJumin2(), "") %>" />
          </td>
        </tr>
        
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Ҽ�</label></th>
          <td><input name="GroupName" type="text" class="text" value="<%=StringUtil.nvl(userDto.getGroupName(), "")%>" title="�Ҽ�" style="width:200px;" readOnly onclick="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');"/><a href="javascript:goPopup('<%= request.getContextPath() %>/B_Common.do?cmd=groupFrame');" class="btn_type03"><span>��ȸ</span></a><input name="GroupID" type="hidden"  value="<%=StringUtil.nvl(userDto.getGroupID(), "") %>" /></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
          <td>
	          <select name="Position">
<%-- 	          <option <%=acheckd %> value="A">��ǥ�̻�</option> --%>
<%-- 	          <option <%=bcheckd %> value="B">�̻�</option> --%>
<%-- 	          <option <%=ccheckd %> value="C">����</option> --%>
<%-- 	          <option <%=dcheckd %> value="D">����</option> --%>
<%-- 	          <option <%=echeckd %> value="E">����</option> --%>
<%-- 	          <option <%=fcheckd %> value="F">�븮</option> --%>
<%-- 	          <option <%=gcheckd %> value="G">���</option> --%>
<%-- 	          <option <%=hcheckd %> value="6">-</option> --%>
	          <option <%=acheckd %> value="A">��ǥ�̻�</option>
	          <option <%=bcheckd %> value="B">�̻�</option>
	          <option <%=ccheckd %> value="C">�׷츮��</option>
	          <option <%=dcheckd %> value="D">������</option>
	          <option <%=echeckd %> value="E">�Ŵ���</option>
	          <option <%=fcheckd %> value="F">���</option>
	          <option <%=gcheckd %> value="G">����</option>
	          <option <%=hcheckd %> value="6">��Ÿ</option>
	          </select>
          </td>
        </tr>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�Ի���</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="HireDateTime" value="<%=HireDateTime%>"/></span>
			</td>
        </tr>
        <tr>
        	<th><label for="">�����</label></th>
       		<td>
				<span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="FireDateTime" value="<%=FireDateTime%>"/></span>
			</td>
        </tr>
        <tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�޴�����ȣ</label></th>
          <input type="hidden" name="OfficeTellNo" value="<%=StringUtil.nvl(userDto.getOfficeTellNo(),"") %>">
          <td><input type="text" name="OfficeTellNoFormat"  class="text" value="<%=StringUtil.nvl(userDto.getOfficeTellNoFormat(),"") %>" title="�޴�����ȣ" style="width:200px;" dispName="��ȭ��ȣ" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
         <tr>
          <th><label for=""></span>�系�����ȣ</label></th>
          <input type="hidden" name="OfficeTellNo2" value="<%=StringUtil.nvl(userDto.getOfficeTellNo2(),"") %>">
          <td><input type="text" name="OfficeTellNoFormat2"  class="text" value="<%=StringUtil.nvl(userDto.getOfficeTellNoFormat2(),"") %>" title="�系�����ȣ" style="width:200px;" dispName="��ȭ��ȣ" maxlength="14" onKeyUp="format_phone(this);"/></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��뿩��</label></th>
          <td>
          <% 
		  if ((StringUtil.nvl(userDto.getUseYN(), "")).equals("Y")) { 
		  %>
          <input name="UseYN" type="radio" id="radio" value="Y" title="���" class="radio md0" checked /><label for="">���</label><input type="radio" name="UseYN" id="radio2" value="N" title="�̻��" class="radio"/><label for="">�̻��</label>
          <%
		  } else if ((StringUtil.nvl(userDto.getUseYN(), "")).equals("N")) {
		  %>
          <input name="UseYN" type="radio" id="radio" value="Y" title="���" class="radio md0"/><label for="">���</label><input type="radio" name="UseYN" id="radio2" value="N" checked title="�̻��" class="radio"/><label for="">�̻��</label>
          <%
		  }
		  %>
		  </td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��й�ȣ</label></th>
          <td><input type="password" name="Password"  class="text" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>" title="��й�ȣ" style="width:279px;" size="30"/>
            <input type="hidden" name="initPW" class="in_txt" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>">
            <input type="hidden" name="PasswordModifyYN" value="N" class="in_txt" ></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��й�ȣ���Է�</label></th>
          <td><input name="RePassword" type="password" size="30" class="text" value="<%=StringUtil.nvl(userDto.getPassword(), "") %>" title="��й�ȣ���Է�" style="width:279px;" /></td>
        </tr>
         <tr>
        	<th><label for="">�ּ�</label></th>
       		<td colspan="2">
				<span class="ico_calendar"><input id="zip" class="text" style="width:420px;" name="zip" value="<%=StringUtil.nvl(userDto.getZip(),"")%>"/></span>
			</td>
        </tr>
        <tr>
		  <th><label for="">�����η���������</label></th>
		  <td colspan="2"><div class="fileUp"><input type="text" class="text" id="file1" title="�����η���������" style="width:212px;" value="<%=userDto.getBoardFile() %>" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="BoardFile" id="upload1" /><input type="hidden" name="p_BoardFile" value="<%=userDto.getBoardFile()%>"></input><input type="hidden" name="BoardFileNm" value="<%=userDto.getBoardFileNm()%>"></input></div><br /><span class="guide_txt br">* �����η� ������������ : ��� ���� / ÷�ΰ��� �뷮 : �ִ� 500M</span></td>
     	</tr>
        </tbody>
      </table>
      </fieldset>
      </form>
    </div>
	<!-- //��� -->
    <!-- //button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave()" class="btn_type02"><span>Ȯ��</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
</body>
</html>
<script type="text/javascript">fn_fileUpload();</script>