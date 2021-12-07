<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	String State = (String)model.get("State");
%>

<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9�� ������ -->
<title>�ް���û��</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/jquery-ui-1.9.2.custom.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script language="javascript">
function Sign(seq,state,sign){
	var signmsg ="";
	
	
	var returnreason = $('#ReturnReason').val();
	if(sign =='Y'){
		signmsg ="�ް��� ���� �Ͻðڽ��ϱ�?";
	}else{
		signmsg ="�ް��� �ݷ� �Ͻðڽ��ϱ�?";
	}
	
	

	
	if(!confirm(""+signmsg+""))
		return;
	location.href="<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDaySignPop&Seq="+seq+"&State="+state+"&Sign="+sign+"&ReturnReason="+returnreason+"";

}


//���̾��˾� : �ݷ�����
function goReturnForm(seq,state,sign){
	
	$('#ReturnForm').dialog({
      resizable : false, //������ ���� �Ұ���
      draggable : true, //�巡�� �Ұ���
      closeOnEscape : true, //ESC ��ư �������� ����

      width : 350,
      height : 233,
      modal : true, //������ ��Ӱ�

      open:function(){
          //�˾� ������ url
          $(this).load('<%= request.getContextPath() %>/H_Holly.do?cmd=ReturnForm',{
        		"Seq" : seq,
        		"State" : state,
        		"Sign" : sign
        	});
          
          

          $(".ui-widget-overlay").click(function(){ //���̾��˾��� ȭ�� Ŭ���� �˾� �ݱ�
              $("#ReturnForm").dialog('close');
              });
      }
  });

}



function goClose(PopName){

	PopName.dialog('close');
}
function goCloses(){
	self.close();
	
}

</script>
</head>


<body>
<!-- �˾������� : width:705px -->
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>�ް� ��û��</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="leaveApplicant">
		<!-- ����Ʈ -->
		<table class="tbl_type tbl_type_list" summary="�ް� ��û��(��û��, �ް�����, �ϼ�, ������, ������, ����, ����)">
			<colgroup>
				<col width="90px" />
				<col width="90px" />
				<col width="60px" />
				<col width="90px" />
				<col width="90px" />
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
						<th>��û��</th>
						<th>�ް�����</th>
						<th>�ϼ�</th>
						<th>������</th>
						<th>������</th>
						<th>����</th>
						<th>����</th>
					</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="7" class="tbl_type_scrollY">
					<div class="scrollY">
						<table class="tbl_type tbl_type_list" summary="�ް� ��û��(��û��, �ް�����, �ϼ�, ������, ������, ����, ����)">
							<colgroup>
								<col width="89px" class="scrollY_FF" /><!-- tbody�� �߰��Ǵ� ���̺��� ���� ���� ������ ���� width����� -1px��. -->
								<col width="90px" />
								<col width="60px" />
								<col width="90px" />
								<col width="90px" />
								<col width="150px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<%
					                if (ld.getItemCount() > 0) {
					                    int i = 0;
					                    while (ds.next()) {
					           				 %>
												<tr>
												
													<td><%=ds.getString("UserName") %></td>
													<td><%=ds.getString("HollyFlagName") %></td>
													<td><%=ds.getString("Day") %></td>
													<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
													<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
													<td class="text_l"><%=ds.getString("Reason") %></td>
													<td><a href="javascript:Sign('<%=ds.getString("Seq")%>','<%=State%>','Y');" class="btn_type03"><span>����</span></a>&nbsp;<a href="javascript:goReturnForm('<%=ds.getString("Seq")%>','<%=State%>','N')" class="btn_type03"><span>�ݷ�</span></a></td>
												</tr>
										<%
								                i++;
								                    }
								                } else {
								         %>
								            <tr>
					          <td colspan="7">������ ������ �����ϴ�.</td>
					        </tr>
					        	
					        	<%
					                }
					            %>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<!-- //����Ʈ -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:window.close();" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</div>
<div id="ReturnForm" title="�ݷ�����"></div>
</body>
</html>