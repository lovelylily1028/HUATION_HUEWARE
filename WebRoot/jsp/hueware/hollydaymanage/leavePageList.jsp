<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%
Map model = (Map)request.getAttribute("MODEL"); 

String Career ="";
Float TotalHolly =null;
Float UsedHolly =null;

String curPage = (String)model.get("curPage");
String searchGb = (String)model.get("searchGb");
String searchGb2 = (String)model.get("searchGb2");
String searchGb3 = (String)model.get("searchGb3");
String searchtxt = (String)model.get("searchtxt");
String StartDT = (String)model.get("StartDT");
String EndDT = (String)model.get("EndDT");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ް��̷�</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">
var  formObj;//form ��ü����

//�ʱ⼼��
function init_leavePageList() {
	
	formObj=document.leavePageList; //form��ü����
	
	searchInit(); //��ȸ�ɼ� �ʱ�ȭ
	searchInit2();
	searchInit3();
	
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

//��ȸ�ɼ� �ʱⰪ	2
function searchInit2(){

	 formObj.searchGb2.value='<%=searchGb2%>';

	searchChk();
	
}

//��ȸ�ɼ� �ʱⰪ	3
function searchInit3(){

	 formObj.searchGb3.value='<%=searchGb3%>';

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
	
		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('��û�ڸ� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='B'){
			if( formObj.searchtxt.value==''){
				alert('������(TL)�� �Է��� �ּ���');
				return;
			}
		}else if(gubun=='C'){
			if( formObj.searchtxt.value==''){
				alert('������(CEO)�� �Է��� �ּ���');
				return;
			}
		}
		
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();

	}


	function showCalendar(div){

	   if(div == "1"){
	   	   $('#calendarData1').datepicker("show");
	   } else if(div == "2"){
		   $('#calendarData2').datepicker("show");
	   } 
	}
	
	//Excel Export(���� �����ޱ�)
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageList";	
	}
	
	

	function goModifyForm(seq){
		$('#ModifyForm').dialog({
	        resizable : false, //������ ���� �Ұ���
	        draggable : true, //�巡�� �Ұ���
	        closeOnEscape : true, //ESC ��ư �������� ����

	        width : 455,
	        height : 500,
	        modal : true, //������ ��Ӱ�

	        open:function(){
	            //�˾� ������ url
	            $(this).load('<%= request.getContextPath() %>/H_Holly.do?cmd=leaveModifyForm',
	            		{'seq' : seq});
	            $(".ui-widget-overlay").click(function(){ //���̾��˾��� ȭ�� Ŭ���� �˾� �ݱ�
	                $("#ModifyForm").dialog('close');
	                });
	        }
	    });
		
		
	}

	function goClose(PopName){
		PopName.dialog('close');
	}
</script>
</head>
<body onload="init_leavePageList();">

				<%
					ListDTO ld = (ListDTO) model.get("listInfo");
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
				%>
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">�ް����� &gt; �ް��̷�</div>
			<h3><span>��</span>���̷�</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ����Ʈ -->
			<div class="conTop_area">
				<%=ld.getPageScript("leavePageList", "curPage", "goPage")%>
				<form method="post" action="<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageList" name = "leavePageList" class="search">
				<input type="hidden" name="curPage" value="<%=curPage%>"/>
				<fieldset>
					<legend>�˻�</legend>
						<ul>
						
							<!-- �޷� ���� -->
				        	<li><span class="ico_calendar"><input name="StartDT"  type="text" value="<%=StartDT %>" class="text textdate" id="calendarData1" readonly="readonly" dispName="��¥" maxlength="8" /><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="�޷�" onclick="showCalendar('1')" /></span> ~ <span class="ico_calendar"><input name="EndDT"  type="text" value="<%=EndDT %>" class="text textdate" id="calendarData2" readonly="readonly" dispName="��¥" maxlength="8"  /><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="�޷�" onclick="showCalendar('2')"/></span></li>
				        	<!-- �޷� ���� -->
						
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<li><select name="searchGb3" onchange="searchChk3()" id="" class="">
								<option checked value="">��ü</option>
								<option value="1" >����</option>
								<option value="2" >��������</option>
								<option value="3" >���Ĺ���</option>
								<option value="4" >����</option>
								<option value="5" >�����Ʒ�</option>
								<option value="6" >�����ް�</option>
							</select></li>
							
							<li><select name="searchGb2" onchange="searchChk2()" id="" class="">
								<option checked value="">��ü</option>
								<option value="D" >��û��</option>
								<option value="E" >����</option>
								<option value="F" >�ݷ�</option>
							</select></li>
							
							
							<li><select name="searchGb" onchange="searchChk()" id="" class="">
								<option checked value="">��ü</option>
								<option value="A" >��û��</option>
								<option value="B" >������(TL)</option>
								<option value="C" >������(CEO)</option>
							</select></li>
							
							<li><input type="text" class="text" onkeydown="javascript:if(event.keyCode==13){goPage('1');}" title="�˻���" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>�˻�</span></a></li>
						</ul>
					</fieldset>
				</form>
				<!-- Top ��ư���� -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>�����ޱ�</span></a></div>
					<!-- //Top ��ư���� -->
				</div>
				<!-- //������ ��� ���� -->
				
				<table class="tbl_type tbl_type_list" summary="�ް��̷�(��û��, �������, �ް�����, �ϼ�, ������, ������, �����, ����, ������)">
					<colgroup>
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="5%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="*" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>��û��</th>
						<th>�������</th>
						<th>�ް�����</th>
						<th>�ϼ�</th>
						<th>������</th>
						<th>������</th>
						<th>�����</th>
						<th>����</th>
						<th>�ݷ�����</th>
						<th>������(TL)</th>
						<th>������(CEO)</th>
					</tr>
					</thead>
					<tbody>
					
							<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
           				 %>
							<tr>
								
								<td><a onclick="javascript:goModifyForm('<%=ds.getString("Seq")%>');"><%=ds.getString("UserName")%></a></td>
								<%if(ds.getString("State1").equals("N") || ds.getString("State2").equals("N")){%>
								<td class="return">�ݷ�</td>
								<%}else if(ds.getString("State1").equals("Y") && ds.getString("State2").equals("Y")){ %>
								<td class="leaveOk">����</td>
								<%}else{ %>
								<td class="requesting">��û��</td>
								<%}%>
								<td><%=ds.getString("HollyFlagName") %></td>
								<td><%=ds.getString("Day") %></td>
								<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
								<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
								<td><%=ds.getString("RegDateTime").substring(0,10) %></td>
								<td class="text_l"><%=ds.getString("Reason") %></td>
								<td class="text_l"><%=ds.getString("ReturnReason") %></td>
								<td><%=ds.getString("SignName1") %></td>
								<td><%=ds.getString("SignName2") %></td>
							
							</tr>
					<%
			                i++;
			                    }
			                } else {
			         %>
			            <tr>
          <td colspan="11">�ް� ��û ��Ȳ�� �����ϴ�.</td>
        </tr>
        	
        	<%
                }
            %>
					
					
					
				</tbody>
				</table>
				<!-- //����Ʈ -->
					<!-- ����¡ -->
					<div class="paging">
				      <%=ld.getPagging("goPage")%>
				    </div>
					<!-- //����¡ -->
			</div>
		</div>
	</div>
	<!-- //container -->
		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
		<!-- //footer -->
</div>
<div id="ModifyForm" title="�ް�������"></div>
</body>
<%= comDao.getMenuAuth(menulist,"82") %>
</html>