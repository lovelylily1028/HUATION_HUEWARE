<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import = "com.huation.framework.persist.ListDTO"%>
<%@ page import = "com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
// 	Map model = (Map)request.getAttribute("MODEL");   //basejsp���� ���ǵ�. 

	String searchtxt = (String)model.get("searchtxt");
	String StartDT = (String)model.get("StartDT");
	String EndDT = (String)model.get("EndDT");
	ArrayList<HollyDTO> arraylist = (ArrayList)model.get("arraylist");
	HollyDTO atDto = new HollyDTO();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ް�������</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function init() {
		document.getElementById("pName").innerHTML = opener.document.adminLeaveApplyPageList.pName.value +" ("+ opener.document.adminLeaveApplyPageList.pEmployeeNum.value +")";
	}



</SCRIPT>
</head>

<body onLoad = "init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1 id ="pName" >�̸�</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
	<!-- ������ ��� ���� -->
	
    <!-- contents -->
        <table class="tbl_type tbl_type_list" summary="�ް���û��Ȳ(�������, �ް�����, �ϼ�, ������, ������, �����, ����, ������)">

					<colgroup>
						<col width="13%" />
						<col width="13%" />
						<col width="13%" />
						<col width="10%" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th>�����</th>
							<th>�ް�������</th>
							<th>�ް�������</th>
							<th>�Ⱓ(��)</th>
							<th>����</th>
							
						</tr>
					</thead>
					<tbody>
	<%
		//���� ��� ���·ι޴���
		for(int j=0; j < arraylist.size(); j++){
			atDto = new HollyDTO();
			atDto = arraylist.get(j);
		%>
			<tr>
				<td><%=atDto.getRegDateTime()%></td>
				<td><%=atDto.getStartDateTime()%></td>
				<td><%=atDto.getEndDateTime()%></td>
				<td><%=atDto.getDays()%></td>
				<td class="text_l"><%=atDto.getReason()%></td>
			</tr>
		<%
		}
		%>
					</tbody>
				</table>
  
    <!-- //paginate -->
    	<!-- ���̵��ؽ�Ʈ -->
	<p class="guide_txt">�Ի��� �������� �ֱ� 1�⸸ ��ȸ�˴ϴ�</p>
	<!-- //���̵��ؽ�Ʈ -->
    <!-- Bottom ��ư���� -->
	<div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
    <!-- //button -->
    </div>
    <!-- //contents -->    
</div>
</body>
</html>
<script>
// searchChk();
</script>
