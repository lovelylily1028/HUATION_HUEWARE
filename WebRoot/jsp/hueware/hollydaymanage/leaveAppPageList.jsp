<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@page import ="com.huation.framework.persist.ListDTO"%>
<%@page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ް�����</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	String State = (String)model.get("State");
%>
</head>
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
	location.href="<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDaySign&Seq="+seq+"&State="+state+"&Sign="+sign+"&ReturnReason="+returnreason+"";

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


</script>
<body>
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">�ް����� &gt; �ް�����</div>
			<h3><span>��</span>������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con leaveAppPageList">
				<!-- ����Ʈ -->
				<table class="tbl_type tbl_type_list" summary="�ް�����(��û��, �ް�����, �ϼ�, ������, ������, ����, ����)">
					<colgroup>
						<col width="130px" />
						<col width="130px" />
						<col width="90px" />
						<col width="130px" />
						<col width="130px" />
						<col width="440px" />
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
								<table class="tbl_type tbl_type_list" summary="�ް�����(��û��, �ް�����, �ϼ�, ������, ������, ����, ����)">
									<colgroup>
										<col width="129px" class="scrollY_FF" /><!-- tbody�� �߰��Ǵ� ���̺��� ���� ���� ������ ���� width����� -1px��. -->
										<col width="130px" />
										<col width="90px" />
										<col width="130px" />
										<col width="130px" />
										<col width="440px" />
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
									
									<!-- <tr>
										<td>�����</td>
										<td>����</td>
										<td>2</td>
										<td>2014-06-13</td>
										<td>2014-06-13</td>
										<td class="text_l">�����ް�</td>
										<td><a href="#none" class="btn_type03"><span>����</span></a>&nbsp;<a href="leaveReturn.html" class="btn_type03"><span>�ݷ�</span></a></td>
									</tr>
									<tr>
										<td>�����</td>
										<td>����</td>
										<td>2</td>
										<td>2014-06-13</td>
										<td>2014-06-13</td>
										<td class="text_l">�����ް�</td>
										<td><a href="#none" class="btn_type03"><span>����</span></a>&nbsp;<a href="leaveReturn.html" class="btn_type03"><span>�ݷ�</span></a></td>
									</tr> -->
									
									</tbody>
								</table>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- //����Ʈ -->
			</div>
		</div>
	</div>
	<!-- //container -->
		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
		<!-- //footer -->
</div>
<div id="ReturnForm" title="�ݷ�����"></div>
</body>
<%= comDao.getMenuAuth(menulist,"81") %>
</html>