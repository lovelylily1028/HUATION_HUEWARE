<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String Page="";
	String msg="";
	String user_id="";
	String passwd="";

	if(model != null) {
		msg = StringUtil.nvl((String)model.get("msg"),"");
		Page = StringUtil.nvl((String)model.get("page"),"");
		user_id = StringUtil.nvl((String)model.get("user_id"),"");
		passwd =  StringUtil.nvl((String)model.get("passwd"),"");
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��й�ȣ����</title>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/JavaScript" language="JavaScript" src="<%= request.getContextPath() %>/dwr/engine.js" xml:space="preserve"></script>
<script type="text/JavaScript" language="JavaScript" src="<%= request.getContextPath() %>/dwr/util.js" xml:space="preserve"></script>
<script>
<!--

function passWdConfirm(){
																								
		var requestUrl='<%= request.getContextPath() %>/B_User.do?cmd=pwdEnc&cpawd='+document.passwdFrm.passwd.value+'&dpawd='+document.passwdFrm.opasswd.value;

		var xmlhttp = null;
		var xmlObject = null;
		var resultText = null;
		var result="";
		//var test="";
		
		//jQuery Ajax
		$.ajax({
			//contentType : "application/xml", //contentType ����(�������ص� �������)
			url : requestUrl,	//Ajax�� ��û�� url ����
			type : "get", //get��� �Ǵ� post ��� ����
			dataType : "xml", //���� dataType ����   ��)xml ������� html �������
			//cashe : false,
			async : false,
			
			//ajax�� �ش� url�� ��û�� �������� ��� ������ �޼ҵ� ����
			success : function(xml, status, request){
					//xml�� �ش� �κ��� ���� �޼ҵ�
					$(xml).find("encpwd-result").each(
					function(){
						//alert('encpwd-result xml�߰��� jsp������ ��ġ ã��');
						result = $(this).find("encpwd").text();
						//alert('encpwd ���� : ' + result);
						
					}		
				)
			},
			//�ش� url ��û�� �����Ұ�� ���
			error : function(request, status, error){
				alert("code :"+request.status + "\r\message :" + request.responseText);
			}
			
		});
		//alert("1:"+result);
		return result;
	}

function goModify(){

	var obj=document.passwdFrm;

	if(obj.passwd.value==''){
		alert('���� ��й�ȣ�� �Է��ϼ���!');
		obj.passwd.focus();
		return;
	}
	
	 var result=passWdConfirm();
	//alert('result:'+result); ��ȣȭ�� ��й�ȣ��.

	if(obj.opasswd.value!=result){
		alert('���� ��й�ȣ�� �ٸ��ϴ�. ��й�ȣ�� Ȯ���ϼ���!');
		obj.passwd.focus();
		return;
	}
	if(obj.mpasswd.value==''){
		alert('������ ��й�ȣ�� �Է��ϼ���!');
		obj.mpasswd.focus();
		return;
	}

	if(obj.rpasswd.value==''){
		alert('������ ��й�ȣ��  ���Է��ϼ���!');
		obj.rpasswd.focus();
		return;
	}
	if(obj.passwd.value==obj.mpasswd.value){
		alert('������ ��й�ȣ�� �����ϴ�. �ٸ� ��й�ȣ�� �Է��ϼ���!');
		obj.mpasswd.focus();
		return;
	}

	if(obj.mpasswd.value!=obj.rpasswd.value){
		alert('������ ��й�ȣ�� �ٽ��ѹ� �Է��ϼ���!');
		obj.rpasswd.focus();
		return;
	}

	obj.passwd.value = obj.opasswd.value;
	obj.password.value=obj.mpasswd.value;
	obj.submit();

}

//���̾ƿ� �˾� �ݱ� ��ư �Լ�
function goClosePop(){
	//$('[name='+formName+"]").dialog('close');
	$('#password_pop').dialog('close');
}


//-->
</script>
</head>
<body>
<!-- ���̾��˾� -->
<div class="passwordLp">
	<!-- content -->
	<div id="contentLp">
		<!-- ��й�ȣ���� -->
	    <form name="passwdFrm" method="post" action="<%= request.getContextPath()%>/B_User.do?cmd=passModify">
		 <input type="hidden" name="password" value=""/>
	     <input type="hidden" name="userid" value="<%=user_id%>"/>
	     <input type="hidden" name="opasswd" value="<%=passwd%>"/>
	     <fieldset>
			<legend>��й�ȣ����</legend>
			<table class="tbl_type" summary="��й�ȣ����(�����й�ȣ, ����й�ȣ, ����й�ȣȮ��)">
				<colgroup>
					<col width="40%" />
					<col width="*" />
				</colgroup>
				<tbody>
				<tr>
					<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
					<th><label for="">�����й�ȣ</label></th>
					<td><input type="password" name="passwd" value="" class="text" title="�����й�ȣ" style="width:148px;" /></td>
				</tr>
				<tr>
					<th><label for="">����й�ȣ</label></th>
					<td><input type="password" name="mpasswd" value="" class="text" title="����й�ȣ" style="width:148px;" /></td>
				</tr>
				<tr>
					<th><label for="">����й�ȣȮ��</label></th>
					<td><input type="password" name="rpasswd" value="" class="text" title="����й�ȣȮ��" style="width:148px;" /></td>
				</tr>
				</tbody>
			</table>
	     </fieldset>
		</form>
		<!-- //��й�ȣ���� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:goModify()" class="btn_type02"><span>Ȯ��</span></a><a href="javascript:goClosePop()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</div>
<!-- //���̾��˾� -->
</body>
</html>
<script>

 if("" != '<%=msg%>'){
	 alert('<%=msg%>');
 }
</script>