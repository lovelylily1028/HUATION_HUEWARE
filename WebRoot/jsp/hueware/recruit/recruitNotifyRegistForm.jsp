<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ä����� ���������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){
	var frm = document.recruitRegist; 

	if(frm.subject.value.length == 0){
		alert("�����о߸� �Է��ϼ���");
		return;
	}
	if(frm.contents.value.length == 0){
		alert("���������� �Է��ϼ���");
		return;
	}

	var recruit_field='';
	var cnt=9;
	for(i=0;i<cnt;i++){
		if(frm.recruitfield[i].checked==true){
			if(i==cnt-1){
				i++;
				recruit_field+='0'+i;
				i--;
			}else{
				i++;
				recruit_field+='0'+i+'|';
				i--;
			}
		}
	}
	if(recruit_field==''){
		alert('�����о߸� �ϳ��̻� �����ϼ���.');
		return;
	}else{
		frm.recruit_field.value=recruit_field;
	}
	
	var dates = frm.recruit_start.value;
	var recruit_starts = dates.replace(/-/g,'');
	frm.pYear1.value = recruit_starts.substr(0,4);
	frm.pMonth1.value = recruit_starts.substr(4,2);
	frm.pDay1.value = recruit_starts.substr(6,2);
	
	frm.recruit_start.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	
	
	var dates = frm.recruit_end.value;
	var recruit_ends = dates.replace(/-/g,'');
	frm.pYear3.value = recruit_ends.substr(0,4);
	frm.pMonth3.value = recruit_ends.substr(4,2);
	frm.pDay3.value = recruit_ends.substr(6,2);
	
	frm.recruit_end.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;
	
    frm.recruit_start.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	frm.recruit_end.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;
	if(frm.recruit_start.value.length == 0 || frm.recruit_end.value.length == 0){
		alert("�������� �Է��ϼ���");
		return;
	}
	if(frm.recruit_start.value>frm.recruit_end.value){
		alert("���� �Ⱓ�� �ùٸ��� �Է��� �ּ���");
		return;
	}

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.submit();
}

function cancle(){
	
	var frm = document.recruitRegist;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList';
	frm.submit();

}
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome���� &gt; ä�����</div>
			<h3><span>ä</span>�������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ��� -->
			    <form name="recruitRegist" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyRegist">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
			      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
			      <input type = "hidden" name = "recruit_no" value="01"/>
			      
			      <input type = "hidden" name = "pYear1" value=""/>
			     <input type = "hidden" name = "pMonth1" value=""/>
			     <input type = "hidden" name = "pDay1" value=""/>
			      <input type = "hidden" name = "pYear3" value=""/>
			     <input type = "hidden" name = "pMonth3" value=""/>
			     <input type = "hidden" name = "pDay3" value=""/>
     
 				<fieldset>
					<legend>ä�������</legend>
					<table class="tbl_type" summary="ä�������(����, ��������)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����о�</label></th>
							<td><input type="text" id="" name="subject" class="text" title="�����о�" style="width:916px;" maxlength="100"/></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
							<td><textarea id="" name="contents" title="��������" style="width:916px;height:248px;"></textarea></td>
						</tr>
						
						<%
							CodeParam codeParam=null;
						%>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>ä������</label></th>
					          	<td><%  
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("input1");
									codeParam.setName("recruit_type");
									//codeParam.setSelected(btxt); 
									out.print(CommonUtil.getCodeList(codeParam,"H01")); 
								%></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>ä��о�</label></th>
							<input type="hidden" name="recruit_field">
							<td><input type="checkbox" id="" name="recruitfield" class="check md0" title="R&amp;D" value="01"/><label for="">R&amp;D</label><input type="checkbox" id="" name="recruitfield" class="check" title="�������" value="02"/><label for="">�������</label><input type="checkbox" id="" name="recruitfield" class="check" title="��������" value="03"/><label for="">��������</label><input type="checkbox" id="" name="recruitfield" class="check" title="��ȹ" value="04"/><label for="">��ȹ</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="05"/><label for="">������</label><input type="checkbox" id="" name="recruitfield" class="check" title="����" value="06"/><label for="">����</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="07"/><label for="">������</label><input type="checkbox" id="" name="recruitfield" class="check" title="�繫" value="08"/><label for="">�繫</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="09"/><label for="">������</label></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���</label></th>
					          <td><%  
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("input1");
									codeParam.setName("career");
									//codeParam.setSelected(btxt); 
									out.print(CommonUtil.getCodeList(codeParam,"H02")); 
							  %></td>
						</tr>
        
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
							<td><span class="ico_calendar"><input id="calendarData1" name="recruit_start" class="text" style="width:100px;"/></span><input type="hidden"  class="in_txt"  style="width:80px" value=""/>&nbsp;&nbsp;~&nbsp;&nbsp;<span class="ico_calendar"><input id="calendarData2" name="recruit_end" class="text" style="width:100px;"/></span><input type="hidden"  class="in_txt"  style="width:80px" value=""/></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
				<!-- //Bottom ��ư���� -->
			</div>
		</div>
	</div>
	<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"42") %>