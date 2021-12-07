<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@page import="java.util.Map"%>
<%
	Map model = (Map)request.getAttribute("MODEL");


	CompanyDTO compDto = (CompanyDTO)model.get("compDto");
	String name = (String)model.get("name");
	
	
	
	String[] b_check = StringUtil.getTokens(compDto.getBusiness_check(), "|");

	String acheckd="";
	String bcheckd="";
	

	for(int i=0;i<b_check.length; i++){

		if(b_check[i].equals("01")){
			acheckd="checked";
		}else if(b_check[i].equals("02")){
			bcheckd="checked";
		}
	}
	
	
	//������ �ʱ� ���� ��.
	String date = "";

	
	if(compDto.getDate().equals("")){
		date = compDto.getDate();
		date = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}else{
		date = compDto.getDate();
	}
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ ��ü ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script src="<%= request.getContextPath()%>/js/hueware.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script type="text/javascript">




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


function goSave(){
	
	var frm = document.companyUnfit;
	var businesscheck='';
	var cnt=2;
	for(i=0;i<cnt;i++){
		if(frm.business_check[i].checked==true){
			if(i==cnt-1){
				i++;
				businesscheck+='0'+i;
				i--;
			}else{
				i++;
				businesscheck+='0'+i+'|';
				i--;
			}
		}
	}
	if(businesscheck==''){
		alert('�ϳ��̻� �����ϼ���.');
		return;
	}else{
		//frm.business_check.value=businesscheck;
	}
	//frm.submit();
	
	
	//$("[name='business_check']",opener.document).attr("disabled",false);
	var checkLen = $("[name='business_check']").length;
	for(var x=0; x<checkLen; x++){
		if($("[name='business_check']").eq(x).is(":checked") == true){
			
			$("[name='businesscheck']",opener.document).eq(x).prop("checked", true); 
			
		}else{
			
			$("[name='businesscheck']",opener.document).eq(x).prop("checked", false); 
		}
	} 
	
	//opener.companyView.elements["unfit_reasom"].value = frm.unfit_reason.value;
	$("[name='unfit_reason']",opener.document).val($("[name='unfit_reason']").val());
	$("[name='date']",opener.document).val($("[name='date']").val()); 
	$("[name='unfit_id']",opener.document).val($("[name='unfit_id']").val()); 
	$(opener.location).attr("href", "javascript:show('show');"); 
	/* $("#cmStChk", opener.document).css("display","show"); */
	
	self.close();
}



</script>




</head>
<body>
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>������ ��ü ����</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- �ʼ��Է»����ؽ�Ʈ -->
			<p class="must_txt"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ��� -->
		<div class="companyUnfit">
			<form method="post" name="companyUnfit" action="<%=request.getContextPath()%>/B_Company.do?cmd=companyUnfitEdit">
			<input type = "hidden" name = "comp_code" value="<%=compDto.getComp_code() %>"></input>
			<fieldset>
				<legend>������ ��ü ����</legend>
				<table class="tbl_type" summary="������ ��ü ����(��������������, ����ó/����ó, ��������, ������)">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
						<th>
							<label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������������</label>
						</th>
						<td><textarea id="" name="unfit_reason" title="��������������" style="width:265px;height:45px;"><%=compDto.getUnfit_reason()%></textarea></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����ó/����ó</label></th>
						<td>
							<input type="checkbox" id="" name="business_check" value="01" class="check md0" title="����ó" <%=acheckd %> /><label for="">����ó</label>
							<input type="checkbox" id="" name="business_check" value="02" class="check" title="����ó" <%=bcheckd %> /><label for="">����ó</label>
						</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
						<td><span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="date" value="<%=date %>" title="��������" /></span></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
						<td><input type="text" id="" class="text dis" name="unfit_id" title="������" style="width:200px;" readonly="readonly" value="<%=name %>" /></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
		
		</form>	
		</div>
		<!-- //��� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:goSave()" class="btn_type02"><span>Ȯ��</span></a> <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
		<!-- //Bottom ��ư���� -->
		
	</div>
	<!-- //content -->
</div>
</body>
</html>